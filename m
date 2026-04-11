Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC9F45A18
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBO3x-000292-K6; Fri, 10 Apr 2026 22:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3v-00026v-4S; Fri, 10 Apr 2026 22:27:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3t-0000O2-Hh; Fri, 10 Apr 2026 22:27:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B0P1912276100; Sat, 11 Apr 2026 02:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eYbBKH1oO13k9TLel
 I7GDEIaC9XcIecLzSyl4dhG1eQ=; b=PhpQg7C6Cv8+akJdP6YDym+yud9GeVbCd
 wNN+IMdsx6MEydjh8vtNvyDjJeuKny0owTuOTXdnYX+D/ASc1c3V64xggsjG7Fq5
 Jb4+erVcvPD8hUPHCpuhv9PPgUZ+P94OMHw9GW7vg3Bwx7G+t1ySn04OK1WN+0ig
 6AZzQ6krPFEXt6M3E8wfev9BM4tgtofXLoz3eU2PBLfw6XJstotC5dh9OJePDVnS
 0q07M/SiCvi/plblJZe6i9gkzyk7T8kkhtMgzxY3OWyb8C4EqpXWP7Tc+fGkm5gi
 ww/n5VEg3wUHTsVHJShLd3XGWAJwbzysTu5Yk+EKMXRT6B4ZRzMyA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqk87f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B0bRJn007924;
 Sat, 11 Apr 2026 02:27:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2u263-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63B2R0ai47251960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Apr 2026 02:27:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BE315805A;
 Sat, 11 Apr 2026 02:27:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B8EE5805C;
 Sat, 11 Apr 2026 02:26:59 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Apr 2026 02:26:59 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Fri, 10 Apr 2026 21:26:16 -0500
Message-Id: <20260411022618.2136588-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411022618.2136588-1-kshk@linux.ibm.com>
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69d9b175 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YbwZhMhe-Yu4dYefToEA:9
X-Proofpoint-GUID: 6II-tRUVElryzpVDi9JeenTpaDFqCWRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX+WB2tHlwWjFN
 NfYAV5BVuIReAabgHTJbbzH6EegADT6Ys6gavmKl4wh5ddIDV6LDmYE0EdLAzDi0PEtOS+T6HE/
 ErZCvM3RYcMATZpjxU/Y0sh7ZyG7IeJV86rgK2vEOxJFPeBjVVusqQQcUZv+L56zvkouoxge9VV
 tf2e8RXrYkdWREiXkW7YKXExVjrNVHu0hqTqhZ9qB71ZZMTj8XdXHQd3REGldXznc+44e4JfXvu
 ANvw9mY5MyNHcnUYd9RAqmwx1IgVpfdAHPqXhCtbngvwSd2/9NGlEJMvqIjjHBxyk03bOOSALat
 2APf3CSmshJsaJDQf1wXCh3FOvAkrQGEzQg9kuS+kRIqJQyBPe+hrlhVxH4r68mk42aZzp4PsDn
 KLk8xwU6mvys8Y0wV1fnX/C01m3777FelY28JdZUQYJ23TdTq6sOdPkPd1eUt8P1OgmR+6OsKCm
 khzDIVmr/ww8JYXA1og==
X-Proofpoint-ORIG-GUID: 6II-tRUVElryzpVDi9JeenTpaDFqCWRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e3cbee2695..2fab28e6e0 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -271,6 +271,14 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the PCI device AddressSpace that QEMU needs to link
+ * into its internal structures before the zPCI and PCI devices are fully
+ * initialized. It's a QEMU requirement to provide this "root" AddressSpace
+ * early. The AddressSpace is only actually used for I/O while the PCI
+ * device is plugged in and configured by the guest, at which time it gets
+ * additional memory subregions from zPCI device, that can do real work.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.34.1


