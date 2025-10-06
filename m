Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF77CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 16:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5o0b-0001j3-Hi; Mon, 06 Oct 2025 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v5o0I-0001hw-FM; Mon, 06 Oct 2025 12:24:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v5o0A-0004PM-2m; Mon, 06 Oct 2025 12:24:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Fu14D027039;
 Mon, 6 Oct 2025 16:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=wpbx3bZU
 3Xjqn4rc9RCKKAaigTLmvam0d0Ns3uFKeUE=; b=KJl2mgIhx1a+dR3DNtkQ/CYg
 s0vTKS6yKT16W5ZObib0FPSs/Dzp50sVIp1RQvEjIbwbFaWFYGJyOub7394muHRM
 JVXUl05VnsOoMrPGfS1FRnHWecrsWP4kOyCnCCyw1Bw24Z3X5Mw+79u3kB4C2yZt
 zV1sgFVKxLZhUIQg0QoFY0aJZRC9dO7C/40STnf6G05LpzFjgGlCcIWc+ofetbun
 /sFsZaZzT8jsPQuLj3BWtL+fON/RKLKwh+zEPP25smicUhIAzz2/Lpbr86EDLpT0
 N/y1xPMmBSfPW0+kZUE8LGkKWObrnJmVlzstv903vMd5kwWAuyfLnMF1yMGd0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mg80061v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 16:23:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 596GBIFi000307; Mon, 6 Oct 2025 16:16:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49jt17a5xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 16:16:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 596GEkOr002628;
 Mon, 6 Oct 2025 16:16:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49jt17a5wt-1; Mon, 06 Oct 2025 16:16:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] hw/intc/arm_gicv3_kvm: cpr-exec support
Date: Mon,  6 Oct 2025 09:16:32 -0700
Message-Id: <1759767392-379114-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060128
X-Proofpoint-GUID: 6jYLzpyMLH-Xt1Nyus9SAys2EFs1Cyyj
X-Proofpoint-ORIG-GUID: 6jYLzpyMLH-Xt1Nyus9SAys2EFs1Cyyj
X-Authority-Analysis: v=2.4 cv=HLvO14tv c=1 sm=1 tr=0 ts=68e3ed0d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=IZNwnb8Dc9TsmVGaVMgA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMiBTYWx0ZWRfX04kMOA517/zb
 rm+Ag2Fua5s5mSaeRzpbBnKbLMcSFK4CUu8CpV/Cnb6aRumC0c8mbqA8U/esV27UDzstVSj0a91
 D+WjpZBpr7UCCbwnalsI73KSrhyLD1+aP2gMr1Slb2IODjxIlB6Cch3YNTDnoS5k1FwGhc8GTGL
 bxLm0ztkIr97SsmciniboHFvRq/A59aBdKkdpE8A98X7EbruKDuT4lRPDBVRhg+S+gyhJbsCIlG
 V4XQGyoiu+/BNjjLoJUQTjZB5A5prjLpHVM8Ff9POG9F2jnWbMue28jcv2glgk0b5kFyn9YtCWC
 bdpYd38cGqQTCpke0vQj6zWmmoN8z5bPvok3AXJPU90wYDmVXnvtd0OpSKvCJqqUFx3sNXTc/fU
 FDr36EmM/v1RGLaUgD07YaTHk1Fj1w==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

The cpr-transfer notifier also applies to cpr-exec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/intc/arm_gicv3_kvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 0cd14d7..ddf60e6 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -929,9 +929,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
         qemu_add_vm_change_state_handler(vm_change_state_handler, s);
-        migration_add_notifier_mode(&s->cpr_notifier,
-                                    kvm_arm_gicv3_notifier,
-                                    MIG_MODE_CPR_TRANSFER);
+        migration_add_notifier_modes(&s->cpr_notifier,
+                                     kvm_arm_gicv3_notifier,
+                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
+                                     -1);
     }
 }
 
-- 
1.8.3.1


