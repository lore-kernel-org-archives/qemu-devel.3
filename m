Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAE606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLd9-0008QA-AJ; Fri, 23 Oct 2026 16:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcx-0008P3-PV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcv-0006uV-E4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIx36QGlczM/ZzPZDKHaW9+m2dZ42awC2Afm3FsyU7RBD8MfasSiHFk2ufvfQnhaoryE8DFOk3MjM3Ix5YBmElUo5trGXdUO6Ly/DYlpnqr5nQkhl5tkUZtDT6RztXZXJF4MDXdJspGamrAeeLYJ7zri1QbXd3F4ow1DpS17wRp2+fRaZCrEte2KEE5o8flGbXJS6k4MOUyCOXNu7rZ4/WrPQMiTUpJhGvNaA/8hV697BJmn9ie4fXCbjpiPZT5HiMTHlSKkWXh4m8wXBHra6k1qJ8o4OvjoI5HcWBPeW0zaHibWsKrxl3CARMuA0Ec4F8u2XfFPCvcsbS/l4aR2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J7mNPL+seDxzyDVzFffdDPXzHkkPYnGeftrPByilGM=;
 b=JeJieVmiLKN/k5L57x3O8gQ0gEKr7ZJmd+Y3pHhIrB7rPcfgkgZnlOBXsGcceLyLv2py1bLNl2clz0PAAuHvbtnYSBAGNtMuxIID2fRxAwfYNMDa0p9DxHd/kBgS/DLw80KI9G58YYuF/eepq/Wspf6T5iOy+xslMkWeZn8L8wQ4cwOwLT9ieqS7fXG0F6jH+p0/IP+G6uSeDPvfCdEgULEJQxmS8IcNQSxl+IXTnf2CPO6pKAB1vmZ31bTxpUNAIL+D3y+YkK6UcKN3s1OFPuXGN9+hS5iFSVcuYSRgBY9Reqj/TBukVuoDNWoHH8sEdj85XyET0X6sIZwQ5dZiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:19 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:19 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:41:56 +0530
Subject: [PATCH v2 2/9] target/tricore: implement memory protection in
 get_physical_address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-2-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=10132;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=CDlJy/uVSIKY/nDcfIkOu2kOIzEISIUuPjnOITQD6wE=;
 b=DS5dqnCpMsIJrL5cDUs/6GKEyFH7m/NTYY2tGIbzYGho2+lqLqbQ1GxL5wREbPwDpByaKqFgN
 QSwcc4EChQJBIJIW7tT0hfzjvF7VBeRFmeC2+uxwRdnj16PBQAZMC5B
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b8f04f-014c-4e28-46a8-08df3141f0ba
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261021123027099003|261009223027099003|261021121427099003|10067099003|22082099003|56012099006|18002099003|6133799003|261022105027099003|3023799007|261022075727099003;
X-Microsoft-Antispam-Message-Info: 03sS3Vw1yRUP4Am5Wg+cvyOq9aO1k3SHde7g9A1kxN9TPTg5NzWCCDU3Rp6YcZ3r+uIzU+LiIzLyqGq17/lCAlam/wU74v1R3UoJm2+UxmnuCi6wNg27JaZLmHSbx4Pi9fy2oxcvbd8xtoIaM1PUsKNJwW5Ufe0qa6UhnUmPD9UMdgbz6lfdNs65mQqzFG5I7pBi3eSZXCB/My5uAfbdwBRba63yRq5ELoPnRAdrpQoTCTus3D4JMK9U3uQfSuFqilWQOl8YjytyVbpVpc6JB6gUA8oF/QO0AYekntz36mGQQd5zQMOsR/xiTnDk8LCW2B/fTGZTX7ZOgoKLbt7kJWkq0F3OWHbNLtXzIQZOPnqtO6iYo2TfQLaKevOil82PejOwsDm4GxN684nOMAgfYH4sdQlXQnG/cUHfaAg7VCCy4EGKWiKKs/30zYN5Oq/jMRI0kNmV6QWcM6UFyT58zPIJX5/yqpb2wmrVAVE0cb5USYMVaAnVhK74W8ytpaFlHOx1JsKB5yY9v2XuX3WRM/JAfuWhsvQenrU4wUPqpPEJM9+i2Igw5WQKk/W13sEaFB9YbjWFm+JyKuwXMVPS12XcmRO3OJpgw7Sek9TjUvM8qLVEukD02sbDvwd9sRATssYVcn5UEiohZwkWklOBaFTHhDqh+ySX7t3Zgkjhxqu+rlQfdb99mRiNwBcwGgLQ+w+ID/iSNXPkChKjcdS6NWBHOpToWV7Ktm9Nsye9Ta4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003)(261022105027099003)(3023799007)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGozQndRdXplVnhzeEJNNElERWY2RXNCSzRIKzN1eW1ydUpKMzlDTVUxdzh0?=
 =?utf-8?B?Y1NtODE5ZDBEVkNVdk9zVFNIcWhiRFp0Qnd4Q21KbkdhUFZiOUNUQk9rcmsx?=
 =?utf-8?B?ZTM3THlBSTBJVTJMakVvcWJhVXNxRC90enRGTmo0WW54eFJ4dllPdlVmeXhm?=
 =?utf-8?B?MWdwUEhPTSswcTZBaGNqTkhWOUdZTUZVQjlseGhVamdwbDRZU0JWSWhLTDFX?=
 =?utf-8?B?aWVaS21ud3FlVE5rbkdZNDZGbjNuNzBWajdLeGppMkdCcmJPNUFRb2pEY255?=
 =?utf-8?B?aEJ6Wmhqb2plLy9XRmtDZnd5VVM2ck44VWxjU3YvV09aMk1BSGdBaGY4ZE9p?=
 =?utf-8?B?VVEraWlvVnlid24xd1lZd1JUWGVmV0lXRmM1eldNVE0wbzNJaGxYK1ZvbGJO?=
 =?utf-8?B?YWxFUGRkclJPWUU4RGl5TU05QWpYejRrakY3KzlQeEMvbktDNzFBWkpYbFo4?=
 =?utf-8?B?SHg1Nkg0R2dsTGZpU2N1SkVRcEkyOU1MU2VGdk5mQ1M0dlJqTHBYckdCSUpT?=
 =?utf-8?B?dVVveGUzSkZ4SzNVc0VuM3NTSWRkenhTODhMZEV3UURHVFpNdVZpNDFpRG8w?=
 =?utf-8?B?SENaZkN6cWRzTjNNLzBrMUt1ck5vUWp0eXBhUlB3OXc4TzR5ZmszZGdOZkg2?=
 =?utf-8?B?aWRDd292L0ZzRlpuRVV5ZW83OTRma3ZaNEV4OElicVVRZkNTNmZ5U29TMVdO?=
 =?utf-8?B?UkpKejZHT3pMbitXUXlOeWdwMStWc3ErMFZvZ0ZoaHA1a3dpeTdkb0ZpRVAv?=
 =?utf-8?B?SUQ4OFVmMWhzVkhzOUFQOHZZZTVQNEt3VFR4cjN5K2VMZktuUWluZGlPdE9p?=
 =?utf-8?B?YjJsOUNXNjRjbWhzVGVLODR2Y29wM2dEM0sxejZOc0JDMkY3Nkl2Nmt5ZlVj?=
 =?utf-8?B?TTVXYjU1Y0FDRXgzUExRVWp4YWRkODVaUlFVT1EyNDRlY0o5ZmE4QkJmZUhD?=
 =?utf-8?B?UnZ2aEE0OUN3bEFXMjJQWGh6YStweFIvMXlXZ0Qybkw2OHB3Tm0zZ0VIYko3?=
 =?utf-8?B?enlIY2hma0U1d1J4c3l0d3RYV2V1dzcrQXp0NkVQemF0NnNpRnArUGRFcnla?=
 =?utf-8?B?UG14MnZXelJtYzFTMlE2SmJzbWI4Q0d2SDFMNkR1YUtpeE03QUtVR0lXdDRw?=
 =?utf-8?B?MkR2L3BqNnM4T29HZFhWRklFSU1EbTVRK2hQQUVDR0xFMVpHQTdrd2Y4Vyt1?=
 =?utf-8?B?bTM2NkVKbXN0Z0FQa2tYWXdzUEtJWkljbWhKQ3dhaHhLL0RiZm10L09UbDh0?=
 =?utf-8?B?Y2NteGxZNUlFMFVpNEUyV3o0Y0ZXZlNrY3h2d1JzMzhaRlIvcko5QU81enJB?=
 =?utf-8?B?a0FRdHowNWdpdEF5WVhTaDZLN0x3VENkZE9tVHhDeVk3SUVtWXpTNHAxMTdx?=
 =?utf-8?B?dUhHQ29QZnJqck16RXF4cU90Y3BVN3hQaVhVUUgvaVhxQ2FoU0ovREVIa3Rx?=
 =?utf-8?B?UDZqQkpraHlzYUpIMlBVd1d0RnMrWkI5TkhENlBVYjhMWHQ3MU1CQkF4ZzJl?=
 =?utf-8?B?eWF1NFRyQUgxRzkrU0l0aHJpZWpFZXAxSWhyU3JDVlVpYzkvcGNrYmRIZ3pj?=
 =?utf-8?B?QTFlbmNMZzlpK2hBRmNwbmJVUWtKU0R3WUhneGQ3NFlCeUpUanZmbVhpM2V6?=
 =?utf-8?B?RnArTDduYUMrWGhJeUhUdlhyc3l0aU84Qm03QnM5dmRxdFloazFsdGVHTFFJ?=
 =?utf-8?B?cnlya1YwVE92dituRGtMZS9HdFVlVDVRb1pRRVAyVmUrdmw2Q0p0Yy95OEFB?=
 =?utf-8?B?YzlxVmFSbDY3Y1V5dTdVMVlhZ0pmSnNFSU9mSVZFeHRBVTk5TXkzOUhCcktU?=
 =?utf-8?B?ZGRyVVhjbDRuVEtDem5vc2JrTm5WU2grTWtTa0lFVmR0TEg0MFVZSkVqb0gz?=
 =?utf-8?B?T1lmQ2QrMkFNNHQ3cFRzRHluekVnV0JjVDgweDFyMkx3d2ZWVDA3L0NFVGY5?=
 =?utf-8?B?TkpYZnovcVBncGNIdFI0blM1TklFYWoyZU1BbVF2ZG0rY2hReHJKMTF6SE1I?=
 =?utf-8?B?WG5MUSt0Tng0T2MyV2JHWTAwQTRyY0tubFFXRTZBb1V6WXMvVkdvZ3VFZzZx?=
 =?utf-8?B?b1p2Z1MxTE5wU01xZEVkUURmV2oyK21XZ2VlaVB1ay9US2lZQlNNMTcxVERl?=
 =?utf-8?B?NHFDSmdBWjZoRVlrSGNaL3I5dUxxc0w4di9sSTd4NEVyZjEzQVpUOVprd3Y4?=
 =?utf-8?B?REFqcThabXN6ckFPeDM1T3FpTzFZZGZaczV3THhFRmFNcTVCN0g3RWdDOFk3?=
 =?utf-8?B?RlBLSFJsNEVnNUxFTEI4bjhTenh3eHdTU2UzbG9tVFJiNS9BRVNWMDN0a1Ay?=
 =?utf-8?B?ZFcxR0JwVkplWVNVMU9TSUN6S1FOdWZ4N2ZveXJCU0RiWmtNVXFHdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b8f04f-014c-4e28-46a8-08df3141f0ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:19.2155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRZkC99LEWhVenm3rGuepIZPFN12lu5h2qZiDfOdyiOlh6eDCPGK+apokn8I4JH91ytPLbe99vUB6ybVtgCnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 273713a147..ba85491bd6 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -28,6 +28,9 @@
 #include "qemu/qemu-print.h"
 
 enum {
+    TLBRET_MPX = -12,
+    TLBRET_MPW = -11,
+    TLBRET_MPR = -10,
     TLBRET_DIRTY = -4,
     TLBRET_INVALID = -3,
     TLBRET_NOMATCH = -2,
@@ -35,6 +38,207 @@ enum {
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
@@ -44,6 +248,19 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
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
 
@@ -61,10 +278,25 @@ hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
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
@@ -74,9 +306,8 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUTriCoreState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
-    int ret = 0;
+    int ret;
 
-    rw &= 1;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, mmu_idx);
 
@@ -86,7 +317,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
+                     physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         return true;
     } else {
@@ -171,8 +402,9 @@ void NAME(CPUTriCoreState *env, uint32_t val)                            \
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


