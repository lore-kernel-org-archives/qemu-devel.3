Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A626EE69183
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXaU-0003Bx-99; Fri, 22 Nov 2024 12:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tEXaS-0003Bj-IW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:36:56 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tEXaQ-00034Y-27
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:36:56 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso2410381b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732297012; x=1732901812;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/C9RMHlIaJE1IsnI23oEghQ6QqOAyMCRss+CmZiJ3w=;
 b=f1Cx6DbPphTKvvuN1EnIdTTU8hHS8JE3fU2116pyP9hy5lB98f14D+zZzRU27aC1dn
 eU+ohWyLNp9TyF0uxt7Nxksq7hkCZa0a7N8Z3MtyNfC5lfHtJaSkosxBzOJEzeIH7obe
 PiooosyvRJZ2vNSqiIHXi2CMEmVaCIHzf20z8BwrlgYqIqNObXMzBCotBpo2x+y4bvZX
 9A2BX+gpLG4+wEdjIxaNW4t9ZOr5lhKRSoRzxe+vt6fq6n7eS+5nGp5dRhDDgRGEe/Cc
 XhreymniytbfZKAD6g3vYlIXiMDO9p4sByIB7XGn2bEENwBmRkEzoW8o8WFNVjTapZXu
 pc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732297012; x=1732901812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/C9RMHlIaJE1IsnI23oEghQ6QqOAyMCRss+CmZiJ3w=;
 b=XyS+F7UlAATPPWgwNvNiGpu7aAvYz50Q/mZtngpG0cDgfTYLC0M3nnYqCjIu0/lh2m
 pniuytPM4elYg1mTuSbWESSacnYXNy7Cs3PJKsDEWyDLMLkxWcf1ghOvb4vtE4+jpbsg
 71WRWP3ZzVb312HVE/ViehZSUPcRqsJd9ftY0IkEHRyJxZ4AAaQ6JYe9DImv9bv7unRb
 YFU76Saajef3Vob48aNPwgV72Lpv52nKg9oICkSNwxvUQlAk0OU12R0MLlcK/khNJ0TU
 TJ9T+e87Xxwwn8wd5ZHrqfNvNX4I7qhBthlW9tTJkPgU13PyR+6TJY/JUtGRZCDAyIPp
 lMBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvrvvK2ac6pTuB/HI3mRIzmOGz9eZ6juf/myqKTiOj2jiVmZmW1bCzC3PCfecz9yxd3nSg5EXM/vez@nongnu.org
X-Gm-Message-State: AOJu0YwQ+/Bsxc3js6vygyEKlhLrznCxfLKpNc7pROB7/13AP2D7OoNn
 MavMPOIlRZa69xmCkuzaU7Ij8akAeG70zZi/z6a/AvbaoPUb7rUWCI0g2wxV62A33leBLoKpVLJ
 6vRAKQyAoYU7cCz5SSzMAryrA1nPDey8/QK4BWw==
X-Gm-Gg: ASbGncvG78dfYDFByI/qQH2YnxIhAoc+Bb299/OlnCZ/Zz+GTk3YA+Ph0hOBxlT58s2
 JSqhwKGPHSNBOSujVWKxjmzbbsNMH
X-Google-Smtp-Source: AGHT+IGH0KSp0kk3NUd2Qb8Gyr/08ZJ2WyyHCA34+w1tHxUspRDXLm2U2bWBH8BxaegELbrkU/rBfMJQSRXl41t2aWo=
X-Received: by 2002:a05:6a00:8007:b0:724:e160:7f19 with SMTP id
 d2e1a72fcca58-724e16085a7mr3917327b3a.22.1732297012142; Fri, 22 Nov 2024
 09:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
 <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
 <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
 <CAHBxVyER0Lxp0uwed7ANW6d6pD1gvSVQ8b245scd+tm7HpT9ag@mail.gmail.com>
 <0214DDE7-28F3-48C1-96ED-E700764D95D3@syntacore.com>
 <CAHBxVyGU1nbY5HC7dk4fhWNEJP8EPP-eNxhNU992usQi7Cim7w@mail.gmail.com>
 <DBECF034-EC77-4165-A571-902B86C81EE6@syntacore.com>
In-Reply-To: <DBECF034-EC77-4165-A571-902B86C81EE6@syntacore.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 22 Nov 2024 09:36:41 -0800
Message-ID: <CAHBxVyFnWbtKN-ZjQYRYV_-JxbxFJbiJv-a6Upwq1CMr8GDkUw@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
To: Aleksei Filippov <alexei.filippov@syntacore.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 22, 2024 at 3:43=E2=80=AFAM Aleksei Filippov
<alexei.filippov@syntacore.com> wrote:
>
>
>
> > On 21 Nov 2024, at 22:54, Atish Kumar Patra <atishp@rivosinc.com> wrote=
:
> >
> > On Wed, Nov 20, 2024 at 6:25=E2=80=AFAM Aleksei Filippov
> > <alexei.filippov@syntacore.com> wrote:
> >>
> >>
> >>
> >>> On 22 Oct 2024, at 15:58, Atish Kumar Patra <atishp@rivosinc.com> wro=
te:
> >>>
> >>> On Mon, Oct 21, 2024 at 6:45=E2=80=AFAM Aleksei Filippov
> >>> <alexei.filippov@syntacore.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On 11 Oct 2024, at 23:45, Atish Kumar Patra <atishp@rivosinc.com> w=
rote:
> >>>>>
> >>>>> On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
> >>>>> <alexei.filippov@yadro.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 10.10.2024 02:09, Atish Patra wrote:
> >>>>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>>>>>> ---
> >>>>>>> target/riscv/cpu.h | 25 +++++++++++++++++++++++++
> >>>>>>> 1 file changed, 25 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>>>>>> index 2ac391a7cf74..53426710f73e 100644
> >>>>>>> --- a/target/riscv/cpu.h
> >>>>>>> +++ b/target/riscv/cpu.h
> >>>>>>> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
> >>>>>>>      uint64_t counter_virt_prev[2];
> >>>>>>> } PMUFixedCtrState;
> >>>>>>>
> >>>>>>> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
> >>>>>>> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
> >>>>>>> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType=
 access_type);
> >>>>>>> +
> >>>>>>> +typedef struct PMUEventInfo {
> >>>>>>> +    /* Event ID (BIT [0:55] valid) */
> >>>>>>> +    uint64_t event_id;
> >>>>>>> +    /* Supported hpmcounters for this event */
> >>>>>>> +    uint32_t counter_mask;
> >>>>>>> +    /* Bitmask of valid event bits */
> >>>>>>> +    uint64_t event_mask;
> >>>>>>> +} PMUEventInfo;
> >>>>>>> +
> >>>>>>> +typedef struct PMUEventFunc {
> >>>>>>> +    /* Get the ID of the event that can monitor cycles */
> >>>>>>> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
> >>>>>>> +    /* Get the ID of the event that can monitor cycles */
> >>>>>>> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
> >>>>>>> +    /* Get the ID of the event that can monitor TLB events*/
> >>>>>>> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
> >>>>>> Ok, this is kinda interesting decision, but it's not scalable. AFA=
IU
> >>>>>
> >>>>> Yes it is not scalable if there is a need to scale as mentioned ear=
lier.
> >>>>> Do you have any other events that can be emulated in Qemu ?
> >>>>>
> >>>>> Having said that, I am okay with single call back though but not to=
o sure
> >>>>> about read/write callback unless there is a use case to support tho=
se.
> >>>>>
> >>>>>> none spec provide us full enum of existing events. So anytime when
> >>>>>> somebody will try to implement their own pmu events they would hav=
e to
> >>>>>> add additional callbacks, and this structure never will be fulled
> >>>>>> properly. And then we ended up with structure 1000+ callback with =
only 5
> >>>>>> machines wich supports pmu events. I suggest my approach with only
> >>>>>> read/write callbacks, where machine can decide by itself how to ha=
ndle
> >>>>>> any of machine specific events.
> >>>>>
> >>>>> Lot of these events are microarchitectural events which can't be
> >>>>> supported in Qemu.
> >>>>> I don't think it's a good idea at all to add dummy values for all t=
he
> >>>>> events defined in a platform
> >>>>> which is harder to debug for a user.
> >>>>
> >>>> Yes, you're right that the rest of the events are microarchitectural=
 and that they can't be properly simulated in QEMU at the moment, but it se=
ems to me that's not really the point here. The point is how elastic this s=
olution can be - that is, whether to do any events or not and how exactly t=
hey should be counted should be decided by the vendor of a particular machi=
ne, and not by the simulator in general. Plus, I have a very real use case =
where it will come in handy - debugging perf. Support the possibility of si=
mulating events on QEMU side will make the life of t perf folks much easier=
. I do not insist specifically on my implementation of this solution, but I=
 think that the solution with the creation of a callback for each of the ev=
ents will significantly complicate the porting of the PMU for machine vendo=
rs.
> >>>>>
> >>>
> >>> As I mentioned in other threads, I am absolutely okay with single cal=
l
> >>> backs. So Let's do that. However, I am not in favor of adding
> >>> microarchitectural events that we can't support in Qemu with
> >>> completely bogus data. Debugging perf in Qemu can be easily done with
> >>> the current set of events supported. Those are not the most accurate
> >>> but it's a representation of what Qemu is running. Do you foresee any
> >>> debugging issue if we don't support all the events a platform
> >>> advertises ?
> >> In general - there is only one potential problem. When perf would try =
to get event by the wrong id. The main algorithm indeed could be tested wit=
h limited  quantities of events. But this
> >
> > It won't get a wrong id as the Qemu platform won't support those.
> > Hence, you can not run perf for those events to begin with.
> >
> >> gonna be a real pain for the testers which gonna deduce and remember w=
hat particular event can/can=E2=80=99t be counted in QEMU and why does he g=
ets 0 there and not 0 here. Moreover,
> >
> >> perf list will show which events are supported on a particular platfor=
m. So user won't be confused. We
> >
> >> we would allow events with even complete bogus data this would works p=
erfectly for CI stuff for the benchmark + perf ppl, and they wouldn=E2=80=
=99t restrict their CI to that. I really do  not see
> >
> > IMO, it is more confusing to show bogus data rather than restricting
> > the number of events an user can run on Qemu platforms. Clearly, you
> > think otherwise. I think we can agree to disagree here. Let's
> > consolidate our patches to provide the infrastructure for the actual
> > events. The bogus event support can be a separate series(per vendor)
> > as that warrants a different discussion whether it is useful for users
> > or not.
> >
> > Sounds good ?
> Yeah, it=E2=80=99s even better to do it separately, agreed. Do you want m=
e to do
>  general part? Or we gonna split it in some way?
> >

Sure, go ahead. If you can include my first few patches that modify
the key to 64 bit
and other fixes/helpers before your patches that would be great.

> > any problem to let the vendor handle this situation. At least vendor
> > can decide by his own to count/not to count some types of event, this
> > gonna bring flexibility and the transparency of the solution and, in
> > general, if we=E2=80=99ll bring some rational reason why we can't add s=
uch
> > events we can always forbid to do such thing.
> >>>
> >>>>>
> >>>>>>> +} PMUEventFunc;
> >>>>>>> +
> >>>>>>> struct CPUArchState {
> >>>>>>>  target_ulong gpr[32];
> >>>>>>>  target_ulong gprh[32]; /* 64 top bits of the 128-bit registers *=
/
> >>>>>>> @@ -386,6 +408,9 @@ struct CPUArchState {
> >>>>>>>  target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >>>>>>>
> >>>>>>>  PMUFixedCtrState pmu_fixed_ctrs[2];
> >>>>>>> +    PMUEventInfo *pmu_events;
> >>>>>>> +    PMUEventFunc pmu_efuncs;
> >>>>>>> +    int num_pmu_events;
> >>>>>>>
> >>>>>>>  target_ulong sscratch;
> >>>>>>>  target_ulong mscratch;
>
>

