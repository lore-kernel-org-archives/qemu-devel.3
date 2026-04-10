Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484D9E99077
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB8k6-0007Iw-Uv; Fri, 10 Apr 2026 06:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB8k5-0007IH-00
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 06:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB8k2-0001On-VD
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775815533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLQxTuoOSmu7wueIRZEqqREP+YovMsVy7W3Hn70m5Ls=;
 b=Ew2f2qur3mDcaGgkijuKuQ4FFYgsTQpXQANc4djNEY10aaFreLTYk6mQy49tUEififw1d8
 3rhjpdmOXBTMf9Rig1omsJGTTwlzaiHQXvAcmtxK0dUwYryJjMBa0lK/FbZ6+9GmR2J3oP
 1k0v773GXUenQ2xln1kLC6IddSL47vw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-C52WqwPKMgiYPXprdhNWaA-1; Fri, 10 Apr 2026 06:05:32 -0400
X-MC-Unique: C52WqwPKMgiYPXprdhNWaA-1
X-Mimecast-MFC-AGG-ID: C52WqwPKMgiYPXprdhNWaA_1775815531
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a88a2704fso906350b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775815531; x=1776420331; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLQxTuoOSmu7wueIRZEqqREP+YovMsVy7W3Hn70m5Ls=;
 b=asHE0TfVH9L9gdZo5PMm/Qf15WsPTZ+tgCPCuiiP+ycESME/YujXK2XyhTSe65xX1D
 B6PfaEyNLJZB/Ei+DfmGnFzpkfk6JK1jDhcQ2lj7y97sivQ36pqyygL4THjqqRN0w4qj
 b9OUlI9TRfcwuX99HwhHK8AJ/jgQyJoQVkiCXKW6Bfa5FA/Yob5BE0fXZ2f8cTFU11zf
 r/ItCp7ZFUYGGupLKE2w+WXDgeME0yo2zdMVtErIpq70ZOA7E8+glZ2/2zpVSfeaHggi
 5d2lPjPFlvZCiRHNxpR7ewyrHhnjGQWXJyF504SbqOIah8G0rrejGupg8k79u4Sln4Vl
 SBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775815531; x=1776420331;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PLQxTuoOSmu7wueIRZEqqREP+YovMsVy7W3Hn70m5Ls=;
 b=dgEcGJMgtNytxQajy7HVDj8sCF+GSvfTO6i6A7sC6zh3thvxOQRV0ZgmSknqTH5TZ9
 EO0e3KA+mMM0El5UA8kvDiLyst08C+Ce6pL5TqXsZ3d4QR28Lo56w1xSvlgUR/KewqIr
 uK0Q7rF8QaFDLAZjPWgSG//HNgC8akvziXmxI4jWsDVkC1f5w9wG+gTeuW20TD9CnM8o
 ZnW4yEUkJjhlPEhEU+EJOdj2oG2MYFcBbW1V4ShRfUXaPx1JwdVNIIW1m0rJikeIpXOB
 Cfm96tUY39wIftlNCZQ0l4vdkiuiSyNnyjzKNKQPqTM7WPBqbwUi05EU7yutO6J0jmXy
 1Img==
X-Gm-Message-State: AOJu0YxlWb69gbTcjCb5snZ3FidNi4Jhnzo4VDu9limj1IzhLeIefbIl
 HU+lTDE5vyxfN6MxzH3bKG2K4mRF3V7GJSDdRNd8r/arqmT+WxHyuqY6qdP9u8JHu2/oBZb8VJD
 MeP545NenjHp3yU/T5mFsw13HH2K5rqn9pC73zSecz3rTvJCVi70XFMWzxmGe3uUV
X-Gm-Gg: AeBDieu2rbS0KuKcY1xFpIobf5w+7fMR8zyldCaJY1aEB0MXtoeiQ4ITL1gYbW/8JY1
 BFuIBYynmegZgwCWtuQ7KJ4Hmnvctf+btOvwCmSsuqxpSgJ1mW39+Ldza5YlfeGEEenOkhawP1/
 1ucL/FcDb6vWr783e/CZdjiN7/qUYrZ6/ygU9Um8xUlIeFiiG8AdBMEwWGWhsfYVXIvuRL4rs/3
 Y8DG+fpqy3tAjDc1UQ36nFWUbD6t2hcoFAdCpJo9s9zqKYyNNyNx12sAKQxjtfCq12W3oRCijQy
 ZHQsuQ/FJom98lpkEyzWgGXOHhG60GNfA4RoRBHo4tG2AYeDfg9FWN++8FZJ8At4Kix3rqj0ykb
 0p3bTe95OiCSfc/8xz4AYWCeveEdpgUb8n1sZcufuClQiCAyXJZ7kwitczJTRz+oz4Nfv7YnBz7
 A=
X-Received: by 2002:a05:6a00:2e08:b0:82c:c390:ad77 with SMTP id
 d2e1a72fcca58-82dd8a1dbb5mr6256999b3a.7.1775815530790; 
 Fri, 10 Apr 2026 03:05:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e08:b0:82c:c390:ad77 with SMTP id
 d2e1a72fcca58-82dd8a1dbb5mr6256960b3a.7.1775815530087; 
 Fri, 10 Apr 2026 03:05:30 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4e3d41sm3109682b3a.48.2026.04.10.03.05.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2026 03:05:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <852c5863-8f56-473d-ad92-a56a80f3ce71@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:35:13 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89EDA797-28E3-46A1-A464-8AFE9FB534BD@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
 <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
 <69167029-AE49-4BB3-9A5C-D16E51E5D40F@redhat.com>
 <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
 <34DB9C06-ED15-42BF-A7BB-AF1BBC170ADA@redhat.com>
 <852c5863-8f56-473d-ad92-a56a80f3ce71@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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



> On 10 Apr 2026, at 3:32=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
>=20
>=20
> On 10/04/26 3:01 pm, Ani Sinha wrote:
>>> On 10 Apr 2026, at 2:31=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 10/04/26 1:59 pm, Ani Sinha wrote:
>>>>> On 10 Apr 2026, at 1:48=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 10/04/26 12:05 pm, Ani Sinha wrote:
>>>>>>> On 10 Apr 2026, at 10:55=E2=80=AFAM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>>>>=20
>>>>>>> Hi Ani,
>>>>>>>=20
>>>>>>> On 10/04/26 9:12 am, Ani Sinha wrote:
>>>>>>>>> On 9 Apr 2026, at 9:40=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>>>>>>=20
>>>>>>>>> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
>>>>>>>>> returning true, it was returning before releasing the BQL (Big =
QEMU Lock).
>>>>>>>>> This caused a lock imbalance where the vCPU thread would loop =
back to
>>>>>>>>> kvm_cpu_exec() while still holding the BQL, leading to =
deadlocks.
>>>>>>>> I am not sure I understand this. Seems kvm_cpu_exec() does =
expect that the caller holds bql before calling the function. Where is =
the lock imbalance?
>>>>>>>=20
>>>>>>> The issue is not that kvm_cpu_exec() doesn't expect the caller =
to hold the BQL - it does. The problem is that kvm_cpu_exec() has =
inconsistent BQL handling across its return paths.
>>>>>>>=20
>>>>>>> Normal execution path:
>>>>>>>=20
>>>>>>> int kvm_cpu_exec(CPUState *cpu)
>>>>>>> {
>>>>>>>    // BQL held on entry (from caller)
>>>>>>>=20
>>>>>>>    if (kvm_arch_process_async_events(cpu)) {
>>>>>>>        return EXCP_HLT;  // =E2=86=90 Returns with BQL STILL =
HELD
>>>>>>>    }
>>>>>>>=20
>>>>>>>    bql_unlock();  // =E2=86=90 Normal path unlocks here
>>>>>>>    // ... KVM execution loop ...
>>>>>>>    bql_lock();    // =E2=86=90 Re-acquires before returning
>>>>>>>    return ret;
>>>>>>> }
>>>>>> Yes the semantics of the function kvm_cpu_exec() is that it =
should always return with bql in locked state. This is because the =
caller kvm_vcpu_thread_fn() calls this function with bql locked and if =
you see the end of kvm_vcpu_thread_fn(), it releases the lock.
>>>>>> So if kvm_cpu_exec() unlocks bql internally, it has the =
responsibility to lock it again before returning. This makes the locking =
and unlocking symmetric.
>>>>>>>=20
>>>>>>> The lock imbalance:
>>>>>>>=20
>>>>>>> When kvm_arch_process_async_events() returns true, the function =
returns EXCP_HLT before the bql_unlock() call.
>>>>>> Why should it unlock it before returning? In fact it=E2=80=99s =
opposite. If the function had unlocked bql, it should lock it again =
before returning.
>>>>>>> This means the early return path keeps the BQL held,
>>>>>> This would be the correct thing to do.
>>>>>>> while the normal execution path releases and re-acquires it.
>>>>>> Because the functions it calls after unlocking requires bql to be =
unlocked. Since it had to unlock it, it locks it again before returning.
>>>>>=20
>>>>> It had to unlock it for the same reason - to give others a chance =
to lock. We need to handle failure/exception cases for the same purpose =
as well.
>>>> But by unlocking and returning you are breaking the semantics of =
the function and introducing imbalance.
>>>=20
>>> I think it is better to unlock bql early in failure cases.
>>> Even Otherwise, it would become a bql_unlock followed by a bql_lock =
in the caller for EXCP_HLT, which might look a bit odd as well.
>> But you are doing exactly that across a function call.
>=20
> I am fine with either/or maintainer's choice.
>=20
>>>=20
>>> Paolo, suggestions?
>>>=20
>>>>>=20
>>>>>>> The caller (kvm_vcpu_thread_fn()) loops back and calls =
kvm_cpu_exec() again, but now the BQL is already held from the previous =
iteration
>>>>>>> This creates a situation where the BQL is never released between =
iterations when EXCP_HLT is returned.
>>>>>>>=20
>>>>>>> Why this matters:
>>>>>>> On PowerPC pseries with halted secondary vCPUs =
(start-powered-off=3Dtrue), these vCPUs repeatedly call kvm_cpu_exec() =
which returns EXCP_HLT. Each iteration accumulates BQL holds, preventing =
other threads (including CPU 0) from making progress.
>>>>>> This seems like some kind of architectural issue with PowerPC. =
Shouldn=E2=80=99t qemu_process_cpu_events() -> =
qemu_cond_wait(cpu->halt_cond, &bql) block other secondary cpus? Then =
the main cpu does a qemu_cpu_kick() to make them active again at some =
point?
>>>>>=20
>>>>> KVM vCPUs need to enter the kernel to handle the halted state and =
therefore can run. On spapr, it is handled via start-cpu rtas call for =
which the handler in qemu does a qemu_cpu_kick(). However CPU 0 needs to =
be able to proceed before that stage is reached, but it hangs while =
trying to acquire bql_lock in qemu_default_main() whereas secondary vcpu =
is spinning with BQL held returning EXCP_HLT. This is causing deadlock.
>>>> Without looking at the code, it seems there is a race condition in =
the way the vcpu threads are initialised in spapr. I think that needs =
fixing.
>>>=20
>>> I did explain the race condition observed above.
>> So why not fix it properly?
>=20
> I think the suggested fix is appropriate for this scenario.
> Keeping BQL held forever in a loop for EXCP_HLT case isnt the right =
thing to do.

IMHO that loop is a symptom of a deeper architectural issue. The fix =
proposed here feels more like a incorrect hack.


