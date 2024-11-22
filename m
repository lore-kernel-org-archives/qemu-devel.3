Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D6D75E30
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tESI0-0001kh-5B; Fri, 22 Nov 2024 06:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1tESHy-0001kL-M7; Fri, 22 Nov 2024 06:57:30 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1tESHw-0006F2-A4; Fri, 22 Nov 2024 06:57:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 4B972E0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1732275816;
 bh=ioAQwrSmmSALrKzDacXq0pcwNhsS9+sPLTjRqSNwCTs=;
 h=Content-Type:MIME-Version:Subject:From:Date:Message-ID:To:From;
 b=NO4O2us2vDGerj9XvE2EGLeJwNHMEEsbgYxaUBYPLeyhlAyjHCF8zhjm9kmA1MKAq
 /BM0sB7hemaoMKZ950tPz3xptcgr94BC95SFd6geaOMRdY/SEVoKdvNZ9Wn3LkKDK6
 RHdxA6T7TjXA1f44SCPJF/cdxRV+XWBtRPIU7+kag9nga4bQdAyZHzhyq8TkEtsvBQ
 hg4vZ5XG62sz24blpe8z89l5qZ42yN9yZRAGwte7rpf22oeUSSoKI95Z3MOo4My+Qd
 qTRKHsb3hkS5Ee3EDeh2bspqvGAS0/VnifDUrNXXW0y92oFwBWs+HKhWQlztZizGsN
 /AongbzISwanQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1732275816;
 bh=ioAQwrSmmSALrKzDacXq0pcwNhsS9+sPLTjRqSNwCTs=;
 h=Content-Type:MIME-Version:Subject:From:Date:Message-ID:To:From;
 b=j7IRBzvtcAVa0+1Tq3sC3yWFevr1P+f/Tq8cdW5aMYWq1WHYIr5hxbK8cW+gcHbLH
 WXIQvAHDc/tbuvoMIYKikZMOSOELt5Nzca0T0rrY4ZBrWf9PzcLYpwAJnAWi6HaABq
 5xgiOcGfyRAGVjfqQrg66A2ax0O282J+Yt8gM94gZnaRdD0toc0aVq7DrbX7SuidOE
 VRHlkgAj0aGIP0EqJb5DrDYEpFWcKGfRQ8D1OJcDOJZqPH0LwlneQIb+h0VVZFtdc6
 G53pqViIUWq0BaPN2/xQ1a2PBF6OSsujMsouvEwrR09BauOFE3I3odPVVvn6GIBX3h
 z+FMXQ8UPz6Mw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
From: Aleksei Filippov <alexei.filippov@syntacore.com>
In-Reply-To: <CAHBxVyGU1nbY5HC7dk4fhWNEJP8EPP-eNxhNU992usQi7Cim7w@mail.gmail.com>
Date: Fri, 22 Nov 2024 14:43:24 +0300
CC: Aleksei Filippov <alexei.filippov@syntacore.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <alistair.francis@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-ID: <DBECF034-EC77-4165-A571-902B86C81EE6@syntacore.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
 <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
 <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
 <CAHBxVyER0Lxp0uwed7ANW6d6pD1gvSVQ8b245scd+tm7HpT9ag@mail.gmail.com>
 <0214DDE7-28F3-48C1-96ED-E700764D95D3@syntacore.com>
 <CAHBxVyGU1nbY5HC7dk4fhWNEJP8EPP-eNxhNU992usQi7Cim7w@mail.gmail.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



> On 21 Nov 2024, at 22:54, Atish Kumar Patra <atishp@rivosinc.com> =
wrote:
>=20
> On Wed, Nov 20, 2024 at 6:25=E2=80=AFAM Aleksei Filippov
> <alexei.filippov@syntacore.com> wrote:
>>=20
>>=20
>>=20
>>> On 22 Oct 2024, at 15:58, Atish Kumar Patra <atishp@rivosinc.com> =
wrote:
>>>=20
>>> On Mon, Oct 21, 2024 at 6:45=E2=80=AFAM Aleksei Filippov
>>> <alexei.filippov@syntacore.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 11 Oct 2024, at 23:45, Atish Kumar Patra <atishp@rivosinc.com> =
wrote:
>>>>>=20
>>>>> On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
>>>>> <alexei.filippov@yadro.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> On 10.10.2024 02:09, Atish Patra wrote:
>>>>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>>>>>> ---
>>>>>>> target/riscv/cpu.h | 25 +++++++++++++++++++++++++
>>>>>>> 1 file changed, 25 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>>>>> index 2ac391a7cf74..53426710f73e 100644
>>>>>>> --- a/target/riscv/cpu.h
>>>>>>> +++ b/target/riscv/cpu.h
>>>>>>> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
>>>>>>>      uint64_t counter_virt_prev[2];
>>>>>>> } PMUFixedCtrState;
>>>>>>>=20
>>>>>>> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
>>>>>>> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
>>>>>>> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, =
MMUAccessType access_type);
>>>>>>> +
>>>>>>> +typedef struct PMUEventInfo {
>>>>>>> +    /* Event ID (BIT [0:55] valid) */
>>>>>>> +    uint64_t event_id;
>>>>>>> +    /* Supported hpmcounters for this event */
>>>>>>> +    uint32_t counter_mask;
>>>>>>> +    /* Bitmask of valid event bits */
>>>>>>> +    uint64_t event_mask;
>>>>>>> +} PMUEventInfo;
>>>>>>> +
>>>>>>> +typedef struct PMUEventFunc {
>>>>>>> +    /* Get the ID of the event that can monitor cycles */
>>>>>>> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
>>>>>>> +    /* Get the ID of the event that can monitor cycles */
>>>>>>> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
>>>>>>> +    /* Get the ID of the event that can monitor TLB events*/
>>>>>>> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
>>>>>> Ok, this is kinda interesting decision, but it's not scalable. =
AFAIU
>>>>>=20
>>>>> Yes it is not scalable if there is a need to scale as mentioned =
earlier.
>>>>> Do you have any other events that can be emulated in Qemu ?
>>>>>=20
>>>>> Having said that, I am okay with single call back though but not =
too sure
>>>>> about read/write callback unless there is a use case to support =
those.
>>>>>=20
>>>>>> none spec provide us full enum of existing events. So anytime =
when
>>>>>> somebody will try to implement their own pmu events they would =
have to
>>>>>> add additional callbacks, and this structure never will be fulled
>>>>>> properly. And then we ended up with structure 1000+ callback with =
only 5
>>>>>> machines wich supports pmu events. I suggest my approach with =
only
>>>>>> read/write callbacks, where machine can decide by itself how to =
handle
>>>>>> any of machine specific events.
>>>>>=20
>>>>> Lot of these events are microarchitectural events which can't be
>>>>> supported in Qemu.
>>>>> I don't think it's a good idea at all to add dummy values for all =
the
>>>>> events defined in a platform
>>>>> which is harder to debug for a user.
>>>>=20
>>>> Yes, you're right that the rest of the events are =
microarchitectural and that they can't be properly simulated in QEMU at =
the moment, but it seems to me that's not really the point here. The =
point is how elastic this solution can be - that is, whether to do any =
events or not and how exactly they should be counted should be decided =
by the vendor of a particular machine, and not by the simulator in =
general. Plus, I have a very real use case where it will come in handy - =
debugging perf. Support the possibility of simulating events on QEMU =
side will make the life of t perf folks much easier. I do not insist =
specifically on my implementation of this solution, but I think that the =
solution with the creation of a callback for each of the events will =
significantly complicate the porting of the PMU for machine vendors.
>>>>>=20
>>>=20
>>> As I mentioned in other threads, I am absolutely okay with single =
call
>>> backs. So Let's do that. However, I am not in favor of adding
>>> microarchitectural events that we can't support in Qemu with
>>> completely bogus data. Debugging perf in Qemu can be easily done =
with
>>> the current set of events supported. Those are not the most accurate
>>> but it's a representation of what Qemu is running. Do you foresee =
any
>>> debugging issue if we don't support all the events a platform
>>> advertises ?
>> In general - there is only one potential problem. When perf would try =
to get event by the wrong id. The main algorithm indeed could be tested =
with limited  quantities of events. But this
>=20
> It won't get a wrong id as the Qemu platform won't support those.
> Hence, you can not run perf for those events to begin with.
>=20
>> gonna be a real pain for the testers which gonna deduce and remember =
what particular event can/can=E2=80=99t be counted in QEMU and why does =
he gets 0 there and not 0 here. Moreover,
>=20
>> perf list will show which events are supported on a particular =
platform. So user won't be confused. We
>=20
>> we would allow events with even complete bogus data this would works =
perfectly for CI stuff for the benchmark + perf ppl, and they wouldn=E2=80=
=99t restrict their CI to that. I really do  not see
>=20
> IMO, it is more confusing to show bogus data rather than restricting
> the number of events an user can run on Qemu platforms. Clearly, you
> think otherwise. I think we can agree to disagree here. Let's
> consolidate our patches to provide the infrastructure for the actual
> events. The bogus event support can be a separate series(per vendor)
> as that warrants a different discussion whether it is useful for users
> or not.
>=20
> Sounds good ?
Yeah, it=E2=80=99s even better to do it separately, agreed. Do you want =
me to do
 general part? Or we gonna split it in some way?
>=20
> any problem to let the vendor handle this situation. At least vendor
> can decide by his own to count/not to count some types of event, this
> gonna bring flexibility and the transparency of the solution and, in
> general, if we=E2=80=99ll bring some rational reason why we can't add =
such
> events we can always forbid to do such thing.
>>>=20
>>>>>=20
>>>>>>> +} PMUEventFunc;
>>>>>>> +
>>>>>>> struct CPUArchState {
>>>>>>>  target_ulong gpr[32];
>>>>>>>  target_ulong gprh[32]; /* 64 top bits of the 128-bit registers =
*/
>>>>>>> @@ -386,6 +408,9 @@ struct CPUArchState {
>>>>>>>  target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>>>>>>>=20
>>>>>>>  PMUFixedCtrState pmu_fixed_ctrs[2];
>>>>>>> +    PMUEventInfo *pmu_events;
>>>>>>> +    PMUEventFunc pmu_efuncs;
>>>>>>> +    int num_pmu_events;
>>>>>>>=20
>>>>>>>  target_ulong sscratch;
>>>>>>>  target_ulong mscratch;



