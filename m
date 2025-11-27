Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7208CD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 12:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOajK-00018B-71; Thu, 27 Nov 2025 07:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOaj9-000155-NF; Thu, 27 Nov 2025 07:03:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOaj6-0007KY-Ac; Thu, 27 Nov 2025 07:03:57 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28OaB019697;
 Thu, 27 Nov 2025 12:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=cjvZj+FId3+HY8xlWc8UStjX/1T7JhKEEOmRP983W
 sQ=; b=Sx1zlCEF4ghbgYTx1wb12Zwyyp4GqAgtbXV31X+Gw9OolWVzb1icWN3RE
 4dRaG86cDNa4ReQyuDvjfeZNg6MPy5skMqHAk8bdmm3+tikya1kXdDSsY06E7JRO
 wly677RfJwdzk/Vp63RRGRWtZ7WfAul0we014UJWYABkW/IGKUZavxzDAuYiiEbb
 YIRg2qEZm5kWnjHrz7MCOQsqtxOegdRZvO2fmh2w6xshiw8Om5G53bQVgYBL7s9n
 atklrdz2njJ/AyR0H4/pUkX1C5fcfjNu+J0buqT6b7iqZq9dvJBMXePYwKPFqIjy
 sd2DTPu86x5Bm2E8i6+W+TMfez7LA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvhfyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ARC3iYl005296;
 Thu, 27 Nov 2025 12:03:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvhfyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARA11YT000857;
 Thu, 27 Nov 2025 12:03:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvy81h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ARC3gxK23659242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 12:03:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29DCC5805D;
 Thu, 27 Nov 2025 12:03:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14B2F58058;
 Thu, 27 Nov 2025 12:03:41 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 12:03:40 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com, nikhilks@linux.ibm.com,
 stefanha@redhat.com, fam@euphon.net, philmd@linaro.org
Subject: [PATCH v4 0/2] hw/nvme: Properties for PCI vendor/dev IDs and IEEE-OUI
Date: Thu, 27 Nov 2025 06:02:49 -0600
Message-ID: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX7ukOw1UD46EJ
 fIi6YsT1Qd4+bq8pOssXpJnmmLT5ShVqJ+YgpGfeBgmyrat//An1N7gYymfJeo1FnHDP9aWt2S9
 fw1Da+3Dq7vyYiQKq8DKnUvIQbiSG3k3glpj/o4TZFhAaM1gJz4hwB6DSLx2jyPz3Q5ZoX55Abl
 TN0mtBQOLWZa6XJg69zKYBIU59p9zTwEdFd+foV7g3uUn0VuhXKuBJVE5JtJRYJfw/Gtj4gDfVD
 uIPH0uE2JkHsZfFtVhh2UU54o5niNO52dbDsnUGmo4kY1iTmOCbABbeSBk2lN5VMTXrWqT7skX1
 T4Wl2HIdUt2KMcEJkfsb0X2f00GJ/xxWfr1CXbEVwBeFguJYRoVvE7izDbh9faDtJ2k0HixO276
 ILGA5N+/HCpVpP3q2nl+3cBPFlZ/dA==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=69283e21 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LBo_BDk6ZE8na0GEeKkA:9
X-Proofpoint-ORIG-GUID: g8F4o2KeMitr7ZcYIWxlzv40w57M6-KG
X-Proofpoint-GUID: s3YPCI_qawk6uYC6vsiO0spVBKv01m3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add properties for user-specified PCI vendor/device IDs and IEEE-OUI.
PCI properties are now set independently of each other and
used only when use_intel_id is not set.

Saif Abrar (2):
  hw/nvme: Add properties for PCI vendor/device IDs
  hw/nvme: Add property for user-specified IEEE-OUI ID

 hw/nvme/ctrl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 hw/nvme/nvme.h |  7 +++++++
 2 files changed, 56 insertions(+), 3 deletions(-)

-- 
v3 -> v4: Resolve merge commits when moving to the latest repo.

2.47.3


