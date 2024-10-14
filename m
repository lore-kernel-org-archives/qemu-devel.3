Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF9D16258
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KBO-0000Lr-MO; Mon, 14 Oct 2024 08:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KBB-00008E-QJ; Mon, 14 Oct 2024 08:28:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB3-0002OU-Gt; Mon, 14 Oct 2024 08:28:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ECNwuJ002626;
 Mon, 14 Oct 2024 12:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 9bILM+ajOn4ZmA8j++WZz/jUN9VoQndIz+V3LVRILp8=; b=L5axbBDaCKJxVaup
 0TCIjQdG6xUNaOxsy1YckaGkIt/Uu4l1wYgTO+ZpLoPqS5kgJcU+oF+li+eUW4SD
 h/sUbxfcRwlVKEb+E175nUP+k3T4Y04LEE3tRozN5ADydGm64lgwOeBkMk6R1Q4D
 SsdrCHS8Uj7lP4rXbpI8M7fU9Dvgnhj5xYxBGs62HMVL6l6d/PdByiq5pS3qIzHy
 9yzDwM/yK2LBLlu4JejmtM5u7RYF4fN35LWaSylQIdn1bVhBCZcVxE6qhSGMISSJ
 9hPZ0fagvW8B4o6c/ik5lqA531MB9TDRhdutoMyPYUmxNLF5MdFeCoHqaqK5xC3i
 4wXhcg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42939080hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECRlts010470;
 Mon, 14 Oct 2024 12:27:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42939080hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EB1xrE002426;
 Mon, 14 Oct 2024 12:27:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emeff8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRilE41288082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E59072004B;
 Mon, 14 Oct 2024 12:27:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0921D20040;
 Mon, 14 Oct 2024 12:27:43 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 01/13] ppc/spapr: remove deprecated machine pseries-2.1
Date: Mon, 14 Oct 2024 17:57:17 +0530
Message-ID: <20241014122729.1136809-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014122729.1136809-1-harshpb@linux.ibm.com>
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWf8SOSN9OKyAk52p0T7WmAM-yQ3qPq3
X-Proofpoint-ORIG-GUID: jw2wY41VMbu3pSFlm1kRlWawIfmgfys7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=669 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.1 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/boards.h |  3 ---
 hw/core/machine.c   | 11 -----------
 hw/ppc/spapr.c      | 11 -----------
 3 files changed, 25 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baa..44d19e1ffc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -828,7 +828,4 @@ extern const size_t hw_compat_2_3_len;
 extern GlobalProperty hw_compat_2_2[];
 extern const size_t hw_compat_2_2_len;
 
-extern GlobalProperty hw_compat_2_1[];
-extern const size_t hw_compat_2_1_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..a41d1dbe26 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -297,17 +297,6 @@ const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
 GlobalProperty hw_compat_2_2[] = {};
 const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
 
-GlobalProperty hw_compat_2_1[] = {
-    { "intel-hda", "old_msi_addr", "on" },
-    { "VGA", "qemu-extended-regs", "off" },
-    { "secondary-vga", "qemu-extended-regs", "off" },
-    { "virtio-scsi-pci", "any_layout", "off" },
-    { "usb-mouse", "usb_version", "1" },
-    { "usb-kbd", "usb_version", "1" },
-    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
-};
-const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c10a70a48..e9518ff8b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5381,17 +5381,6 @@ static void spapr_machine_2_2_class_options(MachineClass *mc)
 }
 DEFINE_SPAPR_MACHINE(2, 2);
 
-/*
- * pseries-2.1
- */
-
-static void spapr_machine_2_1_class_options(MachineClass *mc)
-{
-    spapr_machine_2_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);
-}
-DEFINE_SPAPR_MACHINE(2, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


