Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BF3E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswcN-00045j-3u; Thu, 19 Feb 2026 00:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vswcK-00045X-E2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vswcI-0003x3-C8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771479020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvdzw6t+DsB3jpZzoIRZhNq4arH2Lfxgw7PvqGnNf+k=;
 b=OpE7wkZnEFFDPfTBOmF4UmJ4S6Gn4WEIDD7IiQdw9/z3zXztH4f9nOo66vYKQ5fw0E8s2H
 57zc1aLW+WHqXZMnoj7nY1Evo+w3oPxk/qfhn8EBIGRZYGX91GcnahD3bdUEH0lEtX5myE
 UDnYOj1wYry3b4PgLLFYh9r/6oXU4Qk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wfIcf4qpM6KVhrerJmPLnQ-1; Thu, 19 Feb 2026 00:30:17 -0500
X-MC-Unique: wfIcf4qpM6KVhrerJmPLnQ-1
X-Mimecast-MFC-AGG-ID: wfIcf4qpM6KVhrerJmPLnQ_1771479016
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ad44941ea2so3705365ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771479016; x=1772083816; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uvdzw6t+DsB3jpZzoIRZhNq4arH2Lfxgw7PvqGnNf+k=;
 b=ctphBGUY03iymu0WmcBjqbv3tlhljr3ytFDthlf1/sMvjfYFzshBnXhI1Jni1am1oN
 98H2MYb3DiCcbwZLmkiF38w+8ZmGG95/KcIn9r+JvIekzfM5AepJReqov5INd+cP9I8N
 CfHvM6byPO14MQjKDJRIS1/R7JEhGLrZve7NQQhgRX6jq1NNMLRsAzT3Mi8uk9SqbL2R
 RiA73jDabaA1j/Y9iOs/03rcupBkyO4MauD37+ZkmD6sG7RQ8pZEw/BwdDm8RGmS7ewr
 zxNNl94oTyB7LKW8h2Rn1D1WRYm46PYm84jZPpk4asczRc+rgXJxL95ro5S91E03CzJn
 Gt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771479016; x=1772083816;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uvdzw6t+DsB3jpZzoIRZhNq4arH2Lfxgw7PvqGnNf+k=;
 b=aiM/8BQwv0XbYeKU39YsMbZzq+7NCcsPq9qZIvdAcDcbm8+a/kOIF/JpZL+qESVkdN
 oMZ9RnyMa4+/X2iZOMEcFc3f8kjmjYeUzOHiWV+LhAmkqLuxhsNBwCT4I5FrJ+YjEesE
 aGeh7CRVaiLzRfISTTkxWSdFPe50XvuEitDXdKU/DZhfIa+Qy7ipUY0rjssVSFpo3UFL
 UePelp31QJ5/44U06LzQp85Hhl/teFgbMM7zK7qcXcMsocewEnBH+QCyVvIpn9wGKg+E
 KzV5OkzlIGXnsletZDNmAYj/ThRwb3O9Dqvf/mh6laQrlom67y8IUpV6wArtRFZECEbK
 7tmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxhlmsldpCIh3kEyd95j4uN7Xa+PQQ2xi0OCFqo0X90SdZ+w7ZtyUQBZh/AC+bl5Y8HaEjwVGqby6c@nongnu.org
X-Gm-Message-State: AOJu0YwMoNJ32YegZAFUMyo7baLnA1JLrdPQFZH8H1rv58QUstX7Zo/z
 ZcHK2NKgZ7Dn7HT3apeNN4E7gq3E2RXvXYGXg9Be8+yv6iB5FzzOA1TWfIH/Z8sSUEAbZJO/PMt
 E+fAd1oe6sXoIgbj03v/6VMSXT/9tvcK+YEcIziZohXswVbqupIogZaYi
X-Gm-Gg: AZuq6aIKLhuWk3tG7zgyGcPq9T5TFGHsmqE9T5wtE/l487CSZYNWNuM45g4sgkMf7Ng
 f4svo44CHHPKAqdail0aPsJ96iz+6oZDNBgL8loupI7SjeyELjkOXR0aWthXQD4V9cJxZkad8z5
 VFM5imaXuNMPYF4JGR5T8K1uakfc4R8V8wJOYzAOJ/fwTMxSR6WEM5oQcU3Rp/3ZA31XJh2O1xi
 Lj8lOIbq1Z32PLJkiVDSPftrjy5aVQoVgmkIAPZ3YVpkpslu8xAi4nw2sI9JLlPQZFra08C0Szw
 4G7Mgi2XDoZakESQT+uhhx0EC8l5jux967sUVzZQF4MmpCNzc7FQpZlz04UfZT8WJyBmQIJf2hN
 bj4ULtb2/KEtdkY09zzUOBy076sXWIHZYeQmX3ta31Ux7t/P/BZAAkshmVmiKXfEC85M=
X-Received: by 2002:a17:903:8c3:b0:2aa:e3da:52b5 with SMTP id
 d9443c01a7336-2ad5aed3f6amr11926525ad.9.1771479016310; 
 Wed, 18 Feb 2026 21:30:16 -0800 (PST)
X-Received: by 2002:a17:903:8c3:b0:2aa:e3da:52b5 with SMTP id
 d9443c01a7336-2ad5aed3f6amr11926295ad.9.1771479015853; 
 Wed, 18 Feb 2026 21:30:15 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6f9c5bsm144706905ad.15.2026.02.18.21.30.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Feb 2026 21:30:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <61f1dfa8-705e-4f2f-ac9c-35da4e8eac02@redhat.com>
Date: Thu, 19 Feb 2026 11:00:01 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D89ED00-C696-4ECA-BE4C-7ADF04631900@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
 <CAK3XEhOFvXUEiO3z1MhGqjBQUH3hB_3u9suLpweBs9vaTr1zog@mail.gmail.com>
 <61f1dfa8-705e-4f2f-ac9c-35da4e8eac02@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 18 Feb 2026, at 11:09=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>=20
> On 2/18/26 18:33, Ani Sinha wrote:
>> On Wed, Feb 18, 2026 at 9:00=E2=80=AFPM C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>>>=20
>>> On 2/18/26 16:07, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 18 Feb 2026, at 7:37=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>>>>>=20
>>>>> On 2/18/26 12:42, Ani Sinha wrote:
>>>>>> Normally the vfio pseudo device file descriptor lives for the =
life of the VM.
>>>>>> However, when the kvm VM file descriptor changes, a new file =
descriptor
>>>>>> for the pseudo device needs to be generated against the new kvm =
VM descriptor.
>>>>>> Other existing vfio descriptors needs to be reattached to the new =
pseudo device
>>>>>> descriptor. This change performs the above steps.
>>>>>> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>>>>=20
>>>>> There is a regression since last version.
>>>>>=20
>>>>>=20
>>>>> 'reboot' from the guest and command 'system_reset' from the QEMU
>>>>> monitor now generate these outputs:
>>>>>=20
>>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt =
with new guest file handle.
>>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt =
with new guest file handle.
>>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt =
with new guest file handle.
>>>>>   ...
>>>>>=20
>>>>> and QEMU exits after a while.
>>>>=20
>>>> I have only seen this in SEV-ES with more than one vcpus. Never =
with TDX or SEV-SNP (single or multiple cpus).
>>>> On which host/guest type did you see this?
>>>=20
>>> SEV-SNP on a RHEL9 host. Same guest I used before and host says :
>>>=20
>>>    [1816531.409591] kvm_amd: SEV-ES guest requested termination: =
0x0:0x0
>> Strange! I am not sure why KVM thinks it's SEV-ES. I have done all my
>> SEV-SNP and TDX testing on a fc43 host and for SEV-ES I used a fc42
>> host. I have not seen this kind of guest termination on SEV-SNP or =
TDX
>> on that host. I am sure there are some differences between the RHEL9
>> host kernel and fc43 kernel.
>=20
> The same issue occurs with a rhel10 kernel.

OK good news is that I see this issue on the latest rhel9 host but not =
on a fc43 host.
The issue happens only when > 1 cpus are created for the guest. With =
only one cpu seems its fine.
I tried a minimalistic guest with only a kernel passed as UKI as well as =
a full blown fc43 guest. Both manifest the same issue with > 1 vcpu =
threads.

There is a regression indeed between versions. My v3 which I posted just =
before FOSDEM seems good and does not show this behaviour on the same =
RHEL 9 host.
Both v4 and v5 are affected. This means regression is somewhere in my =
changes, not due to host kernel changes.

This shows a little bit more information:

bash-5.1# /usr/sbin/reboot -f
[   43.920835] ACPI: PM: Preparing to enter system sleep state S5
[   43.922988] reboot: Restarting system
[   43.924242] reboot: machine restart
qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00800f12
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000b004 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 =
HLT=3D1
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 00800000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 =
DR3=3D0000000000000000=20
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00

It is likely that the changes towards fixing non-coco reset case with =
QMP =E2=80=9Csystem_reset=E2=80=9D introduced this regression. I will =
have to audit changes between v3 and v4.





