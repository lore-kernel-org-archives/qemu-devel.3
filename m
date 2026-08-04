Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E8C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuP-0006fy-Po; Tue, 04 Aug 2026 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuL-0006f5-R1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:23 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuI-0004md-LF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOSan/rIzhg+SoQ95FA+J7AV63vJxiwuThaT50z7jVk46kEAByNXut5mcGxXb9rF9jB3cfDS94bM9PnZGUGrxKTZj4zUkmYwZ47mlvAOxF+1MzJ0p+C89poK71lBAsm7hUCl/XDm1wBRSDy5XJ+wBvSyDmH8lvL2iS513laZVmyXr1KJ4Y4NKueppqnitl0efwYAL1H/tKW5cViYd68S6FwI1hLFwOKigl6R92/0iwxpIW33m+W8dLBAiekprOhSy0BJ65YCqK1ZOyyUAH3qwRz4HSD95IIBjbM8kYlKxBJ6xQHeudy+kVB7WlI7aWqPxtkzCFCrarN8cEKesQfI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llIjZRimUjn75xGNJcp5N0ySW/EWYaWzILlqXl18SmU=;
 b=S0zzE1l79VaARqRHEQoyzOPitNl1fRLQRqkiclswY4vYp6If0dCskB/3Bc8EG2fLuikfMXX42wgUBEAvGGLH982nuDXfsD+Nz1Rw5V3kvFFKetVKDXskaelOENQV3RlxDpP+WsYgB+O2yWAx5puPiXNnxnmrR4mO0Zkqlcvgzdx7H2cBt49WJPhrnBYAFlmCSA1qQgXA3a7778PBuyZNtBfLDt/cSAvOeTaWnssexYPMC6u4t6leo33r87XIBPcyaT9pEMO+VCsHCgXoCX5S7YEa364CjmESmcmePH7XA0PefhO9oFJd9IVwqrsTwCkkcKAmyHKM+zy3Egh4tamYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llIjZRimUjn75xGNJcp5N0ySW/EWYaWzILlqXl18SmU=;
 b=SA+yrhWS11GQdhhQycqXGq0p9EinazYoY+wIjVYFlaZ6ofIZTfo/GnV/VuSIG9Oe9T1vmn6T5JEjJcQJ8RCvBgoimFNc7tW7M4iwzAGv+wl1MvfL+jImfbI0eyPBFWkhwVdfWbjDjgY0+eimVoAhd2fMzTFTJhXiXRrbLHvURaHJvPKN5HZYbptcYLU7yhY5GJCsdeXVAJNFYSz3zgQw9aGscDi0bDA7f4ocIWJLNbrqnY8Vy25DSqMlbp6612trrY7tjtUQ0ZVt8gZSLryM4ajFdgkkUbdAua7wah77iB+cBc60S9LdJH5uEGKiot4zhk6ygPjVb4d7/gdnOT4xzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:58 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 9/9] scripts/qemugdb: coroutine: Don't touch the coredump for
 a plain backtrace
Date: Tue,  4 Aug 2026 18:17:43 +0300
Message-ID: <20260804151743.937694-10-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa30f3c0-b036-4499-d3be-08def23b913d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xrfgjym89CMphXABJ8AMfoKGEpGsdb2dFTgXKSSEAZTCYJ4Zv6BpO80PKDcMJ/kzsuIrYuoenwixKnraEbj2Lh4uR68KKOVAQT0gSk8pTVsgMGa4zBkKyWja6e6HZ+0xYBFuFt0sT+NO9f4cb8GJyqjcBeFnrPOshhsl4T58kPHszfok5V4UX69YQ4OHACUBnyiB8O91/viQdceK3rDECUCN5OS+kVcV9Bqy6qFzgB7kVlUCICe3/79oA0XVCQgU6Y+eU4vM76Sbb/7KAR5SYBGE+5o+0SSHoLSNSpL77WbYCr+XdJEnRh9/UwdcDK76IZCjfm8jRaSSK3o+vQWuV/eUwBcmwSoskEHhjs9qB1CvY21q9tOM50qkYDhf/Kf/3P8a8zUtDxp9W+CAfr+ksg0habKkNvI//sJhXpBXlMdu9X2F0Mx9kFwRsuoFZzJzJCEQZbgDqU0hTMZq63swcdb11S837F+W0OV9oh/nrt1Y0UCoEXbCNKXkToun2iK2dNM7valuk6nkXtk4NhlLqgSZWGOA4d/pHQgziD0qbxZ7NjQGYMuzpo1THUtZPN1F3vlfogdKW61XaYqy3tkJTNRjWQvwmRRGedYpRwlZ87kfhm+RS0hl3eATjfG2BvrE43KaRV1K7nYUtOav846RriYO2iYq9vMwO3TJL5ArWitdem3VqwQasppbtYh+MZ4F5IHglPB9ICBhLwL4mnkLPszzWH895e61fIkP66a46HQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbc1zDKgBoWDN6O7MPCpwCSM1J2MiapbRsWp59/45eNEIZScwRh30/D+bNjD?=
 =?us-ascii?Q?3k+jDwGtzyQzV2zogWQ7MdeavmyP1RE6naAnKA/+VDXIx+WWQsLItwLkjMlt?=
 =?us-ascii?Q?RGuOFVlIue5A3RkNtpKtnvUEvEK+3rIkPPcWQK2FbXZ183ff9K/RnWBhS4ch?=
 =?us-ascii?Q?jv7OorFaV7NHOT3m6PsKCt+DS3YYiMjmRh/eJdKMHR0FjqAGHU80KCCLu+5+?=
 =?us-ascii?Q?DONxM5z9rDNB0IW/fs5aKoeSHB7bYO4iXcskymaE32ECvCBzI5rrjXrHy7IE?=
 =?us-ascii?Q?vYtQ64WpOVfbawcpc0CUSSYraJjDc9ef3BOUziDfk3FnCmvKTpQrxm2NFQHv?=
 =?us-ascii?Q?RnBbG5J3g79BxhlPKzLRBXt91dNyhD7lbpOCFowIwoxh0C+lBqSAdxJ9OwBy?=
 =?us-ascii?Q?HIw94cjVZhYK9wYZ0Qr/J305vlvLTb9/+EUlX87/G0CFSx9utRVHnZNxOlum?=
 =?us-ascii?Q?ZOBtT4HGNfY/xPmh1Vcis4QrXiGUoXSMKD7uedGhExgnE0VZFrjin/YM5wzJ?=
 =?us-ascii?Q?7mlcudZyzZexTTItoxTuNrRAvEXNuBZkh6o9wdyW0ca7lT0+ifOZ4I9n3B8F?=
 =?us-ascii?Q?KCP9/G8K2l55k249NC+YDXvsOAIubu3OtmBlCYV6BC8YSZ2aTQfIRW2jbrlM?=
 =?us-ascii?Q?bVjlXYAbwicazPValQoe+sgkZyR5XL0LzYaZkKaQN6PVZ/GFXpyNbjbuwh7S?=
 =?us-ascii?Q?BlUr4oetYsBKESMT3W5iOG3Vm2t4ZLMm47Nj+AU3l2pmqVddsF70FYtqkuyJ?=
 =?us-ascii?Q?GDZEW83OSjAHe9yPpEvdiYVD/7vDiaR7+9kAyQ1Lot8WinX+Xl3uDxAyrZhZ?=
 =?us-ascii?Q?QDbVoAW1rLmJ/kTCn4ejHQ47CuDGoYvb/EL2eZJW88bR3OTOLn2eO1V4waQO?=
 =?us-ascii?Q?rjfzb3hPiLb9jFPpPYTjLXthaEUoo9VCG5pgsYRb9d+TDLrFhfTiWtA2QsXk?=
 =?us-ascii?Q?MMLUmguTK4P4+EkMLTYgFsI691VeAYQT+j2sTKjGI+kynKEFVIQBxYHFs23P?=
 =?us-ascii?Q?MRC59bRzDtNlV6p57sFBGud01J5D9V8Impyl4MvzlDh9zob59Eon6ynU+Vwt?=
 =?us-ascii?Q?YM7qTKTBSC00Wl/ekuMCk2N3KPCJNH2wEKtjRMf6CG0mS83St5K4d5Cak2T5?=
 =?us-ascii?Q?cTF+zl/mg0kfqu4FRXokypLsCWtV+7v3mT8p8a9vTcmuXWA1zmnFOryp03Vg?=
 =?us-ascii?Q?BptOP9mgvrcv27e6nhF/YOw8vqP1QhDz9tzBc0sZe7RW+ZYinXkxXZ/MR6vO?=
 =?us-ascii?Q?hfTvCjCv9dpqDqSa3B1k7yKrG18kOPF6pnfGcUJbrS9RI+1PDXi3HTshh0XA?=
 =?us-ascii?Q?8an1htO5RYCbBjngJPSKEGSKrLiBwPOvMD1rXR7SCM+FV2ZC8IHB34tDAm1y?=
 =?us-ascii?Q?VuYYTLoGQfljNkbesdLkJ/4MZ1A50FzUKhvlEzRhBbFTy4hoCXVNi9JM81cf?=
 =?us-ascii?Q?qHN3r/Rtsi2J36wDFH3Bde7Lw4tLb0Nt5UEhevGHjhORX6bjdAi2w7R3Afus?=
 =?us-ascii?Q?hMkJ9hvXv2MuJUvYIKsSyZ2CGAzyEQLX0N3sYk1fZ9UCBGVqLG4mOmBleiDq?=
 =?us-ascii?Q?fDGjKI1PRWYdJpOCMN9KDoJunPTR39nI6fyZg7wNALnXG9cO1jPZ0b+z3W+y?=
 =?us-ascii?Q?Pd5wWcPYXatzpCBl22rndIuxN7GWWVuPFNGSswedOXZfSTL9PNMpCFfD6bzJ?=
 =?us-ascii?Q?NvLAtm7FW2VQYfz4gIcXGwJJ2Kn9rcPvHpDe9VRyUlHnHX9TeTgAD+sP1xSe?=
 =?us-ascii?Q?4sw3hUY4OXKVU0jSS0/oL/oigcwjlj8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa30f3c0-b036-4499-d3be-08def23b913d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:58.8597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B06VveUPodAGV0DiXBlF7q3tvoYDYgCN8bm3+u0qpYeOo4Ht3XOUDJ8REg5isjayCq1zhTD0Od3wBrZU8BQIN4AEzOwmRslDTGcgbLTsPS8=
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

init_coredump() creates a Coredump object for every coredump session.  That
implies opening and scanning the actual coredump file.   For non-detailed
'qemu bt' invocation we don't really need it.

Les't only create the object when the core is about to be patched, i.e.
for '--detailed'.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 21ed7cbaab8..edc1f3cc69f 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -328,7 +328,7 @@ def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
     return coroutine_pointer['env']['__jmpbuf']
 
-def init_coredump():
+def init_coredump(detailed=False):
     global coredump
 
     files = gdb.execute('info files', False, True)
@@ -337,7 +337,8 @@ def init_coredump():
     if match is None:
         return False
 
-    if coredump is None:
+    # The object is only needed to patch the coredump
+    if detailed and coredump is None:
         coredump = Coredump(match.group(1), gdb.current_progspace().filename)
 
     return True
@@ -372,7 +373,7 @@ def invoke(self, arg, from_tty):
         if gdb.selected_thread() is None:
             raise gdb.GdbError('No stack.')
 
-        is_coredump = init_coredump()
+        is_coredump = init_coredump(detailed)
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
             return
@@ -381,7 +382,7 @@ def invoke(self, arg, from_tty):
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
                       is_coredump, detailed=detailed)
         finally:
-            if is_coredump:
+            if coredump is not None:
                 coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
@@ -413,7 +414,7 @@ def invoke(self, arg, from_tty):
         if gdb.selected_thread() is None:
             raise gdb.GdbError('No stack.')
 
-        is_coredump = init_coredump()
+        is_coredump = init_coredump(detailed)
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
             return
@@ -441,7 +442,7 @@ def invoke(self, arg, from_tty):
                 bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
                           detailed=detailed)
         finally:
-            if is_coredump:
+            if coredump is not None:
                 coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
-- 
2.47.1


