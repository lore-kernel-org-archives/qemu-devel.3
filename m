Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE44C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ovk-00086D-Gq; Fri, 03 May 2024 05:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1s2ovi-00085y-0o
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:10:10 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1s2ovf-0002KJ-ME
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:10:09 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so25318536d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1714727406; x=1715332206; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhBwHcG8DeU/nNoNr/s1hUtQqPGkcuusRXIQ2lhTUpM=;
 b=Ss90lS/6Qpv+POgF3P6fFYHfZ8PnjKBqqqYdx48FKj34Bf95MRRA90v4zdJGCAS2Fo
 iYqFXt2A3xWMfEpTot/ca6Cz19yZUEe1NVbOhlDG9fkiZ78Y4aQyKNa3g0BOBgyZdUrL
 DS61+XEtK4p8J5vRo9DUYuhNNMGOYtn09ZYYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727406; x=1715332206;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhBwHcG8DeU/nNoNr/s1hUtQqPGkcuusRXIQ2lhTUpM=;
 b=eBppiBEX8ocAlwGASjzf4DJ3h47t7UDvrk3ZQAHDGMzt8Bdt/UfQyFyVbKHw3swXq8
 /ZjShxWn/AjLJIKawZu1TTxcklYje3i2YzGK8KXE5wWoz1QpwaWom5g8gOCPHIilwdYa
 V6fQeDqnQ3HMoBFc+gI5jFtDk6M+qIY38gs5vM6wm4/RAj008wm6O9uJTGzzGObslcA2
 3enmy99VA80VLl1JOAoPMjwkTD6VEbp5reOBWXq08GRQY1FfM0agrrDsE1sT3PeLiWaJ
 UhdOFA+/K3Q6B6+JLewW+q6Qo/gnOfuIuo7xBlnNVneRmMOl25a8QntsNoJeCBuTIuJH
 49Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKj67K7AvddGLrO9v4Tt14ob3BLaphZH4+MWB7Dp0xbGUTCFNd7weVZTVg0AFKgmF8E8uCS5ZYGXqp3OWyNjlxhTP2TUw=
X-Gm-Message-State: AOJu0Yx88Agbki/LPeLeKKHFDZTWJ6g8/Ws7Q1ZjVxK1aKxgz0mRgUME
 46tZh2UavtMdNelcVR1NHoQ+tM4EtqWhx3QHD6PT5kVlNQlR7b1XY8hRnCofctgjM9Gt1Po/EOM
 =
X-Google-Smtp-Source: AGHT+IGeo7qxSBNLQLP/oVga2MYWi2Dh2T+216xDtiWp/1lBnckbL0ZZd3zjor72v9nHcODN6NIZNw==
X-Received: by 2002:a0c:e807:0:b0:6a0:fb8e:2845 with SMTP id
 y7-20020a0ce807000000b006a0fb8e2845mr9010806qvn.11.1714727405458; 
 Fri, 03 May 2024 02:10:05 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com.
 [209.85.219.48]) by smtp.gmail.com with ESMTPSA id
 r10-20020ac8794a000000b00439d68d5eb0sm1354538qtt.78.2024.05.03.02.10.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 02:10:04 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-69b50b8239fso22516386d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVmu1tqcbo1BTQotty1haDT+TV76hapYstwVFPiyyRT8d16IseQG2RmZ6iXpN2NZaDamJcCOyNkIZWt4b1DjyEZ1lJS5Tw=
X-Received: by 2002:a0c:d803:0:b0:6a0:ef09:dbaf with SMTP id
 h3-20020a0cd803000000b006a0ef09dbafmr8770829qvj.19.1714727403465; Fri, 03 May
 2024 02:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240417135608.2613586-1-ribalda@chromium.org>
In-Reply-To: <20240417135608.2613586-1-ribalda@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 3 May 2024 11:09:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCv=2roABFXP9=BURxU_qvJrTPJaU5Zm=YrFzcyoVRp4Yw@mail.gmail.com>
Message-ID: <CANiDSCv=2roABFXP9=BURxU_qvJrTPJaU5Zm=YrFzcyoVRp4Yw@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/acpi-build: Return a pre-computed _PRT table
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-devel@nongnu.org, Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Friendly ping

On Wed, 17 Apr 2024 at 15:56, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> When qemu runs without kvm acceleration the ACPI executions take a great
> amount of time. If they take more than the default time (30sec), the
> ACPI calls fail and the system might not behave correctly.
>
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
> +#define N_ROUTES 128
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
> +    int i;
>
>      method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
> -    res = aml_local(0);
> -    pin = aml_local(1);
> -    aml_append(method, aml_store(aml_package(128), res));
> -    aml_append(method, aml_store(aml_int(0), pin));
> +    rt_pkg = aml_varpackage(N_ROUTES);
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
> +
> +        if (is_pci0_prt && i == 4) {
> +            name = "S";
>          }
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
> 2.44.0.683.g7961c838ac-goog
>


-- 
Ricardo Ribalda

