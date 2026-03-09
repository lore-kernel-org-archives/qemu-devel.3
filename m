Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE81F3C24E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzahQ-0005kS-7N; Mon, 09 Mar 2026 09:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzahO-0005k8-TE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzahM-0003Gc-5K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773063063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4esKHIK2+oAbCNBAfwUHG3EtkKbG3xqBxEDPXDkf9Y=;
 b=VNjmX6uFGVhO7ZVIgYX8ryTIjMDN/dzaxc+agqv407S1JjMRJLio3tq32TVpvHhqD1SAQR
 26tOZYazENBH2mzwtw3dOc2PxqiwqorFhK89+JqHTn8XyTxzFrUweXZqdcBrm9ijNVaOnv
 tTEWmyvi39XLYN0YLAMEXQ4H3vO/25A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-7PwbZLADM1WRyUCru30zbg-1; Mon, 09 Mar 2026 09:31:01 -0400
X-MC-Unique: 7PwbZLADM1WRyUCru30zbg-1
X-Mimecast-MFC-AGG-ID: 7PwbZLADM1WRyUCru30zbg_1773063061
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ae42659a39so510876395ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773063060; x=1773667860; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4esKHIK2+oAbCNBAfwUHG3EtkKbG3xqBxEDPXDkf9Y=;
 b=eEVxju/GEa1vxg4PM78BPzlTOagUjr7E6S2JubXudxtCzn1lOqH36CA4b4MCYktHJI
 1jq4Dkb7BkMKS3vlPISdVcZp9j6sajQyIHay7vzIauT7WBahegPvYA1bNeFLKPjlHjOk
 O9qE7cl/Wkb6gbdh4Ab3BdUQwNKt8SEZx9Xg2fVSta5WB9kkF3h9hYzz2wnAzchLcZGF
 xU4hXKbJx222fDRrbY8F500rms05d2RYMvcDu2wFrovPNEGQhut6i4WdlOc+Tq1wFkUH
 5PURL1IDmQqhWYu5Q7Erj2f/qIHScXyOW54rNMNF3Fqt3wt4LYNjpY+CTRdtShd+pJP2
 Y7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773063060; x=1773667860;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4esKHIK2+oAbCNBAfwUHG3EtkKbG3xqBxEDPXDkf9Y=;
 b=Ecm+jTJjpib4MrhV1jl/f5Fz0JECPSBrX2pkHl9lM7Lr7X40j34k5ywjOTK1xokisO
 RGLKY6ik46KqXim4z5nW7VuVZTzGfxFL9nrLOgJO7AWOf8ojR2Hgq7OdokyTtJLObpj4
 9ZWfXVwcrUR8oTJWZ4zQtLSg8WyNgkmdVmFvhebzGwhbc95EmISBTVBXO9M6lI1fE2P3
 hCfb8IrFZWhOVsd26zBv334ZaQE63IMW2laYYdbg3AVJcCPikBYo8Oxkgcs5J/KV5Vef
 4AQX+vImKaIKKCAtTWAieDDvEYbmM37MmrZtpIXLg8La+fJEPvspsbKa4+VN0vbwTqt0
 +kjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKAGYJk7+Sy5XfcM+/uPFh2GZdu24vKDHYjyNgf62F2DTXr3tjAQpbxiwvwthtn5loXP2TD55/2SV7@nongnu.org
X-Gm-Message-State: AOJu0Yzh2pDjY7t+0Imhw9reVToCEzaC0nR7aVMCYRbU+4SzXhhH4ERh
 wsfrAEd9SksfOBKYBr+Aj6x62NPaBxgy6FfMyA/DbvUHHGBYeAgCxcvq1GPMFyFFqWIKXW3vAIG
 O8EUV4E2Yf1cWzEo+q61yxLlA2gOQFFZis2wzw+yTblUw6y8axbHmS2kT
X-Gm-Gg: ATEYQzzE5+Pb0CFOM1GdcnF7xXG9qQg8E8/J4grfCCgXvJndzRw4GV2tcYE1YLgrmgu
 4I5ojITJ0uiyAMT7ljVy2FenKtyKegEXH2temiSgLx34ca4WrT7qO05lDFy8KAPk7Wuoav2UKKR
 eL9KPI//JXu+auvE0QEPqFejsDZmz+ZrAEeDKafLA3XXNr5oNHnSFpVu1Liqg8m1jJtzt18CPIV
 mlXvsMuQQgFBClavKIdLrlBN7s2n6VrbSvNanw1cikgW0UrB6ZwFgNnh86BLxWrr1+1qakR6WRn
 kHBrP/2TDVskRVCBnuLXxwsgyzTUm8mxs9+KoCeHYX8WH1DRf/ijX15E4Jb+t7RhhRWa8GNtMPD
 BudzmGjUvJa6EEfTpuEIjm8brHSP6QBRBXl7kKTZb65KK2bSWFVRlr8Gp3R+ILhwedhdLRo4RMR
 c=
X-Received: by 2002:a17:902:e891:b0:2ae:59d0:bf20 with SMTP id
 d9443c01a7336-2ae82444d74mr128675415ad.31.1773063060375; 
 Mon, 09 Mar 2026 06:31:00 -0700 (PDT)
X-Received: by 2002:a17:902:e891:b0:2ae:59d0:bf20 with SMTP id
 d9443c01a7336-2ae82444d74mr128675055ad.31.1773063059936; 
 Mon, 09 Mar 2026 06:30:59 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840ccb6csm151310885ad.92.2026.03.09.06.30.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:30:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
Date: Mon, 9 Mar 2026 19:00:45 +0530
Cc: Misbah Anjum N <misanjum@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A89F6271-D17D-4D0C-8FBB-5BD820F5AC6F@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 9 Mar 2026, at 4:34=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
> Hi Ani, Paolo,
>=20
> I think the problem lies here:
>=20
> For archs which doesnt support vm fd change, we are baling out as =
below in kvm_reset_vmfd.
>=20
>=20
>    /*
>     * bail if the current architecture does not support VM file
>     * descriptor change.
>     */
>    if (!kvm_arch_supports_vmfd_change()) {
>        error_report("This target architecture does not support KVM VM =
"
>                     "file descriptor change.");
>        return -EOPNOTSUPP;
>    }
>=20
> However, when rebuild_guest (kvm_reset_vmfd) is called in
> qemu_system_reset here:
>=20
>    if ((reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>         reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
>        (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {

This entire block is only executed if either you manually enable =
new_accel_vmfd_on_reset or cpus are not resettable.
=46rom looking at the code

$ git grep kvm_mark_guest_state_protected
accel/kvm/kvm-all.c:void kvm_mark_guest_state_protected(void)
include/system/kvm.h:void kvm_mark_guest_state_protected(void);
target/i386/kvm/tdx.c:    kvm_mark_guest_state_protected();
target/i386/sev.c:        kvm_mark_guest_state_protected();
target/i386/sev.c:    kvm_mark_guest_state_protected();

Seems only sev and tax makes the cpus non-resettable.


>        if (ac->rebuild_guest) {
>            ret =3D ac->rebuild_guest(current_machine);
>            if (ret < 0) {
>                error_report("unable to rebuild guest: %s(%d)",
>                             strerror(-ret), ret);
>                vm_stop(RUN_STATE_INTERNAL_ERROR);
>            } else {
>                info_report("virtual machine state has been rebuilt =
with new "
>                            "guest file handle.");
>                guest_state_rebuilt =3D true;
>            }
>        } else if (!cpus_are_resettable())  {
>            error_report("accelerator does not support reset!");
>        } else {
>            error_report("accelerator does not support rebuilding guest =
state,"
>                         " proceeding with normal reset!");
>        }
>    }
>=20
>>>=20

<anip>


>>> Reproduction:
>>> Using virt-install:
>>> /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate
>>> --name 'avocado-vt-vm1' --machine pseries --memory=3D32768
>>> --vcpu=3D32,sockets=3D1,cores=3D32,threads=3D1 --import --nographics
>>> --os-variant rhel8.0 --serial pty --memballoon model=3Dvirtio
>>> --controller type=3Dscsi,model=3Dvirtio-scsi --disk
>>> path=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- =
ppc64le.qcow2,bus=3Dscsi,size=3D10,format=3Dqcow2
>>> --network=3Dbridge=3Dvirbr0,model=3Dvirtio --boot
>>> emulator=3D/usr/bin/qemu-system-ppc64
>>> Result: Starting install...
>>>         <hangs indefinitely with no output>
>>>=20
>>> Using direct QEMU command:
>>> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine
>>> pseries,accel=3Dkvm -enable-kvm -m 32768 -smp
>>> 32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device
>>> virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive
>>> file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- =
ppc64le.qcow2,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2
>>> -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev
>>> bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0

Hmm, this command line does not seems to indicate its a confidential vm =
or you enable that debug flag.


>>> Result: <hangs indefinitely with no output>
>>>=20
>>> Analysis:
>>> The commit introduces VM file descriptor change support with
>>> architecture-specific hooks.
>>> I attempted the following fixes without success:
>>> 1. Changed abort() to return 0; in stubs/kvm.c
>>> 2. Added early return in kvm_reset_vmfd() when
>>> kvm_arch_supports_vmfd_change() returns false
>>>=20
>>> Git Bisect Log:
>>> # git bisect bad
>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a is the first bad commit
>>> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a (HEAD)
>>> Author: Ani Sinha <anisinha@redhat.com>
>>> Date:   Wed Feb 25 09:19:10 2026 +0530
>>>=20
>>>     accel/kvm: add changes required to support KVM VM file =
descriptor change
>>>=20
>>>     This change adds common kvm specific support to handle KVM VM =
file
>>> descriptor
>>>     change. KVM VM file descriptor can change as a part of
>>> confidential guest reset
>>>     mechanism. A new function api kvm_arch_on_vmfd_change() per
>>>     architecture platform is added in order to implement =
architecture specific
>>>     changes required to support it. A subsequent patch will add x86 =
specific
>>>     implementation for kvm_arch_on_vmfd_change() as currently only =
x86 supports
>>>     confidential guest reset.
>>>=20
>>>     Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>     Link: https://lore.kernel.org/r/20260225035000.385950-6- =
anisinha@redhat.com
>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>=20
>>>  MAINTAINERS            |  6 ++++++
>>>  accel/kvm/kvm-all.c    | 88
>>> =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ =
+++++++++++++++---
>>>  accel/kvm/trace-events |  1 +
>>>  include/system/kvm.h   |  3 +++
>>>  stubs/kvm.c            | 22 ++++++++++++++++++++++
>>>  stubs/meson.build      |  1 +
>>>  target/i386/kvm/kvm.c  | 10 ++++++++++
>>>  7 files changed, 128 insertions(+), 3 deletions(-)
>>>  create mode 100644 stubs/kvm.c
>>>=20
>>> # git bisect log
>>> git bisect start
>>> git bisect good ffcf1a7981793973ffbd8100a7c3c6042d02ae23
>>> git bisect bad 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
>>> git bisect bad e76c30bb13ecb9dc716fa629954bfb6253056ce2
>>> git bisect good 9bdc612a18588975f5776ee4e562df607fea1b2c
>>> git bisect bad 40c015e96942fd2a3e4d5ace6063b3333a3dd372
>>> git bisect good df8df3cb6b743372ebb335bd8404bc3d748da350
>>> git bisect bad 0f53f021ad1ede28dc8944686544e496cab02e5e
>>> git bisect bad 9f0c2b3032639315faf141010a2603b0dbf56230
>>> git bisect bad 98884e0cc10997a17ce9abfd6ff10be19224ca6a
>>> first bad commit: [98884e0cc10997a17ce9abfd6ff10be19224ca6a]
>>>=20
>>> Thanks,
>>> Misbah Anjum N <misanjum@linux.ibm.com>
>=20


