Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F02107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w185t-0003B7-0C; Fri, 13 Mar 2026 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w185r-0003Ao-Ir
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:22:43 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w185q-0002Up-6G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:22:43 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-899f27df3d1so24840946d6.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1773429761; x=1774034561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UsP2ccNpDKs+021Yg5+OHqyUhLDRr6Zfap6mI09W524=;
 b=TTYrJ27xhfmvTinoYtOpPL8XIDBCCW+bmBfnw+o0oBLlFDFfNWTS3+euVItp0LeEqT
 OfK4s2gnhOD1jd+Fplhedop75cpeaCe1Z3iMynZ33VloeSae3Nm/adyIsNzm9UV8Yg31
 iRldBXlLtiFOG2pV31jHSUTiDFSCjcvfmZoKDQoDvHmf9C3o0Wb4Lc7oGxD1btXC6dVd
 aI38Ok73Ge64QPfTlyCxh0mdD0fN6QnK94A0egsq0UAaCCmzhb7xaxBfui0BZdwsvGpk
 2Oa0gOXkuveIJoyLYez85BHr6CjB/OdSf6Tc9HaMUmQOAyEapBDs8UttO0GckmKYmGfC
 zq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773429761; x=1774034561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UsP2ccNpDKs+021Yg5+OHqyUhLDRr6Zfap6mI09W524=;
 b=b/UF/R5vjh9lEDRNgQoh9yOFFl35Zpopg1hoKNXoPBt0Sa+Vjm/C0d+fyGuRFnOex4
 I4V2nLDODKqpuP8bcV/gejFn+6h7lgTJIlhl82uxMNc9bG9JTYR8NV2xxhTR13/21QRE
 h4LPMujlze0GSw5np1Uxz7ldx8zoKW0eDDjX7kvw5oElOn3SDNE5xQuHBQRu3PiAJKEp
 aFa0f6RXtDATaojZIM4uxE7HZzCa3o9bxmwX+Y53+Dn6/9lzNl+3jHZapKRVGbnlIGAP
 uwBJvealL8Qo8jrcWwa6mcfh0rOhK1JSPPS2tAaawMK79c36V9zpLMa49Hm5JZfVvbct
 6/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4RbaZxVzaSoXvXUvlzRDwUFGVn4jkwQuXMLKo9ml56r3wqayFfoRNEp0vR7Db1oPm2e3TaA4SzZEm@nongnu.org
X-Gm-Message-State: AOJu0YzK3bWnBip8G26ymV4S9Dh97XRqUTizMe+VA94mNkSKPvSUOMik
 6s6tn/qWNdLpEfXomEC7fm1BvEBfN8bQGvtjquLcSkjn90JlXOVpYfijynwGmAw0/f4=
X-Gm-Gg: ATEYQzzLYf1m787APlCBKKez+V5UtYpN/bXmpoXf5GOx7/TMgfOyagV72mCY2QIHBkh
 BylKy9UgmWjIcuVLESLaqhE2/6ijBm2275Ruq/hu1b07EohjVTLT30hGZCUcw/vfaLmRcaF5ae2
 4Lxu9l4qfOPMD3kXYwNANYMexTxoArbm1nybdydAcbyOXBoV+cazUcwbjLUJMlb9Zc/SzJKqPPo
 YwC/g1LofP3/GqP+hTWEa1Us7qtQuiCXRnovRxYy6mzfhhj5Aoh/OC9i0O/pjnAFI1cPXvG3LPy
 ENK7NxY+hlf4aE9HRREKUY+NL8BqbJfAAQEwYpzmdHHnJrJUYu0k+7T3GM88VRXo98xTnR58+9S
 SYpI5EZpYDy6ejMK6l3GVig9YWRnxt7fhW4htujJE+6An7+wGrcqCBFs08pmRkaz9ozg1nXI69C
 tPEWhlpbXHgsOxpsgN/FRdEBhMA80AhNRfjQLV5wkg7uxVRuN2vmPcwV1ZQrEeq/8=
X-Received: by 2002:a05:6214:2a4e:b0:89a:aeb:11 with SMTP id
 6a1803df08f44-89a81d32194mr70527536d6.23.1773429760974; 
 Fri, 13 Mar 2026 12:22:40 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.163])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65cfcd3asm73957356d6.38.2026.03.13.12.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 12:22:40 -0700 (PDT)
Message-ID: <2ab330b3-6bca-45bd-bb1d-6e5a91ea5099@ventanamicro.com>
Date: Fri, 13 Mar 2026 16:22:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hw/riscv: Free resources allocated at
 riscv_iommu_instance_init
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-5-farosas@suse.de>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260313182957.28432-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf31.google.com
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



On 3/13/2026 3:29 PM, Fabiano Rosas wrote:
> Add a riscv_iommu_instance_finalize() routine and move there the unref
> of the iot_cache and ctx_cache hash tables from riscv_iommu_unrealize.
> 
> Also start freeing the register state masks, also allocated at the
> _init function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 98345b1280..a9cd891039 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2446,6 +2446,18 @@ void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode)
>       s->cap = set_field(s->cap, RISCV_IOMMU_CAP_IGS, mode);
>   }
>   
> +static void riscv_iommu_instance_finalize(Object *obj)
> +{
> +    RISCVIOMMUState *s = RISCV_IOMMU(obj);
> +
> +    g_hash_table_unref(s->iot_cache);
> +    g_hash_table_unref(s->ctx_cache);
> +
> +    g_free(s->regs_rw);
> +    g_free(s->regs_ro);
> +    g_free(s->regs_wc);
> +}
> +
>   static void riscv_iommu_instance_init(Object *obj)
>   {
>       RISCVIOMMUState *s = RISCV_IOMMU(obj);
> @@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>   {
>       RISCVIOMMUState *s = RISCV_IOMMU(dev);
>   
> -    g_hash_table_unref(s->iot_cache);
> -    g_hash_table_unref(s->ctx_cache);
> -
>       if (s->cap & RISCV_IOMMU_CAP_HPM) {
>           g_hash_table_unref(s->hpm_event_ctr_map);
>           timer_free(s->hpm_timer);
> @@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info = {
>       .parent = TYPE_DEVICE,
>       .instance_size = sizeof(RISCVIOMMUState),
>       .instance_init = riscv_iommu_instance_init,
> +    .instance_finalize = riscv_iommu_instance_finalize,
>       .class_init = riscv_iommu_class_init,
>   };
>   


