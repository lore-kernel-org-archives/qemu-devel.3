Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9ECCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyAQ-0008OA-2o; Mon, 20 Oct 2025 18:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAO-0008C3-5R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAM-0006qT-6B
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so22217035e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998544; x=1761603344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sd9XbBWaPuGKNpw5kMPlomKlbYG7JtQTngo7iwdPDmw=;
 b=yj/vdcBum2mwhJw9CMZy4tLPySUC/KZcIpAWen/tg91sz/b2h028txmtT1reePPziL
 Z4Ei7YfooiiQsvFjV79iBHLvvzJwnjjZxWqIVSf4RDKk/d6VspL5IJvYeErqDDN4z5Aw
 1gg62yivZUBtbXxH2eA14h7SqeLxTcK8D3unfI1DlETooEUYUgAhFfZHik54Krd60NHI
 0TnimGoEyVp/JYLrf6TgNpRJWmb86Hm6R13Uj43KkyopPHF2kk9O7JI7ZXgD+86emt4A
 sFshSbvwnAr8FQPn5NxkN2i2qMQCoeuIjDg85jcWBT+18fQJdNdi6Xxx+udoGjvVaxrh
 yhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998544; x=1761603344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sd9XbBWaPuGKNpw5kMPlomKlbYG7JtQTngo7iwdPDmw=;
 b=B3g56p3UI7lx5ghdUR/u5eOM4bkaZ0D9TPQWGtvJdFNZto09b/0TZO1pNVFhLHakM9
 dRONVq9TasihIp83PgOyHFCmTk1Jq543dIXxxmW4iifi2yOwtB+Eoj5UiB8xhDZEnexC
 VfKOflAqi34qzE0C77evkqcoMutXZs11DytnA1GHLSJRvqNTP5glGzrVS6eNND3EfP2q
 mBUKZf3DIDwdTmJG4aj1gPAwaZ0puO8pZ81xyq48rD7+TXDbyIJlY0EwTEo4t0KTv7Xg
 QYJEXHk8g0TW+AJZie4NRqFh9if+p1V6BxkAfS4JJZs4i8PQunrjMYOjydTwNEDQvhus
 4dng==
X-Gm-Message-State: AOJu0Yzc+FeUiETHP1CBh396CxdmZvL0d0KsoKaL9h64QVJ0qV+DKB+z
 1/c5TG5VK7wQZa7eS19yrBX/kUIMvdyjeUXyu/5h+Vahg4qVYr0T3R1M+F1l/xX/DNS4Y50Xp8z
 L6Ji3s9U=
X-Gm-Gg: ASbGnctX+GoRTTQGBiCTqgcYl40WtOztSv4U+u697MwPiqzxlLLen90r8dXEePxBOc/
 uymBo/hK/9+kMaUU9Ut5B4Old14VWH5mTTITgbS5e+WavhR9wxOaPqMganI799ptBN1ArPfggAr
 9JFhyUKkABZRDqvMrXOgp+6pjLGYxg/oHf3TEa8QXKXhcn2KwnuQgYgKU7B3gQxU55TcbPP2CQF
 QePczm5AD3DkGADPI5Ky2XJ+dvrmTivMYKwwV3xyGHo/1UyVArQYf10q2k3Yr4B1rEESdx0Dw4R
 RiEpHq/f8b51yyJMNsyMB7Ugyr/Ra0esjcuXU8T7Y6W40VZqlLqOLlPmCblCiCiM2TQ68SlG6Q7
 4crFeRx/GGykUQn6LVy32iU4V3LkbeMZyaO2QacxbehE3h0nQ6GZDmWDAlyvo1QRb5sg7aNjaYL
 PoEtWpeMYz7w6y9I1uA8g2FHGsEWE0g4TjaJKmx8pVJwoScVxiPQ==
X-Google-Smtp-Source: AGHT+IH7yvA9+h5U0ggooXDqiX18ilulXBihN7dp6QNEq8NwdI9hfCtCiAczaouISZ5R/bNTWe+lXg==
X-Received: by 2002:a05:600c:8b30:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-4711791cbcbmr110605165e9.30.1760998543934; 
 Mon, 20 Oct 2025 15:15:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b365adsm4350515e9.6.2025.10.20.15.15.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 22/30] hw/core: Introduce
 MachineClass::get_default_cpu_type() helper
Date: Tue, 21 Oct 2025 00:15:00 +0200
Message-ID: <20251020221508.67413-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MachineClass::get_default_cpu_type() runs once the machine is
created, being able to evaluate runtime checks; it returns the
machine default CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/boards.h |  6 ++++++
 hw/core/machine.c   | 10 ++++++++++
 system/vl.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8fc34579412..5f0fa5f56c3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -25,6 +25,11 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+/**
+ * machine_default_cpu_type: Return the machine default CPU type.
+ * @ms: Machine state
+ */
+const char *machine_default_cpu_type(const MachineState *ms);
 /**
  * machine_class_default_cpu_type: Return the machine default CPU type.
  * @mc: Machine class
@@ -309,6 +314,7 @@ struct MachineClass {
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
     GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
+    const char *(*get_default_cpu_type)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d9684fbc85..bf0530b25cc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1559,6 +1559,16 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
     return mc->default_cpu_type;
 }
 
+const char *machine_default_cpu_type(const MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (mc->get_default_cpu_type) {
+        return mc->get_default_cpu_type(ms);
+    }
+    return machine_class_default_cpu_type(mc);
+}
+
 static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
diff --git a/system/vl.c b/system/vl.c
index a96063f9901..fd98ea52d9c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3817,7 +3817,7 @@ void qemu_init(int argc, char **argv)
     migration_object_init();
 
     /* parse features once if machine provides default cpu_type */
-    current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
+    current_machine->cpu_type = machine_default_cpu_type(current_machine);
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
-- 
2.51.0


