Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4ABC61DBE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBc-0005lK-A1; Wed, 26 Aug 2026 20:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBZ-0005kY-Vd; Wed, 26 Aug 2026 20:41:41 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBY-0004l8-0F; Wed, 26 Aug 2026 20:41:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tugy6rkIBx56twdIwhKgHNxdINgmTYnz+XBusHZluHu2V+8iYrRDuD6FgKBNVzCOO2QsrniDw1KTlwmFMpcn3WLaGn+9vUtxW08yF/+qFgDF6nqWVM1sdIpBHBFYVGfowwY728k1BnbczzIbAtpKpsEBawINic0bV6Nt0dKzW7d7ZkVkJfepfS2Yoc+gLaewMHpdCPTN/wMQl+PuR7wifQ4gEeFfrMDyEJQdnel6Tro7jrZ0+GRY84LriFdO3VTjp2dNyVn6tfWJ+a1MdPRWyMYTucVz18gBrcWK8xoSaJILk7b3Ec613c718fVJfRkdP6CYplb3dN1FvTfc/oPCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EHmHACdC5qlNgInt8mpiYyZ/TFo9T82qx5KeD10sto=;
 b=V0awsakcg5fRXE7e1UokA7EPKeG3O2dyimyGDzXUh1m7NSJReiLoi2dPdlQTVOzg0od42KA2pX53WSne+wMhp4L+NjIHi9GNbShvtuQddPiln7wqivST+uJnoHxoty2fXkP/OmwwZZcvJxiFJjUGjYrDSlovW3/9Y56SyxdTiQ6p+QWVs/HDZao+INV0nXyYy5bwzyc1jE5yVKAk6PXDvGk42qJzMVUMmKovcK1odI3h6bqzloYPF3lKDIJGzmax84uNBFqyuzq4Gh1Xyuk3+5bSuoqPV1JsBPxzX2bZe+3oAEyJ1eMr2bdGeeXc0fEKFDXy/J6DhV18j4qEN31LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EHmHACdC5qlNgInt8mpiYyZ/TFo9T82qx5KeD10sto=;
 b=eVfixnm315RIvHAF4oz+ctRNUhAj/yBM+gXCwi4GgSH/TcRj9IwcB29sOUUJojO0eiPwo0EPsFKMtnFf35N8cDPVpnNxNVb60WJzz0jSVLPYiJq+ia3nv7ndwiPiedp1d43ggy761SsYsE4VjKJs7a+RgXqb+GC4a1tL5osp1bp4LCt63UBfiywIGTIV2iBGbzCiWhdVFIS5IAbJvlxKmeh3QDaE0woLliqmOMwisF98+ijB7g9Ijl0hSRpStbEQ81ltCI58001UC+E3roNrm2xjZFJ+UJI7lU/w7hrp7iJKMJXjK9WAW1JmKqvJendZ5XkQEZ2biz3eOa3SUgkMSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 00:41:28 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:41:28 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 2/5] pci: add validation for fixed BAR configuration
Date: Wed, 26 Aug 2026 19:40:21 -0500
Message-Id: <20260827004024.598351-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004024.598351-1-tdave@nvidia.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cf83b4-072e-452c-bc34-08df03d3ee49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: VTi1GI8vBezHQk2fCpzqu2lrRz99hnRwyOETKQI3thmGCEp8kOOcoYOEg8OIkJoyAouJGUiJuAzE+WPO0xyvAjvp2LqGJxJsXM8He1fIc2OzlHWEsyAsYMpLEe7RPpvoc4FT9mQYqHh5Oyf7wCJJGaFQrUCsUv7NLyIljYY1RvOt3kswg7Xdc4oMgsaW+zQW+MlGURrjvtkLudDPaN7lYUIzBA8IzmO2CMmAs44aUXDtQHvTq09XbXQd1uyokw27nH+RfGLKfrZr0FU+JO97xS1loDbfrR8OnLMk9P/HGvvXpHat1++KvqNNuEyCF5g+n7Floo9VkTwtqhkErzPAx190H3DvAN3OvrxFJyL86VlEsArqEuRSbPnxzxDPijVRbnNsEZUrr8HXgGEn/wXlOc8D4nrQli9r1rnL4PtnrMmRyRNkYoy0IePbAeHURvnyXy8EjWIvUVR/x7RZDJ8EsK4yhNZC5MXi3Zjw9Eqk/2GJUlhUW6YDDO9VcifpvO53eoUzYQmnez/1OQALHZWKR4L/QENIQ2ZJl3Y0NpzqylMHjEpI08vmlPTWR7J+pZjE0bUliErfzb5ek5ij3/nGzwaQKIJs5fleLLC7Nifk4I8ji6y1EuXAVQJnNq9oMEGexNn4AvlsNVKlJioql2Vx6eiGJgekOseeEdofWy9Nf9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThQSnhXT0RxQXdNcmFHR1VYNFBuZDJSU29vK0p0SzlIK2V1NTRJVnZUSzJR?=
 =?utf-8?B?THdKSmQ0TndNS3BHM0xQZDdxcy9PVlJhT0x2RHB3NGt0S01JbDRlRjJ3V25Y?=
 =?utf-8?B?d3JBblJZWHdCcEx3TENRZng3bklvNTViZlVNUHBkam5xdGRhNjVBNmlpY3Zn?=
 =?utf-8?B?NVhwQnAyVkw5R21WRllyY1cyNmZaVElPMVJITzZYTjErR0FKeWNRZk5oeTU1?=
 =?utf-8?B?OVN0Myt2cHgxeHZYVFVqZlJaSlVGRThSY1VpS0Y5TTVpYWhYb0VNR3lKR3Zt?=
 =?utf-8?B?cHZOT1JtUG56TlZDY3IrbGpyaTgrekhpbHY3ZGhKaTNoOVlLUFlHVC9Ta29O?=
 =?utf-8?B?YWoxWFpoTUlnZlRjdWh5OVVRbFV3N1NRcUlTZXY5MEFkRVI3Z2I5alRIRS9h?=
 =?utf-8?B?L3ZuOU9SMXJPSWtXeFZoZEJTT0tINFZaaGduOFY0YnlkbG0zRzlCUjRDZTc2?=
 =?utf-8?B?ZzUrNUhSazlRVVYvUkRwdWduWlBYQkFCdHM1OFJ4bVhWTE9XVzV4VXpzeFU0?=
 =?utf-8?B?c3FtRTU5SDJXTm4yT3MwUkhmeFlvd2FIcHEzT1RTTmY3S2RmeGVBVW5hN1dr?=
 =?utf-8?B?NVBpMjNHNHFpWmVGYm5zcVhoTkFYM2NOVXUzYjBQVEprdmVBVmlWQmMvSWU5?=
 =?utf-8?B?UXNFZG5nUG05czRpMFkyaVI2TWxLWnlqY3laa3lEd08xUXJrTkw1Wm5sUHd0?=
 =?utf-8?B?b292T2k4a21BNlVwSlc2aXlxZk1DejV6b3JlazhiUDUxYy8vaklma1Znbytu?=
 =?utf-8?B?Q0VYMVhtN0toc1RvZStmTjd3dmNEYmFlSE5uRHF3UmUrS2VWdFovT3dPVjZK?=
 =?utf-8?B?cUJ0UVRycFlxY2dxVk8xSTd6MUpVVTV2UThOU0dmcG5xTzdEQUNTUS8zN0pY?=
 =?utf-8?B?eWEvOVNkWktjakh3SDRXbHRhaTdmS1NzOG9SWm5jQ0w1Q0JnUmFYeE8vTlJM?=
 =?utf-8?B?OTJWdjZoVHFuRjA0c3FrdDNEbWVpeVZSaXRKWGdKeTRJd2RnM3Q4aFczWk9O?=
 =?utf-8?B?b1dLRXB5dVoxRi9jRng5NVdyNTNnZTh2aURFYm82MVNEVmJ0K2FFOXBVd2Zp?=
 =?utf-8?B?VlI1QmtIRGRkcHZDK0JTbEZYSVNLMThjSlhhNDBheEV5QUY4elpaeGZKdUVi?=
 =?utf-8?B?VkFKTDEwUG5yZk9Vc3FkTTN6ZEpzVmtEUjc1MUNLeXZrZGhTZS80ekZFK24z?=
 =?utf-8?B?dHN0ajlXZ1dFNkk1dFIrMVRkZUMvZlVQR0E5WHVXR3oxTHBNb3VNKzRBWnVG?=
 =?utf-8?B?bXFabVdCRk1WS0xSN3o3THZhMXFveU04RDdIcm16eW5oVHRtQ1VvTjBJbHBU?=
 =?utf-8?B?M2JlNWEya3M4cHFXUlhMc3NTL1JVMjRYK0lnaFV6SzRoMXJXSE9pdW1Pcncr?=
 =?utf-8?B?bndwQ2pZNmNjSmNRYW5KaW5HYVA2UThBamtodUZHVjMyRVhJUUNsUHJTWGlT?=
 =?utf-8?B?L3RPMkE0VEgvRGxIcGtLQW5uSjRKS0lNWFEyblRTcnlhd1VRemlENzZHSUFt?=
 =?utf-8?B?TjlTNllUWnlmRXptME5zTzAwbVlPeW0vTTRIemI0NkdPT0FuTi96UVZWUCtG?=
 =?utf-8?B?ZzAwTHBHZzE2ZGJsWWE0WWVyZFk3djNRYllUS0tYN2lTbEVTNWNxZDJ3RytB?=
 =?utf-8?B?NmNxRUY5L0V6ZGgxSy9QSThtdUJyQ3RidHdsNXpBallkemlwWEJmamtkaHpE?=
 =?utf-8?B?UUVYeExWL1J0aUtlT3BBd2k4Yk1Malo1K3FLYjdFYXpUUXUwMWo5U2lUV0kz?=
 =?utf-8?B?Njh3ZHhCcFlQNWc2TlRjak82dVJmekx6ZmErUk1ocTVYYTY1NnVxcGlCYWRX?=
 =?utf-8?B?b2Y1bmg2Uk50cXp0cTNUV1JGYzh0THRNV3E0ZjVsN3Uva1c4dzFVbURnRU4r?=
 =?utf-8?B?ekdTbFBvdWJOTEhUdmF6b2pDS2RPSTM0eFQ2b3BqcllwV0hrN1Vpb0JFa2Vq?=
 =?utf-8?B?VEgwMHBTQ0lSbHh0K0NyTk9WMHJYUElYUFhsWTBua1NSY2FHMmlZY2VoSWFK?=
 =?utf-8?B?WXBoRktVZWM5ODFxRUtZM1dPYmhCSEswZU11VEphdnZ6amZHd2p1b29iT2Za?=
 =?utf-8?B?MDBvaEtjRGdoZnQ0VlVIWm5aK1g5UG5jVWVwZVlwTmF5RnVicTJDeHFkUmZq?=
 =?utf-8?B?c3BnME51WVFsdDdpVEtZckgrNzEyTlM3KzQ1NFF5a0hZQkFDTWJReHl4R2U3?=
 =?utf-8?B?ZGlZRURyb1RPVHJJVitKQXFmZWxlaFVNU1ppM0RXUnBPT0wyUmt4RFRGZitG?=
 =?utf-8?B?enBtU1NmZUlxd1B1SGg1Q2lBMSs3NWZ3aWNkM3QvWGhPZVcwZk91ZW53OVIx?=
 =?utf-8?Q?nuO5mcSRTbvf+p/HWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf83b4-072e-452c-bc34-08df03d3ee49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:28.1976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdkofGRqxuYAE6YgI1+xCAg84gR71+Xx+xdKtWG6X1mdymqL5OP4mh/4wwJXMw91OtmDXbtY2IAx3iSGtyE8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Validate the fixed BAR configuration specified through the pci-bars
property on PCI devices and the fixed-bar property on PCIe root ports.

When fixed-bar=on is set on a root port, every device in its hierarchy
with a memory BAR must have pci-bars= specified.

For any device with pci-bars= specified, validate that every memory BAR
has an assigned address, and that each assigned address:

- is aligned to its BAR size;
- is within the appropriate PCIe MMIO aperture; and
- does not overlap any other fixed BAR.

Abort QEMU if any validation fails.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build              |   1 +
 hw/pci/pci-fixed-bar-validate.c | 279 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  21 +++
 3 files changed, 301 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index a6cbd89c0a..44b94a24b4 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -17,6 +17,7 @@ pci_ss.add(files(
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
new file mode 100644
index 0000000000..a8cce3d296
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.c
@@ -0,0 +1,279 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * BAR address validation for fixed-BAR placement.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/pci/pci_host.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "pci-internal.h"
+#include "pci-fixed-bar-validate.h"
+
+/*
+ * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
+ * across all fixed BARs system-wide.
+ */
+
+typedef struct {
+    uint64_t    start;
+    uint64_t    end;
+    const char *owner;  /* device name, for error messages */
+    int         bar;
+} FixedClaim;
+
+static GArray *fixed_claims;
+
+static void fixed_claims_init(void)
+{
+    if (fixed_claims) {
+        g_array_free(fixed_claims, true);
+    }
+    fixed_claims = g_array_new(false, true, sizeof(FixedClaim));
+}
+
+static void fixed_claims_free(void)
+{
+    g_array_free(fixed_claims, true);
+    fixed_claims = NULL;
+}
+
+static bool fixed_claims_overlap(uint64_t start, uint64_t end,
+                                 const char **owner_out, int *bar_out,
+                                 uint64_t *start_out, uint64_t *end_out)
+{
+    FixedClaim *c;
+    guint i;
+
+    for (i = 0; i < fixed_claims->len; i++) {
+        c = &g_array_index(fixed_claims, FixedClaim, i);
+        if (ranges_overlap(start, end - start + 1,
+                           c->start, c->end - c->start + 1)) {
+            *owner_out = c->owner;
+            *bar_out   = c->bar;
+            *start_out = c->start;
+            *end_out   = c->end;
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fixed_claims_add(uint64_t start, uint64_t end,
+                             const char *owner, int bar)
+{
+    FixedClaim cl;
+
+    cl.start = start;
+    cl.end   = end;
+    cl.owner = owner;
+    cl.bar   = bar;
+    g_array_append_val(fixed_claims, cl);
+}
+
+static bool validate_bars(PCIDevice *pdev, FixedBarsInfo *info,
+                          bool is_fixed_subtree)
+{
+    const char  *devname = DEVICE(pdev)->id ? DEVICE(pdev)->id : pdev->name;
+    const char  *overlap_owner;
+    const char  *wname;
+    bool         has_pci_bars = (pdev->fixed_bar_addrs != NULL);
+    bool         is_64bit;
+    uint64_t     addr, end, wbase, wlim, overlap_start, overlap_end;
+    PCIIORegion *r;
+    int          overlap_bar;
+    int          i;
+
+    if (is_fixed_subtree && !has_pci_bars) {
+        error_report("pci-bars: %s [%02x:%02x.%x] under fixed-bar root port "
+                     "has memory BARs but no pci-bars= specified",
+                     devname, pci_dev_bus_num(pdev),
+                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+        exit(1);
+    }
+
+    if (!has_pci_bars) {
+        return false;
+    }
+
+    /* Completeness: every memory BAR must have an address. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+        if (pdev->fixed_bar_addrs[i] == PCI_BAR_UNMAPPED) {
+            error_report("pci-bars: %s [%02x:%02x.%x] BAR%d "
+                         "missing from pci-bars=",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            exit(1);
+        }
+    }
+
+    /* Per-BAR checks: alignment, MMIO window, overlap. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+
+        is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+        addr     = (uint64_t)pdev->fixed_bar_addrs[i];
+
+        if (r->size - 1 > UINT64_MAX - addr) {
+            error_report("pci-bars: %s [%02x:%02x.%x] BAR%d "
+                         "addr=0x%"PRIx64" + size=0x%"PRIx64" overflows",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, r->size);
+            exit(1);
+        }
+        end = addr + r->size - 1;
+
+        /*
+         * wbase/wlim are both inclusive bounds (mmio*_limit = base+size-1,
+         * set by the caller alongside mmio*_base), matching end's own
+         * inclusive computation above.
+         */
+        if (is_64bit) {
+            wbase = info->mmio64_base;
+            wlim  = info->mmio64_limit;
+            wname = "64-bit MMIO";
+        } else {
+            wbase = info->mmio32_base;
+            wlim  = info->mmio32_limit;
+            wname = "32-bit MMIO";
+        }
+
+        if (addr & (r->size - 1)) {
+            error_report("pci-bars: %s [%02x:%02x.%x] BAR%d "
+                         "addr=0x%"PRIx64" not aligned to size=0x%"PRIx64,
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, r->size);
+            exit(1);
+        }
+
+        if (addr < wbase || end > wlim) {
+            error_report("pci-bars: %s [%02x:%02x.%x] BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"] outside %s window "
+                         "[0x%"PRIx64"..0x%"PRIx64"]",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, end, wname, wbase, wlim);
+            exit(1);
+        }
+
+        if (fixed_claims_overlap(addr, end, &overlap_owner, &overlap_bar,
+                                 &overlap_start, &overlap_end)) {
+            error_report("pci-bars: %s [%02x:%02x.%x] BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"] overlaps %s BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"]",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, end, overlap_owner, overlap_bar,
+                         overlap_start, overlap_end);
+            exit(1);
+        }
+
+        fixed_claims_add(addr, end, devname, i);
+    }
+
+    return true;
+}
+
+/*
+ * True if bus, or any of its ancestor buses, hangs off a fixed-bar=on
+ * root port. Walks up via bus->parent_dev / pci_get_bus().
+ */
+static bool bus_is_fixed_subtree(PCIBus *bus)
+{
+    PCIDevice *parent;
+
+    while (bus) {
+        parent = bus->parent_dev;
+        if (!parent) {
+            return false;
+        }
+        if (object_dynamic_cast(OBJECT(parent), TYPE_PCIE_ROOT_PORT) &&
+            PCIE_SLOT(parent)->fixed_bar) {
+            return true;
+        }
+        bus = pci_get_bus(parent);
+    }
+    return false;
+}
+
+static void scan_bus(PCIBus *bus, void *opaque);
+
+static void scan_bus_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    FixedBarsInfo *info = opaque;
+    bool has_mem_bar = false;
+    PCIIORegion *r;
+    PCIBus *sec;
+    int i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    if (has_mem_bar) {
+        if (validate_bars(pdev, info, bus_is_fixed_subtree(bus))) {
+            info->any_fixed = true;
+        }
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (sec) {
+        scan_bus(sec, opaque);
+    }
+}
+
+static void scan_bus(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus, scan_bus_device, opaque);
+}
+
+static void scan_all_host_bridges(FixedBarsInfo *info)
+{
+    PCIHostState *hb;
+
+    fixed_claims_init();
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            scan_bus(hb->bus, info);
+        }
+    }
+    fixed_claims_free();
+}
+
+/*
+ * fixed_bars_validate - scan all PCI devices, validate fixed BAR addresses.
+ *
+ * @info: carries MMIO window bounds for validation.
+ *
+ * Returns true if any fixed BAR devices were found, false if there is
+ * nothing to do. Aborts on any validation error.
+ */
+bool fixed_bars_validate(FixedBarsInfo *info)
+{
+    info->any_fixed = false;
+    scan_all_host_bridges(info);
+    return info->any_fixed;
+}
diff --git a/hw/pci/pci-fixed-bar-validate.h b/hw/pci/pci-fixed-bar-validate.h
new file mode 100644
index 0000000000..297d1480c0
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_VALIDATE_H
+#define HW_PCI_FIXED_BAR_VALIDATE_H
+
+typedef struct {
+    bool      any_fixed;
+    uint64_t  mmio32_base;
+    uint64_t  mmio32_limit;
+    uint64_t  mmio64_base;
+    uint64_t  mmio64_limit;
+} FixedBarsInfo;
+
+bool fixed_bars_validate(FixedBarsInfo *info);
+
+#endif /* HW_PCI_FIXED_BAR_VALIDATE_H */
-- 
2.34.1


