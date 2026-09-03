Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17391C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25b5-0006Nw-4H; Thu, 03 Sep 2026 07:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b3-0006EE-CI; Thu, 03 Sep 2026 07:27:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b1-0006ne-QP; Thu, 03 Sep 2026 07:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAZk9foIr/ylE/f5FfUdD4nxfz7jMXB7owVT/G0FqniXyeO0zAbtXl2+7DGePOwQeJWvnyUlY6kIfShJ5WHCOB+At9TG2wJeZuI0J8ErWsWF9rCG7wFVPLmYJdtkj7t8fomfrf5M4SFbIjYhU20CDNUm2qhvV7BgBvZTvESXko1zlr9dy9Mb5iWrQlPDFAHz5128/DXOonuKxi2/vCMRSB6BeN2Fre0eappYEiL4pwoPmcJMBTSp33tAS2DcsUeb6pHyN77AxSgKsqHXk2GZHD/nEv6AjuOg3pgcpXpUzYcCZKyNLd+aJnkIj5mjQ9QAfAXj6MG7RbR3DqRo8o+7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+wCIAWDev3PCBinSAnzOKvGLq2iKg6PRtVfzruz6xM=;
 b=vwFUxwwCpZO3E3wAwUAx7rL3fEklcok0OCDyonZ4SqU4CHn8jSErc8rBEiaiVHe9I6L8gzg01YojuPX8l8Zzr1QdfCeGXUOu2jAal15jOvruVh9Kn504OUOrFat19PsuK5DXr2WhPg4+0+LeCYkPkNbfBiVdUgw06ztOyB4wpdpxr0xgP7Jo44Jg25jvPkYEQaonGSJHkx4q6MNarVniN0yzOyLjAm+HS48Ymiwua5O27/rFyP3s9/uHE4EnUSXpnBpg3HbivC3mMg9ZcQrzOKdE5Sh+D0xAIf4jwqNKKDOUt8oLB26G+Bv9/ZLQwcyKOIyMxS++fI57ytRP9KV/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+wCIAWDev3PCBinSAnzOKvGLq2iKg6PRtVfzruz6xM=;
 b=BpoXk9bNX2lZhbOZ7pDOgBPRQw7Q+6Gkfzug4NVVB898dyS8R/eCOflY7e/EPHhJotizX11MD7MzxzYZIfR4D+V8zvrEcyrgn50m2aMYzUDqVgr78fIwpkWtEFt1awAozpoVzAapvBHlR32urH1Zrz4cKW4DewjQjjs+xRWfv0zi//DDtv26LgoIRfPhjxASUIJgAePTKNoOCTvwh+opYCuqnoEQBgxsBABZJF/GfCzB+qEyjLIA4t+Puz0hh/mY+tLfaftL0QKOkzPv0iFHt+wj7XzAQTN7Xtxj9FuOGqKXX52cDs+/gVCrg4qMrcDlFvfDTnSEbPsXIiIk+uPKaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:39 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:39 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 25/33] hw/arm: phytium: Add Phytium E2000Q COMe machine
Date: Thu,  3 Sep 2026 19:25:05 +0800
Message-ID: <20260903112532.3276678-26-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ad2bd0-cf07-4f9c-f151-08df09ae3898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: XEHWKlQRoeMn/kIPsecuO4I7hGNu6B6NIcoCZD0Mvzh+PWbSrRLjY4ouGMudheMQXLdrpWZ2qwjKa697RS4HpNVAAln1TK68y22qUmWtf6dxbvmVcM4AgMIs2+jwL4WiWqeBeqTUH4DayLhPvKD7CdYfOSqM2TzMpeb5haYB9sMhp4qn+Lmx1gTmBCKODh1njfG2eeiIHTcXMMBptpbN9YTLEA8aEb5pWVIw4/Rce/WQpMm1dSJNmsev5TrxbDOBH9NoVsr1YkpLuKfzTD4GgW9gPDaOOt6FFp56OWzYD4AffV2Lbp5DGNlbOhwC+5/JdE2fTgejtlufcKBa9CmrxkOFzovvI99hIewEUzxWJ6mJ/0Ln1afdRvBw2aWJ+b+IwFonqy8xLBQgZLyfyN0LedqQqJS2E9h2QO8+lWB4sFACw0CZMUjhKgxxd8nHE56HIrOBvrCXAHzhUCxAOQSkwkzrplPWxffunAoiT4qcdhZOqxLT+7Bs1Umj6NrnD5YG5+CZYt7xIbe1yR7dbKIq1fYbp3zHgE1DO4XkuyHzzxlJEb+TQcc3AIDGwdzf/Uijv4RlMNWsVuiv6PIqZ1bw5vTxo0Llh3cGz1rhU/1OBxv3Q44KK2hNAMlTq2YPz8ltvHHJZSzKD3tM3VLX83GM3PhARtxdpezxm5tvGEqGG9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10fafXf3OK/rHUDgX8IZ0zXoYLwfHxwxheoKXXP09oOg4m+sEmGoWdsVLRpm?=
 =?us-ascii?Q?czss6kTiyQc7ovyKB4sssLKlerlOdCK9u8G5H2Oj9lgFqXAVo2dRH7xD+Pu0?=
 =?us-ascii?Q?LoOjeECWEk29bvSVy+WMymdTCT80XavdnPuDcEBuJoFE62x3B7ZOI8X5i7e9?=
 =?us-ascii?Q?/gOtd1QPRfn6vjvZZipG5WydzYwLuXiD/Rep8C9c9zYyY/qqu4TxYv2smhxP?=
 =?us-ascii?Q?3iw4N2YK36TpBEWEGSbNHVcXBP+zBlgfXjY1j+E9L8BCo/mTtOWlG5Jt9+Zr?=
 =?us-ascii?Q?fhNfBt1enZaolDpYogBAbdUGWI5wY1XsXHP0bmE+doFxWeOsX05giGBfKN5F?=
 =?us-ascii?Q?E8dpYyaywPyZOZnZfkYu7e9mqKlutWWSZBStUKXtudE65gWwBUReKGG3oqNw?=
 =?us-ascii?Q?cxe0jCJvVdUcUCq6WlTeTk2nSz1zQd/bDFi0D5srLVBp30UrZQQfIVKgq0NT?=
 =?us-ascii?Q?XBeQJe7BvIDk8EIPNFlZQBVKjSY+3zcWNSaMn5rSI3rHq3+M/G/qEvb/yVIQ?=
 =?us-ascii?Q?7skqPwcMN1YlhVF9Dx6X1ahqUgFohRtLhbGl/4605RTdtfYqnlWwhJm5dmbb?=
 =?us-ascii?Q?d+tJKzVBlytvZ/ortLxC1rrxLWI47xjdMZt0/I7aqtg/feTXRhUoz+LRUyBF?=
 =?us-ascii?Q?RhOopS/X8A5sJrDvDN+eDwySPzUoX19N/3ZF/HT7sYcfhnpuSxSRDtZS7xUa?=
 =?us-ascii?Q?EemsO/R6WT/IJwh0G/GFwEl61SI1swYNi/gt7N+XTbavsdaNM0VPkFQ65uvm?=
 =?us-ascii?Q?3fD1WFIZ+WnsBebaN3gDTwuLubXoPoeIuN/1t2Nj/ffqRU4lZdU6/9z7UwGI?=
 =?us-ascii?Q?aiqhI+t9InLS/FK2i1SUOFZV6eO38g2vAwEV3zqmj1k0OrdJxPpC0SBDfilJ?=
 =?us-ascii?Q?LKMIbfd8vXa+am9zRlQW2TakoUs5alGmrBvYlaq5BrH/tW7DlrUqpqF07n5w?=
 =?us-ascii?Q?MCc/NA3pSdYJ0cbhK3jySTXrOMd16fu7EuPOQrjfNsM0KQxQoSV33BuNgRDA?=
 =?us-ascii?Q?tXJ+qe+i24e9kcpVn7mDxpRf6SMjjMhk6I1QNstAgtdbnDMtIlCwT8b45+em?=
 =?us-ascii?Q?trfuOocQKYuV4pmj0bCFjJ63H6bIcN8HcHXh5Eyt2jfHI4SqoRA4IKG9FYZK?=
 =?us-ascii?Q?Sup0JamI8RIrDjlHjcRSr4fP5lU8zrHtO9CLsgTEMZ0faP3gEH8z11Y1HhaN?=
 =?us-ascii?Q?l82r9BH0zjaegOaMjkXhI3Br3mjGpN7iZyETosdyXrIxo+u4nq+CnkY3nc2n?=
 =?us-ascii?Q?DX9xi+gV/lXNA1PNb1cBh81RM+w3cuggCKVYuohpd/oYMPpl8pGt8Z3/HoWL?=
 =?us-ascii?Q?hPP6I+C+EqvdlEi89Cp+gjlhQAf4t7z9bryZZFkrC2XsO5WmhnVi6TFteygo?=
 =?us-ascii?Q?dfmfQ9sx6kdBBsrEux8W0cR3IKx6ocHmWm8f3PP01DNcctzhCOyj7jHNah1J?=
 =?us-ascii?Q?/jkmeNXkn6escJri8GCWf58MzBX4b/+qeWW/0etwxEPsxjSO+y13ugdpjE2D?=
 =?us-ascii?Q?sBvxG5PCzK5g4ArmF3m/XEn0tP7ZXJwOW/LvAGG1BQYx7E3vbHRwoyA+0gi7?=
 =?us-ascii?Q?ZruP1WUSdElXz8UdsVZuoVt1Xc4PP2AObedUaZHMczxHpZMUnJjsM8UdTEJ2?=
 =?us-ascii?Q?6i9AxxmqaUhUK24VzW4BkLSZhfEaxUp0wREJzJPh0D+LzeMBy6s3rsCwrhOH?=
 =?us-ascii?Q?HjcESsZKRpt45hY6xq/2nVWDb95aNBsRXACqHVGBtOG4uL4cuWwreClrtG4V?=
 =?us-ascii?Q?ieEDK53vLtWPzIw+jTeI/h8LP4anygo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ad2bd0-cf07-4f9c-f151-08df09ae3898
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:38.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoAKekhSQZfR1Er/OcxbpZFPqlO3Yhic/Q2M3aPcdX8MqgYxO0DkN2pv5HTVpk2xu5fF+ovNC9h1g77MKCWHgEOTJIoW978ZbOVrpLnr/Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add the Phytium E2000Q COMe board as a second child of the shared
E2000 machine class. Keep Phytium Pi fixed to SD0, while COMe selects
QSPI0 firmware and requires its own DTB for direct Linux boot.

Instantiate the same E2000Q SoC controllers for both boards.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 5d1e528cc1..5a2155ee32 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -53,7 +53,8 @@
 OBJECT_DECLARE_TYPE(PhytiumE2000State, PhytiumE2000MachineClass,
                     PHYTIUM_E2000_MACHINE)
 
-#define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
+#define TYPE_PHYTIUM_PI         MACHINE_TYPE_NAME("phytium-pi")
+#define TYPE_PHYTIUM_E2000_COME MACHINE_TYPE_NAME("phytium-e2000-come")
 
 #define PHYTIUM_E2000_NUM_CPUS        4
 #define PHYTIUM_E2000_NUM_IRQS        256
@@ -1013,6 +1014,18 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
 }
 
+static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PhytiumE2000MachineClass *pemc =
+        PHYTIUM_E2000_MACHINE_CLASS(oc);
+
+    mc->desc = "Phytium E2000Q COMe Development Board";
+    pemc->machine_name = "phytium-e2000-come";
+    pemc->direct_boot_dtb = "e2000q-come-board.dtb";
+    pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_QSPI;
+}
+
 static const TypeInfo phytium_e2000_base_info = {
     .name = TYPE_PHYTIUM_E2000_MACHINE,
     .parent = TYPE_MACHINE,
@@ -1029,10 +1042,18 @@ static const TypeInfo phytium_pi_info = {
     .interfaces = aarch64_machine_interfaces,
 };
 
+static const TypeInfo phytium_e2000_come_info = {
+    .name = TYPE_PHYTIUM_E2000_COME,
+    .parent = TYPE_PHYTIUM_E2000_MACHINE,
+    .class_init = phytium_e2000_come_class_init,
+    .interfaces = aarch64_machine_interfaces,
+};
+
 static void phytium_e2000_machine_init(void)
 {
     type_register_static(&phytium_e2000_base_info);
     type_register_static(&phytium_pi_info);
+    type_register_static(&phytium_e2000_come_info);
 }
 
 type_init(phytium_e2000_machine_init);
-- 
2.53.0


