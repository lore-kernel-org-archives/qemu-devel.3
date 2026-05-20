Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F07CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgbX-0003C4-5W; Wed, 20 May 2026 09:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgbU-0003Bj-Rr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:04:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgbS-0008GU-Br
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:04:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso38547335e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282287; x=1779887087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d3wk9wJtngh0+WzutkjFnDffu/mtnkSJtT8sAO7G6r4=;
 b=yH8O6aXmeLaeh86WqMZTgq9eHLz19mtlIlsVVNA/LaIuWysLKL/JHamqHAuUgaDvkk
 k6bM7fgYWsbmKrXTsE2jUxZNv/m7n3wCjmsTzgYXmiFYpvZUQyNiGetNu6ZECXiNjZRi
 uq8hNYfMY9fQcYVcyxjj/EKkE+BIj77WG3nQF4gdUiG9mICAHaByL3HM9T9jMq0dpWJW
 AMuERrktxme6r+JeUymzUb4dQULJzcL3UBflV3+JTf+BF5YoVBQjhek3Rqn+l5xl3h1C
 HK/2tGne7BnVBQyvDUs1mEXxSyy4T+Y2IAnmS8p5vz2PlGFHOWrrODXxjdRzF25OHk0H
 ETOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282287; x=1779887087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d3wk9wJtngh0+WzutkjFnDffu/mtnkSJtT8sAO7G6r4=;
 b=tKMsT8nRGorOurEJxoKqb5ELTZVmjmoQBtaEFBigGaepYIOxxVaRHCcKDhCYn7rJ7t
 QSbLl/xC2Oe4YVeyJQzWQCB5l8dzt9ITmXb8x4Igs68Elo3v+J5U9emlBK8TVf0jjBZh
 osyFOCaYkwqXT8KwbmnpaTPP5nyjYNXeoUdGIx9zR28+BRqCOTq/k25d82mvoFo0UGB6
 tg/9zguAqdQAQ+zqCg6BPyzPufUMmOft3TLcH5pAOUok09EGFT+0TGg4tJvPdyevNGKx
 7+Y16iVz4A7O3t0U30Lpc/wHK34pXUA7DLEgpS1hfy5+srHXKqkOCQbe/JIX1xhg6v+Y
 7JVg==
X-Gm-Message-State: AOJu0YxfBXQiH4OGC4X11W69paNWCWVKkshyxmGjCK+do6eocfD6Z7lt
 mjuDbQ72FVYd+vYKOxQQy3LF61QsnbwoeZGRm7auW24hJ/1WvLjG6+Oje76dzjPFP3gIT9QbAou
 45Qf3grg=
X-Gm-Gg: Acq92OHW6QdBEGVIbmCBIED4xOC4Zj0rzbt3pechu/IWqxGxiGfZycB81oGW3SUWhx3
 hEjOzLrHQBYswWp9ixE+MW0RIC7Ky0MPk62BZJW8+sVbQ0asb/uNo8G3RXhi5jlYziX2xEFJ66m
 zHzPmk2x41tnI1OvgKq/p+074Y6m5SHoDpzm+oG+MwpATuikyRlJZ8aFM8zjV1cKndawjBtJcxN
 8DHwTSFY1hSy4gq4V5C9WyA2BaNO7wYeYUWL+kmCAQLC2/6jcl84qtQrbdql7ytdD1F56cHEyJY
 +IMExH39q5nrrVjogCkuN9pgGE4/e2NOqTVDRLqN2z9Hgkd334FKOEI3QIRZhPruDHaKPivNB29
 3VaSw7mYkL8aUXHJ/+9sjeLvuITrMRmdlxzlURAhqHIh0NAmBzbkJcx5iRyA/BmXv6kDMO85xHu
 LtF3O4gmW/zGvra8Fu3Fpo42ytRtRjaQuMeCbVBz8D1p8UPhXFnFqahEnMmQLEtdi2SA==
X-Received: by 2002:a05:600d:b:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-48fe60ee64amr282704125e9.12.1779282287240; 
 Wed, 20 May 2026 06:04:47 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c788sm377699595e9.12.2026.05.20.06.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:04:46 -0700 (PDT)
Message-ID: <76f05465-97a6-46e7-af04-08823a8f3f56@linaro.org>
Date: Wed, 20 May 2026 15:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/24] target/mips: add Octeon MTM instructions
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-19-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 20/5/26 12:17, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
> operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
> products. For MPL0, also set MPL[1] to zero for backward compatibility
> with Octeon2 VMULU.
> 
> Legacy single-source encodings have rt encoded as $zero, so the same
> translator path also preserves the older Octeon behavior.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  7 +++++++
>   target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 01ed3b50beb..5139543b153 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -44,6 +44,13 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
>   SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
>   SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   
> +&r2          rs rt
> +@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
> +
> +MTM0         011100 ..... ..... 00000 00000 001000 @r2
> +MTM1         011100 ..... ..... 00000 00000 001100 @r2
> +MTM2         011100 ..... ..... 00000 00000 001101 @r2

I suppose you don't use a %lane argument (like later patches) due to
the odd encoding.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


