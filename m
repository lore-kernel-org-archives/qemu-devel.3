Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F134C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQij-00028d-Fb; Fri, 09 May 2025 12:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiY-00024j-2x; Fri, 09 May 2025 12:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiU-0000CZ-KG; Fri, 09 May 2025 12:36:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AemwQ003938;
 Fri, 9 May 2025 16:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=z+c0x+nvW4bJcM4OY
 exbji+5LoZMUs+4i9c/Z7KPEFo=; b=KZmTtVrrIU3YXvT82NbKj8OL6/OpmPM4M
 BN8U0tEr2PM2kWFjgT7NN8iqsnrThY45RgoMlGFKsBAm8ZLJXLt3KIaZrUt6A4mJ
 XCXSq8OU7ezQrMnnt04Dy8kiFL9+QFVwlwQYqAE+wkeB7VY86xHduAMX8rYl9z/U
 POQp7emlWleVvhcrK1VNz2KeZ3kb3pZxH0X6OBLAtzWStQY01hAZ8BC1BOd7cDDq
 G0L1E+lOtloG9D+/7NNasldetf7YY1s2dLQizAPFg2RX/WJrcMPeihzGCWgkYMa/
 yZDc8jvwg6gd3Y3WjwEMcjrafuRn8jNerjpfnBe70GN+W62N3vU3w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46hg5shv0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549E6ffp013830;
 Fri, 9 May 2025 16:36:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062v3yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 549Gaoge20644572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 May 2025 16:36:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C999C58059;
 Fri,  9 May 2025 16:36:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1146558043;
 Fri,  9 May 2025 16:36:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.92])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 May 2025 16:36:49 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v8 5/6] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Fri,  9 May 2025 12:36:44 -0400
Message-ID: <20250509163645.33050-6-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509163645.33050-1-rreyes@linux.ibm.com>
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5XN1kI1JeK8wPq4BjqJv1bqHIFlTveuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2NCBTYWx0ZWRfX1CMLPPKq+0uR
 SdmiQ5CeOXaHhu9kKXJJpxDRgmEB8/wUxDhdp0zPxL3bOoO6Q0XUZHr60VkmT33AkFtd0mHfj/1
 Ug+9ZKCdh01boTHBFV5tb/HWrezxaluQOmHNplI7KYWjRffaGAujxWmPifcvr0CYQz9gSU6WNYg
 RPMzhiN/6hUHrlyBXAXf5PFp1waA2peRsyZHgIywtFfrTVCrH4aJ+oXdH40Nhp34GYWzPm6pCac
 mbKWmHdJAPXCGPO31AZ2FlDknYaQPWUt4r+JUKxW0dfA5jKN1bXQVIv1hzmyol798avqKRJ9DDz
 O183DzEkMS1EDg+rH8iHqdTMfkYj00FtFuG2VPxlkCAwfNZ4udpa0juYu7UuSI8/W7cUg5Jcj+L
 7ptlrZPnbPuSSZb1hjF9dz7PAUKPAZlcQTaveqqP/ophi1B+nEyFreKEv4Ttm9qfelUh/cRk
X-Proofpoint-ORIG-GUID: 5XN1kI1JeK8wPq4BjqJv1bqHIFlTveuB
X-Authority-Analysis: v=2.4 cv=NrjRc9dJ c=1 sm=1 tr=0 ts=681e2f24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=1fYsFTRr82c5d5Av3T0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090164
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
index 5ea5dd9cca..4f88f80c54 100644
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


