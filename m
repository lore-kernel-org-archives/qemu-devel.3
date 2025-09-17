Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6652CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqhB-0002KN-JM; Wed, 17 Sep 2025 07:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbJ-0002l7-Af; Wed, 17 Sep 2025 07:45:38 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbF-0001qB-Ox; Wed, 17 Sep 2025 07:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxuuDhOcm2fBuFkLqC9o1P58yFSqWl+6wRm0OXvH0pzNPcmJQTIp4tXag7IvIrGjX56AeGK7trWvVqkIvowIIzh9uq1n4xVr5PrBIiv8aHSN1u6zCLOC8jbUyGyzkCrxPqV8y1h+ZaNq+2xk3+RKeLSpvR+v/396rSph6F2iqGRMwrENSGpwjWqb17pztKWLmVUEsCBfhAfWqD5blbiXJYgk0qGOgyABa6B8Xu1po/4wqR7KcCqx5AkmuReCeM0+mRSswsf3+50127r3wnAaDcCXo4/CrW4NP/inDFtyVDvL5Znhq+SuiFmj7M/JOlQGI96aHp0J1jg55WXBxi5olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMOpl3qNEntTC54I0UrCVD134WsVhW0KTLcb3rE4Rpc=;
 b=y5o+kBCjs/gmqWLcP6qQWUvaqFQDqYDf0thgOHokvJ4Qg7/1GF/YA+Z7pZ24tpZMRm1tfEGubzKMHXOf6z/RcxqKkCrbJWCn19bxZfrjXV+vFMN16dchWydjuw5ypV0cqtPLQEZe0AhAb0nfYKm4lU6SQRaOJ7rnPNAUm5dsKzZaXYfHgjbyK9dCcPxYKL3MEhEW3fqLe2lp/QNNEBi93cdTR9Vsg+IBc62+Wx9XA7930yqKCn6B5q5QaZThmfVrG0g5DLUW1Sj1qrOwDoC39kuhZVd3w9bjalwLQqbIUuaAbirdSJvDgSx4uX6vDtYO03gmMc95gGdQu4VkwxYHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMOpl3qNEntTC54I0UrCVD134WsVhW0KTLcb3rE4Rpc=;
 b=jIsU4ZeB47CoXP3AMGVIC6k06V60B2f6Dlg1dOUzL7mG45wDgL4YJn+34FjyW7eucKOVMTd1t50HusXqFSza2ov6H0uCiIyHauGm1ZVTqN0sIeAa+DGz3HXTKTDHCnv87aa7ovSktntLToaAzJSRVjqMRxOW3vAF0VOOyhi6MCU=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:45:20 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::e8) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 11:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:11 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:10 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 7/7] hw/net/can/xlnx-versal-canfd: remove register API usage
 for banked regs
Date: Wed, 17 Sep 2025 13:44:48 +0200
Message-ID: <20250917114450.175892-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc04aef-e632-4d92-ddc9-08ddf5dfad6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EYhY3iqSzpUCCx1Wm7Cunx8wLbslHh3jnrDSzmGebR4ZTKm/jHWR4ifse6yM?=
 =?us-ascii?Q?HNV04wwdIfWyVfBJZjkS2Y9ih8We+9R+CiR+GwMOE5FSClfK40oo06Kv3z40?=
 =?us-ascii?Q?0piS0VKcIhdX5LlVu0wxMqSnOZSEbO7MlBcZfpSR+UZxeVm8I4R35MA3OKa9?=
 =?us-ascii?Q?l5NWG+RakH/atrMWlnepfq8wOXewHxYzOlVYRRhFd3ul7OMSDtfS2Zy6+vj9?=
 =?us-ascii?Q?5dI36bg61uyls1MVRJ/QtGLBmJTtVtvmqROi3GfoeGpxVfMTTx5a5uEaKoYb?=
 =?us-ascii?Q?P7hPn/Ly1zyQcfcCH6qtbCO9pRNLlWrBLvd4N23Ko77rQk6Z7PJ4NHxdOaVF?=
 =?us-ascii?Q?NepNLgkRuHGTxVreNJzmXEj9SmX5O0i+EAvd7LXyJFVQWXeOn3d8D2b0Nauu?=
 =?us-ascii?Q?gENq7KA0x8HYIFR2X1brKGo1dNK6D2CVak9f+3Ktg9GIig3Oot775eA+gIM+?=
 =?us-ascii?Q?/W1pvMu4j5IAZmcCuIZcZ1SHk11SZd7nDf22cCmZ3hoZDPwy0aQ5K9OvFOrG?=
 =?us-ascii?Q?zM7+4i0Hx7j4rF6AnQf5bMi1zJKYO2iEgYEDI40GYAq216TDK9pGEBsVFDAB?=
 =?us-ascii?Q?99pjt06vF27mUcp4Hka9LE1+q5BZIixge7uSTX/S5NBhpjemC+jzOLg8kZZg?=
 =?us-ascii?Q?3EngnlLu5/3/AgfRKdLfkMTqpOxuHIMbsYqtgNHPUipCFgouqoGcSRXM78ra?=
 =?us-ascii?Q?/2guN+X8MgxuajEStkpBZWpK2HNoralGfTHzahkprdJFJQH9+L/PWoEk3OPD?=
 =?us-ascii?Q?yc5JU0mzH9fgG161qTHZ7g7Y7Z6+bayDknWFdA4pASK9M6WH4mozl+zvgOK7?=
 =?us-ascii?Q?+he1WDDchjFFbU0OPYEtL1ybxST/ScRD8Uy1kiLiTrbusG0oyCLFH5pX1XEx?=
 =?us-ascii?Q?TIi+RyKNkQq5KnB8MDS8zc9qdkZUrat9oNA+zt1RBV/INbKkesWNTe2XS4j5?=
 =?us-ascii?Q?R4JlSNS4Efoyjpo6c1n5MrcBcNFph8LEiFNrZv6AphMyZCNsEYDtEdbn6sDd?=
 =?us-ascii?Q?WrQjaKZGk+a8dkhn9V/sx6mB70aZ0ZR9eNmdHbqrVO5771GAEH3O4+dkk19S?=
 =?us-ascii?Q?JlRDh+jSzW8JmizTfbDh17WhvN3iv3TNjEVmqAG2g8u5optS63QnVNV7xGjI?=
 =?us-ascii?Q?jHEvA/mvkPP2WiwXB8MII30aFgW6zC+7al5K1I4YXFI8O1fMzTMkZSu8e02d?=
 =?us-ascii?Q?sz9nGdXV2YZO4TGONE+6oox1UeqJ0keycSDFqJjsu9CXQ6SI3X44ju8CzBb/?=
 =?us-ascii?Q?RHmUAsFySUo5QbAvDXz3uEgGkONWmMvDPttt7FCAiWeo31Am9DjRKANDiJed?=
 =?us-ascii?Q?mlxApW304NvNzKB2QbgBfU963xMsRtkPnJkhb4wbdQc2LoR2VBK4JUoE23B0?=
 =?us-ascii?Q?SBaYyrNx3YvPFz/k4o2w30hDHYAbFb9AnP/K+3hKUtl9ndKit2zoNt5iGhg+?=
 =?us-ascii?Q?mJqz8QeDr69iVjRfFi1NaDTA6XddebrYmwN3/pssTT5Ss0oCj3N4paXFKQRQ?=
 =?us-ascii?Q?liF8L/9yYgVXlYaPPWiQVKPPax4bstmZbNxY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:19.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc04aef-e632-4d92-ddc9-08ddf5dfad6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Luc.Michel@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Now that we have a simple decoding logic for all the banked registers,
remove the register API usage for them. This restricts the register API
usage to only the base registers (from 0x0 to 0xec).

This also removes all the custom code that was creating register
descriptors for the register API and was leading to memory leaks when
the device was finalized.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/net/xlnx-versal-canfd.h |   8 -
 hw/net/can/xlnx-versal-canfd.c     | 295 +----------------------------
 2 files changed, 5 insertions(+), 298 deletions(-)

diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index ad3104dd13f..396f90d6dc1 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -52,18 +52,10 @@ typedef struct XlnxVersalCANFDState {
 
     qemu_irq                irq_canfd_int;
     qemu_irq                irq_addr_err;
 
     RegisterInfo            reg_info[XLNX_VERSAL_CANFD_R_MAX];
-    RegisterAccessInfo      *tx_regs;
-    RegisterAccessInfo      *rx0_regs;
-    RegisterAccessInfo      *rx1_regs;
-    RegisterAccessInfo      *af_regs;
-    RegisterAccessInfo      *txe_regs;
-    RegisterAccessInfo      *rx_mailbox_regs;
-    RegisterAccessInfo      *af_mask_regs_mailbox;
-
     uint32_t                regs[XLNX_VERSAL_CANFD_R_MAX];
 
     ptimer_state            *canfd_timer;
 
     CanBusClientState       bus_client;
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 81615bc52a6..49f1b174b70 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1425,50 +1425,10 @@ static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
                       HWADDR_PRIx " changed while filter %zu enabled\n",
                       path, addr, bank_idx + 1);
     }
 }
 
-static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
-    uint32_t reg_idx = (reg->access->addr) / 4;
-    uint32_t val = val64;
-    uint32_t filter_offset = (reg_idx - R_AFMR_REGISTER) / 2;
-
-    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
-        (1 << filter_offset))) {
-        s->regs[reg_idx] = val;
-    } else {
-        g_autofree char *path = object_get_canonical_path(OBJECT(s));
-
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
-                      path, filter_offset + 1);
-    }
-
-    return s->regs[reg_idx];
-}
-
-static uint64_t filter_id(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
-    hwaddr reg_idx = (reg->access->addr) / 4;
-    uint32_t val = val64;
-    uint32_t filter_offset = (reg_idx - R_AFIR_REGISTER) / 2;
-
-    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
-        (1 << filter_offset))) {
-        s->regs[reg_idx] = val;
-    } else {
-        g_autofree char *path = object_get_canonical_path(OBJECT(s));
-
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
-                      path, filter_offset + 1);
-    }
-
-    return s->regs[reg_idx];
-}
-
 static uint64_t canfd_tx_fifo_status_prew(RegisterInfo *reg, uint64_t val64)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
     uint32_t val = val64;
     uint8_t read_ind = 0;
@@ -1590,129 +1550,10 @@ static uint64_t canfd_write_check_prew(RegisterInfo *reg, uint64_t val64)
         return val;
     }
     return 0;
 }
 
-static const RegisterAccessInfo canfd_tx_regs[] = {
-    {   .name = "TB_ID_REGISTER",  .addr = A_TB_ID_REGISTER,
-    },{ .name = "TB0_DLC_REGISTER",  .addr = A_TB0_DLC_REGISTER,
-    },{ .name = "TB_DW0_REGISTER",  .addr = A_TB_DW0_REGISTER,
-    },{ .name = "TB_DW1_REGISTER",  .addr = A_TB_DW1_REGISTER,
-    },{ .name = "TB_DW2_REGISTER",  .addr = A_TB_DW2_REGISTER,
-    },{ .name = "TB_DW3_REGISTER",  .addr = A_TB_DW3_REGISTER,
-    },{ .name = "TB_DW4_REGISTER",  .addr = A_TB_DW4_REGISTER,
-    },{ .name = "TB_DW5_REGISTER",  .addr = A_TB_DW5_REGISTER,
-    },{ .name = "TB_DW6_REGISTER",  .addr = A_TB_DW6_REGISTER,
-    },{ .name = "TB_DW7_REGISTER",  .addr = A_TB_DW7_REGISTER,
-    },{ .name = "TB_DW8_REGISTER",  .addr = A_TB_DW8_REGISTER,
-    },{ .name = "TB_DW9_REGISTER",  .addr = A_TB_DW9_REGISTER,
-    },{ .name = "TB_DW10_REGISTER",  .addr = A_TB_DW10_REGISTER,
-    },{ .name = "TB_DW11_REGISTER",  .addr = A_TB_DW11_REGISTER,
-    },{ .name = "TB_DW12_REGISTER",  .addr = A_TB_DW12_REGISTER,
-    },{ .name = "TB_DW13_REGISTER",  .addr = A_TB_DW13_REGISTER,
-    },{ .name = "TB_DW14_REGISTER",  .addr = A_TB_DW14_REGISTER,
-    },{ .name = "TB_DW15_REGISTER",  .addr = A_TB_DW15_REGISTER,
-    }
-};
-
-static const RegisterAccessInfo canfd_rx0_regs[] = {
-    {   .name = "RB_ID_REGISTER",  .addr = A_RB_ID_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DLC_REGISTER",  .addr = A_RB_DLC_REGISTER,
-        .ro = 0xfe1fffff,
-    },{ .name = "RB_DW0_REGISTER",  .addr = A_RB_DW0_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW1_REGISTER",  .addr = A_RB_DW1_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW2_REGISTER",  .addr = A_RB_DW2_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW3_REGISTER",  .addr = A_RB_DW3_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW4_REGISTER",  .addr = A_RB_DW4_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW5_REGISTER",  .addr = A_RB_DW5_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW6_REGISTER",  .addr = A_RB_DW6_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW7_REGISTER",  .addr = A_RB_DW7_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW8_REGISTER",  .addr = A_RB_DW8_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW9_REGISTER",  .addr = A_RB_DW9_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW10_REGISTER",  .addr = A_RB_DW10_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW11_REGISTER",  .addr = A_RB_DW11_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW12_REGISTER",  .addr = A_RB_DW12_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW13_REGISTER",  .addr = A_RB_DW13_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW14_REGISTER",  .addr = A_RB_DW14_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW15_REGISTER",  .addr = A_RB_DW15_REGISTER,
-        .ro = 0xffffffff,
-    }
-};
-
-static const RegisterAccessInfo canfd_rx1_regs[] = {
-    {   .name = "RB_ID_REGISTER_1",  .addr = A_RB_ID_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DLC_REGISTER_1",  .addr = A_RB_DLC_REGISTER_1,
-        .ro = 0xfe1fffff,
-    },{ .name = "RB0_DW0_REGISTER_1",  .addr = A_RB0_DW0_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW1_REGISTER_1",  .addr = A_RB_DW1_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW2_REGISTER_1",  .addr = A_RB_DW2_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW3_REGISTER_1",  .addr = A_RB_DW3_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW4_REGISTER_1",  .addr = A_RB_DW4_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW5_REGISTER_1",  .addr = A_RB_DW5_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW6_REGISTER_1",  .addr = A_RB_DW6_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW7_REGISTER_1",  .addr = A_RB_DW7_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW8_REGISTER_1",  .addr = A_RB_DW8_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW9_REGISTER_1",  .addr = A_RB_DW9_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW10_REGISTER_1",  .addr = A_RB_DW10_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW11_REGISTER_1",  .addr = A_RB_DW11_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW12_REGISTER_1",  .addr = A_RB_DW12_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW13_REGISTER_1",  .addr = A_RB_DW13_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW14_REGISTER_1",  .addr = A_RB_DW14_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW15_REGISTER_1",  .addr = A_RB_DW15_REGISTER_1,
-        .ro = 0xffffffff,
-    }
-};
-
-/* Acceptance filter registers. */
-static const RegisterAccessInfo canfd_af_regs[] = {
-    {   .name = "AFMR_REGISTER",  .addr = A_AFMR_REGISTER,
-        .pre_write = filter_mask,
-    },{ .name = "AFIR_REGISTER",  .addr = A_AFIR_REGISTER,
-        .pre_write = filter_id,
-    }
-};
-
-static const RegisterAccessInfo canfd_txe_regs[] = {
-    {   .name = "TXE_FIFO_TB_ID_REGISTER",  .addr = A_TXE_FIFO_TB_ID_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "TXE_FIFO_TB_DLC_REGISTER",  .addr = A_TXE_FIFO_TB_DLC_REGISTER,
-        .ro = 0xffffffff,
-    }
-};
-
 static const RegisterAccessInfo canfd_regs_info[] = {
     {   .name = "SOFTWARE_RESET_REGISTER",  .addr = A_SOFTWARE_RESET_REGISTER,
         .pre_write = canfd_srr_pre_write,
     },{ .name = "MODE_SELECT_REGISTER",  .addr = A_MODE_SELECT_REGISTER,
         .pre_write = canfd_msr_pre_write,
@@ -2001,146 +1842,20 @@ static int xlnx_canfd_connect_to_bus(XlnxVersalCANFDState *s,
     s->bus_client.info = &canfd_xilinx_bus_client_info;
 
     return can_bus_insert_client(bus, &s->bus_client);
 }
 
-#define NUM_REG_PER_AF      ARRAY_SIZE(canfd_af_regs)
-#define NUM_AF              32
-#define NUM_REG_PER_TXE     ARRAY_SIZE(canfd_txe_regs)
-#define NUM_TXE             32
-
-static int canfd_populate_regarray(XlnxVersalCANFDState *s,
-                                  RegisterInfoArray *r_array, int pos,
-                                  const RegisterAccessInfo *rae,
-                                  int num_rae)
-{
-    int i;
-
-    for (i = 0; i < num_rae; i++) {
-        int index = rae[i].addr / 4;
-        RegisterInfo *r = &s->reg_info[index];
-
-        object_initialize(r, sizeof(*r), TYPE_REGISTER);
-
-        *r = (RegisterInfo) {
-            .data = &s->regs[index],
-            .data_size = sizeof(uint32_t),
-            .access = &rae[i],
-            .opaque = OBJECT(s),
-        };
-
-        r_array->r[i + pos] = r;
-    }
-    return i + pos;
-}
-
-static void canfd_create_rai(RegisterAccessInfo *rai_array,
-                                const RegisterAccessInfo *canfd_regs,
-                                int template_rai_array_sz,
-                                int num_template_to_copy)
-{
-    int i;
-    int reg_num;
-
-    for (reg_num = 0; reg_num < num_template_to_copy; reg_num++) {
-        int pos = reg_num * template_rai_array_sz;
-
-        memcpy(rai_array + pos, canfd_regs,
-               template_rai_array_sz * sizeof(RegisterAccessInfo));
-
-        for (i = 0; i < template_rai_array_sz; i++) {
-            const char *name = canfd_regs[i].name;
-            uint64_t addr = canfd_regs[i].addr;
-            rai_array[i + pos].name = g_strdup_printf("%s%d", name, reg_num);
-            rai_array[i + pos].addr = addr + pos * 4;
-        }
-    }
-}
-
-static RegisterInfoArray *canfd_create_regarray(XlnxVersalCANFDState *s)
-{
-    const char *device_prefix = object_get_typename(OBJECT(s));
-    uint64_t memory_size = XLNX_VERSAL_CANFD_R_MAX * 4;
-    int num_regs;
-    int pos = 0;
-    RegisterInfoArray *r_array;
-
-    num_regs = ARRAY_SIZE(canfd_regs_info) +
-                s->cfg.tx_fifo * NUM_REGS_PER_MSG_SPACE +
-                s->cfg.rx0_fifo * NUM_REGS_PER_MSG_SPACE +
-                NUM_AF * NUM_REG_PER_AF +
-                NUM_TXE * NUM_REG_PER_TXE;
-
-    s->tx_regs = g_new0(RegisterAccessInfo,
-                        s->cfg.tx_fifo * ARRAY_SIZE(canfd_tx_regs));
-
-    canfd_create_rai(s->tx_regs, canfd_tx_regs,
-                     ARRAY_SIZE(canfd_tx_regs), s->cfg.tx_fifo);
-
-    s->rx0_regs = g_new0(RegisterAccessInfo,
-                         s->cfg.rx0_fifo * ARRAY_SIZE(canfd_rx0_regs));
-
-    canfd_create_rai(s->rx0_regs, canfd_rx0_regs,
-                     ARRAY_SIZE(canfd_rx0_regs), s->cfg.rx0_fifo);
-
-    s->af_regs = g_new0(RegisterAccessInfo,
-                        NUM_AF * ARRAY_SIZE(canfd_af_regs));
-
-    canfd_create_rai(s->af_regs, canfd_af_regs,
-                     ARRAY_SIZE(canfd_af_regs), NUM_AF);
-
-    s->txe_regs = g_new0(RegisterAccessInfo,
-                         NUM_TXE * ARRAY_SIZE(canfd_txe_regs));
-
-    canfd_create_rai(s->txe_regs, canfd_txe_regs,
-                     ARRAY_SIZE(canfd_txe_regs), NUM_TXE);
-
-    if (s->cfg.enable_rx_fifo1) {
-        num_regs += s->cfg.rx1_fifo * NUM_REGS_PER_MSG_SPACE;
-
-        s->rx1_regs = g_new0(RegisterAccessInfo,
-                             s->cfg.rx1_fifo * ARRAY_SIZE(canfd_rx1_regs));
-
-        canfd_create_rai(s->rx1_regs, canfd_rx1_regs,
-                         ARRAY_SIZE(canfd_rx1_regs), s->cfg.rx1_fifo);
-    }
-
-    r_array = g_new0(RegisterInfoArray, 1);
-    r_array->r = g_new0(RegisterInfo * , num_regs);
-    r_array->num_elements = num_regs;
-    r_array->prefix = device_prefix;
-
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  canfd_regs_info,
-                                  ARRAY_SIZE(canfd_regs_info));
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->tx_regs, s->cfg.tx_fifo *
-                                  NUM_REGS_PER_MSG_SPACE);
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->rx0_regs, s->cfg.rx0_fifo *
-                                  NUM_REGS_PER_MSG_SPACE);
-    if (s->cfg.enable_rx_fifo1) {
-        pos = canfd_populate_regarray(s, r_array, pos,
-                                      s->rx1_regs, s->cfg.rx1_fifo *
-                                      NUM_REGS_PER_MSG_SPACE);
-    }
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->af_regs, NUM_AF * NUM_REG_PER_AF);
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->txe_regs, NUM_TXE * NUM_REG_PER_TXE);
-
-    memory_region_init_io(&r_array->mem, OBJECT(s), &canfd_ops, r_array,
-                          device_prefix, memory_size);
-    return r_array;
-}
-
 static void canfd_realize(DeviceState *dev, Error **errp)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(dev);
     RegisterInfoArray *reg_array;
 
-    reg_array = canfd_create_regarray(s);
+    reg_array = register_init_block32(dev, canfd_regs_info,
+                                      ARRAY_SIZE(canfd_regs_info), s->reg_info,
+                                      s->regs, &canfd_regs_ops, false,
+                                      A_RX_FIFO_WATERMARK_REGISTER
+                                          + sizeof(uint32_t));
     memory_region_add_subregion(&s->iomem, 0x00, &reg_array->mem);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq_canfd_int);
 
     if (s->canfdbus) {
-- 
2.50.1


