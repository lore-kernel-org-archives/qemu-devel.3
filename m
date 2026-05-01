Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBBCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkK7-0000xe-Er; Fri, 01 May 2026 05:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkK6-0000xL-79
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:38:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkK4-0003R4-Jy
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:38:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f8892d4d6so826148b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777628291; x=1778233091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTc/gmbB6KSXb+l4ZU7rlAdbwcTLzpV4FDGiNz+eZc0=;
 b=imMf8Yc5NKswWWDRMemXtct4ci6XRiGx/ylaPJHmflVBjOflNWz5DSRg2AlbmlXn2H
 fKfOKh7742JVCC7O1WapiBYcigroIC89iPFkM1LptFeTGQSFNhcniqS3oEwT9HtsRUTp
 bT+uvOLGSXRvaT4UUcpL/Gu6589dmXIHt5Dfj9EI0yaClPLx/rjYrWETce0QjlIb2aJv
 saVv9HbrK12QZnO/H54YyFqNmueisFX2qlbD31BNTmIJmSb71VhJaTTE2VThpq8y+hUw
 EaDE/eyrUN5tQXgoW+tXomySHKxBg3JT9XJu0ZWtvp/3rGCcJPDOJkCGI0/rk2A5VlEv
 H8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777628291; x=1778233091;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTc/gmbB6KSXb+l4ZU7rlAdbwcTLzpV4FDGiNz+eZc0=;
 b=C8P7EZQojC+PQgB358iX5Vl35dq0/Qid7XR371Ma2zSFDppJbvVfK3o7BdjtBDRDPQ
 ujPKoLIouPhfZjD9DFDifoZx1igcQy1+tGGEEooEsflgd6dcR/0fAaNILyR3oKRAtwEk
 Wd58mp988b9MQZsyFm/7g3Ptba2d9p29Y8HlvUI2z7VDhlGhP82WAEmUemH1UanyKjUU
 pfIpkYxAiBsGHx9IsyoMy8VZlBg8r+VEjr5X3Nb9mz32BTZVR4ZahbxnujLl9bAnSCGK
 ytbDS5SgBq9Cz+JSWZMESpTFMSj8AwuP4QXAZbpc8zS8xKI3oDN9ClMf5SOCWblidjfs
 XN1w==
X-Gm-Message-State: AOJu0YxjnQSe5ymcnRX8uOSUxyUZ7LocCMWeWYZx/Mfon62iLWhZmQ05
 Wkw8QWySFXDk6SS9DXS2nHhYZ8WvkanIFeBJyoUm49DSZp7lsfTxxxB1hTmUjkz4X++kdq3Ljkc
 yxsw86hI=
X-Gm-Gg: AeBDieuyofcB7HKMGjp/4WbbKQc9Tc0YJ+MoHpOPZ+4Cha/PmQ6NDUWt5tJIciUhu3A
 fHiJZu3rRwHyyuWKr30O9J4B2UNti+TAE/MxzP9LDDIJ/3nQKuQe6UjcipY86PXNJp/YWVDHKQR
 YY1cKICtQCtRsvoJRFVeqXIOd8etzpWSruY/yyQAPjImBlbr4Fjx/Dol8szJLdjYeq8QeyutCZ4
 Ftnd5BsbdnBL+wvaQUL5E9GJdK2CWwgZS0Rt1KoBFdnI0M7BwT6xG5wIBynJmWK6GBJBtjFS662
 l8lu9l2pWSoP0VlVoaIe6UA/6u+Ct4V3olE153wa/AZPBHb3lURM+z23jymPh+tU08+zGh6teRJ
 +8t/CBZpbKWkxLJmqdkKo3Hvoq305XGarXcN3ZTJOjIFU8kLyCc/45NAKPXFguFA59DmYz925r+
 9GK9ChL8X4irIAXDSuKOsbIXgpRcWG5+uoP5bl/TBICBkxbIMvtEUc
X-Received: by 2002:a05:6a00:aa04:b0:824:3bd9:aac6 with SMTP id
 d2e1a72fcca58-834fdb5c84amr7310673b3a.16.1777628290896; 
 Fri, 01 May 2026 02:38:10 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b864c7sm2356574b3a.59.2026.05.01.02.38.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:38:10 -0700 (PDT)
Message-ID: <cd8456aa-f356-4b91-9a23-2f37e34d9c99@linaro.org>
Date: Fri, 1 May 2026 19:38:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] target/arm: handle the WFE trap case
To: qemu-devel@nongnu.org
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
 <20260430104434.1482407-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430104434.1482407-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/26 20:44, Alex Bennée wrote:
> Now WFE can actually suspend on A-profile we also need to handle when
> its trapped. To do this we need to pass the instruction size so we can
> deal with the is_16bit syndrome encoding.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/tcg/helper-defs.h   |  2 +-
>   target/arm/tcg/op_helper.c     | 15 ++++++++++++++-
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     |  2 +-
>   4 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

