Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638B9C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F2d-0007AT-3G; Tue, 22 Apr 2025 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2V-00073z-BL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2T-0005Ei-6i
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso4535472f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333755; x=1745938555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXKfwIcrPvC5QvBuHzIyemct49OPnabCI5IYu6xLPCw=;
 b=NAEW9omlsN4FmBo2kGUE8vh/YQU64LEFTS7M/Q7RcfNgifeiRA9fG4xTrmJ/atYezE
 wAVaVp67cGJiE7czZBFq11Fdp4HjeCjuF3Ro+x9bVRTIX3ll7gQbWWxwjjSOoaQONg/w
 9y6Qwi/eGSJ6qisf/idphNFX4XmTAacb28ezJLbEh3QaelmHrDF10lpKRzJsCAgB1SYi
 oCa8NRM+yzB5pLpplTV/3/Axv0w4HDxeHrmM9YFZuF26Xr9L/5/00SZ1sLErQ5sBa/FR
 xFQZSnd4Z9+uSQgmubFAQHjcn8Fiac644xzAmYj7XFvn4dhGbxgJTi6zeOEwXkKwK1N9
 IgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333755; x=1745938555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXKfwIcrPvC5QvBuHzIyemct49OPnabCI5IYu6xLPCw=;
 b=VqS7ORH009TKVftbGESXIBUPbKpUUwYYtyG5qEuLJCgWcU1OpEEFUqZ9WciRrhwG84
 2W3X8JQ5bPtLfbbkH2BYO2x984HpupSNgQzwoc7DmREzbAdaoA02WGMz67Guvo+bmMAg
 lZRnif3lG7ZN05YymOLg7gbALDHpJm6jAjXZ7eMNtyYjGNsx46ZFYxtiDSbdF6kQ4iGx
 gSidKE1RxFL5Pn4mf66OsSee2y82ixWSlJafxR6LGDdLGJ00ufxuYVNNEfDXXRgb2zqE
 9N9IPGU075rkQ6qlEZs/SD8CL4TdpjZTUp6FBrAWYOjNUG9NG2RJh5yxbnvl3lGRnh7f
 2HnA==
X-Gm-Message-State: AOJu0YxA/tFK7ZEGL1/q7dttXrUSYrjxkmaZefBxutei6z58eFjyKYK9
 Jkxix6WZe3TvJYfs+T8MBsqnVdycuEaU54LWclRt5IvVpgmgNHFoL5bTIKug7o9MccKcDPC7XQ4
 X
X-Gm-Gg: ASbGncteCvokg5yBqqep+0ELMpJKaJlTPS1zu3whmZB2yRrO6C/cILXEza2uYnIynQ+
 Goavd9stvJHXV3Phj1mVr7fA7c0FJglMcUxAyxqwrfRZ0yAP7L1Ho3AuKZsW+WvIkvZyXQBMwBE
 tyH990cmoiphc2BtcZeAJN/2I0SeaZkC+LnQu7pJqyVMIqET2ArtKK8FuDekK9vm5GbKWyLtF7c
 Ys24DV2M2C9CLTN4HRHTcvNNrxlAwjs5ptNYq1audrGFIfHnXCL8L+NZavBytCe9Jt4cmqRnoBs
 yt8p05ZJrFReA/AohRh4VRov728S4gijmFD0kjy06UeD6OsIw/X9/CXm4MffCfOI7zVKU9EleNO
 dEP1BQf/4QTkeWoao9GOmNC83cA==
X-Google-Smtp-Source: AGHT+IH3kbWZk9Fwv9mDfcHDH9MY447+pkpReNyEh9a+XFd9ZhrQI3WEzcW9GiwGJEkWqYfF/GZMgw==
X-Received: by 2002:a05:6000:430c:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-39efbb17649mr12256816f8f.57.1745333755404; 
 Tue, 22 Apr 2025 07:55:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433133sm15305288f8f.28.2025.04.22.07.55.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 11/19] hw/core/machine: Allow dynamic registration of
 valid CPU types
Date: Tue, 22 Apr 2025 16:54:53 +0200
Message-ID: <20250422145502.70770-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
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

Add MachineClass::get_valid_cpu_types(), a helper that
returns a dynamic list of CPU types. Since the helper
takes a MachineState argument, we know the machine is
created by the time we call it.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  4 ++++
 hw/core/machine.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f43ac5d4d..be0c0f04804 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -259,6 +259,9 @@ typedef struct {
  * @smbios_memory_device_size:
  *    Default size of memory device,
  *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
+ * @get_valid_cpu_types:
+ *    Returns a list of valid CPU types for this board. May be NULL
+ *    if not needed.
  */
 struct MachineClass {
     /*< private >*/
@@ -306,6 +309,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
+    GSList *(*get_valid_cpu_types)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b..8b40735ef98 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1581,6 +1581,33 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
             return false;
         }
     }
+    if (mc->get_valid_cpu_types) {
+        GSList *vct = mc->get_valid_cpu_types(machine);
+        bool valid = false;
+        unsigned count = 0;
+        GSList *l;
+
+        for (l = vct; !valid && l != NULL; l = l->next) {
+            valid |= !!object_class_dynamic_cast(oc, l->data);
+            count++;
+        }
+
+        if (!valid) {
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+            vct = g_slist_reverse(vct);
+            error_setg(errp, "Invalid CPU model: %s", requested);
+            error_append_hint(errp, "The valid models are: ");
+            for (l = vct; l != NULL; l = l->next) {
+                g_autofree char *model = cpu_model_from_type(l->data);
+                error_append_hint(errp, "%s%s", model, --count ? ", " : "");
+            }
+            error_append_hint(errp, "\n");
+        }
+        g_slist_free_full(vct, g_free);
+        if (!valid) {
+            return false;
+        }
+    }
 
     /* Check if CPU type is deprecated and warn if so */
     cc = CPU_CLASS(oc);
-- 
2.47.1


