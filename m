Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7989ECA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqfb-0007qy-E5; Wed, 17 Sep 2025 07:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb7-0002hn-GA; Wed, 17 Sep 2025 07:45:33 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb3-0001ot-7b; Wed, 17 Sep 2025 07:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoMbhzZWO3PQwExDN9jKlkc4TKHeIxvEZWJugGCdN/82PJWF4eDJY0FjCGavqMxDRZgv7gRViUMoxEauXUDOPrtTSjD6TmRCiD/VQW0iO78NJYZ92yuslvU18tZAgCVzOZS1ml9iJ1M2xMbmBhiMnlkBJw7OZdXVQ2wJWvDO4l/Uk+T4tHBTbnC8ygmB6lu13FjgZX1ArlRiLbcEZ0Ke1/DOK3miwJ8UrZPiS14Jh0W5X/qqmWKIiAuIs3gVepgTPkv66YUVg3HOjzDqgQrEd4iJ5XXCjWb+p66uzFfLldAqAixEGT4HpcWCc0Yybcjy7ZKD+ZWOByncOK41O2woGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVc7wjetViZwJPd+5rpxt1GwQ+s9787iGXNojg/TB7Q=;
 b=VVBCDUBMLwxjWMbtYhgIQ4wzdHWVaGtnezappheE3RQnf66o6heeOxT+B8jRzqvFgOSXC7N9pfmq//80HgYaSXKW4w8y/dxMRTAzegVs+nU3UlmxCXjn1qVGAmsvMeMe8DZ1oEKli9sgMcnjGZFkxxEXPpSuxQoKfst35Ds/SNkygdOANOTx1cttbanUkrEdCj9CEATk5dHpR6jSFYn/I+t0+wQXn57G4P9t3NvhUGAlNTKyceKiEfx/SUbtVijyt/lWzmrF8nGJw1LFqpQRcLiA3rIpygjh5JSkWxA9vYHG1Nr5GR3soFrXYnqEda3e8z0e4Vf5Dn8qkWKJtKSNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVc7wjetViZwJPd+5rpxt1GwQ+s9787iGXNojg/TB7Q=;
 b=wgRcDEykV5rOSlSQ9BwBsEn4zzmr15Y6EOR/ciKC3eCOTzl0Zya6zIPemJZ74OvECaCOmZRsxHrC46E8VUEr/AlXmOQJbjlouTiOiCy024XTBkjxBP2JbtcYFam0+/RVWk1D35wi/mpcfyYFvQn/Ndk6zF3Diz+o6N2xLh4eiHs=
Received: from MN0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:52c::28)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:45:08 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::b1) by MN0PR05CA0015.outlook.office365.com
 (2603:10b6:208:52c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 11:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:02 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:01 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/7] hw/core/register: remove the REGISTER device type
Date: Wed, 17 Sep 2025 13:44:42 +0200
Message-ID: <20250917114450.175892-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 21254d70-36cb-45e6-80e1-08ddf5dfa6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?id1dnHTK6hAbGt3kMgQy8jcrOllz3otrxnC0HHQWA9FUdgEiMeXRwSSgnMYa?=
 =?us-ascii?Q?/GypqW8w+PoLPG1u/UfJZRS7aYM5Fl0apCvwi3QkZESUggguikrOuNVwDpgx?=
 =?us-ascii?Q?fkC8vOJXBEZ7aNuZEBStu72GnKd7QwdGtHGZ+YuRR03BvKlxPg2D6Na5knFp?=
 =?us-ascii?Q?/E0aDxdHQooTaJ3M9R/ArmPN1IHmvPN6SN2F8s0kUOLmQhQwl+hPqQI9oCHA?=
 =?us-ascii?Q?2RPpREukgxzbJCONR/IQGjYsoTAFTutiwMSLg5mmkQMZbrRaQY42v/VUqrLI?=
 =?us-ascii?Q?jDoHWgTNP1/xIyzXByNSweDt+tfS5K5tl2RrVFMv+mUtI4lAqjyt2B5dCu36?=
 =?us-ascii?Q?lRIkES26yj9QidfSILQYC3wwad8iABeGNnP9buZihT+3wTqz3XDonVReViZW?=
 =?us-ascii?Q?tQa6znpoE2G4jzALhSntTQU7zMBFQCqV+jxY/7GSMeXmIsbXqmvU89rJGMC2?=
 =?us-ascii?Q?jQkVKPKNLRkeB+mLM6Ab6JMd8lQTEl60XIR8RE6XDcOXLRjFncYCrci/pjXN?=
 =?us-ascii?Q?TveoM1GkKI6g+PE7jEdoGC/w5FKfFpx8+l8yaB/t27mM0sDA+SJu/lnToORi?=
 =?us-ascii?Q?z9TfPNoynGo4XfaY7uo7vkL+hKwht9XldZGBp0FAtm8AZB/fJ8RW79D4F3bR?=
 =?us-ascii?Q?AdhzQ7FhWLg9sGQ/UVBtjACSSHuPZn9SU+Ea16DKy4cFx1bH/rgjeLOnHuta?=
 =?us-ascii?Q?jUkZtFQiug/aKO+2Tp759+spgjmLj58WGMri6eJoJlKPMQEFQ+LKgwzzGrlS?=
 =?us-ascii?Q?PSMe1rBkTKn7K+BoOicPKQQbmH5ehdrk3cOYQyoXfsCkmppEFY5BIUDIJQE8?=
 =?us-ascii?Q?qLuRhK04ghqVSymz4Ohzu2W5Cgs8O8KFUzKWtWiyqqbfYuKgOWlEQmzFBRgP?=
 =?us-ascii?Q?Zsc4riXcoN2SRPyGMfadb6eMp1iVJ7snu9hXTyNDVdlR5H0t3sNd3kALZjV5?=
 =?us-ascii?Q?wqDSKd/fsLgrns0RPPZVn61IUHrF/zHXctRhVZ7T+98chtUS80dRhBFDU51I?=
 =?us-ascii?Q?BKVPiw04a4Tfru70RV03MzNkuq5QCcpQZSyp6V1THbAbQ9VJTJ+G6IXx8+Zf?=
 =?us-ascii?Q?r6AKNjET0eFv51hizQvkQl33GA8Ftrd1rqCBkTw5WlPsfZYUPPmNaolfoeV3?=
 =?us-ascii?Q?waDXqA+dm4rsCngRSrB/hHqjd9TV7faUA8V+OvmDl2W6B302dHkCJCT1Nqwi?=
 =?us-ascii?Q?NJQSatdCxSMD5XP7nxEQd9vRvNJZr8hTjPYmFBF0CDa1DKB98RB1CUVHQXqn?=
 =?us-ascii?Q?3nsF2IDCR8Ihi7+fjDK5N6zynS7RgIlASXOR2x7odrlPhFikTpJwOwd/EHdO?=
 =?us-ascii?Q?eoUERcy6BHqKHgcPCCKBwTYUf3+3dxBB794urB5WIRKMaGIpj6t56UMeUiNZ?=
 =?us-ascii?Q?s3l5J7AUxpxKdFe1I3xahwR3XL4aCdyaNnddnFH/fcV7aziM3hGaO9R9UsWZ?=
 =?us-ascii?Q?HOhVU09TvEBGxvRLHpYrMzK6XOQ/eXBFskb/DcHJMYxrIxb3rL7wU3ewkTfn?=
 =?us-ascii?Q?7KX/ZrUCxrYzTE6Hvqkrx595oZ6Z6Z+fIuVR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:08.2215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21254d70-36cb-45e6-80e1-08ddf5dfa6df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
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

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h |  7 -------
 hw/core/register.c    | 18 ------------------
 2 files changed, 25 deletions(-)

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
index 8f63d9f227c..57dde29710c 100644
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
@@ -317,26 +314,11 @@ void register_finalize_block(RegisterInfoArray *r_array)
     object_unparent(OBJECT(&r_array->mem));
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
-- 
2.50.1


