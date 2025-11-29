Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C076FD116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 21:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPSZj-0003xa-FA; Sat, 29 Nov 2025 16:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPSZh-0003vU-40; Sat, 29 Nov 2025 16:33:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vPSZf-0007Mx-4L; Sat, 29 Nov 2025 16:33:48 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATIpwYo008694;
 Sat, 29 Nov 2025 21:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=akrIXA
 9KcRQ+ijdGechK3pxQ8HWOKVo+GHl50DDT5k4=; b=WRZTcC/gkeq4jGvdpeww4Z
 Uizw58W1CYbJWMBBYEtUPtRB1V+qotPa8HuMw8I/MIP51aimRZEXuk/5KS4ie2Yv
 GMV42G2NKBMo+WpPJhp7d0kMXFb8Ve/BFqXGYYZyb7UwjDAsouKTKf10vVjPlb2e
 n0V2cZBRLts30S90V7CqT2sfW97qnkHzM9hFGCVNAPl/k8qR8EhatlWmKxGzHzI/
 6Slz4kL+HC7UmxxkiNxys01Z2F+uXlmHJMgTZ7lYWF15NdS7fuVJozI+GCDeyKqk
 /L3/6vfUBDzXKYZOsq4xkKPcFGqSf+7iAcVHiDJKWMm0JD+BwlHkbbb39h+DU8Dg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6hpnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Nov 2025 21:33:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATK1gi7027443;
 Sat, 29 Nov 2025 21:33:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4hkbbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Nov 2025 21:33:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ATLXect28836398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Nov 2025 21:33:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25C1E20043;
 Sat, 29 Nov 2025 21:33:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DACDF20040;
 Sat, 29 Nov 2025 21:33:39 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 29 Nov 2025 21:33:39 +0000 (GMT)
Message-ID: <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Date: Sat, 29 Nov 2025 22:33:39 +0100
In-Reply-To: <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692b66b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Nu0YOgDW9tCwb_60XP8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FdRj0EQTuWl4Pk-s2tLVJ6l_S45p3rpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX2ZuuOU6Ac0x6
 AvHTFS9RGCLQEQyMa+kjBP1jdptsoAImZSuwNH/BoWS+OAi5S8G31np8l+fXJ1HU9UrU+4X2VDp
 CRfvH5F+il9LKUj2nX1tHAOQUhAtxhlGjjiPo9wwMkZj0qz4rgNZmf/GBlEE+PRcaSLm4Bwq6Rb
 OWrNdeewYg16cE4pR/rxJZjXTN3FyIAH9dKrYPaVCDMquyaIrSVV+OQRrFg+GBx2vwfTcLDnUjO
 4g9P6qLjJuUB8W82Ns4BsYMZrQ/vKp1GXEhqMJ5efsvZGGrj+u3xrfS7ansJf19AaFdWjLNxDi5
 ZhX6EwdrZMgIuNUZB2S2VA8HwJf6Jigm8WXmk/HpwAGbwefXEJ7jFlRpRRRBFTtAgJ8UdZ46bAy
 yMX1QkOk605/Y1ylCLb+x/8fBQHVhw==
X-Proofpoint-ORIG-GUID: FdRj0EQTuWl4Pk-s2tLVJ6l_S45p3rpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
> On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >=20
> > We just have to make sure that we can set the endianness to big
> > endian,
> > then we can also run this test on s390x.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> > =C2=A0Marked as RFC since it depends on the fix for this bug (so it
> > cannot
> > =C2=A0be merged yet):
> > =C2=A0
> > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218212818891=
@redhat.com
> > /
> >=20
> > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
> > ++++++++++++++++++++
> > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100755 tests/functional/s390x/test_reverse_debug.py
>=20
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
>=20
> I have a simple fix which helps with your original report, but not
> with this test. I'm still investigating.
>=20
> --- a/target/s390x/machine.c
> +++ b/target/s390x/machine.c
> @@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_vcpu_interrupt_=
pre_save(cpu);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure symmetry with =
cpu_post_load() with respect to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CHECKPOINT_CLOCK_VIRT=
UAL.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_tod_updated(CPU(cpu)=
, RUN_ON_CPU_NULL);
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}

Interestingly enough, this patch fails only under load, e.g., if I run
make check -j"$(nproc)" or if I run your test in isolation, but with
stress-ng cpu in background. The culprit appears to be:

s390_tod_load()
  qemu_s390_tod_set()
    async_run_on_cpu(tcg_s390_tod_updated)

Depending on the system load, this additional tcg_s390_tod_updated()
may or may not end up being called during handle_backward(). If it
does, we get an infinite loop again, because now we need two
checkpoints.

I have a feeling that this code may be violating some record-replay
requirement, but I can't quite put my finger on it. For example,
async_run_on_cpu() does not sound like something deterministic, but
then again it just queues work for rr_cpu_thread_fn(), which is
supposed to be deterministic.

