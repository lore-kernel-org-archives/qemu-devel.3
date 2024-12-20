Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C0E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaVz-0002ZK-Fl; Fri, 20 Dec 2024 05:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaVC-0001pN-R3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:45:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaVA-0005sq-05
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:45:01 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso12047025e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734691498; x=1735296298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ByA+t6wtE4y6Ap+K/de248nOE77Dr9SDbhFGzaHg81Q=;
 b=w5WSWvZFe3W/eqcx8aS5ZTSsidhPmgEIEawEwtpSG1j/+ps0i+tGpPh/NznfVCypQx
 0H7GM54yuxf3K7qiF2Q/ySqSp/0XgCXg3gf67GXDo8kMmTPcqFvAwb0pM6wPE243Xj63
 2epyoBbGizOpkBd7fJ+PEJ3rm+DEQEeJl4jcJ9MJcU2F0WmatFwcIJswCrUqJPXhEdqJ
 on6EuyMwSPyt+m+60YZrDsEO+7mnADU531da0bqvteW56/NjVjyejqvXicpQ9JT552iN
 zd6bBia3JAiX05vyyJY/syem+Ld01mLy3hMaG59XfooIO6IITmUEMeXSH/ES2vPg2yvm
 JoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691498; x=1735296298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ByA+t6wtE4y6Ap+K/de248nOE77Dr9SDbhFGzaHg81Q=;
 b=tI94iiufQ1Doo3KvOtOAPh62fJuHUdBe9GuYAxo/R+c02/mgD79uRsTxvoC/OYNpX7
 v2NIP9E1Gw2dGTb5U1i6DdCme3CTQk6BAP0aP8ZViwpxvEfltxyWC6TkfoguiJ9Ec1Jk
 cvDlE8RE57/ZDwWAGhuGEJoWme6B1b/w0i9I5cW70KbTp+cu52nbvCnln2nQJT8HO88C
 NLvl0RBkpnlRbFVQRVI3STRB59YgnzOiS/51sU4DLXLygOnt/dqrUHFC/g1/ykPfuhgM
 OrJ1zOxLz2c3MMjFtrqehRBhppPE2KnlMX017jD0u0svlOQUs9l0MmBwOW7vRWcArC8o
 KDzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp7C8sHOLZKpiSYuJKOsXhS6emcRZNKATLQ39vPonXZvhhIz5ZK/LEJsvB+RZ9RcW+r4SYpOLWGFcp@nongnu.org
X-Gm-Message-State: AOJu0Yx/yXy8ool5TBg45N46It4MNenzsqea3CEj4z5lFw/nY+Vpr3Qy
 /Au+Xj6rVztyyVfTR5PElWjXqG0STgfGjLaYtX5VIoWBQ6q63hyFzyglzljr7HLLQiEdAUP6JpJ
 x
X-Gm-Gg: ASbGncszCeONQ3UmrCBbpyg91rCBaHZtKukQ5Tq+19be02wm5QcX+m57uQqeEV8r7jn
 hYqrhR2lzFX0ryoYpoY3fG3RLDduRReY5UNz8Kbq/u4iDF6o+imHhLUxUzk0Gkfkgb9la5Bw+kQ
 Wcmv0z3z/hlUaQU2Yq4ValVJlPr0Y0ISzDbPy8csHTFRef8D1gO0mMeYd2mSNTbY+u3COZyL9uf
 O0LYpvCK6P9dEuhgo7gnI8b0w52ue7LmrmLbg9zBvQcE5Vfox7Ev1VoNAOFlnkdE4vFGug=
X-Google-Smtp-Source: AGHT+IE7vZWRIu7DvYZp4jGhqSTpTz7yExQx0NnDiNKNqGKCUGGMBNMpV047c+uq71/EeXAfij6psQ==
X-Received: by 2002:a05:600c:1c0b:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-43668646750mr21065475e9.18.1734691498179; 
 Fri, 20 Dec 2024 02:44:58 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b1f6sm77453515e9.31.2024.12.20.02.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:44:57 -0800 (PST)
Message-ID: <07199b31-d791-48f1-b5f9-021cee8e2101@linaro.org>
Date: Fri, 20 Dec 2024 11:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm_sysctl: fix extraxting 31th bit of val
To: Anastasia Belova <abelova@astralinux.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20241220103320.83385-1-abelova@astralinux.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220103320.83385-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 20/12/24 11:33, Anastasia Belova wrote:
> 1 << 31 is casted to uint64_t while bitwise and with val.
> So this value may become 0xffffffff80000000 but only
> 31th "start" bit is required.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   hw/misc/arm_sysctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 69e379fa10..ce8be44b6e 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -520,7 +520,7 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
>            * as zero.
>            */
>           s->sys_cfgctrl = val & ~((3 << 18) | (1 << 31));
> -        if (val & (1 << 31)) {
> +        if (val & (1ULL << 31)) {

Alternatively clearer using the bitfield extract() API ...:

            if (extract64(val, 31, 1)) {

>               /* Start bit set -- actually do something */
>               unsigned int dcc = extract32(s->sys_cfgctrl, 26, 4);
>               unsigned int function = extract32(s->sys_cfgctrl, 20, 6);

... which we already use in this file   ^^^^^^^.

