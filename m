Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304BAC44500
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaZa-00038a-JI; Tue, 30 Jun 2026 11:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaXo-0002lw-OM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:38:41 -0400
Received: from mail-westus2azon11010048.outbound.protection.outlook.com
 ([52.101.46.48] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaXn-0000i0-2e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHX80Qryysw6Cvds0mDQD4SOM5Kx3Jyf1AQ4hFoWyBxHiVzDrsbqA1Xb5ekd3pyF1qbo2nJQEhi8yOlLwUlnGfV8b7dM+73h/R/BWkkZdF9VLE9qJ183a0ZRQOle2XsCFsDaeJGEKWTzpkreodeVg9KF02RzEnJ7ZWdK3YVgDHM1DZZ/S2Pi2YtRDbKhTCyK6n4VvBFhio9RUT1vw2028LFjKyqx0FiEMaWq+ohtcxSnX33LeS9k9ikKV0Z7mzdaJ7MgWiwj+RN4WBBftScoGx8NJWXEH6nVyKidwrcHMlpxVqkifvAg3WYvL7UoAl//EQsjBQs0gCD1UgwWW6D48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlJPurNiT03X/ZFF+E2JHiWHNP31DI+HPx9nIM6XRIw=;
 b=sva7Lwn7DFmogIb+3RIlx1/vKP98M61mEwvzHgR3qs2eY8Q03h1TnvdOlF3M2lU7DBKdMgTQ0oYka+atzSMJfLgJVwGMkc/M3ON2Z9KZXCbH+YGef0rL+olHE2qdh+d988j6V1VOfYSu9IHaS4ULIfvbYXcS2NS7TIce5obS1l9zmhln2iEo9/Auoa5UfU+I2DtBuFNw55vzcLe0Ne64q6p3QD21b7Sf4TQ+0icfyUtvEJ0T9jEyEWO55d723sTla6ZzB9nMZPpa7PZKwCCOyI3WUYztnfnoTN9S2AW0cp/7UXVndZBHEwje1VOCYlo6fvNY7wYw+dyyov2Bb6pqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlJPurNiT03X/ZFF+E2JHiWHNP31DI+HPx9nIM6XRIw=;
 b=x09QGYdviKNYY3yc2MYSDz+IMes8KaFFM/MueuvWPowvL5dNWIdBr7FnUg5yb5WLsXXld1+jUBtG49K73EyqbUOc3XeH7FKFOQuHlwjl8rfIPbkKxOr5Ny1KsPReJIiH1PxMak9kGAKps4YiJIW80+nwg1SS26kIv6zdOw8/rFM=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:33:32 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::5c) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 15:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:33:32 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 10:33:31 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 2/4] target/i386: Update RAPSIZE definition
Date: Tue, 30 Jun 2026 10:33:13 -0500
Message-ID: <20260630153315.1585-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: eb35dda5-77f8-41df-70d4-08ded6bcf16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P9fUILdBEnn2ChV+7keGJzjYmEjm26uI59ETweIRPeqjDufOQ8BJbbIPdrIOTKxJaJcn1PTS0lRPqYb5tVSWICUCqeegUk8EUBhR73IaSVviHm4Ebob8qX1d3JEO8MEj6HcfJF1djJO3ftJ+k/dAlIaPcRHZvSR+PG9NEpEyeA2sKX4+Ah8ta3tsEtxheBEks+Mkz5PfwlxmnpUeIi/KcBhTAaOmH8ss9Oh5mf013nmSH7RP45EOklnC2gfQdtBW3gxhCFWwC36fJ8xkfT8SWUa9B5idaPjKS2zjpsW7YyVn0fsFDJkN8FTjsD6yQ1mSlQsITupzYPg5gSU+iV/Gtf0PgVq6euuY8MET018Eyb8DIY9wo9ZOFVKG0GyV9gh/Q6tKAxWq39UR6d1No0dcYKWa1DAl9FTW7hWsU5Ci/QpRZkLB8VKpkcAJK3dLlT1PNxgn1+yRKLTT/ZISWzFdpZXHBjL3p93rFvCzksbuLTxGpM3Rcs7Z25dHhbM09Pb0accsDWcmAN43PZQJDP/OAis7iur6GyNdB9FPCEmJfluZR2cLbr9rjtFzRdA/SeibCM/S7tkZ/qKl/z8PmZdzEW54ot0IR5iMFqC0KgIdtXv7PqqwjOv17QIOU75CzCwq/xFSUo+xbnjVNlpnGwXdyjbERNg9gbntN0IIpbLgFceh5FH88dF6bGQDU80CGWQDnKLy5xO0CIL/qZ5Pk/7W3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1ygwOVDsuiyOwp0Fr4XaSknZPYnTuT2k7rqQOQHznxwQDKNpc3ZudTfPkxfmaO5pNu0O6d2qHkUQ8PDygyCfdbvktEas/GRt8RafMC6K+ximWmsNHoP/Yf8o4tR2ED6dXR6KV492hshOXUbiTQFDiE3XiqjqbgijImRyh3nr4HwLc5+FeBi270DpVCi0xAScu3zrNbB8fCTKdYbFe2vXQugZpWItDqldQAhPSDugk1IqgnQUFIJsUP6Zsl2y6t/Do1vzcPLuEG+xioh24JgduJpIEJvbtj+YpKC06Vpp2XF2R5eoHC5AImvZNUSIrh923BZ+TiQ1K+mWjeZbKf8oq+C1OzlAPWg8HgPdWIM4EEwmwiPuacfgTdYgHOV0G3m7kRUDYyUSJ/2dME25pvoH468KbfyLDLKp6ZsQoSVqadOkOiiFzMuhus2bPUOgXkNw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:33:32.5123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb35dda5-77f8-41df-70d4-08ded6bcf16a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Received-SPF: permerror client-ip=52.101.46.48;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:40:29 -0400
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

The RAPSIZE definition originally introduced in 9c07a7af5da:
"target/i386: Expose new feature bits in..." hard-coded the value
of the field to 0x8. While this value works for current CPUs, the
value may change in the future. Update the definition to be a bit-mask
instead of a hard-coded value for future-proofing.

The field is currently unused, so no functional change is intended.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e66333cd9c24..ff63baa9dd23 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1214,10 +1214,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
 /*
- * Return Address Predictor size. RapSize x 8 is the minimum number of
- * CALL instructions software needs to execute to flush the RAP.
+ * Return Address Predictor size. RapSize x Y is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP, where
+ * Y is the value of CPUID_8000_0021.EBX[23:16].
  */
-#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+#define CPUID_8000_0021_EBX_RAPSIZE    (0x00FF0000U)
 
 /* CPU is not vulnerable TSA SA-SQ attack */
 #define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
-- 
2.53.0


