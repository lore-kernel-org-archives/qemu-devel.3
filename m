Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF4CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIy-000370-6Q; Tue, 21 Oct 2025 16:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIW-0002Jx-AA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIT-0001GD-Oj
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3876709f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079771; x=1761684571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUpymYOZ5hPQQiiaaJAZks9B5yLzhhqZL128dnY2H3Q=;
 b=vcAKsn11ETaO+k4mee3Jrsn/VKy1BKz48nPlh5efQDo7KXOMJ4HgXeK4gSnDWIxEyl
 IStcaGrsCHZQTPTM0K1KNpB5bRSKIEjzXWgwO991oKvPNDoNrxc7ET89PVaECfrhAngJ
 nfSBjkYKqA7+uE5cSP2QkPFjQO17IjkkQGD9dADVdFEZXsSMBxW2Rv7j4zvspqQswBYr
 NMZcWvcq7wptDz8PIgXQaSEIo33cgYqY7Eh403lVd2X5dcOs8hwS9KpnaAXNJv/jJplT
 phA+46be9h6BQOaiD9TCY3QEGdwtZPDNnrND9zHHHg02xvcjblxcgAo+qYtSy9Fmy896
 Ar2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079771; x=1761684571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUpymYOZ5hPQQiiaaJAZks9B5yLzhhqZL128dnY2H3Q=;
 b=Xn+yerXVwEqeIqo4yKYreagh+WT6rfRKhsXXnyP2FIuQb9W3xiRpIspiAKwpCdNz8k
 cw28+WuDqHa/Js0TNwI5xDzh4Z9M1YBBl4igVJxKL8wnB24vLHoExa50+cRzlmhvz3iR
 BTT0qOv/lb3OGVm5zmJvEuOaJgI4YDT/tO0S2NWAGDE0zWFOsNk5meHEVhcIU4RHVFDB
 JbuJdmywVlVgPJbekYDvkCqaUnxEfe3RRS4TJuNRNyBPgAg16EG80FD0ECLmCIJzdcYW
 FhCb7IIz222P5UjWIym4xNhKLeAcHa2iv8SDltXZjW3VYYfEh+FfB0X84qP2cuWcW+04
 nj9g==
X-Gm-Message-State: AOJu0Ywxrli2LNScE4EIcIil56RcV5aT7/5CaaPC5qv7AxCjBW7jmAn2
 nHsAnBklHVuTzsb4RDgVhYkKY+n7bgHu5SQFzawvI3DiuVZuASnNG4ODEP7qII7M2VF9n19DqHZ
 nb+n1Fcw=
X-Gm-Gg: ASbGncv0yhM92vxc/eM6/7yTxotzU71skyWwa/GD/eX712STurmCf6HTLfzhwsOroLV
 I7XU7ad1aroU7KdkqyyqwytdHutvNpgrfNIZfQ/8pL63+3B9GdXTStiW0xs8lQcce/vd4g8zqkl
 B2AeqZGvOlDqghjnaJfVjhpbLsU1avtDraGn5ToqLUyHHEupSlbQ3PJlTuM1bw3CEITjfGZrLFl
 b07TJ/BsgACH8CmBfxyGWSGK2v+v074u8PsXuomGP2W2xMkTZJa7gUYWms4Q52/09PNK+OP3m4M
 8h0L8kz6SaHVlDg5MN35Ae5tTNvv7EnRxRfioB2YfJNreZvoLUK6wQKyv6isxS8Ysf8OPVbLIwZ
 H03qnxWlcCUnhVQ7oExJaPDHyLOHSDYW3DJOw+l9+1lFghUbpNVCKpN45UtL0nwipnHc3EnGA/j
 7SC4j8pohnw0077AMICdvpGh1zEWHxAzzyMAUpscsOJ8wr048pqA==
X-Google-Smtp-Source: AGHT+IHLRHTkkFetm2Y09YcrZ+AhZ1fghtYu9WuZvGU/ZIi66MnupjsZU27Fz8zhvF8nNXwBnqyYxg==
X-Received: by 2002:a05:6000:310d:b0:3fb:9950:b9eb with SMTP id
 ffacd0b85a97d-42704d90129mr10070181f8f.28.1761079771433; 
 Tue, 21 Oct 2025 13:49:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm11134085e9.17.2025.10.21.13.49.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/45] hw/intc/apic: Pass APICCommonState to
 apic_register_{read, write}
Date: Tue, 21 Oct 2025 22:46:46 +0200
Message-ID: <20251021204700.56072-33-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

As per the previous patch, the APIC instance is already available in
apic_msr_{read,write}, so it can be passed along. It turns out that
the call to cpu_get_current_apic() is only required in
apic_mem_{read,write}, so it has been moved there. Longer term,
cpu_get_current_apic() could be removed entirely if
apic_mem_{read,write} is tied to a CPU's local address space.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-10-shentey@gmail.com>
[PMD: Move return after apic_send_msi() in apic_mem_write()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ba0eda39217..aad253af158 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -769,17 +769,11 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static int apic_register_read(int index, uint64_t *value)
+static int apic_register_read(APICCommonState *s, int index, uint64_t *value)
 {
-    APICCommonState *s;
     uint32_t val;
     int ret = 0;
 
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     switch(index) {
     case 0x02: /* id */
         if (is_x2apic_mode(s)) {
@@ -868,6 +862,7 @@ static int apic_register_read(int index, uint64_t *value)
 
 static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
+    APICCommonState *s = cpu_get_current_apic();
     uint64_t val;
     int index;
 
@@ -875,8 +870,12 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
         return 0;
     }
 
+    if (!s) {
+        return -1;
+    }
+
     index = (addr >> 4) & 0xff;
-    apic_register_read(index, &val);
+    apic_register_read(s, index, &val);
 
     return val;
 }
@@ -891,7 +890,7 @@ int apic_msr_read(APICCommonState *s, int index, uint64_t *val)
         return -1;
     }
 
-    return apic_register_read(index, val);
+    return apic_register_read(s, index, val);
 }
 
 static void apic_send_msi(MSIMessage *msi)
@@ -919,15 +918,8 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static int apic_register_write(int index, uint64_t val)
+static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     trace_apic_register_write(index, val);
 
     switch(index) {
@@ -1054,6 +1046,7 @@ static int apic_register_write(int index, uint64_t val)
 static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                            unsigned size)
 {
+    APICCommonState *s = cpu_get_current_apic();
     int index = (addr >> 4) & 0xff;
 
     if (size < 4) {
@@ -1073,7 +1066,11 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    apic_register_write(index, val);
+    if (!s) {
+        return;
+    }
+
+    apic_register_write(s, index, val);
 }
 
 int apic_msr_write(APICCommonState *s, int index, uint64_t val)
@@ -1086,7 +1083,7 @@ int apic_msr_write(APICCommonState *s, int index, uint64_t val)
         return -1;
     }
 
-    return apic_register_write(index, val);
+    return apic_register_write(s, index, val);
 }
 
 static void apic_pre_save(APICCommonState *s)
-- 
2.51.0


