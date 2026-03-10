Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87344EA854E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 08:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzsrF-0005Uh-Ed; Tue, 10 Mar 2026 04:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzsrB-0005Tw-JB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 04:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzsr9-0006JJ-5S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773132862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2Yxn9lTMLy3PiaYq3pDZvFHr5Z58VEF5SVsZXH134Y=;
 b=I8Wf93CC/DCXg491224Q2NPRi9StkS1x1GbuOZtd2G+c64oNHEPhBxTl3cddXOomNDnZoB
 7Qxjok/+Jnh/XfIe/QdfqJbwLWnEX2dGJ/eUNq5U+KqN8hycqSCBZADT5alSwnZ1rWOErs
 7nxcMYYKDhsqWp8eAEVv7KHZdyCJA4I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-0N5cvwnbPhyN829uIwJlIA-1; Tue, 10 Mar 2026 04:54:20 -0400
X-MC-Unique: 0N5cvwnbPhyN829uIwJlIA-1
X-Mimecast-MFC-AGG-ID: 0N5cvwnbPhyN829uIwJlIA_1773132860
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82992206d20so2676114b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773132860; x=1773737660; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2Yxn9lTMLy3PiaYq3pDZvFHr5Z58VEF5SVsZXH134Y=;
 b=O4arxUoUjEvamS6DfxoWJcFSefHmL/wLw3tBpMxcq+mEbsh97yuymtTCn0A0GQfUCG
 pOyIqreikcedlNHNrajgY+j+uOCCtCMQGmBj5HmiooRHQNvzX3Ce5cTvrW7gU0srl12x
 exSDZCPjrXZOL1LsfV0+6hNYuUDFWqGbcAIHAbDBVeaEZnVIVjWaGJjQCMWFdfRBZa4K
 pPDn6U3w+aZZd4qu3dJyjapgBfJ3YsWrxCAfqXnpic8lTKBK5Y1CpRIgEjma9u6AtBtK
 ifIQkZwC+3r7RSQIHzLhafFz5xj1bWP0VLk4Lb95U3TQLwA5iKSC9R70rHqNALlmuZlH
 RRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773132860; x=1773737660;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2Yxn9lTMLy3PiaYq3pDZvFHr5Z58VEF5SVsZXH134Y=;
 b=ZmzpxH0++8VNxzqe/VqBn3jAHSfBTAeSWKk+C6VjcVSTSV8Dv2oNI2nIFJX5xgNPQW
 Y27tDcgQr+sybYIgG0PB+86v/irwv5RUDZapR3fI5hk1nxiQYti9qqZwB4R+9O3F1TnP
 69wOlbjONa9VRMjFk6SsJVlMUn14C5fVToo6abxb+Y0ud7HNAt7f/D6m0cn7q7Euppcz
 dRdMay7n2ZTGddANd275YM5QnWukZu+DcJzTo8c5YSvwYrrtk7b1n5+Zpk3+R+MwCkjB
 GHSxzVb0Qn+3lA7JbOBsHao0XW5wznUwClv2hTcXI70/XATqMZHam1awPD3TLeCOKE7D
 +30Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZDaSWqQHyAqzVbeKNipIx2ykRS0HMccNKsov4C01THNR0zgH9Jo3tmA4UCo6iFe2jfRd+zc+y/yl2@nongnu.org
X-Gm-Message-State: AOJu0YzIqXcRqwWbzpcqklhwBgR4dCksoTTKw1XImmnl/Ly492AhZYkQ
 ENCPH9lQNrgflmyIVqCw4QATFgpm6G2u2GUFM+JW8JY6ySrw2nJD9owBwyxguHTCqFWUbiH+JQv
 2MJnlPY4gvVTw7JwyZmzHAcvADXVJJs38F+zoJ9/WVhLNRRhvnxMF0eQY
X-Gm-Gg: ATEYQzwsXoYhKA4/YljYm+4+IcmgNmYxEqzN5DJPZbJ5vk13bkn488o1+nbYsbC1egY
 RaBGjeMMmBfNo4PHqpZCU/WViG67thkRC4YnbIKNmXc5EwKeKwKtrVRxH7piLjy+bS+COliSpbP
 RLExF1zwPJuT0ZEvb5OmlCJMJGuCrl16mwEKzY8zCpl/eA6m2h+UcDuDius1xCXdB0SoNnl/4V+
 sEF04fKbqSV59I0P4Q+MkjygxK+3KjlSSczQrU6WGiyb7Ot2eblwRJP/af8pg+GqgrWUymXTKOa
 HoIAqL9g4OIxTCiHu5A/0PVLes40mVrHMhyylgowudlp34tT1Xa7bMwHhxjlVdGMrPrJzT8Sl14
 hVC5iPUdYue/OZ7uAAnRrT/JVRUIUMYKceRzfvaKzhRNY55r3E82tq0sitQ0br8fBUuthTTn8Zc
 k=
X-Received: by 2002:a05:6a00:889:b0:824:afd8:5e91 with SMTP id
 d2e1a72fcca58-829a2dc16eemr12744637b3a.10.1773132859738; 
 Tue, 10 Mar 2026 01:54:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:889:b0:824:afd8:5e91 with SMTP id
 d2e1a72fcca58-829a2dc16eemr12744625b3a.10.1773132859317; 
 Tue, 10 Mar 2026 01:54:19 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a467239asm13312930b3a.26.2026.03.10.01.54.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Mar 2026 01:54:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
Date: Tue, 10 Mar 2026 14:24:03 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 10 Mar 2026, at 2:09=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>=20
> Hi Ani and Paolo,
>=20
> We have tested the code by applying both the original commit =
(98884e0cc10997a17ce9abfd6ff10be19224ca6a) and your fix patch (commit =
9e5a6945181d4c1fce7f8438e1b6213f1eb79c14) on ppc64le.
> However, the issue persists. We've conducted GDB debugging that shows =
the hang is occurring in a different location than what the fix =
addresses.
>=20
> Since the original patch is breaking KVM guest bringup completely on =
ppc64le, and the fix patch does not resolve the issue, given the =
severity of this regression (complete KVM breakage on ppc64le), we =
should either find a quick fix or consider reverting the patch until a =
proper solution can be identified.

Based on what you just described, it does not seem like the issue is =
related to 98884e0cc10997a17ce9abfd6ff10be19224ca6a at all. If you =
revert this patch in your local tree, can you confirm that your issue =
gets fixed?

>=20
> Analysis:
> 1. This is not a confidential guest. This is a regular KVM guest =
running on ppc64le.
> 2. The execution flow shows that qemu_system_reset() completes =
successfully and never enters the code path at line 529-543

This is what I expected and therefore, no code related to coco guest =
rebuilding is getting executed. Your issue seems to be somewhere else.

> 3. The hang occurs later in qemu_default_main() at system/main.c:49, =
after calling bql_lock()
> 4. The ppc KVM guest boots fine with the previous commit - =
df8df3cb6b743372ebb335bd8404bc3d748da350
> 5. This suggests the issue is not with error handling of -EOPNOTSUPP =
during reset, but bql_lock() getting stuck in qemu_default_main()
>=20
> GDB Trace Analysis:
> We set breakpoints at qemu_system_reset() and qemu_default_main() to =
trace the execution flow. The system successfully completes =
qemu_system_reset() without entering the problematic code path where the =
fix provided by you applies (system/runstate.c:529-543).
>=20
> # gdb --args /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine =
pseries,accel=3Dkvm -enable-kvm -m 32768 -smp =
32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device =
virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2=
,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 -device =
scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev =
bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0
>=20
> (gdb) handle SIGUSR1 pass nostop noprint
> Signal        Stop Print Pass to program Description
> SIGUSR1       No No Yes User defined signal 1
> (gdb) b qemu_system_reset
> Breakpoint 1 at 0x69a688: file ../system/runstate.c, line 510.
> (gdb) b qemu_default_main
> Breakpoint 2 at 0xa9aeb8: file ../system/main.c, line 45.
> (gdb) r
>=20
> Starting program: /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 =
-machine pseries,accel=3Dkvm -enable-kvm -m 32768 -smp =
32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device =
virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2=
,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 -device =
scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev =
bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0
>=20
> Thread 1 "qemu-system-ppc" hit Breakpoint 1, qemu_system_reset =
(reason=3Dreason@entry=3DSHUTDOWN_CAUSE_NONE) at =
../system/runstate.c:513
> 513     AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
> (gdb) n
> 517     mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : =
NULL;
> (gdb) n
> 519     cpu_synchronize_all_states();
> (gdb) n
> 521     switch (reason) {
> (gdb) n
> 529     if (!cpus_are_resettable() &&
> (gdb) n
> 553     if (mc && mc->reset) {
> (gdb) n
> 554         mc->reset(current_machine, type);
> (gdb) n
> 558     switch (reason) {
> (gdb) n
> 574     if (cpus_are_resettable()) {
> (gdb) n
> 583             cpu_synchronize_all_post_reset();
> (gdb) n
> 587     vm_set_suspended(false);
> (gdb) n
> qdev_machine_creation_done () at ../hw/core/machine.c:1814
> 1814    register_global_state();
> (gdb) n
> qemu_machine_creation_done (errp=3D0x10123e028 <error_fatal>) at =
../system/vl.c:2785
> 2785    if (machine->cgs && !machine->cgs->ready) {
> (gdb) n
> 2791    foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
> (gdb) n
> 2793    if (!vga_interface_created && !default_vga &&
> (gdb) n
> qmp_x_exit_preconfig (errp=3Derrp@entry=3D0x10123e028 <error_fatal>) =
at ../system/vl.c:2815
> 2815    if (loadvm) {
> (gdb) n
> 2820    if (replay_mode !=3D REPLAY_MODE_NONE) {
> (gdb) n
> 2824    if (incoming) {
> (gdb) n
> 2837    } else if (autostart) {
> (gdb) n
> 2838        qmp_cont(NULL);
> (gdb) n
> qemu_init (argc=3D<optimized out>, argv=3D<optimized out>) at =
../system/vl.c:3849
> 3849    qemu_init_displays();
> (gdb) n
> 3850    accel_setup_post(current_machine);
> (gdb) n
> 3851    if (migrate_mode() !=3D MIG_MODE_CPR_EXEC) {
> (gdb) n
> 3852        os_setup_post();
> (gdb) n
> 3854    resume_mux_open();
> (gdb) n
> main (argc=3D<optimized out>, argv=3D<optimized out>) at =
../system/main.c:84
> 84      bql_unlock();
> (gdb) n
> 85      replay_mutex_unlock();
> (gdb) n
> 87      if (qemu_main) {
> (gdb) n
> 93          qemu_default_main(NULL);
> (gdb) n
>=20
> Thread 1 "qemu-system-ppc" hit Breakpoint 2, qemu_default_main =
(opaque=3Dopaque@entry=3D0x0) at ../system/main.c:48
> 48      replay_mutex_lock();
> (gdb) n
> 49      bql_lock();
> (gdb) n
>=20
> <hangs>
> <system becomes unresponsive at this point>
>=20
>=20
> Thanks,
> Misbah Anjum N <misanjumn@ibm.com>
>=20
>=20
>=20
> On 2026-03-09 18:53, Ani Sinha wrote:
>> Yes seems this is an issue and I will fix it. Not sure if the fix =
will
>> address your issue though ...
>> Can you try the following patch?
>> =46rom 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14 Mon Sep 17 00:00:00 =
2001
>> From: Ani Sinha <anisinha@redhat.com>
>> Date: Mon, 9 Mar 2026 18:44:40 +0530
>> Subject: [PATCH] Fix reset for non-x86 archs that do not support =
reset yet
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> system/runstate.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>> diff --git a/system/runstate.c b/system/runstate.c
>> index eca722b43c..c1f41284c9 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
>>         (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {
>>         if (ac->rebuild_guest) {
>>             ret =3D ac->rebuild_guest(current_machine);
>> -            if (ret < 0) {
>> +            if (ret < 0 && ret !=3D -EOPNOTSUPP) {
>>                 error_report("unable to rebuild guest: %s(%d)",
>>                              strerror(-ret), ret);
>>                 vm_stop(RUN_STATE_INTERNAL_ERROR);
>> +            } else if (ret =3D=3D -EOPNOTSUPP) {
>> +                error_report("accelerator does not support reset!");
>>             } else {
>>                 info_report("virtual machine state has been rebuilt =
with new "
>>                             "guest file handle.");
>> --
>> 2.42.0
>>> Is this a confidential guest that cannot be normally reset?
>=20


