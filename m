Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04897C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOXo-0000MY-Qt; Wed, 26 Feb 2025 16:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOXj-0000CY-Lh; Wed, 26 Feb 2025 16:02:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOXh-00035E-Ou; Wed, 26 Feb 2025 16:02:11 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QH74QK007093;
 Wed, 26 Feb 2025 21:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yvzsom2F+5FwazjKq
 /uiqlqve/NsX1bjsUFFmfiKie8=; b=XbubACf3ooOoBogAmEOpu7sIJ5u8AcWjY
 DWwPL8NIgcNOLDErbZk67OInmsYoLPaP21ngUT1abbUQiklt9X3KTCQGSdZdnSsG
 syI/h+IrnF+8JGJm2uGNV+WX2si0zzmphXOQMhN45luXMv8uFFGQ+kZFSFdPafph
 98qPOumqm/r57DU8/Rnf3qswlc6dhlUiYGX3wLtyd2XKTS8NjyutqYcZx1wcRBpz
 idvfoPt8SWImwKyQBJNrHSxGS6iOY7UgXRVopHs7ZExzHAIfBb8aANBRHH+GVkNW
 gu5w6gjLFwDz8ChBpzMbrINW5VegPQsZXoMhuS+ZsyukLU9QIRf+w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp3ugj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:02:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJZtg9002570;
 Wed, 26 Feb 2025 21:02:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jvm2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:02:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51QL261s9830998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 21:02:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C8D758059;
 Wed, 26 Feb 2025 21:02:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAEB558053;
 Wed, 26 Feb 2025 21:02:04 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.46.135]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2025 21:02:04 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 2/2] s390x/pci: add message for ISM without zPCI interpretation
Date: Wed, 26 Feb 2025 16:02:01 -0500
Message-ID: <20250226210201.238489-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226210201.238489-1-mjrosato@linux.ibm.com>
References: <20250226210201.238489-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NUC3eW7FcMQI8keoIVAT3IXvkT1Ces7W
X-Proofpoint-GUID: NUC3eW7FcMQI8keoIVAT3IXvkT1Ces7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=849 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260163
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Currently s390x does not support ISM passthrough without zPCI
interpretation.  This is already fenced, but the current message will
not provide adequate information to explain to the end-user why ISM
passthrough is not allowed.  Add a proper message.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 6cc0e7538a..c41c88f88e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1147,6 +1147,12 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->forwarding_assist = false;
         }
 
+        if (pbdev->pft == ZPCI_PFT_ISM && !pbdev->interp) {
+            error_setg(errp, "zPCI interpretation is required for ISM device "
+                       "passthrough");
+            goto pbdev_cleanup;
+        }
+
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
-- 
2.48.1


