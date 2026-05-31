Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5FFCD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWW-00020s-HU; Sun, 31 May 2026 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWT-00020E-6v
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:57 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWR-0008Ra-8Q
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plcKn5JWhCLeyYKF6EygDBkDLAmYv/GACqdu3iT4S13WrKYOOnGV0LmqQPUIoHDzEV6Wv2ajpsdlU7vtTJNtRAhYvtl12DKldnSAHn9Ze4G40cYF6+PQLZOB79QkWHTHDo1u7cRXW0PbwglZ2ntkNPr9WKetoXr3D+oW3PD610HcLMVSkOHVRnviUTGgLvi329xhAkJtNX+2SPdqhNigN28q+k/6BhJ3IwEjnAY61tziM++pHPRjAuESMbPiejKRJzlkAhyFvObQJUi7ZZ/nGf0KFrAwxHvqB2jSfwxgx6N9B5kS5LOgNEk1goItWkCPcnHkF2Gfyq36oItCBmdUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQzYAbfSeqNI11mvKUF4Tg0Qrx2d3NkPiD9QdRH8Lg0=;
 b=jLdl6gdx5RRotGUhGtIvepMbJXBnun01Yb5UBex1nHFUCYgvCFJL2W+Ca7VEJYHsqUkZ4bO24SheHzZX7DjP7knEIbB9addpJ0VyheokaEuG7sT4zc18Z6Axa8DCzFQgRI2bMUbbu0u0Ky0dxMHGUzMzLXfD8CuY9nfx94Oxm3iixOVKOZK7gWIVcMl3Wg1a7PeUZwyEBBAHQ8xPPuHegjUDO5XxtDq6eByKOYg10/82YUDIzgpOh5dgb61+yaR92CelN4cioTI+rrZvjv97Ap1C1UrEIrZPx4E33z/e8VN/AjKbIYMSP12JLO97o4nXXUDbDeuZeFabVfmD6uaEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:42 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:42 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:53 +0530
Subject: [PATCH 02/10] target/tricore: implement memory protection in
 get_physical_address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-2-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b782f75-1c78-4b63-6723-08debef76cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: Q7Ptql62pKPZ5u5/vEtdlHqurx1sMRV5g8g0pzkh2cL34C+Yu9wl6wGsCbeULV46Gk+07icC6GYszzd6EvjCFkkBjlxeCFmrOgz8P/Jq/nuomDrMMujb6MWUgPeukROpumfaFgVOuopWVBod8zRoLmH3QuXyihOksjmNep4ndViRWswNXOBwTDwRuKYG12qBkjXw9wDWj/ouG5FaM2B1drdB/TRQC8CijJiIVzGJAo3+4NDiEGwyvYy2FBTE9480THpGB+5a5SjAcfoIc+IC2Abik1QT6SwAjK/ZwxlAz+RP3RSDT25B3lvJLlmKuDMDTlgXDYF7Gcfp8GSelDNeSrLBtGEPNHZ8+rhy3AEJuRtlI/sEJ+qbES3Ectwb8LypOIOdr6mtqQgQdoLv2U1Wr8p7HNjy8AoO8fihlnFiD+w9C45OZ4IoFf2MdJIiTFPTMkHJmtSuSgDXClyMGRiHMERX14g8MDo29OPY4+wv57d8W0mZNt9qxgqQ3LvwJJLN4IceJ29Idq9L0xWDyt5DrQgubxP81K8GAnl6oXvah6vC9/A2fqmeW17HwfbGCZEXBn75517sJGEeWHt43GBk2TTt/tgxGkbGUyVVpB1ECuf6CTiE/hj+Rif5RUJ7YH/T4EkZ1lMHKlFznz2IaSKyEk/w2YayorRGARJ+pkF+vH4HpYmhibLHTIXP3MLsXNlZM1hOuQHRFj/yGaVId6qv9eyguOnT1cUY5sKUKnYOXiOeoptZs/VTexr3xlQ6Dy1y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eng1UWs5UFpHbTlhcWxBRS9hUXRQYVNRR0t2WVJxYVkvNE5NT3RyejBGUkZE?=
 =?utf-8?B?OWRCZ1lhMUU4MGZQYWl5dVpXOGlsaWQxMVFPY3BJYnNPZWNXeFBsNXpyb0Fu?=
 =?utf-8?B?Z09IS2N5SWMwckdoVTMvVmtJQnBybnloNlZ0aW5aVnVvRmpaNUswMHd6Tzlu?=
 =?utf-8?B?bnhTeWhYUzdCRkR2cFAyUHBLQjZQREhRK2VxaTRFT0lsWW5GbXcyckQ1YjFF?=
 =?utf-8?B?dkdMbFRtbitHS2NTR1ZvbmZNVmNqc2MvU2Y3Qjh1NzhZRWsxN00xSFEya1Bl?=
 =?utf-8?B?czFvS1pwenkyeWdESG5kM0M5MHVRcnNJY3p6ZGkyWStwWUY2eXNEOXBTM0gr?=
 =?utf-8?B?WHhjQkJaNXA3M1pKUVRXTER6bmVrMkQ2Ui9uWko4bDVKTGphUisvdnMrdWsv?=
 =?utf-8?B?VXovNEJXM3U5eENFY0JES3pnY3ZMamJVbEl5WTVBUExHNmoyVXZXTk5UZ1g1?=
 =?utf-8?B?U2JHQ2dqSTRGOUd3Z3c0bmxmTXlWbUlWMXR6TDlHaE02b042UktBQTZUVlpL?=
 =?utf-8?B?TDNjS3VGN0ZLczdSUEhkRklUZEljcE1WaTBtMDkvN0Yzck1VVk54emluZ2Q3?=
 =?utf-8?B?Uk5PZnZERDA0S2IvNklLZTlMYTY2NFZERjJadGJEdW1TTml5bWxYY0EydUk3?=
 =?utf-8?B?eXA5ZzJGWjJGaHZlSm9sd1VFd2pHbTZSUnArbDRCZTRYaUxFRXYxOHJyaURx?=
 =?utf-8?B?RUZvcXFzMWI0amlsRUljZXc4QllXVTRyV3d4SnI3NENDeWdabEV3NEVnSkN4?=
 =?utf-8?B?WkJRS1NXcytvdDJFTlJGdGZoVU9PN3A5ZEd1T1hwd21KdFdvL0VJNGpxT0Rs?=
 =?utf-8?B?dWNuaCt6Tk1XS0dDdXR3TjBNOEtCRHk2cC82UFEwRndkUGUwRXQvTlE2K1Zp?=
 =?utf-8?B?OWNpcnlEbWU3c2pSRVUvS2MrbmN5dW5CYnIwNTQzWStQSlIwVGc3N1BlVHdx?=
 =?utf-8?B?VkVVQllldGszeGxJN2hUcWgyQ21uTDNOcUhXRDZibm5KeE5INEFMSWp5eEpo?=
 =?utf-8?B?YVNDQzRwQVVCQnNiUHNTTFBNYUxhdUR2UHNvcVdodTFnOUdjL2xkaXMxQ0lj?=
 =?utf-8?B?WXE0b2Zxc2pZVWpheFA1azQ4d0xMSXlsUTI1UFR4NGNwSjUrWmVzc0ozTUJa?=
 =?utf-8?B?bU9KWkx0WmdZQTBjcytBSDV5bytRa2ZKWXRoT0JuRnlWTjk4U1VFU1puTWFL?=
 =?utf-8?B?c3NHb0g5cWNROFE5WUNBb3VIc01WYUlmWGRmQW1aZGNjeWxWV01vbDJhZk9O?=
 =?utf-8?B?TDhIZEgzOVZqM2dNMThRSjNlcUV4NlVzQ1VTV0ZYOG0xU213SmVMN2EyTHMv?=
 =?utf-8?B?MkxUUFJhUlEwdWoveDN1bG1acW55R0hZSzhvU0hUWWpralVmZE9wY29rUXBk?=
 =?utf-8?B?cEZ6V0ttdEwxNmQyYjh1MzFQQkEvdUJUOW1xdnRLcnpQa281NWdtM3JTV1Zk?=
 =?utf-8?B?QzI0WFUzVGVYWFhVNFhwMU1JRFI1b1FlWXI3Nm1OZWJ3am5Zc0h4TkU2bjRw?=
 =?utf-8?B?V09WeGNxSnN4RzhTS281SGhhZmxXOXNGc1NTVEh0WjVHcDF6MEUrV0NEUm1h?=
 =?utf-8?B?YVVxUU12ZlV6YzZCUXVUbFBRdko3L2ozZzBZYk15Z2RJSjdWR3lQdlcxUmow?=
 =?utf-8?B?a3FObzJ5dFJVZzZncHdEMUpGaXVqWUtWWElFT1RPTnNOdE8xaHpIbEI1Ylpr?=
 =?utf-8?B?WURPODRsS2JUWnR0R2xESGtHWTR4b0hpQWdvQ2RhZWJEakUvZEFBKzdtRE9u?=
 =?utf-8?B?UEZmc0FocjRBTXVyNi9mWGhZREo1WXJIZVhiRlB1N1VyOS9CaGNHNzc5MTIy?=
 =?utf-8?B?N2xGdy9hT0cvb1BCMGFZRTdwWkxnenJUV0lvTVZHZXp0NlBLZU5Md2hnWjgw?=
 =?utf-8?B?cGNHa2lMbk13d0o4aXNyZXhaT1c4YzF4WGgwdmI5aGRlSTdLL3ZNNnlpNU5p?=
 =?utf-8?B?S0hZVFRWTTBmY000b3hTVUlQS2MweXZWMVIyZTA4YW92djlkbEgwMkZLbjNv?=
 =?utf-8?B?eHNhaC9GUzYxMHpIVFNGZ3V0TThwWkQzV3VoMHVwaGJadExyQ21GRHZWRkZV?=
 =?utf-8?B?V1hSZU5YNGpVc1pub2RLNHdXN0Ixd0dGdU9vbDJGWEIyZnk5VE1zcTlUVDU3?=
 =?utf-8?B?V2J1MlFrQVV3dEI2YllBaGsyY0J5WkViT1luRWVIYVBkMCtuWk94Q0xWR0J1?=
 =?utf-8?B?ZE9YeVp2N01uOG9nL2xEMlVlWGlPQ2JlSzFBZGtickxGRjM3a1ZWdEtROHJU?=
 =?utf-8?B?bXg2cUorOStUN2NHd21QV3pCcjg4YlM2WjJkZjZ1S1JMQXJObk9USDJLaFpG?=
 =?utf-8?B?MGJCNnA1Z2ZmRVVBWWZRVTBzZ2RrT1doUEdNcld0Y2F0YXBsN3B5dz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b782f75-1c78-4b63-6723-08debef76cad
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:42.3728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nb5LS53kpTJ1tlaT9mYhAVWEY95SINiXDkUA8JPhg5/CwQs7fmXmvax4DFfLUUregooFT0pc/MU/gr+2hRXc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

raise_mmu_exception() was an empty stub and get_physical_address()
always returned full RWX permissions.  Fill in the MPU:

  - Walk 16 DPR ranges against DPRE/DPWE bitmasks for R/W
  - Walk 16 CPR ranges against CPXE bitmasks for X
  - Block instruction fetch from peripheral space (segments E/F)
  - Dispatch TRAPC_PROT / TRAPC_SYSBUS in raise_mmu_exception()

Also fix a missing else in FIELD_SETTER_WITH_FEATURE and stop
force-adding PAGE_EXEC in tricore_cpu_tlb_fill().

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 target/tricore/helper.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 5 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index ce1693622b..e50ea09a92 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -27,6 +27,9 @@
 #include "qemu/qemu-print.h"
 
 enum {
+    TLBRET_MPX = -12,
+    TLBRET_MPW = -11,
+    TLBRET_MPR = -10,
     TLBRET_DIRTY = -4,
     TLBRET_INVALID = -3,
     TLBRET_NOMATCH = -2,
@@ -34,6 +37,207 @@ enum {
     TLBRET_MATCH = 0
 };
 
+static uint32_t tricore_mpu_dpr_lower(CPUTriCoreState *env, int idx)
+{
+    switch (idx) {
+    case 0:  return env->DPR0_0L;
+    case 1:  return env->DPR0_1L;
+    case 2:  return env->DPR0_2L;
+    case 3:  return env->DPR0_3L;
+    case 4:  return env->DPR1_0L;
+    case 5:  return env->DPR1_1L;
+    case 6:  return env->DPR1_2L;
+    case 7:  return env->DPR1_3L;
+    case 8:  return env->DPR2_0L;
+    case 9:  return env->DPR2_1L;
+    case 10: return env->DPR2_2L;
+    case 11: return env->DPR2_3L;
+    case 12: return env->DPR3_0L;
+    case 13: return env->DPR3_1L;
+    case 14: return env->DPR3_2L;
+    case 15: return env->DPR3_3L;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_dpr_upper(CPUTriCoreState *env, int idx)
+{
+    switch (idx) {
+    case 0:  return env->DPR0_0U;
+    case 1:  return env->DPR0_1U;
+    case 2:  return env->DPR0_2U;
+    case 3:  return env->DPR0_3U;
+    case 4:  return env->DPR1_0U;
+    case 5:  return env->DPR1_1U;
+    case 6:  return env->DPR1_2U;
+    case 7:  return env->DPR1_3U;
+    case 8:  return env->DPR2_0U;
+    case 9:  return env->DPR2_1U;
+    case 10: return env->DPR2_2U;
+    case 11: return env->DPR2_3U;
+    case 12: return env->DPR3_0U;
+    case 13: return env->DPR3_1U;
+    case 14: return env->DPR3_2U;
+    case 15: return env->DPR3_3U;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_cpr_lower(CPUTriCoreState *env, int idx)
+{
+    switch (idx) {
+    case 0:  return env->CPR0_0L;
+    case 1:  return env->CPR0_1L;
+    case 2:  return env->CPR0_2L;
+    case 3:  return env->CPR0_3L;
+    case 4:  return env->CPR1_0L;
+    case 5:  return env->CPR1_1L;
+    case 6:  return env->CPR1_2L;
+    case 7:  return env->CPR1_3L;
+    case 8:  return env->CPR2_0L;
+    case 9:  return env->CPR2_1L;
+    case 10: return env->CPR2_2L;
+    case 11: return env->CPR2_3L;
+    case 12: return env->CPR3_0L;
+    case 13: return env->CPR3_1L;
+    case 14: return env->CPR3_2L;
+    case 15: return env->CPR3_3L;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_cpr_upper(CPUTriCoreState *env, int idx)
+{
+    switch (idx) {
+    case 0:  return env->CPR0_0U;
+    case 1:  return env->CPR0_1U;
+    case 2:  return env->CPR0_2U;
+    case 3:  return env->CPR0_3U;
+    case 4:  return env->CPR1_0U;
+    case 5:  return env->CPR1_1U;
+    case 6:  return env->CPR1_2U;
+    case 7:  return env->CPR1_3U;
+    case 8:  return env->CPR2_0U;
+    case 9:  return env->CPR2_1U;
+    case 10: return env->CPR2_2U;
+    case 11: return env->CPR2_3U;
+    case 12: return env->CPR3_0U;
+    case 13: return env->CPR3_1U;
+    case 14: return env->CPR3_2U;
+    case 15: return env->CPR3_3U;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_dpre(CPUTriCoreState *env, int prs)
+{
+    switch (prs) {
+    case 0: return env->DPRE_0;
+    case 1: return env->DPRE_1;
+    case 2: return env->DPRE_2;
+    case 3: return env->DPRE_3;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_dpwe(CPUTriCoreState *env, int prs)
+{
+    switch (prs) {
+    case 0: return env->DPWE_0;
+    case 1: return env->DPWE_1;
+    case 2: return env->DPWE_2;
+    case 3: return env->DPWE_3;
+    default: return 0;
+    }
+}
+
+static uint32_t tricore_mpu_cpxe(CPUTriCoreState *env, int prs)
+{
+    switch (prs) {
+    case 0: return env->CPXE_0;
+    case 1: return env->CPXE_1;
+    case 2: return env->CPXE_2;
+    case 3: return env->CPXE_3;
+    default: return 0;
+    }
+}
+
+static bool tricore_mpu_enabled(CPUTriCoreState *env)
+{
+    /*
+     * The MPU is enabled when SYSCON.MPEN (bit 1) is set.
+     * As a pragmatic fallback, also treat the MPU as enabled
+     * when any enable bitmap is nonzero, since some RTOS ports
+     * program the range/enable registers without setting SYSCON.MPEN.
+     */
+    if (env->SYSCON & MASK_SYSCON_PRO_TEN) {
+        return true;
+    }
+    return (env->DPRE_0 | env->DPRE_1 | env->DPRE_2 | env->DPRE_3 |
+            env->DPWE_0 | env->DPWE_1 | env->DPWE_2 | env->DPWE_3 |
+            env->CPXE_0 | env->CPXE_1 | env->CPXE_2 | env->CPXE_3) != 0;
+}
+
+static int tricore_mpu_check(CPUTriCoreState *env, vaddr address,
+                             MMUAccessType access_type, int *prot)
+{
+    int prs = (env->PSW & MASK_PSW_PRS) >> 12;
+    uint32_t dpre = tricore_mpu_dpre(env, prs);
+    uint32_t dpwe = tricore_mpu_dpwe(env, prs);
+    uint32_t cpxe = tricore_mpu_cpxe(env, prs);
+    int i;
+
+    *prot = 0;
+
+    /* Walk the 16 data protection ranges */
+    for (i = 0; i < 16; i++) {
+        uint32_t lower = tricore_mpu_dpr_lower(env, i);
+        uint32_t upper = tricore_mpu_dpr_upper(env, i);
+
+        if (address >= lower && address < upper) {
+            if (dpre & (1u << i)) {
+                *prot |= PAGE_READ;
+            }
+            if (dpwe & (1u << i)) {
+                *prot |= PAGE_WRITE;
+            }
+        }
+    }
+
+    /* Walk the 16 code protection ranges */
+    for (i = 0; i < 16; i++) {
+        uint32_t lower = tricore_mpu_cpr_lower(env, i);
+        uint32_t upper = tricore_mpu_cpr_upper(env, i);
+
+        if (address >= lower && address < upper) {
+            if (cpxe & (1u << i)) {
+                *prot |= PAGE_EXEC;
+            }
+        }
+    }
+
+    /* Check the requested access against accumulated permissions */
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        if (!(*prot & PAGE_READ)) {
+            return TLBRET_MPR;
+        }
+        break;
+    case MMU_DATA_STORE:
+        if (!(*prot & PAGE_WRITE)) {
+            return TLBRET_MPW;
+        }
+        break;
+    case MMU_INST_FETCH:
+        if (!(*prot & PAGE_EXEC)) {
+            return TLBRET_MPX;
+        }
+        break;
+    }
+
+    return TLBRET_MATCH;
+}
+
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
                                 int *prot, vaddr address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -43,6 +247,19 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
     *physical = address & 0xFFFFFFFF;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
 
+    /*
+     * Block instruction fetch from peripheral space
+     * (segments 0xE and 0xF).
+     */
+    if (access_type == MMU_INST_FETCH &&
+        (address & 0xE0000000) == 0xE0000000) {
+        return TLBRET_MPX;
+    }
+
+    if (tricore_mpu_enabled(env)) {
+        ret = tricore_mpu_check(env, address, access_type, prot);
+    }
+
     return ret;
 }
 
@@ -60,10 +277,25 @@ hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-/* TODO: Add exception support */
 static void raise_mmu_exception(CPUTriCoreState *env, vaddr address,
                                 int rw, int tlb_error)
 {
+    CPUState *cs = env_cpu(env);
+
+    switch (tlb_error) {
+    case TLBRET_MPR:
+        cs->exception_index = TRAPC_PROT;
+        break;
+    case TLBRET_MPW:
+        cs->exception_index = TRAPC_PROT;
+        break;
+    case TLBRET_MPX:
+        cs->exception_index = TRAPC_PROT;
+        break;
+    default:
+        cs->exception_index = TRAPC_SYSBUS;
+        break;
+    }
 }
 
 bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -73,9 +305,8 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUTriCoreState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
-    int ret = 0;
+    int ret;
 
-    rw &= 1;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, mmu_idx);
 
@@ -85,7 +316,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
+                     physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         return true;
     } else {
@@ -170,8 +401,9 @@ void NAME(CPUTriCoreState *env, uint32_t val)                            \
 {                                                                         \
     if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {            \
         env->REG = FIELD_DP32(env->REG, REG, FIELD ## _ ## FEATURE, val); \
+    } else {                                                              \
+        env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);          \
     }                                                                     \
-    env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);              \
 }
 
 #define FIELD_SETTER(NAME, REG, FIELD)                \

-- 
2.47.3


