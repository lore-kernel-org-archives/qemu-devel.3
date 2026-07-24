Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C5C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6IK-0008OP-T6; Thu, 23 Jul 2026 23:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IG-0008Fw-LW; Thu, 23 Jul 2026 23:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IE-0008V4-To; Thu, 23 Jul 2026 23:09:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLfq19008604; Fri, 24 Jul 2026 03:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5f3Wdy9B9Dzi6NSEF
 LaG+qhWLl/BGAcf0nN/W8k+vFw=; b=GbsItgL+Sfym2SEXkEoEBHEZkxl2yGX51
 8Ia1KbnJcccp7YAhDAWCJ2K+5vg9klLjS3wTlEL8KdGI211fw3PoXwRT9NOYqbWS
 i540yU/djawVJ6dS7nx7zxXA9oz1TgjlobWppmCtCtHwhqmNAnafUhZ/VMdMCOu8
 1ac2sJ3Jaoms77HX5Ob8to7ARiXoYAUOhx5mN0htIIX+0Ai5jXKANZHVJ1L8XAEh
 6J5YaQY9FiqM4qcEnBmme15+NgYiz4oVuW03BIq0cCF7BxbLPgo574zD6sD/MRvI
 l5SS1uTgdcOmOTN/SYVQipbm79Y3FJImOjUqkXjrxYZfLf/5mGA4w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791ardt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O34gcM013325;
 Fri, 24 Jul 2026 03:09:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahf4cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O39eKs9175710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9115A58061;
 Fri, 24 Jul 2026 03:09:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03A3258053;
 Fri, 24 Jul 2026 03:09:40 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:39 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Thu, 23 Jul 2026 22:09:17 -0500
Message-Id: <20260724030919.123733-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030919.123733-1-kshk@linux.ibm.com>
References: <20260724030919.123733-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YsXuRZTmpz7J17hE1szYK9cDPfM_PSG0
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a62d777 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=c3lGbpyPv1M8-G6Y41EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX8xHKCyK8EBpX
 J8Z16ymBwCZZcrKZzDfBmruqRYbNOxtNjuoMarTdMN408VyFdhavJxRK1YLto4ZcpQwJw7uzqh/
 Gh691R2Ujbojbg2SL3IZJ99raBOV/Ac=
X-Proofpoint-GUID: YsXuRZTmpz7J17hE1szYK9cDPfM_PSG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX+7GMyYvPqu2k
 5DZX2lPaW42CxeC1G9KEwHTNH5VXepoiNS6IlURdXIK/sKdpa6WZUx+eZdzhmdrLF29c3yuxEcC
 ryAYN4pz9Tw0qqArSqVHH9uuesxuFOZvTVP8l14oqd2fmS6RctKd6bNHoZNg22sIM8k/ZgKQ2Lg
 U2+rbm2xWtr7LV19IskFF/9XUvOYM2BMuEg8NiSR8J8ne+qaSLag9V69zdT62eKX5yfU4tXIDCA
 9I7OCJeSW7G+MqxNB7TSV0gS9f5Q4AUq6yOPuvh9/TvMyfE+RvYSlW2xFCJs3TkotF6dm/i2OlH
 2InItERnRmDtHJRSd2eaL55xp/Bre2/EuHmX8AS8i8QtECQEdOWFuF24htwpFPRE+IM27uj4zqv
 YxzOA3dh17pOXUHR6yRf0XlPuvSY3t6ZY+HtPibl/PYeoZDLiRQh2IgqAN+hlxNdv8oUof8Qvll
 KAW0zb5/VMeDjFAqQaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because S390PCIIOMMU has just been cleaned up of fields it didn't have to
carry, add a comment explaining why it exists in the first place and
discouraging adding more fields to it in the future.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e3cbee2695..17ecf3e0da 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -271,6 +271,17 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the PCI device AddressSpace that QEMU needs to link
+ * into its internal structures before the zPCI and PCI devices are fully
+ * initialized. QEMU wants to have this "root" AddressSpace before the PCI
+ * device is plugged in. It's only actually used for I/O while the PCI
+ * device is plugged in and configured by the guest, at which time it has
+ * additional memory subregions from zPCI device, that can do real work.
+ * In other words, S390PCIIOMMU holds fields that logically belong to
+ * S390PCIBusDevice but need to exist before S390PCIBusDevice exists.
+ * Therefore, no other kind of fields should be placed in S390PCIIOMMU.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.34.1


