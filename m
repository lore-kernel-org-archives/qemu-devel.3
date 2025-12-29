Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA3E92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMTc-0007AX-17; Mon, 29 Dec 2025 18:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTa-0007A8-6y
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTY-0004Uz-8i
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso90455445e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050190; x=1767654990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++uoMdw5tHPHy/4X3ZDqK/V4wErwg5CIxJRV4pUz1eg=;
 b=OkUN+6mq+7xm+2Vs6zxRV3AehoB/o7zGvA9vQMoCO/9yFQMLMo8sCpbE/KYL644qcU
 qkppcKn4UVTQlau5mWBAkovJxYr5YH6ZnAQVINJqYZGyfh0WO9A0ZzJMYTWJbRNKwCqP
 Epxysil9zdjdeOQxWZ5JMT0PLZ2xUlZlYvHcr/tVnAu6k48Vqqhqrx5sOAnzNaBAxV39
 FaLrcvlXqVizSQlKf7CS3SWj29yyKAoV7549a7R1t+M3v8iLqQNtlN7Rn4qjbANFZmdd
 Tiit8ku8J3N/uOz+BbxscZNUOi1E9jf90cru1J1XmBlvJLFAnwsiFY9CztsjV/EebXnH
 6JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050190; x=1767654990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++uoMdw5tHPHy/4X3ZDqK/V4wErwg5CIxJRV4pUz1eg=;
 b=nErhvK3VCoDzszg18Pl6jSE16k/Wkrf68Xi/rLSdtgqzTUW9hXeU7IgA1PbwWG6SWh
 kmNZks81TLrC8JYbNK+fi8Vl/flvkOsrzCcNOFUZLbxgYHCOWIAgL7KKqMn1GCAu62ZR
 XGOneK/xkHyCQ+hmL0VVQkhVi1zmI88jK3siGWY3OpW8TJWWYv5YUSfaeYz5CnwxQ0Mw
 UbiJaYKjuYTMTEDOFVA53fuf0Iy4veDJfPcoLgbpVL+xH4PPJ0bHihn9O+R+QppTCc5O
 Ldf/LlH/uMT0j8BP4ddpSw5CpeE+EnlyiujYUNkitn/bLMCMuarRX2LyzbWZi/5MTWwp
 4c0g==
X-Gm-Message-State: AOJu0Yz6B0HR5TFFWW9nc1u1BMC/li9/5b42lVvseQFERO0KywnT/6Cr
 CCCGPTKqr1qKteHEbFNSLdzxv/DOOrI+i6duLUon/PdprvsAmDFpnE+ERjlU3dpL5yzci6keHKU
 lp37DcPg=
X-Gm-Gg: AY/fxX6Oqz6mXBZVlNlbrBgbWJ1OdaUjTNPHA23CtJrxruns2DknrsfvpFhaKcNXQIm
 X2S1chl7ozj66yBv/wuMUofa7ddEDstCJvn6ilPPxjSK679Yo73bjw3E/40IvJX+xPUpp1sgQ2f
 HZtIdfet1nCmOx9F822ZZlEvdJ0yQU6lYtdjlUOLDzPStRCMKxI3MsTgfp21YfSeelmHjO30joy
 +jJjKx2jxF7WlJEcXYiERSUraFYkLuaW+H33Tv6tA8FeOGG97jgdJ9seW7ph5vfdP3g7KkVgq+5
 V1wFp1iePRh3nDW1q9oDU+APJBdr/A8+FpQGaRbtv8W6Sw1DxC4E8SBdp/zdUygHG11/6dou0j/
 47Ez1c5VHErp94lN5QuyykGSMJPiqwTjeMtK/74LLWguEK/igPYYkQPLfLuiZEJMowyAqpdgIFK
 If2UxouqOMzUFrEoFFbaO/wq7yZ4gnCKGKuAKjYEbAZxBUeyb7SZaOEJ7RkgygIe8CpX4fmX4=
X-Google-Smtp-Source: AGHT+IHybWv7omPALcBbooy4ivZnJt2kREcR3f2Z7ommtTqLeQ2uYJJ4oJWZsL6uELpLoXj5jXTQ4w==
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr291724075e9.2.1767050190198; 
 Mon, 29 Dec 2025 15:16:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b749esm616998525e9.14.2025.12.29.15.16.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:16:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] monitor/hmp: Fix coding style in hmp-cmds-target.c
Date: Tue, 30 Dec 2025 00:15:44 +0100
Message-ID: <20251229231546.50604-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/hmp-cmds-target.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e782259c3e6..b4360f1f807 100644
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


