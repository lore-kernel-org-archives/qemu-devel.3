Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432CBC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRs9-0004T7-S1; Thu, 16 Jan 2025 10:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tYRs6-0004Sf-Mz; Thu, 16 Jan 2025 10:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tYRs5-00032I-0k; Thu, 16 Jan 2025 10:33:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCSTjb005745;
 Thu, 16 Jan 2025 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2cBZ8N
 EeTutt8vgABvfEDuF5e4p0OqAtId8jBtC6t5g=; b=rAqje5KTu3kiVz0pnUQuTR
 u1R7LdpPPZRJCZs64eGKpH53Cwl/S+1gG9XcxFh1X1n2PkVYfKNMSHkG/RtG4BlU
 FZYlaY1iVizmNaaWmvgi9rkXmjz4E92Cl6WedolVRd2/Qhb2kGc5owNVneGQDwUp
 3QG3qkm3Akw4LhdlY9i0u1RUMIDYY75q+l2p0+3MDojGRxSVmdedwbLsRGDmTACI
 ip136mJLOhOUTQGnX4sqEVkRvePexIR9AyE97F69yjZKg0DREZeZBYxOZUzbzPrz
 Ddkf7B46CcYCPNID2MdWyaB/3VQDiMH0Zg/p0g2muUWFM0kaUvjyJ/b2dG2I17cQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhb8sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 15:33:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCtZd4002693;
 Thu, 16 Jan 2025 15:33:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byejy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 15:33:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GFXIOH47251950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 15:33:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC9FC58054;
 Thu, 16 Jan 2025 15:33:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4AC258050;
 Thu, 16 Jan 2025 15:33:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.67.174.5]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 15:33:17 +0000 (GMT)
Message-ID: <0f063b4c07b56a26b208d07654ba33531b6ab48b.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] pc-bios/s390-ccw: Fix problems related to network
 booting
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jared Rossi
 <jrossi@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Thu, 16 Jan 2025 10:33:17 -0500
In-Reply-To: <20250116115826.192047-1-thuth@redhat.com>
References: <20250116115826.192047-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJu7ud7pjRE_ZPvOKEdGso2q_cz0mmUm
X-Proofpoint-ORIG-GUID: LJu7ud7pjRE_ZPvOKEdGso2q_cz0mmUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=781 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Thu, 2025-01-16 at 12:58 +0100, Thomas Huth wrote:
> The boot can currently fail after the s390-ccw bios used a network
> device since we do not properly shut down the device afterwards, so
> that incoming network packets can corrupt the memory. We have to make
> sure to put the virtio-net device into a sane state again afterwards.
>=20
> The third patch is unrelated, but I spotted this rather cosmetic
> problem while working on the code in netmain.c, so I included it here,
> too.
>=20
> Thomas Huth (3):
>   pc-bios/s390-ccw/virtio: Add a function to reset a virtio device
>   pc-bios/s390-ccw: Fix boot problem with virtio-net devices
>   pc-bios/s390-ccw/netmain: Fix error messages with regards to the TFTP
>     server

Looks good to me; Thank you, Thomas! For the series:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
>  pc-bios/s390-ccw/virtio.h     |  2 ++
>  pc-bios/s390-ccw/netmain.c    | 52 +++++++++++++++++++++--------------
>  pc-bios/s390-ccw/virtio-net.c |  5 ++++
>  pc-bios/s390-ccw/virtio.c     |  7 ++++-
>  4 files changed, 44 insertions(+), 22 deletions(-)
>=20

