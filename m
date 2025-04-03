Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5A8C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVq-0002S7-Kb; Thu, 03 Apr 2025 20:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVd-0001sT-4q
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVX-0003GA-Bb
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so1226243f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724920; x=1744329720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEQ4caRuUm17bqEdIOfMLiQw9DDP+11LU+Cj2r4W6Vc=;
 b=DiDhqPnUaC4SRbYNlQmpQg9VqleterL4nzs2cFNnINdG9TROxwQguuoQFsFnL7DFOi
 +5Bs1Hw7JhhBhXXoOdIeJjgitntj/SRkDLJAqJUL6AEu+txd5tZtjpjOtkqfPhhQNf1j
 GrCUHnue/X4Df67wMjoAtlJL4pQL9DNPTPglBfbfO2xYfhE2+uTszB1rsOVX6g0JUwa5
 Gw4Zx0j4TcxSj5sh5VoLcA8OoB6GOu2p/PILA+uVfIAN+0wSgXfAmvlAQgyi5vh9Fq4Q
 4WZXMPSrutGrJpa/GTKbZSeM04yUllTKuVUHWZ6qxLDzJ4I4L/77O2jWK7bgeIm3YTjX
 PpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724920; x=1744329720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEQ4caRuUm17bqEdIOfMLiQw9DDP+11LU+Cj2r4W6Vc=;
 b=QQD/0QgDuMJNvBhNpCWPYaD0l2RR2GIuTn1rSenvm+mqoh8uDkpqrhuYy3HUBr2T55
 3qAfxlUhWNLMtvgMkGS7Bz3xmHS77rS8JyZTpfxh7jUi3J8nOnarDJW/19qFbMXfExwU
 bZ9RzMKxAohiGPTk289lif6Z7vu0oapInsKvaH5BeYuccCJ1FzaPdyLy0vlfbFCAk8bR
 fgCloUzVq8RiszqDqoelOViVOafnfenugRb++El6uLacbD+ZqTP1rl2CsAaw7fi8plYs
 mQRid6xkIzKYhpwQIn+Vg3//if1GJW0F0WHNvzenRDBB96V2n62C4xHFKeOC11aRNFUS
 EBaw==
X-Gm-Message-State: AOJu0YwCI9LSixap2QBHrCnDC5aLl2j/LM6S/nM7yLGPtUbCkl48DK7w
 a2e2ovopiWxtJHemFJc+hm+a2H1vexyXKVi9Cxf6+BYVg83OwP81uoJQo+WovtXHKTeHr7dZQEV
 J
X-Gm-Gg: ASbGncuK2XW+oWZynYlxeGCGA2FyLmcNeTV07NGpICy0azbJenpXiBCXpUlPoQIyb4x
 zxH7rBgLWq6ezj57SjYsXdm/BVOIT9CZ7yzJh1BrjBke5RnZSbySUbk1vq+YyAimXG3efuD2+n9
 cDbJoBH+WG+doUH286RoXlwYUKPdKfa2muENSAHAUNoUPQSAm8m1n1xVnXzg8y/dlqd6KxE8AH8
 yIfJuN3U3vUv6diqqwmsmG/ZByFdSHU9zChOL65ajhwXLF7LPXp+zVM6loUUFp4XM08/1Z6VhUm
 RqCNhGdY3zBjINYa/Als7BDMLZNwMPrIeCNSEL4XyMh1FBuPuIxmulQU6GU2rlDF6ilJdoEs5bt
 gjY/vePsZkYPlyhYGJq4=
X-Google-Smtp-Source: AGHT+IGMYDZ9BiUVKCWLsZyqPKwlwfLqqm7cKvIQLVdU8TrrcadW1B86XNq4q+uriYiyXYW3pzA9OA==
X-Received: by 2002:a05:6000:1ac5:b0:390:de33:b0ef with SMTP id
 ffacd0b85a97d-39cba93c429mr785050f8f.30.1743724920555; 
 Thu, 03 Apr 2025 17:02:00 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163107csm35041975e9.3.2025.04.03.17.01.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 33/39] hw/core/machine: Allow dynamic
 registration of valid CPU types
Date: Fri,  4 Apr 2025 01:58:15 +0200
Message-ID: <20250403235821.9909-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Add MachineClass::valid_cpu_types_list, a dynamic list of strings.

CPU types can be registered with machine_class_add_valid_cpu_type().

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  8 ++++++++
 hw/core/machine.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index b1bbf3c34d4..92a13b0dc32 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -57,6 +57,13 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
 bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
+/**
+ * machine_class_add_valid_cpu_type: Add type to list of valid CPUs
+ * @mc: Machine class
+ * @type: CPU type to allow (should be a subtype of TYPE_CPU)
+ */
+void machine_class_add_valid_cpu_type(MachineClass *mc, const char *type);
+
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
  * @mc: Machine class
@@ -307,6 +314,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
+    strList *valid_cpu_types_list;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b..5993c6e38d5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1538,6 +1538,11 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
     return mc->default_cpu_type;
 }
 
+void machine_class_add_valid_cpu_type(MachineClass *mc, const char *type)
+{
+    QAPI_LIST_PREPEND(mc->valid_cpu_types_list, g_strdup(type));
+}
+
 static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1581,6 +1586,29 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
             return false;
         }
     }
+    if (mc->valid_cpu_types_list) {
+        bool valid = false;
+        unsigned count = 0;
+        strList *wl;
+
+        for (wl = mc->valid_cpu_types_list; !valid && wl; wl = wl->next) {
+            valid |= !!object_class_dynamic_cast(oc, wl->value);
+            count++;
+        }
+
+        if (!valid) {
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+            error_setg(errp, "Invalid CPU model: %s", requested);
+            error_append_hint(errp, "The valid models are: ");
+            for (wl = mc->valid_cpu_types_list; wl; wl = wl->next) {
+                g_autofree char *model = cpu_model_from_type(wl->value);
+                error_append_hint(errp, "%s%s", model, --count ? ", " : "");
+            }
+            error_append_hint(errp, "\n");
+
+            return false;
+        }
+    }
 
     /* Check if CPU type is deprecated and warn if so */
     cc = CPU_CLASS(oc);
-- 
2.47.1


