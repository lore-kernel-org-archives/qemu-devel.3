Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED484E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 21:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGgM-0008VG-HE; Tue, 07 Jan 2025 16:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tVEYh-0004Ur-ON; Tue, 07 Jan 2025 13:44:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tVEYe-0002uU-7w; Tue, 07 Jan 2025 13:44:07 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507I4BN7005288;
 Tue, 7 Jan 2025 18:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SzCnmuDHwZImq6txC
 eTPY9bwgri6jpswk1Wf+tRGCu0=; b=jnJ5L+damziJmh5QjHTf/jwfObTE8pyG9
 YsDebhAVnBeo4uB585Iba3Vd2evlyexIBLSByqSIrw+E5DZQEnG0wIJJnNvl6VHg
 3nUFGaeMmFTJ6kep77HGxrCUfKccVf4+y61pAOmsVFYWZBIJQvxJA++q0w2mHUWM
 SObKeYyG6ZP958vfgTVcGevy+bqVd+aavIrGf629xtbnYI1S3TqZKeVlzKRxDSaF
 oEOv/ouRGS2gjK3031WfpADICPJlr7iRlXqxvVIYuZsUKvQ8b9uGw6iLLElEKVyf
 36EoYkXayN0hRM0SACGW9Y3sTiqjnHFexe8oB94SEaOMPrewPBYig==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3aw71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:43:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507HKvbu027997;
 Tue, 7 Jan 2025 18:43:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk3r56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:43:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507IhwuC31982306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 18:43:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D1FF58061;
 Tue,  7 Jan 2025 18:43:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC8F758058;
 Tue,  7 Jan 2025 18:43:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.174])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 18:43:57 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: [PATCH v1 4/5] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Tue,  7 Jan 2025 13:43:53 -0500
Message-Id: <20250107184354.91079-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250107184354.91079-1-rreyes@linux.ibm.com>
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tgZY5GFeuvVJqvmF4WWxmpK5Pz3hlQaC
X-Proofpoint-ORIG-GUID: tgZY5GFeuvVJqvmF4WWxmpK5Pz3hlQaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jan 2025 16:00:05 -0500
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
 hw/vfio/ap.c                 | 37 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 17 +++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 508c6eed7a..9d1e18f100 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -94,6 +94,43 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
     css_generate_css_crws(0);
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    APConfigChgEvent *cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    memset(nt0_res, 0, sizeof(*nt0_res));
+    int rc = 1;
+
+    if (cfg_chg_event) {
+        QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
+        free(cfg_chg_event);
+
+        /*
+         * If there are any AP configuration change events in the queue,
+         * indicate to the caller that there is pending event info in
+         * the response block
+         */
+        if (!QTAILQ_EMPTY(&cfg_chg_events)) {
+            nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
+        }
+
+        nt0_res->length = sizeof(ChscSeiNt0Res);
+        nt0_res->code = 1;
+        nt0_res->nt = 0;
+        nt0_res->rs = 5;
+        nt0_res->cc = 3;
+
+        rc = 0;
+    }
+
+    return rc;
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
index 470e439a98..c9beec3db4 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -16,4 +16,21 @@
 
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
+int ap_chsc_sei_nt0_get_event(void *res);
+
+int ap_chsc_sei_nt0_have_event(void);
+
 #endif
-- 
2.39.5 (Apple Git-154)


