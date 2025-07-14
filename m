Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0395DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLQ0-0004gQ-Pj; Mon, 14 Jul 2025 11:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKBA-00082p-7s; Mon, 14 Jul 2025 10:29:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKB6-0002fY-1O; Mon, 14 Jul 2025 10:29:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6CK001413;
 Mon, 14 Jul 2025 14:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=tk5fkxSAtSKuWs98ycJFlpz1H4LyUdJVzy8KeuvCkF4=; b=
 XaouKilcSnQD72WWImPRy53la6FtGTuinvgMsnu+9uuwdY/1tJLIgt/wuTMDuBgt
 B1hIxOjTgECRV47BTfbUSZfs3WyTGw5AhhSKCTo88X0XKSZvAkIT130Hv1Uus/Ig
 YisfVFQ+vBh54bWwMehOaHJblSMsXN4fY10XeDcPk+gOBrmgQWTEa3S49iC8likz
 TkqiK9IKTOCn/CBl01TRjyiZpzh8PhDVmmh3LROCqBKGUXSxBHaDvNyQjhwtSkmR
 dXS/gP16k6T4IZkiP8zUrOuO6tQmjptPa9HzdQVTKdVfLabeQwRRWb3pRLx+qqIc
 esZ5LgVJnGJUI8jGyyg7oQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv846-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EEOjaB010901; Mon, 14 Jul 2025 14:27:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kgq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EERLK4040396;
 Mon, 14 Jul 2025 14:27:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgnu-2; Mon, 14 Jul 2025 14:27:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/2] hw/intc/arm_gicv3_kvm: subroutine for save pending
Date: Mon, 14 Jul 2025 07:27:18 -0700
Message-Id: <1752503239-222714-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
References: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: QfPB42MKEDsw1Csq1H6a0P7rJqtJMoen
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687513cb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=gMFKxlV9jZ9YN_hqq3IA:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: QfPB42MKEDsw1Csq1H6a0P7rJqtJMoen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfXxP6FW0nkvTJD
 uH1a/IaqIPh9h3tBqMGwflCZk29/ZFyzO77oA1qCTI7aVhdGV0NFPAxt8qvcsBd04CrJiheF8qV
 2YRUY8h/Pou6kThP3/ulLk2SJxm/75jFe/5D628g5PFv6UE4qs9R98nrAHtvUQUVzlVjn3GYLSv
 wMSM/5yvzqaW/yloF6Dnsbc7hhn2S1xbkMA88p6EiWRtfJdcVoBUPn+BkQaVXHdxK+k817Iq3Qe
 cBYvFnlpuW6YMMKfuPEkiFwypiCh+Fnu4cvVwhsF4mG3uDg/sGihZMG/0UwmVHYLL4gfg9DBbXW
 7VxvLVqmEvduDCKjz153ZPtnxeMP4MUdDaML29L+OahPFgHQIhdrh1AhZptaMhYFbiwJzv9+NLG
 x/QJI5SbwidohLn6qWKqDDT1SQFRLA1s1mpKVX1BFjcy4Ea3tdwYUenncFQmh3jUtiJ/PoFV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extract a subroutine for KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/intc/arm_gicv3_kvm.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28..43cba6e3f1 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -749,6 +749,20 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
     },
 };
 
+static int kvm_arm_save_pending_tables(GICv3State *s)
+{
+    Error *err = NULL;
+    int ret;
+
+    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                            KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
+                            NULL, true, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    return ret;
+}
+
 /**
  * vm_change_state_handler - VM change state callback aiming at flushing
  * RDIST pending tables into guest RAM
@@ -758,20 +772,12 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
 static void vm_change_state_handler(void *opaque, bool running,
                                     RunState state)
 {
-    GICv3State *s = (GICv3State *)opaque;
-    Error *err = NULL;
     int ret;
 
     if (running) {
         return;
     }
-
-    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                           KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
-                           NULL, true, &err);
-    if (err) {
-        error_report_err(err);
-    }
+    ret = kvm_arm_save_pending_tables(opaque);
     if (ret < 0 && ret != -EFAULT) {
         abort();
     }
-- 
2.39.3


