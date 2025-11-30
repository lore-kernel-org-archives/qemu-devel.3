Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C1FD116F3
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 18:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPmDs-00043p-An; Sun, 30 Nov 2025 13:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPmDg-00042T-Fe; Sun, 30 Nov 2025 13:32:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPmDd-0001dm-9F; Sun, 30 Nov 2025 13:32:23 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUBHHgb009438;
 Sun, 30 Nov 2025 18:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zhFPdJ
 T3bjbt52ILWC1AQ6cNyfHmsZDw1nsqzdQLm9s=; b=M1cliINi89Z2lQkldfSdm5
 jqmD/uZ+67Sp8GBGSTe7BJxagvu6wNabefZ6Uic6xjLGbVytn4F04i6UC3NdZri4
 H7xE/srwuwqhPzEXV/Ys8C+muwUwOY/aO9FGWPi0rooBl4MqIZHHb9q/WG8kIrB9
 aoNksZgdrDUdwtQumACjpvl2guxJNNsc4qQ+ErIs3t8KRGjCN81vDeM9czIcbDar
 8mPeGVyVR4a5NoezWySBiSjLqJ4LDN2BiIHPKnt0xifrCTX6xnNZ/FtFlfL7U3xH
 2kY0nv9s9hdvy+N/uIZtcr7q7AJ6ekcHJ6cOa+GB96/f3u/JqDdt9vdLtRhFBLHQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8pkx1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 18:32:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUDh2SS019133;
 Sun, 30 Nov 2025 18:32:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhxjkj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 18:32:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AUIWFNl31588680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Nov 2025 18:32:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C186A20043;
 Sun, 30 Nov 2025 18:32:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77DA420040;
 Sun, 30 Nov 2025 18:32:15 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Nov 2025 18:32:15 +0000 (GMT)
Message-ID: <4bf61173827c033f9591f637f83d1aedc056a51e.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Date: Sun, 30 Nov 2025 19:32:15 +0100
In-Reply-To: <87zf838o2w.fsf@draig.linaro.org>
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 <87zf838o2w.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX1GRI5SQgJDru
 mMyg52RrX4Ji+NjQ+RO6SkIi9lG/URU9WWcNlNaMhVIeSAnkDQtFqQixhKflapZTnTGbYpKWOvG
 InC2WjHwIpiniQoZBccZe9f9eQDAEtaZ4w6hzHP2/fifz24lZiMsNwsu36/xgMa+03mC0D0J7+w
 YqnICF0Inj93oSicWoix9Jgnf2XE0lKlEfOmqsJ3FPV9FehxoOd0sVDuloK8Y2udh8gLb9Jo9RY
 zjSY77yFkUb5OGk+3t5Hmn1vGUsSrKF15iJRr75mBVwkj3cKzVj1iT3w2aXSNAhVuJYbYLAJil4
 JIUodSWklAJUHvbQyRH8en+xpN8/xeBNJoWLSni5emjbco+NrZHtOoAp1pEn5Nh+yb3AfMGpXPz
 q3R6ar7i/Vs4bMuZEj+sUeW7H6wLqQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692c8db2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=5VzcDkeLdm_X6Ly6xmAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tuk6Bcp_eZP78hRkb8tcTTigLnCGpeUl
X-Proofpoint-GUID: tuk6Bcp_eZP78hRkb8tcTTigLnCGpeUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Sun, 2025-11-30 at 16:47 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
> > > On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
> > > > From: Thomas Huth <thuth@redhat.com>
> > > >=20
> > > > We just have to make sure that we can set the endianness to big
> > > > endian,
> > > > then we can also run this test on s390x.
> > > >=20
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > > =C2=A0Marked as RFC since it depends on the fix for this bug (so it
> > > > cannot
> > > > =C2=A0be merged yet):
> > > > =C2=A0
> > > > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-21821281=
8891@redhat.com
> > > > /
> > > >=20
> > > > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> > > > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
> > > > ++++++++++++++++++++
> > > > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
> > > > =C2=A0create mode 100755
> > > > tests/functional/s390x/test_reverse_debug.py
> > >=20
> > > Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > >=20
> > >=20
> > > I have a simple fix which helps with your original report, but
> > > not
> > > with this test. I'm still investigating.
> > >=20
> > > --- a/target/s390x/machine.c
> > > +++ b/target/s390x/machine.c
> > > @@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_vcpu_interr=
upt_pre_save(cpu);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure symmetry w=
ith cpu_post_load() with respect to
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CHECKPOINT_CLOCK_=
VIRTUAL.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_tod_updated(CPU(=
cpu), RUN_ON_CPU_NULL);
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0}
> >=20
> > Interestingly enough, this patch fails only under load, e.g., if I
> > run
> > make check -j"$(nproc)" or if I run your test in isolation, but
> > with
> > stress-ng cpu in background. The culprit appears to be:
> >=20
> > s390_tod_load()
> > =C2=A0 qemu_s390_tod_set()
> > =C2=A0=C2=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
> >=20
> > Depending on the system load, this additional
> > tcg_s390_tod_updated()
> > may or may not end up being called during handle_backward(). If it
> > does, we get an infinite loop again, because now we need two
> > checkpoints.
> >=20
> > I have a feeling that this code may be violating some record-replay
> > requirement, but I can't quite put my finger on it. For example,
> > async_run_on_cpu() does not sound like something deterministic, but
> > then again it just queues work for rr_cpu_thread_fn(), which is
> > supposed to be deterministic.
>=20
> The the async_run_on_cpu is called from the vcpu thread in response
> to a
> deterministic event at a known point in time it should be fine. If it
> came from another thread that is not synchronised via replay_lock
> then
> things will go wrong.
>=20
> But this is a VM load save helper?

Yes, and it's called from the main thread. Either during
initialization, or as a reaction to GDB packets.

Here is the call stack:

  qemu_loadvm_state()
    qemu_loadvm_state_main()
      qemu_loadvm_section_start_full()
        vmstate_load()
          vmstate_load_state()
            cpu_post_load()
              tcg_s390_tod_updated()
                update_ckc_timer()
                  timer_mod()
          s390_tod_load()
            qemu_s390_tod_set()  # via tdc->set()
              async_run_on_cpu(tcg_s390_tod_updated)

So you think we may have to take the replay lock around
load_snapshot()? So that all async_run_on_cpu() calls it makes end up
being handled by the vCPU thread deterministically.

