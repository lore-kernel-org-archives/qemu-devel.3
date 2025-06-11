Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D17C71135
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 01:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPWN3-0002BD-9R; Wed, 11 Jun 2025 21:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPV6y-00073E-Rv; Wed, 11 Jun 2025 19:44:06 -0400
Received: from
 mail-germanywestcentralazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::4] helo=FR4P281CU032.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPV6x-0003ue-BG; Wed, 11 Jun 2025 19:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHntNTLEMd4Rc9r7uoSL2Y0DfQceFHX16y9vWE/dXwt92ULbUraua5mkzpLlKl6Sq1ZUU4VsFrlhMEv5PsdrhRorjwG5EExwEhmPgMwKCYdj0K7jclIkjnqyjzlLhu8kIwcQtY9D7XgausQsP/tqK1wLXr+Ccm9//2LizIeicm8uTpBl50vzytHNAAz4yHohE22Foio5bP0ACoO7Oy6N0vD5b2DDFVHz/UQv8zNILj2W0EmaR/yAl9S4/0YOXLdw7i4JLTONiy+16ygajS/h3Gvv3+ImKHkxTM3MOcCX8P7T4Py8EVSra51fPlLY207TqOC4OMKwHlij4vFkm+teSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpEzLqB4kdv1vvbQygbDdDZSSHRA6y8Bo2FblcP9CBQ=;
 b=AipUAsQckAK5TuRSXhTzYgblmJmyyCF7I3YgP6TJMQYUxAetV6I1dq6oxg43Ocpu/5U9hmwYA79t4lxPZFWtYWxKETozYde1oTX41CxPuRR0rGWBqbPk191liPbPYPWUuKocBIwC+v5KYQOjajGzDNXiJxXdExZaajFEDlvmcjLyeE5gYwCXFzezOa69dvTHi8SRJVG8cIazX9QH+7W5Z9xHYCTl8NcQpxtne1yDHLXedThpyUMryggw1ISZDGBoq/4PUwb8tbnnxmGUoUTb17Gu7otNBzZFgT+wmkfU7ltMJmwVci7yf9Jl4rsKSvdvp6gtvS7/1gRWo33zRNLSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR4P281MB4028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Wed, 11 Jun
 2025 23:43:56 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%6]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 23:43:56 +0000
From: Tan Siewert <tan@siewert.io>
To: qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH] hw/misc/aspeed_scu: Handle AST2600 protection key registers
 correctly
Date: Thu, 12 Jun 2025 01:43:47 +0200
Message-ID: <20250611234350.40507-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR4P281MB4028:EE_
X-MS-Office365-Filtering-Correlation-Id: cea8e991-6ec9-41f5-bf35-08dda941d4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f22eCA5BuDpCIVvHt2cxy9rcu91+3sKmUvaY0wwCxrtZ32rnjoRWd1ktoND+?=
 =?us-ascii?Q?vOChDUbBbCUHeIV4fGhFrIPpvbm/g6C8tVOZ6qsZcA2Xk4NLHIsYZOGF+Gy0?=
 =?us-ascii?Q?JmiNa4LegFHyc68yLI6rLIHqftOo9ZL+SQ7H0F8r5TZ/jyt54nQ/Y6fQUrf6?=
 =?us-ascii?Q?pzL5KxeLuCwSPCpu/eWsmW/P7NNrWOu4pCzp6rwcE09F0/ll/YJZAs6nlqF0?=
 =?us-ascii?Q?uUt+Cp0S/30tb6K8tZ1REeVjCb+qNDWFZdE4DCxZD9JC5QjkPAvVRUdvwHMw?=
 =?us-ascii?Q?GGkxsZKNNcop/4WROv8grj+9zGfRR0JmazfeITCsXS9cLE9qauuFQAKz16R8?=
 =?us-ascii?Q?21WNK1uXGIVzEGQZK5yL/mdvW9uAcR42fw19Mb2tCU4JMDN/ofkeMHvPXMVa?=
 =?us-ascii?Q?M0W+ZymUDc9loAx2Lwwbt+hEspf8ALTugev3gTN91HD3n37HuF08yOiNZ0/L?=
 =?us-ascii?Q?dX7VDUaiQIiVdGMFim40zlhLg+xliB90Q3kAO3Egq9zmHKHl4CIeR7mkRx9y?=
 =?us-ascii?Q?E8GdkQq36BF9S/BeglBzyUPMGBfFUWBTqN81lHGm95j/nks2Y3ADakfg2QJf?=
 =?us-ascii?Q?i2yipVOzMt8GmH+xH54tiSSeU1g8Z+QdkVf23PxKY8199ss+s5vfKUQ11vSf?=
 =?us-ascii?Q?sw4vPVVC/gronzZGTFnlVmjzHqMOwPuzc8a17CS0yBHQOBvyv28I68RZEYLR?=
 =?us-ascii?Q?UwezdlzQTPZXwTNaTIQyo8mDiPoU+JU+BkJR2NN79SiIrTXArd2vmylj0gAS?=
 =?us-ascii?Q?ORt/vZDoXfNh1pHg6moOB1Z2wvEpWTnrTxu/+DQn8S6BB6xYMaB08CxE9/Xm?=
 =?us-ascii?Q?lvVi85xGaOoy/Mmt/Pm00DIq+xZaX2SWe0GQD56VSbymIWJosGqFsJW/aYeb?=
 =?us-ascii?Q?ydhzCyXJ4MCWss3F5Ctj+qQja16DBOUcqhfxFZ/cj25q8/m1ooG1rIw/zK6w?=
 =?us-ascii?Q?igaPwhystpnbISdukliQqGe+ONorLdjG2u0A+MMflsRPAneyVSO1gBrWp7Ds?=
 =?us-ascii?Q?krVucsnZNzRaB4m/+QgtFNsEqaQRTMlLSv88yW6rw6HXTUN8n1C9XBo8Q1RP?=
 =?us-ascii?Q?BmUIHj6FMoH+dHv5PaqjebuWHpVVx31qBxOtsVF+l4UESuuDGpqiicAinwuI?=
 =?us-ascii?Q?lbKli6F7PeK8mDU+M771xTnimzbXKyIkuk3S4BRyB1/PjL+jLheN8Y57qc/q?=
 =?us-ascii?Q?h3RE4CBGFpfRx4vGktW/hbbIDYTRGmw36vhX/0gxDUId/Z0pgPbxUJfvxAGg?=
 =?us-ascii?Q?xyMuX4/+sux9KiAdbePBNz8lNOHxPiYaQTKVi0fOfzSZ2yNeb4uMz8CEBfmD?=
 =?us-ascii?Q?lSkxs56ZuyMTu3/LbXy+Mwr+31HDaFtnxHn9Wflf0XjNcf7rgq5OSl1c9ZXV?=
 =?us-ascii?Q?DVeeOP/tU15gttTZCaxG2E1tZZpHYtF9bTym0tOxQUZSHotY+tXC0Ayvwv68?=
 =?us-ascii?Q?Ze4LmuDytd4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1AHM+QpDsna582KpSl6iQzX0DZOc7UMBLHbhPTwarFg+abNSZ4I3iuAM6rfv?=
 =?us-ascii?Q?CthwU8ObezhlQj5XyIGcUrqbUNF6pQTI150xbXOW9Use7GgF/gpABsGp2ZDk?=
 =?us-ascii?Q?T283NE/C8UwATqejDsNubHsMIOIuuWVtXNEGSL7JBgRTDtCEXB3Ap2uU8YYW?=
 =?us-ascii?Q?zNiRtv3pgqypXBty2K9jYqAuPUpKFfBO9tXTpWQ1lsjI22C5wbXxSDF5WYIJ?=
 =?us-ascii?Q?YPqLxrfB76dW+s7Z9/tLcvW8QgBKnCHgTX2imj0WWrDBN0P6ezRlFzsbW+NL?=
 =?us-ascii?Q?x9JwuzRvYq0mgbrEYKJKVQXQvnxBpeKeHBhs1VYotzPrLTayz7dgGUZ666Hf?=
 =?us-ascii?Q?WJJbLPTkiODo6pMHXb/Rkzt7PWbWasPmquauWnRB1pZfmJJKp11z2OQ8yDbz?=
 =?us-ascii?Q?DRret6SYjSpTvPKk9VDW/ZZhF3tfhynXUimThnA7+cceMJS2Yky2NYesNUeu?=
 =?us-ascii?Q?sePJyM1/uzJUL3/unrppWwulNoZ+9OXW7lXsXdpy4yMgt4pELeNYrUrRpRki?=
 =?us-ascii?Q?AAGzOpN3AotxcGpVe9YlYwgBRmn7q3NnBehohXFTFezd8g+TsbqZXIvmCXuR?=
 =?us-ascii?Q?jM6jIPyH040cXrt6RaG/hctsTPC2pVHfXpU1/PhgbwGWZkEdeq3op/7wbpED?=
 =?us-ascii?Q?gcXdU+H3E1I1Q5ePr1haBgvmCBM5Gmlqu83VcXWo95ROIyE9doONI+JGiCDH?=
 =?us-ascii?Q?hPzRNJ6Ovg2tJ05ZLdvMMCUw1kmigjE/bG8h4vCK/TnJfQJYCGkR+SdnTzJN?=
 =?us-ascii?Q?AYsEgrJmAxz4nqyy8A8ldmsBUe/uOc391ifwQz3m0MotOQmTQkQpFVQaesNZ?=
 =?us-ascii?Q?64oE4hAyHa7e+fhqePtluFfgck/aDINWIcxzqArLu1SoFxeV+utyjstjEf3h?=
 =?us-ascii?Q?/pAHWSh/MiRONAqajbG7N5iNPWWAEi1urIN2JnKD6pxp8aZZ7UGcTPpDiXC6?=
 =?us-ascii?Q?e6/GdGGm0ySy7Tdg8d71LiqwSYwIO5ihFhaSAaS+pzIMM/Qkgnn53fI15UEl?=
 =?us-ascii?Q?129mzb8lYzEJU53Pvpj0PaHZpwnMQm9TpgCb6XMLsm1TJ9cSA/C+7q3XD75R?=
 =?us-ascii?Q?SlOUvVCvNDzsjvxhbg1zfX/ZO8lUj1zeikjzV7HeTin+uOrquzicRb9SDO6H?=
 =?us-ascii?Q?7Ni2ENGC9gcFGwKCuwu8e/4d9R0UwQC9haPC2B1ybyi+Mcuyzuh4Kqd4/1Cy?=
 =?us-ascii?Q?lZXs5twU3SacsjZAM/OJl36iYLHGdH/HCeaxP3xuFEI/4ESupSnzYzDtKK76?=
 =?us-ascii?Q?vyFMF4/L0fxR9wZaVmRHfQDHbjKP6yhui4yJ9E4UQTzouezi5LJ2NczFbzpQ?=
 =?us-ascii?Q?unc4EXbm0LRrqyuZfigACP5VOCATOPT293QeRfz+4oUzHFWQwm/hxSnzYu+B?=
 =?us-ascii?Q?aZIRFSe0acddPnevZwuVN2TLJsw6aNZhy7CcBXLt7JVfyzGyg8QLR064lD1S?=
 =?us-ascii?Q?LgAMsf2FJ8Bzt0eLeEvKj3MhLrp3ogKoa//yaFsxhutH10vrmalMnKTP9Yjr?=
 =?us-ascii?Q?U1hodhS0vouRk2XCvWD6V0mR6JlxbtEuWXXBnyYYTj5kHz+Q/5rFoMvKjMTt?=
 =?us-ascii?Q?tUg2gzY+YPe0HZhV8tVBxaDpewQnLhRCT7ehnU7rs5UuvlEFZRBmt0fMo0MO?=
 =?us-ascii?Q?XbnhLbbOfWaaEp1afYO+QYY=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: cea8e991-6ec9-41f5-bf35-08dda941d4ef
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 23:43:56.8680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0A03Td+qgIv3oBRxMu3nRZzSMCYkAWrJFazq+GgKsIxWRmAMBax44epP2gh0uVH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4028
Received-SPF: pass client-ip=2a01:111:f403:c20c::4;
 envelope-from=tan@siewert.io;
 helo=FR4P281CU032.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Jun 2025 21:04:44 -0400
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

The AST2600 SCU has two protection key registers (0x00 and 0x10) that
both need to be unlocked. Each must be unlocked individually, but
locking one will lock both.

This commit updates the SCU write logic to reject writes unless both
protection key registers are unlocked, matching the behaviour of
real hardware.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 hw/misc/aspeed_scu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4930e00fed..8e9eac4629 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -91,6 +91,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_PROT_KEY2         TO_REG(0x10)
 #define AST2600_SILICON_REV       TO_REG(0x04)
 #define AST2600_SILICON_REV2      TO_REG(0x14)
 #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
@@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    bool unlocked = s->regs[AST2600_PROT_KEY] && s->regs[AST2600_PROT_KEY2];
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -730,7 +732,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+    if ((reg != AST2600_PROT_KEY && reg != AST2600_PROT_KEY2) && !unlocked) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
     }
 
@@ -738,7 +740,18 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
 
     switch (reg) {
     case AST2600_PROT_KEY:
-        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+    case AST2600_PROT_KEY2:
+        /*
+         * Writing a value other than the protection key will lock
+         * both protection registers, but unlocking must be done
+         * to each protection register individually.
+         */
+        if (data != ASPEED_SCU_PROT_KEY) {
+            s->regs[AST2600_PROT_KEY] = 0;
+            s->regs[AST2600_PROT_KEY2] = 0;
+        } else {
+            s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        }
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
-- 
2.49.0


