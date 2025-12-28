Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FE6E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzPl-0001GR-MN; Sun, 28 Dec 2025 17:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzPl-0001GJ-4l
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:39:05 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzPj-0000nN-OP
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:39:04 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-787eb2d8663so107949747b3.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961543; x=1767566343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZCHw6sDKrkyUurBRSqT4XQRWGfMTKwrPdg25zJoiRw4=;
 b=Km1KytFfcCpvEvLQofLWdKY+r6ey/dpKr397Hp1ypD/IAMo4dad0CQWXkHIZh6YlHs
 EW9LhkH27km78PHKPsj6dRwzhb1DKfXemxmEBrfjCqUaO5QSGeyE4qlWbpDxHN15PFcw
 4ZHtl5TOFrYiqRtA0CD+LpymPcjYgyKQubP+7/gBGdX7nQqb5WL6pynBMOHkSv0e3hYv
 x6altgXQ9zUUHSDI9uRg+KuVnJ7s52ZjRlfbvyhfKWD5IWhf0K0eBJtgfIrNWdaWalJ9
 xq1y+Rje5fJ2XjLJn1gjayWOFeM6ibiKeGK34nj0zeg0ATIaxX2CgzzZBIvAIrQBKutB
 QmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961543; x=1767566343;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZCHw6sDKrkyUurBRSqT4XQRWGfMTKwrPdg25zJoiRw4=;
 b=qEpT5cy3ONsrmrHlX6gSImORYGQyjz9bzE57/y6VVXZj4DRgCDC9I6CB+TrZZ2nGaS
 97UhPiOBkXCR/3Ad0XIQadIylci1U4ialjxGCRdfTHke1FejlFZiBTRaC5ky5perFBxJ
 9NMan+8lMTXloBaxdDXCHctqcHJK0msX5o9U3c/kusRrieaKKIxdZZ81v/1juESMNEKT
 BixhvZBGJtaiC/wJtOsKnBCCNAJ7QnhSrA7UStvg0SGUkRYtghYS3/z7l2e0G7TDZJPb
 ho2MH9c6QuSJJIe/89LOSgBIMAiCdqKaAiZVcRAHndlahSp8TZBh93gtzWzE+WPc6Gn5
 UKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtfM0b9HQOCgjDwu3dHmsOUiSUDofVlBwsd6+z9tIt7KJyCkXcNVXTiXTvHbqTPQacooyOuDyyL0fe@nongnu.org
X-Gm-Message-State: AOJu0YwMxAjG9tktuOYV60c7UuASFyBiDyrQv+GnUwFunKsLE4eIsZMy
 JwASHYzGru1M7kYkDWSyHqhUQpqCk8DnVIGxHTgz+lIIyn8+K8TaJahyHCu9Y8BveDE=
X-Gm-Gg: AY/fxX6zdYsYT81mJnTb3Q0rOGVjXtxF6dE6iZlH3gC9Mzk7BFuPXb9rWEzu2u+Ykq1
 1QDErQf2P8N6V7WnJRnvdN912T9wtmITvorgbzbLb7AEcnnp7lMjBMHYOviZFP7KKk1i6YzBGC9
 XklSodqpGBuFxtQTN20xGcIQ5zYBD/+m6MZqofWcfOppGtx0lOrRZtR1Bz1Y4pfYkkYq1BWg0LN
 LZqn5okp2OLhPvheQ9t+ViqwlPWKWCMCrDYY8AO72oMkUCaX/e2cT0iwyykSRziyYJznC6BYYWg
 XcwkLLoXZVB4lvtzQ9Kn4F77ntZmuJTjvZi/AwEyoGO/+a+yIUELuevEyCTSkArTRnpobNLQWuS
 gfZEHRw7mN47YuMLKSObfRJCncbSYQ8fEMDDqqjWP+DobjJ00Qtb355xd+1TramblBb95Icupv0
 x7s+qb+bDCJGcvDGdlP8u4lWccYSNIjmWkP79IzTiPOB9M+Kg+kTomDHnjNdomdTY=
X-Google-Smtp-Source: AGHT+IFgiryQpyj5NYQeA+y9KNyGhiLTj8pBRESziRzJlbur51hyEvLs3tq09l5FU92y/xKiHJlKhA==
X-Received: by 2002:a05:690c:6a0b:b0:78f:8fab:be63 with SMTP id
 00721157ae682-78fa5a5f2b2mr269810637b3.6.1766961542548; 
 Sun, 28 Dec 2025 14:39:02 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb456bb29sm108772367b3.56.2025.12.28.14.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:39:02 -0800 (PST)
Message-ID: <0e2a2854-2562-4e60-903a-66b0c73f933c@linaro.org>
Date: Mon, 29 Dec 2025 09:38:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] system/memory: Introduce LD/ST helpers with @m suffix
 (for MemOp)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
References: <20251218212814.61445-1-philmd@linaro.org>
 <20251218212814.61445-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218212814.61445-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:28, Philippe Mathieu-Daudé wrote:
> Introduce load/store helpers taking a MemOp argument (which can
> include size and endianness). Use the -m suffix to differentiate
> with others.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/loads-stores.rst                  | 10 ++++---
>   include/exec/memory_ldst_cached.h.inc        | 30 ++++++++++++++++++++
>   include/system/memory_ldst_endian.h.inc      |  4 +++
>   include/system/memory_ldst_phys_endian.h.inc | 10 +++++++
>   4 files changed, 50 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

