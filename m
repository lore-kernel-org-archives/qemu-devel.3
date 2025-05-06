Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F64C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCC6h-0004yX-BX; Tue, 06 May 2025 02:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uCC6f-0004xu-6o; Tue, 06 May 2025 02:48:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uCC6d-0000d2-Ar; Tue, 06 May 2025 02:48:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3qFp018853;
 Tue, 6 May 2025 06:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tKVz/M
 OLwsfPK/DvfmlgnSKWXTQ4adyqANvXRxQheYI=; b=EbRY/3DR91ER74ZsPmuRIR
 JLwX9L6K80KBuWAtq/JGV09PMulduy5xXLEUcrGl9hVu1rQQ8Z3VauhXCCs8CcIs
 E8MF2gBUvi+1Z7mU/7RbnxJOwecEiIW9pyXJ/WsdOYKNEp/3F1DRpuNc/yBst912
 a5QC4X4oOxRPBAkIBaj5F+IfHJqndeI76SOe0Hkc2LWYen7HydjMP5TTIcnhvQvH
 vyxxXsQz/Nw+YCyHtS3qyFBr7D5B82lIgJh8JauGD4ZiVBTXf1LETLSppvKFUio4
 NCFvJ9hL3iwEa36Aa/9kZsLj8wxMJ91E9FTpXrcrV2YaQ1oKfICWY4mGhlocsfLA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkhs7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 06:48:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5466ArnB013823;
 Tue, 6 May 2025 06:48:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e0629tb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 06:48:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5466ma1S52691286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 06:48:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FCF02004B;
 Tue,  6 May 2025 06:48:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48BBB20043;
 Tue,  6 May 2025 06:48:36 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.155.197.178])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 May 2025 06:48:36 +0000 (GMT)
Message-ID: <db6dbf5b1baf3a6ada04168ecf9fde24890cc1c1.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>
Date: Tue, 06 May 2025 08:48:35 +0200
In-Reply-To: <ad66ac925ff301a945ac1f56fc1d31cc@linux.ibm.com>
References: <ad66ac925ff301a945ac1f56fc1d31cc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=6819b0c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=5DsEzSXuO-3abciyU0gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9GFmYnmC3PHrx0jMoRSrvu3FBsxY2DM_
X-Proofpoint-GUID: 9GFmYnmC3PHrx0jMoRSrvu3FBsxY2DM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MSBTYWx0ZWRfX7zg9ZckZXuK1
 STb1EukULdP92sl2ZR2hYO8T+if5f0OfEoh86MXbaGNm0os0PgHxmyXjO3bIQfxKjP8PdxO3rU/
 POmdzdi6KIwI4JHIBqcakIq4IRgBgPM2BOP9a7383DzhOiZ0CryvNgm89q3BPbGue4AXyyNJBzh
 34VAeJJg77VKoNsvn0clIhs0HeNI5bX/jF9lpHbsskB1ei4UcovNhvEngz+nwY1qRe7v0X2NMKS
 YyOB5JrPlA343bgJF/831u4IByFsP59Yfz6a/W5VmsK8ruVAOa6YvL+cmFiScsXFfzpe3j2v36F
 Yf1h6yN3S5yhN7e3oyTR4CS8CfmRuBiUJw216g2YZ77COwjqRR6CANnVNSSzg49GN84BXtf+WkD
 +aq0rRRqIbZoDQqNRXVHcAZpxeSveIHefri68mgziASnQIR1HjYko5wNrUOKUJq0ooauFoU9
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

On Mon, 2025-05-05 at 08:55 +0200, Shalini Chellathurai Saroja wrote:
> On 2025-04-28 11:22, Janis Schoetterl-Glausch wrote:
> > On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> > > Implement the Service-Call Logical Processor (SCLP) event
> > > type Control-Program Identification (CPI) in QEMU. This
> > > event is used to send CPI identifiers from the guest to the
> > > host. The CPI identifiers are: system type, system name,
> > > system level and sysplex name.
> > >=20
> > > System type: operating system of the guest (e.g. "LINUX").
> > > System name: user configurable name of the guest (e.g. "TESTVM").
> > > System level: distribution and kernel version, if the system type is=
=20
> > > Linux
> > > (e.g. 0x50e00).
> > > Sysplex name: name of the cluster which the guest belongs to (if any)
> > > (e.g. "PLEX").
> > >=20
> > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >  hw/s390x/event-facility.c         |  2 +
> > >  hw/s390x/meson.build              |  1 +
> > >  hw/s390x/s390-virtio-ccw.c        | 14 +++++
> > >  hw/s390x/sclpcpi.c                | 92=20
> > > +++++++++++++++++++++++++++++++
> > >  include/hw/s390x/event-facility.h | 13 +++++
> > >  5 files changed, 122 insertions(+)
> > >  create mode 100644 hw/s390x/sclpcpi.c
> > >=20
> > > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > > index 2b0332c20e..60237b8581 100644
> > > --- a/hw/s390x/event-facility.c
> > > +++ b/hw/s390x/event-facility.c

[...]

> It is possible to add the identifiers directly as the properties of=20
> sclpcpi (eg. system type as shown below) and remove the=20
> control-program-id.

This is what I meant, drop it from qom.
>=20
> virsh # qemu-monitor-command vm --pretty=20
> '{"execute":"qom-list","arguments": {"path":=20
> "/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
> {
>    "return": [
>      {
>        "name": "type",
>        "type": "string"
>      },
>      {
>        "name": "parent_bus",
>        "type": "link<bus>"
>      },
>      {
>        "name": "realized",
>        "type": "bool"
>      },
>      {
>        "name": "hotplugged",
>        "type": "bool"
>      },
>      {
>        "name": "hotpluggable",
>        "type": "bool"
>      },
>      {
>        "name": "system_type",
>        "type": "string"
>      },
>      {
>        "name": "control-program-id",
>        "type": "S390ControlProgramId"
>      }
>    ],
>    "id": "libvirt-16"
> }
>=20
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",=20
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",=20
> "property":"system_type"}}'
> {
>    "return": "LINUX   ",
>    "id": "libvirt-17"
> }
>=20
> However, Hendrik Br=C3=BCckner suggested to group the identifiers togethe=
r=20
> during the initial discussion of this line item. So, I would prefer to=
=20

They are grouped together under "sclpcpi", no?

> leave this as it is. Please let me know if you still think otherwise.

I don't have a strong opinion on this, just wanted to mention it and see wh=
at other people say.
>=20
> > > +}
> >=20
> > [...]
> >=20
> > > diff --git a/include/hw/s390x/event-facility.h=20
> > > b/include/hw/s390x/event-facility.h
> > > index ff874e792d..ef469e62ae 100644
> > > --- a/include/hw/s390x/event-facility.h
> > > +++ b/include/hw/s390x/event-facility.h
> >=20
> > [...]
> >    I.
> > > +struct SCLPEventCPI {
> > > +    DeviceState qdev;
> > > +    SCLPEvent event;
> >=20
> > I think you should just inherit from SCLPEvent, which in turn inherits
> > from DeviceState.
> > So without the qdev.
> >=20
>=20
> Ok, I will do so. Thank you very much for the review.
>=20
> > > +};
> > > +
> > >  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
> > >  typedef struct SCLPEventFacility SCLPEventFacility;
> > >  typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;
>=20

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

