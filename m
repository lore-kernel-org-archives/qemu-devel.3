Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D51CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqgu-0001Fx-W8; Wed, 17 Sep 2025 07:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb9-0002i9-It; Wed, 17 Sep 2025 07:45:34 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb7-0001pK-Lx; Wed, 17 Sep 2025 07:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI73tWMbpKMdWTY9dEf9R4iuGLyke7vuBB/tMtLZwAp6Dhtvz2cAQ53xVH8iwgkSbmtVyYXwwg2MdQLAqtuEJo1nbmO1LlNMLXRgoJWSWyqM1jAoktnEakHV07Z51mnn39cCoJPFIJeluDvRc7W8tYvx/lJmeS6ewlqT1035KOCHEcWHZQqwYN6Dcb/7zRJeWdeajU81/ZrWXIlr77hin3obCVZEOnHnfoWilkfbwJ5FQDIA4FZ5Z7RNfhN1+CFBONnUX0UWCf678xG7acei/ZA/tdRF0x6vXFf/MmCOVES2f6lbop+GpXqJUzXXpKsT5KC5FrtXAwhKmOKgwbv0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb1MQlQftlmKR4RiuBV4l8tUleVNBLtd58xgtytc76Y=;
 b=dTO5xfcwDq8fOGiujMUnAXQACPkZT9DoIqbTYcXnbjwOgQs0KBNvyw6ArRmv9hLGEZnfrofaHrTokSiBkqIyvBo+hRd7okTE8DCimI9o5ZpBNvt4Zkfke0GT+1VDRiyMehd8+boZmgsQkQYV4uK1HCmfXXziUSiorbXngK2iDqQbZU7oYN1JmSUsy2JaFBqg0vQrTN26JBXU9TLhrUBhCnHB9Ix8bCCmpfXLvauTfc/7p/ciT04peYpqrBQw7EAbyrJ92/Yv2UvBmLwzaSSU2TlpnJIpe1V0tMx29bVJAVhbITURyZ/M/LbW8MXh4LZzGAX7e2AD5vzcWwzzAOOMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb1MQlQftlmKR4RiuBV4l8tUleVNBLtd58xgtytc76Y=;
 b=hn8MmRkOSwtmiLZGJqpn1CLdMBZD9bIqDCk2hjv/5dWbOHUrv4HhJU9U+j5Hsprbrpta3tBWN1zLFlMP1t7/zy5DeKOJchqqWCZN9ziZ4yYCfL6+1XJbETEINyZ8UVDmTaKQ7u0o+vcMztdsMmbsiPHfFbXzhR2goseocJxAn7I=
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 11:45:10 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::4b) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 11:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:04 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:02 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/7] hw/core/register: add the REGISTER_ARRAY type
Date: Wed, 17 Sep 2025 13:44:43 +0200
Message-ID: <20250917114450.175892-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bf17d3-1d18-43ea-12c2-08ddf5dfa79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Ok2S0/WrVVbTuWyelfzmX/UdGE+xQby8JRUzjCcLoXhfSWpNVFAby9LkORe?=
 =?us-ascii?Q?NKhUtnXXgfJ4GY7G/K4xA1sivXK4aN6mExxy6nN9qisJpyG6cSp1WkpXmLcn?=
 =?us-ascii?Q?/hQxNnOe5sEC+NVxFGT7Yj9g49+HDbHxnE37/2RDWxuCgQLdz146Sv+NRTmy?=
 =?us-ascii?Q?Hx2/rfHDJOgnTaWxoQCrxSB1KJxnII1H/BOq7sTbyF5w2hZjlZFubXK/p4Ax?=
 =?us-ascii?Q?VjcmZ9vHIwY2liUa//Eh36sqAa2OvUvXHdJv07VIGogXxI9jSqryxgokUbCs?=
 =?us-ascii?Q?MwWZfE9CfGm7r5h9MFk7Orl3d6PyvD/RyEvAtRngR5w0eu5H2iPv5Jn46zlW?=
 =?us-ascii?Q?SFf8u0mPGcpWdirM4Tdc18pGpXIK6Exqsrc8Ygzx3gpUhLf0sr2aForubDsa?=
 =?us-ascii?Q?KNVRcY6coUlSgsIr1JjaGQfEprA9Gi+14TSW/6YpkpDi4xjwXkBNisJc1UJ8?=
 =?us-ascii?Q?nI3XklLZugc8sZR/ohNHkmxfBKPJcnynOAA3SGh7MV5OulIro2D68mk2kKzD?=
 =?us-ascii?Q?L3Z4ImGXC1ruy1m9wuWJ8ELLItJx+oBiOU91Y7/iXPXk7SFjWe36IVOeuQeA?=
 =?us-ascii?Q?R4RzcCilpNjoLtaf3qSG2kLjJuk2rG3yM4IqnSGkw9KIcYy76Fv1Ev/wBp/4?=
 =?us-ascii?Q?H53rENrJmlGM4UdYSrgorkTOXPmOzCtVCWK8xDhvudZf8pDm0tgAJEU4LamE?=
 =?us-ascii?Q?SbdgKDElWmFEB3vdFO5ueTIC7rEeOCSY+Gye6rQN4bbfAt1LsJWckqLhLMNw?=
 =?us-ascii?Q?6cNAH+0+b5aDs1QHvEeVGf/rMCNy20pw8gSm05nLn12HRiBdaNryn5ynZPI3?=
 =?us-ascii?Q?46DwA9W1e52NGbTcIkA4qED5UqW+5/Sx3NYTFFaS3YYndV5Iaot3yIRu7C38?=
 =?us-ascii?Q?ik0AaVmnI13rmMC+AC5Iiw6H3LuV31pwSsSxeoppun9PfK/+gMqkm0uZPLev?=
 =?us-ascii?Q?rSW4klqrwt9E6L/X/jGhe0CTS5jmMBZjbwl4bazSvYsI5tr0P2w3i/hqVMLq?=
 =?us-ascii?Q?N5ELZoINjPvn8q+nllaZzdEPk8zD4KpGHpdGrGBj9VbAXzPyvGWHWtiCu+l2?=
 =?us-ascii?Q?kxcIaJPwx3WqOioWb8ZPZRAh2dQ3PuGYxwAICq2D9QzFHeIfxOOFHd+VpMOO?=
 =?us-ascii?Q?dSeyxR25i++BpUo9cdpLFanOEkty/fAlCxi90Wy3+vpw5q4Uvw96YrOie/Ut?=
 =?us-ascii?Q?fCpJn2RCNH/ZA2+FfTraiwMi3FocfykigDNi5MwYiWZ7f2T9D0XKvRLUgq9s?=
 =?us-ascii?Q?O8JUuBYTmucUk7dKTPZWkqcDmg8nxZNREgbLBLUAYau3rSNKU0rywYTtEHQI?=
 =?us-ascii?Q?GO4PFrM9Xnou06EZRuaZMRuLDRyFcY8yaeSzhnyLMEOEhtCZvi9s56pF574N?=
 =?us-ascii?Q?lp2L18ZwxqKju0JneUPoRNOmqHWuNbwIdTU5CeopNa5hHHcjS4ilWhOEnUxg?=
 =?us-ascii?Q?4Cehm2j7Gxncf408bPNCeDbRy4pBAy3gPZ38LgAF3b/IQvcfRjIFGNKaoNxz?=
 =?us-ascii?Q?TLyXlBJE4s7RUOd7fFYmWVMvviJHGFrvLwGz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:09.4700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bf17d3-1d18-43ea-12c2-08ddf5dfa79e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
RegisterInfoArray struct. When `register_init_block' is called, it creates
a REGISTER_ARRAY object and parents it to the calling device. This way
it gets finalized when the device is.

The finalize function of the REGISTER_ARRAY type performs the necessary
cleaning that used to be done by `register_finalize_block'. The latter
is left empty and will be removed when all the register API users have
been refactored.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h |  4 ++++
 hw/core/register.c    | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 4d13ea183c7..65c82600e06 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -81,10 +81,12 @@ struct RegisterInfo {
     const RegisterAccessInfo *access;
 
     void *opaque;
 };
 
+#define TYPE_REGISTER_ARRAY "qemu-register-array"
+OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
 
 /**
  * This structure is used to group all of the individual registers which are
  * modeled using the RegisterInfo structure.
  *
@@ -94,10 +96,12 @@ struct RegisterInfo {
  *
  * @mem: optional Memory region for the register
  */
 
 struct RegisterInfoArray {
+    Object parent_obj;
+
     MemoryRegion mem;
 
     int num_elements;
     RegisterInfo **r;
 
diff --git a/hw/core/register.c b/hw/core/register.c
index 57dde29710c..4d1cce02a55 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -243,14 +243,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
                                               bool debug_enabled,
                                               uint64_t memory_size,
                                               size_t data_size_bits)
 {
     const char *device_prefix = object_get_typename(OBJECT(owner));
-    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
+    Object *obj;
+    RegisterInfoArray *r_array;
     int data_size = data_size_bits >> 3;
     int i;
 
+    obj = object_new(TYPE_REGISTER_ARRAY);
+    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
+    object_unref(obj);
+
+    r_array = REGISTER_ARRAY(obj);
     r_array->r = g_new0(RegisterInfo *, num);
     r_array->num_elements = num;
     r_array->debug = debug_enabled;
     r_array->prefix = device_prefix;
 
@@ -307,18 +313,30 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
 {
     return register_init_block(owner, rae, num, ri, (void *)
                                data, ops, debug_enabled, memory_size, 64);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
+static void register_array_finalize(Object *obj)
 {
+    RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
+
     object_unparent(OBJECT(&r_array->mem));
     g_free(r_array->r);
-    g_free(r_array);
 }
 
+void register_finalize_block(RegisterInfoArray *r_array)
+{
+}
+
+static const TypeInfo register_array_info = {
+    .name  = TYPE_REGISTER_ARRAY,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(RegisterInfoArray),
+    .instance_finalize = register_array_finalize,
+};
 
 static void register_register_types(void)
 {
+    type_register_static(&register_array_info);
 }
 
 type_init(register_register_types)
-- 
2.50.1


