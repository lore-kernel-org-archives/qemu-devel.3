Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E973C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5fq-0007Aa-6R; Fri, 10 Jul 2026 03:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wi5fo-00075Q-6r
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:29:24 -0400
Received: from mail-eastusazon11011059.outbound.protection.outlook.com
 ([52.101.52.59] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wi5fl-0006GI-TG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coKwQr5PnQPVtR4PoA/SsrDvfDgqtbn7WitXMycl2dF02419FBmpozI/O3jedp59Dwtdl/uda/0RWIPHigxirNvpJXLUlaR6tEl9jZ4AsZFQ1e8tgia45J/9fUTblj2LCBk84MW3jNHVfjUXI+y8TPD9coc1kMPKr9CDbkFrmfG7wVLeXnKlUAdv6kILX1npfRjmz+/f84U9gIF41GhMaMpgQ0f90jIG39ktul6mDJwJSIw9j7zaaAFl/CY2sK1YGu0LSmuet4Yrd+hk8egIxBxDDS0VkuZxndIwiYcmeVc+lDAQFyeLorZnf8fvwuldMaw2Ix1ammCeejlz2DSomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0pt+hOkxwqSiCbPzfi7fpRAjF5w3dB8Jtk2pmqMYv0=;
 b=OkjzYcpEN4jVDzIm6sCQudNqea1PuhmOcQkLKsEkJfMuWwKpWMLk4y32yYHcHXznG24ubNg29vWl/Y7fK14ly3018vKc2PfPNz4PM7gsdzukhl1AZAxHd0K0C/+mTjfU75+ACWL7MrR55J2TgGa4GtqxeFyYcs+Ws4WacpQxM4w4vLaNDi/r7CK0fhoLYRYRDkuZMcl1w+7qnrA3TrS1PzlksjSQ/z8713k/uAr3zL/c5V5rSn0aDaoZhb9N/NkRoGR0/2eNhgVFxPJbAA/145OBc/Ok2vropA7UlNQdupz2EfzBqCinEOmditbnB8QJdScjnz2CIvdbP+XCuy/lZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0pt+hOkxwqSiCbPzfi7fpRAjF5w3dB8Jtk2pmqMYv0=;
 b=C4r2z8ln9Ntp8vxw+K0RyxOoLeyGEFSMQAHCchWED2uGWbN8xqMJB1M6EbP398sA40NXdvNIHgH9cW5Srp1CoO0Wb6xGH0BmiNgnAW4gLfw4Op31ErjIw0TmgkT8K2ZGWA2ch63LTNP3H7cj+oR1I+zydbtUUOT0KYdF+pjePpU=
Received: from SA0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:130::15)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 07:24:11 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::44) by SA0PR13CA0010.outlook.office365.com
 (2603:10b6:806:130::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Fri, 10
 Jul 2026 07:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:24:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:24:11 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via
 Frontend Transport; Fri, 10 Jul 2026 02:24:09 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <frederic.konrad@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Date: Fri, 10 Jul 2026 09:23:46 +0200
Message-ID: <20260710072348.3575-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9947a3cc-0b19-4157-93b2-08dede543d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|11063799006|56012099006|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: XnLgw7083c+/T3Ft9jp2oaB8of3aC9bQAPBq2nVVRxqIWonzB+WkxuoQt/m4wbb1aeXOLgdW1roP1HHZnBxOHjKwiMEmsN7BKlAUtK0rkRm8GuMJtiitsic8QA/ZGiqKDkFwAxZ3KtNwegHnh5AaS68us9Vim9rOqkKqWa/X42YpGE83ABwfnU1CXuuufiFxuXjAWdW+OKwZQdVkmJSO4qpzJMqrUvluHqB8cIaAF62U3PwbdCp+EF4C0bw8RTvtKMUDHRktMLtT7qpSyxUfonmgmLQjRAKWHMycoaJoOsUBBM5yq7u3Ce1PJfS4j402Z5JFwprsiruQ0Rtw/81WxVuieCjm9pEozI0spJr5wQPsgdaJYh1frDZ0nQe6UwHDpwyIhkxSWw0SQge0cyxKPfgtayKuqFl16GxrD0cX0wez9HxrWsIMzcQYzJEn++4tCAQw0VAj8GFlLwYdLFb2OX71ntgkt0gCsppOe5my6JPzNJWZCoRNw3eplU0OJ3T1ohgh9Usz1tqIQzpD7EzhvuHGhzNqIeRx5Nh+CFsTP4mI+vQ/RE25lUvYhXJ2t9aI/l288dDy2udCItJuRpaH3+X9QFztTy76VeP42itxdyJr1ptqTaFAHCVi44X+7rImm0K9XFdIOjvM2Y6nG1IqGyYb53fteBLw8fP+8cSC9XPM0W9DZbNZhHNwDmQKkyvH9RNDSO3RXHI+JdlNMrrU+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QM6HFqIrbpO0BYtVjWOI7fhGypwfzdHPz8mWx4ERIdLiTpsrSYxGwlX59kqdEeBZYO/8+4hBuGMkfymG8JVhLbne4rEQtBM4WIqWYeKvltranIAXgaSuoLsVZsTS7uxI9Cv7IRiqy8akFCVLbm4n0LRmXzX7RKTCNRE+Z5bJig9MUYq3Y/XKBsgAV8D7QxsGB45/RN2vvEJbMA+s7oHrCgb5XUrdKCmpIYPBLfT1hBLIJbWjr8Wxr5Bdbubz6e+8T9bT+5+ECQbhu9GY2nODE1QvQDYWNK8LOLP4tUz/9T6IXqYSEYFwCp5iKgwVf0J6JuSKq3h1qMjMkjdqEmkAX+DSSKL5TQndK3JI34kzhQTuC3SyzcRMy1s2mrACCWXO/7u345Gg2fhIxtgY9QIr8dUrluwBVc89xixiKBEGg6c4BzCh77MR2a1ViKFlD7ZD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:24:11.5439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9947a3cc-0b19-4157-93b2-08dede543d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
Received-SPF: permerror client-ip=52.101.52.59;
 envelope-from=Luc.Michel@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
the address can be a target register or a constant. However
do_{load,store} might modify it in the case of a reversed load/store.

Fix this by factoring out the reversed access logic and copying the
address in a new TCGv_i32 if it needs to be modified.

Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..9fb84e1bf9f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -701,30 +701,47 @@ static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
 static inline MemOp mo_endian(DisasContext *dc)
 {
     return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
+static void handle_reversed_access(MemOp *mop, TCGv_i32 *addr)
+{
+    MemOp size = *mop & MO_SIZE;
+
+    /*
+     * When doing reverse accesses we need to do two things.
+     *
+     * 1. Reverse the address wrt endianness.
+     * 2. Byteswap the data lanes on the way back into the CPU core.
+     *
+     * Use a new TCGv_i32 to modify the address because the current one might be
+     * a register or a constant.
+     */
+
+    if (size > MO_8) {
+        *mop ^= MO_BSWAP;
+    }
+
+    if (size < MO_32) {
+        TCGv_i32 new_addr = tcg_temp_new_i32();
+
+        tcg_gen_xori_i32(new_addr, *addr, 3 - size);
+        *addr = new_addr;
+    }
+}
+
 static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                     int mem_index, bool rev)
 {
+#ifndef CONFIG_USER_ONLY
     MemOp size = mop & MO_SIZE;
+#endif
 
     mop |= mo_endian(dc);
 
-    /*
-     * When doing reverse accesses we need to do two things.
-     *
-     * 1. Reverse the address wrt endianness.
-     * 2. Byteswap the data lanes on the way back into the CPU core.
-     */
     if (rev) {
-        if (size > MO_8) {
-            mop ^= MO_BSWAP;
-        }
-        if (size < MO_32) {
-            tcg_gen_xori_i32(addr, addr, 3 - size);
-        }
+        handle_reversed_access(&mop, &addr);
     }
 
     /*
      * For system mode, enforce alignment if the cpu configuration
      * requires it.  For user-mode, the Linux kernel will have fixed up
@@ -864,27 +881,18 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 }
 
 static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                      int mem_index, bool rev)
 {
+#ifndef CONFIG_USER_ONLY
     MemOp size = mop & MO_SIZE;
+#endif
 
     mop |= mo_endian(dc);
 
-    /*
-     * When doing reverse accesses we need to do two things.
-     *
-     * 1. Reverse the address wrt endianness.
-     * 2. Byteswap the data lanes on the way back into the CPU core.
-     */
     if (rev) {
-        if (size > MO_8) {
-            mop ^= MO_BSWAP;
-        }
-        if (size < MO_32) {
-            tcg_gen_xori_i32(addr, addr, 3 - size);
-        }
+        handle_reversed_access(&mop, &addr);
     }
 
     /*
      * For system mode, enforce alignment if the cpu configuration
      * requires it.  For user-mode, the Linux kernel will have fixed up
-- 
2.53.0


