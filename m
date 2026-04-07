Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E09BFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVq-0007Rb-Cz; Tue, 07 Apr 2026 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wABTT-0002LR-1E
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wA6ku-0005oz-Dp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 09:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775569569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/h9fZL0HKWrWy8FI0axLGgXM+deGAqNjX4ay6h62es=;
 b=AeLJbICMm0g75GKrf6QAorpyeSbzgeNdz8BxN8bn8P3XH9bEAFXYFPuK4RzjGte63ggW+a
 aBCL8m3kUbP1GNalElulnGzOIcBAqp5EjhWGL/SnEnHjDRMjVl+vHiMmx3efDdLNkFBU+n
 oz8FHxOUsFGdq8mY6Mw980KbnbXCgNw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-nmB6zry6Pt2ioqIkD4KE5Q-1; Tue, 07 Apr 2026 09:46:08 -0400
X-MC-Unique: nmB6zry6Pt2ioqIkD4KE5Q-1
X-Mimecast-MFC-AGG-ID: nmB6zry6Pt2ioqIkD4KE5Q_1775569567
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d90c7ec5aso12486673a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775569567; x=1776174367; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/h9fZL0HKWrWy8FI0axLGgXM+deGAqNjX4ay6h62es=;
 b=UawryWfhTC3nm9ZfqEtOD8J2Ox0fJbmje5KarMfoM8Nidk8hshF97C6h7H2qEXMniB
 MzuFCVAmzh8YwjWUEuvEGG1yqRl5T763bmDajLWTiaQFP2NzjIeHLFBJCgjw+lXUDS/9
 HKvIV/FQumVoXP7hZLKFlNZZ+ZvSrs0BVrIs/jSP3A2Q8dBtblEyP4gJ6Q4rxFsdcLSE
 +b29x4MJ+RF3MNKvtEbguwZK42Uty3iGaVcBIPP2cWtbqVSHA8xM0+goRG01wyXYXIV1
 wTCrs4E03+9S0PeyU7tIQk+PrKSpKGxUw5AlcG/rQ3o2SbUxKM+HP2vumkZFKh/wSDSK
 a1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775569567; x=1776174367;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/h9fZL0HKWrWy8FI0axLGgXM+deGAqNjX4ay6h62es=;
 b=OgxZXTM/5f9n7ldNTBZPvI+s2eEc3B1fwBeJVFPUEUMm/u1NeZ1pRj1RNxym4bMrh4
 +GcbiGPfVtoIU+5bPiz/aXbpwXKCdp+OoSaxjb0KZWEx8PdqvxKV0DXxrjlZIRpuMj6+
 XZgyYfkhZcD9L/qEjjmWhTHfvcJq3za2EoxK8Z7USFaGqzA4WCE2F1fIfJDzQ4G3R9zl
 Cmo8uMTCCpDmzqOMTcFpg08KIRd7VT5QUuJpQ+9FjOGVjEDE95ww0Vm1U4cbO/ND3sTA
 HBrCb7UTdYiADlttbtsKt53it1uVMijRpYbsXGIxRKPo7/PKmscoTtKge3nS73fLIcoM
 tApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOVQOURqaQvPKde1eqIDC6clns5rJ9YpBOKe0INdFRowJ8sr4BWivgByPd5ofU1Mifh+AH3sNXUltK@nongnu.org
X-Gm-Message-State: AOJu0YwLxUyhOUd6oXJX8B1+SviH/RDascrD/0yp9V2z1EhdrmjdBzkV
 zv3aDZRmVBxovA9I722YjlZp5v1otN6aF2I52cnlJBowQmiZluUyxucJBSHI9HhXtPJEzBGg07K
 Oz8FyWmHtdp+EMpadjkLWtzhR6HcyAfxNwVuAmsngmCx1AVvbRdghBusC
X-Gm-Gg: AeBDieubI3IjRaqv+RpC+1By/1FhvsqANDv6njIRiLwQhjtiVghhuaoqcgYTAXpfv8V
 svbSrmvlVOtKwby/5qchZyYPVdSyS+P69KT/u40EXivQVgHRh7XFnBdzHKpgda3XsEbFsiX+0Xl
 XNPTa1/b4Bt1jiwLIPFfgDfHljWD3207KDrajM/JaVUGfoojtIjE/RhtwIt6Z3JnpqaD2L2xR0a
 yDl/87zSQDIPxcWf9ZgAaZeoymBHG2F5VKB76d57Dgls98h961l0SK4al+uaENPb+jg16QcbwEs
 8Xnd44Tqlqcnwtdryn5GuDSfjrA3FwJN3ZEHnyI+9HqoRvM2FY/Qhh5nvUE/DUMMT+rOW/fbRpS
 rCPv488GWCiu7asOQYgoP3zvlIkLRo2xxOK978saAlkgs7om4JRccgpnVz0pz4vz8LEzvt/JqjQ
 I=
X-Received: by 2002:a17:90a:d605:b0:35b:929f:7e95 with SMTP id
 98e67ed59e1d1-35de6790a94mr16067248a91.4.1775569566704; 
 Tue, 07 Apr 2026 06:46:06 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:35b:929f:7e95 with SMTP id
 98e67ed59e1d1-35de6790a94mr16067199a91.4.1775569566106; 
 Tue, 07 Apr 2026 06:46:06 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd36a1d04sm22645660a91.17.2026.04.07.06.46.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Apr 2026 06:46:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1014F925-4992-459B-B5B4-E6CCAC7FBC02@redhat.com>
Date: Tue, 7 Apr 2026 19:15:50 +0530
Cc: Pbonzini <pbonzini@redhat.com>, Qemu Devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ABE1EB8-3753-4A73-ADB7-8FFB579A35EB@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
 <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
 <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
 <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
 <1014F925-4992-459B-B5B4-E6CCAC7FBC02@redhat.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 7 Apr 2026, at 9:39=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 6 Apr 2026, at 2:24=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>>=20
>> Hi Ani,
>> I've completed the testing you suggested. Unfortunately, the SMP hang =
still persists with these changes.
>>=20
>> Changes made:
>> As requested, I reverted everything in stubs/kvm.c and the related =
changes in stubs/meson.build, include/system/kvm.h, and =
target/i386/kvm/kvm.c. I also commented out the calls to =
kvm_arch_supports_vmfd_change() and kvm_arch_on_vmfd_change() in =
kvm_reset_vmfd().
>>=20
>> Test result:
>> The issue persists - guests still hang indefinitely during boot when =
SMP is configured.
>>=20
>> Git diff:
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index cc5c42ce4d..04b9cbe7c9 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2622,11 +2622,12 @@ static int kvm_reset_vmfd(MachineState *ms)
>>     * bail if the current architecture does not support VM file
>>     * descriptor change.
>>     */
>> -    if (!kvm_arch_supports_vmfd_change()) {
>> +    /*if (!kvm_arch_supports_vmfd_change()) {
>>        error_report("This target architecture does not support KVM VM =
"
>>                     "file descriptor change.");
>>        return -EOPNOTSUPP;
>>    }
>> +    */
>>=20
>>    s =3D KVM_STATE(ms->accelerator);
>>    kml =3D &s->memory_listener;
>> @@ -2659,10 +2660,10 @@ static int kvm_reset_vmfd(MachineState *ms)
>>    }
>>    assert(!err);
>>=20
>> -    ret =3D kvm_arch_on_vmfd_change(ms, s);
>> +    /*ret =3D kvm_arch_on_vmfd_change(ms, s);
>>    if (ret < 0) {
>>        return ret;
>> -    }
>> +    }*/
>>=20
>>    if (s->kernel_irqchip_allowed) {
>>        do_kvm_irqchip_create(s);
>>=20
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index 5fc7251fd9..0dad0079ed 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -456,8 +456,6 @@ int kvm_physical_memory_addr_from_host(KVMState =
*s, void *ram_addr,
>>=20
>> #endif /* COMPILING_PER_TARGET */
>>=20
>> -bool kvm_arch_supports_vmfd_change(void);
>> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>>=20
>> void kvm_cpu_synchronize_state(CPUState *cpu);
>>=20
>> diff --git a/stubs/kvm.c b/stubs/kvm.c
>> deleted file mode 100644
>> index 2db61d89a7..0000000000
>> --- a/stubs/kvm.c
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -/*
>> - * kvm target arch specific stubs
>> - *
>> - * Copyright (c) 2026 Red Hat, Inc.
>> - *
>> - * Author:
>> - *   Ani Sinha <anisinha@redhat.com>
>> - *
>> - * SPDX-License-Identifier: GPL-2.0-or-later
>> - */
>> -#include "qemu/osdep.h"
>> -#include "system/kvm.h"
>> -
>> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
>> -{
>> -    abort();
>> -}
>> -
>> -bool kvm_arch_supports_vmfd_change(void)
>> -{
>> -    return false;
>> -}
>>=20
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 6ae478bacc..8a07059500 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -74,7 +74,6 @@ if have_system
>>  if igvm.found()
>>    stub_ss.add(files('igvm.c'))
>>  endif
>> -  stub_ss.add(files('kvm.c'))
>>  stub_ss.add(files('target-get-monitor-def.c'))
>>  stub_ss.add(files('target-monitor-defs.c'))
>>  stub_ss.add(files('win32-kbd-hook.c'))
>>=20
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 524b5276a6..3dfd9a5974 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -3389,15 +3389,6 @@ static int kvm_vm_enable_energy_msrs(KVMState =
*s)
>>    return 0;
>> }
>>=20
>> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
>> -{
>> -    abort();
>> -}
>> -
>> -bool kvm_arch_supports_vmfd_change(void)
>> -{
>> -    return false;
>> -}
>>=20
>> int kvm_arch_init(MachineState *ms, KVMState *s)
>> {
>>=20
>>=20
>> I've also tested with the latest QEMU build from master, and the =
issue still persists there as well. Could you suggest what additional =
debugging steps I should take to help identify the root cause?
>=20
> Since you mentioned that 98884e0cc1 is the root of the problem, the =
intention is to bisect within this patch and find the problematic hunk. =
You reported that reverting a major part of this patch did not make a =
difference. Maybe you can try reverting the following refactoring too =
(in addition to the reverts above) and see what happens.
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 0d8b0c4347..cc5c42ce4d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2415,11 +2415,9 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> }
>=20
> -static void kvm_irqchip_create(KVMState *s)
> +static void do_kvm_irqchip_create(KVMState *s)
> {
>     int ret;
> -
> -    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>         ;
>     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
> @@ -2452,7 +2450,13 @@ static void kvm_irqchip_create(KVMState *s)
>         fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>         exit(1);
>     }
> +}
> +
> +static void kvm_irqchip_create(KVMState *s)
> +{
> +    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>=20
> +    do_kvm_irqchip_create(s);
>     kvm_kernel_irqchip =3D true;
>     /* If we have an in-kernel IRQ chip then we must have asynchronous
>      * interrupt delivery (though the reverse is not necessarily true)
>=20
> If reverting the above still shows the issue, then I think 98884e0cc1 =
is not the root cause of the issue.

Actually if you still see the issue, revert the following change as well

@@ -4015,6 +4096,7 @@ static void kvm_accel_class_init(ObjectClass *oc, =
const void *data)
     AccelClass *ac =3D ACCEL_CLASS(oc);
     ac->name =3D "KVM";
     ac->init_machine =3D kvm_init;
+    ac->rebuild_guest =3D kvm_reset_vmfd;
     ac->has_memory =3D kvm_accel_has_memory;
     ac->allowed =3D &kvm_allowed;
     ac->gdbstub_supported_sstep_flags =3D kvm_gdbstub_sstep_flags;

And then if you still see the issue, revert this too

diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e43d18a869..e4beda0148 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -14,6 +14,7 @@ kvm_destroy_vcpu(int cpu_index, unsigned long =
arch_cpu_id) "index: %d id: %lu"
 kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: =
%lu"
 kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu =
%s"
 kvm_irqchip_commit_routes(void) ""
+kvm_reset_vmfd(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s =
vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
 kvm_irqchip_release_virq(int virq) "virq %d"


Basically incrementally keep reverting until it works and at that point =
you know which hunk is the cause of the problem.


> The issue is somewhere else as we have tried reverting almost =
everything from that patch except implementation of kvm_reset_vmfd() =
which as you reported isn=E2=80=99t called/executed.
>=20
>>=20
>> Thanks,
>> Misbah Anjum N <misanjum@linux.ibm.com>
>>=20
>>=20
>> On 2026-03-18 15:00, Ani Sinha wrote:
>>> One possible thing to try is:
>>> Revert everything in stubs/kvm.c and hence changes in
>>> stubs/meson.build, include/system/kvm.h and in target/i386/kvm/kvm.c
>>> introduced by 98884e0cc1 .
>>> You will have to comment out calls to =
kvm_arch_supports_vmfd_change()
>>> and kvm_arch_on_vmfd_change() in kvm_reset_vmfd(). Since
>>> kvm_reset_vmfd() is not called anyway, not should make no difference
>>> if those calls are commented out.
>>> Let me know what you get after doing the above.



