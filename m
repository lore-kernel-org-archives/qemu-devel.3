Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97675C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXL9e-0003GI-U9; Thu, 03 Jul 2025 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9d-0003FG-8a; Thu, 03 Jul 2025 10:43:13 -0400
Received: from mail-bn1nam02on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61d]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9a-0004KY-3s; Thu, 03 Jul 2025 10:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e40KEw4K1O/43W8wi6WNgAgC5heEelHs36HgPQuuNLUnHvSocAtb6hD5z6or6L6/H8VTIXJuLZwHavWUF191yVjCre/R37V9+LrK648nTBCr5vwWSWXemzWR9Y4nGYNfBnpZ0uJYw6A/+W/Cpe1Df86BrQXQDy+JUjGyk3OacmRf1AiUxSuSKJjtzGMyLJlj5+nhapdGTrFq+qADa2ByCSmy0lwRokRmlRjWnsOs7VZN+zXPD1ebSUSJGKpO45VeOt4iikyVMpRcFuqZEmJtVVrZvz4PG8+dkaLBerCnnVK7NvdAXAq+20WxdmRuFNEBbw42nimij8AwwPwk3rD+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5DmmmofJHWNVLsUB8hXIlo8AnTXVqq/d2GZdG9uark=;
 b=MeJUpli+wBaZ6VqzT26n2JTDuOO4xq2NpsD+QKCSSB0rv/t6pQG5hM2hjLnLRfwZCmZvN5atZN1aJwTFRe833PWhHL9rB9jzYutD5B3CyPHIUhvwAObiDVsPzxwbjmoWvOiBmkdY0CwfYWUzJESo0POaxi1V7fbReQg4SpWbXcyVsp2lwd9ca9PVUGjszYtQdPaNFoesRvV1inOoUIkghvfA+k8K1vi9HXdElsDvXwNVJzRESz8krS4QELhRs4SHl+d5QK1LC2i3SfCgEfIUL8RsmIbsqwakZYXQ2Nkrme8+nDDeW6Xu2JdHmu/Rr2ItDm6UZgyhz/E8ncfvRMeyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5DmmmofJHWNVLsUB8hXIlo8AnTXVqq/d2GZdG9uark=;
 b=J9VKG6W0qQNhm252i3hhoZI+cNxYAplxH91qMbPFgEDF5nv8fy3G4h35ps58dvKlU1ciWmyBgJvYXd2GE/AxV19iIHgdpbuU5GLSsSEayfwfXzacAAWxUFhacKNU7Wh/7q7gNM5TfVocOFoM/UKi6DqqSdjSVrdC/T8ezvUg4rJUQ49ALvv2GJXU484Ei7q4GimcxRJPHZULhH+1n8XfAFKo01Mqjhu9gw0eNETKkhttjgh4k4lSXypZWOMmmC1h8aPAudbayv8bF4rr7p3IKiHGmpmxkpTNTaRDcl44XIPbYkzEpZFUrkQBjCTwHPbY/2xgHPDWVQfe+ZBpYSqJOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:43:03 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 14:43:02 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Tanous <etanous@nvidia.com>
Subject: [PATCH v2 4/4] tests/functional: Add gb200 tests
Date: Thu,  3 Jul 2025 07:42:49 -0700
Message-ID: <20250703144249.3348879-5-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703144249.3348879-1-etanous@nvidia.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: ab65af52-97c1-4524-bfaf-08ddba3fe9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqQ0N92wkMEpeFVhh79VQR+/eiK3zTmYruNv8651b5z5MfQgSQRm5HktsSv7?=
 =?us-ascii?Q?QncIelWxOn1vKzC1fnnNDXShdJgoYhylxcPO24c7Jlx5voRJyUcBGN8Nt0Of?=
 =?us-ascii?Q?dtEol+TZrGheIXDUfnkiWGKct2p2+mLgj7JJvhBGmf8x5Vshqe7JOsbRceZI?=
 =?us-ascii?Q?PW00wbdZElCBBdU5+X0nfctHS5Wgy5ZSLUGV8ZVvOwAtwOQBXw3dHuAQvOE2?=
 =?us-ascii?Q?6bPBcDG0YQUXogaeboTdBeyKgvRD2PuZOZcAQs/xQINR+oj+zOSMElA6CxJs?=
 =?us-ascii?Q?K5vmDRKtoTFBAgO7NnB7eZHteBRVoHCB1JsaaWz9vGkQadg9o+ssEJughKyb?=
 =?us-ascii?Q?Ne86LCCvu4b/rDxJPIuGsClLDjJC43AfHi0dU6cbSOPMh1ilg8HMQZKG8x42?=
 =?us-ascii?Q?eselGC4fQUFPyaGSzBJ85B0vKDD7ro8PlxwKEUnOasesFY/quGep5gqRGIGg?=
 =?us-ascii?Q?D6TDzbzH4380bj7OvvonsLdetg+SE9EqZjikZb6/DH7XRXx+pF2nsHHlIlWk?=
 =?us-ascii?Q?QSda/VDJVznUT2l+Hfi7yDfMDPXkY+wYLj83mgp2XI+Y+GemacEpD1NU7Rwe?=
 =?us-ascii?Q?mmrGtK0llmz7oRmRGiyUU2449JTWXIB+a2lKaf6EHlq7eCCZovM7g7MEbtYU?=
 =?us-ascii?Q?oXxkiheTzUhv0EbRP0fq/qq2Fm0DwjOCVHFXCrX2C5Vwu68RSxfY1Wwp0AOj?=
 =?us-ascii?Q?2XSZ31xhDHr6b5zQAZjsI5CfO0g/gRLqM+wJJEinmSYHBXkxxlSxsOevhjit?=
 =?us-ascii?Q?RbHk4km62jqnt35jbPsT7Gp/jiWT2iAbVW5JkLdFKVX3XyabZdTs0n8fXqoG?=
 =?us-ascii?Q?v8npgj4qih9VgwrG9PCgtddeXhGBQnoxV/db18cUTGvB+ccmCLPU7rKmZlEt?=
 =?us-ascii?Q?PZ8wA9GSOVPTFJcn8KtjQVqdtoukVdb4YhU6UyQmhbTcdK0jPaVaiwM3NZ6m?=
 =?us-ascii?Q?JKHZgzGAjsU3o7r51vYE1qKi5dHr2O1XCXeQthX3L9XFVZzqQi9tDD8vrlUl?=
 =?us-ascii?Q?og4euy7lxYpl0UxX+4dVci34pze8X7oZXG7xOHnbq6BxMwTGFmxCdkUYmF32?=
 =?us-ascii?Q?rRMNd8YtTTz1ffHkyoE+/ZfLXJ0ys6t6TDsWqDVQtbs3KfFGul8iBYcLEB7E?=
 =?us-ascii?Q?p8N1gn7P6krkZQov+DnAKSdIYQjmY84XFIQVmcKUidzI2sN+6hhW3MxBdev1?=
 =?us-ascii?Q?yNzE1RTmtYJIrfkLU7sq0U+EgNCoTiB2M3T3mLbLyWjXLjMG9MvFAjBuGVD+?=
 =?us-ascii?Q?GgTcYuBAhJg3WNDCYqJlAn+4/Gwp7lRS46Zj+pQgU/kHBj0K3q/anieZ8hzF?=
 =?us-ascii?Q?W5NjgThqtyd1E0zV3VMe6PvhaiXf8OkwwKP//sPbYgOqqrwuALCke6N0NxDt?=
 =?us-ascii?Q?b9XWgxyV/rPqsgYViy5gQtQ/1+lXO9EC7rQef2WCQagyTT0KOKk54qwBnW6J?=
 =?us-ascii?Q?hjFIN9pjUe8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Tgqpd2mE6YoGVW+8sWr2WRKcDZ1KL9Gxy8BAmEwZwEBtscvJktUunP7OyDp?=
 =?us-ascii?Q?BrA/uY+JYvwvFrLC2oo4GoDULDVNMTTPOmxP95qGoNl38Btw5O7+NNiSYPcQ?=
 =?us-ascii?Q?SaM5RWt44iBpBJ8OiGSiiraqW2AVD7UsHAUQIfZO5Buvb57qdr0KSeJtndjx?=
 =?us-ascii?Q?y5vBoISRqdU7wlU2vlZDsAK1Z68sHQBqPqX56AFofh3r0VdDxtqNRV5+Fs0j?=
 =?us-ascii?Q?dYqRyRoDJw+Zku2ZVL5fGOcB11uG1hSwsA2fsUD26aOXQk6tN6XbZyIiKvaY?=
 =?us-ascii?Q?vqrMWyh06fpzReI2LpynNYplyEu91KbSegIAw7axtivR5gTjDmyzuk0ICCKy?=
 =?us-ascii?Q?7dFrhCsgU8TyV6V6+CFDCy+U2LdT6qT5BgRCUohiH1gyXXVpFvhWg86s3Kuv?=
 =?us-ascii?Q?HIfBMsmgiLWecY1ZGWyPs409r6aTnYLJy6zpbWA8IYWOxD8L0zhkKOJ7VElp?=
 =?us-ascii?Q?E6I6kp0n910h9acm3ZE5OLmtOxNr3pehSJzjgTfMVPr200tZE6kmFDYMRCEp?=
 =?us-ascii?Q?Z5vWvjc28ER209fDUUHO8njXnmoMYjH/6trbdl88mvotLEahZAKIT1AJZ6PF?=
 =?us-ascii?Q?mMxwASztYGz2L8aN0QMPuQhgAaBgwW7hYKDDYITM+21MhsazeKIOex83FCGU?=
 =?us-ascii?Q?BlHja2LImuI3TA5SuoKdxQBaJEPi74l4AFJd0037LZjHrfBUsWSAe0cC4njQ?=
 =?us-ascii?Q?qw6YT80m4XAl5CUex3Dm09ZjZbTXG7wV5Bj0lHNsZk4wxKkvn4xXLzOWj7u4?=
 =?us-ascii?Q?cBlmRJiUkfDabrz7v9UE1w5jLuxMV3/88jEpo/jeQWWc3o44VCo2e4EiIAgJ?=
 =?us-ascii?Q?RlWca0q7BXZmEGCnWgfCxjnSHJutXIVhRdcsxMagHTpq8JhQ9TT6ay+nK+BP?=
 =?us-ascii?Q?4XSS7YRbvvdzWoqTSKlUmfYWQtwfSGhSW6p+wt7MshKcNgOwfbD+kIlWGrUv?=
 =?us-ascii?Q?34HL7mxAvXSwDWryfaK4fLFC5Avi5yt8h4H9ZShhv2j4jQBsWO3zolel+kQ8?=
 =?us-ascii?Q?/C9zDaZHiFib0WMUB6NUOYtDdrPVjs80qTaIArF7ea2syrk1CY5Bqnb1k12/?=
 =?us-ascii?Q?hK6ExLcRisxV44PMA303LoBceeRJbojXY9hNauGk6VH/UD/7kTT2FWlLZVBB?=
 =?us-ascii?Q?Bc3DCwk0x56ch81tzDBp/bnWJ6lLmdpbmx8Rl7RGwQKHGZcfyMKdP3zluvWs?=
 =?us-ascii?Q?pDZsgs8C/Jabi3OUoH1WhO3vtJ61drkbjAloy3AxgiklCmYNqfmJY3+DiqOw?=
 =?us-ascii?Q?hJG142oOOCwsDNqfQaia5pz7NkGbmonbtek/deSWXUyQHL6JC1Yi4T5r/Hl/?=
 =?us-ascii?Q?Iuvq2giRTVW3xhEj6uCft7S5cOqPCVZKz53JrDlSEzpjwcY/PF0lo2eTc/uC?=
 =?us-ascii?Q?JLBPURzbnRzJ1cGj1Emw6CzL1cSFNgT+aEadcDAf2zICR7rTyk9f2TT9yC/3?=
 =?us-ascii?Q?sYuPJaMp2Oqj1aGS763GsyXsXUid3gO1XJv9FP6r5/kPYL/SOOq6tV0minOA?=
 =?us-ascii?Q?PpvHbcSq4O6iLQ/dgfcjbVk7FxH1AHt0nisl3bCW1HlEBGZ1EuS8efeeZVzV?=
 =?us-ascii?Q?BF3Q6lzPvzjuE2C0GPXP28I7FtSUiKkM4A7qZeiw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab65af52-97c1-4524-bfaf-08ddba3fe9d6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:43:02.9069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ2CFz+8jcwG94Deuncw8ptoloDRJdUCuVDDLw3oyBkJ3uKfhbdc4QYiIfysQoUX82GO48TU3GXnBDuRqbF1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
Received-SPF: permerror client-ip=2a01:111:f403:2407::61d;
 envelope-from=etanous@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

To support the newly added gb200 machine, add appropriate tests.

Signed-off-by: Ed Tanous <etanous@nvidia.com>
---
 tests/functional/aspeed.py                    |  9 +++++--
 tests/functional/meson.build                  |  2 ++
 .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 tests/functional/test_arm_aspeed_gb200nvl_bmc.py

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 7a40d5dda7..b131703c52 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -8,8 +8,13 @@
 class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
-                                   cpu_id='0x0', soc='AST2500 rev A1'):
-        hostname = machine.removesuffix('-bmc')
+                                   cpu_id='0x0', soc='AST2500 rev A1',
+                                   image_hostname=None):
+        # Allow for the image hostname to not end in "-bmc"
+        if image_hostname is not None:
+            hostname = image_hostname
+        else:
+            hostname = machine.removesuffix('-bmc')
 
         self.set_machine(machine)
         self.vm.set_console()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 85158562a2..d2864543a5 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -32,6 +32,7 @@ test_timeouts = {
   'arm_aspeed_ast2500' : 720,
   'arm_aspeed_ast2600' : 1200,
   'arm_aspeed_bletchley' : 480,
+  'arm_aspeed_gb200nvl_bmc' : 480,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -126,6 +127,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_ast2500',
   'arm_aspeed_ast2600',
   'arm_aspeed_bletchley',
+  'arm_aspeed_gb200nvl_bmc',
   'arm_aspeed_rainier',
   'arm_bpim2u',
   'arm_canona1100',
diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
new file mode 100755
index 0000000000..8e8e3f05c1
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class GB200Machine(AspeedTest):
+
+    ASSET_GB200_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
+        'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
+
+    def test_arm_aspeed_gb200_openbmc(self):
+        image_path = self.uncompress(self.ASSET_GB200_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('gb200nvl-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3',
+                                        image_hostname='gb200nvl-obmc')
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.43.0


