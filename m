Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE1FC55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuJ-0006er-Aa; Tue, 04 Aug 2026 11:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuB-0006d9-A8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:11 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGu9-0004md-Ob
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOX7sSRyn+vwGE54mfraUMQrlyYMJUpWCCyc5/IO9Ff4GYojJ3TKgJzJ1aoC0xK7gHMzL0wuGC4G/ArD5HYfslymVKqEjha91vzpy6i5bcjegNetfDha5GuIk8ETMPy7Cy3KwvxL6tLPyTxnheXamPGtqWSeKQ/Bymj5ucw2zYKOQJxKj1Qd9T6SKCfR9NJMKTyjRtfuOAozEbw8h2HeBFRmwO5WlZeYyTxsUdTmbG2ijZWIbPuktqyzOnQIGlIWxvuujGOMCY1KgrB1XNw8RDT9si0LJ4QV8z/okBGLtAVD776fKPZB7h1y1fE4koRwjkEoEv9kGXhOpKS2/8wb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IXc8O+7U43tmvdXZuySHd5lH9bG7bf9u0h410ImcB4=;
 b=BH+nSv3cOzIQvRFMBATNUEcjN6lLnzS17Ntdw7vfrQGAwBi/95rgO5nshImjHZw69U+x6eU/YUUjVPVWsaoagHJrPqTwq3fr7M267F0xob0jBTs2u3sjTQ2rnjTRT0jdfTcbznc9i0aDwzbhpa3MfM4XuX/QmBs1g6zK8Vq4R3pX6RNQl3Zh/coq/NNtdka6qdXqoJuwVoBBL1zGPq9K74dlZL/ewUZQ+IOrwB8tnVxvLtwmdoNgIYOPZA0DfKm79FI70STX9APFAC7a7e9lgubbL8Wpz4F58KQZj+/e+w6hJisbSUzuL2SIidhI9s+yoUpO5027wMgoDzxGeZTWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IXc8O+7U43tmvdXZuySHd5lH9bG7bf9u0h410ImcB4=;
 b=yqPXK7nkBXbAssad2qhy0BQLWXTc4FzzP7FMx5zQ81hjTuaNp60LkaRJPJfAd3NKITQ01dEQHDj+S3svQTh+B+/sQZy6S+01IUcf0sTI5XXYYqsg2HzY4QDSbkQ2x49q+KiLhtihmS+rhapn2qVIlqY4jOrGFKWkvq+D3ADbAwhQaKu+lJcVKF5X+izWoYq6uIpuWazaAN71XXDWsfnEZ56s6khuk39B3vFh1IxlbXRKJ8h0JSDOBG9cCAg3kTwcnmQ5w28ADUm6/dtpIhk21cyd9ZF8d2Ua4HqrOhtLeWyiY+QWLPzKB2lg+CNFoTkpXbZiW+ER2i3tXkkQrL7ADw==
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
 15:17:56 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 6/9] scripts/qemugdb: coroutine: Fix '--detailed' description
Date: Tue,  4 Aug 2026 18:17:40 +0300
Message-ID: <20260804151743.937694-7-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bac95ce2-0af5-4146-4d62-08def23b8fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bwwck3YJIV670yfXfxrsvwLDmjVsC5f8/1R4LJBeJiekOIoek+bRucsOHcOcdfwI3qjeyMc80fie1prxHgQGIDNkJFavLK6fnvIittF93fqJY1FEqVBjQmTlbmRgR2wM8ydUxx6qNf0lC57yj9LkDtGuDZlokszojkPPnmtgXlD8RzfwVT4+fjlZk1Z+X4HB33FNfaWHOB60arKPa7ickoBjG8p1Z1Gevtz4LDNHSYHBPllmZ4EXMF+8Rqh57XY42q0UQSa3G0TqTlP/QNx+WqJAz+dJifhI4CVw30FgePxJA9hWbp3dgTUqZRl1o3QJzkRFvqDyZ+38NJsWhJ+T9OzxrAg/6RkA6K4wDd6TBm50zEUvui4dGhg+4dIXE7n5D+8UumHS0Rxqq0taVoHd2YSKW4nhkK3X3esIyeYfVJp6wMYnRnCnyCXBaCVgNI3fe52ZWXuO1c08q9LUvxM06EIDYbygcCHSzTOviALzIKZdZmxSzFW0Gk+9wOe4aEVHSD/CViThZC6PDSYXCrXq51yP5/TbQoucWvV+6qR8ybHml9Ff0biVCLUhwvSJgfT9JwZeHXPBs+gLZbtO/W1C2EQFzBb1Z8qXZbM7h206erUmBlYqydEBwMlqzy4sFPSuybmKI+AfVcxKQoSuGnL00LdVoJVQfH5JM4532xltmeOwWQfG+1hbL6g7Ead8TsJbmIBNixVtHxwvn8MyI7GtJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FDb4FpOtHoag3pLSemiQ1H6hfIbYgVXi3Sag2SIQYvTpw1ah+w7wb2lhhKZz?=
 =?us-ascii?Q?okoLLNKGdHvr4B+xcAEE2aiYJuvYalprP2U4zTOVk04akdWq08+OW0VNRj6H?=
 =?us-ascii?Q?WVaZ1/EEpsTE0XBNIDSvGNJ0tcyPZd8MVLHBTCsK3U5RhA24D8ITS+Z0TNEM?=
 =?us-ascii?Q?hQFPM0R+aCiSCVYnLILr+IiFrATASScjPy+GhkaWSw4nkICtT7PzCaO8muwN?=
 =?us-ascii?Q?xF7yJX9ll60QYHCPObNblijrvm0rO2WUZ2YtsW1Bi7qh/EhwovrFgB8CvK9j?=
 =?us-ascii?Q?2amwbIlctG0w4i8MCAoHpjJSKcgYQ29COnGSq84Gbq9zFK1ljliRKi8NuRJZ?=
 =?us-ascii?Q?PuDmuzvJrty6rKoKz2Dhff/qDgDjEIC9DcW5TNtb4p2Nv8tNmHaGBRc+CIaT?=
 =?us-ascii?Q?SlGO0HecS613EyghfSvcy2NRkO1rPGPXg7qhOj8EudVyP9DvtiHaRpEH2mZ9?=
 =?us-ascii?Q?t3UsNq28LUTLL2PiBsSZPxQmb3e8JwNP6NAdhxs9wl+/cety1vDPiAQDS3gl?=
 =?us-ascii?Q?ZXMTgku5M38ZR0iHVRkDQ+sq0EQOhQueVq6hHySDpaDHJRonKA1kjs3LU8V6?=
 =?us-ascii?Q?zQ+zOjZvvY+3s6gyvrL1t4WXqLFLtyVS9+Pfv3UXRi1ZRig+j2zBAck+ziop?=
 =?us-ascii?Q?C+y/UsezCgVIaobLqfRpnVevyaxe4o7EdQXH6lq81z47s86jXC7DnUBYk+Sh?=
 =?us-ascii?Q?6SGHH1DiU9B1tau02TA1qPn+0BoORWIdCaf5RR4+U46mteO4szPx36ygq0FT?=
 =?us-ascii?Q?wVSsWbNxiuay6FfiS12L0rkJsazt+k+mh0BbHbXy+DpFrPJ8DPYs2AT0Dd5t?=
 =?us-ascii?Q?b2QPJnu+1i/Sequy8lbPCItVw5c+mcuWRb41GYMrM2dICC96GUPVPNBP5KvD?=
 =?us-ascii?Q?4PvJWnK9Pkck2y0QcyqsYf2vY6pSVjtHgOhi1p6SexNAr6dopmt73vm5kAru?=
 =?us-ascii?Q?N8WtbUYfdS3VCIurwjs553zGjcetKziV6xRWb/VxLrOujnpYHyFFniNbIDdq?=
 =?us-ascii?Q?P9NRMSJWryNJcPN34SWOJUwIUfJ06E861Qcz/H0gwDx0Ap89ZG8JuMihFiei?=
 =?us-ascii?Q?tldYazIho8ypGaXYHcgZWeGuiygiXDX27cQRWnctfypysDB05LlQoC1Xy9v6?=
 =?us-ascii?Q?xU2YelhMTd97scXHYX8y/WHKrfm5YslCrzJuzzwMoOZlgHGX3VSK3jo9cjWA?=
 =?us-ascii?Q?ddKW47pyGZrCd7pNzlnxq7InZp5GDufAmFXF9mU1HNhk7iu2eOOup9YQzd0J?=
 =?us-ascii?Q?k1Cv9i1RMooE50oOIIvdBuiZWdAj6/obCOZBzv0EPgZF9bwGMDKw+N4M1cJx?=
 =?us-ascii?Q?wl1i4XbkJvRQfnrVJV2Otfpou0/sB9damuP/c93rFD/6OH2Vt6s/nv9rNhcb?=
 =?us-ascii?Q?1aOXgBneXh+54/Bwln6zg/HhBxoI7lYuC5/WaGFdg9aB7ubLYedj1zjLyj1u?=
 =?us-ascii?Q?M+IyheLBrkczHo+y+epj8ZdOmKLsKzCoDLvMffoJG2FCk+a0BDFvGX0684Kc?=
 =?us-ascii?Q?1xxRbme2VPmmWruWjsi1ndSI/lJ/BZweIS8bkjLQVXsbjVG3h6sPeY9FSzcS?=
 =?us-ascii?Q?u8wPDiW73/viHIFdvuotmAyFR9iYwnIjbYQ6W6/h+E3QVxCF8o3OjLMoovzG?=
 =?us-ascii?Q?gAY3gObpWx9REQy6luTKWeIHW2qNSuYd9VvHXc7Wh5vKXM1G0Wy+2YvnHnM1?=
 =?us-ascii?Q?k5pC1gKGw57uPKmUybUiMyRGvQ/K5Csy5mhFwMK3qu+0PIo83eKi+U2tJM1Z?=
 =?us-ascii?Q?3QPEfp5RpJPSTmRAwjnMivtwUMHt85E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac95ce2-0af5-4146-4d62-08def23b8fe5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:56.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5TvwdhThjQCP+CtrdYDCh51d5PVVnje8hfe7UAILlsOcnCnNFfFT/ZsGpiSXXza6Ggk4JDEZURmy0oJlq3o3XV9lIroI5Jkk5T906qdNKQ=
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

Both commands claim the coredump is copied before its registers get
patched, but patch_regs() writes to the coredump itself.  Describe what
actually happens, so that nobody expects their coredump to be left alone.
Fix a typo in "runing" while at it.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 4803914dde0..9148264de3c 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -306,7 +306,7 @@ def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
         # but only works with live sessions.
         dump_backtrace_live(regs)
     elif detailed:
-        # Obtain detailed trace by patching regs in copied coredump
+        # Obtain detailed trace by patching regs in the coredump in place
         dump_backtrace_patched(regs)
     else:
         # Obtain a non-detailed trace by poor man's unwind
@@ -342,9 +342,9 @@ class CoroutineCommand(gdb.Command):
         Usage: qemu coroutine COROPTR [--detailed]
         Show backtrace for a coroutine specified by COROPTR
 
-          --detailed       obtain detailed trace by copying coredump, patching
-                           regs in it, and runing gdb subprocess to get
-                           backtrace from the patched coredump
+          --detailed       obtain detailed trace by patching regs in the
+                           coredump in place, and running gdb subprocess to
+                           get backtrace from the patched coredump
         """)
 
     def __init__(self):
@@ -380,9 +380,9 @@ class CoroutineBt(gdb.Command):
 
         Usage: qemu bt [--detailed]
 
-          --detailed       obtain detailed trace by copying coredump, patching
-                           regs in it, and runing gdb subprocess to get
-                           backtrace from the patched coredump
+          --detailed       obtain detailed trace by patching regs in the
+                           coredump in place, and running gdb subprocess to
+                           get backtrace from the patched coredump
         """)
 
     def __init__(self):
-- 
2.47.1


