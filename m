Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE934C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 09:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVw4-0001aK-2i; Fri, 07 Jun 2024 05:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVw2-0001Zl-V5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVw0-0007qy-OK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717752654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AZcq9bl9m06Y1mdSQb58GQqgUpM3gMTglQTF57CKWDI=;
 b=SxSEnCQ8xkLObc1PiXkvDYMW/7DB8dN0wEYTdef3xeXa/Uzh0pzR9MzEEoXQgyqRLedqxH
 +StkF2dt5CvCRhHW0FYJw8AZnA/ETn0QY30+9isUUtQsKQh004lkGu30lKE56GmDPpUvsY
 rO62imokO2mzKSlxnZAYcC7d876umKM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-pEKnNRJJP8-lBkLLxSvJJQ-1; Fri, 07 Jun 2024 05:30:51 -0400
X-MC-Unique: pEKnNRJJP8-lBkLLxSvJJQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6929fc5b52so109371866b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 02:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717752650; x=1718357450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZcq9bl9m06Y1mdSQb58GQqgUpM3gMTglQTF57CKWDI=;
 b=pfMXHKvQvXU6qLFImaKXh1/FBzLfrX1zR5v0o5yZTPPSJEM3FU3qTqKIPsJ/MA4Nj/
 PtpaLgqjNGAlkBeXmkz3NruzkeCPckMb6SjfyWqXtJkVQ4zPKiXMVfw3Qj6mrzVJEelB
 9Z0vnw9TBUL1k9tneM5JR0wgNJBHZCeVCgl9l3rX9s+KJ3jua4gricbIcQ5vpGm7/EAY
 3+llvGbwCTMCBvmLFOn/ay+3Vzg5uDaEvhKSINdy92QVaoB28de2QXOB5Bvg5WAAQ7kA
 WYLf8TWARt1q6CSX5yw96BhJecQBBqTdiyveKBEZFIme109jlSNkLxmKelAZ66shG211
 EVlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC4PiM+Af7IE9yN65nYf82RoSEsbg9eGL6mPec23B8EJb74wKDX8Zy1eFyd3B4JhXx/pl0gN6ywBEzquSHjbrDiqj221E=
X-Gm-Message-State: AOJu0YzR6NcuUzV21wHp0oPViXhcp3zvp1tTQLEINhmpsnHXocSK0Nte
 9LDeiIPqYAY4X2+UwqWB9XHW0TVhYDRd38oh+x2wJuD/HUMOWIZZbBoadUk1eWCLXTvceUl9cZS
 RjRW2ABUtbjmubWTyULph0h+7mF9+W9g0Dn3UkNXisGSOTAn11cV9
X-Received: by 2002:a17:906:79a:b0:a63:41f7:d46 with SMTP id
 a640c23a62f3a-a6cd6663cbdmr127941066b.17.1717752650516; 
 Fri, 07 Jun 2024 02:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg4oFXPqc+QkhkiZnlf2BGpONhxgNLxT685y678xTOIRwKIIMBwX/a/Ado9A+v+pfSKWXxsA==
X-Received: by 2002:a17:906:79a:b0:a63:41f7:d46 with SMTP id
 a640c23a62f3a-a6cd6663cbdmr127939666b.17.1717752649963; 
 Fri, 07 Jun 2024 02:30:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c8bfesm218475566b.56.2024.06.07.02.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 02:30:49 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:30:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH v2 2/3] hw/i386/acpi-build: Return a pre-computed _PRT
 table
Message-ID: <20240607051808-mutt-send-email-mst@kernel.org>
References: <20240607085903.1349513-1-ribalda@chromium.org>
 <20240607085903.1349513-2-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607085903.1349513-2-ribalda@chromium.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 07, 2024 at 08:58:57AM +0000, Ricardo Ribalda wrote:
> When qemu runs without kvm acceleration the ACPI executions take a great
> amount of time. If they take more than the default time (30sec), the
> ACPI calls fail and the system might not behave correctly.

Wow.

> Now the _PRT table is computed on the fly. We can drastically reduce the
> execution of the _PRT method if we return a pre-computed table.
> 
> Without this patch:
> [   51.343484] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   51.527032] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   51.530049] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> [   51.530797] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> [   81.922901] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   82.103534] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   82.106088] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> [   82.106761] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> [  112.192568] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [  112.486687] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [  112.489554] virtio-pci 0000:00:05.0: can't derive routing for PCI INT A
> [  112.490027] virtio-pci 0000:00:05.0: PCI INT A: no GSI
> [  142.559448] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [  142.718596] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [  142.722889] virtio-pci 0000:00:06.0: can't derive routing for PCI INT A
> [  142.724578] virtio-pci 0000:00:06.0: PCI INT A: no GSI
> 
> With this patch:
> [   22.938076] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> [   24.214002] ACPI: \_SB_.LNKD: Enabled at IRQ 11
> [   25.465170] ACPI: \_SB_.LNKA: Enabled at IRQ 10
> [   27.944920] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> 
> ACPI disassembly:
>         Scope (PCI0)
>         {
>             Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
>             {
>                 Return (Package (0x80)
>                 {
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         Zero,
>                         LNKD,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         One,
>                         LNKA,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         0x02,
>                         LNKB,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         0x03,
>                         LNKC,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0x0001FFFF,
>                         Zero,
>                         LNKS,
>                         Zero
>                     },
> Context: https://lore.kernel.org/virtualization/20240417145544.38d7b482@imammedo.users.ipa.redhat.com/T/#t
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  hw/i386/acpi-build.c | 118 ++++++++-----------------------------------
>  1 file changed, 21 insertions(+), 97 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53f804ac16..4c14d39173 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -725,40 +725,7 @@ static Aml *aml_pci_pdsm(void)
>      return method;
>  }
>  
> -/**
> - * build_prt_entry:
> - * @link_name: link name for PCI route entry
> - *
> - * build AML package containing a PCI route entry for @link_name
> - */
> -static Aml *build_prt_entry(const char *link_name)
> -{
> -    Aml *a_zero = aml_int(0);
> -    Aml *pkg = aml_package(4);
> -    aml_append(pkg, a_zero);
> -    aml_append(pkg, a_zero);
> -    aml_append(pkg, aml_name("%s", link_name));
> -    aml_append(pkg, a_zero);
> -    return pkg;
> -}
> -
> -/*
> - * initialize_route - Initialize the interrupt routing rule
> - * through a specific LINK:
> - *  if (lnk_idx == idx)
> - *      route using link 'link_name'
> - */
> -static Aml *initialize_route(Aml *route, const char *link_name,
> -                             Aml *lnk_idx, int idx)
> -{
> -    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
> -    Aml *pkg = build_prt_entry(link_name);
> -
> -    aml_append(if_ctx, aml_store(pkg, route));
> -
> -    return if_ctx;
> -}
> -


Can't say I like defines like this. Explains almost nothing
and is far divorced from code.
Better to do it near the 1st use:

 int nroutes = 128 /* Explain why it's 128 here */;

 rt_pkg = aml_varpackage(nroutes);



>  /*
>   * build_prt - Define interrupt rounting rules
>   *
> @@ -771,74 +738,31 @@ static Aml *initialize_route(Aml *route, const char *link_name,
>   */
>  static Aml *build_prt(bool is_pci0_prt)
>  {
> -    Aml *method, *while_ctx, *pin, *res;
> +    Aml *rt_pkg, *method;
> +    const char link_name[][2] = {"D", "A", "B", "C"};

Wouldn't it be clearer if we just made it LNKA, LNKB etc?

> +    int i;
>  
>      method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
> -    res = aml_local(0);
> -    pin = aml_local(1);
> -    aml_append(method, aml_store(aml_package(128), res));
> -    aml_append(method, aml_store(aml_int(0), pin));
> +    rt_pkg = aml_varpackage(N_ROUTES);


Again, initialize where defined.

>  
> -    /* while (pin < 128) */
> -    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
> -    {
> -        Aml *slot = aml_local(2);
> -        Aml *lnk_idx = aml_local(3);
> -        Aml *route = aml_local(4);
> -
> -        /* slot = pin >> 2 */
> -        aml_append(while_ctx,
> -                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
> -        /* lnk_idx = (slot + pin) & 3 */
> -        aml_append(while_ctx,
> -            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
> -                      lnk_idx));
> -
> -        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
> -        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
> -        if (is_pci0_prt) {
> -            Aml *if_device_1, *if_pin_4, *else_pin_4;
> -
> -            /* device 1 is the power-management device, needs SCI */
> -            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
> -            {
> -                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
> -                {
> -                    aml_append(if_pin_4,
> -                        aml_store(build_prt_entry("LNKS"), route));
> -                }
> -                aml_append(if_device_1, if_pin_4);
> -                else_pin_4 = aml_else();
> -                {
> -                    aml_append(else_pin_4,
> -                        aml_store(build_prt_entry("LNKA"), route));
> -                }
> -                aml_append(if_device_1, else_pin_4);
> -            }
> -            aml_append(while_ctx, if_device_1);
> -        } else {
> -            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
> +    for (i = 0; i < N_ROUTES; i++) {
> +        Aml *pkg = aml_package(4);
> +        const char *name;
> +
> +        name = link_name[((i >> 2) + i) & 3];

better to combine definition and initialization of name.

And can we get some explanation of what is going on here?


> +
> +        if (is_pci0_prt && i == 4) {
> +            name = "S";
>          }

So this discards the previous calculation.
if {} else {} would be better.


> -        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
> -        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
> -
> -        /* route[0] = 0x[slot]FFFF */
> -        aml_append(while_ctx,
> -            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
> -                             NULL),
> -                      aml_index(route, aml_int(0))));
> -        /* route[1] = pin & 3 */
> -        aml_append(while_ctx,
> -            aml_store(aml_and(pin, aml_int(3), NULL),
> -                      aml_index(route, aml_int(1))));
> -        /* res[pin] = route */
> -        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
> -        /* pin++ */
> -        aml_append(while_ctx, aml_increment(pin));
> +
> +        aml_append(pkg, aml_int((i << 14) | 0xFFFF));
> +        aml_append(pkg, aml_int(i & 3));

document and explain above &/|/<< logic too, please.

> +        aml_append(pkg, aml_name("LNK%s", name));
> +        aml_append(pkg, aml_int(0));
> +        aml_append(rt_pkg, pkg);
>      }
> -    aml_append(method, while_ctx);
> -    /* return res*/
> -    aml_append(method, aml_return(res));
> +
> +    aml_append(method, aml_return(rt_pkg));
>  
>      return method;
>  }
> -- 
> 2.45.2.505.gda0bf45e8d-goog


