Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLcx-0008Ol-T9; Fri, 23 Oct 2026 16:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcu-0008OV-UE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:32 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcs-0006uV-Hg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxYOM5tvSwu/2g+95R/3FqQ6PdDAyujZ6sqbmWj/tRkDDCf7HCFDcoIMiM7q2XfFBV4OHqz6Lhytv/ZRgp6eeGzXHa6iMfCj8KIPY4WVEHL4NPFolX9pXPw7teYawdF0XXERh4A3WaBsvbMHT5xn2I+2dJ30PDmlvC++JC0xS3BYsI6wu/a3ewtcuEUadsz2Uycb7axCCGef8QrAsT1t2sYaamlMj1YTRv/sP7QQQ4k8TAVkPWc6eUtsARcKXYYk4Sbe9bH7mjlHrFwVY5PxJ3/GVWG6i44AWoy7CF2zmdo5jpyelqDUfW1sghllaDVfmn2Kts+e4DWfKvqqpIN8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLJi0GHYqVoC4jjsesyIDz/l9RRi9e5vYY6DJyJsbXU=;
 b=D9ZiJ6Q3NHGi6GKjwGnneDrbY/dDqcke+fv+nsaLwoPt2NtNC15yDOhBdj/UKwJydZN4R4vQtU1DYD2yX+cEHJE6yYlSa1uV6WtGhOkWqFOqnSOEgzhYJDOqsbilj2sdUvn9HbOEldFlJzBYIPlrtSPP0OOB68oaTqNuviViHMtLMDn8LMxjvkACLDjJ/v3X8Vje0KcBlV3LomxVqOvNJ6jd3E+eXMzk2wLw8NrvgID+LxtwoD4TJu8z32FLUIIDUVAL6itvDwGLQ4HRSfjZtP0i3pAwYAx6lcZkt52gzlSfXOjGYXj9vPrszZ490Vbcud8TX5jPqHitYfkXF7xE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:17 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:17 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:41:55 +0530
Subject: [PATCH v2 1/9] target/tricore: replace legacy DPM/CPM CSFRs with
 CPXE/DPRE/DPWE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-1-c722e4ca5661@linumiz.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=1647;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=cTFL3JOEnHOoiazo4b3vlwrz8KUBlJ9gV91vxec3wzU=;
 b=olspLTb60TuS0BXByt4BbXfN7wy440Yp/RrX6kIDagxQUGtHc5/G7OeXvVZ0KBTICNFiniWqe
 2SLcTLuXyEVCRkGDofmKzUnnzKwvuikzKi8+lmU0EvB6tA4Gls0lXjV
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: dcda134e-53da-4190-a407-08df3141efc9
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261021123027099003|261021121427099003|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: J/G+ee468h/g/kyJLK+i8o8DEC23VA88pC2cb6KaALOH8oOpkd8sfQuhPhv6lxe+LxbENLoEwRS/LFLB4GdhdvGlQUdTFNa8ot6CfW5ECR8rvrnb1JA0ZfQJwMhp3aJ+nScRPtIMO4nTF2eF53Ak5lSj5vj0rdMnVRKDnhwPXxshT2orJafIvJsVyJuMQUHu0mSFpQPGv6jaedPelcdXEE3CjjcHDTLvF5NImfA58FsWn6Gxx6I24msxdaw2hwFdFKZJTd2Y2DFNPwZOAdUvVLohTrfdwp8a0DFHt/fSYmuNRExz7rkwpr1ip3v8cMO4SfgB8P7AMInCT4Ipu98uSzQfcovIKUyw7essecnsDSwIWXB4mHuB18+uVsvphBeqDvAmjVRgOYdwtr1YzvczJV2g4CBc7vskeFzGIcN4AnidEgI8KNHcMiLyugtV5a7E2mM2nWF6H1WnJgzs+YcxRnTfbeDTswt6kWjWRCJQ/1MeRUFS57i4PKdtjth2x79GGxEO37NB2vtXSZEj8KDaL4TXno3KEwrzk2t0kslKizt8LHncTeIwKoayN/9uYFWrmsiL1SIk+WtCkcuogXLGCihArHrVDPp36xSL6hcfmM9DgCg0RTzAl0Q87w9V1dSemVdLF/mI1WPTBdbQxofusCGaFWm+Zy5Bcvz/lvOEReIByIm9hyuj95SHmby11p0z0hxrCUrIWWG73BydeblVr54j13//CgvtiMw0C9C0z7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBnVzBKMXl4NW1xK1ZjTTdmZTlKV1UxNWJ1TWliNkxqbHp5OTNMbFR6VGRL?=
 =?utf-8?B?RzhuK0hidHViSTNieXF2QTBzRHZzd05kMmd4blU1bzk4U0lGNEIySzhnOTJr?=
 =?utf-8?B?ZXJKOUZlN1JGWjNBa0UyTjduRktHVTk3eVZiVFQ5YnN0Nk1GcFpHWlR3TmtM?=
 =?utf-8?B?d0xLWFIvc3kwZTRnbGI0YWdxMGxEQStVYzEvNkVGNTVobVdkb3hUU1B0Uy9B?=
 =?utf-8?B?TjBGZ20zR3l3aGRFMjVQeU1VZHFqQWlVMWF3c0tOQWlNd1RTUitBUE9nYm9B?=
 =?utf-8?B?ZWpXeS95R3JlZEFVaVdodGUxNm5mN2RzYkFvV2plVmFJSW1PZUk3bW0wY21i?=
 =?utf-8?B?WHBjY0RDY1hHSkVZRFo3UkRXdnFYZ1RoNS9WRU53dDhTNEttWnp6Y0YwZy9n?=
 =?utf-8?B?Q1J4ODB6c0RiM3BLcHdyejBUUThPK0ptZVdtZ1pBZHVhQkI1RkV3Y2l2T0hW?=
 =?utf-8?B?aTYwY3hjeVdGdjZpTDN2b3hRdTlLV0tnTGRDZkZYc1B1dlh4dnphcHBSL1Br?=
 =?utf-8?B?ajFOZ3FiOVRPK1NITjBUTUd6VFRvb1IxdjJ2MXM3a3JqTjlXWVo5aS80WUVr?=
 =?utf-8?B?T0xDZzc5NnZVeVNHTTFsNGlRdkV4WjhoNGlwczdyV1dTSmErU2hHclk0TFJs?=
 =?utf-8?B?bGN4L1VlV2ZlaXg3a0pRQjlHdlB5WDNpWTRJNlVQUFFoVzFjWnVWU3g0SkpE?=
 =?utf-8?B?Tk91OEdNZUFNVHd6UDZjcy9wbk9KS1dLRlR6bS90cmh0U2tJVFRsVng0RWM2?=
 =?utf-8?B?NWJpMndpeUJaY0FDQzZxVUgreXZDOGlrd3ZxUnl3blVoQjAvV2hIOWVpYUcv?=
 =?utf-8?B?dUJLN1o1NVVSZVQ0OE50aVRDZTVwdkxTQTQ3VEZxRDdwNnF1MUJ6U2VKbTFt?=
 =?utf-8?B?cm9WUzZ2SmgzZWZTdTJ1N2EzR3NtdHYxV1RNYmJxR25JWUdVVThMSThEdFdl?=
 =?utf-8?B?YmlCY3hxOGFMQWJ0djRKb05EVVl2bTNBcEpQZE1nZmdTc21zeGdtM2tlN294?=
 =?utf-8?B?RmFrSW92K1JBeUx5S0hRTDhEL3pBUUtIalZBaTZ1WUdCWTRNM1Y5M0o5ZE5y?=
 =?utf-8?B?eDhsZThnYlg3SzlNSzd1VUE0cXU0TGNtbmJXMGtCUW9yWkJXMUl6dU1KYktZ?=
 =?utf-8?B?VmIrWCtpVnovVFE2Sy9YTWRnWEVVMDMwczMxdWJvaGNleFcxcEZqLzZhS1kr?=
 =?utf-8?B?UkEzK3Y0aUFaTmRsdEpSOFZTRTllSytNcWxoMkZEd0FVWTM2dHdtRFJuYnFs?=
 =?utf-8?B?SlFOdkFDdGNXN3NBaGlBSDROWU1yQjV6WnhtT1ZFUm1NaVo3SjdJQXJDZWZP?=
 =?utf-8?B?VWRLbGpDK0hCUldhQ2srTXUzUHVmckZSZDhRTSsyZU5FYU5mVVN2blY0MFFW?=
 =?utf-8?B?c0F4QzYyajRWVmNDVzhyRmV3TE1VVUZnZUV2bmFpUWFPbHREWURSR3BQcVoy?=
 =?utf-8?B?WVZtc3dPbjZmNy9aN0hmS0tFZGN3ZngwcDl3WUtBZWIxbWlyQkVDa0pBVmVh?=
 =?utf-8?B?N3c5MUNXMTAvUTBFUWxmRitpMHVQYkdGeEZOZHR3aDVLMU5yRjF5WHdkVk9h?=
 =?utf-8?B?ck9qbTQvcVpMTUFLWUliY0ZKa1VaQTliYy9DdmFMeTZUNEdZNElkb2FvektQ?=
 =?utf-8?B?eEtoRjJzMzkrMlpSZk1Fdy90Q0xXRVo0WjczSWtMb2FzSVNOU0I2MzlzWXcv?=
 =?utf-8?B?N1JEWGo4TklaYWI3R05LNHozRE9NM0ZxODM3cWJ0aGdJSFo5UnBpa01sQmpX?=
 =?utf-8?B?RDhoRFB2L3FiNnhmSFhLYnJjTEpZSXlVd1kwVGIxUUQ2SU1hbUo1YUpDdUJp?=
 =?utf-8?B?Ylg1WGd4VnRlcWhjc0RZT3VQNG95dVFLNTgwemd1VmVhdFhMdTRhaDRMbGVi?=
 =?utf-8?B?dnQxWDFsU25WeGh0aDR4dFk2OTNMNVNkNTJnWFl3eWJCM3BYUnI4SXhyUVNl?=
 =?utf-8?B?ZjVQa3p2RjFFcEdYS2xpSUJsMkp6NjZYTnpkQWZ6TnVLUSsxLzNBVlhGU1JG?=
 =?utf-8?B?L3I1VGkzTEV2MEZCZGlrVExIdDJ4SFFqQTJmTFd0K3JNWUQyZzV3ZDUrN2RU?=
 =?utf-8?B?Wk9xS2hmZUl4b3p0dG1uN2llUHNwZ0FZSmFOc1EzNmd1ZUhUc244akJNWFF6?=
 =?utf-8?B?Z1A5T0E0bXh2NzMvUW9xekNDS0taVS9yOU9pMU5NKzNLVDNCbTB0N1JhL0Nh?=
 =?utf-8?B?dktTdXkvSFpPTUdYajFNQnZyQ3J1RS9sLy9UbnpsSFBDbUhsK1RscEZHWnZn?=
 =?utf-8?B?ZEpGcVNlbG53WkczYXpKYXpPMXJCc21PVkc4eHQvUGFDT05xRlVOdUpXVHg2?=
 =?utf-8?B?M1IxUGkvSUlteDBmNlhuSGdSaVp1YVN2WVBOU1oxdm9ZMnU3dHNnZz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcda134e-53da-4190-a407-08df3141efc9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:17.6442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ziGc9FxcUNvIkb/LrAEvZotQI/CKrcFUUQ+JKGuYox/88h2CAm0oeKE+o/NY0lNrxfBOhlHeFZA6eKNSXfivA==
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


