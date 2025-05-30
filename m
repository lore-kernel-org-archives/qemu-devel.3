Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C99C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1KP-0001er-8Z; Fri, 30 May 2025 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL1KL-0001eH-Va
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL1KI-0001gB-CF
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748617635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HupKbNPSYfmbXC8ke5w04k/H8F9nN51ZxmrlIjAhzA=;
 b=PKxc6qxMDLjRvsigabtN4Hwf/M5PTExOqY/VkMmOtlWdikrWlOMv27VwGYjaXgE9Q60j5x
 q4p4pIiY/Wyb06WL5iL8zzEByDwtKZguqCVCxnx1J49at7Z5pa+bHS/oDJN5jTmB2xT4n0
 XpW+mdU53H2UJuiOxd1lfSgiu6DK6c4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-iEwvoYp_OiWdGVT4sTNeRg-1; Fri, 30 May 2025 11:07:09 -0400
X-MC-Unique: iEwvoYp_OiWdGVT4sTNeRg-1
X-Mimecast-MFC-AGG-ID: iEwvoYp_OiWdGVT4sTNeRg_1748617628
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso472701f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 08:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748617628; x=1749222428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HupKbNPSYfmbXC8ke5w04k/H8F9nN51ZxmrlIjAhzA=;
 b=U+f9gyOis1d4RdV1Qijs2GV09pNN36dzEKxigcA+/Xlud0+uE4hV1ly9YQJgftnW2Z
 4S1Pqw9Zgk+792xVjkwopr4uImHWGJKBNvMwu0ibpkPkY30rVe5KyfCiJ146tbS7X2VQ
 4N4nRkjXtHS3kZZ74XL4oqid1NfiVA0rmlm6jP1zjWyur0t6lAkhM91YBcwM2v3hxTj3
 CWVKFgL/im0yULXHeKicn2COIDnk/1sdKkGXTJ3LoBqDdw+AnQWTQEIBOMpQWNBpVr0E
 TufmXchJMDMBQj3mWTqJCLlE8+UpLuP7nGum7wRGzA6OgyRMZm3VxVRrjCRJymPDfE1y
 lRgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU1wodE0JzP6yBoNOCYxHK+fp6f8O7pn3HLJ/fdmO13ZNdcq9KTk2jZ7Ul4UHOqjzRom8hKgV72PT/@nongnu.org
X-Gm-Message-State: AOJu0YyNBKood6HtJyUKPSfpjf+Ii2jIApcE4Hp8UfDZ/Fvp+cXGQV0r
 6mzC1prfXiSn+5H7glX4pzl/jiHJvf8BFfoAzItGlXQa3fk1eOYDJS4o9NOJdI1HvGm0pyyln5Z
 F9CWeR0LN5BK5yM7fFY+hp6v1QvG8XjNalq5/JTZUKXfeXSDOphkOWCwe
X-Gm-Gg: ASbGncsOFBgLVefVnfuuYyS3GbD+ULaSdo5TrO9K0y6kvdQGDRHmZRY6crljk+jPtF5
 GE5X8KJ4bogoFtBxlm2pTv5fWgbiVSM8+IRgmrdhw/FnQoPIIUmppIpHGylJVVvIs8JvoQsLvK8
 NKRUvmv9554kbCovUKcIFd9SU1bnovbtn0opjw6Pyjo1xrdkxEX6YKN9DP0WyIjDHaz385JbTha
 7D5gvmDmsRicjRlX9/SRdJEfKchRzD8hILcC63QCGM2yx2APHyBqlNX02DLjuWHJt/VMhxPAckT
 tAytF2cvubgD+kBoEOsolnNx6vhLO+cG
X-Received: by 2002:a05:6000:1447:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a4f7a9b5abmr3110024f8f.39.1748617627661; 
 Fri, 30 May 2025 08:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsbUoMUeGrGSKAIySsyTDFal9FBBlmWZpW3FVx7725RPXt9cRTzCtLa+i3t3pndxsLKQGcQ==
X-Received: by 2002:a05:6000:1447:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a4f7a9b5abmr3109945f8f.39.1748617626890; 
 Fri, 30 May 2025 08:07:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8easm5132781f8f.34.2025.05.30.08.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 08:07:06 -0700 (PDT)
Date: Fri, 30 May 2025 17:07:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <20250530170705.31927dd8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250511093927-mutt-send-email-mst@kernel.org>
References: <20250307102329.556260-1-anisinha@redhat.com>
 <20250511093927-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, 11 May 2025 09:40:08 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Mar 07, 2025 at 03:53:28PM +0530, Ani Sinha wrote:
> > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > introduced 'default_cpu_version' for PCMachineClass. This created three
> > categories of CPU models:
> >  - Most unversioned CPU models would use version 1 by default.
> >  - For machines 4.0.1 and older that do not support cpu model aliases, a
> >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> >  - It was thought that future machines would use the latest value of cpu
> >    versions corresponding to default_cpu_version value of
> >    CPU_VERSION_LATEST [1].
> > 
> > All pc machines still use the default cpu version of 1 for
> > unversioned cpu models. Use of CPU_VERSION_LATEST was removed in [2].
> > 
> > This change cleans up the complicated logic around default_cpu_version
> > including getting rid of default_cpu_version property itself. One new
> > flag is introduced for the legacy model for machines 4.0.1 and older.
> > For older machines, a new pc machine property is
> > introduced that separates pc machine versions 4.0.1 and older from the newer
> > machines. 4.0.1 and older machines are scheduled to be deleted towards
> > end of 2025 since they would be 6 years old by then. At that time, we can
> > remove all logic around legacy cpus.
> > This change also removes all complications around CPU_VERSION_AUTO
> > including removal of the value itself.
> > 
> > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> > 2) See commit XXX ("microvm: do not use the lastest cpu version")
> > 
> > CC: imammedo@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>  
> 
> Anyone merging this? If so:
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Presumably cpu stuff goes via Paolo's tree.

This cleanup should go together with 
1) "[PATCH v2] microvm: do not use the lastest cpu version"
https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg00094.html
that I and Intel folks (arguably the single user of microvm) acked.

Ani,
   would this patch work with without [1]? 



> 
> > ---
> >  hw/i386/microvm.c     |  2 +-
> >  hw/i386/pc.c          |  1 +
> >  hw/i386/pc_piix.c     | 10 +++++---
> >  hw/i386/pc_q35.c      | 10 +++++---
> >  hw/i386/x86-common.c  |  4 +---
> >  include/hw/i386/pc.h  |  6 ++---
> >  include/hw/i386/x86.h |  2 +-
> >  target/i386/cpu.c     | 56 ++++++++++++-------------------------------
> >  target/i386/cpu.h     | 16 +------------
> >  9 files changed, 37 insertions(+), 70 deletions(-)
> > 
> > changelog:
> > v2: explain in commit log why use of CPU_VERSION_LATEST for machines
> > is problematic.
> > v3: fix a bug that broke the pipeline
> > https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
> > when cpu versions are explicitly specified in the command line,
> > respect that and do not enforce legacy (unversioned) cpu logic.
> > The pipeline is green now with the fix:
> > https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
> > v4: made changes as per Zhao's suggestions.
> > Pipeline passes https://gitlab.com/anisinha/qemu/-/pipelines/1635829877
> > v5: adjustment of pc_init_cpus() declaration as per Zhao's suggestion. This
> > simplifies things and also passes compilation.
> > CI still passes https://gitlab.com/anisinha/qemu/-/pipelines/1637657451
> > v6: cosmetic commit log correction as suggested by Igor. rebase, added tags.
> > v7: This patch is based off the top of
> > https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg00934.html.
> > Igor's inputs taken into consideration.
> > CI passed.
> > Note: The above patch has not merged to QEMU upstream yet. Hence, its
> > commit hash is marked as XXX in the commit log for this patch.
> > 
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index a340a5fd39..0eca629958 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -491,7 +491,7 @@ static void microvm_machine_state_init(MachineState *machine)
> >  
> >      microvm_memory_init(mms);
> >  
> > -    x86_cpus_init(x86ms, 1);
> > +    x86_cpus_init(x86ms);
> >  
> >      microvm_devices_init(mms);
> >  }
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 63a96cd23f..6a2ccfd42a 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -30,6 +30,7 @@
> >  #include "hw/hyperv/hv-balloon.h"
> >  #include "hw/i386/fw_cfg.h"
> >  #include "hw/i386/vmport.h"
> > +#include "target/i386/cpu.h"
> >  #include "system/cpus.h"
> >  #include "hw/ide/ide-bus.h"
> >  #include "hw/timer/hpet.h"
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 04d2957adc..b793a4c765 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -181,7 +181,12 @@ static void pc_init1(MachineState *machine, const char *pci_type)
> >      }
> >  
> >      pc_machine_init_sgx_epc(pcms);
> > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > +
> > +    if (pcmc->no_versioned_cpu_model) {
> > +        /* use legacy cpu as it does not support versions */
> > +        x86_cpu_set_legacy_version();
> > +    }
> > +    x86_cpus_init(x86ms);
> >  
> >      if (kvm_enabled()) {
> >          kvmclock_create(pcmc->kvmclock_create_always);
> > @@ -457,7 +462,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >      ObjectClass *oc = OBJECT_CLASS(m);
> >      pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
> >      pcmc->pci_root_uid = 0;
> > -    pcmc->default_cpu_version = 1;
> >  
> >      m->family = "pc_piix";
> >      m->desc = "Standard PC (i440FX + PIIX, 1996)";
> > @@ -669,7 +673,7 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
> >  {
> >      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >      pc_i440fx_machine_4_1_options(m);
> > -    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
> > +    pcmc->no_versioned_cpu_model = true;
> >      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
> >      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 77536dd697..be7775e9de 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -187,7 +187,12 @@ static void pc_q35_init(MachineState *machine)
> >      }
> >  
> >      pc_machine_init_sgx_epc(pcms);
> > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > +
> > +    if (pcmc->no_versioned_cpu_model) {
> > +        /* use legacy cpu as it does not support versions */
> > +        x86_cpu_set_legacy_version();
> > +    }
> > +    x86_cpus_init(x86ms);
> >  
> >      if (kvm_enabled()) {
> >          kvmclock_create(pcmc->kvmclock_create_always);
> > @@ -339,7 +344,6 @@ static void pc_q35_machine_options(MachineClass *m)
> >  {
> >      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >      pcmc->pci_root_uid = 0;
> > -    pcmc->default_cpu_version = 1;
> >  
> >      m->family = "pc_q35";
> >      m->desc = "Standard PC (Q35 + ICH9, 2009)";
> > @@ -547,7 +551,7 @@ static void pc_q35_machine_4_0_1_options(MachineClass *m)
> >  {
> >      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >      pc_q35_machine_4_1_options(m);
> > -    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
> > +    pcmc->no_versioned_cpu_model = true;
> >      /*
> >       * This is the default machine for the 4.0-stable branch. It is basically
> >       * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
> > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > index 1b0671c523..e8c827c1da 100644
> > --- a/hw/i386/x86-common.c
> > +++ b/hw/i386/x86-common.c
> > @@ -66,15 +66,13 @@ out:
> >      object_unref(cpu);
> >  }
> >  
> > -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> > +void x86_cpus_init(X86MachineState *x86ms)
> >  {
> >      int i;
> >      const CPUArchIdList *possible_cpus;
> >      MachineState *ms = MACHINE(x86ms);
> >      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> >  
> > -    x86_cpu_set_default_version(default_cpu_version);
> > -
> >      /*
> >       * Calculates the limit to CPU APIC ID values
> >       *
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 103b54301f..477960275e 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -92,9 +92,6 @@ struct PCMachineClass {
> >  
> >      /* Compat options: */
> >  
> > -    /* Default CPU model version.  See x86_cpu_set_default_version(). */
> > -    int default_cpu_version;
> > -
> >      /* ACPI compat: */
> >      bool has_acpi_build;
> >      int pci_root_uid;
> > @@ -125,6 +122,9 @@ struct PCMachineClass {
> >       * check for memory.
> >       */
> >      bool broken_32bit_mem_addr_check;
> > +
> > +    /* whether the machine supports versioned cpu models */
> > +    bool no_versioned_cpu_model;
> >  };
> >  
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> > index d43cb3908e..2d2b987fa1 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -114,7 +114,7 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
> >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >                                      unsigned int cpu_index);
> >  
> > -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> > +void x86_cpus_init(X86MachineState *pcms);
> >  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
> >  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >                        DeviceState *dev, Error **errp);
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2da2cf36fd..e5c8dd98d0 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -5624,30 +5624,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
> >      },
> >  };
> >  
> > -/*
> > - * We resolve CPU model aliases using -v1 when using "-machine
> > - * none", but this is just for compatibility while libvirt isn't
> > - * adapted to resolve CPU model versions before creating VMs.
> > - * See "Runnability guarantee of CPU models" at
> > - * docs/about/deprecated.rst.
> > - */
> > -X86CPUVersion default_cpu_version = 1;
> > -
> > -void x86_cpu_set_default_version(X86CPUVersion version)
> > +static bool no_cpu_alias;
> > +void x86_cpu_set_legacy_version(void)
> >  {
> > -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
> > -    assert(version != CPU_VERSION_AUTO);
> > -    default_cpu_version = version;
> > +    no_cpu_alias = true;
> >  }
> >  
> >  /* Return the actual version being used for a specific CPU model */
> >  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
> >  {
> > -    X86CPUVersion v = model->version;
> > -    if (v == CPU_VERSION_AUTO) {
> > -        v = default_cpu_version;
> > -    }
> > -    return v;
> > +    return model->version;
> >  }
> >  
> >  static const Property max_x86_cpu_properties[] = {
> > @@ -6251,10 +6237,15 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
> >      if (!cc->model || !cc->model->is_alias) {
> >          return NULL;
> >      }
> > -    version = x86_cpu_model_resolve_version(cc->model);
> > -    if (version <= 0) {
> > +
> > +    if (no_cpu_alias) {
> > +        /* legacy cpu models do not support cpu aliases */
> >          return NULL;
> >      }
> > +
> > +    version = x86_cpu_model_resolve_version(cc->model);
> > +    assert(version);
> > +
> >      return x86_cpu_versioned_model_name(cc->model->cpudef, version);
> >  }
> >  
> > @@ -6268,11 +6259,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
> >      g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
> >  
> >      if (!desc && alias_of) {
> > -        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
> > -            desc = g_strdup("(alias configured by machine type)");
> > -        } else {
> > -            desc = g_strdup_printf("(alias of %s)", alias_of);
> > -        }
> > +        desc = g_strdup_printf("(alias of %s)", alias_of);
> >      }
> >      if (!desc && cc->model && cc->model->note) {
> >          desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
> > @@ -6375,13 +6362,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
> >      } else {
> >          info->deprecated = false;
> >      }
> > -    /*
> > -     * Old machine types won't report aliases, so that alias translation
> > -     * doesn't break compatibility with previous QEMU versions.
> > -     */
> > -    if (default_cpu_version != CPU_VERSION_LEGACY) {
> > -        info->alias_of = x86_cpu_class_get_alias_of(cc);
> > -    }
> > +
> > +    info->alias_of = x86_cpu_class_get_alias_of(cc);
> >  
> >      QAPI_LIST_PREPEND(*cpu_list, info);
> >  }
> > @@ -6553,10 +6535,6 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
> >      const X86CPUVersionDefinition *vdef;
> >      X86CPUVersion version = x86_cpu_model_resolve_version(model);
> >  
> > -    if (version == CPU_VERSION_LEGACY) {
> > -        return;
> > -    }
> > -
> >      for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
> >          PropValue *p;
> >  
> > @@ -6583,10 +6561,6 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
> >      X86CPUVersion version = x86_cpu_model_resolve_version(model);
> >      const CPUCaches *cache_info = model->cpudef->cache_info;
> >  
> > -    if (version == CPU_VERSION_LEGACY) {
> > -        return cache_info;
> > -    }
> > -
> >      for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
> >          if (vdef->cache_info) {
> >              cache_info = vdef->cache_info;
> > @@ -6718,7 +6692,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
> >      /* Unversioned model: */
> >      m = g_new0(X86CPUModel, 1);
> >      m->cpudef = def;
> > -    m->version = CPU_VERSION_AUTO;
> > +    m->version = 1;
> >      m->is_alias = true;
> >      x86_register_cpu_model_type(def->name, m);
> >  
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 113cf10aea..ee1edaa987 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2739,23 +2739,9 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
> >  void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
> >                                     TPRAccess access);
> >  
> > -/* Special values for X86CPUVersion: */
> > -/*
> > - * Resolve to version defined by current machine type.
> > - * See x86_cpu_set_default_version()
> > - */
> > -#define CPU_VERSION_AUTO   -2
> > -
> > -/* Don't resolve to any versioned CPU models, like old QEMU versions */
> > -#define CPU_VERSION_LEGACY  0
> > -
> >  typedef int X86CPUVersion;
> >  
> > -/*
> > - * Set default CPU model version for CPU models having
> > - * version == CPU_VERSION_AUTO.
> > - */
> > -void x86_cpu_set_default_version(X86CPUVersion version);
> > +void x86_cpu_set_legacy_version(void);
> >  
> >  #ifndef CONFIG_USER_ONLY
> >  
> > -- 
> > 2.45.2  
> 


