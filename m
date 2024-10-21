Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB7D15D95
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2siv-0007Xv-Pw; Mon, 21 Oct 2024 09:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1t2sin-0007X0-CE; Mon, 21 Oct 2024 09:45:22 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1t2sid-0002xp-PS; Mon, 21 Oct 2024 09:45:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com DF35BE001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1729518301;
 bh=tBX5ec73e5MHzQfX6Yy9HVxhOwBUdy1VGBTCJcOxUA0=;
 h=Content-Type:MIME-Version:Subject:From:Date:Message-ID:To:From;
 b=VFzq/MHPVTb29jwSQ2maxO5keKrCxEEKi5vDz5H+JEYepSlzqbwRyLN3zsPSKuvqV
 kigvIWsa0g4/xhA5NdV8fuEShyRORJqDfKClVYpKVbJkl5lzxmvZOMKoLTuB14VI5d
 0FIBdHiT6DWVuolBvrj7uW5rJN0+m6v54YAfowSuoVOoRdeaZg8kNWSrE5pkz5603F
 w7SI2fKxt5uA0od61rNNH7j6Hy1qRqGmGGTQRXUphjx/JGC6/o+INOVylmIfAOlsU8
 IzykKySHG66CzazS8GqF7w2diBR2Lu7jxfNPlgIgFdTq0PuF6dcfCHCLHxyw+e1vns
 7WQvza1nQ9zLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1729518301;
 bh=tBX5ec73e5MHzQfX6Yy9HVxhOwBUdy1VGBTCJcOxUA0=;
 h=Content-Type:MIME-Version:Subject:From:Date:Message-ID:To:From;
 b=qGTOqDuBzB1i6gP0E1mcsomSv3dJqgzRxWsxtj0Yd2S0eQ1wrQlHfYIavAfQFPzk+
 MutOBx8K1ocb2cj3djqYMten+QiPSVZwpsgDcNXuCBzGPlPP+dY7XF0J7IDt1zs6wB
 D3bnU9lzeZ2q59FNfpOip5OAz5dHuYv24UGhP73/S2EZRRj+12HQwJQcmjy+n2CBkN
 +qtuZv/G5PNrsPH7wmrobiEeRbQOCT1rDWiwb6ek4mGC0pgfDlZiWYlkHN/DZRP47b
 r+SBVMUc8+I1/v2/v5js5O5iOOh6HmJj+gSTUzF9APqTcnFecJUAIQd+T9N9AdOJC6
 NJKdOJ2gvo9sg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
From: Aleksei Filippov <alexei.filippov@syntacore.com>
In-Reply-To: <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
Date: Mon, 21 Oct 2024 16:44:39 +0300
CC: Aleksei Filippov <alexei.filippov@syntacore.com>, Alexei Filippov
 <alexei.filippov@yadro.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <alistair.francis@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-ID: <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
 <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 11 Oct 2024, at 23:45, Atish Kumar Patra <atishp@rivosinc.com> =
wrote:
>=20
> On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
> <alexei.filippov@yadro.com> wrote:
>>=20
>>=20
>>=20
>> On 10.10.2024 02:09, Atish Patra wrote:
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>  target/riscv/cpu.h | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>=20
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 2ac391a7cf74..53426710f73e 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
>>>          uint64_t counter_virt_prev[2];
>>>  } PMUFixedCtrState;
>>>=20
>>> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
>>> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
>>> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType =
access_type);
>>> +
>>> +typedef struct PMUEventInfo {
>>> +    /* Event ID (BIT [0:55] valid) */
>>> +    uint64_t event_id;
>>> +    /* Supported hpmcounters for this event */
>>> +    uint32_t counter_mask;
>>> +    /* Bitmask of valid event bits */
>>> +    uint64_t event_mask;
>>> +} PMUEventInfo;
>>> +
>>> +typedef struct PMUEventFunc {
>>> +    /* Get the ID of the event that can monitor cycles */
>>> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
>>> +    /* Get the ID of the event that can monitor cycles */
>>> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
>>> +    /* Get the ID of the event that can monitor TLB events*/
>>> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
>> Ok, this is kinda interesting decision, but it's not scalable. AFAIU
>=20
> Yes it is not scalable if there is a need to scale as mentioned =
earlier.
> Do you have any other events that can be emulated in Qemu ?
>=20
> Having said that, I am okay with single call back though but not too =
sure
> about read/write callback unless there is a use case to support those.
>=20
>> none spec provide us full enum of existing events. So anytime when
>> somebody will try to implement their own pmu events they would have =
to
>> add additional callbacks, and this structure never will be fulled
>> properly. And then we ended up with structure 1000+ callback with =
only 5
>> machines wich supports pmu events. I suggest my approach with only
>> read/write callbacks, where machine can decide by itself how to =
handle
>> any of machine specific events.
>=20
> Lot of these events are microarchitectural events which can't be
> supported in Qemu.
> I don't think it's a good idea at all to add dummy values for all the
> events defined in a platform
> which is harder to debug for a user.

Yes, you're right that the rest of the events are microarchitectural and =
that they can't be properly simulated in QEMU at the moment, but it =
seems to me that's not really the point here. The point is how elastic =
this solution can be - that is, whether to do any events or not and how =
exactly they should be counted should be decided by the vendor of a =
particular machine, and not by the simulator in general. Plus, I have a =
very real use case where it will come in handy - debugging perf. Support =
the possibility of simulating events on QEMU side will make the life of =
t perf folks much easier. I do not insist specifically on my =
implementation of this solution, but I think that the solution with the =
creation of a callback for each of the events will significantly =
complicate the porting of the PMU for machine vendors.
>=20
>=20
>>> +} PMUEventFunc;
>>> +
>>>  struct CPUArchState {
>>>      target_ulong gpr[32];
>>>      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers =
*/
>>> @@ -386,6 +408,9 @@ struct CPUArchState {
>>>      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>>>=20
>>>      PMUFixedCtrState pmu_fixed_ctrs[2];
>>> +    PMUEventInfo *pmu_events;
>>> +    PMUEventFunc pmu_efuncs;
>>> +    int num_pmu_events;
>>>=20
>>>      target_ulong sscratch;
>>>      target_ulong mscratch;



