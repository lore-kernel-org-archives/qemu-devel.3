Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49797EBFD08
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBUg-0002yu-GO; Mon, 13 Apr 2026 03:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCBUf-0002yd-Ju
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCBUd-0000Lz-1e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776064436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iAu39pTkAEFIrDGoZu079165o4bxNu8OxZMxd1GIwU=;
 b=XOFJL8KEipAoDAVcOkYwyM1yYNGkqVnfQxoWRVG7G6WnQ1xrxBk95XsNltHs+xfApiEDIg
 Bqzx8MPEMU4/Ok/kFKNvX4E90865e+TRcmGsAmxOwiiYL09qaZEeGGOMb+vB6Jsr06Fx44
 6hn52awhAUwj6EHSRB9R0DVID/RcTZc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-512XYB-wPr6LmouAd9_iFw-1; Mon, 13 Apr 2026 03:13:55 -0400
X-MC-Unique: 512XYB-wPr6LmouAd9_iFw-1
X-Mimecast-MFC-AGG-ID: 512XYB-wPr6LmouAd9_iFw_1776064434
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso9423915ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776064434; x=1776669234; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iAu39pTkAEFIrDGoZu079165o4bxNu8OxZMxd1GIwU=;
 b=jdJmXpFWt1JHKHAR1Bh0ns7YM+U1IZVulYn6ZJBoxx/LSYs9nGmtEUO7EOIoZwftCp
 JHK7ylR7MMDofwR7u2M9mkPFTzGj4jHxieAdPi+Sdb4f8ckT+IEA9550Zzgxi46Bjk5q
 G7m1ZwmDQ3G/WP2Tic5LtRbjlg0CoqL0QLb/EC3Q3mujNd07AHX/UvLVlvPL7n4Mho0z
 KIHC6AgmlNkG8xo4BXNRyKRpCkpPIosQ8nzHoWVHlUO+grWDpLnPRDq/MSWGWm3yAR2C
 Ewf1KPmHoGfyrseKUWTIgFBZxGbLWOwXGdKgj+9DY4xks65uIybtsvZ+uaFBwzri2+yB
 5q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776064434; x=1776669234;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5iAu39pTkAEFIrDGoZu079165o4bxNu8OxZMxd1GIwU=;
 b=LHBwEo1d/ML6Fc62RfIXCCSM9jrLtICTwR7lbt21vcG6QfpEGh09f7p88hLug5UXM2
 SMtpsYiTt+ah/YG2r4r5FJ8R7D/APVNhfixhcX+sPOoAJvOg2r2Caha6ityHZZ93ZHHj
 avL4AsyN6+DywawwvuG2DxUE9gGLyCebyHUxH744YxPn3VO2YKgqFD/ImpO3vtjJucgB
 YwNqxdmOr1ew+2Jx23Vn5mIoKU+y5Dqe8BvgXKcDTzu03UCM/0Y2kHsvK+8ZRqj3iw50
 UUm8GZu8lu06mvzfpSfB5WWZwW7EL6GbK5GxHvZEDS7yEmGX16lofPcZcn7Ywk9cDVRm
 +J3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UtD/CkrIcgEUpKW/zmm/iqcGB4M7IxEFP1NzBW0H3rN326g6YNrn50P9j1pT5TIND3YH4QN5hcdXf@nongnu.org
X-Gm-Message-State: AOJu0Yz42Dmf/w+uuMhMO7IxukGDJj9AyTnynBknkAkY0Zv1yX1Gwz3z
 pQawgU/XF7bO9lVYk7lWbsIo0dcNZbqDmkHmc2l0YDjaF1g19IDkr/ELl5BBiygmicDZcxUTBWq
 eb2rG3+/AHhHBsdNkUM1s0pUH6ENUqTs/XIyID3JCDdHYrra/g7pqgEsR
X-Gm-Gg: AeBDieto2dBkp43Dapj7fs6W5It52r6QvttlGGfslawTATNETSbZzLby9IkWEv81IRM
 sKMJSuV7XV7UaNo9EMyWxlkwI5WKrpOcuRzAlZELNRHUsFlFWWCE5zdKUeXfGsbJSEiaj84rFPV
 o2sfCvK6McBNINr8QWQXvyE3bIhvjoPznN7lBNr0ZCDNBHyVETQe8P6VOYmTxjZ+kk6BP2ZatXR
 R2AJX7CbmgFGnCcWCFrdhJSSK7i5Mg/dgYWxf5DDWXC6KzX3mrF8NTbQTDVy/TlRS9C1zK/Hzys
 DmbYmOl3X9s+VIUDDe//fgs+UBJxh9g6K4mHUB6ZpK9JZuH3YejTdTAT7jIZWe8AL4JHZ1JxyL8
 F3e7WdkRrEsaiR1yaZmkbCOjeYlU4521c5wAM3T2HHURPLSvV70eA84rWwgwO00kg9s0hYcoykN
 g=
X-Received: by 2002:a17:902:7041:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b465ab5ba4mr3859365ad.36.1776064433959; 
 Mon, 13 Apr 2026 00:13:53 -0700 (PDT)
X-Received: by 2002:a17:902:7041:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b465ab5ba4mr3859245ad.36.1776064433399; 
 Mon, 13 Apr 2026 00:13:53 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4dd7faasm105091465ad.26.2026.04.13.00.13.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 00:13:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d4ca5f6a-c810-407b-b089-839e0a7d6d06@linux.ibm.com>
Date: Mon, 13 Apr 2026 12:43:37 +0530
Cc: Fabiano Rosas <farosas@suse.de>, balaton@eik.bme.hu,
 qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A44F57CD-3292-4715-BE26-98DD15D40613@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <87qzomznto.fsf@suse.de> <d4ca5f6a-c810-407b-b089-839e0a7d6d06@linux.ibm.com>
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



> On 13 Apr 2026, at 11:14=E2=80=AFAM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
> Hi Fabiano, Balaton,
>=20
> Thanks for pitching in and the suggestions.
>=20
> On 10/04/26 11:42 pm, Fabiano Rosas wrote:
>> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
>>> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
>>> returning true, it was returning before releasing the BQL (Big QEMU =
Lock).
>>> This caused a lock imbalance where the vCPU thread would loop back =
to
>>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>>>=20
>>> The issue manifests as boot hangs on PowerPC pseries machines with =
multiple
>>> vCPUs, where secondary vCPUs with start-powered-off=3Dtrue remain =
halted and
>>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each =
iteration held
>>> the BQL, preventing other operations from proceeding.
>>>=20
>> AFAIU, with halted=3D1, the thread should be waiting at the
>> qemu_process_cpu_events() qemu_cond_wait invocation which will =
release
>> the BQL during the wait.
>> What is your irqchip setting? on/off/split? Aren't you just hitting =
the
>> early return at do_kvm_irqchip_create()? The refactoring from commit
>> 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file
>> descriptor change") made it so a few lines that would have been =
skipped
>> are now executed.
>> In this case, probably kvm_halt_in_kernel_allowed=3Dtrue is making
>> cpu_thread_is_idle() return false and skip the wait at
>> qemu_process_cpu_events().
>=20
> You caught it right, the early return changed the behaviour with the
> commit mentioned. I just tried with below change which retains the
> behaviour prior to the commit mentioned and it works as expected (no =
more BQL deadlocks).
>=20

This makes more sense. Btw if you had followed through with the =
suggestion I made here
=
https://yhbt.net/lore/all/1014F925-4992-459B-B5B4-E6CCAC7FBC02@redhat.com/=


It would have pointed straight at this change and then figuring out the =
rest would have been straightforward.

> Ani, would you like to post the patch fixing the behaviour change
> introduced with commit 98884e0cc1 or I can send below patch if looks =
fine?

I will post something soon.


>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..a388c00d71 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> }
>=20
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
> {
>     int ret;
>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>             exit(1);
>         }
>     } else {
> -        return;
> +        return -1;
>     }
>=20
>     if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
> @@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
>         fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>         exit(1);
>     }
> +    return 0;
> }
>=20
> static void kvm_irqchip_create(KVMState *s)
> {
>     assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
> -
> -    do_kvm_irqchip_create(s);
> +    int ret =3D 0;
> +
> +    ret =3D do_kvm_irqchip_create(s);
> +    if (ret < 0)
> +        return;
>     kvm_kernel_irqchip =3D true;
>     /* If we have an in-kernel IRQ chip then we must have asynchronous
>      * interrupt delivery (though the reverse is not necessarily true)
>=20
>=20
>>> The fix has two parts:
>>>=20
>>> 1. In kvm_cpu_exec() (kvm-all.c):
>>>    Release the BQL before returning EXCP_HLT in the early return =
path,
>>>    matching the behavior of the normal execution path where =
bql_unlock()
>>>    is called before entering the main KVM execution loop.
>>>=20
>>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>>    Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since =
the
>>>    loop expects to hold the BQL when calling kvm_cpu_exec() again.
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
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> ---
>>>  accel/kvm/kvm-accel-ops.c | 4 ++++
>>>  accel/kvm/kvm-all.c       | 1 +
>>>  2 files changed, 5 insertions(+)
>>>=20
>>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>>> index 6d9140e549..d684fd0840 100644
>>> --- a/accel/kvm/kvm-accel-ops.c
>>> +++ b/accel/kvm/kvm-accel-ops.c
>>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>>            if (cpu_can_run(cpu)) {
>>>              r =3D kvm_cpu_exec(cpu);
>>> +            if (r =3D=3D EXCP_HLT) {
>>> +                /* kvm_cpu_exec() released BQL, re-acquire for next =
iteration */
>>> +                bql_lock();
>>> +            }
>>>              if (r =3D=3D EXCP_DEBUG) {
>>>                  cpu_handle_guest_debug(cpu);
>>>              }
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..00b8018664 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>      trace_kvm_cpu_exec();
>>>        if (kvm_arch_process_async_events(cpu)) {
>>> +        bql_unlock();
>>>          return EXCP_HLT;
>>>      }



