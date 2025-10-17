Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7958CCD1A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAb-0005Ur-QS; Fri, 17 Oct 2025 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAW-0005SH-IH; Fri, 17 Oct 2025 12:19:04 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAO-0007eM-Fe; Fri, 17 Oct 2025 12:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJZifyp4jelrxuuKPivJWry55SteK4iFouam1F3xwJq2L6ShUyYnt1/8n3OeHaUVcZr5YdX1ygLhbFTCcxDdCnL25hjB+pJqGdRlfMgM0clE5+tgiTNPs+u9kkYoaXD3V7JI2+gkqIhcWvCH8qcgAlE5e5s4bve7mT8boFyD4ZzmZ0FU5h2tvy0Bj/Ih3LrwP7GiVTo9GEnMwvDtPx3FYvtcaC/ZOyOLnpQBxXGTE5FhiNVr8TXoiLl+7zIGVm94T6+rbFYl6oQVBlFa+6KumjrZvcDb1SajI/IO/8QGc9w5frBNtKJAD4zSn1KqFFFYflpBj9dQeeMR/txdhnxWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdAOd/EUmGFD7tZM3WnBt5YGeDjC5brmyqZBulN7VJI=;
 b=GGy6ZCEp3TiN2/1c8wd8l0WqATskhDKIRy1nW5+OUXCk57OuDbVqUO8hQXu9ggWFTWagP9QT7eoHNfFISRBnnJl/VETN7vec9tn/2vqfUgHsoNLw7/Jz0/aRVDD0s8qqXvUVPkCH6+UBo+E6IpAJPZLO8nZHq/6p3Qc2HP2Gg+nj/G7pIOeIkJ/6Z/Nqc6ufIsOCxwAixHfC1taGC4mcMCjqUpdJdOK73OKBvjQIRe5gTSC9s0diiKI1TlE9luyC4r/OG0osv/EOCZyWaMSKnJRIe3ZTjLnpjLCo8KGGcZMB6SGR/Fp6SV8Ex+KymZfaZka6HYi5Q8+2Q+KlX3qHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdAOd/EUmGFD7tZM3WnBt5YGeDjC5brmyqZBulN7VJI=;
 b=AQrrQZthQPJRAa84PtW4mzGH2XlnPZjxe0fBVUivdm9o/4sXGdNzyuNfiz/ECit2hPSYEwf3ZAJUecIIXd55VREEYFQauEqhmAIJIOz/Xdu1BzNdPT/vpvaxIDZ9CNU2ObPLelZ96YzZbJyli0jn+WzOQlRz4rOpPzeGSdtN5lY=
Received: from PH8PR21CA0018.namprd21.prod.outlook.com (2603:10b6:510:2ce::8)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:18:43 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::a) by PH8PR21CA0018.outlook.office365.com
 (2603:10b6:510:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via Frontend Transport; Fri,
 17 Oct 2025 16:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:41 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:39 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 6/6] hw/net/can/xlnx-versal-canfd: remove register API
 usage for banked regs
Date: Fri, 17 Oct 2025 18:18:05 +0200
Message-ID: <20251017161809.235740-7-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0811a846-8b67-4202-3b14-08de0d98d6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F9DwADQn+8rqnHlFUOn1n21cALfC84JMo9jIdrGUUk22CNHx8JfX3ST0uRpP?=
 =?us-ascii?Q?IHcUJqjw8njRekKP4ule0CuV+CkmBFzJ3dMW/E1dEzvWOwO6fjFgsgkzfdOX?=
 =?us-ascii?Q?Fs8G8ppZEvItp/qb/7wqJU5OBNoo5fg5WZ9UoNP4+R2XoknzBeW6Wm/7F6wv?=
 =?us-ascii?Q?8LpEPznDmwtohdWpbcf5+otKQw/weB/ZMLSwkXNh24fAr7AU/f6ewg6u/4Nf?=
 =?us-ascii?Q?M9VdTT87nC7TaiMaROf6S7F5sbXAKMx9k56IqhNL27SIOqfYVaPO8IGCoEtU?=
 =?us-ascii?Q?+JpVepZcD33vg3rNQE4YVGLPwk6hynUKgyitu0VwDLMzfR3wVEkAMI8ep+8c?=
 =?us-ascii?Q?XnriLZnxrRwBoLIkR0I1tygVNzBUsU1GM/Xw+9BQAnv6BYQ0ErArQalUmeIE?=
 =?us-ascii?Q?kTrERQ8vzAn+nlVe0qWUfiayr33RREWQe8cfaNVjEVyOSiDD/1lWDRVoI50a?=
 =?us-ascii?Q?xQ2jYuGspiLONfviq1c2e3YA9Hbfq6WGJpR0q/LgYKIWmkdqsxI/4uKmiSGm?=
 =?us-ascii?Q?0TQOCicbsk7vYvaNMvCwsja9z/jSLcYjubtnClizhiVAbXOrhri7v52dS+J+?=
 =?us-ascii?Q?3SmVxAfomgnM5MMgw8K7yKXx3hlesstFuHFwtesX4T/F5kh0lwiVBNmiPXIB?=
 =?us-ascii?Q?/3ppJwhug/YGwj433fS+QiA+27uYCSkjyFjgrq0eXdHIS79sIgg6BQc0kamq?=
 =?us-ascii?Q?0vak6XJ1q724rEM2O5H0dFy7LfrHmqLjZ5aerMtsDjaFxoJByHrWxUCt9ZSR?=
 =?us-ascii?Q?sAGW7cD3Q9hv32D9YOGX2CnZSzbboYrBDUb0hpLdQOUqO2wdPPvMAkPGvhhK?=
 =?us-ascii?Q?NgHFotthdIyVfOBS4h1NiChWGPWWGrKST/ottYgnXxtDU2Bwz2wFt3oeRicg?=
 =?us-ascii?Q?VWnfX+l5EbVPIYwD24nmdyr0Wf8WYzpIWZQLXsw6uvbLGzIhGGsztyASnMpR?=
 =?us-ascii?Q?IMO9/Z+d3Hf+gXMfme6XqllPhhQq7oFShf8kBF9Ncw6/P9BKfnpWJ7UZJ2Ox?=
 =?us-ascii?Q?YsHk8eXjhaQmGP3Ziq1ZwGhwZ4HYvuaOfw4QR9VsHNByonTjugNmgd7UX+Av?=
 =?us-ascii?Q?LVDlKtIdgKXOUazc6OyxULGO4wfgM5LSfWonrY2i7PKzlN1mw2VJaRWgOZvb?=
 =?us-ascii?Q?HYQf6ReJ6OCO6ZK79BPLEiPhpA5UhHYvWh8cpbUo4ssSkTg+9luM61JDcWZ6?=
 =?us-ascii?Q?U8y7eZtoAlSmJSIfhWc8hhuWclum8vzufzgaPAxAYZgfO2krOBtPtA2ia5Yp?=
 =?us-ascii?Q?mDO+ZvKwjJYhkKNujWd9EQHAm8xpYE+By4fEgFFuPBEL+3YSeW1zJvEp/4Sk?=
 =?us-ascii?Q?fo4LSZvTd6cogR80k2g/ECAtxhMtPS6nlt0qIupV0T6AONDQ+XnHhJJ83g1J?=
 =?us-ascii?Q?PfDnarspxjGB5JdNMFaNxJUYGQ5YBYuQN9dEFPXgcwxjY7aLrG6PTZAGjEo0?=
 =?us-ascii?Q?Nf9HWZK8KACAHn/7tgFiAzI5bWE1STcjZon9oiAsx/X52Qw/+v2Z2b3Nlci7?=
 =?us-ascii?Q?/3k+DtFn+irQXkVHwTrlYMySSidufW06VkkfGq6F8hE9N4KGdy3m4yoGiN1b?=
 =?us-ascii?Q?qf1xkYFvltFYtmaSNi8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:42.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0811a846-8b67-4202-3b14-08de0d98d6d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Luc.Michel@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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
 hw/net/can/xlnx-versal-canfd.c     | 303 ++---------------------------
 2 files changed, 15 insertions(+), 296 deletions(-)

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
index c493664c2f1..e8aa4fc8764 100644
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
@@ -1912,10 +1753,20 @@ static const MemoryRegionOps canfd_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
 };
 
+static const MemoryRegionOps canfd_regs_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void canfd_reset(DeviceState *dev)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(dev);
     unsigned int i;
 
@@ -1991,144 +1842,20 @@ static int xlnx_canfd_connect_to_bus(XlnxVersalCANFDState *s,
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


