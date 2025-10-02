Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AE1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqR-0004fE-A9; Thu, 02 Oct 2025 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqM-0004Z9-Ud; Thu, 02 Oct 2025 03:35:14 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqC-0008I4-Cb; Thu, 02 Oct 2025 03:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDQO6XbOcqCrjNbZhN3tSQlVUx18lc2TY+lrpS4u4zYKYlaYdnQ0UZFfmAga/WIUUTccNHdkyuaON7uwBV3FE67XP0P7swLiPxlaOUNTaiRcMylYjOqZhNwJq2GCiLQdvTpgPDwpKXlt5tgQT53LY+hIHneB0I47mU1jTaSlgWp4wtoWoqdxO22NYQWEFl7ybfckEyHydBFFAxLaOpbtEfesmZ16Knz4zHR4GuPb/h2XRHnnuknF/+ans9b8BOm5PDzRPkGolxO9PgiW5fdVy0Z+lf9UEE42WekTr4pC4F9mqSMyCeXuTNKpstVjpxNGPaS/gH3mriIQRx9RwQaUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq8i8I6MsRVU2bIfdCd37nhdxW+gNSsRxkvnsQUsQKQ=;
 b=IMWlrRrGEQQoRGJmYCl4QfFqKZq+wSZAOp0UIgWX0ET84A5kqPKL9GQ8k3Qd0bbOwQDPI4rYxVY7kAn7SRa8ykp/hJIRg1kyheCJasokhRQqc6zs2wSW+KcVlhv2Hgii0YWWLNtPDCs85veq1PHe1p+NzW2FXSiI/UFwi+nqY5wkNQp94QvWOp63VC4CkHidHwETa8XcUjO/u/wQGfL/Ze0EFwp9+BG9bKRTvKSKKJfvaPdBxjaRy8XflvoL5u93IWsp4VOxDJLmNK5egBSAHWrx/tNYhZNiR8XSuP992DCaQZQP64BYLrQBONXWMiNOzUJsfXNEz8MgBw1uZkxzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq8i8I6MsRVU2bIfdCd37nhdxW+gNSsRxkvnsQUsQKQ=;
 b=U2vWnpXeGn+CojdlFLYnC7tugaR7cTUnkS/zOPWPRSodSqFFix+01PwQkOH3RyT3pntJCP5U/ME5vzuYxEn8o1agZTEapcpIlfsIm5NPuL4vxIJh2Oyp2BRh886ma0K1OR8fhc74Cn3NV7FVTFHvdqRzBu4WmY+X4jVOFdQRELI=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:34:45 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::14) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 07:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:44 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:44 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:42 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>
Subject: [PATCH v2 7/7] hw/net/can/xlnx-versal-canfd: remove register API
 usage for banked regs
Date: Thu, 2 Oct 2025 09:34:16 +0200
Message-ID: <20251002073418.109375-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbfec4c-fa38-4191-df62-08de018628a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xsXIvqiUGGiqXKx0LQ4wTFxUvC6m2cgIOdY0d8v14F/Fhe9YayC5tF/h8iog?=
 =?us-ascii?Q?rGZp6RXFztk0f6IoA9E1C6S3QcjxBAF2GESxaNOQre/3O2EgaKbBQUWQ4erv?=
 =?us-ascii?Q?hJt2THGtHprNvJdcbylVJb/88YdnpFD9bLlAV7mpAFT9/JVFzX561BVcJlWr?=
 =?us-ascii?Q?LwRnhITts3InQnnPbJW1IOjeEyoGvBvAZKk+CtD1iM/CJnmZh9Hj9M7ceobQ?=
 =?us-ascii?Q?vj9lirMIQ8iOMMhTTRkuv7ghY3DueCZBZ9l6dNzq9kpmPONLf2oMmaojze15?=
 =?us-ascii?Q?m18GjdKuWIrPfqGZEBvPGgchifxajaeFdInlMCfv1Qt3c4eq/7MbuXH1VRao?=
 =?us-ascii?Q?0ueh7hTyW5xQTTQK4SPAks7Lk4Gg6HUBzIltv/J1h+9aAyp/9qiTFFOrbapg?=
 =?us-ascii?Q?ulGHVyammaI1TWJbaA14GUBEDJbnfYGves9vES8O+Feii2NnTbOva5bQ45cd?=
 =?us-ascii?Q?+Iuup2Nl+Tw8ecGXUhYbWHoThtbg88V646qfpegR0Y0IKBCpgPZixcFIt45K?=
 =?us-ascii?Q?J0o6NAS1OVLH4oStCkjsXM4fc4AChTP3YW0eVvXeFPPtgyFn2siZDIIn+TDB?=
 =?us-ascii?Q?SKfriNbIbej5WBP6SLY8bD5Uww+seA0NZNjfz2o6KM6dN+ii2OhmhUREnQJ1?=
 =?us-ascii?Q?FA2AhbV1Iapk3+dWV/HsDsIearcu5KQjxd/VX9EILJTFYa/c++1Egamigg7e?=
 =?us-ascii?Q?dxKE0+AL6B0HwMqQeCS6W8+3b5GbA4kJaIxr6OWL0t8tb8Kgx/rWgFP+yFxW?=
 =?us-ascii?Q?uEPuKZtXEabI1L25CnfdPKwDfWmhkvucIHoTW3g1CsQDjDzNVLz8o62jZPPA?=
 =?us-ascii?Q?eytaIKxZQBpADi1ybRVVd7kMLNtzBTofxgW1MHRa0B1NrT7P075DtpFJ5JcQ?=
 =?us-ascii?Q?FRHaMApWdfel/mmc1bE6qPbq2U0MA46IWL37a3WC5axSuNlmls5Fj2oLbPoN?=
 =?us-ascii?Q?TQLMq4nM7v5YpU8DhLmyNW3/sHS837vdah4zbvwriVII3NcSU3IoqISftsHT?=
 =?us-ascii?Q?OaFoaAI52/Ey7Ye+GGPEtCKJtKu6KaUi9ArArw8haJffG3sh+MiZipQyLtTQ?=
 =?us-ascii?Q?UIRbpIpqfRPLSm6m4YyyPEkUv/VAmkZlp8SBOrMs69RctJiIIpZvssMYTMLc?=
 =?us-ascii?Q?FzEz3rL8jJ81BcDKw9aOUG6cheXrIcHMROKBWg/8VrYBbMOho4REzV+2HLIz?=
 =?us-ascii?Q?K0q2VzTulR1XTRusdxAFxKxcv8RXdwiF2j3EZUgwTXOcJd4Mv0l/gx95qBAk?=
 =?us-ascii?Q?fVd601zF/J5IxyvkybvH9VwE05n6asNksxdANumXjLiPcyDLZHFcQe97t8qa?=
 =?us-ascii?Q?8oIOQ6dkZLcUAVx7726OTxIUMjZ3ZGO6jnQ+kfe2AfxMg6qAMNeK1WfBVdzd?=
 =?us-ascii?Q?WfxF8Z09qwgUeYBsGY6SJW3HroG+xRUqlo8ZUeKjG6iR6SraRtlzgPWbdmEO?=
 =?us-ascii?Q?bVNESxaFlyk1LrLlkIC5BRLUrr1wjtl54wktScdjP2UQ9xZ4KzxlOuDBht0+?=
 =?us-ascii?Q?rCgnUT1fNn6EJeupS4QVnKk33pW9aYEXBGp7ks9tlOafI0d+XlaKfAG66hB/?=
 =?us-ascii?Q?FEH0yIfxucqwiAVlBps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:45.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbfec4c-fa38-4191-df62-08de018628a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Now that we have a simple decoding logic for all the banked registers,
remove the register API usage for them. This restricts the register API
usage to only the base registers (from 0x0 to 0xec).

This also removes all the custom code that was creating register
descriptors for the register API and was leading to memory leaks when
the device was finalized.

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


