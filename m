Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB8CE9905D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB8DI-0007TR-2h; Fri, 10 Apr 2026 05:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB8DF-0007T4-Po
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB8DC-0000oL-TX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775813496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptZZvVPuYkfpijxT4Yx1WCcrzvMcHlP0a8QMGdjJ8Es=;
 b=VcaA3gD2ME09RBl9nkCArNyyMaqg5NPg68xIM34AfUcNIqFhVBKDWjFhVlVT3lpW3MF0iX
 HAIwfVNxx05SR7oQnfP9r3yiOyCQcUUOTIL21PBaWtBvlw3NHmBXh41mAPQOs1EjT+gOAf
 nReEdoGw9lyUfee3ojvtYhfD3OHGUcs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-HN3j1hlVPC6kQHKLA1ausg-1; Fri, 10 Apr 2026 05:31:35 -0400
X-MC-Unique: HN3j1hlVPC6kQHKLA1ausg-1
X-Mimecast-MFC-AGG-ID: HN3j1hlVPC6kQHKLA1ausg_1775813494
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76c2bb3149so1111627a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775813494; x=1776418294; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptZZvVPuYkfpijxT4Yx1WCcrzvMcHlP0a8QMGdjJ8Es=;
 b=smkeC1PzaH5ejzg1Dlcmmok4/Kqhu0pV4v3ms6VfIGqf1/xB+G1enniuYkw2yp/alr
 fHkpnjpIVgMX1xP4GG4CTZaDxFmiXbZnFFot89C/jAe/CUbwlMaPQvPS4v8f1+FzpAgw
 bPVyGUrHM6pHrASAQJaC23kIVjnTtbjW18HH1WaKeH+sRTOSUTGNWvrOE/WTDvUhVc6c
 rG0oMUqFWINZzvo4zbZUXRfj9bmGKFxWIUA39HKmj5yrVBwVWVF1MyqPdXSayEg513dw
 FmOV1okv/Bbt4iWo18fNHkw7C5ZdE3jZuf18U902H1hlQXnuNbN7/2y4ybQLfj5weKZ0
 qsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813494; x=1776418294;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptZZvVPuYkfpijxT4Yx1WCcrzvMcHlP0a8QMGdjJ8Es=;
 b=Zan4WcxE5yP11izqJUyzaJGEuVD0fm3dB8ZFjMO9JoMiYKlu4w6CXiEnyyCrxFTqQ0
 qWv6lIkkVMa6pcJxDbdOl6jsJBbi+o3dglowq5Z6tjrZ9yDoXJLY4y3k3+132ZC2hOM4
 pXYsp55jUu71chjiYtROdf+4G1mrS4RS/vbZdfBI9nhOhLDWS0yMuA14xI5AijWuReOR
 GbTMdctCbfQki1q+95a3O5duqmOqBE7hOR5FfiTkNMViJ2tLSBRyXYE+LmC9d9P5heqP
 V7t/awoTpSNmVdgWhXjLqWvNs5Ab8UdQH/UHk8ffJBCdo7RkE69rw/vyc56w+ofAhW2Z
 ochg==
X-Gm-Message-State: AOJu0YyE6G6aJi9WUc2RpcBPhoKog2CVVBowEBrwz+2KsBTX7yGucvWN
 pksq2C9BWhmg/ZeksRnZFajqUM2svjHxAckNib7gxxT5r6L0a9kBzd38D9X4DIibeG2Dy2yaZWi
 08WnUeqIlNy1BeL8u6YbGh3pSh6rUBw2FQrehtZcM2h2ToekPs5T5ylSm
X-Gm-Gg: AeBDievnti/ro6hla0OP2jXuXZ0NJjFQLGffFSX8Z0S5tNTIdx3DVW8fFMpW5XAsrlQ
 03gdIp6jwYOEqJQceopL9LKHva6+pFkgL74y1IQ58ouob6MNaH1j5etGm+3dwV5mUaGDzZ+psC3
 vYvIiTo3tqNAYIOPXzaQVKU1dE+gPN/nDmXVn8wqcROElq7IEY4s06v+tZfFyz6flKSlvBOCBbk
 RtLqncnESt1lanPIJGjiWrWLqx5RHgxFl9L2B0el7JCCErMG1sxx+gTm8gVek4KEXbIK1Kz4Mmi
 Rp5nZwpgp5l4ldyuQCcXaBxcHzBN46aWrw0Mm7nmHq6LT6qBWIY837eC5OC0k4tqZUV6ktCmqgV
 Xlt+1on0lHAG6jDOk6rBSLUncK103IMnunp9bAEaT59LT1ZNoJkcXKH4W/dTb5gQeRgjSqOStt1
 0=
X-Received: by 2002:a05:6a20:3ca8:b0:39b:ff20:f4e5 with SMTP id
 adf61e73a8af0-39fc9309e37mr7358356637.12.1775813494217; 
 Fri, 10 Apr 2026 02:31:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca8:b0:39b:ff20:f4e5 with SMTP id
 adf61e73a8af0-39fc9309e37mr7358331637.12.1775813493491; 
 Fri, 10 Apr 2026 02:31:33 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c4a97sm2028613a12.19.2026.04.10.02.31.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2026 02:31:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:01:16 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <34DB9C06-ED15-42BF-A7BB-AF1BBC170ADA@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
 <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
 <69167029-AE49-4BB3-9A5C-D16E51E5D40F@redhat.com>
 <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
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



> On 10 Apr 2026, at 2:31=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
>=20
>=20
> On 10/04/26 1:59 pm, Ani Sinha wrote:
>>> On 10 Apr 2026, at 1:48=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 10/04/26 12:05 pm, Ani Sinha wrote:
>>>>> On 10 Apr 2026, at 10:55=E2=80=AFAM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>>=20
>>>>> Hi Ani,
>>>>>=20
>>>>> On 10/04/26 9:12 am, Ani Sinha wrote:
>>>>>>> On 9 Apr 2026, at 9:40=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>>>>=20
>>>>>>> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
>>>>>>> returning true, it was returning before releasing the BQL (Big =
QEMU Lock).
>>>>>>> This caused a lock imbalance where the vCPU thread would loop =
back to
>>>>>>> kvm_cpu_exec() while still holding the BQL, leading to =
deadlocks.
>>>>>> I am not sure I understand this. Seems kvm_cpu_exec() does expect =
that the caller holds bql before calling the function. Where is the lock =
imbalance?
>>>>>=20
>>>>> The issue is not that kvm_cpu_exec() doesn't expect the caller to =
hold the BQL - it does. The problem is that kvm_cpu_exec() has =
inconsistent BQL handling across its return paths.
>>>>>=20
>>>>> Normal execution path:
>>>>>=20
>>>>> int kvm_cpu_exec(CPUState *cpu)
>>>>> {
>>>>>    // BQL held on entry (from caller)
>>>>>=20
>>>>>    if (kvm_arch_process_async_events(cpu)) {
>>>>>        return EXCP_HLT;  // =E2=86=90 Returns with BQL STILL HELD
>>>>>    }
>>>>>=20
>>>>>    bql_unlock();  // =E2=86=90 Normal path unlocks here
>>>>>    // ... KVM execution loop ...
>>>>>    bql_lock();    // =E2=86=90 Re-acquires before returning
>>>>>    return ret;
>>>>> }
>>>> Yes the semantics of the function kvm_cpu_exec() is that it should =
always return with bql in locked state. This is because the caller =
kvm_vcpu_thread_fn() calls this function with bql locked and if you see =
the end of kvm_vcpu_thread_fn(), it releases the lock.
>>>> So if kvm_cpu_exec() unlocks bql internally, it has the =
responsibility to lock it again before returning. This makes the locking =
and unlocking symmetric.
>>>>>=20
>>>>> The lock imbalance:
>>>>>=20
>>>>> When kvm_arch_process_async_events() returns true, the function =
returns EXCP_HLT before the bql_unlock() call.
>>>> Why should it unlock it before returning? In fact it=E2=80=99s =
opposite. If the function had unlocked bql, it should lock it again =
before returning.
>>>>> This means the early return path keeps the BQL held,
>>>> This would be the correct thing to do.
>>>>> while the normal execution path releases and re-acquires it.
>>>> Because the functions it calls after unlocking requires bql to be =
unlocked. Since it had to unlock it, it locks it again before returning.
>>>=20
>>> It had to unlock it for the same reason - to give others a chance to =
lock. We need to handle failure/exception cases for the same purpose as =
well.
>> But by unlocking and returning you are breaking the semantics of the =
function and introducing imbalance.
>=20
> I think it is better to unlock bql early in failure cases.
> Even Otherwise, it would become a bql_unlock followed by a bql_lock in =
the caller for EXCP_HLT, which might look a bit odd as well.

But you are doing exactly that across a function call.=20

>=20
> Paolo, suggestions?
>=20
>>>=20
>>>>> The caller (kvm_vcpu_thread_fn()) loops back and calls =
kvm_cpu_exec() again, but now the BQL is already held from the previous =
iteration
>>>>> This creates a situation where the BQL is never released between =
iterations when EXCP_HLT is returned.
>>>>>=20
>>>>> Why this matters:
>>>>> On PowerPC pseries with halted secondary vCPUs =
(start-powered-off=3Dtrue), these vCPUs repeatedly call kvm_cpu_exec() =
which returns EXCP_HLT. Each iteration accumulates BQL holds, preventing =
other threads (including CPU 0) from making progress.
>>>> This seems like some kind of architectural issue with PowerPC. =
Shouldn=E2=80=99t qemu_process_cpu_events() -> =
qemu_cond_wait(cpu->halt_cond, &bql) block other secondary cpus? Then =
the main cpu does a qemu_cpu_kick() to make them active again at some =
point?
>>>=20
>>> KVM vCPUs need to enter the kernel to handle the halted state and =
therefore can run. On spapr, it is handled via start-cpu rtas call for =
which the handler in qemu does a qemu_cpu_kick(). However CPU 0 needs to =
be able to proceed before that stage is reached, but it hangs while =
trying to acquire bql_lock in qemu_default_main() whereas secondary vcpu =
is spinning with BQL held returning EXCP_HLT. This is causing deadlock.
>> Without looking at the code, it seems there is a race condition in =
the way the vcpu threads are initialised in spapr. I think that needs =
fixing.
>=20
> I did explain the race condition observed above.

So why not fix it properly?

> Other architectures may have different timing that masks the issue.
>=20
>>>=20
>>>>>=20
>>>>>>>=20
>>>>>>> The issue manifests as boot hangs on PowerPC pseries machines =
with multiple
>>>>>>> vCPUs, where secondary vCPUs with start-powered-off=3Dtrue =
remain halted and
>>>>>>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each =
iteration held
>>>>>>> the BQL, preventing other operations from proceeding.
>>>>>>>=20
>>>>>>> The fix has two parts:
>>>>>>>=20
>>>>>>> 1. In kvm_cpu_exec() (kvm-all.c):
>>>>>>>   Release the BQL before returning EXCP_HLT in the early return =
path,
>>>>>>>   matching the behavior of the normal execution path where =
bql_unlock()
>>>>>>>   is called before entering the main KVM execution loop.
>>>>>>>=20
>>>>>>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>>>>>>   Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, =
since the
>>>>>>>   loop expects to hold the BQL when calling kvm_cpu_exec() =
again.
>>>>>>>=20
>>>>>>> This ensures proper BQL lock/unlock pairing:
>>>>>>> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
>>>>>>> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
>>>>>>> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
>>>>>>> - Next iteration has BQL held as expected
>>>>>>>=20
>>>>>>> This is a regression introduced by commit 98884e0cc1 =
("accel/kvm: add
>>>>>>> changes required to support KVM VM file descriptor change") =
which
>>>>>>> refactored kvm_irqchip_create() and changed the initialization =
timing,
>>>>>>> exposing this lock imbalance issue.
>>>>>>>=20
>>>>>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support =
KVM VM file descriptor change")
>>>>>> I do not think this is the right reference. The above commit may =
have exposed some underlying issue but is certainly not the cause of it. =
Further, as we have discussed in the other thread, the changes in that =
commit are not even getting executed.
>>>>>> Personally I think the core issue is somewhere else. I am not =
convinced this is the proper fix.
>>>>>=20
>>>>> Regarding commit 98884e0cc1:
>>>>>=20
>>>>> Reverting the kvm_irqchip_create refactoring makes the problem go =
away. This commit may have changed timing that exposed the issue, but =
the root cause is the pre-existing BQL lock imbalance in kvm_cpu_exec(). =
We can either:
>>>>>=20
>>>>> Remove the "Fixes:" tag entirely, or
>>>> Lets remove fixes tag entirely unless you can pin point the exact =
commit that introduced the architectural issues.
>>>>> Add a note that this is a pre-existing issue exposed by timing =
changes
>>>>> The core fix (releasing BQL before returning EXCP_HLT) is correct =
and addresses the actual deadlock mechanism.
>>>>>=20
>>>>>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>>>>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>>>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>>>> ---
>>>>>>> accel/kvm/kvm-accel-ops.c | 4 ++++
>>>>>>> accel/kvm/kvm-all.c       | 1 +
>>>>>>> 2 files changed, 5 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/accel/kvm/kvm-accel-ops.c =
b/accel/kvm/kvm-accel-ops.c
>>>>>>> index 6d9140e549..d684fd0840 100644
>>>>>>> --- a/accel/kvm/kvm-accel-ops.c
>>>>>>> +++ b/accel/kvm/kvm-accel-ops.c
>>>>>>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>>>>>>=20
>>>>>>>         if (cpu_can_run(cpu)) {
>>>>>>>             r =3D kvm_cpu_exec(cpu);
>>>>>>> +            if (r =3D=3D EXCP_HLT) {
>>>>>>> +                /* kvm_cpu_exec() released BQL, re-acquire for =
next iteration */
>>>>>>> +                bql_lock();
>>>>>>> +            }
>>>>>>>             if (r =3D=3D EXCP_DEBUG) {
>>>>>>>                 cpu_handle_guest_debug(cpu);
>>>>>>>             }
>>>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>>>>> index 774499d34f..00b8018664 100644
>>>>>>> --- a/accel/kvm/kvm-all.c
>>>>>>> +++ b/accel/kvm/kvm-all.c
>>>>>>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>>>>>     trace_kvm_cpu_exec();
>>>>>>>=20
>>>>>>>     if (kvm_arch_process_async_events(cpu)) {
>>>>>>> +        bql_unlock();
>>>>>>>         return EXCP_HLT;
>>>>>>>     }
>>>>>>>=20
>>>>>>> --=20
>>>>>>> 2.52.0



