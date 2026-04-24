Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C5FED3D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIuC-0003oG-F0; Fri, 24 Apr 2026 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wGIuA-0003nd-Jo; Fri, 24 Apr 2026 11:57:22 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wGIu7-0003Mq-Lj; Fri, 24 Apr 2026 11:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ9TVten3udibLg3U3YPydTp27cfob6Pw9R+xT+bOFbCB0oWhB1lK6IJ9F5FlpxwznSliJfGRvjO4LX05Q5+gOSdXpGSglqFbYyDGox8E1rFZxBvy0E2sOWmgwVan4x/Je/x+J6iPZqfs9kzh4WeZ5+aLUeL8vFFIKkii16ZJx0kF7K2D5AiqELakBmHhOOw/vs/6PcqPO2CRQYX6ecFwaqOdBm3rcXyc3dH/StJDY7PZQ7uGHPgOm0VY4qOXAoupsH3a3tmwpBCMlrlrTXzigzwPEmZ5/QJUKkQT9M+V+ScDQVNjEUwAHvf7piOcsKI3ES7CXbmwo99E9GIHjgiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLyg4SUcbhPf/UgAsp0MRyeOKbr8wXR3qR32euURJAw=;
 b=pG/64umbZOtP1lM2EM2GDJCrm8FG+bxeThBX7gzEJj/bZ7aMvrKK958OC+PksA+AMuEXN3vz5S3o8aa40vIP1TGKXGnqo98e3PGw1AyrajOdTPIGjCiCVTT+in9kCOksJ0S04yRR5d+nrtJ04y0cLD2/d2yf9vavclLxHCYK4UcAt2Dpf8axcD4EOQv6O/EFuWyoABlyzUiqQPnyS7qNAyfIjzZCZE38YwUtoIj2ygZOOUklLyEC9EbD3BJrcUjCiYyrwtHL4FthnFAzXeE7JmVs6VWQcYVFeF4ZVcGDl7dS9RZ//4mtZ/Coq/3u6Mqo0/kxLQUP2T6MV33QIxyikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLyg4SUcbhPf/UgAsp0MRyeOKbr8wXR3qR32euURJAw=;
 b=xgY6bbv5eheKlJ1fTMU11r64vFwlf5D0EaOsg5sgKtiAoMTUO2mi1rWFyAb7VOmcPX4is0NPCdkurMV97Tije46ywlcxP5w2+/ZaXDcvLW35iTJU2D9ahX9QiHfqtPkaZKmE8W4t2UNOdGbFmIZGb/JpRo/WYnrSr2W/BYNl+Wc=
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 15:57:12 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::c7) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 15:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 15:57:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 24 Apr
 2026 10:57:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Apr
 2026 10:57:10 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 24 Apr 2026 10:57:09 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Thomas Huth <thuth@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <frederic.konrad@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, <qemu-arm@nongnu.org>
Subject: [PATCH] hw/core/register: add register_array_get_owner
Date: Fri, 24 Apr 2026 17:56:44 +0200
Message-ID: <20260424155646.533334-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dee10cd-84b4-4486-2b1e-08dea21a259b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hFwi0VOatTt17NNsWvm6V6iiwlIGKqlO0dDwqQ4vdRY43uAVAFIQ6SOkArkcWvtkxpN0Bfw5MiOorCqCIePNQY9bzy/JSL/k/mZUzm3Va1QwjR014mue/zaVuQafeR3ahTPFi6iuN9h74vF8L+AfrhgcpLPV1VGdP21UXdCjc9rAl2WRp3EtDZxV6c0uFOG6nSwx/gfA5C8Nq6dW6rEeIWOrPNpnWBLAmcbTRAbZvJQdA2J4UQv0x10Wji6mMK0LhJAGo5cYVXQTzi8CK7kWxl1FlGf8AHDt2cZ2580TyiQW8uMvno0WThXLELZmkbZRH1rLbMvYr5ckggkQStnB7DDI82+16RwQkRIZidLIXTUjvt3V2+TUGeRUnwkc5y0oSX+hXTeIW8rYLNqBcf7Wm3Qwik3NDTgMJW+S8pSwJ/AkzhrarMDScPfNPQEyHoEON528RLJI73BAXQnxPYkgd8jdxcMoUgKwDJqxR9T7bGi7J+Ok3Vs2z/9JrpZQHpTo4rDVhtxbLcKQqm5VGNGbS4TxHpcwYJDV1NNX6mPEMOimEZxSEjSnoJAgYYCYa56He+xD6OG3tL80SW85Yp0d0uo0CiBHKbXy9UiHZ/3l2CSGPEBRuFVcflAUopJg6WaNFiIEDxQAkSvQPS50C0pv9NG/PAT+fCYmhlLURZrKqT2U9L2Ex0AYwIkTqD5kc+PEtUSoB5kSn94VygY6QLsOQg93cFUgaCV5HUCXLdAYRFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPTbFYFPlRZuEcMM9aF8fKlmCDklQ3b5jYBxc8+xw7RYN9rQnfsRTWe0EV1V6CS54kgo8yk+aGK9jyc1cq7Hwvt4ZoWD5Y+z54om0MgLNzhXiejb17oqAKOHVpdOUCVczOTSF0FpI8Up3cLRV6/cpZma3WSD69HLdOZvAnbesLbxcoeA/HOxIkJf6dokhITqeo76yKzKOq3H9mlXbwuSZ+sPz47pgvh3HzFUT1+gPyXEUT2WKo12AD1VkrXOZuNbYtQnnNU6zwqUnvGji+NFOLH6LATfcgaj/QduOhXXyKoGIl1IcBu0IGcwi/k7kvgukq2ucqpwNPAalWKQv7JG8PFlTYa7oT7xytgQC7xptXi6Q4ClJ2GxaD+NmbeHQpMa/gESgI6vJKZs5yWfJzaKxtKu875yw5YJEijI8vZdJ71mFV4WKCg72SMHlyo2Qa9d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 15:57:11.6595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dee10cd-84b4-4486-2b1e-08dea21a259b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Add the register_array_get_owner function to the register API. This
function can be used to retrieve the device owning the given
RegisterInfoArray.

This was previously done inline by some devices.
5c6367bc1c8850f74812eeaaf87cff9911be58de modified the way register
blocks are created and parented to the device. Since this is an
implementation detail of the register API, it makes sense to have a
function for this.

Use it in the Versal OSPI and Versal/ZynqMP eFuse models instead of
tinkering with the API internals.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3421
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3422
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3423
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/core/register.h        | 11 +++++++++++
 hw/core/register.c                |  5 +++++
 hw/nvram/xlnx-versal-efuse-ctrl.c |  4 ++--
 hw/nvram/xlnx-zynqmp-efuse.c      |  4 ++--
 hw/ssi/xlnx-versal-ospi.c         | 10 +++-------
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/register.h b/include/hw/core/register.h
index 1f265f4ed71..c6f648fe95e 100644
--- a/include/hw/core/register.h
+++ b/include/hw/core/register.h
@@ -207,6 +207,17 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          uint64_t *data,
                                          const MemoryRegionOps *ops,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
+/**
+ * register_array_get_owner
+ *
+ * Retrieve the device owning the register info array @reg_array.
+ *
+ * @reg_array The register info array to retrieve the owner from
+ *
+ * Returns: the device owning @reg_array
+ */
+DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array);
+
 #endif
diff --git a/hw/core/register.c b/hw/core/register.c
index c3f3c936e70..99ca5e17758 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -320,10 +320,15 @@ static void register_array_finalize(Object *obj)
     RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
 
     g_free(r_array->r);
 }
 
+DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array)
+{
+    return DEVICE(OBJECT(reg_array)->parent);
+}
+
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(RegisterInfoArray),
     .instance_finalize = register_array_finalize,
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 69acdfa3047..f5d5587cb65 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -617,15 +617,15 @@ static const RegisterAccessInfo efuse_ctrl_regs_info[] = {
 static void efuse_ctrl_reg_write(void *opaque, hwaddr addr,
                                  uint64_t data, unsigned size)
 {
     RegisterInfoArray *reg_array = opaque;
     XlnxVersalEFuseCtrl *s;
-    Object *dev;
+    DeviceState *dev;
 
     assert(reg_array != NULL);
 
-    dev = reg_array->mem.owner;
+    dev = register_array_get_owner(reg_array);
     assert(dev);
 
     s = XLNX_VERSAL_EFUSE_CTRL(dev);
 
     if (addr != A_WR_LOCK && s->regs[R_WR_LOCK]) {
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index e6bc54fc6bd..028120f824d 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -722,15 +722,15 @@ static RegisterAccessInfo zynqmp_efuse_regs_info[] = {
 static void zynqmp_efuse_reg_write(void *opaque, hwaddr addr,
                                    uint64_t data, unsigned size)
 {
     RegisterInfoArray *reg_array = opaque;
     XlnxZynqMPEFuse *s;
-    Object *dev;
+    DeviceState *dev;
 
     assert(reg_array != NULL);
 
-    dev = reg_array->mem.owner;
+    dev = register_array_get_owner(reg_array);
     assert(dev);
 
     s = XLNX_ZYNQMP_EFUSE(dev);
 
     if (addr != A_WR_LOCK && s->regs[R_WR_LOCK]) {
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 467f0ce7033..e25e4c26c2e 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1567,19 +1567,15 @@ static RegisterAccessInfo ospi_regs_info[] = {
         .ro = 0xffffffff,
     }
 };
 
 /* Return dev-obj from reg-region created by register_init_block32 */
-static XlnxVersalOspi *xilinx_ospi_of_mr(void *mr_accessor)
+static XlnxVersalOspi *xilinx_ospi_of_mr(void *opaque)
 {
-    RegisterInfoArray *reg_array = mr_accessor;
-    Object *dev;
+    RegisterInfoArray *reg_array = REGISTER_ARRAY(opaque);
 
-    dev = reg_array->mem.owner;
-    assert(dev);
-
-    return XILINX_VERSAL_OSPI(dev);
+    return XILINX_VERSAL_OSPI(register_array_get_owner(reg_array));
 }
 
 static void ospi_write(void *opaque, hwaddr addr, uint64_t value,
         unsigned int size)
 {
-- 
2.53.0


