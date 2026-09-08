Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BEAC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI4-0008TD-B6; Tue, 08 Sep 2026 06:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI2-0008RT-5b; Tue, 08 Sep 2026 06:42:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI0-0006bO-1q; Tue, 08 Sep 2026 06:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m35a8ElwNPQaFBPJr5JTZy/+g2Zee2Z12vMlAYe63Iys3yg3biKNKq5UOzUR+aFHQZAVtVwmXEQ4Jvpk05d5tKT/tKgQwSt7yHCrjB3cMhIt91Xg/SCKMO5RSKLizNi71D42/zUHiWvWbT+RxvONHTHhlPr+NVhmKeddeI9iNt+s/ELXX8KdF2ZtECCACo4wN3ry5PUr5zY9WXhnDPSuHfVFMpXb/j7Y2X7lJYnzKfi6SZxBHGqY4Y/MXGsl8TeKIqoXypR/LE/PAG96XUYIJzrwn7/C5kWApvO5qiT8GsF356dcx1Oob2rfPwwCk0J7asvZCzP7X3MLQ4GZuqPsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFXkzN1Yb8i0zjh8XcBmG2jfI3etJSg0c5y+SZbbvAc=;
 b=u+Gxem8/FYo9lIxdmjFmrFONik2mWmAE2ZN6TrwWAuJcIbHIHCvJDgbF45KqGrmSf6/AKD3tmltNvNwnf9K3TOqrL8prVjdujC3uY2XzJHQSWhJhRQdV33hXLA93hVvdcPSbScRIdmIcOcGaLAtVl+2ujfnOOyzB3yKBNZn/Hx5Ung5I0YqbMypLiMSWhxgT0jTbWD1oFfC9FH3LQNypGSFIFCEX+lPEnIDnTNuQxOTdUYqrdfza0oxH2b0s76saMqCYOZodssw9WscqrfPYpQvCdXj8T6/BQGSOdaoAd9QFaPkGkz5mAYxMBFkZgeJ0XAIP+lvRKRAenUkIKSvcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFXkzN1Yb8i0zjh8XcBmG2jfI3etJSg0c5y+SZbbvAc=;
 b=HQKIB2jbFlxYivKoFbJoBz2hHZKODqwW4RUb0acM1DnvoAKu49QQHh9JB9abWBy58H40IwWKZTU5HZLxQC0I/G+kDvl0+uv2/DqdV1zYBDbEdOOXob7IwnG2Q5uKH+WMAnVynr94DUALyGJ5vu/xkpfyf++bn9bKjqASq7bdbQ7SxEsc6GprxzxXP2kMCurL6otuCGk4qB/DOAAytUkAEOrU22M4eqHfDoqH7HCEy1hdH1b3YpFwKwufv4DAuHbbznOZsZE4hVYC8uj9HhVF1vE6cLxdhU6aRgNF1J3YvU4/YsHEsqb+9p/WXmNEyNEKIZt1MsJl0fBy0FKp5TddCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:54 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:54 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 22/32] hw/arm: phytium: Connect the Phytium E2000 random
 generator
Date: Tue,  8 Sep 2026 18:41:31 +0800
Message-ID: <20260908104159.1621764-23-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7896cb-72c2-4b24-8ec9-08df0d95eee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /HEU/i19ITwhJyYT4nAUhNnYMuVhKyPh4mUJ1baslC/RtTj0K3jl+j8mmuYfOSOa3jPUGR7dr8p1mLZ8+gobnXNkiBpW7vr0dPKfdBSRfy3epHrAvkLIHpvICHLltgKhuK3N5O/W3wrNBptq64ciN65WDCKt3V4lrS0FCK3lyvDYHcaDbxFdnOpVn1QE4anTs6ESd9j6UHgvIRH3nY7VBk7zgpPj4PWx6z7/6HVpQRygGfBWwfWbiENKWXe9ohG5H9PTDglc3Civh1oGPhYzXbDHsyOzbPnJjK0dRkZzv0AYqr8HBeSqFCEfk/uFNcMSYnpI19JkuwbHI4cnaKovOfptPQtkGxNhzs7UTS6MRp/JcaB9SJ2qNFCJFBjoujyARvWClD5xnZgUNF5LNEH9mHOBXxS8ZX3Z63ILPfgI2Z8ACDYqMeO6FtnXDpN0nDnA3pNOp1KvNlz/Y6Vq7TefGIbfjhpo0L5GgrAmUiFBEj1sIsi0i372hU/k4WJDEbfNLkhHrR0u+fb1886CdOg80ErR3S76datloNB4IoESy60iGIfbYctHjXr05WSryNpN3H3mfzNHT+IwIcDiVGI6BWpwP2vOFdWFLcF0TK+05PQEGnisTXdJVBT+nKKbym7W9yO+nGzEP0mncjtTfliJfuQb2RsJQHxFyGsIajwn1IQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7NhrvXTvjlCLBJwxpzV4n36xTbYB2Kb5i0zcZYf4Hqa7mqP6/M5evpYTxJ0?=
 =?us-ascii?Q?VicWGvYV9tZFbhDv1QbJ/HO7KbrZu8RIAAgfYu6rAnyVOvSwZgwH6BGQwmtI?=
 =?us-ascii?Q?fsDmuDIENsGlnOhnXpqYJbEIdRYy/pjM+DC6efTNuk67YfSp9sF1D2UTNpTI?=
 =?us-ascii?Q?ChMlZ3XIbXKTuA2dloQG4dsby3npkV2fBbGN1ghFF9OqJELOknjMUanjslSp?=
 =?us-ascii?Q?FKjHuImmryQpfyvxJPfRRIhhcTX3EpezQGqN5N7YTP+Lw8FH/td07/lzriQu?=
 =?us-ascii?Q?q3n3VJFWTNrR4emqstKGHCLe+Av73EgH3Nb6FOM7fFTa9v7xd9pnyybiBt61?=
 =?us-ascii?Q?6T/FN/kZeL3KcU/g4CfME1nm6sxDWFsiUmy1uRCFD349J1RnBxCs/GsaQBWY?=
 =?us-ascii?Q?sIk4aRsOaA1wqHqB73Yr+HarP3lU51tW+nxo7KboTC1EFBN2kALDczEBCv9g?=
 =?us-ascii?Q?n0P+OnAJ69J+6r3jrwcKCA8gIFESt9gKB57HDYFqppwEz5zsh7JWt+hM2CFp?=
 =?us-ascii?Q?S9MQD5g7LzqDFg4EHd1KsKF+g34zmmEFLokQae6w/apyQMgZwbl4eHmgUA6k?=
 =?us-ascii?Q?TVd9X56elO7bkFzpE0PaWb00X/Mf2p+315M8TbDxBxCYHHQlYc3PkIg4gdz/?=
 =?us-ascii?Q?wogv6PjOh+rr7cXg+Ck4veQSFjF9eFFxGW/9U2rk1k66GIcQpdAizw5YlTp5?=
 =?us-ascii?Q?yaIkPBIaz/WWomuhRwbj9bRfm6e2jotLfEyOL7d8eSCQbvszo1SmQRHOmaPY?=
 =?us-ascii?Q?2O57Jceeu9SoP98lsghSxTXaj1q+4SoFtPYn188r21PJgEwfFX1wOAfM39jn?=
 =?us-ascii?Q?FO8u3lsO2Jp1edPyHbf9ANPgK67OSngRIgZRUhxzVc3qlg/6FD9ZL8oQdPXT?=
 =?us-ascii?Q?WWO7vS19UcbhvO80veuWhfW+/3jiSOUD7bwEMHakG/7RGrbFXfHSfONUlmDn?=
 =?us-ascii?Q?xXMfeCPVrENGKaKo3xoDA9/sRSIugYvbX7qpAII0aFQL5vUDAxXNkvKbseiM?=
 =?us-ascii?Q?wmybo/T24gpEy3cnEbFk5TMOBHPqk3lIpSKP/fuWCxmHwAXgRwgUWC0a6UJ3?=
 =?us-ascii?Q?AHOh++JBnBp4IZZAMySEWMqoc+vi+ktHpBQ1+LfrEeBoeXQSKHWqVOvpotCm?=
 =?us-ascii?Q?m1VsKDPRg57agpzlSyGFfP7qzEjFUC2beQJ0NHHsCMlUdfoBok/RuMJxl9wr?=
 =?us-ascii?Q?OUquZM4+UQdrdntZnLJm+ys+wObBDl0Txs1Ayy5zjykTSwC0IPECXCKiX34d?=
 =?us-ascii?Q?APKhcmVzUhu+MIoyIPJEAXqTMKqI/lRHF1qGIhnGQayFeBmt+CNAObPExE00?=
 =?us-ascii?Q?R8gupIj8qoCxx9hzmf4gHWcukOO3SeD0pLI/diDMLyPCtyFAlvtKcOQ4KTwx?=
 =?us-ascii?Q?GBOm84ZSEVpxHwVGNsOvkZ7r8sqt04D4xEssXhg3rGVtAAOZ7z2ifEzp6ZI4?=
 =?us-ascii?Q?DN7ewY+bLIRkIWRXrYqqimA4LE5GSpxN9dVbH9gKbWfadYGjRMkE+k+Fe6I+?=
 =?us-ascii?Q?ocTZbnMAQMaHibmJLswRLhTUKUUsrMJojlBF+Okm1CTwGPbQUHVgBK38hhln?=
 =?us-ascii?Q?5/dotVtGYcQ7h77n+/SbwrP+2eswJN9ec7cfgt6gNn2p9Ytd5bUeXCpIhWpl?=
 =?us-ascii?Q?XqZn0Nu8XLwjrjAUI66YnJSNVK29k5t+FvSZJhljzo0xzqFH2FQqWmSKzoiJ?=
 =?us-ascii?Q?Rvb//DjRlV2fzj3cxVlioFA1fv65t8Z0LjtGB5y15hLiiFEJNt8f+ZfWTWuB?=
 =?us-ascii?Q?Ey2BXjUR81X2DUtqeDbHddbTD8JhEe8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7896cb-72c2-4b24-8ec9-08df0d95eee7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:52.0041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UgBwHxoFiyG8YZIL6etoDW1x+yf3JqiDQRY6i+0CftEgLQi/aQgIx22dvO7Lx5W2yU9lltwQobPd2HwCmCnYpw95BjCaSOEvkKJQwvaGAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Instantiate the RNG during E2000 SoC realization and map it over the
placeholder.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the random generator into the E2000 SoC

 include/hw/arm/phytium_e2000.h |  1 +
 hw/arm/phytium_e2000.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 079f7298e9..ee645ce530 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -57,6 +57,7 @@ enum {
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_RNG_REGS,
     PHYTIUM_E2000_PLATFORM_CTRL,
     PHYTIUM_E2000_SECURITY_CTRL,
     PHYTIUM_E2000_CHIP_CTRL,
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index e74005289f..33617e793a 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -25,6 +25,7 @@
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/phytium_e2000_pbr.h"
+#include "hw/misc/phytium_e2000_rng.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -87,6 +88,7 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_RNG_REGS] =       { 0x32a36000, 0x00001000 },
     [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
     [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
     [PHYTIUM_E2000_CHIP_CTRL] =      { 0x33000000, 0x00010000 },
@@ -594,6 +596,17 @@ static void phytium_e2000_create_ddr_status(PhytiumE2000SoCState *s)
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
 }
 
+static void phytium_e2000_create_rng(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_RNG);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(s), "rng", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_RNG_REGS].base, 2);
+}
+
 static void phytium_e2000_create_scp_sram(PhytiumE2000SoCState *s)
 {
     /*
@@ -812,6 +825,7 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
 
     phytium_e2000_create_scp_sram(s);
     phytium_e2000_create_mhu(s);
+    phytium_e2000_create_rng(s);
     phytium_e2000_create_ddr_status(s);
 
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
-- 
2.53.0


