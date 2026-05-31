Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E6CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWV-00020N-QG; Sun, 31 May 2026 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWQ-0001zz-N9
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWO-0008Ra-Kf
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2ghTsyz9M70otMDGyzK7iL9cs423sO7E+k8XBA/ohcIiIpMqB1uH8WHszse0+FDz0+8jTR9oRVtzRpl3qdsRVC/v05i0wZpyavt7Rxu6IdQM2R6j6muxA8Rso1kXMhsTeucDXOHsfbJJ9ABS9ecC5Ay6xped8dZC/Ng4b2RByg/pLadoZbbdjAy6L/YWbF6UgpLflyUbr3dAlky+dbXFeJptX8rs0ULvxz/eeRDs1TtskuiaOUTqiy020iKxzvpoIv6f/p6IBQzg99E4blw5m/Ark/f6dSgkG/5Os2jyFVzYudvbsIWnNyq40XLOiY7DC4qejMIFMlBfbQ5Ls7iXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLJi0GHYqVoC4jjsesyIDz/l9RRi9e5vYY6DJyJsbXU=;
 b=RaewnFolJpOiwxHK/wYVKJKzq3JtAoetY2Fr/BGgnP4WLCb58mkmioT38vkXaw9iEZe4nORtxBgXsbsFWNDBwoknNL3ExcDRr/+P1wcN3qIZmlnxDe7SEhhYbadbMSjP9K8KJPsUGn5I68jRpBKQbyxRzpD2HCU1naMAGLx0jWQXfNq1J3lpGjfjSd+rok0dzYxhxkzNA1bUnEboT6bFD0m1giCejd0IBLa/Qbp0E6V7YQGZ76BpdyTHJhEhEdlqdIUQJ0c0kUB1wvK+GiEZ3UCjut04BO13vqG53lhsaKq4bjlcFWHZPOVOPp6iJ6g5YunihZdPZ396AHEdFPnTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:40 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:40 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:52 +0530
Subject: [PATCH 01/10] target/tricore: replace legacy DPM/CPM CSFRs with
 CPXE/DPRE/DPWE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-1-1c39053e5e95@linumiz.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c6780c3-2c7a-490f-4c55-08debef76bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 2VIIE9EYJ5n9hv0khBn5TlpJ7b+26z1EpB8pH2vcgjzhKuc0HVVG5YPfW6KmgcBpAfqvS38GZodx7c/JnLQO5cghgoqMKcQ0hX2OsThVJSQeSPAIjEVQ0MkYKp5NNiTy5Xu8mAe24Wk24veplHQabMAQYeG1NPk39RgOM4P5I1GHvHvQxoQc8h9kBEsgvZEC4Srwmpkzy9XdkH4PWVFVWiunhKa21P9FnDk0Sd3yg4va7Rxa6GWuduuSOKbYJcPmjlViUmUwZAKyiZ5irWG3+g6lWRBdcMqUqv/V/OUYy20qu+CBVHaCJ8WW92a+zDS8Fl63CzLuvQdkT2kk+tXQdCMd8EDzxF2DHp4ieg7qlEA8XQ1xFqUxZsTFmu/7ozXtj+PQDFCvOGBwAlGyB7pnT1wZUplF3z2lWmbQuNDOqVROjlBRr3Jy8YiAPaTklkmqOaJwQ9D3W/YlJZA6y3nNV7rYL1ukiz9fewEuyybyMcl3M3atukF9EqzcALXXyLRpn3Nw+BTZ4V1+FvqEJhHYwgCJmJUTnT6mP6smJz+Nn0liuQeF3sxFzoVBAwM0AtewDbdw7ZwZIvJc83OBHL+10hTqjZeWvCWKkNfXQlEs6YZ4aQNPVua5AVokWNMMyOchWeScv0bcZkhKj95Y6wSHc+mZ7zWlD78uXqkw0llPMZZEKig3+gPYeRgZs+tMu0fMyrJjabz73noqWuRGyGHMIx5UPjtGOy5q6gtCsoEkuhYbA71ukfwrglf5HIO+BA2h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlzWTZaY1dsQk9Pa2hVbEFOYnNFYzJ4aVF2azRCbEVsMy92K2lTUlR4VVBS?=
 =?utf-8?B?Mm9PT3JFaGd6VzBOYjVGazAxZ3NpYjJzNWpCVzI0L3ErM1pzMnNHZTlEaFBV?=
 =?utf-8?B?NmZ4RldiTVF1ZjJDRE9wYkJNSXprSFNkUk1FYVM0MFZxMnNHQThBNUVNOHhO?=
 =?utf-8?B?NnIrcVZRMnEzRXN6RFNPVnhXbU5NelhDQnpPV0NXQ0VheVBpeGhneGhVK0NE?=
 =?utf-8?B?UG5UcnJTa3lidWtsMUhEYTAwc1Q0citVaFZBVXBrekVWdk5nNHRNRXdaNkdP?=
 =?utf-8?B?TDFGWGlRaW5iMWZEYVNnSzlBWlJXSCtaSG9DMEJnRG1NODZoR2lLV2RGVEFy?=
 =?utf-8?B?VUFkMWhEcUQxU0pWVXlPT3JVclNWYUVucWRIS1VxN2g1SDlaMFlJTE1mU3Qv?=
 =?utf-8?B?cUJRNi9KUHdieVp0eDVFQy9iY002bFc1cm9vZ2VMUmZwSU4reWcwbmVQS0hm?=
 =?utf-8?B?VzB0UUZ1TTFaRE1kOWlPTytaeDRZUGwzNXlKZVZYMEFNeXY3MElHNDZDNW9B?=
 =?utf-8?B?cDBvNFZobXNZaVNlQ253N1ZRUndKa2s1YzBDUWE2NWc0dVZucWRRNjdlckdx?=
 =?utf-8?B?UTVtOVhFZ2Z1eTZDdFZDbDNoTmVMbWp5b3dwUjNCcmhhdGcxRWwySkc2c29z?=
 =?utf-8?B?bVk2emE0b3NqanR5b29uTno1YzNjWC9BelRHL3ZuMi9xR0lUa3o0VWs4ckdX?=
 =?utf-8?B?YW9BaENnNm9xaHQzNEw0SDNsdkIrYjhEVXkzMzJ4RnJxeUJTNFUzOGFzM3Bt?=
 =?utf-8?B?NkZ5MVVtcXhTRDRYckNzMThjTjVncWp5Ti9jZnlOVkdVUlRLZUVKcFJtdnMr?=
 =?utf-8?B?UVpjTkJpMHVtYnNTbnd4MG9ockpyOGt0OXVQdFVOSWFzUnZoMDd3QTk2Y3Jp?=
 =?utf-8?B?UWNPZ25CV1VNb3ZCUXU4TlNON3lObjdNVmY5OVZ5RnpJb3ozRnRXWlFtU0lq?=
 =?utf-8?B?dGJEZGRaZDU5dm9FUFY4MjdKbUJ1RzhXMlk4WFJ4aG9xRUI1TkErc3VoU253?=
 =?utf-8?B?Qm5OaXR4c0Zhd2Q4Q3ZnL0pZOVJzVCs2UTJ4WXFqVlRiajlMSHVYM2VqdWlW?=
 =?utf-8?B?WUkrRERnWG81cCt6b1pJbUpWR2lHZUJtb2oyK2N3bFJNKzJ3c09MZ0RGcVRi?=
 =?utf-8?B?THhlL3VpVHdGaXhaVEZqdVFSV3RETktjaGMyYUZ1RGNJKzVwUk9NcDkzQXlB?=
 =?utf-8?B?YjFQT25YOXVDQzJhUEE3MlhSTzROd1pFY0pnemYxQUozNGVScERnTHIwanJ4?=
 =?utf-8?B?UHJqR1ZpbEx4c2treEpMdk5wWWhSR3o1SXJnWnU0V0x6bmJoeEJtcVE2RUdl?=
 =?utf-8?B?LzkyOVNXU3B1VENJQzNuT04xK0toaVdDckdsYXA4akw2bzYzMDJ0MEhRWUNi?=
 =?utf-8?B?NlZnMzlSVzY1d2ZOMzE4RFl5M2JLc0ljQVpMYWc1aFAyZUVtSzhIZmF1blFo?=
 =?utf-8?B?bklPVFVDMGJuNGloMzVCZG9NbWh0L3ZmQmx4KzQrcUt3V3dLL3RLYjdsd1NG?=
 =?utf-8?B?Q0QzTTNJMVFhUGtla3JrVkZZY1I2b2lLRVNuR1BrMG1haElZOGp1ZXZkUFBz?=
 =?utf-8?B?Uy9NS05pMTJ2RWZFbUswUHdiUmlVZElPQUxXZ0RmRWYxS3VQSGFaRHlNMzZZ?=
 =?utf-8?B?d0dkUFZGUG9TOC9LZThPSjRiTjgzZVZTeTBRVlZNYTV5ZkcraW9TaVFBSVVp?=
 =?utf-8?B?bUw5cytoQXFUbDRrODVaYWR2OVB0L2dLWjZwVkk0TTZac1hrdjNPcm5nTmZW?=
 =?utf-8?B?elNxZFlUU094UFlYVnZPaW9IUUsycU1ablR6L1RIKzJhK3QzTVNjMHpDTGZt?=
 =?utf-8?B?Zmtjc3Y1TmdEVkc3Q0NKeG5XN3BCdmNSNVJKdzM4K3NQNEFyQ3JEZmlEK0Nz?=
 =?utf-8?B?YVJqY3VrUjFPZlNDK05zd3Q2ZWlyRWtZSG1TWU1sT1A5ekQ5MkVtZXVpVnpv?=
 =?utf-8?B?VGJramRPVXVUQyt5Q2pMYzlFRnhQSnFCaURkVDl1NG1Nc2NmU3lqbmpKd2xo?=
 =?utf-8?B?VjFtMzEwN3lOOHovYVYxckxWalBqQ3Q5QWU2c21FdUlxYTlGV0hWK3hYUC9X?=
 =?utf-8?B?Nmk3c3JPd1RKS09oNDhvZlBkRVFRNlZWa0h2eFV3RGhpNlh0aE5WZjRhbGpT?=
 =?utf-8?B?UWswSHBnTzlCVzRXckFTZTB2VXhrWTVmUlNxQWc4bFkyU3NLVUpTaFVncG1k?=
 =?utf-8?B?a1dNcG1Lam1Lbko1Mlh0TXZRbHYrMFh0cWl1c0RydzRFUG9WdWtNUjlQWWxB?=
 =?utf-8?B?QUpKd2xKcGxnYWdwaklhRU9zaXhJU1gwTiszRk5DUW5ETFdtQUVIRVVIUWxM?=
 =?utf-8?B?aFV5dm5hUjNmcXVXMVRjUkNBNTJpM2hkL2N3UDdsc0hGWUk1SURTUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6780c3-2c7a-490f-4c55-08debef76bc6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:40.8495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyzKqygGTYeHAajrCQh1G+1XIEBzxTVm76ccwu0m6QCMJ/+RajIZUDd/94CQ9Nz5RyY1md8GX6wV7e+lxJwE2A==
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

The DPM0-3 and CPM0-3 entries had wrong addresses and were never
used.  Replace with the correct per-protection-set enable bitmask
registers (CPXE, DPRE, DPWE) per the TriCore architecture manual.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 target/tricore/csfr.h.inc | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
index cdfaf1d662..24d8310947 100644
--- a/target/tricore/csfr.h.inc
+++ b/target/tricore/csfr.h.inc
@@ -83,14 +83,18 @@ A(0xDC10, CPR3_2L, TRICORE_FEATURE_13)
 A(0xDC14, CPR3_2U, TRICORE_FEATURE_13)
 A(0xDC18, CPR3_3L, TRICORE_FEATURE_13)
 A(0xDC1C, CPR3_3U, TRICORE_FEATURE_13)
-A(0xE000, DPM0, TRICORE_FEATURE_13)
-A(0xE080, DPM1, TRICORE_FEATURE_13)
-A(0xE100, DPM2, TRICORE_FEATURE_13)
-A(0xE180, DPM3, TRICORE_FEATURE_13)
-A(0xE200, CPM0, TRICORE_FEATURE_13)
-A(0xE280, CPM1, TRICORE_FEATURE_13)
-A(0xE300, CPM2, TRICORE_FEATURE_13)
-A(0xE380, CPM3, TRICORE_FEATURE_13)
+A(0xE000, CPXE_0, TRICORE_FEATURE_13)
+A(0xE004, CPXE_1, TRICORE_FEATURE_13)
+A(0xE008, CPXE_2, TRICORE_FEATURE_13)
+A(0xE00C, CPXE_3, TRICORE_FEATURE_13)
+A(0xE010, DPRE_0, TRICORE_FEATURE_13)
+A(0xE014, DPRE_1, TRICORE_FEATURE_13)
+A(0xE018, DPRE_2, TRICORE_FEATURE_13)
+A(0xE01C, DPRE_3, TRICORE_FEATURE_13)
+A(0xE020, DPWE_0, TRICORE_FEATURE_13)
+A(0xE024, DPWE_1, TRICORE_FEATURE_13)
+A(0xE028, DPWE_2, TRICORE_FEATURE_13)
+A(0xE02C, DPWE_3, TRICORE_FEATURE_13)
 /* memory management registers */
 A(0x8000, MMU_CON, TRICORE_FEATURE_13)
 A(0x8004, MMU_ASI, TRICORE_FEATURE_13)

-- 
2.47.3


