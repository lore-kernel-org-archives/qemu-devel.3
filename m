Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3861CF45AE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLTo-0004Tm-OM; Mon, 12 Jan 2026 12:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLPF-00011e-Ps
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLPE-00076C-9r
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uehu+xQx7dj6E3RoenzKjj23QeiGyi5ZnRxyNtgQu2g=;
 b=Uy/meMhZ/LtV2AsZ/6iRb0+f1PS0f1JlS461mcxTqaG6QmlptfpkzhiqMbIj3X8hRsdpRu
 VF1OovA01kMrGTnzhGW1I9e5Pk97w6TVHB8JHFnjJxuRDrt/8/QoZM92L8MQRSGnv2pdbv
 iuK5twhtHeiVNTHjze2UxnC+7VfMVtE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-uMT0v8TfORaNQOZxI5Mhow-1; Mon, 12 Jan 2026 12:08:38 -0500
X-MC-Unique: uMT0v8TfORaNQOZxI5Mhow-1
X-Mimecast-MFC-AGG-ID: uMT0v8TfORaNQOZxI5Mhow_1768237717
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47788165c97so37207915e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237717; x=1768842517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uehu+xQx7dj6E3RoenzKjj23QeiGyi5ZnRxyNtgQu2g=;
 b=fB/NR95BGMh98RL9adEPSNIR2PHvTl24G32uO70Z7gPfJLgXCRIlqyCUesh9uKze2l
 +d6SCSJwJWcjjkg4/KM+iEOX/lQ6+KAl5aFynNTfqM0wCTTPZiUuFzzXjHtyEmJFg782
 iWQJXsEu9TNfwTQHLXWa0F8v0TWnwkjLY3w8Vj4wz9+9iGa4VYnggTZezyha2nTTJpzJ
 oC8o+vIkZ1sVH7YWSLKNH9e4jwaAcpeCiU5l1t30J29DWmUosjIdyn6NLkZEpbDrw/xp
 +IqjZKFvCBlXaITioSbvrTWNXmLRNgKxVjZC+L2EoLvhxR+bnU9/WZ1SJnijAbyeMzlA
 NwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237717; x=1768842517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uehu+xQx7dj6E3RoenzKjj23QeiGyi5ZnRxyNtgQu2g=;
 b=MDahCcRLlEfYcLw6bV5qvYyCrgsd1QTdm8BnI02Gsh0E985+u6668DC3MPo3O6IXti
 JxDaDhyMwduR9b+5mvnqHjt8MwBTAUWnlIxU0JxOPPLMDr6hMFgfyEzZ5hCngzR1EJj4
 I7VIsMwqbfLsUxa2SwSSX6fuj00pOHurvBia0oCsrWb5rktGqDEBjD3+/fzBQQ3yS4s6
 HJfnOdXZ2dPNg6HECjFZd3X3lDZjVnMr41pSttb3mMmE35iivzPNJa6gBScvMJgmYqHP
 qam9ZO6ql5PTjihb117UJ320nWAVXOrWdExwrpXJXrLcAIJCbfpnRo8PtvBsb1abvpff
 XEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOUwax2bMTZYdxpJ57Tqt7ycoYbW3v4U3xcab9ngpod4/xrr5Lrz/sCAL0ds6EiYx6x7KO56VdpSRR@nongnu.org
X-Gm-Message-State: AOJu0YzyKf+xf4qi7GvvsDrFnQEuDP3upa6bYLF8Jgfm1n/hIIx4nV4K
 NO8BTWaMbO2Emm7n8Rxk8Vfy2+f9C4KTWA3Lz07zj5z43IzS8SpQAzWjkJ8cDgaf8zUgo1yJGUv
 IVPPXvwyoGc28/BeSE/zLh04m6KoQUAKcNmlogryLJbgnVnK1AiM2OzIPvufIUbfTIYu10VRU+c
 Kio0Ew4Npz4sYP7hHojEfVF2EfqMplaDI=
X-Gm-Gg: AY/fxX7EO4c2mIjRzxMRt0MgvTJZl/69onHl5yfptaQpeuvDIBDmHqJ6+hw1J2yfruE
 bSLZcLduBPiHgdPlWUnZyNYYcgc8Gw69hBUOyFGNfjxPPU4gB5pbm2vzbV6X2Tz5EWiQRkhAfA3
 H+1LXuNi9mcXWGtbudAw8TevK6exM3MaRth2Z7WrUH3203kwOZif8IcP/WQ5xH1CqSTUEdbnmUr
 pm+a/WUoFC58SsFHID4eC+nOoO1CgVAk0eAcL2C5JEk/il625ecqda9RcDW2Md6I3MmbA==
X-Received: by 2002:a05:600c:a10a:b0:477:7bd2:693f with SMTP id
 5b1f17b1804b1-47d869a6980mr158250765e9.6.1768237716577; 
 Mon, 12 Jan 2026 09:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwqW31gAMuXtSnKzztCB1SmpWewS7W/AbC9ckMxuoVKmqTODiapV67ShTxTW1baaqumEt+ZHydA0H+XVesmGg=
X-Received: by 2002:a05:600c:a10a:b0:477:7bd2:693f with SMTP id
 5b1f17b1804b1-47d869a6980mr158250425e9.6.1768237716133; Mon, 12 Jan 2026
 09:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-12-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-12-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:08:23 +0100
X-Gm-Features: AZwV_QiZz31TiQz1u2tp1nj0kN-UTTKgWLW2HYrCutr-qZ2aUaQJVSNiddvSnbA
Message-ID: <CABgObfZTjvfhb7DnNSu74PVUUZ6kBXw6_Y1pv_0mgpoxys+h+g@mail.gmail.com>
Subject: Re: [PATCH v2 11/32] kvm/i386: reload firmware for confidential guest
 reset
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> When IGVM is not being used by the confidential guest, the guest firmware=
 has
> to be reloaded explictly again into memory. This is because, the memory i=
nto
> which the firmware was loaded before reset was encrypted and is thus lost
> upon reset. When IGVM is used, it is expected that the IGVM will contain =
the
> guest firmware and the execution of the IGVM directives will set up the g=
uest
> firmware memory.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4fedc621b8..46c4f9487b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -51,6 +51,8 @@
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qemu/memalign.h"
> +#include "qemu/datadir.h"
> +#include "hw/core/loader.h"
>  #include "hw/i386/x86.h"
>  #include "hw/i386/kvm/xen_evtchn.h"
>  #include "hw/i386/pc.h"
> @@ -3267,6 +3269,22 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
>
>  static int xen_init_wrapper(MachineState *ms, KVMState *s);
>
> +static void reload_bios_rom(X86MachineState *x86ms)
> +{
> +    int bios_size;
> +    const char *bios_name;
> +    char *filename;
> +
> +    bios_name =3D MACHINE(x86ms)->firmware ?: "bios.bin";
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +
> +    bios_size =3D get_bios_size(x86ms, bios_name, filename);
> +
> +    void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
> +    load_image_size(filename, ptr, bios_size);
> +    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
> +}
> +
>  int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
>  {
>      Error *local_err =3D NULL;
> @@ -3285,6 +3303,16 @@ int kvm_arch_vmfd_change_ops(MachineState *ms, KVM=
State *s)
>              error_report_err(local_err);
>              return ret;
>          }
> +        if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> +            X86MachineState *x86ms =3D X86_MACHINE(ms);
> +            /*
> +             * If an IGVM file is specified then the firmware must be pr=
ovided
> +             * in the IGVM file.
> +             */
> +            if (!x86ms->igvm) {
> +                reload_bios_rom(x86ms);
> +            }
> +        }

Does this have to be done here, as opposed to in its own notifier or
anyway a notifier owned by the machine?

In any case, this can be done after the part in common with kvm_arch_init()=
.

Paolo


