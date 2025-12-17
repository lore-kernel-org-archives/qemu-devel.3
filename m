Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6763D66B86
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwUY-00026Q-8c; Wed, 17 Dec 2025 13:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vVwUL-0001yc-Uf; Wed, 17 Dec 2025 13:43:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vVwUI-0000eS-Ly; Wed, 17 Dec 2025 13:43:05 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHHvAAS015533;
 Wed, 17 Dec 2025 18:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LNXIJcG9hifXqIQlUCzhmVqIidg+g89AZGbnoc4bk
 P0=; b=ca+nD+mtpgxWZyIsAJ9zpozT+zwyBrJvXdxybl3IU/pmWSsCIR4sKVeOo
 cYplo+59tX5x/xSGLPsUv/hX2fRdfJ8YS0IUhXcrB56pJpL475Lfne/SnjwNJ+BB
 +w9pWoZvkyq4hwjnv2pPXKPPfqS2zdywx0yutntERwwCx3TLUf0r3/9s9SnyKwJ4
 h1CHKfv0/kZ5ZGcWejcN9OqNVBdQjJOMtLdZLSUc/YMDvfLxcZNFFu/0QnoT6gGg
 m/ncHNnFJKq8w9r7+1CjoNMhtPoUpUBPyiFRKn0melr9u62j0fpK1VZj9aqpUwL0
 eXMP+2Ao6Sl2GGcgcLy58dFM3hf/A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1nqx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 18:42:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHI0I9Q005675;
 Wed, 17 Dec 2025 18:42:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp2ph3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 18:42:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BHIgslS18940600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Dec 2025 18:42:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7664D58064;
 Wed, 17 Dec 2025 18:42:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E6AF5803F;
 Wed, 17 Dec 2025 18:42:53 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.176])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Dec 2025 18:42:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, fam@euphon.net,
 alex@shazbot.org, clg@redhat.com
Subject: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
Date: Wed, 17 Dec 2025 10:42:53 -0800
Message-ID: <20251217184253.1520-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D6ukLhN1QEgRJlQVroZjjrkbXPrkQZev
X-Proofpoint-ORIG-GUID: D6ukLhN1QEgRJlQVroZjjrkbXPrkQZev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXzwu9aCKEfHPL
 pEfvw7aWdyRavqUu1/bptR5vcWzw4uJ8k/adY2iTCEoz6N9Q7HBEF8Kbg9tGud31ncrYphr83Qs
 F9hBAHXn93RRUXcr/ps8WVKaQHgvF8JNr8kWgVCj7M/hnK5lHQeMHgoiHtLCDpU94d+iavWy7Of
 N8DRMybTZe8jt7OPz9jjZt3sylZpwe6vBAYdxoce0alsh/tgTGkPyX95rKk/Ox/fDKzh0FLxddk
 GQSfetFd9NddS+O76Zn6HggVBzauQJjsVpwnSKSQwQqvx6T5qgT6WlvZzhImIeVRheCvDOuHyrS
 AHzP9Z1QqpJS8biAIlTisqobWq4LqUeVicr1rJ1hVgrZmW990EBzaZfjQ6+FYa3IP3BscnlE4ZY
 HteVWehqVrW6fZSvYcESmjJ18XOhQw==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6942f9b0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=bYWn2dwaQkB-B1967H8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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

The VFIO pread/pwrite functions use little-endian data format.
When enabling the Bus Master bit, the value must be correctly converted
from the CPU's native endianess to little-endian format.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index fdff042ab4..3c8284284f 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     if (ret) {
         goto fail;
     }
-    pci_cmd |= PCI_COMMAND_MASTER;
+    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
     ret = qemu_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd), PCI_COMMAND);
     if (ret) {
         goto fail;
-- 
2.43.0


