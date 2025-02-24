Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E76C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbvo-0003il-Aw; Mon, 24 Feb 2025 12:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tmbvl-0003hm-Bw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:07:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tmbvf-0004FW-GF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:07:44 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OF75lZ012138;
 Mon, 24 Feb 2025 17:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VRng8L
 Nia1WdBVIIygYt0uMjvbJ1JbdrZ5DkXp4GzAU=; b=lLg4QCfQC+Q0rZEOp7rUdw
 lLN+qcvUERkHbD1bwm0LiZV83MZFT6vqYvHaCUbcti7W65B+tvwgNUSfZzdcdN+9
 DcYxOSY9JrsyQ7M707dqSng9coh/Ze3qxqcdRUUdZWam8a7vVFU05nl2WY4aEs0w
 sxDg2faBdrc1Uo+dye7bQqQlEBf01Zra745uzYyXNKM5ujQmdrnxp9I+S3b952wf
 Buvz83R6s9u/ilK8y/Rko5BBRjHBsFEQ0NqU/FyBCDo3VKR/sbo+HexolY/Pav3H
 fZ45fXL8x9NOslCiFqOyl+l4gtbxY2dNXlK99BCYaLaaqT24LXoz1mFv6vR4dbEg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450jk836xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 17:07:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51OGlVdA006251;
 Mon, 24 Feb 2025 17:07:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450jk836x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 17:07:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGMOL5026961;
 Mon, 24 Feb 2025 17:07:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk846b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 17:07:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OH7XSB28050044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 17:07:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 135D35805F;
 Mon, 24 Feb 2025 17:07:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC9A258043;
 Mon, 24 Feb 2025 17:07:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.172.201]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 17:07:31 +0000 (GMT)
Message-ID: <b8b54a18d9975633bd536341e419290c48a02794.camel@linux.ibm.com>
Subject: Re: [PATCH v4] vfio: Add property documentation
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, tomitamoeko@gmail.com,
 corvin.koehne@gmail.com, Kirti Wankhede <kwankhede@nvidia.com>, Joao
 Martins	 <joao.m.martins@oracle.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Eric Auger	 <eric.auger@redhat.com>
Date: Mon, 24 Feb 2025 12:07:31 -0500
In-Reply-To: <20250217173455.449983-1-clg@redhat.com>
References: <20250217173455.449983-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tAgdFAHvHygJJS0QXDSgPiypIHLaXUol
X-Proofpoint-GUID: bi5ndSpmnBpoH1yUgobG4Y3egjXs2W61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Mon, 2025-02-17 at 18:34 +0100, C=C3=A9dric Le Goater wrote:
> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
> devices are simpler.
>=20
> Sort the properties based on the QEMU version in which they were
> introduced.
>=20
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>=20
>  Should we introduce documentation for properties like the kernel has
>  in Documentation/ABI/*/sysfs-* ?
>=20
>  Changes in v4:
>=20
>  - Latest improvements from Alex=20
>=20
>  Changes in v3:
>=20
>  - Re-organized the vfio-pci properties based on the QEMU version in
>    which they were introduced
>  - Added property labels
>  - Improved description as suggested by Alex, Tomita and Corvin
>=20
>  Changes in v2:
>=20
>  - Fixed version numbers
>  - Fixed #ifdef in vfio/ccw.c
>  - Addressed vfio-pci-nohotplug
>  - Organize the vfio-pci properties in topics
>=20
>  hw/vfio/ap.c       |   9 ++++
>  hw/vfio/ccw.c      |  15 ++++++
>  hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  24 +++++++++
>  4 files changed, 173 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com> # vfio-ccw

