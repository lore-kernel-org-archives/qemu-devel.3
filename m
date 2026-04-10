Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C059F36BBB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 06:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB5TD-0004KA-5i; Fri, 10 Apr 2026 02:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB5T9-0004Jb-VN
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 02:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB5T7-0000Bz-Hm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 02:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775802951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=me1HUP1kyvRB60+ew96olFdIdRAU4EYzbu0s3mn49GU=;
 b=X9aGB1trH1SwNSaLkS6z014ObulQkbMbUatoh+Q6vKKC714RzEjAwrIZmgHxRYp4Vw/KuK
 PXzi/QQX+w0aZ9vUPDr1y5sQH/we/iIG4LcvlSZbxwXpuEsfaeUIuW80SngNSHkOCv8fIX
 grOoPx+6UkOqZAttET4osRLK8ElQM90=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Io41gmsOPpiJipbzqPkY9Q-1; Fri, 10 Apr 2026 02:35:49 -0400
X-MC-Unique: Io41gmsOPpiJipbzqPkY9Q-1
X-Mimecast-MFC-AGG-ID: Io41gmsOPpiJipbzqPkY9Q_1775802948
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82cf8dcd079so1099532b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775802948; x=1776407748; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me1HUP1kyvRB60+ew96olFdIdRAU4EYzbu0s3mn49GU=;
 b=Sbm7p7yn1CbzJCg2Jvh9QQag+NMNtpnnkV3Lt/tI7sZ1AxqlnNhK+viLN5iPg4PvXw
 vaZAfImhs74FgKLdPN/JRcUro176JJCn2BN067ozch4mQ3SKAzfeB4hFJ9oX850fewL/
 SKytDj5iTzj85XNY1iPoN1BgRHETwC3EVFV/ifatqxTAvGIfzAkE9lMOYLp5tRZkEBo3
 HN+Mdb9msO6PXX0g5XhhLrUe/ir1PA4wUX3hKYK9BEAA+pglygmBmiTL0q7JKwRd8LfU
 RuVdZIiOdYLuUr63oIj/uiTrbVnX4N9fL1rmw3dx2PSN6ZeIXmuEvNsyWR2X9uhV+6Fl
 ND2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775802948; x=1776407748;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=me1HUP1kyvRB60+ew96olFdIdRAU4EYzbu0s3mn49GU=;
 b=d3G9JtN/5uAJWIThSeCkz4qiBuVEZ70KeD6wLKc6HiBjzANSswumyzKhwAUN0KW9fp
 /PPf/Ru0bXEmA+CWEbfUed2e37lRGDdtmcSZHIH8qiWQdENOh3w6NTeyOpCkOAbgf5N3
 jttDHNBTv9YJBxjftdEEPEnPYNP6R3PSppnPCewTJwbevxNSKBtGMOTYLd7iR1P/EwGL
 XgZGow0DaA4WYPLfn91his8LB8j05okxOs/4H79NNpi0Z8GNUn82vXCGK2itGetrvchY
 kstQXqKX8h4xpBG+cTe2g2GEQTKKVk2wRn1DmTDOLtbjWBsvIH8+eNOfZrjjhIAamhNL
 a7mw==
X-Gm-Message-State: AOJu0YxN11IZytaFYZeYZKd2pZ65E71woyJxBTopkJwNRxy3DpQeQ8lM
 69Hz5dYqxboHOUKtwDGirYcbRMJWOUHewj+yVCPewhQ8+omkmSn5mVqvIIzWWJ1IBa2YYO6EDhH
 +MbvXcr4KMdIEAsZaATSozmFPR4ImgqQU9vX57ew/cxRPa5z4ntJItzHh
X-Gm-Gg: AeBDievrF9QEwfR5kVUIco5jW2+0aasGRkP2a4P2D+oKlbOVCn8jZHx0+3P5xJGRM5p
 d3f2DlqVGrH0XDyqCKW1zabfP7OZV3AK1WlWM9A4NksSwqTIcXr8wm8pX3JY9RCKzJO9IZEISoa
 nwbb5UyTo319CcvugCjqcbYDBRtkVDNm8wP89izMj+0zTIH/h+Pv0qxAwg9T6TgZySicD1JI4PW
 mM7KaSEWaJFJnROM+OLYrNGKaKzJrcYQsB9R2WEz+BDQJk3++l7R/9avBvGvKwjFcduq5wtF05d
 nLB6BxqWQyiUoz7Ci5IUeR9K8RhDN67e6aCgJ98jnqEKTKyTldcbJoeTWgXQOQaRFNYrzZujY+t
 PU+6sgjf42pMkpIMd+s9TlF3WzqT7oaePFKTdvpog5lzTVjPVI9nCopPF4//1nFh2ALrE7jqD+b
 E=
X-Received: by 2002:a05:6a00:369b:b0:82c:2468:a163 with SMTP id
 d2e1a72fcca58-82f0c22190cmr2176775b3a.34.1775802948369; 
 Thu, 09 Apr 2026 23:35:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:369b:b0:82c:2468:a163 with SMTP id
 d2e1a72fcca58-82f0c22190cmr2176744b3a.34.1775802947823; 
 Thu, 09 Apr 2026 23:35:47 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc64csm1394428a12.11.2026.04.09.23.35.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Apr 2026 23:35:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
Date: Fri, 10 Apr 2026 12:05:32 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
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



> On 10 Apr 2026, at 10:55=E2=80=AFAM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
> Hi Ani,
>=20
> On 10/04/26 9:12 am, Ani Sinha wrote:
>>> On 9 Apr 2026, at 9:40=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>=20
>>> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
>>> returning true, it was returning before releasing the BQL (Big QEMU =
Lock).
>>> This caused a lock imbalance where the vCPU thread would loop back =
to
>>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>> I am not sure I understand this. Seems kvm_cpu_exec() does expect =
that the caller holds bql before calling the function. Where is the lock =
imbalance?
>=20
> The issue is not that kvm_cpu_exec() doesn't expect the caller to hold =
the BQL - it does. The problem is that kvm_cpu_exec() has inconsistent =
BQL handling across its return paths.
>=20
> Normal execution path:
>=20
> int kvm_cpu_exec(CPUState *cpu)
> {
>    // BQL held on entry (from caller)
>=20
>    if (kvm_arch_process_async_events(cpu)) {
>        return EXCP_HLT;  // =E2=86=90 Returns with BQL STILL HELD
>    }
>=20
>    bql_unlock();  // =E2=86=90 Normal path unlocks here
>    // ... KVM execution loop ...
>    bql_lock();    // =E2=86=90 Re-acquires before returning
>    return ret;
> }

Yes the semantics of the function kvm_cpu_exec() is that it should =
always return with bql in locked state. This is because the caller =
kvm_vcpu_thread_fn() calls this function with bql locked and if you see =
the end of kvm_vcpu_thread_fn(), it releases the lock.

So if kvm_cpu_exec() unlocks bql internally, it has the responsibility =
to lock it again before returning. This makes the locking and unlocking =
symmetric.


>=20
> The lock imbalance:
>=20
> When kvm_arch_process_async_events() returns true, the function =
returns EXCP_HLT before the bql_unlock() call.

Why should it unlock it before returning? In fact it=E2=80=99s opposite. =
If the function had unlocked bql, it should lock it again before =
returning.

> This means the early return path keeps the BQL held,

This would be the correct thing to do.

> while the normal execution path releases and re-acquires it.

Because the functions it calls after unlocking requires bql to be =
unlocked. Since it had to unlock it, it locks it again before returning.

> The caller (kvm_vcpu_thread_fn()) loops back and calls kvm_cpu_exec() =
again, but now the BQL is already held from the previous iteration
> This creates a situation where the BQL is never released between =
iterations when EXCP_HLT is returned.
>=20
> Why this matters:
> On PowerPC pseries with halted secondary vCPUs =
(start-powered-off=3Dtrue), these vCPUs repeatedly call kvm_cpu_exec() =
which returns EXCP_HLT. Each iteration accumulates BQL holds, preventing =
other threads (including CPU 0) from making progress.

This seems like some kind of architectural issue with PowerPC. =
Shouldn=E2=80=99t qemu_process_cpu_events() -> =
qemu_cond_wait(cpu->halt_cond, &bql) block other secondary cpus? Then =
the main cpu does a qemu_cpu_kick() to make them active again at some =
point?

>=20
>>>=20
>>> The issue manifests as boot hangs on PowerPC pseries machines with =
multiple
>>> vCPUs, where secondary vCPUs with start-powered-off=3Dtrue remain =
halted and
>>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each =
iteration held
>>> the BQL, preventing other operations from proceeding.
>>>=20
>>> The fix has two parts:
>>>=20
>>> 1. In kvm_cpu_exec() (kvm-all.c):
>>>   Release the BQL before returning EXCP_HLT in the early return =
path,
>>>   matching the behavior of the normal execution path where =
bql_unlock()
>>>   is called before entering the main KVM execution loop.
>>>=20
>>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>>   Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since =
the
>>>   loop expects to hold the BQL when calling kvm_cpu_exec() again.
>>>=20
>>> This ensures proper BQL lock/unlock pairing:
>>> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
>>> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
>>> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
>>> - Next iteration has BQL held as expected
>>>=20
>>> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: =
add
>>> changes required to support KVM VM file descriptor change") which
>>> refactored kvm_irqchip_create() and changed the initialization =
timing,
>>> exposing this lock imbalance issue.
>>>=20
>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM =
VM file descriptor change")
>> I do not think this is the right reference. The above commit may have =
exposed some underlying issue but is certainly not the cause of it. =
Further, as we have discussed in the other thread, the changes in that =
commit are not even getting executed.
>> Personally I think the core issue is somewhere else. I am not =
convinced this is the proper fix.
>=20
> Regarding commit 98884e0cc1:
>=20
> Reverting the kvm_irqchip_create refactoring makes the problem go =
away. This commit may have changed timing that exposed the issue, but =
the root cause is the pre-existing BQL lock imbalance in kvm_cpu_exec(). =
We can either:
>=20
> Remove the "Fixes:" tag entirely, or

Lets remove fixes tag entirely unless you can pin point the exact commit =
that introduced the architectural issues.

> Add a note that this is a pre-existing issue exposed by timing changes
> The core fix (releasing BQL before returning EXCP_HLT) is correct and =
addresses the actual deadlock mechanism.
>=20
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> ---
>>> accel/kvm/kvm-accel-ops.c | 4 ++++
>>> accel/kvm/kvm-all.c       | 1 +
>>> 2 files changed, 5 insertions(+)
>>>=20
>>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>>> index 6d9140e549..d684fd0840 100644
>>> --- a/accel/kvm/kvm-accel-ops.c
>>> +++ b/accel/kvm/kvm-accel-ops.c
>>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>>=20
>>>         if (cpu_can_run(cpu)) {
>>>             r =3D kvm_cpu_exec(cpu);
>>> +            if (r =3D=3D EXCP_HLT) {
>>> +                /* kvm_cpu_exec() released BQL, re-acquire for next =
iteration */
>>> +                bql_lock();
>>> +            }
>>>             if (r =3D=3D EXCP_DEBUG) {
>>>                 cpu_handle_guest_debug(cpu);
>>>             }
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..00b8018664 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>     trace_kvm_cpu_exec();
>>>=20
>>>     if (kvm_arch_process_async_events(cpu)) {
>>> +        bql_unlock();
>>>         return EXCP_HLT;
>>>     }
>>>=20
>>> --=20
>>> 2.52.0



