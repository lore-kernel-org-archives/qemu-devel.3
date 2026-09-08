Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA00C79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIC-0000Fy-0K; Tue, 08 Sep 2026 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI8-0000B8-AU; Tue, 08 Sep 2026 06:43:04 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI5-0006bO-Hu; Tue, 08 Sep 2026 06:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCAgDyozHPfMNOiwu+fZkxOmsBBKFftFrRvltRvu+iiSFIXvbNgpkAKdT8+OZ8hYPiyPt1kTPCcVVaLR8sIsYUEv4TWVSodeB8ifap17uDIDgyvMDTzWNVhv2Td9SArS+P5NZFqhebLsS1BAbyrCT/Gfi0v6T5YqGlfqlO1RjLgTxpkjwrhWuNAhPKVvXBgEmCUmp5aluXbWbEihZ4U6Pz2YOn6Q3PeYGmTFNLmDXYQpoDYXlhAxJZpH7RrPaNUOaYref55zGlrMqNjP+KR6ZI/wjysUMYIxuEhcZ+RE98Jw4kU1MSrTN/tsSALyTpsKBdiKd6dbp+TcmVTwcKfSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGjwJretuWtxX2ihDuqbcoU89AuHLAax+FXYL4JbP/Q=;
 b=PqVnkrgsQjLSiN8HuoZu77/QkXDy3jfAhcXqQ9bEvmLtBfma6OIHeWwR/7AH9jcmxBzv/DyFwvHLi4nM/wxCRaCekFAxUYF9BwjDtgoTzGqWtt3Mgzw6sB6azOJK3nG6lFOrDTyTRbjnaqa5cA/Ujkewa25mrYjvt/WWjP4+TQV5dwvb2BVcp3IThZDWg9sPtTvIzIENlxkMiB2IBA5vRsxMhOIBYFhfrXb9+U4Jmh8Gam7PU2Bw0Lmlnlc5fkgVwNhrgM0yE6qyT5tqPMTwzu0sdWwpT95YaWZZDyskB/6cYajp0n+YdR/GlnNfjrv/JS/OMGm4+Hv9U4ZDRViw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGjwJretuWtxX2ihDuqbcoU89AuHLAax+FXYL4JbP/Q=;
 b=nM4dEVvNoNSB+cyT9rnK9w2/PXLBxxifql21Qci8oEJ5hBpfzSgQQanP2C0U+Uwjc7jSzFsNJNSjeejilVLWUbEVg5wOcCBs2Zu2iywD2MQkDq/qngJtEFPpD3NFiLV4DCLXDbB9BrJ2qGIf6FuM0ly2Xua3f6O5ZqeS91j1cd9by8K44eEYdfpl036E7gS3SUH0LwLaBIkAU/tGfew4Ies5ejgMedpwsw220kv1aRRoiCJET8LlOM+Hr/ECrIk9pMm3Ob0aKKOojnuL6JhIDEvLpf6R7T5xC9CMkncF4XFHtzPONecJAkS1B2VZXarcFPmq2S6VQFPyxOMaqFYbMw==
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
Subject: [PATCH v2 24/32] hw/arm: phytium: Add Phytium E2000Q COMe machine
Date: Tue,  8 Sep 2026 18:41:33 +0800
Message-ID: <20260908104159.1621764-25-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c443c4b-2fab-45fc-5b1c-08df0d95f080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0/qd+lMqGcJItEq7LPeYStXIa3xf7Yx1N9jE5R8xcwL5teF+E65OVI4P52palzfc4PhX5qrmT5AS6D5AWPOPa6eROStlGCjan3wXB+WcPJgVBSOL9cmY/HKHHV6YdotZVz0CeX9smxXrDvr7tE/XQy/Nyp18itAVpUDsAHgALjrsJ98w9cCkjU7MNxk8zE+vijcvMaJNkIsopVhhLdGqGqtD8BttH0ze9QXtsOA1is4EWKS8mkVWs2UDqA/BplJpHjRjmemSM0XEaff1DsM6t/WICALQNizmA+HDn1aOPA0VRudgbVcCUO9YIHy3SCiyPzZQin5FRjRNjIMOGC7JJ59XQPLDXdj65gYZcPOO8qmsosIMBCzLPPViGBDfXw/bYyrHSNtZkUCO3KsIQombzQZ5EBcK2howu0zOfbIQ77TUdN6C2iAvjeJhtsmMl1ZALxmcRrJojO1C1Uav5b3ptgW0oBXeU6clBI5tRnwwaYKzWKtCViXK13pLGrXoJlb2t2nwkxe/GFSFH9bgMzLJLXO/M1dpFUy+FeKhtqT8mAlAAGsLjxnPFhWZys3uTAY6ruXL8Gdu2PDJCqSzHu14ysq1AP56h8hbT9P0Xo+wtOpi/B1hCVWnvFazgrR3f/H4UkRDGcuI63S1JMycSAXyUjWLXVZWcaYR8/AXe/+HGGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9nniBFv3ciE7Iud1p6+wzdmBfkh4f3NVWB1E0wZTIzYBVRlAaNbTmp+kTp7?=
 =?us-ascii?Q?rpggeIgvZv+0Ufd70jDL5l950beV14DIDUDhZPMaXVsJ2Z6HzOd3zxceoJ/y?=
 =?us-ascii?Q?SvV9jdxXvduwpUbsN5X5KkaTrxJ8INOHeQKv8FuSH0sckIcT8zBHNdJ9WpoB?=
 =?us-ascii?Q?W9MJuVSSH9HX9lS55DcFEQ7GfxKoS1vy7yYaJ7n/6LfzJBcUSWRvaPGkYFrt?=
 =?us-ascii?Q?31lEBm6iogxCOVUVqHxsMxPLpog/xytDHth0gcWrAj3uU1DwytlyO26jLn3V?=
 =?us-ascii?Q?45VyqNZ7N1SD5qCZAbZDTPww7ZIWJJWCqp5yHvy3z+wqWfVVUVSzX45czUxf?=
 =?us-ascii?Q?RaG1DS/tHbpqRuhATysqAdhCNBgCDMHcUH0NumktSe1rHYUGG1UsEUM4ARpE?=
 =?us-ascii?Q?1nCC8bpLkDRpp8kNPC5TK/a7pLKZuEceuH8qwjAgfwAEnZ+VpIY2Q1IG2n8Z?=
 =?us-ascii?Q?JnaVRc1GktajCv1a3YWYAYZbAhXMtpHoLZr+XFHLaKq7vtyWF4oQ8CTwPzSC?=
 =?us-ascii?Q?mK6HNoP57DgrEiy5sbmnizeuBOz8Sii5636WzP6whM/5eNgE4TDd02K7dNK7?=
 =?us-ascii?Q?nzvpLXWLADggHGpI1FJCzPTkkliPJTIa6WAU7mEJTjWeahY9WdOZEPiZQoRX?=
 =?us-ascii?Q?PtiM4mTU/UZs5aSgd0uOb/n+hAfetTzIvom3A2Ak0o54kyoa8Ebxt+7xtwdu?=
 =?us-ascii?Q?4dSn+m3ONCGLmPWliSUaOgXVKY8781hi9k87ZLYG8X2b3v8rzc9v7DvYe6lU?=
 =?us-ascii?Q?767lJMU0fnOqZfYOApBj2HYzGaIIQlWeBidVquB8cuHY8JwfHApAPZz1QIIc?=
 =?us-ascii?Q?A5F0Wo19p2wtuN+r590Q4Bk987Dxg3VHbwMsBvHq0ztclgNpmtrsBw2Cf3Jw?=
 =?us-ascii?Q?ViMSJ68Z8DGrqG3KTs4tDWvf7kDNeQng0bqs8HV7gXaapEViaA5Wyihz4OH+?=
 =?us-ascii?Q?BgP2cbOKHrM0CKJ+VR/63NN4a9q+qnRmcgtGOTTA19p18XCAIEYOg48cgZVB?=
 =?us-ascii?Q?Ei8EcqbvyShsk2uP2+0H3tzvJMnhxp4Mhv7yQ2Mt5ggPrEhh8LklK1kPzyOG?=
 =?us-ascii?Q?5RIzBjBPnDiMXo+aO9XtQKFTiET+SqBFajnChlALnS1b/9lL/dj42mP6z4pw?=
 =?us-ascii?Q?DtO6JuS0yWNyXjXpbGo6DKnwHrrTec5d4+wV7dbip/8DSQq7shBv8WdW0N98?=
 =?us-ascii?Q?PEP4QSCkzojIs9zrzJUbm5tudY8mo/i//sImJbBfmtKkGKL9PVgLn4lYHH0j?=
 =?us-ascii?Q?nmFbUBIW5339g8OPMaAlgrH4/tzQLN39GHYzizd8TpJyMKoF1Z/VuKkPlPTm?=
 =?us-ascii?Q?gfLHyOvrVKC5OtqWNEsV3dpCNe63AVSH+RmbPbM+nrO9TWtcjO4hmho9SNJu?=
 =?us-ascii?Q?HPLqKr6u6Bkd2Cv63WOfony9LZH6YVopHjpxqx3CvtODmSFPg8hh03Mru1K8?=
 =?us-ascii?Q?JpT0wusEjidcSSX8Jg0mEzhm7IvQa3C0oUGj4nc+/kPK8KUEZN1QD/ZFxGAL?=
 =?us-ascii?Q?es9WIoSr3h9h5NSMIrXBnvZ00jeXYJI5Wyv3G0CLdE35IZ0t3JBXhdYMa3l4?=
 =?us-ascii?Q?18tu3Hchkql8xchidcMJmNM28x3G3C6D46qsFWhfi9wI1TTvQi5J+rRefjKT?=
 =?us-ascii?Q?EHXUUNhKmDdSdieHVy0/T5zJrD88r0Y9sGYD23f3/33MkViox4U1v/bo+ofW?=
 =?us-ascii?Q?c01zZzU93IjnZnAaTve51/p03eZ5dMvYC8dSIwY25loo+723Jg+JC3LJ6Sxq?=
 =?us-ascii?Q?kORX6xRCfd9RAQCg+ZE4Bde5AF5miyI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c443c4b-2fab-45fc-5b1c-08df0d95f080
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:54.7085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/hw7iYCeiC7iNDFmUzasUyj9/za47a/3B59sU/MpShGhCzkgn6u32G5+W4ehE0ogZ85vrNd85CiZ8ROxRTpU0pLZPKekewwn4kZCjockas=
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

Add the Phytium E2000Q COMe board as a second child of the shared
E2000 machine class. Keep Phytium Pi fixed to SD0, while COMe selects
QSPI0 firmware and requires its own DTB for direct Linux boot.

Instantiate the same E2000Q SoC controllers for both boards.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/arm/phytium_e2000_machine.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 41bce8a64b..c1944cb986 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -30,7 +30,8 @@
 OBJECT_DECLARE_TYPE(PhytiumE2000MachineState, PhytiumE2000MachineClass,
                     PHYTIUM_E2000_MACHINE)
 
-#define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
+#define TYPE_PHYTIUM_PI         MACHINE_TYPE_NAME("phytium-pi")
+#define TYPE_PHYTIUM_E2000_COME MACHINE_TYPE_NAME("phytium-e2000-come")
 
 struct PhytiumE2000MachineState {
     MachineState parent_obj;
@@ -292,6 +293,18 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
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
@@ -307,10 +320,17 @@ static const TypeInfo phytium_pi_info = {
     .class_init = phytium_pi_class_init,
 };
 
+static const TypeInfo phytium_e2000_come_info = {
+    .name = TYPE_PHYTIUM_E2000_COME,
+    .parent = TYPE_PHYTIUM_E2000_MACHINE,
+    .class_init = phytium_e2000_come_class_init,
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


