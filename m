Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F7C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8IY-0003PZ-SB; Thu, 20 Feb 2025 10:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8IX-0003PH-Df
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8IV-00072r-NA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740064625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xdCCz4QYW+5j11g7MngUMnMM6DzUJyBM74yKX8wMrXE=;
 b=MsbBRMrZ4+GomCFbDWdxkFDqkz/jIz8Zs1dLhr+elYfG2AGAc5J1xV1uYjFlsouXR3ltad
 pbb0Z9HhTMU4fq953Grna7C6mLghrJ5nDQQBTH0YZ9dR3sZifCys/fHDrwuy6EOXq9SgKk
 dWlwZaYhlohUuPU/COQbKbcZBo7SWew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-aM9ISr7nPmSRr6IDDB6Y5A-1; Thu, 20 Feb 2025 10:17:03 -0500
X-MC-Unique: aM9ISr7nPmSRr6IDDB6Y5A-1
X-Mimecast-MFC-AGG-ID: aM9ISr7nPmSRr6IDDB6Y5A_1740064622
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-439858c5911so5921455e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740064622; x=1740669422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdCCz4QYW+5j11g7MngUMnMM6DzUJyBM74yKX8wMrXE=;
 b=WX9Kpw/larhTtUXrsv8mRl2n1Htwp4VdJoQnMcpXbAkkEVcdCQ1QaAGOc3Xj35BLi9
 TkNGfF5u1gXlyOEcsIgfjEl22d/9qaTDyZEJLH2xJhyRt21usXMYCMFVQ+qgTaN88mKE
 yqscUZjkF0b3c9ybzwOEqIrl6840pSY4dg9HTirU/bTJCsGR39ZodZpE73qYSezmKboq
 IcuPQXc+hImlLjldLbWDDFiM5LmVOtQSr5V0irvvllwthNe1luFtKyPMPoY1kHbCKQsa
 5RS7m+n0/mLvn3WJ7YyxRMCW9Ra1TLhnhsuEgkEPlGxfTSyE7ZFW4pealCo/p04xYomp
 XeDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLtlVbnhtqQyot0m/NKSFn44CFjPXNgzB3pIQgdp3z5OqoA9Z9gXCKJODNTDSkBGwBbGoNboDOrEyf@nongnu.org
X-Gm-Message-State: AOJu0YyZs7F8wzyAN2Fp2KVxQg0e2Px6Twu5OehsZIZhG+MSJZILtM4Z
 wpN7tsONeLMWHyHdthst39WmjOqOQhb+NlSQs2pUkaU4bmI8CuIShK5/aa2KR/gEjD9pxB1IeKN
 RwruNpg+xeduKjLay7YGzdSw1Y/VC3qAWX1V5kRMJ/LRcUzhjqbWP
X-Gm-Gg: ASbGncvdSm/R9NLS3WXLGCL3iEZCyTiQMrz4Du7jREutXzkYtan5GMHgfsuXJavkAwQ
 z+30NZa7CVsJTn+i1Ntv0F7pBFwUrYRFf+ptebiysYjGyJK2BNmEqaNqsGt41mRHkgAwAVP7Fm+
 ineXKBzMyojsnUSd9Kub2tyqpEOIOdJhRJ6D81wZobkFxUCq8dcVSG9iTBnrgXynFTZb3BwOqhk
 srk5awvJuH1ApxNdmSGhGWulLxvrNLVHMZHeNUmKvs32CysywwDMya49tpxsVg3dQwN8Q==
X-Received: by 2002:a05:6402:3493:b0:5d3:cff5:634f with SMTP id
 4fb4d7f45d1cf-5e089cff723mr7756040a12.24.1740064622396; 
 Thu, 20 Feb 2025 07:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHds1nwlwml4RO4XRCbt7rK/gWD49hFqVnf7/a5gsGU4/FblvwVy2R/Vshc2NYMbSrd8x5V2Q==
X-Received: by 2002:a05:6402:3493:b0:5d3:cff5:634f with SMTP id
 4fb4d7f45d1cf-5e089cff723mr7755996a12.24.1740064621876; 
 Thu, 20 Feb 2025 07:17:01 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece288e2dsm12241365a12.80.2025.02.20.07.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:17:01 -0800 (PST)
Date: Thu, 20 Feb 2025 10:16:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=C3?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND] i386: Only configure HPET firmware info when HPET
 is enabled
Message-ID: <20250220101525-mutt-send-email-mst@kernel.org>
References: <20250121140121.84550-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121140121.84550-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 21, 2025 at 10:01:21PM +0800, Zhao Liu wrote:
> At present, the hpet_cfg is written unconditionally since 40ac17cd56eb
> ("pass info about hpets to seabios.]"), because it concerns ACPI HPET is
> created unconditionally.
> 
> But that fact has changed since 51124bbfd2ea ("i386: acpi: Don't build
> HPET ACPI entry if HPET is disabled") and ACPI checks if HPET device
> exists in (hw/i386/acpi-build.c).
> 
> Therefore, configure HPET firmware information if and only if HPET is
> enabled.
>

and what is the gain from this change? just a cleanup?

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Resend:
>  * Resend the patch since it was missed on https://lore.kernel.org/qemu-devel/.




> ---
>  hw/i386/fw_cfg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 91bf1df0f2e4..d2cb08715a21 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -149,7 +149,14 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>  #endif
>      fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
>  
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
> +#ifdef CONFIG_HPET
> +    PCMachineState *pcms =
> +        (PCMachineState *)object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE);
> +    if (pcms && pcms->hpet_enabled) {
> +        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
> +    }
> +#endif
> +


Hmm. Wouldn't this break cross version migration? I suspect we need
a compat tweak if we do this. Might not be worth it ...


>      /* allocate memory for the NUMA channel: one (64bit) word for the number
>       * of nodes, one word for each VCPU->node and one word for each node to
>       * hold the amount of memory.
> -- 
> 2.34.1


