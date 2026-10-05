Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59156CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDmiq-0001My-Jy; Mon, 05 Oct 2026 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmij-0001Ky-SA; Mon, 05 Oct 2026 13:43:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmih-0007YJ-8z; Mon, 05 Oct 2026 13:43:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZrQq1257970; Mon, 5 Oct 2026 17:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K3e3zL8kBO4quMbID
 CYCTuLs2hTd7jJl1EXMPtlluG0=; b=BBNTvTsiBjKEuZW8LQ3UynLHoHGNPlQ+7
 fTIFt78JIAF7QCYXaQfHkhZS4Eji7QXGFZq/O3fHaFjYB6VNsRTlAPrvehzJkwVy
 /Q1vDGcylycxTkH6TnCtGeuyRiDcfI5RE/6Rmt4ZeczC6mxSNSDGMHciykSfu8A2
 Qy+TW9Wss2ZmJ98aSvWgpgMR1//nzAj9gMnWxhmzg+S9kKc5pWkUxisr+0/NQJf/
 l+qf3ybKPhMMTHHKtsnhRD1V5C/S9BNas8fR6gUsmROUAH3fcka6Nadw1mIwbFWN
 UdEbBv8IA4/Uj/uSrsJtpbhOra0x9bjFmZ7QOiZy4r6YoYiSkMIfw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5bmbq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HMYDR3214609; Mon, 5 Oct 2026 17:43:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jpffv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695HhHsB66519302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 17:43:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7944F58056;
 Mon,  5 Oct 2026 17:43:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2B315803F;
 Mon,  5 Oct 2026 17:43:16 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.223])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 17:43:16 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v7 2/2] s390x/pci: Reset a device in error state
Date: Mon,  5 Oct 2026 10:43:14 -0700
Message-ID: <20261005174314.871-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005174314.871-1-alifm@linux.ibm.com>
References: <20261005174314.871-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX9i9nUHiEyHu2
 knDAJkVZS1UU7NlgUVKeJAZKS5DAKAMhXyWkOaKiiozUGnmEE7EBvh0+Cf5PBkFjTFbvhAjwrKN
 m9lRRlxzZBXygeiTX4qLHnmkUor0CAs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX8ghIqwF1C3s5
 dCjxdQ/M2Y5ZOen6CxvP/bhOc8mUfhrE5v9o+nsrl7SqMmAp434nQCsaMTz/KZbaiR9HpO8g7Df
 7hqgXOxCGlKjPfx6Mgv0fqoFznHXx1EhfXq08P/1C1UiUVag0xiguxSKifcVQ9AIoNbdI/QZyrA
 QNaZgdNsCy30TlesVQz4WYhLHmptWV5sbJJDbhVyXKnvkNNJH6mmLHVjam3F5W2gq8KOJR7P90x
 zpiLo84VOyiFU5GrS0/BI6v0io5v7TCs6x/RLChIC59f9l13/lod3eMsyzyRRwtAXRnwp+Ize1L
 XWUmpQjBo5VKnA4vEwulzFZGqhZs8GTh6Uj+FTgbfV5l7SfGVKa1Tr3pcEHB7gl5DbT6GgXQ7E3
 evkiesu9KkQLGxKuy+DBcFdc/YeqOb4juUtjeHdSArLRdz/bR5P+q/2C6G1gHjRoHd8aLgcEqXm
 iok3FVL9vyEOM5qn1xw==
X-Proofpoint-GUID: yHCYHp6zUU9nW3N5AtYJkxX81cc1cZea
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3e1b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FuZLNSxbJke2QbDKExoA:9
X-Proofpoint-ORIG-GUID: yHCYHp6zUU9nW3N5AtYJkxX81cc1cZea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050069
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b2967dacba..6557ec4240 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1505,6 +1505,21 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        /*
+         * Attempt a reset to recover the device. A device in ERROR state
+         * can be transitioned to ENABLED or DISABLED state via guest
+         * driven actions.  Since this code path is also executed on
+         * subsystem_reset() and the expected state of a configured device
+         * after subsystem_reset() is to be in a DISABLED state, we need to
+         * transition from ERROR to DISABLED.
+         *
+         * Linux guests drive the state transition from ERROR to DISABLED
+         * via CLP_SET_DISABLE_PCI_FN. So it should be safe to transition
+         * from ERROR to DISABLED state.
+         */
+        pci_device_reset(pbdev->pdev);
+        /* fallthrough */
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
-- 
2.43.0


