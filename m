Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B168C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuI-0006ef-T1; Tue, 04 Aug 2026 11:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuD-0006ds-9f
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:13 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuB-0004md-Pw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX/kfOmgAhYSuaWQkoVPrJPjb0bTkWlXheXzkkRstxQ6dvwqQ81Oiw/vF8BehADIgbtl5ZvHh+LHNU9GzOGprdCQz5J6JXcCFszDUYZ81cxGLFUvxW2JRSAfBS6V0G+Ar2fxG93ZYNjDUP0ugJqolQM1anCJFUOGfYY//crulV/YMwH1dfm4uCnqY7z3hljuuvC6eOcj0s8kPmnNNHDUBAVA6zOPlkvBiyzGF5YRRGxXhKX5XGTjhKG5CqX0ZFukk8KSTEljMaYv8KlSpW7zhc++Y0JW5iHQFKQimDKXy9Mr93SrkV1ejftHzfdvErI3jdE/vhfLxkzDVZwm0xX3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpjDBV7Cz0re1cZiaLvg8YGfeD5P98KQfzvF2HLGiCE=;
 b=xfJaumBih13qkSOCKLINPZcONesuq7N2S2AhI2xpe7PXVS/azcaRyQMZ6l+Slco2WdTfz/ogoxPg84kY/CX7ZBTp+UvI/LW9OCuTOKxBG4szvBuS23ND43HvIEpg842NQaxap8QbVjl+BgUIpW9s0JZRJGrmhhruraZbu4TOLPVvxt+Z0INsvZGWbrbZ1opGWGXPjiGbczqe9H50qwKwhkw32veDbaPAw7hXTfDap+mI5h2yzrZ3OMumOaiwOXiBE5UGoPNwYLXW1CysHsYXgV8RVihrHfjjmcPp+4L/xGTCEhqju4d1hl6eEv9dypRReGj3bD0igoJckgiyxQjNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpjDBV7Cz0re1cZiaLvg8YGfeD5P98KQfzvF2HLGiCE=;
 b=PRNUdeVz/01caLAsu1YnPktuhcBXyDhzxxVBckgVYo/1lUcdZmQIwIf+om8JhS82azv/ouK+kCLwzCqQ4x69acLuSb37V9FOIXNMlsZKH5T10vbGUZtUQ9zP7v9iAxQELfbZl5wpxw2hj++GHUp3Amc6Z70m6BmbkcF8vO+vW/nveAOzqrDjQ2OdUuMAX8rCUcBl/L5ESIioknM27t6S9NN2+3zUlgen2u7bu1n942SWCjmXRUWHpHTkSY/BX2vGgu+EiVP0LbtpAUJ+d+8OFt0N5vDomaeqel7OvAq3Y/2p2bN3a//TcWJJ90PcUeEXCMLxrDw+r8gmEdSxbu//2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:57 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:57 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 7/9] scripts/qemugdb: coroutine: Handle target absence
 gracefully
Date: Tue,  4 Aug 2026 18:17:41 +0300
Message-ID: <20260804151743.937694-8-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f25e7fb-701d-49ea-2883-08def23b9061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4Qz4O1pWrMU6QA1tEsn6+2if7nu9TSb5oOmcEVX7MBdzPENyK+uWGhiSk5Ut0p/Zc8Tij3cKu27pcKKwHcqeXJQHQbfqBJ0gAKCeW5Bn+oEXJxeCV4PUHY6IoZmrwN4iyDD84B6mzWxtQ+fQP3mIC0n3F2HkM7ie1JFMDOqZ2Uhwx8GAq4xjrUUjJik8CWXG3aQekooUPr5QFIhJ1wCD0H/crZ1b2feA/zKEWvHc0uYkdhH+sNfh5FLS3idTd6Pl2Ph8l461Sjozjzj+EFmASgXat95uhVsU1AuFowhruAcXmPjp0ddoUvvV2jLurXszCsIHoWKRE9CU4hoM0tTT4s4gRQtQzB+y4UycAp+jTVmoXjKzex4RSGbtXIPY5H8i9rVgQu0IcjtxNABQ9EA/kbV4d8MWzneD6yeoeS7cS/bLSKBfjHl97mfduXvmaib7czpEY/Bpfkp3vBWzCXaTJPrfH1oJIs1JwDK8RxFAHSuGdMmQJyknvYs3A9ZfvfxZ9TIGkGfguc0LJya8JigFVuxgiYqe7FGiZwK+fCemfIJ4OuN+jJ/l8Sp8CURyXT3BBnWy93CXB1Tn8OPfZIpUVmf9JuEVzfLsExral+3DM37T7nD+f/2YcIsisAz8FidYPxk0C0vNWzMlJq5PLXUkLUZy613AXAqBjTF2K0sjmBbzoUTW36NOlE3o66OTp95zikek3uvGgUT5f370Qj53UzCbXXweV09W4PQhzTcQD8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtLqh+hNcELeHp+cPlKOe0UI88SwMpQsj0zdh5iKwEAeoTi5NkAL9Ic6/lMv?=
 =?us-ascii?Q?HVIoixqHL44R/WD5jyNTEdOZc3NKoR85lPveQecC568tg4/uIu3KznARvlD6?=
 =?us-ascii?Q?uCNKG52igUT1R4B9odfUAom2hzuTS/g4Z5bXIc6YZyx33ef0Qm1zwfzMn171?=
 =?us-ascii?Q?Ngtz9/c8adA1ZquqO7iYCe3kE0+JmuBxdhkmGLOfLbkPzK9Ah/8bqdJ1Lvj7?=
 =?us-ascii?Q?vja9Ekb95y6u7lHPMkI9/sCNELZo3LQl9U1JltU1VpQdVLzQT4hL7Bq4h0f5?=
 =?us-ascii?Q?1RvZwTv3jmWTqk6Gyk5dp2Qlwt64OwJ2ngCzatnmxUBGxD83X+P6U7PSkLWN?=
 =?us-ascii?Q?20Xc+1zm2s9KWfpy8l17sUZHASITtT5tuFVoPaE7ElkJUGNhHZu8C4svfCcb?=
 =?us-ascii?Q?IXwA6c8/ZikCgA1JFWDt2Ewd8Bj+iDrYNsHgd+dUFR/9JKYFPNuir8hNhLCA?=
 =?us-ascii?Q?/2z2kYwZ/f5n0GxiM64L1vRKnlJkX1SuR0umOIB1mh6pP7YvmUArs9htLxvD?=
 =?us-ascii?Q?Uvyy/Zz9GjQy6nW/OuXqvDhJ1pv1tbOqDdF63SyvrVb6WT/WLxwHEM770DY7?=
 =?us-ascii?Q?/rSCbkV3OeIp9/rTin5keD5r+CHHUAOY8ft/vFJ+k1H6+NuzuruFtxQ99x7k?=
 =?us-ascii?Q?2yYe+YrZdmSFpoNIMhlb2P1jg8rsXM3/Fg6O/W5rCCwcPFgPGyOt2nJ+KZua?=
 =?us-ascii?Q?5Ece0dAhaWdiaQRWNFSodnU13EPL8I1QqRT0l4JNxn/ePS2ztClrim/6qNet?=
 =?us-ascii?Q?SwxKfos7blrUt46hoVue20wDtORtuDhVY/EIWW0O1inLaxHPufKJ+dKlHIzM?=
 =?us-ascii?Q?yopeGuvXDjHUMHTk1N9rw1ePykNIb9JPt0DsWwUvGjd+dsd1rJi8lso5KBd9?=
 =?us-ascii?Q?9t6HYPNMnNQGHTGfg+P29NFMU3vvy2yIJs650eGtA0mSKklGXOpC3uIrZOuK?=
 =?us-ascii?Q?uXNdu8DL8EE0wvi9JoXpr23ofMbSZY5WasxJH2Ug8c84JJzh7HBTQu+39UnM?=
 =?us-ascii?Q?DMyXwTQ4P7k0Fuzuwvp/IFVd5dNe5Y6aKxA0kmAIE6snkpVeKPzKToI2Ond5?=
 =?us-ascii?Q?fu7CrkoeeaMzheATGlgpjh1SaxHTk/b3ZNxthBbiUOww8+ROU7OwQ548DD1O?=
 =?us-ascii?Q?WsWpVauDYc6ZMmDaLxQoB0He3BUtCKxgFR3ZcKH8WNeSnr/YLgZ3nAYmIKkP?=
 =?us-ascii?Q?yLw0sQD5TbWoqZiWLQvhenTnGagjEYLC7xEnvBSYlUK3avQrHLqpFyMLM3jj?=
 =?us-ascii?Q?y38Pl7pLSIM6rtzCL+jsOhvoii/UXPSxZUM3haPW4fpGAc8lZ5uHCqCNamUS?=
 =?us-ascii?Q?y63KaFpUn+LVE+V3g3C1msQaJVPdcx1qy06P1kEsNxPOODp0CO18bwulQa0+?=
 =?us-ascii?Q?x7H3iLXYhxPKIIShvz7Q1eUqufLmSbYAY2bfT0zZqEjpbCYsW7CC0Xj/HhMQ?=
 =?us-ascii?Q?AiFZI2E/MJYj2OKYKmE2tztbBvs9hNhvS9i0LoCv5sDCmWFDqBkDAdOfiK4i?=
 =?us-ascii?Q?cddxfe1hG/6b85mj46oEOhlbNuvIw/MvsYGm3OHNIe/AMQ9i9DzY0X3GisM3?=
 =?us-ascii?Q?m3iGTY+IMzGNYQpO6uXylJIcOU7LhawhrCUdQmU2B96irYZWmKqi1dzmJdmC?=
 =?us-ascii?Q?HYBZjs1ZqnClPcLGNl4n1RPvY3/vD6WaCy7tIrmTlPcNBznZKHtv5hpR8EqO?=
 =?us-ascii?Q?ify/Nkd4fFinV/wp0wMKRTOqUIqcH4GaFeKuKdcvHCIWmNGkF4X+0hjgYTjo?=
 =?us-ascii?Q?Jwt43zWEkqXchPLrZ2WtlE21nHWGZ7Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f25e7fb-701d-49ea-2883-08def23b9061
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:57.6376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWIb3pXNZ/QjDwpGesBlibp7BB296p3zhZRICrX6xHwK45JpFy0w9BXvfbcKNAJ8z4lLm8xJdvhW/KBTy+5N36X+9aiL2GYB/3Wcu1Wjhf0=
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

init_coredump() picks the core dump and the executable out of fixed lines
of 'info files' output.  With no target loaded that output is empty, and
'qemu bt' dies with:

    IndexError: list index out of range

Search the whole output for the core dump file instead, and take the
executable from gdb.current_progspace(), which doesn't need parsing at
all.  Neither can raise if the pattern isn't there, so an unexpected
output format now just means "not a coredump" rather than a traceback.

That alone only moves the problem to gdb.execute("bt"), whose gdb.error
escapes invoke() and still gets reported as a python traceback.  At the
same time plain 'bt' just prints 'No stack.'.  Let's mimick this
behaviour and simply report an error if there's no selected thread.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 9148264de3c..3e0b37b73ea 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -322,16 +322,14 @@ def coroutine_to_jmpbuf(co):
 def init_coredump():
     global coredump
 
-    files = gdb.execute('info files', False, True).split('\n')
+    files = gdb.execute('info files', False, True)
 
-    if not 'core dump' in files[1]:
+    match = re.search(r"core dump file:\s*`([^']+)'", files)
+    if match is None:
         return False
 
-    core_path = re.search("`(.*)'", files[2]).group(1)
-    exec_path = re.match('^Symbols from "(.*)".$', files[0]).group(1)
-
     if coredump is None:
-        coredump = Coredump(core_path, exec_path)
+        coredump = Coredump(match.group(1), gdb.current_progspace().filename)
 
     return True
 
@@ -362,6 +360,9 @@ def invoke(self, arg, from_tty):
             return self._usage()
         detailed = True if argc == 2 else False
 
+        if gdb.selected_thread() is None:
+            raise gdb.GdbError('No stack.')
+
         is_coredump = init_coredump()
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
@@ -400,6 +401,9 @@ def invoke(self, arg, from_tty):
             return self._usage()
         detailed = True if argc == 1 else False
 
+        if gdb.selected_thread() is None:
+            raise gdb.GdbError('No stack.')
+
         is_coredump = init_coredump()
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
-- 
2.47.1


