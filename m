Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0ACCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 23:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIxv3-0005Aj-Ds; Tue, 11 Nov 2025 18:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxv2-0005AG-5E
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:37:00 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxv0-0007XA-FM
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:36:59 -0500
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-9486d008fdbso8692239f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762904217; x=1763509017; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RUpldihiRbLRoEl33gL7gMiTG9wTkgipOEM6Jz9Tr9U=;
 b=NYrE2aS+bzFoCqwn2PSP9K2G9sM5cEqulwXn8DK+75zlftxiGa+G1dUCagkvQqQbTU
 HtUMo+zKcylC9Rg+1U9C1Xz/+xtobbdP7fQQgJLp3ZnqEgz1beIrBHVkr5ApVAOIYwRl
 WsHFWVKq+rk8mcvCTiWl/sO00A7KmkzBBh2uFT0NIxAN2hVI2LleQdlbPaoIyCrBHDPr
 DBd4EIfHXiO/cfOoFpRZkpJfo2OngtsM8zY466ztLgG5TjiYdynLMOSTNRwpovpcJzSi
 gerkvUJVvnfWbQU/izUDUYmJssHTBccSMUoZuYnNlb4CRtFMMlCBNYJ8VrtylMGIgynL
 lGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762904217; x=1763509017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUpldihiRbLRoEl33gL7gMiTG9wTkgipOEM6Jz9Tr9U=;
 b=j+6BjKN8w2VPT1NelugjfylhpyJqMIibFqJXVqX4ymfcnutpj9vx8Tr7rDF34SUpc3
 A2TnQ2dtjpp9stRrXpDDTsvbbsAcf9XZMuovsc7F7OFYS+gxjYeoBhHQA8FhO+epQNij
 vOZhuthfoW0Xx4sVqCW3d+mqdD57nhMp7d/hyeZpkoD3FioAlSdpnzbWqwhfULV6mlwf
 3R+c2Y6wPHMdUlYPrtB7tV48EvK1C0Pqcub5HveUzLc0Agpcm7Tv5p7hX8pj6c2T44W2
 TMWHUtmI1cq+qc33Itf8gZRjs2hqVCJvGG2+EzXvPP7Nar6WZYWemqMRSxEvhIa886Iz
 5RIw==
X-Gm-Message-State: AOJu0Yxx7WOeNRkK5WBX8Xcaj8iGX5gGMwakoWqB5UqZEh9+4LjqONlN
 3/6tTutxUour6DnzvEnifDSPoWW2isBof7HIvbxXJDqkTH5PahvtmtmQcgTH+Uufmio=
X-Gm-Gg: ASbGncv4PpS/xLqMN1taqBNLhpciH2WZ5hr0yqOvgo3dOV261+S/bBnYKwkB0H6lzvh
 ssRklIFCOSM0Zr3cV/YWnxaDgtMcdmAn0+TgzhejRKx1nLUiIEa6CHsh5xwhnadp3rIcMlHxWnz
 RoQhLRH8kt/k7agmLgvi8NBW0cNukKnfOtjNx/GM96o5T4tz385tROnV3cwnpqyH/9z9jEWb94l
 +vsBSZeEBjVT1qBLhJJ4LiPF799SdqZ8MSvtmBEXAYxoAhaq5/sep9s2cjBvhBhqEeOFnRtRC7G
 OvrsDew0Q5jdM5UtaI7mtya2c49x4EPg1F0AwPi8GkL5PKQyRDSjd6isN4Wej0nLUCqh3n1l+R3
 xgcO295g7USguUyxNnjQkIu/tQIIoXFr3Hcpi0ETl5V0yqId0Fjr6jT8zlGQyp94SK2EV19HiKM
 kVqQ==
X-Google-Smtp-Source: AGHT+IFAJ+pTl/Pcsj19aqB4cbnGnAMjW31h2Ug8XTHtTMK20vBpde88FeSRMVZOcULk3YaVEC0GsA==
X-Received: by 2002:a5d:974a:0:b0:948:7c53:2d67 with SMTP id
 ca18e2360f4ac-948b47d75dfmr540800539f.2.1762904216716; 
 Tue, 11 Nov 2025 15:36:56 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7ab14f4c5sm376706173.63.2025.11.11.15.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 15:36:56 -0800 (PST)
Date: Tue, 11 Nov 2025 17:36:55 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
Message-ID: <20251111-a6e8ae9a0d6809ba0e62ba2e@orel>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 11, 2025 at 03:29:42PM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
...
> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
> +{
> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
> +    char val[32];
> +
> +    sprintf(val, "%d", s->aia_guests);
> +    return g_strdup(val);
> +}
> +
> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error **errp)
> +{
> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
> +
> +    s->aia_guests = atoi(val);
> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {

The minimum is 5 for the server platform, so we should enforce that. Also
I suggest we bump RVSP_IRQCHIP_MAX_GUESTS since it's only 7 right now.

> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
> +                          RVSP_IRQCHIP_MAX_GUESTS);
> +    }
> +}
> +
> +static void rvsp_ref_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    char str[128];
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_RVSP_REF,
> +    };
> +
> +    mc->desc = "RISC-V Server SoC Reference board (EXPERIMENTAL)";

We could (and probably should) version this machine type from the get go.
If we do that, then we could simply give it a version 0.9, which would
match the current spec. When the spec is ratified and this model is
complete, then it can be bumped to 1.0. Going that route would allow us
to avoid the EXPERIMENTAL "flag".

> +    mc->init = rvsp_ref_machine_init;
> +    mc->max_cpus = RVSP_CPUS_MAX;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->pci_allow_0_address = true;
> +    mc->default_nic = "e1000e";
> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
> +    mc->numa_mem_supported = true;
> +    /* platform instead of architectural choice */
> +    mc->cpu_cluster_has_numa_boundary = true;
> +    mc->default_ram_id = "riscv_rvsp_ref_board.ram";
> +
> +    object_class_property_add_str(oc, "aia-guests",
> +                                  rvsp_ref_get_aia_guests,
> +                                  rvsp_ref_set_aia_guests);
> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUESTS);

Same comment about the guest file range as above (we shouldn't suggest
anything less than 5).

> +    object_class_property_set_description(oc, "aia-guests", str);
> +}
> +
> +static const TypeInfo rvsp_ref_typeinfo = {
> +    .name       = TYPE_RVSP_REF_MACHINE,
> +    .parent     = TYPE_MACHINE,
> +    .class_init = rvsp_ref_machine_class_init,
> +    .instance_init = rvsp_ref_machine_instance_init,
> +    .instance_size = sizeof(RVSPMachineState),
> +};
> +
> +static void rvsp_ref_init_register_types(void)
> +{
> +    type_register_static(&rvsp_ref_typeinfo);
> +}
> +
> +type_init(rvsp_ref_init_register_types)
> -- 
> 2.51.1
> 
>

Thanks,
drew

