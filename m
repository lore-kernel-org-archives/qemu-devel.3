Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDF8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribdm-000377-BD; Fri, 08 Mar 2024 09:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribdg-0002tJ-E9; Fri, 08 Mar 2024 09:56:01 -0500
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribdc-0005Ix-NC; Fri, 08 Mar 2024 09:55:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM7s9lSMG2srz2uypziyWiHMJuxiBXkGoGU4YkNz14DwVN5+ugR6rYup23z5msj57JdQ0V7fLLKZEfcD0KLXe2/L2nNoPcB0yqrIVRB7s0aQhlvsI33XvfbrMj2VNCWBLWgmQrbGa6pt+akDXafqtjz8CjHC3k/4fUnv31vm70U8bQtXw/eQ9rwK6mNECNT8he0PlQ4l9nGttGeVgdF0e4X1gzIWq9wahFiWSQ3UOSK9Mahha0WHaquql4IVdvUlhmZEeWLvT/2KI6n7N8MrHaJu2wIHT37jYyFUiRIXsm56jHp1KTDb5WAGe5uJLaIj2kGRB146ewB5qkYOtnKhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46TmEwnba3f9pvo72kaw4E9+tlqVVNLLm5gs8smzUmY=;
 b=g9kBwql1wvQXtzIM2D6nOLnWVn10Nn8St3SkaXhAAwfYZ0pCDvNFcCRA1ofidDQ6svoIDCSbt4TltJR7+UAe6sPFcfq3MMO82lXHVh378E/Y7v113VrzvfcvuhJN+Fs1Ly2TIR4qLfODEYF07cRcQc61xIrBDaLJelKmc03FT+l4ZFIxLeLSINPKtkwsnt6wUqvFF3xX/5/tQZOwXvFyTTrrtYloeCoYCtBh3sadvjH41gMHQbjbIH3VVSgdUhnNkLVEMQUY8vudW6pstSFjHiRi4fvvmr3oEUMg0ZFUDgoCPL7asZQdjJ30S1N87QLhj13Au14sfoLleTcNQUW9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46TmEwnba3f9pvo72kaw4E9+tlqVVNLLm5gs8smzUmY=;
 b=SzT7JpLTvUZyGncsbHaNDCqPrAhn/nYtSCouY1kKJy1Jn8OYoiPYIyoSfDYeuF+H9VOWjwN5U2Gy6UHECrvTzUUGIvNF9W+mMN0M/4YSUJJSmUHo6ojpkLW0cDDmtz5BTuC5QxVtYw+JzPKUKzxNACOFA9UDdNeo6ixkzl/TBHspKTRMWD1drfLM+JlGo6ro/2MR/oQdnuP3QY22HHzAb9AWpo+zIpAtS8W1D21ydF3Qbr5T/TirLoGkdVbAs+iwPFXWoP18Zfgp17ODam70I1g88W73H/iOK37bGXNQxr1wZiWd0P/emj/n1OoBA5JvF7IGcIfqMOc4HFe7u1F/0w==
Received: from SN1PR12CA0105.namprd12.prod.outlook.com (2603:10b6:802:21::40)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 14:55:49 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::8f) by SN1PR12CA0105.outlook.office365.com
 (2603:10b6:802:21::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 14:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 14:55:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 06:55:27 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 8 Mar 2024 06:55:26 -0800
Received: from host-10-63-191-31.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 8 Mar 2024 06:55:26 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, <wangyanan55@huawei.com>, <alex.williamson@redhat.com>,
 <pbonzini@redhat.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <mochs@nvidia.com>, <dnigam@nvidia.com>, <udhoke@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v9 3/3] hw/i386/acpi-build: Add support for SRAT Generic
 Initiator structures
Date: Fri, 8 Mar 2024 14:55:25 +0000
Message-ID: <20240308145525.10886-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308145525.10886-1-ankita@nvidia.com>
References: <20240308145525.10886-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: adbf5c4d-7c14-48fe-05f9-08dc3f7fd7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErDLEGwXvoyqnPpb0J+b382RG06j9bQ7AaHVMYGKYu87vAsXxQP9jOrYlqECd2VwK8pP86sqAM+bhWmUrrDuJOSEzbpJ45deH8M0MvPAA4mCgOJD+2uvxvKGu0L7xBfMQcOEKptIO6wlmLLgQ93c777hkodNaD/+Jae5UhXepnZ4c44XAL74sbOiWNi62aEP7nvSuDmzk33RHJmWgst7yLzO2iXqRN0epBMK/O1NkSQc+re7w733zKAZW8Q9+ro1ie0oITh9QnQRcsGsOyglHdy/TEQlDuWB1WjgcWDCRnaoQ5A+7R3SQddXD0ZDGr2SfZ5SS1gkAN582o1H/UikKvLnrB16JLQQB04VT3JVrgM9yPK0OYVb6Dxo7aFsBdsJDf267NQJMA0HPFW4qt/sPetSmBm10D4Vu2Soj6bnLQGk9fAyunnHkMvzKhu+SDuJ+zAj+PnMq5h0g4XyMJhWSdz4pKF0hpwL2vj7PWgu0nZjy5GALyS/jA4skTkPkWHG68lj1acYFj8ffxGYzANpigK7h3v+LwYyyrgbDxDop3x2IXyDB3pTQ2zf9FkGn06GKTxBfqDrq8dA6wxY0EG0ci+QRmF/kqj7NHbTjeTgcDrW31UCwCPH+XTdJIoB0jVjXzDsO7Zz3uqTyp4p8m19dJKo6BHEWApzMWkJ1NYXjJ6u1YMxetJR2o1z7t+ofbNoFwUwb4FM2P+BmEJOHaTdFunJV/r0Jf5ZtMiXOVtvPCsXQ4lhZGoNWmy3p6dscVLZPy0O9u7d/QYol3AvOmRT4Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014)(7416005)(921011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:55:49.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf5c4d-7c14-48fe-05f9-08dc3f7fd7f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
Received-SPF: softfail client-ip=2a01:111:f403:2409::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

From: Ankit Agrawal <ankita@nvidia.com>

The acpi-generic-initiator object is added to allow a host device
to be linked with a NUMA node. Qemu use it to build the SRAT
Generic Initiator Affinity structure [1]. Add support for i386.

[1] ACPI Spec 6.3, Section 5.2.16.6

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/i386/acpi-build.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1e178341de..b65202fc07 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,6 +68,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/acpi_generic_initiator.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -2056,6 +2057,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
     }
 
+    build_srat_generic_pci_initiator(table_data);
+
     /*
      * Entry is required for Windows to enable memory hotplug in OS
      * and for Linux to enable SWIOTLB when booted with less than
-- 
2.34.1


