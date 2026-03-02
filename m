Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F3EA4E07
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3tZ-0005yC-LY; Mon, 02 Mar 2026 09:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sU-00053Z-TO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:18 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sS-0003rA-LI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0lJl96gTh0eJTbzzDfLzhUplaxZZv0EQRVK7zwLlHF6dDTJVejKX7ZdLgbUQJGMRghpPGoMarX6Q4WaOwZqBnZ+Za4AsbrKB60wKLJFWUY71bxl46O5gyz5DsAXMh+6FFLkAzukJJaMGq3ZtMMpX+vbG6J8TCrzT0P5Aamz5gzbR6Aj/hAL9q5trj+Q+VPB4Snd3XD2YMZgy44yuqHHN+uaDwfLsysRcZUzKXSlKhWiK68NImW4jyKtnEj8C+cG7Pj4qRU8eX5LUFvl1w6W9EedAV1JwRzTSHwYRhiGDlw0ZsHxe7cUET3ZBlLLZfLynDugKuvV+5KHDgLgbWYWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCuQI2xm85tWu7VZZHjwOj9kxXtdcjGbLolMu+yDW3c=;
 b=r8fZeBR8AIBUnubHX8Hx3YLmiFwjlSpUzVG9tNmcUlFXxpxMk/XjOzExdOlQFp2IHM/bGZOKBvxT9RqhCQLfqgqmcl5lJrGBflPs7U+1x6bmbGP+yUOHQ6pNcnBY0qpLlG1ddOUim9DvqIJrGV1bnnBonmQVTmvKok+HB+aOuYkEjb0827feL3ADvGVDiNhhbRWO12ajSa65CXxHvU1M/iAIq3ykr/AhvF6bXosGIPoS1Ak7ICXqX0RW7Fc0/ab/8bpjQW0g+EWPPNNJL3pisTuNu0HYhufecOiPBum3jd/d0YkD4u9juztbw5zE6TeyGaJjm568sVbpuZJ7UaFy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCuQI2xm85tWu7VZZHjwOj9kxXtdcjGbLolMu+yDW3c=;
 b=sBSwKePOWvt6kRU+qZDl3VBcV3cagUAvpX1eBudYR938WvRJWBQXVRScw5aEYbWQuXW24vRAgetTOE0PYlvwjRSpcEuOWqkvBfcrFU/yBQWFig5f2U3dlgpH2G6z/Nvg0NREZTvDDdyXKUllCK79xTd5z1/wM/WtTt1rTFhVaZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:48 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:48 +0000
Message-ID: <9adb80ba-e635-4472-a5cc-a37ced7438df@epfl.ch>
Date: Mon, 2 Mar 2026 14:58:29 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 3/7] plugins: add PC diversion API function
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
X-MS-Office365-Filtering-Correlation-Id: b12f7a48-5bec-4a7f-d49e-08de786485e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|19092799006; 
X-Microsoft-Antispam-Message-Info: T48Z30O4mTfWByDLYNG/wcTMGhKh35gBFHVETFyQdbS9fb3kemxaJu8Wg+PgYXg71Q3ThdRwcAUAZtMDj1yaiyWdE2J4sl52H/tkeJ1M+YawFYyxhAzH6kulkZmukO9R2HmKcCVO+vKkL6CeXps5aaZNG3JsXXKqQ1DFh2oZtA2mnXs1T8CxJK20uExZE9m6APwB9RL+AsU6VsB6c5NyD0ygaELncqeQXU+TmWn2l+Pqcr31TtW3c2+3IJYgmlSRltrrGC7T1F67kXJw8uwVZkQ2x89rhZM9+kUIKnwrH8lwDjL7hkltgnnYjG4HPYVsxctVrN7jdAkT/OZkSpCI3nin+C5SSI36ZQ/07IAPESz6Hb92BmsZXZPHwvWUBHh6nAx0fFyDL7ZHIr+o9s9y94FJz14Fc6mQAgi7px96iOkIcblrb/B45mkO1qFTW3cNbahwP9kmEYYmJgQKs7HblQE+BXQfOMx6iD1LCxDocVJrwIhZ+/0wtPQh6z88eYVUvvs+5+1usz+YzHoVtmj4J/J/BW5FOvaFvTy2PtHQpw5V1l0VK6WfJC97ZYz4fuR0RdP/YWXKXFrvbgnQc3mUYjSPdu37oK1/ZnPGPMfF9ZBrgJ528/98E2DDCa1rMEebrlYzX3AY2aFjkRaLxxeNDAQssYSaGVXT+WZ4IVZdB3K24sZjMEskkUY5ZfsJzZ/0gEaybluAxeAAOr/9S6aBJH36DGk8cpwtymtVUgd2B8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVkL1dCVThVRnNYQlZLdjFCa3ZrQWlWVTBQdzR6Q2pRTFhiVzkyTGZkYVpM?=
 =?utf-8?B?SHNmdE5qTHBBYTNiNElCbXRnOC9wTk4xcXVwSUFQbEZzMzhGK1BJTVBmeEZh?=
 =?utf-8?B?RGNlaFYxUkZwMUo3ZDcvRGYwWlpuYmo3RXRvYWxGTEk2RkJzVVhlU1dGQ2N1?=
 =?utf-8?B?d2RDVWs5eVhXQ3FBUlRoSEtxNW9Rd3JWRG5FYjNqa25wZmdWZFVETXh2L09p?=
 =?utf-8?B?enlzZUJ6RlRwM3Nndm5XbjhJMkhxRkVNWXpsbnVtRm9TNHhxRThiSVNORVRx?=
 =?utf-8?B?Z0d5Z0FVeS9HR2lqbmhJcFAwNFpyR1UwRGI5R3NFYUJMZzhSeXUvUGhjLzB5?=
 =?utf-8?B?Wm9yNzhpQk5ZQ1pvdWM1UHBjUk9sMFg5QVBqcUtmMXpKdVNVbmhvaHg2bitF?=
 =?utf-8?B?aG8rcm83bE5sNFFWb1Y0N1h4QnpSR21tOXlvRm1GcTZaZVpxR0Y0ZGVpVTR1?=
 =?utf-8?B?YURXTmtGYTZxaVNHU2llSHl4ODR4NEUwL0VYR1JkWjlYcjNKTmZtaUh5OFlT?=
 =?utf-8?B?WFlkMVhNY3NNV25qYzQzRjdWeWJPNDlNZ05yaVFOU2RHNmVYRVBBTXZHN3Fr?=
 =?utf-8?B?U1k2d2tDeTlLMDh4TFJndXp1aE9sM2dqb0U4MSt6d2lTaWVtQ01SZUF5eW9L?=
 =?utf-8?B?b3ZQcTJLaU1LcXV0UEV4RnNhbDMyLzFsaUFESTE4SWlWdCtvVmtodk83eVEv?=
 =?utf-8?B?NW5Ga2xVZ0pxVDl6Q3E0TllrZDlZR2tVNExaSzAwbnJVZGRabTZ2Rk1ORU1x?=
 =?utf-8?B?NGoxUGRWOVhHMklWd1ROYlRacktZQ2V2RUhQNnBORUVBaEF0RkRQZnlMalVa?=
 =?utf-8?B?b2Rnd0dTYzd3eTRLNE5sVnVwdlVhaGhFQWJMNXlkNVhnVTVvNmx4TjlMSDRs?=
 =?utf-8?B?dUhrcVhhbEQwMDc0UDBQcWNla0RwVFF3blZOdldqV0pKWm96WmFGMTFuZlE2?=
 =?utf-8?B?VlcvRVZoY0U1SUFJK2pPU0dMemlxSXZDeXU4R0RvUGx4RE1vMG51K083RFQv?=
 =?utf-8?B?WXpjWVR5SlA0YXFaaTh2SGgvdHIrTlJkck9NbmNRRmh5bjFOQ1FLNlpFMzNB?=
 =?utf-8?B?Z3l3MmZjYm5jWnNWdE1HMmNlaDBpZ3l6TXE2ejN3enBnV1AySXViV242Q2p5?=
 =?utf-8?B?QXdSaHJlM1FVek41UVN6Z0NtY3YzRkthU2hKL21qSE1EcUJxeWlMOUFubkYw?=
 =?utf-8?B?SmxoUVBQZFBiL3lxQXNtcmQxM3dJbEUzQzB2RlRWbWNab2pYZ3FKWDdmTyto?=
 =?utf-8?B?M3E5N3gva2ZUaEVMa0NOamoycVZFTkN2M3RaUTBJdkp1dExFd1VacUxJRVg2?=
 =?utf-8?B?Z25zWk5BK3RKY0RzK3JMTjRIK09sb3VHSDVVSWxxSW9lbzZHWU9zZFk5a29n?=
 =?utf-8?B?UzBzcTRHN0NZUlV1S1phaHpiS0hKWnZPNHZMYjMvRi8rNVpKV2IzT2FEMTYx?=
 =?utf-8?B?SjBlVHhhNXZQRUFGS00xOUFobUc0dUZjVHU1R251bXhMdEU4aFh5R24yS2xN?=
 =?utf-8?B?bG9ReW5SUXVrZk9PdWJEUnd4VTQ4dmczcDlyVWY3L1kwYTVhZzhyK0xxRnV1?=
 =?utf-8?B?dVdMRVV1bE5xYUNiVXR0RzNpbVVld0VtUDNzeHh4SU9BMGVURkVTNm56ckZy?=
 =?utf-8?B?R3VTcXFpQnNWSG9xRVRudjRUTitXWmJFWkhkK3l6WkF4TFN5ZnZxTktTek9Q?=
 =?utf-8?B?V1pEbnhHZUFZWlVvS0RnaWtmT0tTMXUxa0gvaitTdFZKQS9LQWoxZVNoSWhs?=
 =?utf-8?B?TE0wVU1iR0V3RUlrWTI0cWZHUVcrRDhPUnlycWwyeWNCcnRLbXk3MTd2RHdK?=
 =?utf-8?B?WS9zUFRGTTNueEpQQSt4MkpXSDNpS2p4ZVk4NFJwcXJhRjdiRkl5aVBLcjB2?=
 =?utf-8?B?M1JrcHMyOE9SNk5lckNIbFpLYU1lZXdOdDN4c2p0eGwzaHZrSEJpanlid1g3?=
 =?utf-8?B?YjRuNFEzaEVuaEhqYTM4cFpUZmozSk1BenQ0VDlBTHdnS1NiTEZySUVTTUZ1?=
 =?utf-8?B?SEhFNHNKR0lTTHlNc0lOd0VQVFpLOUFkZys0ZHNWeksrRnQ1VFpQcktjMUJD?=
 =?utf-8?B?SkY4NkQ1VGJLUTBWZnN4M1RmUXZHK3VFQ2hBMDBJU2hrOVZIS0NvT0RoZTFz?=
 =?utf-8?B?eUsxekwyTFFRNVRQcWdteW5vbzRlMHdFd0tqOHZQVkViQ1cvc09wemRDbFJ0?=
 =?utf-8?B?WHhDbnVKYmZrbnJsVUp1Yk1pUXU0L0hVdlRVa3RXWUZtZUJJWUE1ME5LWDVP?=
 =?utf-8?B?aFVPN3hVUTJvRnR0VVg1N2tzR2c1ZjNhQzlkK1l4aHd5UlhPYmdoVktMOCtE?=
 =?utf-8?B?UVVHMXpWek80QklER21WUWpQOTA3aldBV0FQRzJDME5Jb1BMYzI1QT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b12f7a48-5bec-4a7f-d49e-08de786485e8
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:47.3496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpX8brl97v6TQd6dOFHyz+wXdqdkm+BBZHtR/vsqmjkanHY7aI30FbVJziz9phdWb6TOx++W9RfByJvoY9CFAIEiqUXZxdLCPCzj8VxCzco=
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h | 13 +++++++++++++
 plugins/api.c                 | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index a6ec8e275d..f083c30fd3 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added qemu_plugin_set_pc
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function does not return.
+ */
+QEMU_PLUGIN_API
+G_NORETURN
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index 32eb086300..23c291f644 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -467,6 +468,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    g_assert(qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_RW_REGS_PC);
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
-- 
2.53.0

