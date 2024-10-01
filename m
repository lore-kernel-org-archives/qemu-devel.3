Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFE7CEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdUQ-0000jZ-U0; Tue, 01 Oct 2024 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdUK-0000j7-7q; Tue, 01 Oct 2024 10:04:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdTt-0000W8-44; Tue, 01 Oct 2024 10:04:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4916KWV2016468;
 Tue, 1 Oct 2024 09:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 V6g208rEQrXlGVcx7r14x4APCR7rw1eeMbc8vkI5vQ0=; b=pFtgETgHY2j5vRy5
 /ASl4WnLoxODY1elRQDv4mQBduo0tYoOZ6n8jCWEfOkuBQncStWTln+otyTDir2b
 ftLs3BUsh50QgrJLBLz+RUZO9Vu1yV1Qs8A8w9/RvVfq6KcmQ0DyNjTJgPZHmgYn
 nrEJkXv6Mg9sPyoHJs26LgbIHBJ1q9a5PlQdlrvRc5DYSzLLT8N/mv9zVnlKhEYf
 xhLTJopzFOp4w44gNop9ngj4SX3cDO7zXzaVy9mZPXQ11616/+CJ+R7wdBvggH17
 qZKbdSunu0eb9SWSpltfkS3lfx0HgItAia7xGRNgC0aHF0ty7kAYpjlTiS6e0YD8
 8Kk/FQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqn8wc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4919TUGr027522;
 Tue, 1 Oct 2024 09:29:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqn8wby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49192425017866;
 Tue, 1 Oct 2024 09:29:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4muf91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4919TReg50331980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 09:29:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C73DB20049;
 Tue,  1 Oct 2024 09:29:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E227020040;
 Tue,  1 Oct 2024 09:29:26 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 09:29:26 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v2 09/11] ppc/spapr: remove deprecated machine pseries-2.9
Date: Tue,  1 Oct 2024 14:59:08 +0530
Message-ID: <20241001092910.1030913-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001092910.1030913-1-harshpb@linux.ibm.com>
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OfGjLMKqDm3EcxOiB_kWlGdz0Th7UR92
X-Proofpoint-ORIG-GUID: yCMwi1JG6XKAB3S9nYTrYGI7b0uSBeaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_05,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2410010055
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Removing pseries-2.9 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/cpu.h      |  1 -
 hw/ppc/spapr.c        | 20 --------------------
 target/ppc/cpu_init.c |  2 --
 target/ppc/machine.c  |  2 +-
 4 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cab4a46fc1..74a0ab768d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1456,7 +1456,6 @@ struct ArchCPU {
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
 
     /* Fields related to migration compatibility hacks */
-    bool pre_2_10_migration;
     bool pre_3_0_migration;
     int32_t mig_slb_nr;
 };
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97ab253fcc..84da4ece77 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5184,26 +5184,6 @@ static void spapr_machine_2_10_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 10);
 
-/*
- * pseries-2.9
- */
-
-static void spapr_machine_2_9_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
-    };
-
-    spapr_machine_2_10_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    smc->pre_2_10_has_unused_icps = true;
-    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
-}
-
-DEFINE_SPAPR_MACHINE(2, 9);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7768392986..39c19e6674 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,8 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 }
 
 static Property ppc_cpu_properties[] = {
-    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
-                     false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
                      false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 21bed7c7c8..47495b68b1 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -630,7 +630,7 @@ static bool compat_needed(void *opaque)
     PowerPCCPU *cpu = opaque;
 
     assert(!(cpu->compat_pvr && !cpu->vhyp));
-    return !cpu->pre_2_10_migration && cpu->compat_pvr != 0;
+    return cpu->compat_pvr != 0;
 }
 
 static const VMStateDescription vmstate_compat = {
-- 
2.45.2


