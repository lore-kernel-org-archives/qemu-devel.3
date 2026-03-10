Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640CDFCC9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzu5B-0001NG-0Q; Tue, 10 Mar 2026 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzu57-0001MU-Jb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzu54-0007i2-0v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773137567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmpqQ0M10n/r79GzYO9D+cfRWnMPUDUrByU+ta7N4aI=;
 b=JR6v9MidvyIxonJlaJ3UFEqu8lv8fImH91zFPB24ufVUI2WFwYatW6yGAWx9gtQeOOCiGz
 wUkILXpSkSeXBfdBSIyqhriyCUNGsWlzTo9b5JQrNTMEn/Sl5EWOjOL77moNwSvZ+bqQIf
 z8BIJSjcwKz3Y3lI2mBRVreHgkUX5Rw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-EjZQvDhBM--MLCECAo4viw-1; Tue, 10 Mar 2026 06:12:46 -0400
X-MC-Unique: EjZQvDhBM--MLCECAo4viw-1
X-Mimecast-MFC-AGG-ID: EjZQvDhBM--MLCECAo4viw_1773137565
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35984ef203bso9362888a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773137565; x=1773742365; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmpqQ0M10n/r79GzYO9D+cfRWnMPUDUrByU+ta7N4aI=;
 b=bHevpjp3M9u93+vJLAEQSOhVbcOYeXgwMCUYhxMzflZ74PyLtqcRFZIBUqvj38AHgK
 N9lkqVKZsWMJcDAzi/3TlJHln9NjtPTc5n5Roe6k67nMCS8JtvHkX6HwCKMuFEPtEjrs
 rDH0ZnrGf3JsfZJWALgzXGzUknXpUy9sn+DJ+wMOIyl/wK2ibX9W/h4QTi9xJ2zslOLP
 kLY0u8rEBkfMnG1+7EqI+PKVVVip2f5C3L8DvDNA4z8Pic4Ldr72KbGkiNEcgHJMQYPB
 9azTtSubPxSZHnBS+bPaTrwlniSg4DtCzMnVhSCfkKj3tXZ+skAcW3wVpRLHlTWlrdsC
 Xidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137565; x=1773742365;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmpqQ0M10n/r79GzYO9D+cfRWnMPUDUrByU+ta7N4aI=;
 b=k9jBzgpL8bzP4bidXHuMGjyXHbMRkomzpDl21Vup+A5mhxvqfAMbHhFsE4d4NfyADL
 5sM40rG2LolpOtn1vx7jsZtWygFzelq+7olh63KJ7X0iOdQbVusGz/9aHE6X8rR/mf7e
 5iukKfPguZbtpOLFHL68iHkyUX80zg7YUMyB6YUXvtWG3Dmy6zAMeuNCNSGqE8WN+mC+
 hV3x7J6cCEpDdsH6bkVWCQ3ivv624jmjIJePIFTfWYy8kkPw3HmhFOB/mJUBlD1EQOgO
 PxENHdTvZ+R/dRC8xwe29YzEPrTeDpeAyzlTG31Et3g9GnY/vrTQD/cCjWbwLSBfZsY3
 bDFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH2LR4VOMQhS3yxLyumqwsYyFhNx0j/uvuOjamMcNwrNgYhPrCmrSt1rR2ot2GY9UeNEmsCQ44/8gC@nongnu.org
X-Gm-Message-State: AOJu0YzuwKoW62U/sL4vE1zXJrT3ctR7QdLAKQ52MPWk5XW73r4vymga
 GXuvLfUvMUReQHRRET1HY9fyM0xuZ+On73MukSaZ+0IyJAPNvS5+BbzwZ80a507LZnFLAM7VY4m
 bBUrM6bhXHLS2BL5AaPVo82x66LJ3BSfhlTTy0rYVNoXHUoNBcVrJpVY3
X-Gm-Gg: ATEYQzyiLN1l+k+WfZKuY+ErBnJ2/O8th6H0ipRUd75nrZw0+rBGw/hBPi7j2q7P2Uk
 /Gs0J4cNMGI9U43iIIgo0b8cccx8jPWdRwfRijTwjXAuBPUe8jxQ81v0iznNHakxjYFMvPq0NL4
 819ZshqlQZ50NV1YdlEUUDX2rfuBo/V1UGU9yxP9oUWyLdQQ4m1Taw/GvOPq9GjjqFGfSNi024m
 9GucViCPDoyBoXjwM2iQIpjMe4PiEtJhRcq6lyk2Z81Cg+m1YkSpU6orfDeXNnPz7yQ/CwvrddO
 obNvvapxcvTkK7ISTbJuP6B0ZXOfQoTGNUbNTgsUMnT3UirgjNRFgDvo1JFGrcofcy4Kf0FVPws
 7s7Dx9c2FIiIq9oocNLX8LiP8TO5NshlqROqcCpycFT3S3Dcnkua7FhutnaddmtoXpIrlDS1+Yb
 o=
X-Received: by 2002:a17:902:e847:b0:2ae:a683:c0dc with SMTP id
 d9443c01a7336-2aea683c4b4mr15329295ad.33.1773137565219; 
 Tue, 10 Mar 2026 03:12:45 -0700 (PDT)
X-Received: by 2002:a17:902:e847:b0:2ae:a683:c0dc with SMTP id
 d9443c01a7336-2aea683c4b4mr15329035ad.33.1773137564747; 
 Tue, 10 Mar 2026 03:12:44 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83eafc64sm197180315ad.40.2026.03.10.03.12.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Mar 2026 03:12:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
Date: Tue, 10 Mar 2026 15:42:29 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
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



> On 10 Mar 2026, at 3:35=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>=20
> On 2026-03-10 15:04, Ani Sinha wrote:
>>> On 10 Mar 2026, at 2:38=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>>> On 2026-03-10 14:24, Ani Sinha wrote:
>>>>> On 10 Mar 2026, at 2:09=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>>>>> Hi Ani and Paolo,
>>>>> We have tested the code by applying both the original commit =
(98884e0cc10997a17ce9abfd6ff10be19224ca6a) and your fix patch (commit =
9e5a6945181d4c1fce7f8438e1b6213f1eb79c14) on ppc64le.
>>>>> However, the issue persists. We've conducted GDB debugging that =
shows the hang is occurring in a different location than what the fix =
addresses.
>>>>> Since the original patch is breaking KVM guest bringup completely =
on ppc64le, and the fix patch does not resolve the issue, given the =
severity of this regression (complete KVM breakage on ppc64le), we =
should either find a quick fix or consider reverting the patch until a =
proper solution can be identified.
>>>> Based on what you just described, it does not seem like the issue =
is
>>>> related to 98884e0cc10997a17ce9abfd6ff10be19224ca6a at all. If you
>>>> revert this patch in your local tree, can you confirm that your =
issue
>>>> gets fixed?
>>> Yes, the issue is not seen with the immediate previous commit:
>>> commit df8df3cb6b743372ebb335bd8404bc3d748da350 (ani-df8df3cb)
>>> Author: Ani Sinha <anisinha@redhat.com>
>>> Date:   Wed Feb 25 09:19:09 2026 +0530
>>>   system/physmem: add helper to reattach existing memory after KVM =
VM fd change
>>>   After the guest KVM file descriptor has changed as a part of the =
process of
>>>   confidential guest reset mechanism, existing memory needs to be =
reattached to
>>>   the new file descriptor. This change adds a helper function =
ram_block_rebind()
>>>   for this purpose. The next patch will make use of this function.
>>>   Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>   Link: =
https://lore.kernel.org/r/20260225035000.385950-5-anisinha@redhat.com
>>>   Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Looks like the next patch is enabling the functionality of the =
previous patches in such a way which causes bql_lock() to get stuck on =
architectures (ppc64le in this case) which does not support this feature =
yet.
>> This theory is not substantiated by code or evidence.
>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a introduces kvm_reset_vmfd()
>> which is called by this block of code with the tip at
>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a :
>>   if (!cpus_are_resettable() &&
>>        (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>>         reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
>>        if (ac->rebuild_guest) {
>>            ret =3D ac->rebuild_guest(current_machine);
>>            if (ret < 0) {
>>                error_report("unable to rebuild guest: %s(%d)",
>>                             strerror(-ret), ret);
>>                vm_stop(RUN_STATE_INTERNAL_ERROR);
>>            } else {
>>                info_report("virtual machine state has been rebuilt =
with new "
>>                            "guest file handle.");
>>                guest_state_rebuilt =3D true;
>>            }
>>        } else if (!cpus_are_resettable())  {
>>            error_report("accelerator does not support reset!");
>>        } else {
>>            error_report("accelerator does not support rebuilding =
guest state,"
>>                         " proceeding with normal reset!");
>>        }
>>    }
>> If cpus are resettable, this block will not be called and nothing =
that
>> the patch introduces will have been executed.
>> So I think you guys need to explain a bit more why you so strongly
>> feel this patch broke it. I am confused and unable to reason this.
>>> Did you validate your patches on other architectures which does not =
support this feature yet?
>> As you have already seen, on other architectures, the entire block of
>> code is not executed at all. Only SEV-ES, SEV-SNP and TDX currently
>> exercises this.
>=20
> I understand your concern about the code path analysis. Let me clarify =
our findings with concrete evidence.
>=20
> Reproducibility Evidence:
> With commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a applied, we are =
able to reproduce the hang issue 100% of the time across multiple test =
runs. When we revert to the previous commit =
df8df3cb6b743372ebb335bd8404bc3d748da350, the same KVM guest boots =
successfully 100% of the time.
>=20
> This consistent reproducibility strongly indicates that commit =
98884e0cc10997a17ce9abfd6ff10be19224ca6a is introducing the regression, =
even if the code path analysis suggests otherwise. This suggests the =
issue may not be in the code path, but rather in the changes introduced =
by the patch series.
>=20
> As the author who led the development of this patch series, we would =
appreciate your help in figuring out this issue.

I am really not sure what changes in that patch can cause this breakage =
in a completely unrelated area when the changes are not even executed.

>=20
>>>>> Analysis:
>>>>> 1. This is not a confidential guest. This is a regular KVM guest =
running on ppc64le.
>>>>> 2. The execution flow shows that qemu_system_reset() completes =
successfully and never enters the code path at line 529-543
>>>> This is what I expected and therefore, no code related to coco =
guest
>>>> rebuilding is getting executed. Your issue seems to be somewhere =
else.
>>> The issue occurs only with the introduction of this patch and not =
with the previous upstream commit as explained above.
>>>>> 3. The hang occurs later in qemu_default_main() at =
system/main.c:49, after calling bql_lock()
>>>>> 4. The ppc KVM guest boots fine with the previous commit - =
df8df3cb6b743372ebb335bd8404bc3d748da350
>>>>> 5. This suggests the issue is not with error handling of =
-EOPNOTSUPP during reset, but bql_lock() getting stuck in =
qemu_default_main()
>>>>> GDB Trace Analysis:
>>>>> We set breakpoints at qemu_system_reset() and qemu_default_main() =
to trace the execution flow. The system successfully completes =
qemu_system_reset() without entering the problematic code path where the =
fix provided by you applies (system/runstate.c:529-543).
>>>>> # gdb --args /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 =
-machine pseries,accel=3Dkvm -enable-kvm -m 32768 -smp =
32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device =
virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2=
,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 -device =
scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev =
bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0
>>>>> (gdb) handle SIGUSR1 pass nostop noprint
>>>>> Signal        Stop Print Pass to program Description
>>>>> SIGUSR1       No No Yes User defined signal 1
>>>>> (gdb) b qemu_system_reset
>>>>> Breakpoint 1 at 0x69a688: file ../system/runstate.c, line 510.
>>>>> (gdb) b qemu_default_main
>>>>> Breakpoint 2 at 0xa9aeb8: file ../system/main.c, line 45.
>>>>> (gdb) r
>>>>> Starting program: /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 =
-machine pseries,accel=3Dkvm -enable-kvm -m 32768 -smp =
32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device =
virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2=
,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 -device =
scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev =
bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0
>>>>> Thread 1 "qemu-system-ppc" hit Breakpoint 1, qemu_system_reset =
(reason=3Dreason@entry=3DSHUTDOWN_CAUSE_NONE) at =
../system/runstate.c:513
>>>>> 513     AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>>>>> (gdb) n
>>>>> 517     mc =3D current_machine ? =
MACHINE_GET_CLASS(current_machine) : NULL;
>>>>> (gdb) n
>>>>> 519     cpu_synchronize_all_states();
>>>>> (gdb) n
>>>>> 521     switch (reason) {
>>>>> (gdb) n
>>>>> 529     if (!cpus_are_resettable() &&
>>>>> (gdb) n
>>>>> 553     if (mc && mc->reset) {
>>>>> (gdb) n
>>>>> 554         mc->reset(current_machine, type);
>>>>> (gdb) n
>>>>> 558     switch (reason) {
>>>>> (gdb) n
>>>>> 574     if (cpus_are_resettable()) {
>>>>> (gdb) n
>>>>> 583             cpu_synchronize_all_post_reset();
>>>>> (gdb) n
>>>>> 587     vm_set_suspended(false);
>>>>> (gdb) n
>>>>> qdev_machine_creation_done () at ../hw/core/machine.c:1814
>>>>> 1814    register_global_state();
>>>>> (gdb) n
>>>>> qemu_machine_creation_done (errp=3D0x10123e028 <error_fatal>) at =
../system/vl.c:2785
>>>>> 2785    if (machine->cgs && !machine->cgs->ready) {
>>>>> (gdb) n
>>>>> 2791    foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
>>>>> (gdb) n
>>>>> 2793    if (!vga_interface_created && !default_vga &&
>>>>> (gdb) n
>>>>> qmp_x_exit_preconfig (errp=3Derrp@entry=3D0x10123e028 =
<error_fatal>) at ../system/vl.c:2815
>>>>> 2815    if (loadvm) {
>>>>> (gdb) n
>>>>> 2820    if (replay_mode !=3D REPLAY_MODE_NONE) {
>>>>> (gdb) n
>>>>> 2824    if (incoming) {
>>>>> (gdb) n
>>>>> 2837    } else if (autostart) {
>>>>> (gdb) n
>>>>> 2838        qmp_cont(NULL);
>>>>> (gdb) n
>>>>> qemu_init (argc=3D<optimized out>, argv=3D<optimized out>) at =
../system/vl.c:3849
>>>>> 3849    qemu_init_displays();
>>>>> (gdb) n
>>>>> 3850    accel_setup_post(current_machine);
>>>>> (gdb) n
>>>>> 3851    if (migrate_mode() !=3D MIG_MODE_CPR_EXEC) {
>>>>> (gdb) n
>>>>> 3852        os_setup_post();
>>>>> (gdb) n
>>>>> 3854    resume_mux_open();
>>>>> (gdb) n
>>>>> main (argc=3D<optimized out>, argv=3D<optimized out>) at =
../system/main.c:84
>>>>> 84      bql_unlock();
>>>>> (gdb) n
>>>>> 85      replay_mutex_unlock();
>>>>> (gdb) n
>>>>> 87      if (qemu_main) {
>>>>> (gdb) n
>>>>> 93          qemu_default_main(NULL);
>>>>> (gdb) n
>>>>> Thread 1 "qemu-system-ppc" hit Breakpoint 2, qemu_default_main =
(opaque=3Dopaque@entry=3D0x0) at ../system/main.c:48
>>>>> 48      replay_mutex_lock();
>>>>> (gdb) n
>>>>> 49      bql_lock();
>>>>> (gdb) n
>>>>> <hangs>
>>>>> <system becomes unresponsive at this point>
>>>>> Thanks,
>>>>> Misbah Anjum N <misanjumn@ibm.com>
>>>>> On 2026-03-09 18:53, Ani Sinha wrote:
>>>>>> Yes seems this is an issue and I will fix it. Not sure if the fix =
will
>>>>>> address your issue though ...
>>>>>> Can you try the following patch?
>>>>>> =46rom 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14 Mon Sep 17 =
00:00:00 2001
>>>>>> From: Ani Sinha <anisinha@redhat.com>
>>>>>> Date: Mon, 9 Mar 2026 18:44:40 +0530
>>>>>> Subject: [PATCH] Fix reset for non-x86 archs that do not support =
reset yet
>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>> ---
>>>>>> system/runstate.c | 4 +++-
>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>> diff --git a/system/runstate.c b/system/runstate.c
>>>>>> index eca722b43c..c1f41284c9 100644
>>>>>> --- a/system/runstate.c
>>>>>> +++ b/system/runstate.c
>>>>>> @@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause =
reason)
>>>>>>       (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {
>>>>>>       if (ac->rebuild_guest) {
>>>>>>           ret =3D ac->rebuild_guest(current_machine);
>>>>>> -            if (ret < 0) {
>>>>>> +            if (ret < 0 && ret !=3D -EOPNOTSUPP) {
>>>>>>               error_report("unable to rebuild guest: %s(%d)",
>>>>>>                            strerror(-ret), ret);
>>>>>>               vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>>>> +            } else if (ret =3D=3D -EOPNOTSUPP) {
>>>>>> +                error_report("accelerator does not support =
reset!");
>>>>>>           } else {
>>>>>>               info_report("virtual machine state has been rebuilt =
with new "
>>>>>>                           "guest file handle.");
>>>>>> --
>>>>>> 2.42.0
>>>>>>> Is this a confidential guest that cannot be normally reset?



