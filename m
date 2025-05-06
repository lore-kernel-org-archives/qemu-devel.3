Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC24C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBxq-0003cy-Eu; Tue, 06 May 2025 02:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uCBxo-0003ce-4b; Tue, 06 May 2025 02:39:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uCBxl-0007zV-DH; Tue, 06 May 2025 02:39:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3EPV017980;
 Tue, 6 May 2025 06:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EYwsBo
 QgDsOCDZFXdZn+Og702/+D5DihchxDV65A3Ks=; b=Hp0an0BFOr4P9cBLXnbGao
 qHVqOtnqCwkHpg4WH4kk1kjzKFzI3EhXrEQAdFmtjgXqh+kSnyyrjHsc7hobOpGA
 a4hgSCFAXT+OzEuJGIOR/eiSm+VzERIo7jKWog5QGclqTT3aJfaTZv+0vUc0Clz0
 emaKg8V5ivVfTCky5Noqw+TDVGBxPm7khkprc/GprcRlP4sxYQj5kTMPca5jyTg3
 TNh1UZfw0ZXSXqugUz6/2qRB1opwGBigsAyHiywmjFM+JOA6VwK3gMBwgma7rZbi
 vBhu80IXsX9dcT6wQFuyoVyzvQldj9ZUtruA9V/cjmPZgd1Mla+4DtMdSiGj5JLQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkhr9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 06:39:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54658Enn032235;
 Tue, 6 May 2025 06:39:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxymj1x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 06:39:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5466dNAm13828448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 06:39:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F9F20043;
 Tue,  6 May 2025 06:39:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A5E020040;
 Tue,  6 May 2025 06:39:23 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.155.197.178])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 May 2025 06:39:23 +0000 (GMT)
Message-ID: <a8b3e90442fddf914a4013dd93dc8f24aa684368.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] hw/s390x: compat handling for backward migration
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Tue, 06 May 2025 08:39:23 +0200
In-Reply-To: <7390ada124fe80862e7661672c75fda4@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-5-shalini@linux.ibm.com>
 <cabf1f945a3072e3eada75ceae828bd346855e9d.camel@linux.ibm.com>
 <7390ada124fe80862e7661672c75fda4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=6819aea1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=1KT9R8tGSRl_Qt75he0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bWR3UpR2kt2dQJGcR3JzXoPYUiARYyMS
X-Proofpoint-GUID: bWR3UpR2kt2dQJGcR3JzXoPYUiARYyMS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MSBTYWx0ZWRfX13ZWOzynFZ3N
 Ek6vl2VRmX68QMDQAj2YZNK8PjPLKLN4x4Kc1gf1XbjvUNGNNWwg/Vof0UPO4p5BakuIX1rUH3a
 W7jI3X2Q9WXaK4VNfVIqfNTFFSNkbbShMmc5qhfb+0Vm9DqEvPP4NSGTLFfiaWA5PoLJG+iXib6
 5grQEXOOostbc7H3++I06pJJgNDDpw4S23WO56hCr4nHN4VcU1RwrtBM1suo9Vm7Rz22hgwpEgP
 tF6yPG5itqEKXZZy5b2VSQFOvNbpaHmg9rrJ0bkGTyBaVRcLr572rPyI0DsEW/1yFfFUBw5KAB6
 w5HaS2qcqZK7W09jIKLeGuSqkETzRtntRnr6mwhBkJ6AxHTNE9AADZoMv49iF3MuNLiQYec0sv0
 BkFXWAyx/iVflCFVp4WoPNR/UmFFYKhKfDpbUZVBws+ak0Pc8I71e+HnnTdDkexHJdNISvBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 2025-05-05 at 10:54 +0200, Shalini Chellathurai Saroja wrote:
> On 2025-04-28 14:05, Nina Schoetterl-Glausch wrote:
> > On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> > > Add Control-Program Identification (CPI) device to QOM only when the=
=20
> > > virtual
> > > machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0"=
=20
> > > machine
> > > and higher.
> > >=20
> > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > ---
> > >  hw/s390x/s390-virtio-ccw.c         | 10 +++++++++-
> > >  include/hw/s390x/s390-virtio-ccw.h |  1 +
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > > index 7f28cbd1de..81832ee638 100644
> > > --- a/hw/s390x/s390-virtio-ccw.c
> > > +++ b/hw/s390x/s390-virtio-ccw.c

[...]

> > Fixing this in a separate commit could be bad for bisecting.
>=20
> Ok.
>=20
> > You introduce use_cpi in an earlier commit set to false and
> > then flipping it in the migration patch for new machines.
> > This way there is no broken intermediate state.
> >=20
> > I would also squash the compat migration changes into the previous
> > patch.
> >=20
>=20
> Hello Nina,
>=20
> If use_cpi is set to false in patch 1, then the sclpcpi device will not=
=20
> be instantiated even for new machines at that point. The sclpcpi device=
=20
> will only be instantiated when the use_cpi is set to true in the=20
> migration patch.
>=20
> I prefer to squash this entire patch to patch 1, then the sclpcpi device=
=20
> will only be instantiated for new machines with the code in patch 1=20
> itself and will not be dependent on the migration patch. I like this=20
> approach as the logic to add sclpcpi device is complete in patch 1.
>=20
> What do you think?, thank you.

Sounds good!

[...]


--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

