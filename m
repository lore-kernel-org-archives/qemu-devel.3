Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FC4CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESGC-0003uv-Ff; Wed, 07 Oct 2026 10:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERz3-0005x8-Ja
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:47:08 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERyz-0003v5-2u
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5I8TkPG/u862eaawmp+lPAi+C4LwfwnxMeCKeW1XaRIZWgdijf54wOo2GAJNeXuKU0LKJNFHWccj/kPr7DnIF87bqpb5NhOGDgOGYWyXiMGTfO/gqYGZtX3HQiC4c0mhn9UptroLQBKMkfPYYOuH4SN51KE8oBaUbvxR4JRZkdtJ2HP84ObXZMai25Fr74+eUkq6N80lI0DtWHF8jU6p6LHfkWAhG7PvB1SUdwFtDGEO3QhypTBl7/uSOsLTfgfti4simWC6bdZASPiXFzrWQSlKDeT2zbyCB7AfGhErsS2sAQyaXbRgD4+7mtnXcfw6pRJ4+ZpDJp7Sxl+5BHb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08W+qOfxSiVpnrkG3f4AOwAJyCz9pkXeSpWG+oYjHr4=;
 b=f9O+b0airs5IxpI/95B9EJ9sALdqPlX8PgW8ZBI2EelI478NSXHLXWB8RM9iiSBOjzFTVBIrv3BIlXy7L3CMkmgEZkQpXJ9C00nxSJIMqFtmNiYg/Vf1Xu5aqjbAZsB4/itQYf+Roc4fo7cBqyv8VReFEtVlbO1wfVydcP5cWco0lZdOY/3TTMFOfsWsdiCVfKpV9Cxcwft51XHu0/qMD6A+jPISK3ADfcfeVo6aiQv8Qj2kj83FYkFMUy4KOSqrkw/sxgJmbsihi4DYsNRf1oN+1QizHX8Yt0qrBufOe8qvpfYQa5quKTcr7q9U7Cy3N+Xuf7njfeXSTYq51VlJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08W+qOfxSiVpnrkG3f4AOwAJyCz9pkXeSpWG+oYjHr4=;
 b=ue2PGPuCmH5S/m+ilS6qDqCNuerKyF1qwRN4DcRGpHWQLJFZpDkcakVfZoJ2zSyzCvlvb9ljT4GrMDPGzDI9QnIA5VOOe7r0Yj0H45iLgIcWmdN3UWpF/FjP4ZZlFt2nvEskY58Y6s+Aqug9JAbsHAYkgKh7tF9F78daNapM4Xc=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:46:34 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::1a) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:46:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:46:33 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:46:31 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 16/19] i386/sev: Update CPUID failure handling for in-place
 conversion
Date: Wed, 7 Oct 2026 08:41:40 -0500
Message-ID: <20261007134323.1606088-17-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a508f-5efe-4f04-e016-08df2479666b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|7416014|36860700016|1800799024|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NjvSMUNr8d5L1Ubza2HX/h898BB/PtRqWRU4H+VlJroJZnAdoKCXjBEAMBShfSF5p5G6YeV0ezZG1zYAAQ8BVRMY1imCF68hot6WJ3wl6zup9wDvlTp2TLS1ZX3ISs2+OaVMb/HAeHY9msYJpkl6gLMSJtaGoQa/vJRI7g3q4J0iz6l3mJqEb10im3fSstSO717kFyl8sesJkOmH2/q3ksWOG+pja/otdAN2EmegO/720OfNeO4oK6dgAv0bA+m/T1tqLIwVtToNdGcUUMv9Jj5wvG4iCHDtW87CLno4eDuuC/FmlTRg2wjA3FznOFt2gjQBd6KZF8vJcBwkAD35l2r64CzcPeIL79JfFs/I/vdDr9TZktrQSB33AOrd8JggemzI43vTb78btXNSnc/9euQrlee8p1Uy/s0K6fZ/811KmNxXTvwbpt2TbF/PVnZvOd6+QmEdnBcXtDepFg5bPPkTUD0Fvi9caad5aDxKQERUqpt7PZny3YcrA9ZmZx8es6F6kqEaTvJ7HxVU7h83Bcudr3R4cLvAdkxWXrLq9HSgN5tT7t6YCyexyGg7qcyZE1NgYZ3Ia989Ci5PVXWMZT/cMyOAa8rYwFvZHhG9n2Hcjzv/J9G4b54VbuuQlhXid44NqfUh6qvfCbFkXfYwWtVifIXrJq/nvgC5XG4KWoHoaWSNt0qaRu7IvM08iRJC8HlVWMtv6o/oGIoxAuLfDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4sp4IICQQpHkfQOzo6binf6RTmsC7FkJGgU9vj6HDNnwBrcupIdfEoeACm+rnogmPFS/hBobG8EkCbYjQvYZTKl/r72qdHgYgdTl6gGUigH9pwMICTuP5ip18oEOJXUHPetr7KNW01+6Ek8iF8lemDevq7RniH8WMX5LNrApcdsk7Voe1Kh3xjoz38NPCpIu6cVNLTJA+jQiWDfExspmwWvA4y+xRqNIo52xOgHImMiFHMe+U2C9vPaE28uhsL+Pb435i5SG/N8Xvt1c7IFWPer/+hR/9erqm8rtKy9EW4S6yKsD/KqSdMPcnRh5N3UdNydpI62K7MhL14YaWKcVnt3izvo8of0TzWW6kYAZwdr/1jImZ/wN5iWX6o/ZS2hqKu/W1tR918TuC9nWoA2aw5NlxOdE9dLOWMomMz9fAnkeAVhFkjkU6Q+r4F/5Ioqc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:46:33.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a508f-5efe-4f04-e016-08df2479666b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When SNP_LAUNCH_UPDATE fails to update the CPUID page, the CPUID page
data passed in will be re-written with metadata about what CPUID fields
didn't match with what trusted firmware expected. In the case of
in-place conversion, this will have been the same page that was
initially passed to SNP_LAUNCH_UPDATE, and so it will have been put in
a private state prior to making the call.

Make sure to switch it back to shared before accessing it for
error-reporting, otherwise this path will generate a bus error.

While here, sneak in a typo fixup for the error message that gets
printed immediately afterward.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b28a31b7bf..e15e23c78d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1278,8 +1278,14 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
                          ret, fw_error, fw_error_to_str(fw_error));
 
             if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+                if (convert_in_place &&
+                    kvm_set_memory_attributes_shared(data->gpa, data->len)) {
+                    error_report("SEV-SNP: unable to access CPUID page to "
+                                 "check failure reasons");
+                    goto out;
+                }
                 sev_snp_cpuid_report_mismatches(&snp_cpuid_info, data->hva);
-                error_report("SEV-SNP: failed update CPUID page");
+                error_report("SEV-SNP: failed to update CPUID page");
             }
             break;
         }
-- 
2.43.0


