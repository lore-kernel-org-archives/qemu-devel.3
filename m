Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6340D111A8
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 23:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPqOt-0007IK-Nl; Sun, 30 Nov 2025 18:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPqOe-0007BM-3D; Sun, 30 Nov 2025 18:00:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPqOb-0002m1-KN; Sun, 30 Nov 2025 17:59:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUHlBjm027938;
 Sun, 30 Nov 2025 22:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=utzhin
 UWz8i9yxtaWdf0Wp1K5unJN/CUmE6fqFb8+UM=; b=O8I7nRKMn3IftYpCu/Hy8l
 nPVUSVndRVDagSOriaLkhCuVIS8izgyOY7F4jVF/6wZ7h976yFUujve+s78SA1Sx
 ooLtsYHkxS6kXOosFthYCS3AZ9Z4TnLvIZy3zXPd9VptAxumJW41zuPqSGr1omRt
 qe/VL2E0rCFXQ7xFco08BfrgpXLESkZinql9eP7qGtjVhu1Clf40P5xDFyle+H9d
 CSQytzz1FL5IUHz85EwOW36tTHRMBLTakmvBND6C4gtXXK2oQD8yOfa218KifNLu
 sc2u/5sa+Y+WU7EzIw8p8pfvDvv8tzB8s06W+sBlxiCLLSpOiCp3gvnkDdBjdqug
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9c6su-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 22:59:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUKd7ot010227;
 Sun, 30 Nov 2025 22:59:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnju30h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 22:59:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AUMxn9G57082138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Nov 2025 22:59:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4427F20040;
 Sun, 30 Nov 2025 22:59:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E845C20043;
 Sun, 30 Nov 2025 22:59:48 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Nov 2025 22:59:48 +0000 (GMT)
Message-ID: <6181bc6bd6b41f46a835cee58ab3215b8cefedb4.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Date: Sun, 30 Nov 2025 23:59:48 +0100
In-Reply-To: <dfc4b7b2bdb7a6678364516de03a23959965de1e.camel@linux.ibm.com>
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 <87zf838o2w.fsf@draig.linaro.org>
 <4bf61173827c033f9591f637f83d1aedc056a51e.camel@linux.ibm.com>
 <dfc4b7b2bdb7a6678364516de03a23959965de1e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iCcRYcxi-vSAQVywQmg1DDURyLnW-AxK
X-Proofpoint-ORIG-GUID: iCcRYcxi-vSAQVywQmg1DDURyLnW-AxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX/sc1gsp/Yz+d
 DB9PXsLui7FhjjX7qOQ/pqWlYPa0m73CqPdEa33KFkdiW8zqyTr4TvDZZykL2rGLGhd3WkPvWI8
 1bx1kwXKuiMl4nbAyBzu6kI3rX6k/3kTWwLvh57es/S3M6lbzag0neL0vaNfWRQOJNjJnzusEju
 3vLYumqscgU0jptqls8c8UCY3n8RUbWnD0SPM2Sq4a6mBqsX0IBzviEFHO9eaJgYE9unNgGBk/g
 zt2IQNvV2XVUn+P5B0SPqez9uKVyfnfMnhRxGbStvaq6ddO+AAHcOWTE+4ioeHQGSYOMXA56Boo
 ZNrM8tcu/HcP9Slh0ZUzYO7H/ozdhsIfQKHKeu2Kijf6syL8EyJpZSjJPclB95IbPMC680IKOLD
 vQqARTg1ivruIpLrZPXkJC777dkMQA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692ccc68 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=VsrWL010r-B5Yka6oDkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 2025-11-30 at 20:03 +0100, Ilya Leoshkevich wrote:
> On Sun, 2025-11-30 at 19:32 +0100, Ilya Leoshkevich wrote:
> > On Sun, 2025-11-30 at 16:47 +0000, Alex Benn=C3=A9e wrote:
> > > Ilya Leoshkevich <iii@linux.ibm.com> writes:
> > >=20
> > > > On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
> > > > > On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
> > > > > > From: Thomas Huth <thuth@redhat.com>
> > > > > >=20
> > > > > > We just have to make sure that we can set the endianness to
> > > > > > big
> > > > > > endian,
> > > > > > then we can also run this test on s390x.
> > > > > >=20
> > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > ---
> > > > > > =C2=A0Marked as RFC since it depends on the fix for this bug (s=
o
> > > > > > it
> > > > > > cannot
> > > > > > =C2=A0be merged yet):
> > > > > > =C2=A0
> > > > > > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-2182=
12818891@redhat.com
> > > > > > /
> > > > > >=20
> > > > > > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> > > > > > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > > > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
> > > > > > ++++++++++++++++++++
> > > > > > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
> > > > > > =C2=A0create mode 100755
> > > > > > tests/functional/s390x/test_reverse_debug.py
> > > > >=20
> > > > > Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > >=20
> > > > >=20
> > > > > I have a simple fix which helps with your original report,
> > > > > but
> > > > > not
> > > > > with this test. I'm still investigating.
> > > > >=20
> > > > > --- a/target/s390x/machine.c
> > > > > +++ b/target/s390x/machine.c
> > > > > @@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_vcpu_in=
terrupt_pre_save(cpu);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0
> > > > > +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure symmet=
ry with cpu_post_load() with respect
> > > > > to
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CHECKPOINT_CL=
OCK_VIRTUAL.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_tod_updated(=
CPU(cpu), RUN_ON_CPU_NULL);
> > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > =C2=A0}
> > > >=20
> > > > Interestingly enough, this patch fails only under load, e.g.,
> > > > if
> > > > I
> > > > run
> > > > make check -j"$(nproc)" or if I run your test in isolation, but
> > > > with
> > > > stress-ng cpu in background. The culprit appears to be:
> > > >=20
> > > > s390_tod_load()
> > > > =C2=A0 qemu_s390_tod_set()
> > > > =C2=A0=C2=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
> > > >=20
> > > > Depending on the system load, this additional
> > > > tcg_s390_tod_updated()
> > > > may or may not end up being called during handle_backward(). If
> > > > it
> > > > does, we get an infinite loop again, because now we need two
> > > > checkpoints.
> > > >=20
> > > > I have a feeling that this code may be violating some record-
> > > > replay
> > > > requirement, but I can't quite put my finger on it. For
> > > > example,
> > > > async_run_on_cpu() does not sound like something deterministic,
> > > > but
> > > > then again it just queues work for rr_cpu_thread_fn(), which is
> > > > supposed to be deterministic.
> > >=20
> > > The the async_run_on_cpu is called from the vcpu thread in
> > > response
> > > to a
> > > deterministic event at a known point in time it should be fine.
> > > If
> > > it
> > > came from another thread that is not synchronised via replay_lock
> > > then
> > > things will go wrong.
> > >=20
> > > But this is a VM load save helper?
> >=20
> > Yes, and it's called from the main thread. Either during
> > initialization, or as a reaction to GDB packets.
> >=20
> > Here is the call stack:
> >=20
> > =C2=A0 qemu_loadvm_state()
> > =C2=A0=C2=A0=C2=A0 qemu_loadvm_state_main()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_loadvm_section_start_full()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_load()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_load_sta=
te()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_=
post_load()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tcg_s390_tod_updated()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 update_ckc_timer()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_mod()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_tod_load()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu=
_s390_tod_set()=C2=A0 # via tdc->set()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
> >=20
> > So you think we may have to take the replay lock around
> > load_snapshot()? So that all async_run_on_cpu() calls it makes end
> > up
> > being handled by the vCPU thread deterministically.
>=20
> To answer my own question: apparently this is already the case; at
> least, the following does not cause any fallout:
>=20
> diff --git a/include/system/replay.h b/include/system/replay.h
> index 6859df09580..e1cd9b2f900 100644
> --- a/include/system/replay.h
> +++ b/include/system/replay.h
> @@ -60,6 +60,7 @@ extern char *replay_snapshot;
> =C2=A0
> =C2=A0void replay_mutex_lock(void);
> =C2=A0void replay_mutex_unlock(void);
> +bool replay_mutex_locked(void);
> =C2=A0
> =C2=A0static inline void replay_unlock_guard(void *unused)
> =C2=A0{
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 62cc2ce25cb..ba945d3a1ea 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3199,6 +3199,8 @@ bool save_snapshot(const char *name, bool
> overwrite, const char *vmstate,
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t vm_state_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 g_autoptr(GDateTime) now =3D g_date_time_new_now=
_local();
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 g_assert(replay_mutex_locked());
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 GLOBAL_STATE_CODE();
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate_can_snapshot(errp)) {
> @@ -3390,6 +3392,8 @@ bool load_snapshot(const char *name, const char
> *vmstate,
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incomi=
ng_get_current();
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 g_assert(replay_mutex_locked());
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate_can_snapshot(errp)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 75249b76936..30825a0753e 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -124,7 +124,6 @@ void replay_get_array_alloc(uint8_t **buf, size_t
> *size);
> =C2=A0 * synchronisation between vCPU and main-loop threads. */
> =C2=A0
> =C2=A0void replay_mutex_init(void);
> -bool replay_mutex_locked(void);
> =C2=A0
> =C2=A0/*! Checks error status of the file. */
> =C2=A0void replay_check_error(void);

I believe now I at least understand what the race is about:

- cpu_post_load() fires the TOD timer immediately.

- s390_tod_load() schedules work for firing the TOD timer.

- If rr loop sees work and then timer, we get one timer callback.

- If rr loop sees timer and then work, we get two timer callbacks.

- Record and replay may diverge due to this race.

- In this particular case divergence makes rr loop spin: it sees that
  TOD timer has expired, but cannot invoke its callback, because there
  is no recorded CHECKPOINT_CLOCK_VIRTUAL.

- The order in which rr loop sees work and timer depends on whether
  and when rr loop wakes up during load_snapshot().

- rr loop may wake up after the main thread kicks the CPU and drops
  the BQL, which may happen if it calls, e.g., qemu_cond_wait_bql().

