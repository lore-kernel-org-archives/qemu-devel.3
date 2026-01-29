Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A69D73E8C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZWd-00058S-PQ; Thu, 29 Jan 2026 16:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZWc-00055I-D6; Thu, 29 Jan 2026 16:26:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZWa-00077z-Gj; Thu, 29 Jan 2026 16:26:02 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEjOEk029483;
 Thu, 29 Jan 2026 21:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kb0GX+
 JBV/Z4Nw86iEGXNtjwXdFm8rxn1QVW6ps1WyA=; b=LQlJoi4OUxO8lIcfZfv2j8
 /+wjwXJPuhfRJHB5BtG9nHKj0oZ8jbvXfZEDakGkfqWYca2lz97dX46j/57RuWH8
 3ibMdI73Co8jWEDEAKu4woibAganZSayAQ5in2k6lbltNFVuR3RMyRs5/ZHaZu7i
 LuJZp6D/28YWLyFu/vU2Bbpe8kEkbCPSGI8ch3JgeJr/1hM8zUwZ4SPpfK86Ho+U
 e6TudmdWrzpimAS+PqRkqS58L8Fm0fUpWISY3jpnzzOtxjRlAKfxqWSa4EEJtHLX
 w97mxbzeZ6Dc8Gpf+gWV09glc8VQNnGd+BA0nqBKClemTutp/c1nVZCXdYHXxLtg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt831ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:25:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TIwmet031048;
 Thu, 29 Jan 2026 21:25:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsuuba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:25:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TLPrhw11993656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:25:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14F8A58052;
 Thu, 29 Jan 2026 21:25:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D1058045;
 Thu, 29 Jan 2026 21:25:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.53.37]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 21:25:49 +0000 (GMT)
Message-ID: <91e0d6ec25b8cfc62e690a7452d5c193936f65bb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/14] pc-bios/s390-ccw: Remove redundant vring schid
 attribute
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, jrossi@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 29 Jan 2026 16:25:48 -0500
In-Reply-To: <a21c41cc-3da9-4820-9980-023a8e197fbb@redhat.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-3-jrossi@linux.ibm.com>
 <a21c41cc-3da9-4820-9980-023a8e197fbb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LUgPYpZX9IrVpS5UC-ytcDiDuiwlSQTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1NSBTYWx0ZWRfX85vDk9LFLVhT
 fjtwFaev3wnRRtEUJJlSClOzIuUKju0eAf1ONCjCGD3PDi3O2OwkwW7NqTMrNdfzJwcC5/+4Pff
 r7X77GUcHwRa2uEpoLFQo1qEPNoBnH6seZmgOvRxJ7u0MghncektJ4KHn5Ptbe8WWKPSvVwtHP9
 pz2R7NEOTNq7PSZ9zrhMlyb/kN8vETGS75dV6YBCCYztagvh1vA5kYUIBrEpAKel94k3SvxgMdZ
 c4hUbqIGCfFL7OSHRjOkisViaNxBw1yjb1o4udtV/cVyClLKZEmc2zsY3MIl2opAwYF+f+BUv4X
 2jXn/lEMiJbfAs0qomn5qblZxit0AxKF/vM5ie3te3Bbd2D4kX6Q7AJmR8T5gPPo36QBTqSomTz
 ODBXrCGOeBO5EwakDvOmGskL/HPSM3XNY1/DZGfc2z6oQlau4OlqNYd0YvTdoDV0uQIBHvQzCkA
 8GkeWM0tzsMEgKSMyzQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697bd063 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=7c-yTx2yABycnVvCHqoA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LUgPYpZX9IrVpS5UC-ytcDiDuiwlSQTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2026-01-29 at 11:31 +0100, Thomas Huth wrote:
> On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> > From: Jared Rossi <jrossi@linux.ibm.com>
> >=20
> > The schid is already stored as an attribute of the VDev itself and any =
other
> > instances are copies of this same value.  To avoid CCW specific attribu=
tes in
> > the VRing let's just access the existing VDev schid attribute as needed=
.
> >=20
> > Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> > ---
> >   pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
> >   pc-bios/s390-ccw/virtio-net.c    | 2 +-
> >   pc-bios/s390-ccw/virtio.c        | 9 ++++-----
> >   pc-bios/s390-ccw/virtio.h        | 3 +--
> >   4 files changed, 7 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio=
-blkdev.c
> > index 4b819dd80f..019c2718b1 100644
> > --- a/pc-bios/s390-ccw/virtio-blkdev.c
> > +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> > @@ -42,7 +42,7 @@ static int virtio_blk_read_many(VDev *vdev, unsigned =
long sector, void *load_add
> >       /* Now we can tell the host to read */
> >       vring_wait_reply();
> >  =20
> > -    if (drain_irqs(vr->schid)) {
> > +    if (drain_irqs()) {
> >           /* Well, whatever status is supposed to contain... */
> >           status =3D 1;
> >       }
> Just a thought: Maybe we should rather get rid of the global access to th=
e=20
> "vdev" in the long run (in case we ever want to deal with multiple device=
s=20
> at once), so it might be nicer to add a "VDev *vdev" parameter to the=20
> drain_irqs() function now instead of making its parameter list "void".=
=20
> Anyway, it's just a thought, we can also still tackle this later if neede=
d,=20
> so I'm also fine with this patch as it:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I agree. Removing that global access to the vdev would be a good goal, sinc=
e it's sometimes passed
around today and sometimes not, and this series highlights that oddity. But=
, that doesn't need to be
addressed at this particular moment. So...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

