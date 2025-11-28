Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB76D116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOwid-0007Bk-Ok; Fri, 28 Nov 2025 06:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwia-0007Az-Hb
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:32:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwiX-0008JT-Su
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:32:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2981f9ce15cso19522785ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764329568; x=1764934368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auikiTq0Xwm6i2dKamn80StXz9HZ5YgBzkcvk1MmHVM=;
 b=oQu/j/gsXiJltwv/K44m6McN/1Eeq+wqjeRalysLyaBcbVsvyT8sJH4Y49b5UD2ieg
 N2JGlmy/5vaSg7mfw4jPU7LwozRhPnfC6/YmA+ly/fknK/RoHDW3OQR0O6GmYn3XeJUt
 RBUMKsCEBNCq1Kr0xumZ5ULj+BaIF1kwCqb5qPzW0PlXftrH4uHvElVZPDXMf/14ws05
 TMkjSLqAQ9ESZDY2AmLCYdlUnRjCr9yS8MEKR5nk5ak4UeEBAF0YmuG7mi16MZA1CHew
 uuWmqlUdMwV+avN30fvSBp2IqwSTGVrMjLlVH4NVkt4MO+S8ACVAAi3c8DzGCo9pjEJZ
 tQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764329568; x=1764934368;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auikiTq0Xwm6i2dKamn80StXz9HZ5YgBzkcvk1MmHVM=;
 b=ioFxg16nJHnkOy/I8kZSMXRsJNlCVwlvWi1OrgrEX3zT6ND0FKzOG8KOrEudIz0XKp
 PLWmvXSpeFlrnN9D7AniwW2Orbq444BF02j9ATpRto4x+yUSHSS3Sqkxi4VnGnYlogkW
 Gydhu69Wgba5f55YK8ICMPSli5LlgJgWUTAFbMFDno1x9gVRWLrzGvkHQzg26Op8Akq7
 Zzxyr0R8JQM2XWsafi3WPFiC2U3nyFCIuOf8EyP4eFTXVBFiqkxLzn7jUU3uPfCOEyke
 rjoyR3Dg0OnZqdQo1i98pWyKBe4GaxknWzL3V58af+oR3BVToGiqPc5UQC+mUpl0MhwU
 kbWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNObTFU3gdGM9JF/8LzIBdOnVRda4slAKWDTmt/a+mKSi9fYKxT0675srYPJ0BglI/bYMhcBwb0nvY@nongnu.org
X-Gm-Message-State: AOJu0YxHeybQdf3oojKC68VBny2a0FTLYKuB2jxwTAVaW8rygwNvQEi8
 KPN4i0NGNJYfKxHLIVJ5Q4Jh29Dv8M+vEaus/LkOi5ByYQ8eCALaJiRPaswPgA6R0vU=
X-Gm-Gg: ASbGncsdgbsldK9fFaYIjBE/atuYZumnQPt1YnJfVvm7bKVKmiK0jqA1TG8BpOERHS+
 +2836abaSxPReZ/3XBlyGCLOcxkzSGuEyFLPxRzTmvgNsw0LDvkLeqwIBg9qF9UzpUiUkxZSMrD
 lkDSu7D2GgaCeE8ze8qqS1+r1ctf0J7bV+6r58ciOdnbaDBO3P7adQugPpbRwh0YaqXze97ETXt
 XNAB8L+UJsGuXmKs1i0IAYIH0PjAMWfD6jNpEqBqHo6xlLeQICuk7rYYBQFnEUt6Lj3LTT33u41
 3VNIjpwBRApkC0kr90CQOiRLPYERtWHPqB+6Ac8c6As8ODKjMF38o3BuZbvID6lYx/m+xYGML5k
 JfJ0F3GeFg4DGnK8wByURu8iClYAv31gqYvdvtlenLNg2qVLzMVUdiCRKfdNlM+hbhmMHaatiI0
 MreEepWZiLvqfw2Vd5rxvwL3gDlw==
X-Google-Smtp-Source: AGHT+IE4dTK1HhHDOpqIiGpseP0Ja/y45Uhqrq9hjFDyWSbiitK+1wFCknVZeOcw1RmoQStgzHqsjw==
X-Received: by 2002:a17:903:2c06:b0:295:9d7f:9296 with SMTP id
 d9443c01a7336-29b6bf77f5emr311628015ad.45.1764329567843; 
 Fri, 28 Nov 2025 03:32:47 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-be508a1142esm4332414a12.19.2025.11.28.03.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 03:32:47 -0800 (PST)
Message-ID: <a50869b2-d348-42e4-abec-d47dea8587f2@ventanamicro.com>
Date: Fri, 28 Nov 2025 08:32:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: Add "debug-1.0" to specify debug
 specification v1.0
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, vivahavey@gmail.com,
 Yu-Ming Chang <yumin686@andestech.com>
References: <20251126164329.2157287-1-alvinga@andestech.com>
 <20251126164329.2157287-2-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251126164329.2157287-2-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 11/26/25 1:43 PM, Alvin Chang wrote:
> Currently RISC-V CPU has a property "debug" which is equivalent to old
> debug specification v0.13 version. Now we have ratified debug
> specification v1.0 version. To support both versions, we add "debug-1.0"
> as one of RISC-V CPU property to let user specify that debug v0.13 or
> debug v1.0 is enabled. When debug-1.0=false CPU fallbacks to default
> v0.13 version.
> 
> Note that "debug-1.0" depends on "debug" property:
> - debug=false,debug-1.0={true|false} --> debug is disabled
> - debug=true,debug-1.0=false         --> debug v0.13 is enabled
> - debug=true,debug-1.0=true          --> debug v1.0  is enabled


It is worth noticing that 'debug' is default true, so setting debug-1.0=true alone
is enough to enable debug v1.0.

If a new version becomes necessary we can add this clarification in the commit msg.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280..082035b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2637,6 +2637,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>   
>   static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    DEFINE_PROP_BOOL("debug-1.0", RISCVCPU, cfg.debug_1_00, false),
>   
>       {.name = "pmu-mask", .info = &prop_pmu_mask},
>       {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecd..402b255 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -151,6 +151,7 @@ BOOL_FIELD(ext_XVentanaCondOps)
>   BOOL_FIELD(mmu)
>   BOOL_FIELD(pmp)
>   BOOL_FIELD(debug)
> +BOOL_FIELD(debug_1_00)
>   BOOL_FIELD(misa_w)
>   
>   BOOL_FIELD(short_isa_string)


