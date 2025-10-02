Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3AACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqW-0004la-Nt; Thu, 02 Oct 2025 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqM-0004aW-Pn; Thu, 02 Oct 2025 03:35:14 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq6-0008HS-N4; Thu, 02 Oct 2025 03:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9rZBCnddEFZsdIgvkzRmsG0G3BCmknvFyk5tk7onfz1udLSFDtt3zSzugX3wa1M+hOzXW+XRAUQmOo/zo5JpN+nNdnNidf1DdtnPGzGh3Rz/ed1njaCoaAzvOEA9Nazj9xUQyvEyJBSJn0NZWtJqSt7qC5xDXm9DCINRFAzHBr+0KvjnPVsVyfWQTALWPYROYPsbkuiF+ReIBPr2+BCp4XCwIVjqovlOsW3QnKAIUgMJ4zLkAB50gKaB6V40eWBXYpd3fNooJewbwT9yZSCSd8wfNNjohuakt7Orp8PbjS2bpejYnAaLh/n6xPiz0ZtMVL6Zj1TXjk1rlVySjrQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JRssaRE6Uw5wWT92e7mCMNS/nzxR6wP+/p9K8WAX4I=;
 b=SspxrG8h+befEg/UM/9HJHMM+4d4MgkUn+V7+pi/gVyFEJ+ELfu4nn1/zbKjKgdbrvd+1a3aorgZDRmmHBB0yRIsBh9SQZ8wpayvK1NSa/scBKyYhKSutrIWvhBv+KOWU1uBVIKc1npjhbdn40F8w2/BqbpIB6NJAp8r28W3TntP4zak+Mse402J2+eOYE2/IW74sdVqY/0JGWfidvPwMJAZOy49cTW1OfL4TY4mtDGxlqckGtClt1gtDTaZ+77PykOp3+8Xw9ZzEYxWx+x4VWX06ldl80L9bn4lvVNq2DkcgsgghQDGUq/c1dMl1l1s2rV0SPqZxvT9E6XSLAK6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JRssaRE6Uw5wWT92e7mCMNS/nzxR6wP+/p9K8WAX4I=;
 b=XWDWTFOAlvexAqIjh+Y3vQZSBL1PY5fuKJWcwZCYz+0WfHggXUFGe6mKs3p3FoalUEAa+cyTByHDJwCGDVp5/sW3DlCEwuDxVVF0SnmY+ZN5+4SK7FkOYS6i5x7XSXNRi8dt+Dgm6jetxMyIuNIWsbevoeTqqEyQ2HtFpjzf4hs=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:34:35 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::d4) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Thu,
 2 Oct 2025 07:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:33 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:32 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v2 1/7] hw/core/register: remove the REGISTER device type
Date: Thu, 2 Oct 2025 09:34:10 +0200
Message-ID: <20251002073418.109375-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c61802-bebd-424e-9ecd-08de01862272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UR390xTbmEEFq/buwvJuHQfgLM1THJejA+Gj6xTiTnc0jMi2Vi23wuKGxjZ?=
 =?us-ascii?Q?Iz57t3yNc+B9sSdvxL28fjFszZ0cwLbtceQEtQhBHLpxv1R21PcIGSsMAwxy?=
 =?us-ascii?Q?EG5SCpy9m7sEHSTFKebMeBILTPm04KL2xZmDHYzrFxifBWsFgnhqjQYdGpAY?=
 =?us-ascii?Q?zBLptKtuTizaUaeUQHY502ARFXbkQCjpY6azqo2AYoQ1VNrCe1EVwV09JyUy?=
 =?us-ascii?Q?eS9MEsUZWJHi8k7EoGt4gNtz+pht0wGQTTn4u/NdWAsya3GO3Lc5T+jr2szQ?=
 =?us-ascii?Q?pkNnIoPFzyZEBG7dnxHyWQmkugBVVHVHJ7YvpLWgO9Q5VKblLyIUmokZTzQD?=
 =?us-ascii?Q?DWUBmBRmBaV3wAQFVdkX3nXD7szHbWINd5qX/GhervpSjE9XkqiXbiRZZJUd?=
 =?us-ascii?Q?zL4ZeRQz593o6nKUzdrSjFx7CL+ZYiVrt29OpnM8t5DtBKRSbCz29UrVGWTv?=
 =?us-ascii?Q?MpP0dOwa7wnY/QO1AUl4/OjOpmkbhD3ZbNH92jeT96yduKK3tXDau8oJ++oQ?=
 =?us-ascii?Q?Q11+vmQtQksXAF+NkYx5EKgF99sarUk7cpiutPkU0xHogB2c9oMGznPcLhqZ?=
 =?us-ascii?Q?SV/9AoFTosmhZZRxofc13XiAi+XX9+nPnjrjgxGKKOniUfz4G1T1WfZiBuKE?=
 =?us-ascii?Q?dBuTDQbz/CCPABnlywqyvsI9vv+aBMOuoJOLPdLRVApYXpy2w7bRrrylU3nV?=
 =?us-ascii?Q?sR8KlQVdlbLLA8/TQJeDGnWbECpV1XX6GMuChliiCBXOff77vNqwSdTv6kbw?=
 =?us-ascii?Q?yTdK8+Csduj+GnXM4Kj4RfFwNbfVv8Gdbyg0fNhMF6xq7Briw2kQFPPFm0C6?=
 =?us-ascii?Q?SZ4lXGm30Jj6LwN+Uu4roqQkavioln6jc81ka0dFQD8kIuXMxT/0QY+fdaUD?=
 =?us-ascii?Q?0O/LbnjN5gtEcE/zRK8rV6/0saiNTkIT7lSPfPjwMQGCdCXeqn+1e/NSCcix?=
 =?us-ascii?Q?Zwgdk4PliHLI1XOl75xjdvIbDnJHDkPJUV1nYd3Q2NWGhTWRGurJN7AE8c/y?=
 =?us-ascii?Q?Lq4kjINmIPpD8DKHS7OEBZpFm8MzMG3eTRmBGvEfndtGDf0qvFu82TLOTkS3?=
 =?us-ascii?Q?rEpWMJYjM5ed9ishnZbYpGB7ou85C7Say/UZiHNFRlV80l2VKBn1tIAdR1KS?=
 =?us-ascii?Q?sQeziD/fdd6WcIf3hXFgfQf8t9LpisBfLROT1BDELQ2NXKVRG36eMTsBkapV?=
 =?us-ascii?Q?QbfjfvzXs3BwbSf0gnJA75uQRUCUZo61o0mBY/ub6d9qKFq+vd2sKQimNrMx?=
 =?us-ascii?Q?Xun1zElnnPwTAirTR3MiEmznRyhBtu1CQAmwitryiL/+TIrGXK/EJgRJmlxq?=
 =?us-ascii?Q?mQLgneAaWLdyEgHHfX2yl4lUKJhT60Gm+X0G6BYH4sB8hpuPQoleDv/dwKXp?=
 =?us-ascii?Q?XdqbhEFq6gR3p/qaihK3RQfsVSzfVhabNAuPq5ByY4fScmoLYFHDnlLWXhQl?=
 =?us-ascii?Q?gk3W3h9WxbY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:34.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c61802-bebd-424e-9ecd-08de01862272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
-- 
2.51.0


