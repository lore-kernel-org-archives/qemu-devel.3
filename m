Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE1FD41D57
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiP9-0001Ax-MW; Thu, 11 Dec 2025 10:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTiOv-0000xl-1p
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:16:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTiOs-0002UH-EO
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:16:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso2366325e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765466173; x=1766070973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYfoLmiosUhDWjsaKlOfIamPKI0njxPzpav86ZyNrZ8=;
 b=vkSN1i9QKJv9MeNdaQAevELCjdHIfeb1TdK6ZRBGJoFiJb+mMTVl6UM33OwqBiEgcV
 JhOkF/Qm42P47axKyV1OQdxS3BWSIMP9vH0wgcbwEMra0XpWWSPVMHe4RRDCZEEUV2Kl
 zPZ//BThcc7MafsYLKPpNeixYdSREdOL5pLNcQqJ2kH39suMOV0cUYo+Tvvd0jVs7lce
 S4kuevSVd8CE5i3JFhqLX5husQD0hz5UXuoF/7ept8bB6LjRgK6WErpwHqyXOEPS29++
 8FYqv+C77S4fqGG77poF0cb64fi2eIp9NX59G6Rcf7zRaFyr8dT2F2Zz6TIfdt268i3V
 izjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466173; x=1766070973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wYfoLmiosUhDWjsaKlOfIamPKI0njxPzpav86ZyNrZ8=;
 b=LC3YtDZL2MJarB8Av8p0d60vWXBl9nGnENsnlG4lh/mpE9sg+OX944uwLTEnbppTmT
 q1OQRZieR8yh8Y9Jms7kwvvw4ucBsgAfru0Hk33KygVKjFKByBQBZCVPw+xe+VovDZIl
 Vekz8ToCQnmQV7b1pce+bg/K/gI/0RRkgeJax6cEaOXbx/R88MbhoOHrV/oz48kQ1by3
 6zlBb1VCbs3UbNm2oafccVO6CYLAAfi1YctmNeHj5uAu8lHVlpD0IyH4Idaowk2DZMdr
 FxjjBR8wxeQ/liY/SpK8wi4gtZPIdUA3arv2oCuL14Pib4XL20C2+KTg3dt46KvnEnU/
 TJug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW/p4bUwE8XBN64OHDlVk2yfFQyZGfa7C2pmVhzIa81x/dPOHSGMNkqL5bL1CV1PxU5rJMGWzXLceP@nongnu.org
X-Gm-Message-State: AOJu0YxMsLUhfif/j4w1OcxylZLLZHCGfYibKL02ih88AAUci1UAGE+6
 KE9rz/MfCF88V41gXVOtVG2xq9meWS9pTgCeH5zsOLfG9pArkK0CFA56VZ2d/QFRKGI=
X-Gm-Gg: AY/fxX4yr6lxrVECjEN9yn24G9v8zutvLl7p+PrJufL3/IeuJDzzs8+cFJJkvMj7nuJ
 w4Lfpaw0/REUbGWQarWrQ7b8snkfEhKyb/cWdNl8qfJjrI/Py+gAzBXmcRdCl+rBlHHS+ZUzrWq
 UVE9uaGg2vjgksb6hraV0YxBH1WWqBqlCY6mvYw048hdlNPMuqaXdfNd33284pnlJRtrhj1U9ol
 e/j06+hKTK3kTwz2jI2T074T5WXvS+L8iNPjMhaNG+Oc85Qfsn+J2pOZEZgveaDbD4+VdJ7MTSA
 tKGTq3ml9HQF390T29xBJVJmEcXVm0MyvXIS+/cgAMhnmxL3NMzYDrbqy/s0q/hEicRtk7tOF1C
 RJt7/GLTMClkgk4mslJJ8Q/duL02lzQAHnd33qG/4M7DPwmjE4Xbp/1Rmary9KBNs6J3y+n0nnI
 +yO1kCsS72OGAkOjC4hskVuem5+VbkdVuNNOr4woIl+BiMxEl8ijgk0g==
X-Google-Smtp-Source: AGHT+IG33lH+FRexnu7FPofP3vQUkxiDxMFtXmCwkv5IYtq1cv1z4vIWAP5H1GekUgKExuEVKANAEA==
X-Received: by 2002:a05:600c:3b24:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47a8bd020d8mr19192165e9.5.1765466172653; 
 Thu, 11 Dec 2025 07:16:12 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89d04393sm41331815e9.0.2025.12.11.07.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:16:11 -0800 (PST)
Message-ID: <d18e36d7-0863-4ba5-a50d-73a05b33d8cc@linaro.org>
Date: Thu, 11 Dec 2025 16:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386: Fix const qualifier build errors with recent
 glibc
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-2-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251210181306.926334-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/12/25 19:13, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
>    ../hw/i386/x86-common.c:827:11: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    827 |     vmode = strstr(kernel_cmdline, "vga=");
>        |           ^
> 
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/i386/x86-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


