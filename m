Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E59C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrh6-0000jq-VE; Wed, 20 Mar 2024 04:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrh6-0000jZ-5U
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:08 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrh4-0001Ub-GG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ6cEHvME7YGx7bYkJeWp9uDOYd/FRldMgrb1Pk/BtO73PsWdh2Iged2j/+7CI1iLUuHEAsMbTkAMX/YIAt0rEd492azOrwevsA/d5TIgGF7kQALH0iiJ/T9Kbo1fxZzHKbv+pFv1p579K5DnlJSqDTfhfYlpynRyYE+lrululWu/gnPqYQaSWaxzgn9dhk/KpKejLFeoXH8dUOU3dBz+mjGkiXbRI4M/r7brsYdIsrobSxGBQUd67yefgSWKeJvmLK1o2zNagLQTAGpReMRVsZdzrNcxTBrzKfVxqniqgUasXoHcMyLTjr/CJdF4JoKMPl+Fxz9CqFysFxAGZ57RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXZ6Vcykvow/rJgShLM+EiS1n8t73FPvxJCq+B8NpqY=;
 b=cS62bmGVH+KxdayzDzRWhrymYNte2YgTVh+yuR2JprwEAWisROVoUBolj3gErBFXNf/NstROkvA2FYxP0mf39cuQBdu3ccUyiLQQoKQHP/u91P7hnDQVqxmtNfPjLujTvJVNEl60C1xEQRLeBieAH7XFXa071reBtqCrh36wvghDgNJTLpDh5YhhxEbKji0dbfU8OTaUWu8uxRgb9rx0Y5dv9JNsxeHtd76z8EzlOR4cZXnWyJiRg7tjWVvH/Rnkybhf2czLWuT6mOiSw7aogX3B/0/ow8K88a7vihLfphaqA6OwgDpf+EJIAzFP8Ce0XTTDGJqDzUSRhwyaIrdrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXZ6Vcykvow/rJgShLM+EiS1n8t73FPvxJCq+B8NpqY=;
 b=UJnbGJl6xvJn43o5tU+BPI9oAdkM0Oc9sHXab0n/M4n42HlRrbdepTGQDOnLoIkt6Rzfu/bwexPbRu4dVkd4GRKsdvHVJx8aDXISB6kamdmZS69ze+t5IsY7P0226Bf+8Il9PhXddUgacqOeeJ9Agq9XgZypgcbHV+dQkiMDZJU=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:53:03 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::15) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:53:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:53:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v3 40/49] hw/i386/sev: Add function to get SEV metadata from
 OVMF header
Date: Wed, 20 Mar 2024 03:39:36 -0500
Message-ID: <20240320083945.991426-41-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f738c6a-27d5-4b54-234c-08dc48bb2753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ybF6KMqkplJlSZF9pvUfyMEK64ijM8mGTDyMnRKkckrS/xc6jc5MJ4e+iDHU4h65XMAlej9NciI6ZMwW+TAAzEXvFVvzXJLJZw0OgpXnONxEDnmzmtsjLpLfYOLbLrhRcqgc3MVK52pveBIdBnsCi/1bzRjzpbRXOZ5i+BnzDyGRoKX7o0/aATnM1px4XY0DGms1fe0AVAqzIT8O8XWsH+oficjHeFQPm4xxhdIXCDl4HFNwif7v+JYhwxXG0Jky+gnVAj4qsuEP7lMVxBAd4rygNj/70sLeIe+FVoMEVz714VFzSRlW6TShGeRYgmwLunEKd2myzx66biOt7nKGyUxvV49H3kwhR1H4b7f4la5LWTL6wPemwqYbA+i9MQs7nsQ/WzrAu+takHOWv9N2juG+4z5ff6golcn05wjWjyECIMVv2HqSnV1jofZI7A+0+5dYCe5E1YlGNPMODNd/Sbj7Vpeq6fEeTyU7nuhOdwoe9sZqsSCRN+IoGwMjXYv706EDn/3mgo0aAjemtji19SwphhScMKRO7mTBRrZnmW9H3QaDfcnulnoiQW1KzKFMm8TwgjaHKt70mqpTU1RR3fwJI491F/5vVAOVYOxmcXg+Ynz0Y95dhtV/NTxJEnQmBudKdyiHo1c/m/vK0yiXhl1wMQkuEyyAD5mcvHPn8UNrS5hDEx/ghao6x9jxJ8LkAFjpg+grPTQF2SJdEIv9xszYovpdgmwqfti/LbVEhBOngx3Zd0fYFLMSr/sE4jZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:53:03.5143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f738c6a-27d5-4b54-234c-08dc48bb2753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Brijesh Singh <brijesh.singh@amd.com>

A recent version of OVMF expanded the reset vector GUID list to add
SEV-specific metadata GUID. The SEV metadata describes the reserved
memory regions such as the secrets and CPUID page used during the SEV-SNP
guest launch.

The pc_system_get_ovmf_sev_metadata_ptr() is used to retieve the SEV
metadata pointer from the OVMF GUID list.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/pc_sysfw_ovmf.c | 33 +++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h    | 26 ++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..32efa34614 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -35,6 +35,31 @@ static const int bytes_after_table_footer = 32;
 static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
+static OvmfSevMetadata *ovmf_sev_metadata_table;
+
+#define OVMF_SEV_META_DATA_GUID "dc886566-984a-4798-A75e-5585a7bf67cc"
+typedef struct __attribute__((__packed__)) OvmfSevMetadataOffset {
+    uint32_t offset;
+} OvmfSevMetadataOffset;
+
+static void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
+{
+    OvmfSevMetadata     *metadata;
+    OvmfSevMetadataOffset  *data;
+
+    if (!pc_system_ovmf_table_find(OVMF_SEV_META_DATA_GUID, (uint8_t **)&data,
+                                   NULL)) {
+        return;
+    }
+
+    metadata = (OvmfSevMetadata *)(flash_ptr + flash_size - data->offset);
+    if (memcmp(metadata->signature, "ASEV", 4) != 0) {
+        return;
+    }
+
+    ovmf_sev_metadata_table = g_malloc(metadata->len);
+    memcpy(ovmf_sev_metadata_table, metadata, metadata->len);
+}
 
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
@@ -90,6 +115,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
      */
     memcpy(ovmf_table, ptr - tot_len, tot_len);
     ovmf_table += tot_len;
+
+    /* Copy the SEV metadata table (if exist) */
+    pc_system_parse_sev_metadata(flash_ptr, flash_size);
 }
 
 /**
@@ -159,3 +187,8 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
     }
     return false;
 }
+
+OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void)
+{
+    return ovmf_sev_metadata_table;
+}
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fb1d4106e5..df9a61540d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -163,6 +163,32 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
 #define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
 
+typedef enum {
+    SEV_DESC_TYPE_UNDEF,
+    /* The section contains the region that must be validated by the VMM. */
+    SEV_DESC_TYPE_SNP_SEC_MEM,
+    /* The section contains the SNP secrets page */
+    SEV_DESC_TYPE_SNP_SECRETS,
+    /* The section contains address that can be used as a CPUID page */
+    SEV_DESC_TYPE_CPUID,
+
+} ovmf_sev_metadata_desc_type;
+
+typedef struct __attribute__((__packed__)) OvmfSevMetadataDesc {
+    uint32_t base;
+    uint32_t len;
+    ovmf_sev_metadata_desc_type type;
+} OvmfSevMetadataDesc;
+
+typedef struct __attribute__((__packed__)) OvmfSevMetadata {
+    uint8_t signature[4];
+    uint32_t len;
+    uint32_t version;
+    uint32_t num_desc;
+    OvmfSevMetadataDesc descs[];
+} OvmfSevMetadata;
+
+OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void);
 
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space);
-- 
2.25.1


