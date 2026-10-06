Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2999CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7d-0004ej-GN; Wed, 07 Oct 2026 04:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4D-00017i-H3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI3y-0000co-LV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:37 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYs8hL7A3rkrhTQwdSJyl6hKlQI2ISm75aEptRYNnH/LjGMKQ1cETMpRZ5f1ptP8lUCXLoxByotx2jYiLE0sNVjMMhatKcNnRyIH8nhkwRpxOobK8Ea3zK1STgQL3F6mlsZKQ08YOc7wnbqORFHfDv/ru6lR0eqC15HesF3UB/PH01jQqS2omxm+y5TXHpHlx/hnaNGg7DLzxwSwAVeZraUusKsBd3lsN9re7KZUsE1aiNWRnofeSSpyyyGPX0GW4GrJ2U5d9dZgwM4U7yIFMC3kCwhK1zzWSFcX2WSzoNDe3rfQMymhxEP6tiE8cbq7BiWOlPOhEylN1qxD8DloLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Nh646pCJPzlIYGNaYOmbMZHm1hYySth9053vym/pOU=;
 b=jrCaPcX1F6Hip8dwvjluK9RSwzisp2EqC1Y9NEuOT8gBloy33K+1Jv0/F2eVefU/h0miGRt7IEmPXjXnbljUfvJh6bF8O07/X4ecI7HqF+KInmiAdQC+qLRWfnW+76GqdnNVws62XF8143JaMUUHn86IkBc1VmWo1IxujVVD8QFQySeBsC6r4weuFE2JN2yFQM8+7ybdCLMelISUyO3hLy1e9+TkYKG3aa9Un0VyVA3XskJZl5iVq9t0CDNfntxnpNglXFdg+XTm6QEGNPhMxda2faFreMqhkq6v3vVRzrqXyxZqmRQ8yiZOPbnwm18jSpSVDmZMu6rJ3YmaacT6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nh646pCJPzlIYGNaYOmbMZHm1hYySth9053vym/pOU=;
 b=jJXa+qPM9pNWxojl8kcl6yO0qOzlRmKoN526OZ3d1W5CbRhc4NVPsz2MEvVk6w/CAist4A9j3aaR9SjwqxraBwu0VpW/EP2pPcDof4mLBLegwbVOXvBNsLF3RQ4DguEE9X/UxPE+odnXDNexQrIXZAMFhpUYX4z2eWRvDcKHLHy2hmHXL3vCXxLN3Pyd5F+IqpP3JUJiyKubPLWO+tbO4mWhObaktQMlPRn2ji8APVWp7n6i7qLAo6GE/PCoWKKClNFa0kcAL8MxDbxzWjnbmOfH8rgGWIq/4yhLieg/sr7FVSJDxMYzl8skXCaBBdh8rILFd7LBt7ZJjX5eOaS9TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:50 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 16/17] tests/tcg/ppc: Test byte comparison and parity on
 e5500/e6500
Date: Tue,  6 Oct 2026 17:49:11 +0800
Message-ID: <20261006094921.110871-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 291b5b71-ca4e-4b75-b6ab-08df238f4d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|260925021311599003|260925021911599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: gJv6PqQgi940RuG/CACZYEBDdYqBpbCX7G+irbRF0HV6NfiYichDQH3nN+ufUWKHQrwN7zfI7jcw9tK6PkmR/A4Xmm59gy7FkzbsDRE4h3gTh7uzn9unR9EwY8nEgjI9WvkdA6OJoqSuAWTcS2ozru4UEuvJSswTmLeRzeEFSfaMbduATf9j/AO2Axzayackn9rnD9uKfFyR8Cadq24McMwcG7OIvy3DMWoxys+Bi/U1erDzmN5Y5f2E/ldm9hRotK4M2QsM47J3xE1xxCYvAAugQZWJG1u7pvQNJLo5VM1q7bgSvw1e9CbK1nT4rHDsLhtZ8YabVunz/GkT23PB5ulOCAD5vvVM5iEAEe57FaTzcOGN+KFCVHyBcLNinfS5L1JQrQbpNyAvzPGBpgQibg+U+enOQGfrafGeYvpiwRGy1Oyca5H2rGzLJfQwoc/KbqrUEQHCdk3xyIHoSNjy12gO2KQH/SpDqjdRs46jTtQOl/6ZEzSup/ZZeJhtYt+PQ/0BiBtPmpIvOskvmiWDMTW2WnTJ1fjNsE4rFSSB/WW1gEiRr33z4m40+bkc3BoQRylZIjh39l/w7TDVdy6jXU/fvfq0jVZg7n4zy5CwrqXXWYyL1SJoDUrOTasoz/TJ3AHemIl7/9Ecz1jyrKhf945K8a0Nie3KTEAW0M2bWLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t5PxOuFPWoB1m6qRLhSzPK9C1BIs60+3JjjqbXJ6mA51CA74M+pZBcZf80pI?=
 =?us-ascii?Q?Og8+RmbnzTjzOEZgqBPDKikQ4DXSeo7xyCgY7ifRDmr7Vzl6ou78AOBOsaOz?=
 =?us-ascii?Q?MEu8peDRm4T/hcZhzNbdMgoTMqMpcKcm5Rs1eyAUaJauUyZ6FqwxVfevjMVE?=
 =?us-ascii?Q?FZD1jcnzydoAfUAIYDWbXlHQJcocJ/6dN6OAWThhoDhBuLcivRyyc2Ca9ews?=
 =?us-ascii?Q?16TKViOfOPUTKVaG2BMNgSuczLU9KpJh7P+onLsmxH3ksUlkbESnA3qDp192?=
 =?us-ascii?Q?D95LugUYj0FJMFa1pLcj3mWQs4lVnb8CMN2PBHh/2r2mT83IFphiH3KjGKfF?=
 =?us-ascii?Q?E8iF0vyRw34kJKJtKX5/CXHyIOzSIOwoPhu/MP53ZAYIxDti69VG0jWNNl3Z?=
 =?us-ascii?Q?67N2zRuTCKehJfP8QVdhHQr8VcmjcD4874LEK3SA6dyKozhEH7pZIbAW805J?=
 =?us-ascii?Q?4zpyLN9AENcj72VroYkUr0YMGx6+RpyGNTiFZ6nE82oPBY+tfGkXCyvilm5J?=
 =?us-ascii?Q?92tZaz+6mjz6L2dRwNU9Qbw0Xb6R51nY87/evhc9m8k4l66Hx9fApzswB7dh?=
 =?us-ascii?Q?WFbN7GJbpql5+mlPUXi82NcAaxlipa2l1DLAi+gwkFv0mTl/i41jptwcGT83?=
 =?us-ascii?Q?6nAbVH3S526SCQzF+1rHMpHJRdnUSFzZbHtgA9eLd0JE/TKXU2vnjtCMVgcC?=
 =?us-ascii?Q?7JQm6uWOQswsRK93vpmoxNkQRmcf/LKzC8TwhZ8XFZ9tACT/g7p5TVI3/bow?=
 =?us-ascii?Q?/Y9VkBTVPwtE1QEGtU743kHfcGIodSxBG/cYzhx6BVgAcrdQP3Hi34bvjUYE?=
 =?us-ascii?Q?pztBcUbT63qlVyby4ow3s1GSxnkvRkHFHM7UoHwLXsYM71cGfEnqTK28pIoV?=
 =?us-ascii?Q?B5xxFPTSmZXRCJtKNJgXamsIpKHD7vO8I3Ae3WJCgcWOdKqXOFEY6I/golb1?=
 =?us-ascii?Q?nfCAdki/DgCeZrzFc0m7e+GpBS/fCfOEOJcMfHSBb/ynox1n04lE9iX2GU0W?=
 =?us-ascii?Q?ihqg4gRuPPQhTX9hpJxNQFiBnFbVd1DPb3V8niLYLMIXFe6U2muoX6JwZhM/?=
 =?us-ascii?Q?o8xvEwq/e9HRdB00kKHCQ2xygpiI946Q+kzVHOY1FYvXjiQJZgt55XsbOV5u?=
 =?us-ascii?Q?Tsx05vIjFulnYFWyuCdCb7UUUA5UwpGCucDYoPaU7mpPVKGCh7BVhykZ8Hjp?=
 =?us-ascii?Q?t9cxgQmlYrjPlFd0wUEbIg1lK5HmAOmMT0Q3DGzSi3M/pFvw5HO3/tMD6cfL?=
 =?us-ascii?Q?6kyXUHZjsoThi7rjv3DtO1TYyh9fe4WGjuunVzJiV8STAMYJsAhghwBlD6LH?=
 =?us-ascii?Q?EhP5CVC/HihAK1ywMlQ2qYCEI2JwrfDy0yWdGLlhAJPe5+iV5ew6bIshK0Th?=
 =?us-ascii?Q?Nj8EdLK99shPJ7uCf4RlwhDwFH+yqEc5bNMZQwGDTTf0fKYQuKqRPa8aozJP?=
 =?us-ascii?Q?glgbn9QXHl1Kf0j+1xNFe0FPU3eOgspaYjVO6w27Ipio6eD15u8aEuMckpbR?=
 =?us-ascii?Q?0aZAh5aDxEUSy6Jg1Mrxm6REezJ6Fi4mg3FwQQ5WS0d3YLLEwyIjkV9zhG9s?=
 =?us-ascii?Q?t4PLxR+aSOHWVQfPXnMtckviw2o9OVIM86Jp8C168R2BiH3vLPVfpx3nPXte?=
 =?us-ascii?Q?/9vJTszu5dwjwAMwbnzf9CT7OMg7YRwSmq5elaoJUxE53vha86SMwyeGNEWB?=
 =?us-ascii?Q?t6xUe1rAv3EpJ9GOrjBPolQKtLGWvcZRKQsWw+jN1p655N1wPALG14QDLeA8?=
 =?us-ascii?Q?6IG1WmRbaCQmS2k4n10cDONXNF1AOa4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 291b5b71-ca4e-4b75-b6ab-08df238f4d9c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:50.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHxxHXGM8W4PoZRxsdu46hhguRuGmGrGfKiOj7m6NMEHf9SBGO+GmLxT8Em8VNInRzHkj0a9pIYpF74/VWkNx8T6Dyh5j9pAHC4vYoeV9KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

The e5500 and e6500 implement cmpb, prtyw and prtyd. Check matching-byte
masks and parity results, including the separate word results in a
64-bit register and parity based on the low bit of each byte.

Use inputs with odd parity in bits above each byte's low bit to reject
implementations that compute parity over all bits.

Add the test to the existing Book E matrix for e5500 and e6500 in
64-bit mode.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 tests/tcg/ppc/system/byte-parity.S | 33 ++++++++++++++++++++++++++++++
 tests/tcg/ppc64/system/meson.build |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 tests/tcg/ppc/system/byte-parity.S

diff --git a/tests/tcg/ppc/system/byte-parity.S b/tests/tcg/ppc/system/byte-parity.S
new file mode 100644
index 0000000000..f4d434c881
--- /dev/null
+++ b/tests/tcg/ppc/system/byte-parity.S
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .text
+    .globl test_main
+test_main:
+    load_value r9, 0x1122334455667788
+    load_value r10, 0x1122994455660088
+    cmpb r11, r9, r10
+    check_value r11, 0xffff00ffffff00ff
+
+    .macro parity value, word, doubleword
+    load_value r9, \value
+    prtyw r11, r9
+    check_value r11, \word
+#ifdef _LP64
+    prtyd r11, r9
+    check_value r11, \doubleword
+#endif
+    .endm
+
+    /* Parity uses the least significant bit of each byte */
+    parity 0x0101010100010000, 1, 1
+    parity 0x0001010100010000, 0x100000001, 0
+    parity 0x8080808002020202, 0, 0
+    parity 0x0000000000000080, 0, 0
+    parity 0x8000000000000000, 0, 0
+    b pass
diff --git a/tests/tcg/ppc64/system/meson.build b/tests/tcg/ppc64/system/meson.build
index ca398860e3..ffa3060f05 100644
--- a/tests/tcg/ppc64/system/meson.build
+++ b/tests/tcg/ppc64/system/meson.build
@@ -6,6 +6,7 @@ ppc64_system_cflags = ppc_system_cflags + ['-m64']
 tests = []
 foreach cpu: ['e5500', 'e6500']
   sources = ppc_system_sources
+  sources += ['byte-parity.S']
   foreach src: sources
     tests += {
       '../ppc/system/' + src: {
-- 
2.53.0


