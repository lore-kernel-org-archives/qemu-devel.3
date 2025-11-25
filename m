Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811C7D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtw2-0007cu-K0; Tue, 25 Nov 2025 09:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtuu-0007FG-AN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:29 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtun-0002Gs-IN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=a+tUUiQC5dHHaCTNVUg/RgFFKDMzkIDuPzrqjC0AfeE=; b=kng0Pw/3P2sF
 ceqrOthptDw7qn1y5fcgEUYZ151k7miN4llKRlh/yxTx3NjuWXk49XstTYtxtFmrW2ahmhOly6IKA
 Z8r5DU1kj2zbD9Oi9fOPQ4ir1gj5FA+BHZLX+WR3oYvzUoJNAZPx7fCiQRI0WNLNyJhSvgKI5XTs4
 O+TUkILcyzgq7GJ9uo2lrhUvvFFjDg8H5Rb1+H4cpN+4+Vljvp7ADCT9zlHNQtrqJI96bawfALuzH
 5BfjWQTR4HD4o/xQ88q6cdmQFMdeNC2wCD20wNwpkN257F+TPDrIYowZmEFPm3QNPpojbnoJv56KB
 HGD/X0kGiEsOLpuPv1+Plw==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vNtsz-003IJo-0V;
 Tue, 25 Nov 2025 15:20:56 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 3/4] scripts/qemugdb: timers: Improve 'qemu timers' command
 readability
Date: Tue, 25 Nov 2025 16:21:04 +0200
Message-ID: <20251125142105.448289-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

* Add the 'attributes' field from QEMUTimer;
* Stringify the field's value in accordance with macros from
  include/qemu/timer.h;
* Make timer expiration times human-readable by converting from nanoseconds
  to appropriate units (ms/s/min/hrs/days) and showing the scale factor
  (ns/us/ms/s).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
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


