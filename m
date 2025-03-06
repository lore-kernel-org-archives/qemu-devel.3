Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79911C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDH3-0002Ke-3V; Thu, 06 Mar 2025 10:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tqDGp-0002Hx-1I; Thu, 06 Mar 2025 10:36:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tqDGj-0004Ve-DS; Thu, 06 Mar 2025 10:36:19 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526E3CDT019289;
 Thu, 6 Mar 2025 15:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5p/qx4
 iyFBsj96syQVyc2ZLjhRr0lIS0Fi0xwM2a3R4=; b=deVi2TC4IWGgpffk0m646S
 2f8dtUDGkgczDBWQTyW58Jao6iS0nF3essIaYuAfm5kK2ATKlppRLcALYo/IZDzN
 vy0WIUOyjFqLZEGqRBi3140ttDd/VoPebbEewc7E8eEnhav8l1eKs1DrWRkLgnks
 /16Hn7S3SwFaMFq6tGbEac014bQ/BrcMT1oc2cZ2bzDQitIZKuuBsM6gPk0zkI4U
 p+d8nGzjXRNBM8y4Dhwx52ldTQnEL62JHJd7gdSaQk0xrnG1+YehWO+pWwdnnQnq
 2/cbdNcuaaxx53+2w41FLk0EyAkQNrty45qJEr2pocAgeiCxVdsEX08Y5Mk5oB8w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457d4p0g80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:36:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526CHPOP009038;
 Thu, 6 Mar 2025 15:36:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyskhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:36:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526FaAtG47579456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 15:36:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BB2620040;
 Thu,  6 Mar 2025 15:36:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D785120043;
 Thu,  6 Mar 2025 15:36:09 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.9.216]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 15:36:09 +0000 (GMT)
Message-ID: <de5e3ddbdd36cafe444058b79d8aa12e912ae89f.camel@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Shalini
 Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 06 Mar 2025 16:36:09 +0100
In-Reply-To: <Z8m5pV0kPIfp2jo2@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <Z8h2hNFlNvjWWHqd@redhat.com>
 <b44e0b46f69ee6f86a15ecabecd6942c@imap.linux.ibm.com>
 <Z8m5pV0kPIfp2jo2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tcocyIe0YkrikESQvaBXyq448pbetjqi
X-Proofpoint-ORIG-GUID: tcocyIe0YkrikESQvaBXyq448pbetjqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060118
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

On Thu, 2025-03-06 at 15:06 +0000, Daniel P. Berrang=C3=A9 wrote:
> BTW, your email client is possibly mis-configured - your mail
> came through with "From: shalini <shalini@imap.linux.ibm.com>"
> and attempting to reply to that gets an error saying that
> 'imap.linux.ibm.com' does not exist.
>=20
> On Thu, Mar 06, 2025 at 02:55:27PM +0100, shalini wrote:
> > On 2025-03-05 17:06, Daniel P. Berrang=C3=A9 wrote:
> > > On Mon, Feb 24, 2025 at 01:04:47PM +0100, Shalini Chellathurai Saroja
> > > wrote:
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
> > > >  hw/s390x/s390-virtio-ccw.c         | 29 ++++++++++++++++++++++++++=
+++
> > > >  include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
> > > >  qapi/machine.json                  | 24 ++++++++++++++++++++++++
> > > >  3 files changed, 61 insertions(+)

[...]
>=20
> > > > +# @system-name: system name of Linux instance
> > >=20
> > > What is a system name ?  Is that a hostname, or is that something
> > > else ?
> > >=20
> >=20
> > Yes, it is the hostname of the guest virtual machine.

Is it? Seems to me it it just a user configurable name of the system.
It's empty on the two LPARs I checked.

>=20
> Lets rename it to 'system-hostname' to be unambiguous.

In any case "system name" is the established name for this value on s390x.
>=20
>=20
> With regards,
> Daniel

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

