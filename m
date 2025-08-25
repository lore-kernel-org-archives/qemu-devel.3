Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2B7C8303F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 21:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqegs-0002AN-4d; Mon, 25 Aug 2025 17:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegf-00023N-1e; Mon, 25 Aug 2025 17:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegI-0001qm-2E; Mon, 25 Aug 2025 17:25:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PKkf5T006750;
 Mon, 25 Aug 2025 21:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CKaNldD39gux0n5zr
 u7jawIwcYcN6/uuiAt/GMnnGvk=; b=ZqTs8bffCdKmEeQWfrwR5FwTcYroaUKMG
 Q/51VBcVP41051/xU0Ynmixc4ru2GD3sF4oMAs3+AXK0ZE7F7s4TBRip+1dsX/nT
 Lu7BTTBRR7UMb8o2P2ENGugQVNK6OV/6bXltDIrYIZgas0aOMAQ/mlpO3jTgbuyG
 DbezAA3J16JV0+qdI6QZfwycUjAu1qD+/NfzRcjd4UVdUMkolkNht9rpfGxS1h08
 /N8Ope3Ebo6jDBUI+K+EwWMMTTd5BxyhkJx/5CtKIkOkSe2jPda11XVE9F61jmSi
 EHNn6mGl6nWTaAxu6tSc77SDFtIHL6Xb8PPBw9TsxbpGsQk6jNiiw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42huaad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57PIqBuM017993;
 Mon, 25 Aug 2025 21:24:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp37gk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57PLOaVl8455408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 21:24:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 955DA58043;
 Mon, 25 Aug 2025 21:24:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED0985805E;
 Mon, 25 Aug 2025 21:24:35 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.253])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 21:24:35 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v2 2/4] vfio/pci: Add an architecture specific error handler
Date: Mon, 25 Aug 2025 14:24:31 -0700
Message-ID: <20250825212434.2255-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825212434.2255-1-alifm@linux.ibm.com>
References: <20250825212434.2255-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX7UGMwpj1PVIQ
 CDREaVJm3cFjDOJ2DpNXjUSYmgsczhuAbS/5PM6UbhaeG3Yk8szeOfk9VsRx25nm2kgP31kOO1+
 W1pp0w7CMneC/ZpU6LfBbAdSWlwXkd8G8PyRI9TCRSoC+EGSCuBFs+2cYZ5oW4em+OO9XM+qI/m
 Gw5PBzlkpr/8fqsXQK5VnzjZqlVAV+mWSB5AyKn8pm7U2hYZV74NtMQeuiloSjCCAiu6gAp/vT4
 HB6HwH540HulZ/JSTpdXh604crnEjfoZjzlbi0gBs5Gijyn+qsBP/UsowcZglCR5VwuXEjpYeYt
 Lr3tOG+Na8a99Y93zm1BTM3E05dIIHhlC/P1NoikKmma8Ft9bes71h4otXpcRvtbnvpPJ9XLlH7
 wqdexRZJ
X-Proofpoint-ORIG-GUID: yFcyvvTyou-BThCj3p-15iCxFyLn3-7l
X-Proofpoint-GUID: yFcyvvTyou-BThCj3p-15iCxFyLn3-7l
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68acd496 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=muFhjd4W0z0y0MAsxxIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Provide a architecture specific error handling callback, that can be used
by platforms to handle PCI errors for passthrough devices.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/vfio/pci.c | 5 +++++
 hw/vfio/pci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa0..3c71d19306 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3026,6 +3026,11 @@ static void vfio_err_notifier_handler(void *opaque)
         return;
     }
 
+    if (vdev->arch_err_handler) {
+        vdev->arch_err_handler(vdev);
+        return;
+    }
+
     /*
      * TBD. Retrieve the error details and decide what action
      * needs to be taken. One of the actions could be to pass
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 810a842f4a..45d4405e47 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -145,6 +145,7 @@ struct VFIOPCIDevice {
     EventNotifier err_notifier;
     EventNotifier req_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
+    void (*arch_err_handler)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
     uint32_t sub_vendor_id;
-- 
2.43.0


