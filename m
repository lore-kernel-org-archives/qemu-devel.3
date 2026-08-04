Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F9BC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuB-0006cz-LW; Tue, 04 Aug 2026 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGu7-0006cG-MB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:07 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGu6-0004md-2c
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ23IG0qC26oTDhUqdHOhHEwVOxcpla/e3Hvvf5vm1hIazFjd0MPa8SimvmSMZi0YFxpw30/Oyxs+lXfBsXOtbZE+DSZ6W6WOoi3WIFUFjgM6Sc9VtukrYWuqqVk+tIqGKNQSWVwBkfMDurAucWN/12CDsPhQySM6KekDKvAP0KPqfxevLQpBt+JwXru16zjt/N4pBVM9qB1TEpMv0gSEfH6IZedrjyTi49GW6K4paH7iP5yuJAeefN6JKFhIYyJuxsi9HkFkDIbMdKlnLkb+yxIk00jhXYyMSyBFCYx9xXpDP1j5dc3Gbwc5HbYcto1qAYJgn2PXXuK2KGsKWHktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQaH81j/itw4J82adWdJOy7FUmgW5xs1AypzYSFJlkY=;
 b=dIWoKNok/eaTtXxukhqSbxlTvhKEXf5kO4EuIE7uiIk6JDva0C6+vjQqz3Vk4Q9bxc32OFhlzpa8pegB6mQcvXzGEcXSdvPHJuw0hubwhL5RAYC0W+wNwQsi2S5RlxRQnd8KfNco5yY9BW7WARe5ENnfWRXuj1gZlxMXON3vACJrofjpWIsiR2/dogeI/5JUeAlj6Of0KeZRJ2Rl4qImglQgdp08h5EZ+42L5T32FxkzPqdIYDHdvTn3yU5vm5yVyuFN1tvAjAbAqZSIcET2njIUmhYfKJMgz4iIsQ5z1L+e2KmUONXYM6g0oEycXUTK+2SgkoBr/OFvUhyrdawSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQaH81j/itw4J82adWdJOy7FUmgW5xs1AypzYSFJlkY=;
 b=r4wdYWfLKqx79hUnKuJ04fa+4LAY8nq93swDGPszNqPQ/v1phk2kRhYtWaEgqj7EvHiuCqJPlk1nUokWkd6Vs9TxFzh3k3WQ/ibhFzu59Jyo0FV74MFpl3cNOmJvM1ACaMotGug3zuQEuuP4UQ1CrTwIBGkNmSV/NLnVtAlVTVz++OGdfpzz/PyNAakkFa+35zGQs4i7/rVzBYfwYWQt3aCvJtAaX6yqeBYnGB5BW2NFWMWfrx2cKtdlwmkV8Woo9GD91Vs7zj4CAdg/nlZeK8Q8dDWEVt7wiTbFIPk8nT4bfbO6PoMmD6G3S+ztvmROODsfHcg+jbcZakQzhEK0dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:55 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 4/9] scripts/qemugdb: coroutine: Don't unwind past the
 outermost frame
Date: Tue,  4 Aug 2026 18:17:38 +0300
Message-ID: <20260804151743.937694-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB10317:EE_
X-MS-Office365-Filtering-Correlation-Id: c7adb232-c9b3-4ebc-5752-08def23b8f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1YIp92tKBmVZZPvRWXF3rtoDzgpO7Xz4uVC7TkAz8KLD3DxQ+S5i5RUMPA45xduXPcsrt0UlElUjPs3JiacPhjvArvhPBvBm8eIp5xWiO2r7mjJgDkFviTPWLWZo6njenHxrx3qOOOO0I+oTiB9hspEyjg4cr5v+JBiIm4MBX/C7f0kfkZWSScLHFzOQeCu+Kb1m/Bp8ifXj8VHw8oTdDh/QxOJOijOto+kyeppa55/HixCoSwaoyw9OEVaA9ZZKG3K1O0dzHuNz35+rJdpOGcuUtdkyDyFPi6LzvQIlaltd3yPRxFfiXWK3bpTnZDcVdr0c3KMzMDESEIi2qzrOtawfpZqyoipYuWHW4RFVfJyC/ZxEJUYoG5heFkoW1s6J7lqYE09Z9W8LgdLWf2rvppmriS2EH64x5XELrY41PB6owx9PIW2iTOlJnxpidnJdtLE7wq+1oHfIzn1dWs2gMN7G4TjW8UQAjV8xVmVJpkh7E8JxZyI+T5HstBB9dGBJsGkqAgjtzF/SRja08nAbLILr0xPrtMSzRhYEjnUqv/mskOnFihV9FYbj4qKFw8yWju2MiwgjTDAyL7ea4qUD/HRiprtAE8+UQazzL7gtDuDe0KZTAFq9VYwFTsPuXTbTW/FIPCfxHlN5XK3ze2+OGe+JJj8MVUJzcjJlGzlCRKs8SQ4ixdTxewOVwJu2BXIu0faf5e/IfjX7C4QmrlttVkVj3TZPsFRXTcQBztlViEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wy7BCS4ZBqCo9GvocqYK2gQxU0w+Ex7PPWO5naEnX9Emz0vIIKh3N8QfkXM+?=
 =?us-ascii?Q?gxggEJglWVcrcNF1b9M501s44owS59Jfq/o4IwFJuC08E1arUoZqE7TNzC/8?=
 =?us-ascii?Q?0fKe65j2u/SmKStn5o4EiOMZY54v4SFm1aa4430rBhn+NmNHbzXZo1/mQZch?=
 =?us-ascii?Q?GvQtpoxBjNNDLj39H+7O/OLAcKF1Jhp3EN9+Ze3HTKPDKF2YgsRtEI9rIIgn?=
 =?us-ascii?Q?hthGxJwpDEI6SAfWQqRl0crkNfpstiAIhLc/S0rlmwwV4XH9vaJnSaf5ZV63?=
 =?us-ascii?Q?eSxkVKalCHc9l2rzZBMeiuKjS/8Ch0xFVWDpbSioszNrI5eNvmFknxhDbWKz?=
 =?us-ascii?Q?7mPUSIjgQsUYVAtsHxRn2lPyWjJdlmAoNO6Gw7B0wyMW/C5uc73jNRaM8vod?=
 =?us-ascii?Q?FmjIYYmMQl6Dp7TDtWcc7dlHgA6OyCiIZhjFKElJSLPKGk84hyDpisbh2wlA?=
 =?us-ascii?Q?NofHmI8b0ZJid+Vs12eq3wo929Aycpmi1hRcjvi1/Q5LDu+6IVx/GplmBvos?=
 =?us-ascii?Q?Xst20NFZ5qhkjiciX/izbJxtX4VdVSlIRKLxvg/tK5puUC55a0bTIAvTzcc4?=
 =?us-ascii?Q?xAIEAoPXlly8irvHPG5n8I5/WkN7wP3VcAAeAumUnCgO9ZD0wW4dzBdQQ4vK?=
 =?us-ascii?Q?Ej3UQcsvMlUTFNjFkvFl/AKl26rugHIHjyaVzSQ7VGrx+N0hjwCpDCCOqKYZ?=
 =?us-ascii?Q?icT9tIMHqoa7P04C7BRVG0LDJCmO+vy7lMp6kLczUNT4eUk/ff53M4wowXI1?=
 =?us-ascii?Q?hFLS3LZuFFTV1WXtrEAOISDTqnF3lC6EaGaerqzne5DSAaJrrBRG+gr12j9p?=
 =?us-ascii?Q?KqAzcFxjVWDJXWnxG7/abUFSC7UTSIXJWh9lSfAcYGQz96EDmIi3eH9W9hhF?=
 =?us-ascii?Q?5ju8f1ACk/KSL/SkZUujvZ2IgJdG9h2OUiqvw0kxJhdBWgeNqmxPrETnRSG6?=
 =?us-ascii?Q?e6MO35SxIj2XC10kKYpNi/57SYsUUEfsWQGfM3UUD/4kWXiQy8Gh7VILKiTe?=
 =?us-ascii?Q?epTqnEj+wEsAbw4tEWtOuxThmpjpnj1WEwXT/5kqcx5Z7loDhhSGgNuCVvvM?=
 =?us-ascii?Q?2GdAZWWmZ1pBVrxFKaIVLu9rEHZeUJWXkamNiwLplGJ1nXg9DynbsejEz2UT?=
 =?us-ascii?Q?somtBzv1abnCVAznHlHbVM8mg/WRyuVI1hvOXrL7mb1FwRiJQWJ+56AZLHG3?=
 =?us-ascii?Q?WwgHRu9hXByeJ7/A0GPctvpwXP4hZWFAW1XCRdzr+QNjVc7C+qAd27HLsSdy?=
 =?us-ascii?Q?3WIBN2ZsqqHUqsu9vBPOe5C7zbumizyHao2reqWX4Eb34gOuILlqaCLKV46q?=
 =?us-ascii?Q?CR1g614FrKI4+gUt62Cqn+YvmpXIftG7kxVVGmB5b/emE+87Xy/I3WcYlkR7?=
 =?us-ascii?Q?n+Ssp7RqtMHR8QtrR+ky8dlG7Qaj4/pFlipp9KNlDO/eNZUWQEj7exFWh9Ov?=
 =?us-ascii?Q?JIYbCeczv5furVXQW+rQz2rM4u+ftaiZCmwC9HhSumnbTvKV0wmZJzBNAOhf?=
 =?us-ascii?Q?Sz6ZNy66XbjjMfpJzdRkN1b8aTgTlSwIIJMC94FelKSwtdosibKEedCriabb?=
 =?us-ascii?Q?pIcRSsa5uSRC275HhYwWCkvYuyDiG/8PoSgtn7qeqPOg7gXFt7++My8T9o+B?=
 =?us-ascii?Q?+uHqwTd3JxT1UbDw2nbMDMs1uKPQamEr2tH808O7BwhfXmi0rQPK86/CJesX?=
 =?us-ascii?Q?7jsdbAn2QFX8PxLEPpuVRVLTPU3YEvOZP7iU5Oai92ZG9/JiU5RLF2JSTLMh?=
 =?us-ascii?Q?KXnkh3iHQLgqf4NVbZv56jf4k1b5M6s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7adb232-c9b3-4ebc-5752-08def23b8f1d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:55.4435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLq63KLDobpsbZqRWVapmBCkHqaU676THJZ+/wEQywT+CS+EDZZalT2azBFLYhLHaZQyxe6NXc7CapuJUNJNufTNzMtsx+bX2ugpx73PvIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10317
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

dump_backtrace() walks the frame pointer chain until rbp is NULL.
However, when glibc is built with no frame pointers, rbp is never NULL
during unwind.  Instead, we see garbage in the outermost frame.  This
results into:

  #17  0x5610b6e9f2d9 in main<+1720> () at ../qemu-io.c:674
  #18  0x7f26cc10230e in __libc_start_call_main<+125> () at
      ../sysdeps/nptl/libc_start_call_main.h:58
  Traceback (most recent call last):
    File "/.../scripts/qemugdb/coroutine.py", line 409, in invoke
      bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
    File "/.../scripts/qemugdb/coroutine.py", line 296, in bt_jmpbuf
      dump_backtrace(regs)
    File "/.../scripts/qemugdb/coroutine.py", line 247, in dump_backtrace
      while rbp:
            ^^^
  gdb.MemoryError: Cannot access memory at address 0x4
  Error occurred in Python: Cannot access memory at address 0x4

As a fix, stop on the first link that can't be read.  Since
gdb.parse_and_eval() returns a lazy value, force the actual memory read
by wrapping it in int() and immediately catching potential gdb.MemoryError.

Fixes: 772f86839f77 ("scripts/qemu-gdb: Support coroutine dumps in coredumps")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 649579378db..da395a1a13e 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -235,13 +235,24 @@ def dump_backtrace_patched(regs):
     out = run_with_pty(cmd).split('----split----')[1]
     gdb.write(out)
 
+def read_word(addr):
+    '''
+    Read a 64-bit word, None if that memory isn't accessible.
+    '''
+    try:
+        # gdb.parse_and_eval() returns lazy values.  Force memory access
+        # by wrapping in int()
+        return int(gdb.parse_and_eval(f"*(uint64_t *){hex(addr)}"))
+    except gdb.MemoryError:
+        return None
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
     '''
     # Here only rbp and rip that matter..
-    rbp = regs['rbp']
-    rip = regs['rip']
+    rbp = int(regs['rbp'])
+    rip = int(regs['rip'])
     i = 0
 
     while rbp:
@@ -250,8 +261,14 @@ def dump_backtrace(regs):
         # instruction instead of the CALL.  Here -1 would work for any
         # sized CALL instruction.
         print(f"#{i}  {hex(rip)} in {symbol_lookup(rip if i == 0 else rip-1)}")
-        rip = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)} + 8)")
-        rbp = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)})")
+
+        # The 'rbp != NULL' condition is insufficient: the outermost glibc
+        # frames might leave garbage in rbp if built without frame pointers.
+        # Break the loop on the frame that leads nowhere.
+        rip, rbp = read_word(rbp + 8), read_word(rbp)
+        if rip is None or rbp is None:
+            break
+
         i += 1
 
 def dump_backtrace_live(regs):
-- 
2.47.1


