Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A107CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERz3-0005oT-U4; Wed, 07 Oct 2026 09:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERx7-0005a5-Vv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:45:07 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERx2-0003cI-ID
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbIzayLPKxhwYpaT+AuBMpFdF6w0RzxPe2e40YMTFHf+hZBajA8XcVZQTGo+6LxJ36LX+e8jyobqUJ7LUqtsBAI+CT9PYu698eqVmlNaEea/xz+qlXncF/HmDCOsIJUTrc9Ed4wJZT8jbVmikHn8IF8/god8zqW9uO4/l4Lfq+HWtOLiYhG9XoPnnl8+4bXX1ImpxXt6hes+I2mhvfMKmqStBtq8UvTKU1hLXWYSnhllSFq2PGSULylKAhdAXAY150SnyRw2JztpaW9J/+A1XYXbmIZh64/h3IM0tRvJeetrbBCAUlhX+4cdHmNG4phFMZKBy8mg8YtsVOSGCvykOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfaxWhJESjdAaPl6lor0aGqn0le6Iz1fBpsD6EIZ9hQ=;
 b=qHLHn/I4C3Y3rku6rCcxyI+jtBtTGGEF1ovZrysC1oTyknTWdpPwDnTJwk5Y774eEx3BAraxZy0SkDtGCPMxnEn1dOWMpexZPcc4KQauLrrUKy7cNoyHD47KY+mGF+R7NsppA+VdDgQ8S0bn0XinB1QDt7cN0ywyOSNkVUoarlxTiKI4p1HGqiEzxA712syLN3ZTFMT/mKLkegIhId8AY/rZExJrlyfclzCoDvu3kjSHdh7jDdxM//8btn1dmrlECR52YMh+W0ub6TUB8Ql55h4tVbKvZ9uWZDGo8VMKrEz4N9m/juSImy0VQBxGydTgDSdph2pABY4459lcfGF4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfaxWhJESjdAaPl6lor0aGqn0le6Iz1fBpsD6EIZ9hQ=;
 b=0JKLhG+BWI7e1eoGp5ubRBVOdOesg+9HcYmK/VCkoGMcTBu9Zm0We7FATCtVXQCAZ3dRUoIkRbx4tvZYgFg7ptwA8jeFloi87FyXEh2ags1/buy8kOEWearoNmKz6KlpPbZysw2YdWc4RLe6RznLhD7egK2BwMNTfA0AcHeQ0cE=
Received: from YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::25)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:44:49 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:b01:83:cafe::2b) by YT3PR01CA0138.outlook.office365.com
 (2603:10b6:b01:83::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:44:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:44:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:44:47 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 11/19] accel/kvm: Move post-conversion updates to a
 separate helper
Date: Wed, 7 Oct 2026 08:41:35 -0500
Message-ID: <20261007134323.1606088-12-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0fe0c2-f9ed-4049-0ded-08df247927dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: cZvD+V5vvZihfYLf/IfBwhhgs0FrlieVoPml1FcaISUDrIgVS/4C8LRL1QvzG6Jo3jl1mkJ4yiEaOT4rq2Yhnxix+6iiyq98XD9UZ8rd/urbpBw5EX74/LT5QH4UmUtuT7vaxA6nyaXbM5505MF6564NUYlaXUWxGrZCbVdBCjQDZdRQnH66SOk9CFy/wjivufHxzIw0zHXBqNBToGDnKHDi1t/+CNtMttYs3B2U7690QTEPJxc8NTV4LU6+28pCBe5n8GXVE1TEFSDLu2gQ7DQTNP6uU41RWVaaINWM3h2ir1N2e99cnnRD8E7viWBWIn6GoOu90zAkRNWNquI6JN9NKEym4k+YW4qD37e5S0ZgTgTRFARmJwHd7aMoJRpRsIQUK7rLQYlZd0ytJ+J/w2z47y60XuiylTDEqF5T3wjM8qYl3D9HnJxea8pJnsO9N5Pu0TM8RoKSyEw3Q7rI+NNFqS5ZXsnMlgWL9aWUlv6zA9zhhbG4MNbjDiHpBbnnN2eGe1u9mDCjhoPQ4IA1kyWprZj3oCVRiNz2JcJ+DkYP/l2jOUW+r8B/37tCepLU0LvVYo01V6xhJtOHkVWDdXnYgrk9yd17XQImnQV4oYmXGpacW91uXfA9I3AUvwtYbAYIOHC37iV/bhOuBO4PU7ikcDz0Pgg8WJXZQ5+cJYP/R9gHS2YgXSUhV0OY15XXgcJJduQG29MECWsCJDc3tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itIKb9MNJnWKpIq1Kh8uW2C73wuFjCU7ytdUnvNqOsrSdapl+m8mwBXvMgg7uY3mJ8Xwn8B21ufjahiwXWKYH545JQc8jPXTY//NNAo2MB1pqN/BD8w8DMhgWiu24uewAhLK3ZnGMdSufaHKuP0RQK6lSRc2miCblc6igPBceN00l/mQuoGZ7i4HAjPbYsge561KhNXWFnrZMo3qGMNKbIVVCciXT75HvieRu7wGHpUr280f8q4LGJkEf2YAZgjlj9855H/MmtLjgrvhJUzQb0z1xfk8A/r6k7LqKf8fvrs8AF70Al9lQyQJLbFHk2CAt5ckgLz5FKp4IoVNqgorTKhx8UbaEHpscMjPJhUj91QGAW9l5/Yomnpnqxl0rVFE43ir70ywb+HVCTBW9gJ1BTepuVDzLRJ7pGw5Q4bfq+0fo79ln1GEoLTXsQ1pxL0C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:44:48.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0fe0c2-f9ed-4049-0ded-08df247927dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently memory attribute conversions are followed up by other
bookkeeping tasks like discarding unused memory or issuing iommufd
notifications. Move these tasks to a separate post-conversions helper to
better compartmentalize and track these tasks, and in doing so lay the
groundwork for a pre-conversion helper which will be needed in the
future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8cd1671ad5..b824b803cb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3437,20 +3437,26 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
     hwaddr size = int128_get64(section->size);
-    MemoryRegion *mr = section->mr;
-    ram_addr_t offset;
-    RAMBlock *rb;
-    void *addr;
-    int ret = -EINVAL;
+    int ret;
 
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
-    if (ret) {
-        return ret;
-    }
+
+    return ret;
+}
+
+static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
+{
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    void *addr;
+    int ret;
 
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
@@ -3525,6 +3531,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         }
 
         ret = kvm_convert_section(&section, to_private);
+        if (ret) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_post_convert_section(&section, to_private);
         memory_region_unref(section.mr);
 
         if (ret) {
-- 
2.43.0


