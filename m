Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC11C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hv9-0005UG-Pe; Wed, 23 Apr 2025 17:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7huC-0005Bp-01; Wed, 23 Apr 2025 17:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7huA-0002mx-7t; Wed, 23 Apr 2025 17:45:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLd3px029581;
 Wed, 23 Apr 2025 21:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Arl31x0MijP9cRGMk
 DMApcImfI7o8BjEhAUPtlbgcuY=; b=Bw6uMeZupBQK/vYcVzmP2yOtJsIAQg5Xm
 0fsUmXZgguNE4FpnmeZQ99sgVkUfm6s0qdiIhC7/Xk4N9PepkC0qOYTdFm/udQ9Q
 ncBKED4wauVgEK6Ykd0k2VhDn7WEUm6mSChEn4CBDT8ZcGPX8n3UGTsRR4AMCxiw
 Le0TiH6dBrnMNbIaf8lUdyVJGe8hbgUWArz2K/u6bFwvmG9VZfc85aYcw8/mYGSb
 McauwNmTYb+yrZ//clyuX4Afpvuk5DyoM84xJ6Hqqq96GPF8QURxvCLK99gVXN2n
 aW+UYAtBx+eqzOHYXlEI0y4P85sqMbDCZMO4wMPhjfoU8ldDjk8Yw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aa80q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NIiDxn005884;
 Wed, 23 Apr 2025 21:45:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxd50g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53NLjDrh27525874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 21:45:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB97F5805D;
 Wed, 23 Apr 2025 21:45:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D10358059;
 Wed, 23 Apr 2025 21:45:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.34])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 21:45:12 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v6 4/7] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Wed, 23 Apr 2025 17:45:03 -0400
Message-ID: <20250423214506.72728-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423214506.72728-1-rreyes@linux.ibm.com>
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NSBTYWx0ZWRfXyIO1pEMS/5TK
 7gRtR4WmjSbvwaQqngtEnlJBgLuppyPf3mHMH9sGcc5u2EPCCXMVZlQu5ZeNX1NUqBUAT3FHHKa
 k01YriNJ4ogENRGb3q5gWUy3Ebu7/LA3J3s9bta+ZxNxoyl0PkV2jYfYc+6j49Ac7tP/QD4MUna
 J0lA7i2ZUuOQUWPpeUbqxkBZsSllnf8ueXFB8gnT7ivyW3TzYoxeCPN4IMnPOgBVKihqPqGvxTH
 O/RKZKf2s6RBMVm5meKxEnZmxO1mP6k5ZEbYaXA7GAy86JTa+vFiiqBoMOqb/obuKraZJoneTf5
 oIsTciyrUvV03GM2Xe/QUibBCkVq346XZawjgYHOOs2Zaj+v5aKHxa/bjo1kKiQ7uLZ42FGRJX4
 zd+n4hPhyW+wc7I/RJK+JdVRlLExwyc1LJwX/Q1TUixDxA58H/F9JAXf2DYGWp96QZnTZQ4k
X-Proofpoint-ORIG-GUID: EnSYEn7X90AHRfpK50Uam90VIDwKpbhp
X-Proofpoint-GUID: EnSYEn7X90AHRfpK50Uam90VIDwKpbhp
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=68095f6c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=1fYsFTRr82c5d5Av3T0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


