Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1413E75459
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP6v-0002ZN-Pj; Wed, 24 Dec 2025 08:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6V-0002VG-Ag
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6R-0002aj-U3
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so3064335e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583634; x=1767188434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6zHLozB015qWCpKDt4iTQiK5JyCqCHtIyYzoHPJGD0=;
 b=LYbrWbJcwt3hkU1T6WN2U80p3CzQGGL+8cMLcPTL5G+TM2axW/a7m/6gLnc4LJHiFW
 u21QYZhOAf8+aKMWEa1SgMAS7GmO8l1yTnqPitiRQ+ePxAZDNQKkgehmc43fiqnNm7MO
 b0kYByekjFvClX53TFaglYEhb7KasKKPMULCANBNpO0jstAPBbgKPRwFCswUJIwS105f
 jr9cvWQexKedS39gL7oZMLLXv5/qLIHGU9MH/IpmRa/bvabfhzh507Pe4NJqCZbeB+GW
 P/9qnNzxv/qjxfctysTAviHO+epbEhSUYber6xbO1mk2TotJMAk+Y9N7owswjCrhsyfx
 2ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583634; x=1767188434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M6zHLozB015qWCpKDt4iTQiK5JyCqCHtIyYzoHPJGD0=;
 b=ghZ6KgZpeR0bna/D7gA6efWpKHRDNizpu22tHCHf5H9BaqPuKVVNYYfMMAvZdfJuHP
 +lS3PE2EWsxJzxPzG4qw+7/KSxK1del32fjqLjZ+D2X7FgcGtkw8BxW0LJhcYoxwBJcg
 TC21yRrvaZw2DffC71Qia3qUC6yYCE4NPyH/rxSXvjFkPHPtITuPFl1+9RrqxaxCBzop
 EoaQ/x7tB+z3JfVQgULxA6euhKlNDX13hAfkx1Y6jiXBmBj2qWYgPn5znX0pZ4AAagc1
 UaeEH4uLTGNCLa55xwnDh6DxoES7J1kDw9GtDhehfLPh3PFbId2MaNGfah9E+qc+tHis
 EQgQ==
X-Gm-Message-State: AOJu0Yzp5fH/zuBy3k0q01ihQyU3uD/9a/gracrWlji5Eyb9Z5INQ4Ng
 Y3mm5J1pakGMBQcWY33diYHuxdh5Xyt625I66PJUvmN71bQwO6kjPHif7bwXn5ckEbXY3UDlFw9
 Yl97jgm8=
X-Gm-Gg: AY/fxX77nHhV3cU64gekSFERwSuCpwZxwgPMlylhk89HDORarpX2gw21TYDufXxdy/2
 RijBrnMJcaLs55Oe6NiUdtp9+TuWppRdlW6+NHgjaZF8saXz7gYFLYzKlU01QvuclU5SEvUdzwx
 W1L+TJE72RQDafQEoJClHuUhH4WUrQCwC4ESu0M6rrF+9m4qs27a2W3OT05aBkRPpmNNXYcqzc4
 reHLQ5tvcIhXhArlOMs1t39rbs1KT17E1pMy0QQQnUsaaHWXm0Mc/pewPDxaOfrCZM+Mf3cqbAH
 IXWpDJw0rKMWNFk1MPOgTpwv7MuQX7aCcR0DhxoQ9J4qe5qXFA4IsdL0uXDAZcVltsbKqCS72oO
 F1i7DGwyuHlpmr7+615mNMi1KfuQSxwaptXUk9kem0/SQNBNzYtM8zXhwjRqVnYKKEIUKl2k7rI
 Us2rDjsb9shnXlpVLFbbW1fisSb10FMU1HyKXJ3m400dVxr/zIaqPzuQGkw8wL
X-Google-Smtp-Source: AGHT+IEm0qP8Fu+eaQwb3AQconnfsRzmoVoftrEIA8AU7B24/fMHfFXTG/DevCACOavSi91FPVqCDg==
X-Received: by 2002:a05:600c:1d1d:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47d19577fb8mr176782435e9.9.1766583633617; 
 Wed, 24 Dec 2025 05:40:33 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm35065914f8f.30.2025.12.24.05.40.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:40:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] monitor/hmp: Fix coding style in hmp-cmds-target.c
Date: Wed, 24 Dec 2025 14:39:48 +0100
Message-ID: <20251224133949.85136-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224133949.85136-1-philmd@linaro.org>
References: <20251224133949.85136-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Previous to moving code contained in hmp-cmds-target.c,
fix the coding style. Otherwise the checkpatch.pl script
would report:

  ERROR: space required before the open parenthesis '('
  #134: FILE: monitor/hmp-cmds-target.c:152:
  +    switch(format) {

  ERROR: braces {} are necessary for all arms of this statement
  #154: FILE: monitor/hmp-cmds-target.c:172:
  +        if (l > line_size)
  [...]

  ERROR: space required before the open parenthesis '('
  #172: FILE: monitor/hmp-cmds-target.c:190:
  +            switch(wsize) {

  ERROR: space required before the open parenthesis '('
  #188: FILE: monitor/hmp-cmds-target.c:206:
  +            switch(format) {

  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #190: FILE: monitor/hmp-cmds-target.c:208:
  +                monitor_printf(mon, "%#*" PRIo64, max_digits, v);

  WARNING: line over 80 characters
  #240: FILE: monitor/hmp-cmds-target.c:258:
  +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);

  WARNING: line over 80 characters
  #245: FILE: monitor/hmp-cmds-target.c:263:
  +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);

  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #297: FILE: monitor/hmp-cmds-target.c:315:
  +        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",

  WARNING: line over 80 characters
  #329: FILE: monitor/hmp-cmds-target.c:347:
  +    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index efab133cf2f..48c21559156 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -149,7 +149,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
     max_digits = 0;
 
-    switch(format) {
+    switch (format) {
     case 'o':
         max_digits = DIV_ROUND_UP(wsize * 8, 3);
         break;
@@ -169,8 +169,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     while (len > 0) {
         monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
         l = len;
-        if (l > line_size)
+        if (l > line_size) {
             l = line_size;
+        }
         if (is_physical) {
             AddressSpace *as = cs ? cs->as : &address_space_memory;
             MemTxResult r = address_space_read(as, addr,
@@ -187,7 +188,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         }
         i = 0;
         while (i < l) {
-            switch(wsize) {
+            switch (wsize) {
             default:
             case 1:
                 v = ldub_p(buf + i);
@@ -203,9 +204,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
                 break;
             }
             monitor_printf(mon, " ");
-            switch(format) {
+            switch (format) {
             case 'o':
-                monitor_printf(mon, "%#*" PRIo64, max_digits, v);
+                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
                 break;
             case 'x':
                 monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
@@ -255,12 +256,14 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
                                                  addr, size);
 
     if (!mrs.mr) {
-        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
+        error_setg(errp,
+                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
         return NULL;
     }
 
     if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
+        error_setg(errp,
+                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
         memory_region_unref(mrs.mr);
         return NULL;
     }
@@ -312,7 +315,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
                        gpa + (addr & ~TARGET_PAGE_MASK));
     }
 }
@@ -344,7 +347,8 @@ static uint64_t vtop(void *ptr, Error **errp)
         error_setg(errp, "Page not present");
         goto out;
     }
-    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));
+    ret = (pinfo & 0x007fffffffffffffull) * pagesize;
+    ret |= addr & (pagesize - 1);
 
 out:
     close(fd);
-- 
2.52.0


