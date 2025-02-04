Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72778C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMPI-0004dY-2K; Tue, 04 Feb 2025 12:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMPD-0004bS-PT; Tue, 04 Feb 2025 12:08:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMPB-0007OD-Eh; Tue, 04 Feb 2025 12:08:10 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnbF028646;
 Tue, 4 Feb 2025 17:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+5G/FltpwJ2BlrebO
 7IMI9chV6ZbWSu1tllcaz/IvK0=; b=EvWTZtJ/hwf93n1ZZaVtah46QvMd3S4f/
 Mi1E/p+u/8i8sGuILYlFrQRuflShgz+9IcY4ztwdiTEwy4qf6c42Ht2cBLpuHqbq
 o0Jx6sXczC+IqcN+J0MeRVR9Mcfms6Ex1LEUFczNknZBSiID/c/xuiTaXeNK4zkr
 LbkUXANTOJCr1YC16+8et5PXeDKzlxqyy+xmleJ7TxpiiTfTfbBxOyZPMDgdi0sc
 Dw/tyaeZzRRPTh3TWJSFcC0Zm21GmRGkGn3WGmjbY8Kofn2wshOi2uguIivUe6Tr
 Ow9/qEeZHq1srxKeE5e+EzIqcgRsAgHKfV3GC8DH3ylMMCow5JICg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtrekk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514GtddF006540;
 Tue, 4 Feb 2025 17:08:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekcekg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 514H86i814090888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 17:08:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70A5158053;
 Tue,  4 Feb 2025 17:08:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF9358043;
 Tue,  4 Feb 2025 17:08:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.255.239])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Feb 2025 17:08:05 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: [RFC PATCH v2 4/5] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Tue,  4 Feb 2025 12:07:58 -0500
Message-Id: <20250204170759.36540-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250204170759.36540-1-rreyes@linux.ibm.com>
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SjHrzZXisTKxd7jUCVR619KoNK4y734V
X-Proofpoint-ORIG-GUID: SjHrzZXisTKxd7jUCVR619KoNK4y734V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c                 | 38 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 22 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 396fcf87de..1ec5d1a64c 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -94,6 +94,44 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    APConfigChgEvent *cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+
+    memset(nt0_res, 0, sizeof(*nt0_res));
+
+    if (!cfg_chg_event) {
+        return 1;
+    }
+
+    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
+    g_free(cfg_chg_event);
+
+    /*
+     * If there are any AP configuration change events in the queue,
+     * indicate to the caller that there is pending event info in
+     * the response block
+     */
+    if (ap_chsc_sei_nt0_have_event()) {
+        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
+    }
+
+    nt0_res->length = sizeof(ChscSeiNt0Res);
+    nt0_res->code = NT0_RES_RESPONSE_CODE;
+    nt0_res->nt = NT0_RES_NT_DEFAULT;
+    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
+    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
+
+    return 0;
+
+}
+
+int ap_chsc_sei_nt0_have_event(void)
+{
+    return !QTAILQ_EMPTY(&cfg_chg_events);
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
index 470e439a98..f4d838bf99 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -16,4 +16,26 @@
 
 void s390_init_ap(void);
 
+typedef struct ChscSeiNt0Res {
+    uint16_t length;
+    uint16_t code;
+    uint8_t reserved1;
+    uint16_t reserved2;
+    uint8_t nt;
+#define PENDING_EVENT_INFO_BITMASK 0x80;
+    uint8_t flags;
+    uint8_t reserved3;
+    uint8_t rs;
+    uint8_t cc;
+} QEMU_PACKED ChscSeiNt0Res;
+
+#define NT0_RES_RESPONSE_CODE 1;
+#define NT0_RES_NT_DEFAULT    0;
+#define NT0_RES_RS_AP_CHANGE  5;
+#define NT0_RES_CC_AP_CHANGE  3;
+
+int ap_chsc_sei_nt0_get_event(void *res);
+
+int ap_chsc_sei_nt0_have_event(void);
+
 #endif
-- 
2.39.5 (Apple Git-154)


