Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B7AE9D826
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XTw-00057i-K4; Sun, 05 Apr 2026 20:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XTv-00057M-1R
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:06:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XTt-0007tE-CW
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:06:18 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so13793155ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775433976; x=1776038776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rg1dy0vao+3A5fRXWEmZe6MQz/O1kdvrZKZKOIdGT4c=;
 b=xuYPT1LF7t1Ot5zNIhge3F1we+aHgdLhZXsm6Eyxg1skmTelk3LEQdTFRbT6GJng5L
 zxpG4FopMi+k8RmdLC4xDE8h08c/fth8jvcCdylJJkSYvVDHLOjKpVg1cqh74G96hfQ0
 j3sINgF23cV6Uyq8wWX1yh/A8iJ+y9Kd396+EkKJhcBr0JFP11S0dSRFfkQqjOlQXGkH
 Qd76hmYfXDxmYuEDyASMZB3kpaxKoZE+NYuUzvrCD6aGAi5/Tb0vKdqW6I5V2TPkm3Qs
 GaJQTQea5x8FuFmZtk3CPcocSX2CX11eiR0yo7cW8V/S3XVLFPdHFAfPhZpdEOaunImd
 7+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775433976; x=1776038776;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rg1dy0vao+3A5fRXWEmZe6MQz/O1kdvrZKZKOIdGT4c=;
 b=nrXL0EVvDsGF39JMBICcYT4fG3X0fTKjCoFKFabuyG3SMzxyIUd0uPIpMrNstSsz1l
 kAYKNIy/XJVGNvs4VMtalx0bstBANImva0tE1Wo4N/iKeNpKTTeKNFDAprg16LuRlbOb
 5gQmncJs+uZ9Jpj9QJ2BUpou7nVsOzR3wyRjQVSpk7/QwOfUKSPuCdVQpkn6hUgMHusr
 j1u0SOTUhy3VmBqg/3ckmT6iho8zzZ6gSTOgWsUyDOXf7nUTgUpvGlIGzTy8Xg2PNi7y
 dF3k3UK+l6c3kscKMMZlBMc2+K3Zarb+hUaKIvbtsJ8hLCh/aIZXFWCNlcEAXxEmWwhW
 YKcw==
X-Gm-Message-State: AOJu0YyjjejkD47Na3xN4NYuocI55NlYJw/tUgL0Ncx80E9Sl3JLmGBU
 aHrxIVsekMW+miioMeNVE9h2u3SUyk7r+2GSXkqcgpvoi+mOQMUbTzLXXBsC47Egtvs7AxD3Gdo
 N5swO
X-Gm-Gg: AeBDieud2CMZeggZdfZzEkJoz51dBrMfqYzhD2JGysgwhqH5ye0HUlYrUwd6WKtSAQr
 1UMEZkHVpGOzEgPxc1PyOZSjU7BWMpmN1ZPmMH3hYTPptCn+O87b769R4a4IqYGq8mpihfuaGCs
 YYw3AV9QcmpJSk5mpCt9Ndbi5Ghn6BNzRWsBI0xVu5L7Uo3XGBV1bCHuQRFsTqb1yHs25ozjHDA
 osOq/viDR6wwLydGBQuaZ3jrVegDAbzKaD/ZZbdRc3G3+Wixleo80TP4EA/rd8A4F3DIuH3pIBO
 5a30bYrHJldppBBGz4SkR2hG/8UuPi1qXTsk7az61nbkHSB6waFLgQsufnY4DQCe0/LqXHO1AsW
 mkJTJFNP3zu4mBORYUxgXPi04qhoyeQDF2hVs6RGSXZ7U2TkoPhkPIH8ENFfDJtgJHJwWyFlMi5
 EZ5feGS+qFROsnXHDSzbmkX45Ow18eIuqOT978I8ELrdu9XZ/wANffwF0C/CnAzSjdpSU=
X-Received: by 2002:a17:902:e74d:b0:2b0:5e63:fc45 with SMTP id
 d9443c01a7336-2b28152fc03mr113216665ad.0.1775433975547; 
 Sun, 05 Apr 2026 17:06:15 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274779b48sm160400285ad.25.2026.04.05.17.06.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:06:14 -0700 (PDT)
Message-ID: <94d1f4aa-88be-48cf-ac35-a8cae70e889d@linaro.org>
Date: Mon, 6 Apr 2026 10:06:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/35] target/arm: use syndrome helpers in
 arm_cpu_do_interrupt_aarch32_hyp
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> One more step towards dropping the old #defines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7389f2988c4..5ee79f7564f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8898,9 +8898,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
>                */
>               if (cs->exception_index == EXCP_PREFETCH_ABORT ||
>                   (cs->exception_index == EXCP_DATA_ABORT &&
> -                 !(env->exception.syndrome & ARM_EL_ISV)) ||
> +                 !(FIELD_EX32(env->exception.syndrome, SYNDROME, IL))) ||

Unnecessary () around FIELD_EX32.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>                   syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
> -                env->exception.syndrome &= ~ARM_EL_IL;
> +                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
>               }
>           }
>           env->cp15.esr_el[2] = env->exception.syndrome;


