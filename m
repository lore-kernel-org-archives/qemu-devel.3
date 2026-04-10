Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B84E99053
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB71S-0000GF-Nt; Fri, 10 Apr 2026 04:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB71R-0000Fr-FB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB71P-0000Yh-7l
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775808921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfTs/yau8cHNI4C5o+BGrWbtz6MfsiSDhARV/1OFHwc=;
 b=FWWtKwQCfhzCVzvtLSMkJmf1DWIsYm14Bl7XUWad0sfZylMLJMrWc8h0r2UFRAQPBvF2lx
 YKeOVRY4KafSEaAqopzrDVla2Pqdvl0ybk9aj1Z64FUAoZJ31OYyaOrfv0af+KM+Vz7T0O
 A/91RLCelRP5q9+RLThgVxUN4M8ba5A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-hWhN4PoANZ2xyO_nhoe7Pg-1; Fri, 10 Apr 2026 04:15:19 -0400
X-MC-Unique: hWhN4PoANZ2xyO_nhoe7Pg-1
X-Mimecast-MFC-AGG-ID: hWhN4PoANZ2xyO_nhoe7Pg_1775808918
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82cdf02bce5so967974b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775808918; x=1776413718; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfTs/yau8cHNI4C5o+BGrWbtz6MfsiSDhARV/1OFHwc=;
 b=fEWptvVPXo98oqONd+igHyM1oYOA1UHtzl7NTBp8ykLdrPaqLSu2xIK2h1y9g0B/LP
 s/n/idOa9sVOasW0964ORmR9CaZRJIHGOD896UvcT9o1IdiG0UY84A0he+LdhasNvYib
 ARVMtFylmpeeN+0V7jVyYR2srT2FIpsUOVfLcJ/oFLxegrZrI1X01PqqrXfCgnpqygRV
 PQqe8F976LNoZHWev4mthnZa/rd1wn8Tp4+DzQH44bZg7/LTDhvI1pmZF/Q8pMyPp6xB
 sqqlzp34EFW2BQSgsrqkdB3N+TwAWzsbpjTi7SLvah+r79yKFzHM04GvILjEqR7xWqLl
 VClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775808918; x=1776413718;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfTs/yau8cHNI4C5o+BGrWbtz6MfsiSDhARV/1OFHwc=;
 b=asCwDZxds+zORubAtWdNvTS16f5Y9WOE1+M01lXvRyuN63ZkVXDOIYkDIvhuJBcouQ
 13BUBdzS3yztD8lbrck0lDL/IGpGDXM+75SNlw67kiEe2RUYG3qby++QkaljbePiIhUU
 sZJ8UZsungQ4RwZjAldZsrbijbt6VcbEQQ/ctsnolUSYbw85TGCglqG1Avs5/dGUgvye
 DJNrGkK61WPQlf/x01eRimwTBxS1Uv90AOc5bJ+b/XVbdp3QOY8DybO3kGI5vEGWOqu3
 WXSAS8nBUpIJw042Kwh57pMQYqjBys/AdYoxob9/AMcQq7SgR2rtjhYJlkpsY9eAw1Jr
 XBhA==
X-Gm-Message-State: AOJu0YxRvUgHI+aEGjh94Dki0LRxscTFa6UzHMSvkZ3X/FSdVxm/tB6N
 5+1gWJ+z0JwvUjU8HEclHOA4+8e4okZDOaQe+LKSA4FzljsgJXAetAMOvdWWJZpP95ZiyO2l9L/
 zeJbxYWYWeMyIHxT4LyxAdkbPgC7TRZt6b9JwLK2GLv5uj8c6idza+hi7
X-Gm-Gg: AeBDies/VxHbcYwk0wVWczZbm8iGR4IlTV88BrPIqKEd4aFmhUxLlQugmYmQtZ+ZTzP
 sJMeC8mOHLRohLfNqjjSe3yEQH6Y60sY95iFSHONzLF2MwsuzcerO7WxjCnT3z2b8ZpNQe0Ax6r
 tWosQUWFyRhA0TvCAx4I4NFmGbnPR7St8NnQg5/Ak1LN8NE4Z7gZ9xlp3pS0EusEylGLBDAGL8E
 S5VexjaL+Q5oC5oNJMDY8WQQ38DgfIr59KU8pJucaNCTg56E7r7REEVH2IXCdm6zoVrY1shTg/S
 yiDaZOeswwtTvrSBHtNJKF+0PL7wCvApE88KbgErAJK7ZVd2NzxQgPZF5QEvr5ruvKGu4tr3p3+
 M5+3bNwwlyp+IDaTm9lb0einzaPYfSC6/cpx0uN7aPar+6nnW01WbqlibGpMzoyl7yIRdjaFnLJ
 A=
X-Received: by 2002:a05:6a00:369b:b0:82d:603f:7ab5 with SMTP id
 d2e1a72fcca58-82f0c221b7dmr2627643b3a.35.1775808918222; 
 Fri, 10 Apr 2026 01:15:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:369b:b0:82d:603f:7ab5 with SMTP id
 d2e1a72fcca58-82f0c221b7dmr2627609b3a.35.1775808917726; 
 Fri, 10 Apr 2026 01:15:17 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4e23d9sm2248944b3a.46.2026.04.10.01.15.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2026 01:15:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
Date: Fri, 10 Apr 2026 13:45:02 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B87F317-5C9C-4CAE-AA50-2B5A12864B76@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
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



> On 10 Apr 2026, at 12:05=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 10 Apr 2026, at 10:55=E2=80=AFAM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>=20
>> Hi Ani,
>>=20
>> On 10/04/26 9:12 am, Ani Sinha wrote:
>>>> On 9 Apr 2026, at 9:40=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>>>=20
>>>> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
>>>> returning true, it was returning before releasing the BQL (Big QEMU =
Lock).
>>>> This caused a lock imbalance where the vCPU thread would loop back =
to
>>>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>>> I am not sure I understand this. Seems kvm_cpu_exec() does expect =
that the caller holds bql before calling the function. Where is the lock =
imbalance?
>>=20
>> The issue is not that kvm_cpu_exec() doesn't expect the caller to =
hold the BQL - it does. The problem is that kvm_cpu_exec() has =
inconsistent BQL handling across its return paths.
>>=20
>> Normal execution path:
>>=20
>> int kvm_cpu_exec(CPUState *cpu)
>> {
>>   // BQL held on entry (from caller)
>>=20
>>   if (kvm_arch_process_async_events(cpu)) {
>>       return EXCP_HLT;  // =E2=86=90 Returns with BQL STILL HELD
>>   }
>>=20
>>   bql_unlock();  // =E2=86=90 Normal path unlocks here
>>   // ... KVM execution loop ...
>>   bql_lock();    // =E2=86=90 Re-acquires before returning
>>   return ret;
>> }
>=20
> Yes the semantics of the function kvm_cpu_exec() is that it should =
always return with bql in locked state. This is because the caller =
kvm_vcpu_thread_fn() calls this function with bql locked and if you see =
the end of kvm_vcpu_thread_fn(), it releases the lock.
>=20
> So if kvm_cpu_exec() unlocks bql internally, it has the responsibility =
to lock it again before returning. This makes the locking and unlocking =
symmetric.
>=20
>=20
>>=20
>> The lock imbalance:
>>=20
>> When kvm_arch_process_async_events() returns true, the function =
returns EXCP_HLT before the bql_unlock() call.
>=20
> Why should it unlock it before returning? In fact it=E2=80=99s =
opposite. If the function had unlocked bql, it should lock it again =
before returning.
>=20
>> This means the early return path keeps the BQL held,
>=20
> This would be the correct thing to do.
>=20
>> while the normal execution path releases and re-acquires it.
>=20
> Because the functions it calls after unlocking requires bql to be =
unlocked.

Another likely reason is that we cannot have large atomic regions for =
performance reasons. So a general principle is to acquire the lock =
narrowly only for specific regions of the code that requires atomicity.=20=



