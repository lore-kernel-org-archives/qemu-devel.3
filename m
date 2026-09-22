Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBEEC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98OO-00011S-94; Tue, 22 Sep 2026 17:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OL-00010y-NZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:09 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OJ-0000Wf-R4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG2u5On9JXQSOQURZ+J9pBBoUNVdka2MC/xzPK8y8N6qb9NZSXiYiFnLi2Ff2QmbXzkoB4uF7fBC0i8yBVEuFD6YtqANpEqVqlLA7ApqVREYFbtpimrKoB/7t0FP2NhQDEsTi6XqCoGjH3zv9bA8tY7rYZCoVMjY9Ngj2V37NVUrzULoVf6gAGHKkd0ogS1U6e+faRPaaTFVR9NBkCvTdusXAhIvv9j3XaZf9YPhDfmCxR6Zx9Q6gUfrEKSSxiPJ3oxAinqh9CyQVLPcy9uTi8uZposmLTNUUT2EFbxZc5eoszqeLYmyhcvJdmEG4x01O+1+X0V0hI3K2l2G37ktfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D77zv0KVfFVFnF4meQRovbkpnw3cVz2JsJpdqGsmCjQ=;
 b=yM+dFdlVHC1KsY1T4owkhZoSRbKX2XB4TmEs73IeXk3M3v/EJwOfpfReZ0psbmPfJWuYH0+7iw+qVmmX5cFg76VtvZwC+pdcZoQwGxpPWl01i5hUQ1DZ8ZD+Bh51wuRGdXJr73HdFSM5tlVeDItk+f02J0FyyBnWvMxhwtFmjVlOdaAOALJ0y+2yViM7WHtVFCYibrKccqjYdj9liL8MWuyim2yiivVu2aeQEA6Kafy8SxdMvf/s94/efJnEFW6Eot/5fNtUxnDBeZ4NADQ3k7USK0Srx4cX819Lp5xKQ4yk2ugXnExNX7wJQ1HzOMdCExfd3406HZvoEp42uA847w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D77zv0KVfFVFnF4meQRovbkpnw3cVz2JsJpdqGsmCjQ=;
 b=DJr0JqE9MN8YFaJHh57pbQglfVEgN1csUVASwv1RwD4y8NOg5y9OSznaGJQfdrNF9MRX+jPd5utgtscJYMcMU+zdULDXIBPg37CsR6Cqx8EblKz8V0RFlZ1scjT+7AxdV9oNRmrf6MBmHRzUGcNNq7Jn5+TDLlr2j3m6tk6eQLdbDLltjsMrUFn2p4bAof2eW5Kx1V20MxGtRu6p/KSSSuD9gCD/PxBHaXP08vQQkBkjPhki3LO2poptKg1Npgur8DIKZ/6kpJd7oku3n0p7LPm3KGrBFXcJb1oxtJhikoGkcB7Y2DaFgQSOn/b7tSi6lPOFZDri5xkJDxvUcPPbiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH0PR12MB8126.namprd12.prod.outlook.com
 (2603:10b6:510:299::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 21:50:22 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:50:22 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH 3/3] hw/pci: Make ACS Control read-only to guests
Date: Tue, 22 Sep 2026 16:50:08 -0500
Message-Id: <20260922215008.2554402-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922215008.2554402-1-tdave@nvidia.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::21) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7ff600-dbd6-4202-0291-08df18f3807c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: U1AnFh4l/qlF6PfwzhdNIz3nzXcDuB5VGhQXz8tp/fqvJWP9W6c83wzsnKcrh5xXosgFgvLbfNMOw6HLYeaudEqDpBOqnOV2I0R6bUewUBmYhl9ukhRpekZyvnXY/c6x/GTVCtAq4fNRS08PMRCecr2Th4MdwucDKvvLa5VTgZwQQEbBpgAkBByO17/UtDqRrHNTwtXWAMVEpdXKYq1CtoWWOHM3iJ9vQhN8RQ0DVKOZRqRa2j4/Xv/YNC33+SE005dgnc8/2hQ/TmQAhF8ZK+3G9Q5vLCEkN6cq/7xCNRDQcojjtkN4/bTr5cRQxT/Z3rU/U+6xWgUTFG0GDlemeNeB6ye1iE3LEslOIlmqjxLICfmbGQrYWiUiTHPA34hx5JFWgSFleuFHMxepjXm60Tu6BViRv1PMGcUkAsnaj5kvdOx5otryii9WRwlb0Wf+yv/pFg1fg+wgS71eoyJoLVhhq6bKIL/w/lViY5i07iVdzZm2rM5BS783TuC3Tb6YEtYWvYgrpU2wqxROYaYNcbu+SevAc2nGaaLE8TZJHeChUcC7gtigVybQUGrtSVUvCYo3Wu7VGrZ+Lorv0og5URoDDkbx4KqHNu0qWuLVZCkmP/Ez3L6jerIflnEfEbAPqXvqBeZwMSErxWcNX2bGutwKV9PduEYtSSLoPHd7hw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PUUpiMR+GACZUaRbiRrkAGV9535wwnCUobb/O0+tWL9O7cWVGXyoS3Eh4gj?=
 =?us-ascii?Q?XKWg4Bn9ItKXUWuQ0MLGsq4xImUPsfQpogUk4SvpZjj4jTrBS3W3yT5NzHIT?=
 =?us-ascii?Q?856DcMznALkbgjsZY5tZUBaSmWg62Tr2ODmArsldbrqdu+t/7ATd+l4iQyfI?=
 =?us-ascii?Q?8G+virt5mESMvLE/25nHTcy/VFQSMgR6YYMoe3XB49ddHlBXC4mrWz7gITcN?=
 =?us-ascii?Q?mfeP6u+aGZXZ1Aa9+JtDB/FxX5+V/paSiXWquhOa43wiFEd2clV74G4Ok3XY?=
 =?us-ascii?Q?xYfeU6xTPFiJCFe3W9v4/nLwGFcX9iZ75JRdRkyyE0AS04RBEaJRY+ruF/jk?=
 =?us-ascii?Q?1dVJ60/WRBPhdzq0eOcKScSUwHFK46iDjz/NcRjoArnLxSiup07D6lIuSA+r?=
 =?us-ascii?Q?EejTC9fmJUIkejRMSMQGpiIO6lEWuIMtUnrvL6MEHjeiAFDqTNSP8l6XB0TE?=
 =?us-ascii?Q?5e1rN65PSGyUwy3nbh4K9aS/a76CJzc4XqeYqkw9Cj9TvCy+l494IxkXe04H?=
 =?us-ascii?Q?5tqlve/iV03r9HUYhHBXESZDWIHQXzPylJyuCaE2eN65TDSAq4m2EmXVNS5c?=
 =?us-ascii?Q?KvvSJ1XSRl9TiQodyV++i3zw20ZBn2jpMTIzLNx99sqoaL9V+tnhm3sPgIPK?=
 =?us-ascii?Q?T9YrOWkA9OpmTdkuyf5Y1yZN7r6jesrAL75w7PtMc1D7sz3nFOPr7zLexohk?=
 =?us-ascii?Q?pVQEYW+RN4aEw3NvBQ6FVRmKJyDpr09dCDWPy9ra5jmkrMScfUq7wlnAno8z?=
 =?us-ascii?Q?I95toHKtavvl6Z8Tnv/UOKES+/Rj50rMfwiS7x98EYvB4s5dtVVRhGglfD2c?=
 =?us-ascii?Q?S3xsiuJr1BguKV2osYj9/gtvnAo+y4AM+JXEj1dqffUviUCSanRxVoye21YI?=
 =?us-ascii?Q?OIum9OBksmfmiiX2c05mByE2s4eeFO1yigCwYnzJWSIAMcBtY+p9BWQvCjAZ?=
 =?us-ascii?Q?LyKPBtWQP/6UqOP75r4GuJD6fD8fP1Ub8jHS9/QJb1BUUFHSc8bl+ulxHups?=
 =?us-ascii?Q?mYFTBsMZa06eu/M5rX3I65YyW4+ePCl6TiMYnHNccsEu8VBneEAQrZI9a221?=
 =?us-ascii?Q?yWcnJ6l77ZNGORvrk/YBANsIZXazIfc2CYaReXDXdRt90rocsqedae9dKZGM?=
 =?us-ascii?Q?oDtkc8hS5byo5m5do6rg5tVfrQXghUx/VDDkD9AjkZ/hkq5FLPkbIuxyBZ4w?=
 =?us-ascii?Q?X2Fox4kJfiCL5LQNhWHvaceIwRWXqPewZbHENMJVbn6MutHwenNG8GdxjTFc?=
 =?us-ascii?Q?0/ktt1wKW18QwpjceoOb0jQdXolgeoluE/iJ2KbwQ7LMq2pLacdanAh7g+UO?=
 =?us-ascii?Q?bR8jw8eiOnOWtDq7zvSL8oZGJLdjkxEdDa4tzKUqo3xtwyjgOvbS1ZMfPQaB?=
 =?us-ascii?Q?xAFQ3jTXt6Ryzl0gtcq6wJ4vXNJlmfffsYhLldn8K2zc2gEhULltLY+0upuV?=
 =?us-ascii?Q?ukDMPwln7RNeGgYXOow/leCMjn4Ab3tRMs4vAyHRaovxYUeCKNPVulElW9O2?=
 =?us-ascii?Q?ywqwQrA7J1c/CgrcttlUfHIZ6lYwgfw9r4E0jxOM5UAA7hBV7ZgG1pnIZy13?=
 =?us-ascii?Q?DaWMTgBgiRB6JcO/rAehOFX/omk3LWPjWJeF15afoBv7IetbQxxB5sV6vBhZ?=
 =?us-ascii?Q?ANyOk0oQHBf05TE73soJCv0ID+U001IPiMxKyq5m5sK51lg9256sa1lH2eM+?=
 =?us-ascii?Q?2jiqgkpKpWYML8bQEHl37DCd8FHzGVHKtui6u+jPK0A4JEQx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ff600-dbd6-4202-0291-08df18f3807c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 21:50:22.2188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKyE8ZCHo44rQSG8ELlEplBXbFYVk9Zg62EwzhfeJ4XwFtSkLuSDg+gDlqDnLBoWVLViPlG/zV3Kik4mxVrgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
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

GPUDirect RDMA using data-direct requires a specific ACS configuration
on PCIe Root Ports and Downstream Ports.

While ACS can be configured via QEMU's 'acs-ctrl' property, the guest
kernel may overwrite ACS during standard programming.

This change blocks all guest writes to the PCIe ACS Control register and
preserves QEMU-provided ACS settings across device resets on PCIe Root Ports
and Downstream Ports.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci-bridge/pcie_root_port.c     |  3 +-
 hw/pci-bridge/xio3130_downstream.c |  3 +-
 hw/pci/pcie.c                      | 45 ++++++++++++++++++++++++++++--
 include/hw/pci/pcie.h              |  3 ++
 include/hw/pci/pcie_port.h         |  1 +
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 3ae0b75146..784697b1ca 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -156,7 +156,8 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
+                                   qdev_prop_acs_ctrl, uint16_t),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 9829832c39..e8717be73a 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -149,7 +149,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
+                                   qdev_prop_acs_ctrl, uint16_t),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index c36f8c58c6..08e21022e5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1265,6 +1265,8 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
 {
     bool is_downstream = pci_is_express_downstream_port(dev);
     uint16_t cap_bits = 0;
+    PCIEPort *p = PCIE_PORT(dev);
+    bool configured = p->acs_ctrl_configured;
 
     /* For endpoints, only multifunction devs may have an ACS capability: */
     assert(is_downstream ||
@@ -1286,7 +1288,7 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
         cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
             PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
 
-        if (ctrl_bits & ~cap_bits) {
+        if (configured && (ctrl_bits & ~cap_bits)) {
             error_setg(errp,
                        "Unsupported ACS capabilities 0x%hx were supplied. "
                        "Supported capabilities are 0x%hx",
@@ -1296,7 +1298,17 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
     }
 
     pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
-    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+
+    if (is_downstream && configured) {
+        /*
+         * Block guest writes to ACS Control entirely to preserve QEMU
+         * ACS settings
+         */
+        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, 0);
+    } else {
+        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+    }
+
     pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
 
     return 0;
@@ -1309,6 +1321,35 @@ void pcie_acs_reset(PCIDevice *dev, uint16_t val)
     }
 }
 
+static void set_acs_ctrl(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(obj);
+    const Property *prop = opaque;
+    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+
+    if (!visit_type_uint16(v, name, ptr, errp)) {
+        return;
+    }
+    p->acs_ctrl_configured = true;
+}
+
+static void get_acs_ctrl(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+
+    visit_type_uint16(v, name, ptr, errp);
+}
+
+const PropertyInfo qdev_prop_acs_ctrl = {
+    .type = "uint16",
+    .description = "PCIe ACS ctrl configuration (unset = not configured)",
+    .get = get_acs_ctrl,
+    .set = set_acs_ctrl,
+};
+
 void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
                             uint8_t pasid_width, bool exec_perm, bool priv_mod)
 {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 1ab7b3eee5..b1d5e8ae20 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -26,6 +26,7 @@
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
 #include "hw/core/hotplug.h"
+#include "hw/core/qdev-properties.h"
 
 typedef struct PCIEPort PCIEPort;
 typedef struct PCIESlot PCIESlot;
@@ -86,6 +87,8 @@ struct PCIExpressDevice {
 
 #define COMPAT_PROP_PCP "power_controller_present"
 
+extern const PropertyInfo qdev_prop_acs_ctrl;
+
 /* PCI express capability helper functions */
 int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
                   uint8_t port, Error **errp);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 2ad9a563d9..ef2c2ec2cd 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -37,6 +37,7 @@ struct PCIEPort {
     /* pci express switch port */
     uint8_t     port;
     uint16_t    acs_ctrl;
+    bool        acs_ctrl_configured;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1


