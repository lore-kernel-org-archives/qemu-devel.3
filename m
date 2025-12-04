Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2275AD1F9B5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6vo-0002ei-4x; Thu, 04 Dec 2025 05:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vd-0002W9-K7
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:17 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6va-0002Jp-R0
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1uSsgdlsQjXE9EvdgZ88fds7Ru5o42sZrmufyw5b+ziyK4AWqBSs/s2MPCOa0MehoQREB0VfzyBW6xBjEqiv060HTkSj4CA8/5s/6X/C4JpkNjbdWPuoXcEqehOwPRrxrz8O64ogRKRp0BUHLtUAl/BjpHwJ3VBxvm7B6UH2+RKWWsIOV1VvGO3DvzQnyW9nBsJpnVrvspfE/ti1bkR1P3ECPE4XpsisddEc7BdwSfPUOdOxQrI6jwsoOBS2Vegrnf9DXyf0BXIa2Y/pEAIblUFiUA/lui8ObhIhITmYnUoqPEPrWAdgXVT8UzV4S+3Xotc4KpHwgQidi2z0KD9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXbwsgq2K6eVm4heJD3wssEIynts8bL76glfWpTGwrs=;
 b=uaCW1iaMENoan+O5DgZNTsp10YaLDu4aPDdWM4pYqibNN3zUKYUcNh9qVGOncRdVxffi2zFsn/UWSIbx11qVDmx6Rxa4Vp3N5MB3Q2g1DuT9kLx+UMCJehzWlxFD2UKC3GYF8DN7kWLC+x9byRx5OFeH5qjBrJX6m1Ut6iZik1trfn7UB7Z8CnvZURxTBDT0cNlY0WMec/xQlUbz1uQd+LL8TCQnoh7vkkf9jU2HUUky0Rv0r81dJu2ebaeC1ahT7INJVox08v6ZiNo2e38RTVJem4gyPMMoVY+YZGP4n5jsd9uEeF9IHUCM1GZiVkMyDoBNcnU+GNKmVbyIDhDXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXbwsgq2K6eVm4heJD3wssEIynts8bL76glfWpTGwrs=;
 b=N0Bio6E8PXQLWmeBqzyYdHp4bG6dAHzfLToOah4V0uIVeFiU0h/BmoHVtsIDcGRzUyzsG7ZFtn4aZHk+ZyLtOXfAzBW0tpHqJpYy8YRRO3n/0OacEf5dmkOLh2XKQSZbDeD6EuQu++S3jBLuWVeC6LY5koAfWApF0ZYePoM3HdnUSs7ERb7fmowVWVPtWM7/Hh7fHw2sDz6sCjBqrgbhcYCDrP8qIPTqNZWjibt5aKi4kdVXF8rONFEfVdaIQbKahcPqkCFuvsNvEepatYM1hcACJ4V5thX5PMaVY/M+mE3EixHTsLve0fP4PnS8c6gvbkEK6o4nuf0PwVThovF5ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7718.eurprd08.prod.outlook.com
 (2603:10a6:20b:50a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:50:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:50:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 3/4] scripts/qemugdb: timers: Improve 'qemu timers' command
 readability
Date: Thu,  4 Dec 2025 12:50:18 +0200
Message-ID: <20251204105019.455060-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc3c5dc-27de-4e8b-28f5-08de3322f32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bEjMp0sJ+LvZ3vashcOcFdU7+Gyvz6LPfkH8A9puJ3D628Rfno/2PmzRFEvX?=
 =?us-ascii?Q?PYfsMSw8Fof3fuBSj1dQIf6gw6fK8Fh1+GytR3tnXKlKIDeH+8qZUd2JqRzO?=
 =?us-ascii?Q?7Lxtozv4vIxjmGssbfioR9X4MwWbcF7wPpzi+mgsR52Kn8N0BcwhDp8D9oPg?=
 =?us-ascii?Q?xMluSKky+CiCop+lLEqIQglzxlnQxsJEl5nP/ngEaRYuq5RAw5ti/IYzOp7k?=
 =?us-ascii?Q?hg/klwkJ2k9tXxpCnKQRuyXCZ3ad6BDVuknMdqE7v8s7onXDPv9StbRCKXxe?=
 =?us-ascii?Q?dITdsm7vqUmkilA6e8/rj0+t6QtYbDI7LiZTB7jKkscBXI2tfr9uTgIj7yvd?=
 =?us-ascii?Q?9raj/PbAceC6p1Hm3qShkDMW4eDTjnFHXe9+VJYpzkHnkHNMwk/GrOxJ+90B?=
 =?us-ascii?Q?p5mruGlN/vId69o1BJxbjpt6wnkFsR7FDaqn5PwCY1UbjD6AvU4bhZzWP6+4?=
 =?us-ascii?Q?CqYED2nXH8G4PaHHaExELQqbK6DXTfB0bx4G8RAZdbTKol7/C++apE1WKjG1?=
 =?us-ascii?Q?lHilvVDDfXozwlCIUy3U7ELPS4xaARBrckBDGuocG+iT/SWpOEwmAO6BrlFO?=
 =?us-ascii?Q?6fTu5tD46o8S+EjaNIjMvxaWskYy0upcNAsAyK+ZXk/AcJFqObgJGUcGtyLX?=
 =?us-ascii?Q?yZHz8YtmEtt3wLv6B9VgQdi/4JFzfntE4iS0oEtnYux1AU4s6Qkx9dIuyO4D?=
 =?us-ascii?Q?21e19kp4Db5qqUAS9BCsn9p0JSIKo1FH4wKrPlFk11Bzomc4OInu7CuVPm7i?=
 =?us-ascii?Q?BgOQUtRFSpXvVMCmhFCs7Myr6iBpFM9p1vvP79FknNgcbKMmazyLvPr/dbbz?=
 =?us-ascii?Q?0DTrpDZY/AMYnjy3Y4ZXIadUGwXybFrA1MjxrcyuTqrObx6Mrn+ARLHZIDpR?=
 =?us-ascii?Q?EK/5N014JK8NjVQq7PIIv+3GwZ9aKSryxYrFJYx1bUasQFbPO0vwGkFu5RIt?=
 =?us-ascii?Q?groFrAxIdAFWjuTOiNaLMExUn+DwvVTNTrqtRbimSkHqaoOBI2GilWNmW6q1?=
 =?us-ascii?Q?tCy3nu7VJ5H9O1TpAKNYVFCPefgY1I3DFSelScaihZkSHXnXqmDvBI35PhN1?=
 =?us-ascii?Q?Z0FZeupHi0rtbEJ7sxxajLBfZk69TqVX8ujrx3AUPW3CUNOU7bfugX3Hnj+Q?=
 =?us-ascii?Q?6NJtiu+iDR8nQDpf+SflycM1+MI5k4RbIvAzQuyW2S3kV5DWc3skcpeV0exi?=
 =?us-ascii?Q?94Dqa3akANS8Byg67fi/sQK1+Clsq8+u2qqZ3WIVCcQubnaH9GLufjbVxzQy?=
 =?us-ascii?Q?6RwRgX39PDyEs8tHIzF6EK/1X+XBKzwDaMuuVsoqoBo1gv7P+7QRVR0bFrqO?=
 =?us-ascii?Q?jUsPcokuA0s/Gaxlyqawi5FzJI3zThQkGw1vEnQFeH1d1D1mimGtvOIQGLLn?=
 =?us-ascii?Q?BGJ0nTkxrU0OZADs0yq9olUG7Romyu/4im8gAg6FKjQ65vMrHBt4XjrI71qn?=
 =?us-ascii?Q?sgramHnfPFQza116YlHp71Y057x8klbv8pp2AfqvFVG7NcKEGS7hmPnLGbLf?=
 =?us-ascii?Q?ANsK8emQaCzfFc3ZX97IkLyuXcT/cwEByiPK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anq/l+vS0vfDFTu9D1LtgHEUU7UrzIrGRwYMftDUsYyGpVzc1meJrJMqi1sd?=
 =?us-ascii?Q?y5gcNtRFpHaiFx9hzW87A+8sqlHM/6EkuN99kn5NLgRaUtH/T+2v4o7+K8qb?=
 =?us-ascii?Q?Sa1e9Y5FyhLCx+b0x3755ehMvTK6F2WS0QkuTJVGt+nXSrCAF5+hl/pK/B61?=
 =?us-ascii?Q?ArHf+QvZdMjs73Goxl1eUWMrmDK3JXQ3b9qWVuYv36EunNT9bPNy1cmf0YLz?=
 =?us-ascii?Q?cHmDHRwWF8PvnznWq6zOdZBM99vqCYSUepMaWdgqd3tMjel58rPW4R3WdGgh?=
 =?us-ascii?Q?IpH6wxx9QrTpH6YoRAsc2b3nr6Pbd1YtD5hwuXzcpzvIRBry0mkD8idoVNXr?=
 =?us-ascii?Q?fbuQfZwImInLYwC9ADU45C8F6sQq6yK3veZvPn/Y5q/N8A9j1k/a9wq/Ycqy?=
 =?us-ascii?Q?SEZnRqBQKFpKPMlyd61BTtXUCSBGMS3YURf4SK184cutlvHUXqrz1BQO3mFG?=
 =?us-ascii?Q?51J0ekBkdW8TzHQn3+hWj7AJDjsPPfm0ZFxjUj+AETMnzAIPhy0G+VoCbA8V?=
 =?us-ascii?Q?GXj3iuGe5yYBzpdZz8ru7jqOU2Y2oEeMbwtpFMVf14qgR1PuDmr4q6Q3SnwI?=
 =?us-ascii?Q?GTNCdMjbQtjKTtBzyahgvHXp/ZzZqLOWmeNZCdYqjj3uFd1x/aw3AbqNijND?=
 =?us-ascii?Q?VIkctwApsoVxRuQR0eA+CQ9WojElP8IUYqPj0SsQfg94pvnNWT3Cvt5cb3Ey?=
 =?us-ascii?Q?0UV48KwcE9LVaWEKG1TS9gx36v0OqT/D/zHYiP/CoSPJlO5kqtELoiq6qSxt?=
 =?us-ascii?Q?Gc1WFRNCK/AynbiWYdruDSICgAci5lFK8ONw/2whySfh8l4dZXcdLMCrLcsb?=
 =?us-ascii?Q?SA3Dh0XiDc8fJmEMktHLcqWwIijNdjUdlhNtyco0ALS2auAxQXHQE7G8rJ9/?=
 =?us-ascii?Q?5lMg1EPRTsRev1h6wMuT0vQe+tEC6JL/32nTbB634dRHpI6yqtWcJDZbmj9v?=
 =?us-ascii?Q?uyZ7c+WDVefNtY8Y0JZUFA4AJRHCwGJd51siWWrzVQix0JJw3zKTlaTKaGEt?=
 =?us-ascii?Q?GPE7V8VHl+d2seO9ueCRGdM0h0XqdFmA+gzH1jj1dMGb6C+RJkqUzwITB6ep?=
 =?us-ascii?Q?+YgbXjzIId+FIzNAhX62Iw5+CQjZcjju1o3G4CAVGwwtYLtgWB/791LF5d3h?=
 =?us-ascii?Q?J9p2EyRBaiV0FOjHZm99lUpkfLdqYiXlkLS/6V2Q+nlFjVMgG5gZUjWpI3Ji?=
 =?us-ascii?Q?m8zmbeySvgvzQTBU7pAdCXO8ErzFuKPC5vLctgrkYoQkaNtYsmUvPNSHTuDr?=
 =?us-ascii?Q?y9v3/jwaYOUIdE2NmTQUC2glYPmHQe3dIRBRXEOHDgoV+QlhnYaYS+ZvMcyT?=
 =?us-ascii?Q?3XZCGJMCJAfovLdmFLDiMRnVC1Sl4v/HYOr39yUSBfWMGNRJQRmXfKv2mRmp?=
 =?us-ascii?Q?Pmqh48tWnG+O5e7rmmIEKLnpvQ9zD2YvUqHTExXesD9hzOHSNQjvfmm/nEy9?=
 =?us-ascii?Q?GjgLuwkVt9SidJSUZLfF/T8PIbR7NcSH+fSc0aLAw8rKrp0/5QmMEwsx83Us?=
 =?us-ascii?Q?TBZLB2h5lLFKFwOKg6tmVg5yU2yfe1ycaZoU1SLBRbnCKliHfP8eTqunrOTs?=
 =?us-ascii?Q?XxiNLFusvPok5FW5ia+/EC5fh2e6IUrVw4cxkIuiDvnbEDLlIskIc4jmiymJ?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc3c5dc-27de-4e8b-28f5-08de3322f32c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:50:33.6833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDyn9VfVogqtRyFfaxQG8nbRj1/rlizE986lacvOELt5TqG/6zRuR1kBXA9AbNbwuRX8+g3gs6dIAXdLbZi9c1z2aLQ86YebAWUD2CTDXDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Add the 'attributes' field from QEMUTimer;
* Stringify the field's value in accordance with macros from
  include/qemu/timer.h;
* Make timer expiration times human-readable by converting from nanoseconds
  to appropriate units (ms/s/min/hrs/days) and showing the scale factor
  (ns/us/ms/s).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 1219a96b32..916c71b74a 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -21,14 +21,53 @@ def __init__(self):
         gdb.Command.__init__(self, 'qemu timers', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _format_expire_time(self, expire_time, scale):
+        "Return human-readable expiry time (ns) with scale info."
+        secs = expire_time / 1e9
+
+        # Select unit and compute value
+        if secs < 1:
+            val, unit = secs * 1000, "ms"
+        elif secs < 60:
+            val, unit = secs, "s"
+        elif secs < 3600:
+            val, unit = secs / 60, "min"
+        elif secs < 86400:
+            val, unit = secs / 3600, "hrs"
+        else:
+            val, unit = secs / 86400, "days"
+
+        scale_map = {1: "ns", 1000: "us", 1000000: "ms",
+                     1000000000: "s"}
+        scale_str = scale_map.get(scale, f"scale={scale}")
+        return f"{val:.2f} {unit} [{scale_str}]"
+
+    def _format_attribute(self, attr):
+        "Given QEMUTimer attributes value, return a human-readable string"
+
+        # From include/qemu/timer.h
+        if attr == 0:
+            value = 'NONE'
+        elif attr == 1 << 0:
+            value = 'ATTR_EXTERNAL'
+        elif attr == int(0xffffffff):
+            value = 'ATTR_ALL'
+        else:
+            value = 'UNKNOWN'
+        return f'{attr} <{value}>'
+
     def dump_timers(self, timer):
         "Follow a timer and recursively dump each one in the list."
         # timer should be of type QemuTimer
-        gdb.write("    timer %s/%s (cb:%s,opq:%s)\n" % (
-            timer['expire_time'],
-            timer['scale'],
-            timer['cb'],
-            timer['opaque']))
+        scale = int(timer['scale'])
+        expire_time = int(timer['expire_time'])
+        attributes = int(timer['attributes'])
+
+        time_str = self._format_expire_time(expire_time, scale)
+        attr_str = self._format_attribute(attributes)
+
+        gdb.write(f"    timer at {time_str} (attr:{attr_str}, "
+                  f"cb:{timer['cb']}, opq:{timer['opaque']})\n")
 
         if int(timer['next']) > 0:
             self.dump_timers(timer['next'])
-- 
2.43.5


