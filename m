Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C9AC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gq-0003kx-9J; Tue, 07 Jul 2026 04:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Go-0003kL-QM; Tue, 07 Jul 2026 04:35:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gn-0007zQ-0k; Tue, 07 Jul 2026 04:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM/3mNihpfBiYZWdvi6yNiIVOX/Zem8b3bTpJpdfR3boZsmKegLj7kvQemQB8jirLbtWbSXBoz1k66FlHlFuKOT40Zytq3SMC/3KvgH3BB7F4scFOyU1iT/bfEVz7NbC+3UHEVQA42hDHY+bPYa/VeDAZ2z2hUfjc64FmkJsRVwohQ+KhHtKoVlCUN9cAshrYSJXFxrS1K/6Qe/TrKRlEWXIRjUpzqA3Ypshqnp6Qlx+89o8ST3plcCodRxcBWI8q72prFe1Q90jC00KAuW/QmozVeizXQK57FcopXobqhdRRgjGVgMFoq6kUgbFMpUNDKt22pX/5NXAtrDupaUGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+PPjBcM/H6xlGkv+OMSHy3d9dSjMkgQXkh5ADALi/w=;
 b=jHMn4h1po9tws35BpsQhf/t9JHQOeEWtCyMvt1YclIytqz7O2ivTFo6lQoutrPhCFRm1sHb1A6koXM9nHJw7OftzEnkLz3fkY+2WzQBK/rPWl2VCnyTmY0najhg2g6qAQfDvKYVsnNHS2Ij0NiPptbMHa4BnG97fgYfE2tSnKbpD/ZmTWAEPAi6DAMbp4kVvEd2js47HsEffthp1h29aj3J/NX3tKeJJeULuIeVfAxN300S2hXU2Qg3W0g5ipa5HZcfZauuOZsCRgneQxGI5F/Plwse4UySgXjx63gptS9NcBVsxCu9eNjEtaesmGXu04kimNYuRx8/bqgl14BMQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+PPjBcM/H6xlGkv+OMSHy3d9dSjMkgQXkh5ADALi/w=;
 b=XKdDeMHcasBVkVAsObKyS+AbqMx/M8hH5iOPH+8LiVWxHTx2bDnfYK0km000JrjY/mXljoZMXrVLS2fuStoFxOm2Kd7Q/9XTCsDekwNU6xur5mwgM6ovbrVR3dMxS5vWsHlFp0NOaGrr3lmdDxTKLDSlIIp1Sxv31w/cD5vXVfrVuKAomTs5xoytpdezRsXUUvCQ1jbAMkBhctbXwUKybZQFbPWOSqhnWzi/1GbufXBCo7PRk750orBrZGv9uV8sfKCLqQ4ekHlZmWU8C+gQWyp09SYO9xyrCQfW7c4HPs9nirWbyl+um90oTabCyRztuKKlmX0jt2x7XEHczsrbtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB5558.apcprd02.prod.outlook.com (2603:1096:101:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:34:57 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:34:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 03/10] hw/block: m25p80: Fix dummy byte handling for
 Macronix flash
Date: Tue,  7 Jul 2026 16:34:22 +0800
Message-ID: <20260707083431.219671-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: f45ac138-c984-49c8-30e5-08dedc02a044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|1800799024|23010399003|3023799007|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LcFQZlJ9H42RYIT0xOEp3drxDuvR4VmJCaU9S7FbX3QCz/LzB5CRO3M946MTHc1o7H/w5WvwUJHfD2kPhNGuLQBFSa6ffMuIfTKpvEup6R+t8FAXmad9RoSiof0OsKoF0iLsZvGxToUV/EogDPvVe0DoWmvIlnEmErxxrHbAtEAM0rkJnZfgDoDb4gkJPsWr2T1ZBkiSjodR0crMGA11Lp/3GKTdtf1kXStcfegIUesm3EEF+UznXFHtYJB01o4mPsw84szMnpruTagkmkQFXpEKMqdF1MQwmyFRqHzoR8RDT1sjNmgomYMr8VSzRC9G2+iE0pjI7DYBCjS7KQa6pVoHqUcY9q0S9npoJmuavGtm4WQhtadgvdjv3j5mnqm05J8Yn0ThqRqcDMljswO1gjO5YSw+L42l6J2M0/uwtT7plhY1UQwOymy8m1hTSRc3mZoP39ymMOBbqfEMyokm3d1oiL4OWDRvHQ97KON9UXoo4qfwbAooNQeaXqIZYIZOlKD1SgIkTQVl6LYbDNerYNXEt4WkUzd0kngeAxlbVWvW9jiJonoIvyX0qn4dgG9ZCVd3/fgNcy8t2glKx6MbloC73Y8scVi0HUDVwgtOqkzhV/ObhqGdHj3LAfAyzoAJFcnQ2cqp9sYPhye+08gv9kNbC6jUC8E/Ut/jRwNXz7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJObVJUdU9XYmJrN2VYK1VyL0pPNXVpQnFQVTRWUSsxRkRIWnNFbU5uYUNt?=
 =?utf-8?B?MmIyTnppZEV4d2xBbk0yZVA5aXVpcC9pdFRLOERyYjZtUVUxTU0vazZBclRR?=
 =?utf-8?B?eUdxYm0rNWRqUTVXQzJaUU9VVkZlMmEzd01KdGY2cDRqek9ReWpraThQbDNz?=
 =?utf-8?B?QTBGa2VrZjAzaWMyUGNMNWlJcjNvQ0swK0drQjFSdi83L0piWWpYbWNpWGZh?=
 =?utf-8?B?QTM5T3g1cThzUjU1SHFVRVF2RmdUYk91OS9TMlNyNE53QUQ1ZWtpNElZdVRN?=
 =?utf-8?B?dFBxVnRiRGczQkpHclI1ckJxaVVld0paZkozdXdVUEdiZUJJb0FSZXQ0UHVC?=
 =?utf-8?B?NkhRRUw3cWtXSDI0dE9mZXl1dnF0cE1LUGRyZGZXWWU0N0gyUDRGcFgzdlhl?=
 =?utf-8?B?enhUa0ZQUWFjc3FybmkybWJ1MEg4VjhqVk5tNXplS1Avdkh6clE1YVpxSHFB?=
 =?utf-8?B?eXYvQS9FUHhJY1RKbjB0WitXVHZaTHlOM1dDTzNsblJmcVRzZ0kySlVxWWtZ?=
 =?utf-8?B?RTVQd2xBKzNodUVVNmQxSEZCdzFxdk9BNWRCZ21ocndtQ2NwcTRsQWhOeXQw?=
 =?utf-8?B?YzFsQ0FpenE4UDlGdkNiOGxDZGJCWFFUcmJ6K0hFQWo3UXNRTUJoWmRlMWhj?=
 =?utf-8?B?Q2d6MXBNQmtjYlJ5OHdIQlhYdWNkT080WElRWVFuSHVnSkNRMGdXREZCam1B?=
 =?utf-8?B?YUg2M1dVUnpUY082RTVLUlhWUVF4Tk5SM0MyYThkZk43TkxUZU40NWFzYkN2?=
 =?utf-8?B?bllBTkRZTW56VUh3NHU5ek5JdjM1aW1wNkp4YVNvWnhBY0ZOUG9pQkxuUW56?=
 =?utf-8?B?cTEvWU1SUkpDUnBHeEtBdGdjQXZUWitPUzRRRk94YjRzRlpVdFFKbUZ2VmFX?=
 =?utf-8?B?b0dXR3VabHlSS2RvWmJFSUdvMG9OMU9DcGNHbjN2RmErUS9BWjJST3VMU2Vs?=
 =?utf-8?B?U2k2anlRbWVjcFdub0kyNWVBV2NMT3ZtVDB3R0doWEpmdGF3cENGcmEvKzZ6?=
 =?utf-8?B?QmJwM1E3TGJsOUt0bVNYdlIrandUcGlha2NFdFA0SzBYTExTUlk5V1NtL0xM?=
 =?utf-8?B?eFllL2xKUUdzYkRPZG0ySndvSzlqQi9aQXVNMGtxK0h0VDl2RC9vY3Zwd0pa?=
 =?utf-8?B?Qy93TW9xWmxCUUt5Z1cvS2JJV1I5cm5rejNZall2LzQ5bk1lWjVBSWg0WWpE?=
 =?utf-8?B?b0tJL1owZ0ZyU3dabkpVUjVCeFFocVMvUlJBaXM3Z0RUaGxCNFVkWHl0TkJ6?=
 =?utf-8?B?YlRieWxwQW1DakZiQ3BrT0Q0SzE2aHcyZEpNaEE2VEtBSFlyNXgvK1lrZkI5?=
 =?utf-8?B?QjV2eUFYSXROWXhIUkxYb0Faa1NWdGdPazlUSEY1UWpVVnlHcEUxREwzWXlD?=
 =?utf-8?B?OWRST3pyekpBR3hyRGkzM0Q4eFZvcDR5cUUreW5DZVdnS083Y3lTN3M2SEpQ?=
 =?utf-8?B?alhBM1UvcUVGQzFsVExiRkRjdlpVNTdnWXBRRWFRblFtV3liMUlFdzN6TkY5?=
 =?utf-8?B?Uy9VNjhwYklCdU9jVUV1UUhCRGZ0Z0FJT1BYKzJYaVVyVzV1TEt0dXYzWWZu?=
 =?utf-8?B?amdSMEczMy9tdzFFSzVoMFBhODNLNUlYV1hjTFFCQmtnUHZHSmVXcTVyQ2ds?=
 =?utf-8?B?SlVKV1pacmJLTUJrU2F0dSt6M1IvVm5KYUtidFV1eVJvRjl0bkozWE9uN08w?=
 =?utf-8?B?SkJ6Qkkxd0wwRWw2YUg3c3FCRlhRWWlTTVNPbzIyVVdyYWNJRFk3MEtiaHBr?=
 =?utf-8?B?YVk0UFVYNnFjeVQrT25ISDFCZlBuRFppMHdtTW1CNFVXZHNUaFUyc0M2Ui90?=
 =?utf-8?B?aHhpNFhqaGE0TnJZQTdaQXNyejdtUG1HY1FmUDk1Nmk5RFlCSTVhUmN3S2Y0?=
 =?utf-8?B?dEVUdU9WYmhKMWplem02KzBEd3A2a1RDT2Rzc1FXbGR2MG9ub0ZweldhZkNh?=
 =?utf-8?B?U0RWWmxCUWpwcTg5VFh4V0RpZ3A1U3UwYXpaTDk4NFJYdjRjOS94TFVaLzJj?=
 =?utf-8?B?VE5QdlF5allISEx1ZktMR3BlbndyVGtBM05FRjF1OEIyNVhYQWphRHlFMGpV?=
 =?utf-8?B?ZTlLTGNCbXNJQjRIcDV4Wm1wVlV4QjE1eFczQmthL0dMYUFRSG1UVjdDUVo2?=
 =?utf-8?B?ZE1lUVZUM0RIWXZpbGl4dTlFRnZuSGZaTGV4T0U0TUhnaWVVR09xVkxIVVFH?=
 =?utf-8?B?bDF5bmFMYUV1ZWMrakNzd1FMYWRFME5qd3NGSW1wT0N0dVBTNkpqMXlydFlS?=
 =?utf-8?B?b2dxRUlNSXFhSU1LWTJvckpsUjk3Q3JKaHJRRDMyOGRIdUFBWWVtSTdTT092?=
 =?utf-8?B?bFRMaTA0eWZMdUQ2a0VGVWlhbUNLY1B1RFFRTG5NZGNlYmlSeFNKcHNGbVJV?=
 =?utf-8?Q?MG3LjKYtTaWn86uc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ac138-c984-49c8-30e5-08dedc02a044
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:57.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI+J4K1WNxrV0GjGZLpxF0b1qNVuI+NCMBDb7f+7YUojAO4m3YHoSyVPKiCvbjnnNnxGRMKCfEYH/QCSlkeM4xAPqJeUZLtw0wFQSPqJuHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5558
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

Macronix flashes expose DC[1:0] bits in the volatile configuration
register [1]. These bits select the number of dummy clock cycles
used by the fast-read command families.

Convert the Macronix dummy-cycle settings through per-command-family
tables and round up the non-byte-aligned cases that the byte-oriented
SSI model cannot represent exactly.

[1] https://www.macronix.com/Lists/Datasheet/Attachments/8657/MX66L51235F,%203V,%20512Mb,%20v1.1.pdf

Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

---

Changes in v2:
- change macronix_extract_cfg_num_dummies() to macronix_extract_cfg_dummy_bytes()
  to avoid confusion
- use assert() when the dummy bit count is not byte-aligned

 hw/block/m25p80.c | 63 +++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 83d1ce1f95..d7a9d79373 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1024,6 +1024,39 @@ static uint8_t numonyx_extract_cfg_dummy_bytes(Flash *s)
     return dummy_bits / 8;
 }
 
+static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
+{
+    static const uint8_t dummy_cycles_fast[4] = { 8, 6, 8, 10 };
+    static const uint8_t dummy_cycles_dio[4] = { 4, 6, 8, 10 };
+    static const uint8_t dummy_cycles_qio[4] = { 6, 4, 8, 10 };
+    const uint8_t *dummy_cycles = dummy_cycles_fast;
+    uint8_t dummy_bits;
+
+    switch (s->cmd_in_progress) {
+    case DIOR:
+    case DIOR4:
+        dummy_cycles = dummy_cycles_dio;
+        break;
+    case QIOR:
+    case QIOR4:
+        dummy_cycles = dummy_cycles_qio;
+        break;
+    default:
+        break;
+    }
+
+    dummy_bits = dummy_cycles[extract32(s->volatile_cfg, 6, 2)];
+    dummy_bits *= bus_width;
+
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    return dummy_bits / 8;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -1039,11 +1072,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        if (extract32(s->volatile_cfg, 6, 2) == 1) {
-            s->needed_bytes += 6;
-        } else {
-            s->needed_bytes += 8;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_SPANSION:
         s->needed_bytes += extract32(s->spansion_cr2v,
@@ -1091,17 +1120,7 @@ static void decode_dio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 6;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 4;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 2);
         break;
     case MAN_ISSI:
         /*
@@ -1141,17 +1160,7 @@ static void decode_qio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 4;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 6;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 4);
         break;
     case MAN_ISSI:
         /*
-- 
2.53.0


