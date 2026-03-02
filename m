Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F400DEA4E08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3td-00067i-DD; Mon, 02 Mar 2026 09:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sS-000535-7x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:18 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sQ-0003rA-04
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnEr0Wp+Jp2kqmVv41+TkMZ8fY7MiZKwbv3eWPV2PbAeqFLfwqWT4W7hFYgdF9hMAUxJrOC6mXbufmpdkXsJKtb9IPYcatG4J3Sd84/CEZNISQXopBdbxFkuPZ+0IuJwhVRqYcByR28qi04goh3eLExwwSW6/r3iuNqqPh4VS3rWtAlp0BJVjuWNLaSN4X5Edyb5KYgpI/uMWCJgPRjwBqRKHa6WASO0speCvahv1YFZ6OJJ7wtgdyFjkUJgD+adNdyfFeoTvJuHQqSBVLh0aoK+OieVnNJgpkI7N74FsfXCIY1u/k6CbbVF4ghXzwu6FbR+WGMRlZGoUHkQ15VAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKtxL6WewZUTPxTTW+USh+IA6Bm3oeqYjU4DEzcZtME=;
 b=CQgcJg39eioDbcyp4H/gn87h5Zk7JpfDOqSiRAubzbuqfu7OWqG63uFcBudnSrmpkzQaq7MLCF5ClynUR1fHaYNF9Kp1rpgHlvLTUX68UFaFCbS3NgjBeBb4t0tCSusOmHtOoDaCBZ1R9xqfo4OMnKXQBrz0C4k602C0InHDlXztMCc7FuQwhYLhMQzkcQZ29IlnW90exHPYy3ljmPs18rSzYQKO5zQhuZ4XR9iriBANXohzy6VsrLXqY2N7yG6wf+EEgIMuEeDwmDHQLUZUbm/aBvK/PuOQQVUWsOv1zij10smM34gjdv6y9wYu1CDMbYkOCt8Rg0QDr9DxJau9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKtxL6WewZUTPxTTW+USh+IA6Bm3oeqYjU4DEzcZtME=;
 b=cWIosrRIzLTA7BZLdL9SVKvNlwyjNVkW4JaoHjcwtle1RMHaP0OtEPpZg1dWxcAp5hQdz2En6V3i20rLpEyDLc1uSVz44NMAugfhhYsxHf0Fk35BcRTAQKgkM5SjPUsW9u81ywkvvfm2kanUwQOqj4vwbBJvnraNTrYINvqWFlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:47 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:46 +0000
Message-ID: <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
Date: Mon, 2 Mar 2026 14:56:54 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/7] linux-user: make syscall emulation interruptible
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1029:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2f6b18-8130-4360-15d3-08de78648595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|19092799006; 
X-Microsoft-Antispam-Message-Info: +ztX10lfZ2C2zX5uHoIVBqUlp1o6/BhVYkH6kONGZ5YBrZlzrGyio3pOZtybLcYU5zixbju9S2FMl6GK1YrZZ+wNqs7K44uQUjmiquwHtP/a+4zm0M+dh1H9ffJDSjGh9rRiSBCI5bKTpija6KLUJ3b8BnvIB8XKtupN7VAVJPz5o/OTjM8Mzzb014T8WvH3twAIpYH38GPBnhzkZpV9HLFK9llh9tmyMTvqIvvf9dw50HANnYTw88LpIZh0pas2bKKdj+NFH8afbuVOS3NBvZ9jLAwp9xDO3ackDYK6mUyz64Kc/hhw4Ugm0MXbL6RRsskTBkU4uR5gYhXGYh6RlHCM0rIoXq4ja76gaf06PH8OQstd/abq5ZoCMWKs510woi/m7+vIBG5SuG4e9D9RgFqCOQaK6yiI1cfy5US1K1/A+pUIIvCAklpQ7IJrURVunJj8KnA0ZVvGCkxoMdHMsYLxcEa1inGCAcmZjRVJo6KqYaFYB4hwILf4Y5cY6UosVWoniCbS7FmKoT/eIcvm4URgAV1i7V//5AUGNMrUKb1up97NxrmMnx2O9BCnki77oKpt9crkjHsuuAbrbj/apzYYy10OJ3wZMBOqWo54YMjDXqvZk+PK0DFqkyLalzYaWqViiIo50Co0deJtoNL8j4h9pT3eS4Anwo6Y2NZtqX14RmWqCYiHaHKj4nL/ZnXf1BQznW49j2niyqcH+ab6pE0h0A7atW9JV2TpZGD5MRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBVQ2pBVGFhaStTQXplRkZNUmZqVUNUNzFINElYZHpQUEVNdjhEdTBDZHN4?=
 =?utf-8?B?V2k3M0FUeTVUV3lReU82Q1RXdUh5ZWh2L3lnZjJoQy95V29GbjV5ZnppcFA2?=
 =?utf-8?B?VnpkVHpkUUc0OXI0b283MjNvNGVGaWJhajJrUmtHeUJpZ3Y4T2duVTFYc0ZS?=
 =?utf-8?B?V0llZ3AwVlU1Qm5IVVJrRU1xWWI0dzNxYk0yZ21jcUVuN2QxMVNmUi9VUnl4?=
 =?utf-8?B?S1ZPbEdSN1FVL1I5L042VVlJRGNvT1l2eU4wdzd0SGlIREIxRjFoTThiWDRB?=
 =?utf-8?B?RGpsNE01ZzkzSkRrbXBDTGNOdmlHUko1MlpDempuWEFWZFFIaytTc1Z3RXFV?=
 =?utf-8?B?V3JHR3RkNFUvRm85NjRObUlZQ1lyWkJaY1cxNVhublR1OURmWW1Hd0V0d0Ew?=
 =?utf-8?B?V2YzdzRnVExKQXhodXFiZXFpeVJVVlViL0lLek9QTEllcDBvYjRNL2xYOGwy?=
 =?utf-8?B?aEtRL3dDdUszazRYaVl2aVc2UlA0SmNTQ0Q0WnZCd1dTT0RMRURnVExDRHZi?=
 =?utf-8?B?VC9KMnFxTTNIME5JcjZadGk0RkUwMjBqbldZMnBienpXNEwvWTlrb3RIMk1l?=
 =?utf-8?B?QWpEcElVMVp0SE5RMlVacFd1dHZUYmI2VVVYQVN6SVE1QTFwMmlJVHFlaE5T?=
 =?utf-8?B?cmlNRUh0S0U4VHhiM3JwT2RWV3YwUThSTTd4SWI5UWk3ZkJ6QUw5Wkl0ODFi?=
 =?utf-8?B?U2dld2pUaHY1THV0R1BraDJCVjRoc3NHM1dLRzk2ZWFXVEdMWTNDY2ROQ1Mx?=
 =?utf-8?B?WVp0aHNQZmxITWkweU1ud2NSeHVZK00wRS95cmgxVEhaRFl3SVRIUENjRlR6?=
 =?utf-8?B?MTMwSUgzczFoQitCWHROQWdZZ0VJZ1p6TEFzdDI4azBjcTZRMml1R1pib2xE?=
 =?utf-8?B?cmZNVi9JWXYyaHVsQ1pNNHNPUE1ub3NuTnFwODBqa25wMC9yZzJYa2NDaThY?=
 =?utf-8?B?ZjJwbFAyK3J3ajZnTnBhWGRYVnFKVDZPK0t3RmZZb0dHVmFnbjlWd3QxMWVj?=
 =?utf-8?B?TDR3VFhnc2lXM3l5NWdObkdBMGlHNkdFZ2s3N1VTd3ltbjU2SXBncXFpYUV4?=
 =?utf-8?B?dGhOek5YbVZPSlZpK3ovM0wyWThwa1dmSXlVNDJqck5SZXVWVmxBSXFVUTBi?=
 =?utf-8?B?VVNiU3NCN0tkTE5nK0d2bXdnSHZsOEhQaFBzY040cW10UkQ1NC9JbDdhTEFJ?=
 =?utf-8?B?VFJrZEVXa1hTbUZyQ3NJMmpZT24yZlZYSVdrczAwd25RY3Jzb1g0TVA0MlRW?=
 =?utf-8?B?em5wSTltL3A0akRsdmp5T3h2TVlWS254YmxJaDNhN3U1M3liT3FCNXR3WTZZ?=
 =?utf-8?B?RHdFeDBjMXNUdjNvRGxOTkpLUW9HbFlxRGZqY3Jvd2ppMmVlNjE4NzR4Ris4?=
 =?utf-8?B?WkQvOCtiYVBBNVBNRERpTG9FK24xalM4L1JRb2ExOXA4bUU1b3MwbmhOVHJP?=
 =?utf-8?B?eGZPak9JcTN2TWpWRWJGV2k2YnZ3UXRGbTZtQmNSOTlmelZVcXBXdURqUjFI?=
 =?utf-8?B?MDQzbnRVYnJSZUVJVUVYWldLL0pwVko2NC9jZzNnQk8wVjVMbzczWDBPK1Fz?=
 =?utf-8?B?WmZTWFV4QnRRYVJmSGlhL3VQQnJYMjlkNHBkN0w4aGRNcTZYSkhJQUZFZ2tW?=
 =?utf-8?B?RGZSa0hCaEdFU0ZITHFhMzB5akk3ZnhXZFpuVWpJbVNQUVNyT2J0TDhpeEZS?=
 =?utf-8?B?bkFKeDdNdE5lYnExM2FBSmUreThRbEpDWnBaaFZzcGl0b2hQOE8vMVlnbm9J?=
 =?utf-8?B?VW53M2M1U1FVL0JUSjk3QzdkSVFqeWMyclFjc21tZXRHZHE1ZWJyckxyRUpw?=
 =?utf-8?B?bVFRblFYK0JBTlJlVFo4RGVQeW9SYnlRdUI0bzAwdytkQlFvWlJSdW85Y2Jl?=
 =?utf-8?B?NGhMNFgyTEtMei94bmNPK1VBWUNCT1oxSnJ4TGJMYitEQm42TC9IYjdoQ1g0?=
 =?utf-8?B?K0g5RUh3VHg5T3ZBL0tWaUd1WndVVlhmbjRiMGMrejQ3ZFZRelFuWURTbUVK?=
 =?utf-8?B?TWpWdjhicHl5VG5PNEtPVGUvNGhFV1BPeHlLR1pxeHRhYXBmUENtblFqRTA0?=
 =?utf-8?B?a3BQZGd0c0xUbC8vbXJPTzJHYmp0Uy9QSmZLcGRZYjhQR1puL25vRngzWEhT?=
 =?utf-8?B?OWZvdmV2OFNRdGNjSlM4bjVpMFRPcTlocWtSQTNCTUIwY3g0SVBNTjFrcG55?=
 =?utf-8?B?VDY4b3R5cFNEV0dwL1I4WEZWbzVTYVVSYUNNaERVWXNQOG9PS012Q01WR1Qr?=
 =?utf-8?B?aWJJQUdGYnp5OEx2YzBrNm1iTU5JUG5ma0FJZ3JBblRIQWRQcnNWdmMwaVRj?=
 =?utf-8?B?R0IxSkV1amw0eFFiK1AzWHdLNC8zdHE4bVorZ2NidXRKY2Mvejl6Zz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f6b18-8130-4360-15d3-08de78648595
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:46.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqim9z0t6n1CH9zG2pbABmV2EKGc1EQWRtOv1QD4SbJSBHKxSVnerMTe4hVV6OQWyndBBYkkR9WQqHM1xGWdj3SqjA4/jzVABXrQhRs5wLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1029
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
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

The syscall emulation code previously wasn't interruptible via
cpu_loop_exit(), as this construct relies on a longjmp target that is not
live anymore in the syscall handling code. Consequently, longjmp() would
operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
setjmp and the necessary handling around it to make longjmp() (and by
proxy cpu_loop_exit() safe to call even within a syscall context.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  1 +
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  9 ++++++---
 linux-user/or1k/cpu_loop.c         |  2 +-
 linux-user/ppc/cpu_loop.c          | 10 +++++++---
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               | 16 ++++++++++++++++
 linux-user/xtensa/cpu_loop.c       |  1 +
 19 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea..e7f643d69d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d..19874f4c72 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff..9464246e9e 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487..4b4b663052 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)
                 break;
             case -QEMU_ERESTARTSYS:
             case -QEMU_ESIGRETURN:
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..fa264b27ec 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,9 +140,12 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid clobbering register state.  */
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid clobbering register state.
+                 */
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)-1133) {
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/or1k/cpu_loop.c
+++ b/linux-user/or1k/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f9ee20bd0 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid corrupting register state.  */
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN) ||
+                ret == (target_ulong)(-QEMU_ESETPC)) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid corrupting register state.
+                 */
                 break;
             }
             if (ret > (target_ulong)(-515)) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..ab633eeae3 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS ||
+                ret == -QEMU_ESIGRETURN ||
+                ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d466d0e32f..99e1ed97d9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    /*
+     * Set up a longjmp target here so that we can call cpu_loop_exit to
+     * redirect control flow back to the main loop even from within
+     * syscall-related plugin callbacks.
+     * For other types of callbacks or longjmp call sites, the longjmp target
+     * is set up in the cpu loop itself but in syscalls the target is not live
+     * anymore.
+     */
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..d2b4ccdfad 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)
                     break;
 
                 case -QEMU_ESIGRETURN:
+                case -QEMU_ESETPC:
                     break;
                 }
                 break;
-- 
2.53.0

