Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60625CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAa-0005Th-BY; Fri, 17 Oct 2025 12:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAT-0005Qx-7I; Fri, 17 Oct 2025 12:19:01 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAN-0007dC-6l; Fri, 17 Oct 2025 12:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH3q3bOsTuB4GxmZ9Fay8b9pOnSMQIlScqi+BhiO0F002kjdgXnXzxaKcr2kXst2eweZ4u/iXQEIaj5H9mDBojDimNB/cn+/molHgUCqbxIwpm/W5MOGb1V1gHidN72IWNYR314s0LsGM1viwuxKaFwJ+odxtie0yiKNBu69u9sr2ACAQjNzCahzJVTLmEnm1MidIIfJ1Ehn0ciY0/nrX7KRXN2NpU3/qkmp8bWKBydkKE5CjQ9KW0OVjivTFOjE0NqxsWxiSLtvEl1Lf5u3WJb7KlpMdf+RQ5n36yO1b6G7vv5PAcgdAXmLEbRI7qmfU86OZhhcb4mLh/y3HEMJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALSJf63g6EOqbxWBGxPBCqT5/sgAAMPwNIqmQ0Mu/5I=;
 b=mR4eyDPNSOuKWnBE7pQJ6V2ikI4xM62BHjEZ+PHPm/kCqgocEMhVvv+c8u5UN4VvzS2EPSWDNngfqItOPlMWjZAqY1tlmOYkF5W7+1W9g0RCFQ84mMsVCcPg4zbxSmR9f9HFYxkzrRV53fi8dlPsbG6CB8C0cEeVG3JudCIDalggQ0htlngE9jduTjZNonJNOSlFlV6SYKfw4nvONEz1L6vHZj7Va3gcbSjpaqJWnRQAqZXzMfu8VOu8f39OGiYgTpPHX7dqVgPCc2bJV+rQKcGsFHWxiPL+PSH9x0eokC27nnFWBT5wa2VN4K26ZNPFEHMe5gXtMS9p9idrjdl5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALSJf63g6EOqbxWBGxPBCqT5/sgAAMPwNIqmQ0Mu/5I=;
 b=v1qY3GbOHXBOI/AGsKo6RLIfZRRdewvjASYPHaCNJWI3KGJJgFiAadIOD6mfMcQUd+EOVp+fQrEgw0VKv9HvX4/P9twKnOx6fGWJ1eGbiWJpn3Vq9pj7H5ILu9ZwxIpCZY4Ifh2eEnGyd/WnnmLHrhbQPZqCMr3zUJbfJg7CCAw=
Received: from BN9PR03CA0154.namprd03.prod.outlook.com (2603:10b6:408:f4::9)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 16:18:34 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::a3) by BN9PR03CA0154.outlook.office365.com
 (2603:10b6:408:f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
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
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:32 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Oct
 2025 11:18:32 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:30 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: [PATCH v3 1/6] hw/core/register: remove the REGISTER device type
Date: Fri, 17 Oct 2025 18:18:00 +0200
Message-ID: <20251017161809.235740-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c80a4e-9b17-497a-ee8b-08de0d98d1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47Ur9laQrmdOpLt1sToPvx43TSDvbG+Z4w29+BqZdhejt/FoI4rWCkwquhTa?=
 =?us-ascii?Q?9ihQsLdsBxAwcPrd3InjGcJ11gl1inOPen0p2TFW1R3gtkhbthxuTfhQ488x?=
 =?us-ascii?Q?fR0yMsd2is7kQYXekFwqy1Ry3cMG64feuH/zaj8pwGUpMCySsw/x4KIRLhei?=
 =?us-ascii?Q?1zFKYj0HOpxaGGbl47lgzonx1EU2eqjIXANLBEUjqGEoOSAroU7LGdqJjo/n?=
 =?us-ascii?Q?sGy6XM8qgcxIHZbz/sR1Iva1Ake9SZpoRYt5p+kjjgMzTDKh/HbmQMX7OW6r?=
 =?us-ascii?Q?7TIFbYS/+3IVx0LB0RipJP18W9gQAsfSdd/fJdc9VT7fa0JF87YmJgItpQzq?=
 =?us-ascii?Q?J4Q59i0CBpJeT07w+6J2B99ZNq1Q3CFzGGtnkyAiydmz4yeXMePb8LtQx+C7?=
 =?us-ascii?Q?Iy0tUToDNdJeg+t0H/M6f6sRJqvbHA8odnt9pSkRTeCMWTImQB+dKoPaZCJe?=
 =?us-ascii?Q?GxKODFnSraaDvI+u7p6sYcKoij5cCSiTec96813quWcX30oMGQgO1zMA/FfT?=
 =?us-ascii?Q?txRroder6NW2LJ+osH81hq6rv5sQbzr0Td00vmH8lZ3+MNmE7SyStIP7C/eX?=
 =?us-ascii?Q?4J9ZhXZgkRiCXIW5qnQ9mTnGgVBJGK/dy2c0nczgkz2h5cVNRGSZu9Yi9P+h?=
 =?us-ascii?Q?iIpGGX5X7FkqqpAD2t7LPuHYVB2gmPbnCGs5SMkLlbuFSoj9KXjTbpYQ/Lev?=
 =?us-ascii?Q?0JE2hc70rN+GRwNPEJtV0+xSFxjkYOHpwf7V9/t5waxo/2iTad0m9dbK1Doh?=
 =?us-ascii?Q?3uEEGdf3SKl9ytoJzdjn0gJtP2OAA47SN+6HdEkQp6B6PMfAencnJ/Q0/PS2?=
 =?us-ascii?Q?LId4P8riceutph11EW77kHwQDYznQqneDkpSHk+ihHWRhY+93bsq18eDYak2?=
 =?us-ascii?Q?py02ywsfuvEjU91CGqxKRJ5Wo9fgVA2m0ATL4+vBnHXEgER/sKekDkfTOTDJ?=
 =?us-ascii?Q?9uiz7GLkpvgL3t6iGCnoe/K/7zKYmhvkz5T/iwQxocDcvhKhnjeg/6qwGawa?=
 =?us-ascii?Q?IzeeGN0C2l8DwtNNFjo/G+WUm4wcqDhyae1Dy3Fa0+JrXSZD0R8nB3LabSLV?=
 =?us-ascii?Q?Uu5J1JmuYEuzYuM9jQPT7a0PcSoRM4OFmDimgiXAzcRDktqKVZPeM28URPTm?=
 =?us-ascii?Q?L2lY9MANWmOuL5RISzkXgj9Turz+Wyieycnr7Vn9zsMXdUSACqteppgqbTDS?=
 =?us-ascii?Q?anVWTBPBh4K5/Fk1sOkGV/NAWBizz4A6uBoUG+pJLZFyUJcMrqHqaR0Co9He?=
 =?us-ascii?Q?09Ic576R5excalfL8sCMzO27OmU71uriJULbMvLyTtQGf4fdOOM/LF+GRdS6?=
 =?us-ascii?Q?KGQ+DRkPakqRm3c1IWJX+lVddrXYzCndEqf8a8Vb7NRxG9IUWLmEhNx07FXq?=
 =?us-ascii?Q?zsbvpi2aW8/TCfuFf+zU6j9QwDcWM3TY5fOJ8u1fKUVePeu8Ih5jPQzyyVud?=
 =?us-ascii?Q?GBej9Hkq1fHlWBDHVmfZq/vrVzzU+PzfziH5Jl2zsXBltENVbybmclwgiS2Y?=
 =?us-ascii?Q?MxiShpV7wILAAKu0MM/hjYhgxrwrY80LEBmiHpWG40NiNZy97H2aPrwpCdkb?=
 =?us-ascii?Q?jpj1vmjZqYwCsC4T4V8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:34.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c80a4e-9b17-497a-ee8b-08de0d98d1f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The REGISTER class (RegisterInfo struct) is currently a QOM type
inheriting from DEVICE. This class has no real purpose:
   - the qdev API is not used,
   - according to the comment preceding it, the object_initialize call
     is here to zero-initialize the struct. However all the effective
     struct attributes are then initialized explicitly.
   - the object is never parented.

This commits drops the REGISTER QOM type completely, leaving the
RegisterInfo struct as a bare C struct.

The register_register_types function is left empty here because it is
reused in the next commit.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h          |  7 -------
 hw/core/register.c             | 18 ------------------
 hw/net/can/xlnx-versal-canfd.c |  2 --
 3 files changed, 27 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index a913c52aee5..4d13ea183c7 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -73,25 +73,18 @@ struct RegisterAccessInfo {
  *
  * @opaque: Opaque data for the register
  */
 
 struct RegisterInfo {
-    /* <private> */
-    DeviceState parent_obj;
-
-    /* <public> */
     void *data;
     int data_size;
 
     const RegisterAccessInfo *access;
 
     void *opaque;
 };
 
-#define TYPE_REGISTER "qemu-register"
-DECLARE_INSTANCE_CHECKER(RegisterInfo, REGISTER,
-                         TYPE_REGISTER)
 
 /**
  * This structure is used to group all of the individual registers which are
  * modeled using the RegisterInfo structure.
  *
diff --git a/hw/core/register.c b/hw/core/register.c
index 3340df70b06..2553cb15aba 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -256,13 +256,10 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
 
     for (i = 0; i < num; i++) {
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        /* Init the register, this will zero it. */
-        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
-
         /* Set the properties of the register */
         r->data = data + data_size * index;
         r->data_size = data_size;
         r->access = &rae[i];
         r->opaque = owner;
@@ -316,26 +313,11 @@ void register_finalize_block(RegisterInfoArray *r_array)
 {
     g_free(r_array->r);
     g_free(r_array);
 }
 
-static void register_class_init(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    /* Reason: needs to be wired up to work */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo register_info = {
-    .name  = TYPE_REGISTER,
-    .parent = TYPE_DEVICE,
-    .class_init = register_class_init,
-    .instance_size = sizeof(RegisterInfo),
-};
 
 static void register_register_types(void)
 {
-    type_register_static(&register_info);
 }
 
 type_init(register_register_types)
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 343348660b5..99bbdd7d3fe 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1866,12 +1866,10 @@ static int canfd_populate_regarray(XlnxVersalCANFDState *s,
 
     for (i = 0; i < num_rae; i++) {
         int index = rae[i].addr / 4;
         RegisterInfo *r = &s->reg_info[index];
 
-        object_initialize(r, sizeof(*r), TYPE_REGISTER);
-
         *r = (RegisterInfo) {
             .data = &s->regs[index],
             .data_size = sizeof(uint32_t),
             .access = &rae[i],
             .opaque = OBJECT(s),
-- 
2.51.0


