Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9B8C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58H2-0006y3-S9; Wed, 16 Apr 2025 15:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58H1-0006xn-Ng
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:18:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Gz-0006UM-GU
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:18:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225df540edcso12737525ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831092; x=1745435892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nfxQg4xHAaqXmsuS4/iJkd3TxonAbJ+NFC1rrLcFXkg=;
 b=wcQVXFQW/5aEWb5cpJ8/6X4UG60k4wm1w2CC6xGZZVrXYKAY4WGOK9hCxWJlNi3bfI
 MNVoTB4jiV64cMTwmMTvFOxQxRrFZuSrFaHsE40evnOMC9ZWxm8N7yvl9itIvtpUzaLs
 rzjPWhQiBe92wqZ7yDsG1riqfaPRxAnvWvDnd7KH1NO0xwq0IB/gG7dEMVvyfH+VSPu0
 n4V5rHT5LwcHzruwvenYZZqXAdF4tvYcDnySY59hPCM1admYywNW5A0zugQYftm5jji3
 BzME8q9AcNAYTck2xJs6Vu+tciiaBxa9IZu/ym8DP4y5cMaS6MAMMqx9Zv4X5fzZ8jrQ
 BK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831092; x=1745435892;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nfxQg4xHAaqXmsuS4/iJkd3TxonAbJ+NFC1rrLcFXkg=;
 b=JAgHdgM6SS+MZUIq417RHwoXp4/1SdiI660IG1E0RAS7B8WGc8LiWSvg0ryPBD1NqO
 A/VExQJUEpPa6v31zXsVLMh5xXQvCBQCrbR/FU2GWu6liShzIG0E+U/KcZY5U60alS6f
 5lHschsR7SXSPX62r0eVA/e2Xw5Fj1NU8kS9DXhI1FRBIlp4p9G7i7AgNr4hqzk5qDm5
 MXD5g2pJNIeQaQtYLdBy3HZtsgemsjFbaAEsPu4OBca0kcGtfRotByMCMF3tWyeV+4R8
 Hi0kxazAZ3N/tp1oTsLCCcaXAMBlxW87MzTT6VKSZnacqrc2oPan/llD+lzJXSINZZmr
 Uuyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDhVmyDaQemZGmpGLZ0hYix/VHCYRF4tlGLJzNTkCxm62EuqQ73nhtcV+chroPKYgSmOEFMelFYbBC@nongnu.org
X-Gm-Message-State: AOJu0YwMr8FLhasUzooc5HM61oXuuh1iGSd0WXzA+5/nxlBTXLsks9t9
 uAkGXEbCSOcpOsd+VpbMYXKaFanCNX+/hwQXmwSHCOrt/6gpJlVt4vlADtrSWyE=
X-Gm-Gg: ASbGncuTqhLuodffYagIirL7vylqWXfMFwIooO4x2S4wROmle7HQclSGCsdGAIabCpd
 Ddl+q2wnmd9fgYuU+l0l/DsgxJYOJ/2DQwhEp3E4JpeOgbv6LF/TiR0wt4di7xl3DgAQQ5ptl3m
 MWHIpM/IIaA+Wtxo8l56F/Tsip4rhwzCY9Kc1tu7OfqICRotfASBIBdZKt3Ge0KLXyJdPkjC4bh
 FabJYNKygnZpOkGz6paAkwkfcLHtPVHr1Mva5T4X/hYZh9WVuT0Kt22HXIEeGi3g1hyQmuhxizG
 aXahIrJWn4yviVYcNVcWUhzb+5F/bmejNk5wtngHOPrOZ9jnp4vtkn19CiBgWDcZ
X-Google-Smtp-Source: AGHT+IFaY437U85hPxl79HFwWyBfn+atSJNDE5YIFjEDf7VN/wEvlPZQbVMQrvXnI+zOrPWC5RQxyA==
X-Received: by 2002:a17:903:90f:b0:226:194f:48ef with SMTP id
 d9443c01a7336-22c419c5b58mr1117695ad.13.1744831091913; 
 Wed, 16 Apr 2025 12:18:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef10ecsm18181235ad.50.2025.04.16.12.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:18:11 -0700 (PDT)
Message-ID: <ac2512c7-681c-4dce-a23a-8b2f1a2c451b@linaro.org>
Date: Wed, 16 Apr 2025 12:18:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 142/163] tcg/s390x: Use ADD LOGICAL WITH SIGNED
 IMMEDIATE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-143-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-143-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 2b31ea1c3e..36293d0f42 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -135,6 +135,9 @@ typedef enum S390Opcode {
>       RIEc_CLGIJ   = 0xec7d,
>       RIEc_CLIJ    = 0xec7f,
>   
> +    RIEd_ALHSIK  = 0xecda,
> +    RIEd_ALGHSIK = 0xecdb,
> +
>       RIEf_RISBG   = 0xec55,
>   
>       RIEg_LOCGHI  = 0xec46,
> @@ -682,8 +685,16 @@ static void tcg_out_insn_RI(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
>       tcg_out32(s, (op << 16) | (r1 << 20) | (i2 & 0xffff));
>   }
>   
> +static void tcg_out_insn_RIEd(TCGContext *s, S390Opcode op,
> +                              TCGReg r1, TCGReg r3, int i2)
> +{
> +    tcg_out16(s, (op & 0xff00) | (r1 << 4) | r3);
> +    tcg_out16(s, i2);
> +    tcg_out16(s, op & 0xff);
> +}
> +
>   static void tcg_out_insn_RIEg(TCGContext *s, S390Opcode op, TCGReg r1,
> -                             int i2, int m3)
> +                              int i2, int m3)
>   {
>       tcg_out16(s, (op & 0xff00) | (r1 << 4) | m3);
>       tcg_out32(s, (i2 << 16) | (op & 0xff));
> @@ -2276,6 +2287,15 @@ static void tgen_addco_rrr(TCGContext *s, TCGType type,
>   static void tgen_addco_rri(TCGContext *s, TCGType type,
>                              TCGReg a0, TCGReg a1, tcg_target_long a2)
>   {
> +    if (a2 == (int16_t)a2) {
> +        if (type == TCG_TYPE_I32) {
> +            tcg_out_insn(s, RIEd, ALHSIK, a0, a1, a2);
> +        } else {
> +            tcg_out_insn(s, RIEd, ALGHSIK, a0, a1, a2);
> +        }
> +        return;
> +    }
> +
>       tcg_out_mov(s, type, a0, a1);
>       if (type == TCG_TYPE_I32) {
>           tcg_out_insn(s, RIL, ALFI, a0, a2);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


