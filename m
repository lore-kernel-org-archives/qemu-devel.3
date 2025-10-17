Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C815CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAb-0005UF-70; Fri, 17 Oct 2025 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAW-0005SF-4A; Fri, 17 Oct 2025 12:19:04 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAO-0007dY-Py; Fri, 17 Oct 2025 12:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYlXKAQmM5DvgaFkd6wdoriJJvOj7toOFyJCP75ntswYfT9iJ57KI7HEYOq7ocTE5wIP2OwxCf4dTaWK4SPnPo2mP3MxebrlpOumJ9YsRhRSI9O6w9lbZtzK1fuJJQy6ZOnAKL1gTCwEhYzgxpq6S44l75BL8vDyn9Sje79IdTSzdZY8hpU0DujgWOP0LkPFQqpbHBXdIqx/uhkvgqzj4WWWYILMJZDJyqd8sOg4TqnmR9Fd8zYMOk2eF5HBmlazO7IIiUqaPDP/I7hvfbmb6WHk8wWXs9x5oGQCcSzBFyw5xQiQ53T9EzZRxOzt+itjFCjwbOqxOuMOc2o0c/1oXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di4D+OyYjPLHl+aUkTfhgDQLFkbqjQY6ImPpmUSsT3s=;
 b=L53evjfQfE1gD1Fez3NMlNO0vf4LnH3Q8bwLR73JsnIam83WyhIcBi/wivci1kKPsM+Zcoa9M+N7hz6Fjb1HmEDhCHbUK5SDj4mayDyzXrdTSieAa489aQU3mAjkIpz7Wh5fh6+41wDQDj0aOP2LEJ/h+wwMBs60TSU+OyONeBa1DJbWYUpIRH8wVp4QzHPVPB43Awxg0PLW0htwRoDZ7YKN/9+uEdaoCBGISc9sw2TPfO+d96zv+xe1ey51FVCdkqae4iiSyUsuxkO+vayoUz3l6bB2GSDxBM64HE6qKQLf0TGtcauvqmgvsQ4N1zlCPSlpjwHJwQdWqAB2StVfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di4D+OyYjPLHl+aUkTfhgDQLFkbqjQY6ImPpmUSsT3s=;
 b=gh0C7g3d9k0U/89FbOHm475wplCP6TNWPG1jm9j8qQTcBSzt8gvO4tTLW88lsLEe6lVLX5o9ZcAHr7fOkEwkJ7hOXwmNBBMvrtkHluqElV3miYTUQfJZh3TnzeX5iqHnZ9PW7shYlSuaqZtYTbvtrpFBCk4zPlZYcM14JW2t9Io=
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:18:34 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::9d) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Fri,
 17 Oct 2025 16:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Oct
 2025 11:18:33 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:32 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: [PATCH v3 2/6] hw/core/register: add the REGISTER_ARRAY type
Date: Fri, 17 Oct 2025 18:18:01 +0200
Message-ID: <20251017161809.235740-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c8f852-eb89-41ca-0198-08de0d98d252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RWUL2v+P2ff80VdBrl4W4rL39d0bvBQVK/Q/L/B2NMiMZkB5kKx5tlgSqS7c?=
 =?us-ascii?Q?f82suTNK/9OOWrwHbZxdZ2L1LuxUooun9VeY7TN+yGYyczjssT845i4TwROz?=
 =?us-ascii?Q?+rdT8dmHf3/ILCEagGHerVXMkzuJ7quN+uLnSTSLfxJ6IHhJl8Q6oeJ4Dr3m?=
 =?us-ascii?Q?NFG8IwtB3B9LB7xC3vMFbtdHPknf1ompXaeAMhME+Ejh2b13chWkK2SxdHom?=
 =?us-ascii?Q?tpMf6ujNvqiltmZHdpeqJEeFoYkIf12a1H/b7s/pxACQc7jrU+4cISc3HnIb?=
 =?us-ascii?Q?Cti+iPj/8ePgOpRfIbjL4mrhO4IRKybxqM8EhYoA9zIUs4YpW6CDbRzscUqd?=
 =?us-ascii?Q?PX6H7Ii4BsWUMLzPzQgvmeOFJMg10qb0f1lkMbVaZEx7BrrYo59gpNEzkTTO?=
 =?us-ascii?Q?TY6SgovX5R5cn9RIafCpoz8JX4wdjgZlYQLZK+HYaZBuW7PVmSYxM/w5A65L?=
 =?us-ascii?Q?RDb7ZRtw+L/MewPXZmpvZD+7CS+ysY1txAP/NuIpChGjdJrtv1gkuPtdxuiq?=
 =?us-ascii?Q?u3393v4HY049vMAf194R/4K8+aB3XcuDKGiLthBHbHHrgCyhVuI3gn/00jBA?=
 =?us-ascii?Q?3RoIbDZ+mv17gIMmI5p+njNsrsSlq25impR5SbzrhcxeGSqBqphbz7JLqyZ+?=
 =?us-ascii?Q?JoPpXyBPrPcHYh/biLMDSptM8Xpsu2ec4Irl6MZB+XzGbe/Z1aVG6cauvVaV?=
 =?us-ascii?Q?xrwRkRNoM7/AA04qSdj6z4Btw2defluRXOEC4yyA1CYXRzTuWzzZSOsB4HU2?=
 =?us-ascii?Q?IVbueos0oNs0zVrn4AxXxx070KftbbBkpOYeqBYe2KpwmIwnpHBCLRTZZTw2?=
 =?us-ascii?Q?o/nHvPMaPbK0WmkzEXudm0yCQygvWuUQ2q+GUAodzj45qMHsKmJK3CNu2toW?=
 =?us-ascii?Q?iz+M/tawJ9xLJHmHtg3pH63qm8R2HoMb9oH1z3Sisklq5OHBmKJ1XJrhdT6F?=
 =?us-ascii?Q?t43Zf71FefEWsMbelOezG5V3OisELvFl9yXvoGwXeQx6bpdhuvdLwN7xNnMk?=
 =?us-ascii?Q?o4HxYT3XEYoo8zHjGn1mGyLafPhrzKYYDZpqS02knYYNin2Jup7UStxpC8jL?=
 =?us-ascii?Q?WMPUNSMXMnSHFB4yknoQt/Tfboj5H7zClO4JTg2GlWkQJmA/kqvC+Y/8xf3y?=
 =?us-ascii?Q?epmjBVeAjgUrrexRfFzhJwMx2a5b0rYgkOdM0RZXNYGEI8SaJc5gUZw8Cg8/?=
 =?us-ascii?Q?wtHfELv0xzva5GGjuI26WBusPTQGCLaseAiFJs/pEO4ALD9PnX0Yk0sdDXsN?=
 =?us-ascii?Q?TNzUeT729KwiLVjmcgmPhwqtzT43wa/rTN6g45bC2wo9TekBJs/ZzYjeQiv/?=
 =?us-ascii?Q?FlC0vDedddzXjqn/ugoQZ2oDbxWJ72gIl8+I1lL1xs7A/UVKjtZ7786obiy+?=
 =?us-ascii?Q?TojqUg5CfeD/dAKPtJrNsKy0HujItWRBl6gI2GwlAhp8SIqSo4GB+OQojPfe?=
 =?us-ascii?Q?Vb0ePWQ3Ich470uvef9BvNFO5/RKd9l+10SC4d9RjI6Rq6YWwnBCE5Inba+e?=
 =?us-ascii?Q?1GOAj7/yIpOo7Ey5E1X6//TE9JcmkB4IH48nhJuadLqQ3WOD59TfnmyGgpC9?=
 =?us-ascii?Q?E+G4k6NrsUpe67lKtvw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:34.7541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c8f852-eb89-41ca-0198-08de0d98d252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
it gets finalized when the device is. The memory region is parented to
the REGISTER_ARRAY object to ensure correct finalizing order.

The finalize function of the REGISTER_ARRAY type performs the necessary
cleaning that used to be done by `register_finalize_block'. The latter
is left empty and will be removed when all the register API users have
been refactored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h |  4 ++++
 hw/core/register.c    | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index 2553cb15aba..1612ad174f9 100644
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
 
@@ -265,11 +271,11 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         r->opaque = owner;
 
         r_array->r[i] = r;
     }
 
-    memory_region_init_io(&r_array->mem, OBJECT(owner), ops, r_array,
+    memory_region_init_io(&r_array->mem, OBJECT(r_array), ops, r_array,
                           device_prefix, memory_size);
 
     return r_array;
 }
 
@@ -307,17 +313,29 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
 {
     return register_init_block(owner, rae, num, ri, (void *)
                                data, ops, debug_enabled, memory_size, 64);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
+static void register_array_finalize(Object *obj)
 {
+    RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
+
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
2.51.0


