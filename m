Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D16FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM3P-0000S2-VL; Fri, 24 Apr 2026 15:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wGM3O-0000PV-GJ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wGM3L-000789-0r
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777058342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iy0RjSV7hIDFmGODouT84CrAy0ZOOZ74p+RD+6ujHTU=;
 b=NBWvyiqfhWMNFvmK5/+8XVY9HekAgxaM3+LLgHpAxle2prV9xauzkoX1xWj1IVByqPR0hL
 3uLwGG5JCQeiitmX9KKO+NaI4VSyao08cB3fSVm7ASfhljqCFuNhG6x4y/RLGH+CC6LT+k
 j3DKKIw4/Hb64WKEPsQpHFJqEbjBdoc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-DQ5EFd0POdGpKJ8XWoIitQ-1; Fri, 24 Apr 2026 15:18:58 -0400
X-MC-Unique: DQ5EFd0POdGpKJ8XWoIitQ-1
X-Mimecast-MFC-AGG-ID: DQ5EFd0POdGpKJ8XWoIitQ_1777058338
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a1f9601so4968029f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777058337; x=1777663137; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iy0RjSV7hIDFmGODouT84CrAy0ZOOZ74p+RD+6ujHTU=;
 b=juVjZmnDHM9zdcZVqXvxlc2KN13czWYDx6xNE4qe+82lVXP0SOMwyyG5A+da01Xx4h
 DBsP6cvWIRWNNjeYYts8ck/79CxawNRHhdRp6KS920CdBSTxbc3ja9m5+VU2nkzQIklh
 Okxp6zGXurrTZJWW0Ef9pZUzQ1fY+qcENCuAXv8wuHK8ch/VhEEMl+6dIM1P2/2zTbed
 pzthmpPWdTfz4H5mzXZ9mJQX+a7XaV4n1YhG+IrQiNs0P9A8nXMG/fzXxsUVW2hplcvb
 tzEhPCPtVdRTEL5eXfyDLEMd/6Ib/QqktHWIKqFkO73VZQuOvT/0/0+LYZkzS1ha92IU
 SLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058337; x=1777663137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iy0RjSV7hIDFmGODouT84CrAy0ZOOZ74p+RD+6ujHTU=;
 b=HFFBWodI3vNAvnyKCAdw/rzOSM/WcmSUWbhkzW7KaQT123SkCrc2Pre/u1ZOKiypHw
 X0jCjwqXsH5CyjaeGPmY2jKRktPwr+t2E2LfjNsKdn3oJX4eErvumrGdXjRlbEsJ6K5f
 RfKYsup9oPI+KGl6eSAVXHErXWRS99xupF/1Qhg/mTcAHowhchzIUPCcyXey1BhI7P79
 kWrSYPOOFqlaXxmKN1Q9uTjf7pELuZgf/SeYIfry6mQZLhcoHmMaxe0dxj2+HkIXZzTW
 8oSsNqBfxYu46FKTI9RQB/PJYv0jX3etj7cw+1+7cgKVblXvm2kTDL1duZlNrj0vjHzK
 Ci2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PLbN43MIeoxnI7mkTVXA9kG6geVr4XdnI5vnPKyctc5oxGM8r+/7sdpw1gl1E6+VeRqSP+veiFFRK@nongnu.org
X-Gm-Message-State: AOJu0YxDtp+r5ksZdP+73x3swdPtEaaNlIm8gksiFEht6P0PeHJ2r/r1
 6VklpZxm/xDb9cnjwsJEyoWIWp6Na5kJpX9QJV3T6rpjoPXdCrpbfFDQ9RRfh9zb780w7hRRLMh
 9fzQ+w10MG4ViGomjpc329NidD4790UpGVxURttfS7rBd2QCADPN7lrVl
X-Gm-Gg: AeBDievRjrSNhhAVXCGf0mlOccvyC5+4Uc91W13cvF7XHwKr7INwVeUC36y7kX48aw+
 dM6cT8lVSA5fVFqJjxBL+rzzSTNk3GoIE0FsUSBLCz677XNJxNNvUMt0RtRuZHlRndu9DSgtUDA
 yofmG9u1UpSJCabfysMPgT7mrJKIwKn9V1D8KnYiZrrEQEmdEVoeGqbNGH7xWbwjdwWn52LrHf6
 dPymsy9Tam0jrSc/dWZ0Eyl4YLNnhY2IBI/DenSFVq5DnYXTi6XGAS6/aPUm7XzHrxbuKMd6zlx
 jJwLPhdKDi5xk+4j6qJoARKT8kyNDCB4q0u3uWPocXeAdwuCySt11nLFBLK9t7MSdmPSeHZQg04
 HCYD05rGhKhe6LPkyGs+fSm3SFhHnEhyZP9tlkM7beXkwPxrnisO7hIKiPXyvDX8=
X-Received: by 2002:a05:6000:2008:b0:43b:4982:fc73 with SMTP id
 ffacd0b85a97d-43fe3e08fc2mr53176316f8f.25.1777058337512; 
 Fri, 24 Apr 2026 12:18:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2008:b0:43b:4982:fc73 with SMTP id
 ffacd0b85a97d-43fe3e08fc2mr53176251f8f.25.1777058336949; 
 Fri, 24 Apr 2026 12:18:56 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-147.red.bezeqint.net.
 [79.177.155.147]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc07bbsm65470121f8f.11.2026.04.24.12.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:18:56 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:18:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH for-11.1] hw: add compat machines for 11.1
Message-ID: <20260424151846-mutt-send-email-mst@kernel.org>
References: <20260331140347.653404-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331140347.653404-1-cohuck@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 31, 2026 at 04:03:47PM +0200, Cornelia Huck wrote:
> Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 13 +++++++++++--
>  hw/i386/pc_q35.c           | 13 +++++++++++--
>  hw/m68k/virt.c             |  9 ++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/core/boards.h   |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  10 files changed, 76 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ec0d8475ca40..d7e68d42ce02 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3719,10 +3719,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_11_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +
>  static void virt_machine_11_0_options(MachineClass *mc)
>  {
> +    virt_machine_11_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
> +DEFINE_VIRT_MACHINE(11, 0)
>  
>  static void virt_machine_10_2_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e956..1abc8ae73739 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,9 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
>  
> +GlobalProperty hw_compat_11_0[] = {};
> +const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> +
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },
>      { "isa-cirrus-vga", "global-vmstate", "true" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4b53b5be4a96..2ecad3c503fb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -73,6 +73,9 @@
>  #include "hw/xen/xen-bus.h"
>  #endif
>  
> +GlobalProperty pc_compat_11_0[] = {};
> +const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
> +
>  GlobalProperty pc_compat_10_2[] = {};
>  const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
>  
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 4d71e0d51a28..82457bdb167a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                       pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>  }
>  
> -static void pc_i440fx_machine_11_0_options(MachineClass *m)
> +static void pc_i440fx_machine_11_1_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>  }
>  
> -DEFINE_I440FX_MACHINE_AS_LATEST(11, 0);
> +DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
> +
> +static void pc_i440fx_machine_11_0_options(MachineClass *m)
> +{
> +    pc_i440fx_machine_11_1_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
> +    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
> +}
> +
> +DEFINE_I440FX_MACHINE(11, 0);
>  
>  static void pc_i440fx_machine_10_2_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index cb23322f5a44..972dd9275f68 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -364,12 +364,21 @@ static void pc_q35_machine_options(MachineClass *m)
>                       pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>  }
>  
> -static void pc_q35_machine_11_0_options(MachineClass *m)
> +static void pc_q35_machine_11_1_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>  }
>  
> -DEFINE_Q35_MACHINE_AS_LATEST(11, 0);
> +DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> +
> +static void pc_q35_machine_11_0_options(MachineClass *m)
> +{
> +    pc_q35_machine_11_1_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
> +    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
> +}
> +
> +DEFINE_Q35_MACHINE(11, 0);
>  
>  static void pc_q35_machine_10_2_options(MachineClass *m)
>  {
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index ffe6e234155b..96c0fb73fea5 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
>  #define DEFINE_VIRT_MACHINE(major, minor) \
>      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
>  
> +static void virt_machine_11_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +
>  static void virt_machine_11_0_options(MachineClass *mc)
>  {
> +    virt_machine_11_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
> +DEFINE_VIRT_MACHINE(11, 0)
>  
>  static void virt_machine_10_2_options(MachineClass *mc)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ab39dfea6b8..428b491a7df1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4760,15 +4760,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>  #define DEFINE_SPAPR_MACHINE(major, minor) \
>      DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
>  
> +/*
> + * pseries-11.1
> + */
> +static void spapr_machine_11_1_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
> +
>  /*
>   * pseries-11.0
>   */
>  static void spapr_machine_11_0_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_11_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
>  
> -DEFINE_SPAPR_MACHINE_AS_LATEST(11, 0);
> +DEFINE_SPAPR_MACHINE(11, 0);
>  
>  /*
>   * pseries-10.2
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3ef009463d11..cc768daeb04c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -907,14 +907,26 @@ static const TypeInfo ccw_machine_info = {
>      DEFINE_CCW_MACHINE_IMPL(false, major, minor)
>  
>  
> +static void ccw_machine_11_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_11_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
> +
>  static void ccw_machine_11_0_instance_options(MachineState *machine)
>  {
> +    ccw_machine_11_1_instance_options(machine);
>  }
>  
>  static void ccw_machine_11_0_class_options(MachineClass *mc)
>  {
> +    ccw_machine_11_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
> -DEFINE_CCW_MACHINE_AS_LATEST(11, 0);
> +DEFINE_CCW_MACHINE(11, 0);
>  
>  static void ccw_machine_10_2_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index b8dad0a1074d..db83fe92922b 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -798,6 +798,9 @@ struct MachineState {
>          } \
>      } while (0)
>  
> +extern GlobalProperty hw_compat_11_0[];
> +extern const size_t hw_compat_11_0_len;
> +
>  extern GlobalProperty hw_compat_10_2[];
>  extern const size_t hw_compat_10_2_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 22325324d094..85a74363b52e 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -208,6 +208,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
>  
> +extern GlobalProperty pc_compat_11_0[];
> +extern const size_t pc_compat_11_0_len;
> +
>  extern GlobalProperty pc_compat_10_2[];
>  extern const size_t pc_compat_10_2_len;
>  
> -- 
> 2.53.0


