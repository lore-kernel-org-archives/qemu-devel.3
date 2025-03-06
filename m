Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51692C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDPV-00067r-8K; Thu, 06 Mar 2025 10:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tqDOv-0005sP-OV; Thu, 06 Mar 2025 10:44:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tqDOt-0005ed-0Z; Thu, 06 Mar 2025 10:44:45 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526DCrr8023826;
 Thu, 6 Mar 2025 15:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RbTFho
 DLJ5ZdDzvH60Uuh8SyWr+wdRUEayq6O3pmGnA=; b=hoe11jnqOBzF49j35xmF7t
 R82qa9IuSt+m0SjklV6nLhRfaPtz0xTfsIhEgcJl8xHASQvi3DODzDFe1gBLUDnG
 uRLac/lvDNxT5P49udAwV9HJX+FAjqOhjs7VOkc8TSZce0hf2fFFGps6xDQ1QLFQ
 ZoCqaE75Dn8j+S12l/uA4dhziIEPZYxjkA4NvT6SYvQKx74cnCg0U7YsR4pEuhDk
 8wRKaXYkWGjjLU/tyJ7E7bnIBPRfDzK64KRuB0WqciGfI42JO2CfYgRlnF4IWwdE
 c2d0bth+bowViOLhMDo6VZILtQX2yoZm77SpSTnaT7RlMvmgf/1bpMoIXLSFHfkQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574393cu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:44:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526Di21M020824;
 Thu, 6 Mar 2025 15:44:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk96ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:44:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526FiXtA17891798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 15:44:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B443220043;
 Thu,  6 Mar 2025 15:44:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 584E820040;
 Thu,  6 Mar 2025 15:44:33 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.9.216]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 15:44:33 +0000 (GMT)
Message-ID: <98ab6ad416f0dcf7d1beb5105cace9ca46ad3c84.camel@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, shalini <shalini@imap.linux.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 06 Mar 2025 16:44:33 +0100
In-Reply-To: <f64b5ce4-8843-4d92-af97-24160f687698@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
 <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
 <f64b5ce4-8843-4d92-af97-24160f687698@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rGzGT2md56aqg5jPqihTwAuONETj7_jG
X-Proofpoint-ORIG-GUID: rGzGT2md56aqg5jPqihTwAuONETj7_jG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2025-03-06 at 15:55 +0100, Thomas Huth wrote:
> On 06/03/2025 13.23, shalini wrote:
> > On 2025-03-05 16:56, Thomas Huth wrote:
> > > On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> > > > Add Control-Program Identification (CPI) to the QEMU Object
> > > > Model (QOM). The CPI identifiers provide information about
> > > > the guest operating system. The CPI identifiers are:
> > > > system type, system name, system level and sysplex name.
> > > >=20
> > > > The system type provides the OS type of the guest (e.g. LINUX).
> > > > The system name provides the name of the guest (e.g. TESTVM).
> > > > The system level provides the distribution and kernel version
> > > > of the guest OS (e.g. 0x50e00).
> > > > The sysplex name provides the sysplex name of the guest
> > > > (e.g. SYSPLEX).
> > > >=20
> > > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > > ---
> > > > =C2=A0 hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 29 +++++++++++++++++++++++++++++
> > > > =C2=A0 include/hw/s390x/s390-virtio-ccw.h |=C2=A0 8 ++++++++
> > > > =C2=A0 qapi/machine.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++++++++=
+++++++++++++++
> > > > =C2=A0 3 files changed, 61 insertions(+)
> > > >=20
> > > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.=
c
> > > > index 51ae0c133d..13ea8db1b0 100644
> > > > --- a/hw/s390x/s390-virtio-ccw.c
> > > > +++ b/hw/s390x/s390-virtio-ccw.c
> > > > @@ -50,6 +50,7 @@

[...]

> > > > +##
> > > > +{ 'struct': 'S390ControlProgramId', 'data': {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 'system-type': 'str',
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 'system-name': 'str',
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 'system-level': 'str',
> > >=20
> > > Not sure, but would it make sense to use a number for the system-leve=
l
> > > instead? At least it's a number in ControlProgramId, not a string.
> > >=20
> >=20
> > The system-level, when interpreted as an int provides the output below
> >=20
> > 'system-level': 74872343805430528
> >=20
> > But the desired output below is obtained only when interpreted as a str=
.=20
> > please refer https://www.ibm.com/docs/en/linux-on-systems?=20
> > topic=3Didentification-system-level for details on system-level. I will=
 also=20
> > document this in the description of system-level as suggested by Daniel=
.=20
> > Thank you.
> >=20
> > 'system-level': '0x10a000000060b00'
>=20
> Well, the idea of QOM/QAPI is: It's an *API* for machines, not meant for=
=20
> direct consumption by the end user. So passing an integer as a string is =
not=20
> the right way here. For the user, you'd require some upper level instead=
=20
> that renders the integer in the right shape for the user. So please don't=
=20
> use a string for this at the QOM/QAPI level.

In a sense the system level is a bitfield.
So this could become a struct

{
	'hypervisor-use' : true,
	'distribution-id': 3,	// or an enum?
	'distribution-version-major: 24,
	...
}

Not sure how to handle the 3 undefined bits in the highest byte.

>=20
>   Thanks,
>    Thomas
>=20

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

