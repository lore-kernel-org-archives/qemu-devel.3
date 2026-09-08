Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F57BC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42rG-00045l-7A; Tue, 08 Sep 2026 16:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42rD-0003xC-Hy
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:55:55 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42rA-0007OZ-SP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:55:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh8tFuVIfVEFZFzz1SLLrgc5+Z+PZZjEcKw3OMbqvCi7vTM/ToofbxwHV9lEw1MSJgaiEGFXasoNwXwKmN66iN5ZLl/OJ3unV5qEz7bQ5GMQXlARnD4eSw/Yc3kqBuehS3ShTBofBi+LMpyXGoAtdgqY7ZuRLmapY/oGdM+OLRTZzoHdFdGuh0er8ABxbNPbNHdoDx5SAIwxWCdXBORObUpmQrSmOYQTjISuUpYncyt7Y2aa79v9UU/05fYlIGnO0Pp1MpW0lfDxN0wuOip6f/DGlk6bCw3mWRSlHmnPq++WJtelTKhz0cOgtzutAW83u3eMz/g7/+ftDs9kvro7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3A94Q2cOVtDXlvyMPEwL0+A6/A4i347HHYt0pOPsUE=;
 b=Y1SSW6gRM63NfuLfQ60a6nuZwY8t/YzuEsrBt4lJg8Ci9G/DWv1X6qRDfJitlx8nSHrw02+/w9Gbd8+7GBtAqMfGnjlazpVKzGpy0CShzdVSdvdWLxL4Hiip1Z5tQo8GLJ4OysapARMqMGjSf5ECxx/rToLyPeNl3A3ox7jC9IHl57ip3kBWHGJSeDFJHDBp3mZahdoKwzLJoYEg2L6r6wh4Pi8QZSJyYn9nkTKR0JWORULyw3JkqBART2iIm+zrvqmto45ryq+ytOLQ57agNVw+TV41MS5FY9pStY73pVBn0JIoEjMtpCzjXCuWSlPnZsjmSgL/AvtHDjS9NxNiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3A94Q2cOVtDXlvyMPEwL0+A6/A4i347HHYt0pOPsUE=;
 b=QA96osfkS0oCFxj6jkTHbRd8DoI4FTqW7pGVGV95m3/HMg8DCYMI58Q7SY901KX9cI/kYVXUTapJsJWzMoafTXICvPAt/yOwVlzbabOytDWhe4G532+qc1ELEhhDM5M5CtxFz/H8UXzphCRu9mVuCaki8nRErIKH57fN7YIlXQ0=
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 20:55:45 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::6b) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:55:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:55:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 15/19] i386/sev: Update SNP_LAUNCH_UPDATE for in-place
 conversion
Date: Tue, 8 Sep 2026 15:48:35 -0500
Message-ID: <20260908205236.838281-16-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea27d78-2d2f-4268-97a9-08df0deb8d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ry+T8umK1UqygZ/xUmyKHlLrfGbauwEHNokN+McvLyJzytgI0dwlUSHbx9jQDEk++bvCKkpBqHSYRdauNvpo21VLoQir6Mb/xJ5kQ9U7wgc56vVnVL/OaHSgPqD5hjJYoX/IPb8MB2XxEqKZLnOy6NKD3RiG5K7CJ4/hGvm0yWEowJyBJgyf6essfLe0BsgX4UEVN/H/peT3yXi0J/nAQF5Z2rwiQ4wTdMzawap4PXCP5pkFjs/VJHAu4HlTdV5kKRv469Ktx7u0u8pVpd1ARl2cOt/93w9mWVRA7Oe1zfjLE+VAKenLhdE/v6+gISLaXkaJsU8iapeOSDFjy8wOFedVcK3Td7uUM4GzQ2p2fwh+6KGexVjCJtpvoIUKYidezoUAOSlJ2/n3yeykvRGPlyZ3YUyy1nkEgXmjgmpnts9QJ5yc8vqBtjufqSenhCi8MYe8I++ZFx69zyN9zFDCSlOcsldPDfMEO8KpkcYDOvrNAkx6Mso9eA+L42bOoSn39Cmi8eyayYRb3CiAF1RdaphKHH6rQKnrlf3wssjnW7HVb6u4Xc5ICE6x5WwLRVSMmxznFDCmABJ8nMH+hFAA00DKTtCaFP7It9kFCFGYBNYwj/z2IV4fiFjSh1fSrbkJSMJ+fBBUWtOYP9VAB+LAvGmZnVxsQ3PgSiJdPzKB+ZHO6WilJjMaAvoUPrROve8ONnkTIr9VEkkxH5/WF98EaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DuK1VEJS51FFoN6FqCngHvXM6SzbJ++8CPzbEch+47C9YKiGhbxh4255edPe8EqrNoJOfVCg4OT3zn9cvXyurvbQcP1/zO27C6tSU7LJ412sYWltYd1oHRIDtSFCiKUTw9djUOuzjjycHDlUKY/1VYJjSnFni17x4bB12+EgIsecEv8L2eNR6ZXsB76Ev/Mec9c1+Vze9G9IBpK3CCEUIX9mBmr81O5k5si13m+sw6NjydcOUYCIh9OmFuoA4HQUHrV5s1HpwYxs274ApTC6otH9dlE6P8sPrt1XNK9pj5aIj8455r/E3fDd8a1oq/qhj3Rz+dl+8tOPZ+WD0bL/day88GgTHwfRz0CdEr/FEYhYxUftN7M27IvnmADmW2gkR5su3MjbVdcqEfKG3uEFhMWDjMA5K+0z2yf6p8aMsl1rzqPAS6Rav9xxRs7x6/uA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:55:45.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea27d78-2d2f-4268-97a9-08df0deb8d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

For in-place conversion, the source pointer is expected to be NULL since
the data has already been written directly to guest memory and doesn't
need to be copied in prior to encrypting it in-place for initial guest
memory payload.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b071..87d88b7920 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1240,7 +1240,15 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
     }
 
-    update.uaddr = (__u64)(unsigned long)data->hva;
+    /*
+     * For in-place conversion, the source pointer is expected to be NULL
+     * since the data has already been written directly to guest memory
+     * and only needs to be encrypted in-place for secure access.
+     */
+    if (!machine_require_guest_memfd_convert_in_place(
+            MACHINE(qdev_get_machine()))) {
+        update.uaddr = (__u64)(unsigned long)data->hva;
+    }
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
     update.type = data->type;
-- 
2.43.0


