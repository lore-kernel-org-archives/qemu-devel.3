Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F010F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 16:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ygV-00009X-Pd; Wed, 01 Apr 2026 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w7yg2-0008OL-Dr; Wed, 01 Apr 2026 12:44:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w7yfz-0004vw-Ut; Wed, 01 Apr 2026 12:44:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CM24E460345; Wed, 1 Apr 2026 16:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U+cUyn
 UJ+n0LkrxjpQ1fcg6TWm5heDAt5hnKCuJZ3iE=; b=XPdjGd27ynp5BpR0yMo6T6
 WmsSsfE3ctdF4vNZUioPWL85Ft6uGlzatuFwpc1CB7IZLKokNaJCmu+vxEdiN8cz
 osqytHiinjxg9P3IbkC5hevROdJKU1OMwfBnvGe0UmNUw8czewAR/sC04s1bwRky
 xEZ4X8EZJOLovEd+FlOAWYV6CviREn/K4Wj79BlcELqX8jWg9fPWb7qtPzwhYJ5V
 zSg6KdJWXReSoO85Fl9RIvktBs/dxzQ5FVSS4wwh9eFXPizZY9QPYNz5ng+V3tFi
 ZxiJ2uHk20O72kVmrfkqvSiT6X1+/AOgLsUN/KzTP4l1zn1UA4ALA5oMH5mtl+4Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g217cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 16:44:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631GHcC1022217;
 Wed, 1 Apr 2026 16:44:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan6f21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 16:44:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 631Gi3Es58786160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2026 16:44:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 735BB5805E;
 Wed,  1 Apr 2026 16:44:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 868FC58059;
 Wed,  1 Apr 2026 16:44:01 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.97.105]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2026 16:44:01 +0000 (GMT)
Message-ID: <31fab9d2b8f8e5f3bc6e7a92c3b32171099011c0.camel@linux.ibm.com>
Subject: Re: [PATCH for-11.1] hw: add compat machines for 11.1
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora	 <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich	
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Date: Wed, 01 Apr 2026 12:44:01 -0400
In-Reply-To: <20260331140347.653404-1-cohuck@redhat.com>
References: <20260331140347.653404-1-cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd4b56 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Vs7uO71RKhtVEPws7hkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mKTx7evHykHOpvoQPuG1LYcLyGDAnH-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1MiBTYWx0ZWRfX5fWgHZjeIFva
 GF69eWlA+f5rIjpSUuFnG0+SxkOu6VUSng6W77pcjoRBqiJlkrOKbrYztqectDgX86k3hhF3IEd
 sFploIrNgbXaMmz+2Ynj48IOx3fUWEAEaHSl9ulcPhxJIGV/VqEN6HOVDWWbXzgBGN0WvtG7StT
 juqHzCZ03PZaBbtRisntOg1VxH35TW2z+5b86fDxPy/2lH/MMbL48mXSTSW1xIRNgbh7FSg7LHY
 TbbuRw/h+AD/xOynHGE7dhkHrM0ODrStm60eJacoM6Tqku+sQGtoCef5JRR1oWTY8w1eGGP/xmU
 h1UOzt70HUwPvkXEvz8Dqf6Ug+uoih+q9ibU8opg1yFKZnZ/899Ykml3/CoheKRJu8BEvh5qUmQ
 mqeSG1buSbKtypM9TKiWVW5tupFeNJX+z1MDEONbCPLLjT1HlLeR13eVKJJ81rNeA99IR9f/BYW
 vNTF863AWDROW1gLdog==
X-Proofpoint-GUID: XRUFaMbgnheC46xG_Fiu5rIKaTHJzYRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-03-31 at 16:03 +0200, Cornelia Huck wrote:
> Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 13 +++++++++++--
>  hw/i386/pc_q35.c           | 13 +++++++++++--
>  hw/m68k/virt.c             |  9 ++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/core/boards.h   |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  10 files changed, 76 insertions(+), 9 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>  # s390

