Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C9FD49221
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2Dh-0006O3-2o; Mon, 18 Nov 2024 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tD2De-0006LI-Rg; Mon, 18 Nov 2024 08:55:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tD2Dd-0007LZ-7V; Mon, 18 Nov 2024 08:55:10 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI17nJp008300;
 Mon, 18 Nov 2024 13:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9aJUxO
 OdvycMOVxpUdOskBesQZ+2QMH7mdMx0zjex1s=; b=Njtr2TnovZ6gh3V+qlsyyU
 nfbZ4MG0wPrb1SWbxeRcDeQ0A3jdD+0uUtNCDMV9P4pHW6uNu9EpmTBBagdNVPx6
 UOz2IlA/feSAjxDH87SDkEV9DkWJNx1/hmJWZNB11py35/fOeryNWJPpTgqLtxIL
 kuH5iQeMkq4dQIMhjbw98pqR4wHezPbaMwlU1r6vgBk9UsuQ5LHUHtglggv7Ug7r
 gn5i1TxgSY4uD63UZX1DabLwWTpfd8e/F53sEWSpnMPmQcKsmQuvmEUijEJkMzau
 aIi4QqMx5LfPJeUFRutFCIIY38kNeNvt0+20iMwIPXpbRXJa4SSQnJhAdrfi8zYg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgtt1xue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 13:54:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICvYpa030962;
 Mon, 18 Nov 2024 13:54:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63y4s40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 13:54:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AIDsraT60227860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 13:54:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFD4258052;
 Mon, 18 Nov 2024 13:54:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AADA858068;
 Mon, 18 Nov 2024 13:54:51 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.67.149.170]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Nov 2024 13:54:51 +0000 (GMT)
Message-ID: <fc42668540e23ebb275e6e0418e862f91c5a3cca.camel@linux.ibm.com>
Subject: Re: [PATCH v2] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jared Rossi
 <jrossi@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Date: Mon, 18 Nov 2024 08:54:51 -0500
In-Reply-To: <eec8187b-eb57-4cb3-a845-45084ef48eb7@redhat.com>
References: <20241115141202.1877294-1-thuth@redhat.com>
 <eec8187b-eb57-4cb3-a845-45084ef48eb7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3C0Q_Y31i4VqpMrpCXR5cChgISZlCs1u
X-Proofpoint-ORIG-GUID: 3C0Q_Y31i4VqpMrpCXR5cChgISZlCs1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=917 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411180112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2024-11-18 at 11:02 +0100, Thomas Huth wrote:
> On 15/11/2024 15.12, Thomas Huth wrote:
> > While adding the new flexible boot order feature on s390x recently,
> > we missed to add the "loadparm" property to the scsi-hd and scsi-cd
> > devices. This property is required on s390x to pass the information
> > to the boot loader about which kernel should be started or whether
> > the boot menu should be shown. But even more serious: The missing
> > property is now causing trouble with the corresponding libvirt patches
> > that assume that the "loadparm" property is either settable for all
> > bootable devices (when the "boot order" feature is implemented in
> > QEMU), or none (meaning the behaviour of older QEMUs that only allowed
> > one "loadparm" at the machine level). To fix this broken situation,
> > let's implement the "loadparm" property in for the SCSI devices, too.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   v2:
> >   - Only add the property when running with the s390x target
> >     (checked via the arch_type variable during runtime)
> >   - Check bootindex property before setting the loadparm property
> >   - Call the sanitize function before setting the property, so we
> >     can now immediately reject bad properties for the scsi devices,
> >     too (had to move the sanitize function to the common code in
> >     qdev-properties-system.c for this)
> >=20
> >   include/hw/qdev-properties-system.h |  3 ++
> >   hw/core/qdev-properties-system.c    | 26 +++++++++++++++++
> >   hw/s390x/ipl.c                      | 19 ++++---------
> >   hw/scsi/scsi-disk.c                 | 43 ++++++++++++++++++++++++++++=
+
> >   4 files changed, 78 insertions(+), 13 deletions(-)
>=20
> If there are no objections, I'll pick this up for my pull request for QEM=
U=20
> 9.2-rc1.

Hi Thomas,

Jared was out Friday so I'm hoping he can give it a look over today, but no=
 objections from me:

Acked-by: Eric Farman <farman@linux.ibm.com>

