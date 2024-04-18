Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2607CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUqU-0005Jn-QF; Thu, 18 Apr 2024 12:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxUqJ-0005HH-VB
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxUqH-0003uD-Ue
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713458549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0mqkYMfD1nly8dYRIAknhG6DxWIVujhqX2MkNyMuYWs=;
 b=Gt15ZngZU/xwOtGi9D0vTEZAxQiqibeMeBMFXq0lTyC0Ha0lcySFeFeb0QPSHTWnXlQgZA
 +GyFnu0gUrIo67/QTQgv9LW7Mwb7166rKDvBl16WiNkjylvNhJlfp/jaGrFV9BL1ctk2it
 yGhEzE/af7sUddCkyhyFI1PgKXtGZLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-WJp2aOgZO8Wt3bb3AJpmAg-1; Thu, 18 Apr 2024 12:42:28 -0400
X-MC-Unique: WJp2aOgZO8Wt3bb3AJpmAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B89A618065AE
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:42:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE50040357A7;
 Thu, 18 Apr 2024 16:42:26 +0000 (UTC)
Date: Thu, 18 Apr 2024 17:42:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZiFNcLYyha3_teDT@redhat.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411121434.253353-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
> 
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.
> 
> For now, KVM always returns 0 when the guest requests the value of
> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> these MSRs dynamically in userspace.
> 
> To limit the amount of system calls for every MSR call, create a new
> thread in QEMU that updates the "virtual" MSR values asynchronously.
> 
> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> thread updates the vMSR values with the ratio of energy consumed of
> the whole physical CPU package the vCPU thread runs on and the
> thread's utime and stime values.
> 
> All other non-vCPU threads are also taken into account. Their energy
> consumption is evenly distributed among all vCPUs threads running on
> the same physical CPU package.
> 
> To overcome the problem that reading the RAPL MSR requires priviliged
> access, a socket communication between QEMU and the qemu-vmsr-helper is
> mandatory. You can specified the socket path in the parameter.
> 
> This feature is activated with -accel kvm,rapl=true,path=/path/sock.sock
> 
> Actual limitation:
> - Works only on Intel host CPU because AMD CPUs are using different MSR
>   adresses.
> 
> - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
>   the moment.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  accel/kvm/kvm-all.c           |  27 +++
>  docs/specs/index.rst          |   1 +
>  docs/specs/rapl-msr.rst       | 155 ++++++++++++
>  include/sysemu/kvm.h          |   2 +
>  include/sysemu/kvm_int.h      |  32 +++
>  target/i386/cpu.h             |   8 +
>  target/i386/kvm/kvm-cpu.c     |   9 +
>  target/i386/kvm/kvm.c         | 428 ++++++++++++++++++++++++++++++++++
>  target/i386/kvm/meson.build   |   1 +
>  target/i386/kvm/vmsr_energy.c | 335 ++++++++++++++++++++++++++
>  target/i386/kvm/vmsr_energy.h |  99 ++++++++
>  11 files changed, 1097 insertions(+)
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
> 

> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c791b7b0520..eafb625839b8 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -50,6 +50,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                     MSR_IA32_UCODE_REV);
>          }
>      }
> +
> +    if (kvm_is_rapl_feat_enable(cs)) {
> +        if (!IS_INTEL_CPU(env)) {
> +            error_setg(errp, "RAPL feature can only be\
> +                              enabled with Intel CPU models");
> +                return false;
> +        }
> +    }

I see a crash in kvm_is_rapl_feat_enable() from this caller,
when I run with this kind of command line:

 $ qemu-system-x86_64 \
      -kernel /lib/modules/6.6.9-100.fc38.x86_64/vmlinuz \
      -initrd tiny-initrd.img  -m 2000 -serial stdio -nodefaults \
      -display none -accel kvm -append "console=ttyS0 quiet"


#0  0x0000555555bc14b7 in kvm_is_rapl_feat_enable (cs=cs@entry=0x555557b83470) at ../target/i386/kvm/kvm.c:2531
#1  0x0000555555bc7534 in kvm_cpu_realizefn (cs=0x555557b83470, errp=0x7fffffffd2a0) at ../target/i386/kvm/kvm-cpu.c:54
#2  0x0000555555d2432a in accel_cpu_common_realize (cpu=0x555557b83470, errp=0x7fffffffd2a0) at ../accel/accel-target.c:130
#3  0x0000555555cdd955 in cpu_exec_realizefn (cpu=cpu@entry=0x555557b83470, errp=errp@entry=0x7fffffffd2a0) at ../cpu-target.c:137
#4  0x0000555555c14b89 in x86_cpu_realizefn (dev=0x555557b83470, errp=0x7fffffffd310) at ../target/i386/cpu.c:7320
#5  0x0000555555d58f4b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffd390) at ../hw/core/qdev.c:510
#6  0x0000555555d5d78d in property_set_bool (obj=0x555557b83470, v=<optimized out>, name=<optimized out>, opaque=0x5555578558e0, errp=0x7fffffffd390)
    at ../qom/object.c:2358
#7  0x0000555555d60b0b in object_property_set (obj=obj@entry=0x555557b83470, name=name@entry=0x55555607c799 "realized", v=v@entry=0x555557b8ccb0, errp=0x7fffffffd390, 
    errp@entry=0x555556e210d8 <error_fatal>) at ../qom/object.c:1472
#8  0x0000555555d6444f in object_property_set_qobject
    (obj=obj@entry=0x555557b83470, name=name@entry=0x55555607c799 "realized", value=value@entry=0x555557854800, errp=errp@entry=0x555556e210d8 <error_fatal>)
    at ../qom/qom-qobject.c:28
#9  0x0000555555d61174 in object_property_set_bool
    (obj=0x555557b83470, name=name@entry=0x55555607c799 "realized", value=value@entry=true, errp=errp@entry=0x555556e210d8 <error_fatal>) at ../qom/object.c:1541
#10 0x0000555555d59a3c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x555556e210d8 <error_fatal>) at ../hw/core/qdev.c:292
#11 0x0000555555bd51e0 in x86_cpu_new (x86ms=<optimized out>, apic_id=0, errp=0x555556e210d8 <error_fatal>) at ../hw/i386/x86.c:105
#12 0x0000555555bd52ce in x86_cpus_init (x86ms=x86ms@entry=0x555557aaed30, default_cpu_version=<optimized out>) at ../hw/i386/x86.c:156
#13 0x0000555555bdc1a7 in pc_init1 (machine=0x555557aaed30, pci_type=0x55555604aa61 "i440FX") at ../hw/i386/pc_piix.c:185
#14 0x0000555555947a11 in machine_run_board_init (machine=0x555557aaed30, mem_path=<optimized out>, errp=<optimized out>, errp@entry=0x555556e210d8 <error_fatal>)
    at ../hw/core/machine.c:1547
#15 0x0000555555b020ed in qemu_init_board () at ../system/vl.c:2613
#16 qmp_x_exit_preconfig (errp=0x555556e210d8 <error_fatal>) at ../system/vl.c:2705
#17 0x0000555555b0611e in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../system/vl.c:3739
#18 0x0000555555897ca9 in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:47

The problem is that 'cs->kvm_state' is NULL here

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


