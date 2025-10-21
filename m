Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB71CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGz-0005Jw-Sz; Tue, 21 Oct 2025 16:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGk-0004y7-9W
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGi-00015t-Co
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37842575e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079661; x=1761684461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQQ5psxWRgNiatcKRVUGVhz6uu63XiXm8T64eSiUx9s=;
 b=Yh6xAlyxDL6wGILeqtykZGKs+pg9KBT9Upcis6d3zy/suzcSix8HISaofJYdyGPq9i
 oBeTkLSWXMl2Lo8hu25xzDAPPG9f0gphDutG0U/o0GDiZN9/tsktbWr/0A5kQwcOuZoR
 BQtoVkUgz9Cty1ZONMkq1Bu39yEsJEjsvmGxq+OMTDZPawoNDSRxzD2EqXVuCD+U5Shy
 6dY0yD2RCGZ/8yf8D8/cVqszJC9d8kmFaAaWhWY6x0xRqREzuRgTxP1mx9F9HstbQzAz
 IhLh+zjW8XPP/HkL9oJbaa2QdSesHnAYq0cqgJ/a8WpN/0V8Net76hMtciXpyknUhMKv
 TE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079661; x=1761684461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQQ5psxWRgNiatcKRVUGVhz6uu63XiXm8T64eSiUx9s=;
 b=IcMTSypv5/22Z5FPhnw5AgRbpHBPvRH1T953gL4X15yesalkFJZNG0qSegD78dKlnz
 M9z1bEjnbTtr32RLK6GH5ME00deV6H8+Fn8fuCENBjGkgcnMK0PuTcAnYeKtkdn/Fpxo
 8o63iNSZOSzJnalVlRIUp4xVO/ZdmW7Zp5BnF5/zI80UcVuez15eFF1gOKkyFwQXxXqF
 umZfVY6No27JYUuvodLqmkFX3G/PhMSWXJbd+fyYdiSo10d5KDN8u31JtgqoV9RZ4LT4
 3wlDbJxPjPwKnrWE5gmyeD0AlQlWSg5pgFkMUV1sGFTm+cXyUxmvUhOEHvVLoge76vsj
 BjRQ==
X-Gm-Message-State: AOJu0YyZPWbnmt9sHa4mvrRr4185k2zxLThAIvzdWaXP7J2d6E9aodR0
 LbZNtQQwKMV8fgs+vJCBTjqppmQWpc8p+FKLVDaDBNLm6r8MLM1EI6WVzGQWahEzHkrndn2GnNq
 YkhUftsk=
X-Gm-Gg: ASbGncsjuF2IfqA79g3i0lJQSjNTBW/o53GcZZQ1BDgjwe3Prx9+Ivxahfdn4HXQ2JN
 h4xNwN9ubq2Zv/UPJGlQOc7W5An1DC0j880ptaddNZeD1gB4uslntj+E6LVuBVIxgxTLgu8/UKo
 NOvbfw9qVNpAdgyMVE0BjKMB0Rde16zk52I2YddydTCC5ISkWPSpu8vtqO5LCHUvsw5jMNVVXY7
 9fOLgo3Gn+PXvTrhBcPgm9HqjnZT1KqPc9ON9m7xRkN6VVJgF0O58+4asDbD0XCRtdGTWOfqJGp
 ZrHOL12KheeRvMQMhjI/luB6A8OZz7zclnCN8nW5J0iocD/yaQbWSOMZBGPLxxpdXi8dROOV/Wl
 VnUGSaBHvfHU5wOQY3/KpJJZwSGNOO0chH61nWvIq/4h09FP7mJqEijDU9XyDE3KSrubGhMWLRd
 8CFk3T7eZboVeW2QyI9as99oTQDMfxHMcWOUk9rrephKnqF7Q5PQeolCxK+R2GKFNONs9WlQA=
X-Google-Smtp-Source: AGHT+IFD1N3bpaDZizMwReNy1Um64LrLL22FZCa17VDuRV4mh+iFz17s3VGAB+2P7aEsjYJF+CnA0A==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-471179041b6mr137163555e9.25.1761079661188; 
 Tue, 21 Oct 2025 13:47:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f77bsm10042785e9.3.2025.10.21.13.47.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/45] hw/core/machine: Allow dynamic registration of valid CPU
 types
Date: Tue, 21 Oct 2025 22:46:22 +0200
Message-ID: <20251021204700.56072-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Add MachineClass::get_valid_cpu_types(), a helper that
returns a dynamic list of CPU types. Since the helper
takes a MachineState argument, we know the machine is
created by the time we call it.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20251020220941.65269-4-philmd@linaro.org>
---
 include/hw/boards.h |  4 ++++
 hw/core/machine.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index d0a69cd490b..c45272b7414 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -253,6 +253,9 @@ typedef struct {
  * @smbios_memory_device_size:
  *    Default size of memory device,
  *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
+ * @get_valid_cpu_types:
+ *    Returns a list of valid CPU types for this board. May be NULL
+ *    if not needed.
  */
 struct MachineClass {
     /*< private >*/
@@ -299,6 +302,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
+    GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7aec3916e80..cd2f1414a77 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1570,6 +1570,8 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
      */
     if (mc->valid_cpu_types) {
         assert(mc->valid_cpu_types[0] != NULL);
+        assert(!mc->get_valid_cpu_types);
+
         for (i = 0; mc->valid_cpu_types[i]; i++) {
             if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
                 break;
@@ -1596,6 +1598,32 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
                 error_append_hint(errp, "\n");
             }
 
+            return false;
+        }
+    } else if (mc->get_valid_cpu_types) {
+        GPtrArray *vct = mc->get_valid_cpu_types(machine);
+        bool valid = false;
+
+        for (i = 0; i < vct->len; i++) {
+            if (object_class_dynamic_cast(oc, vct->pdata[i])) {
+                valid = true;
+                break;
+            }
+        }
+
+        if (!valid) {
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+
+            error_setg(errp, "Invalid CPU model: %s", requested);
+            error_append_hint(errp, "The valid models are: ");
+            for (i = 0; i < vct->len; i++) {
+                g_autofree char *model = cpu_model_from_type(vct->pdata[i]);
+                error_append_hint(errp, "%s%s",
+                                  model, i + 1 == vct->len ? "\n" : ", ");
+            }
+        }
+        g_ptr_array_free(vct, true);
+        if (!valid) {
             return false;
         }
     }
-- 
2.51.0


