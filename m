Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6453C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Li-00028f-FK; Tue, 11 Mar 2025 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1ts1LK-00022G-At; Tue, 11 Mar 2025 11:16:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1ts1LI-0005b2-F8; Tue, 11 Mar 2025 11:16:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BD9Gdx001414;
 Tue, 11 Mar 2025 15:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Arl31x0MijP9cRGMk
 DMApcImfI7o8BjEhAUPtlbgcuY=; b=Y6HikptswulLroQ5hrmALgky6EMue8cNN
 GRXvQknaMIp3wIHwQpKmf3pXLSqSpEsEVdLUfLAHeJSbAuR+UOkb/zhG0tNQsH/j
 7svF6p5owUFd/2aQuvFxhUTrc79ULd7bovEHcpNkXNeZw1qRPpUeYZesBmEjTmmp
 K3Zqn9SlRTPEWSbgyPPDzJrh0bIp3Tqofd0KXplD89vWc2xG/2hJtsLNOLuqqAPY
 uTPgO/370mADzkEnv6wKWu6MXhEYhJN5Q7h1ZQum8p6nsh/dIqF06WUKRYAPYFxF
 HX0WaZzcydY+K/G1v0iBWsAxbmT9YyAM9c71jYOxV7/k6rtfJyzYQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb3f7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:16:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEuDxX014024;
 Tue, 11 Mar 2025 15:16:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1vd9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:16:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52BFGOEO19988992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:16:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164EB58058;
 Tue, 11 Mar 2025 15:16:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D037558059;
 Tue, 11 Mar 2025 15:16:22 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.244.69])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 15:16:22 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v4 4/5] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Tue, 11 Mar 2025 11:16:15 -0400
Message-ID: <20250311151616.98244-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311151616.98244-1-rreyes@linux.ibm.com>
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M0o2a53PHG1K5VVNJEaTx1Iq_EcsLj7F
X-Proofpoint-GUID: M0o2a53PHG1K5VVNJEaTx1Iq_EcsLj7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3fa986ca45..4da246c538 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    APConfigChgEvent *cfg_chg_event;
+
+    if (!ap_chsc_sei_nt0_have_event()) {
+        return 1;
+    }
+
+    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+    memset(nt0_res, 0, sizeof(*nt0_res));
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
2.48.1


