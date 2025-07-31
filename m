Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8644CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbFr-0005eB-M6; Thu, 31 Jul 2025 17:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb6S-00060K-4Z
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb6Q-0002GC-Li
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2406fe901c4so7207165ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998377; x=1754603177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L20gtbO69FEL8GHHm+JwrZ6x7+xpexWv/k6tY6puT54=;
 b=qyRY8CVEEhPyKjubck20Wne2i3509amoPpZMiEyLiC37kBIBpyqrVqOxx7cFGy6/BA
 ul5fCRThWW5ZYPwH0kSd4y0eM3lz2LqxyIKflrs0n5smtWgC46YfkoZ1LNrc/ZLkyvU9
 BptQ8ajFYKQflO7B8uU2FoEVT+ISOw+X/4AC4h8Az4DDaVmKsaEKml197g8P/vylqtkb
 J1OeP2OGFuYKOZDirZgY6a1X1S49YPQgeCah72EdeEVx4Vg5Pk1Kxs1tieYC1jKTP7aP
 aIZGfoNqho04v7h+yhl571EQdZUaxn5MGVQM4rDGDj3F8HrcSlw4c/DtGCR1wYhtvxO0
 NBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998377; x=1754603177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L20gtbO69FEL8GHHm+JwrZ6x7+xpexWv/k6tY6puT54=;
 b=p4Y2PIJO/jyQjZWVVASjJJlK6cVXrJwmxNwSzgkmfoZY2QWP/0QjNdxmAavlWoseSN
 acNmBs/wP/5ulZQMf7MEsLygFZeyhwG1cnsdlQbQLYTi66r5DNsr575+IlJktkm8z3jY
 r6ziWoKhUVAEouO/pMy5pq1Bc5zjvFTczsNX7Mn3L6s6UtlZKJiLRwZFOerhagm2fsB4
 o27tam+XZ4FsABrurD6l4llkWeBEWcBJrFcK98Cw2vYdl8DXgYcjkh0gOwQK9svVVfan
 +RZn1yc/yWHxsPlLg5t8PeCnKdaVcWIc1lFuaAKwnWvCERoyN4gNq2QXriXI2M4O91lB
 o7qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWovpY8Ag25sroahluiuiBAdMdcZnS61dLjEqOXXkvYyOCTrV3nfRxrGcTbRsRgandeXZs62F30OPsr@nongnu.org
X-Gm-Message-State: AOJu0YyPWY1Qc6frHDpfg6pALNyOslQHeb4uRKCcsDCs2UwbU1eMvlt9
 oXCLZpKn/tFr7l8oTInrdAFSzYtglbtJcPXyiIeRwMV8cuwMf0bCUgsDgjqv2/zgMo8OJ3v2194
 Bva0L
X-Gm-Gg: ASbGncuDTjm2NXfa6w58KyYfZTxFSG8Ndjg8/90aRpcUe8e2izSeJ2xIEnCUqKRmfPu
 1oysWdGO1KPUCH6eFrRLuoOPKWjGGd/sl5bFKUtywv8+SCieverbXWstpyJKu5UN8x6nIKVftIU
 hvDvh0T130Pir0D/j5zZEwrrxWVgvv2TekmcN4GzOt6rEX4ViE7pQ5FDmuUobf+944b7FUvzp7y
 xPFNTKbcv4Lej4knV/4iLtFyoKjERFbvley+wymH9NNRwq5HXrMfockL9MDxYkhvu28pw+4GrPG
 S3n0dMru+a9sS6qHe+Gn948sxJVyKM705EItS36m6Ykk0tfbGIgac4kBu0NXO3p6j4m3zhI/7Xt
 ViTrguyWt5oge8hcpQDzsPxe6/CafVmBPgUdS27r36oZyPsmv4CQTcc0m
X-Google-Smtp-Source: AGHT+IHGlZVu4QLwBRztOPzEppLDplZFrHYt/bv3vd1jqNNCX0ZAfxmhzTcts7cezqQmyYwMaBOetg==
X-Received: by 2002:a17:902:db03:b0:23f:ecc1:ed6f with SMTP id
 d9443c01a7336-2422a449b0amr3010905ad.17.1753998377251; 
 Thu, 31 Jul 2025 14:46:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a1csm26600675ad.78.2025.07.31.14.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:46:16 -0700 (PDT)
Message-ID: <d9abc67d-f7bc-407d-ad69-4374b7040783@linaro.org>
Date: Thu, 31 Jul 2025 14:46:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 64/82] target/arm: Add gcs record for BLR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-65-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


