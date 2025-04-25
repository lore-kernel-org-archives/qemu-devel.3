Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B567AC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 05:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8BYR-00009R-Lw; Fri, 25 Apr 2025 01:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXq-0008Tp-Ap; Fri, 25 Apr 2025 01:24:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXm-0004H5-Uv; Fri, 25 Apr 2025 01:24:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKDTdf022647;
 Fri, 25 Apr 2025 05:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WdrJg3k3iYg1Fbznw
 iJQRQmDNzW+vHw3NlbsIuLykmE=; b=NxNe+vp/NkIQHpllHAWPOPQiGZB9nTvua
 wRS7BBKJYg3WFEF9HxEJEiMrIShZC48VLO6zDQcaFzv1LYnl0QIkayDIUr0Rvjkz
 LyYqvN68SCuWM1DP7s3hEsi2JydPYTtGBfpDTRQn3420PaYRzUiTLS27FUHecw4b
 rAQpHIyJhJb77lUXU3kSK3yXtd7Lncr/g6RudNwwq9DTw2HA+0vnGhci+i2JK6FJ
 RVCf8a0FkZcFm5DNsYtDcNfF0JYm7Qry+3wVxaEpSacB+88zETyQX+NxHXx8QQmj
 ecjlNwsfLmEe4WVXrM+Dw1eSWr0Z7s0mqbCqdPqNHy6Smv+Vbjvbg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krsvh9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P4EI2Z022276;
 Fri, 25 Apr 2025 05:24:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxkr0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:08 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53P5O7qS25952938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:24:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 410975805A;
 Fri, 25 Apr 2025 05:24:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 749C758051;
 Fri, 25 Apr 2025 05:24:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.76])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Apr 2025 05:24:06 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v7 5/6] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Fri, 25 Apr 2025 01:24:00 -0400
Message-ID: <20250425052401.8287-6-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425052401.8287-1-rreyes@linux.ibm.com>
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzNSBTYWx0ZWRfX4iW8yX7jklRP
 6ZalB5eslnbadubBwNXtFnEgr4sajxpYhmYQ81jcDQ6NiqTYmXjUSgTUO82gszzcKuAgRfo/y8N
 S37ryjSaLhP/l8mL6Q0cUukj5bfjcXAnvG28132HhEa8486AvenD55UqHgfpAl517GwMJ6F4Ae8
 y3RLAhLmx2hzSBU81iWP37LqL8+7w1HzWqYkfzmCxiZlsdudixZYS2+aDz7Rvcu/0bNBH0txUII
 mIqheIB3q0Xz9BifhWmrcQUj925qLMkKTky0e4tODyyVS9txu+wsX8s1aWw0lCZzU6rWq+eb8nN
 Hdwf9JzS29gqHlCus9xaUw0kz9CmYDwuYsjRHM877yZlx7FGXklsMfsftAY2gnC9ouBgwHUQpjA
 uJoiLsaWqivOG7ohkdrrLYrWy3K6Rn9o5u0d9e4k1eASiHu51KCly7WKElLQPdBq+qVzD+41
X-Proofpoint-GUID: 4hNiLArtpqY8LbmvXguvF75CYrO04kfz
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680b1c79 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=5Tnt1MKFKjqkw37VLmgA:9
X-Proofpoint-ORIG-GUID: 4hNiLArtpqY8LbmvXguvF75CYrO04kfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3e94d6ffce..3a013764b9 100644
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


