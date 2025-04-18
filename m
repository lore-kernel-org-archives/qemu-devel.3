Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACCC369D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pYH-00041k-5r; Fri, 18 Apr 2025 13:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXS-0002jP-8l
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXQ-0008Tj-GO
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso16277005e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997402; x=1745602202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vxONwu0xD0Va4pDNJvXwramrjvwjwlqxzQJDi5JhcI=;
 b=iKJt9lQAverj9rHpq2cNF71Q9MyjOjQuBM5eiEtW8ZHD2ZqNpldgNpczO2gXNstnHX
 UsR8sz/EbusDmmC9W/WDznMMAUEpb7GdRMKHr3EbIuTdNMKG3lHLWAZRugMad2Odbmvl
 FtJyhzAvp3TOYCb2aLLdrFgPtpRYVtcvdN9XuIaK2rzFY25nFZWf47gtnb3unp6uskyw
 5GdgyS+4B538xrjkEBblfxXgiI/heJyfc+jk5+IfYja7jIrc3hzOcQdoxU3v4/Va33AA
 FdtqB68qYZ7E66eWEylK6RzX/stKW0r66oP58c+Pe+e1fuJKGdKEBep4FsNom806hYO1
 8PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997402; x=1745602202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vxONwu0xD0Va4pDNJvXwramrjvwjwlqxzQJDi5JhcI=;
 b=TmXyfTuO+Ho3RrxBV+Z/45JtQNaH3Po72BNqzii54GriwDxsjf7UQxXmjlKvIpxZAb
 fsk8bmZzX5FyfzRa14qetpvokoPrWkI1qtTEdyNf7UeAPI2fjm0QD1b65p2t4+aavJfY
 oWhE8hh7XqoLxudXq9XOr1botjKWkpSJjpA3vpjf64elBUT8ap0Fnyj92J7uvrxZX8Bi
 jnfqenfKdq8fpl/Y7BVrZja267X83VNmsu1z2F8Ch0AhuDv8sXnCYluYjMOYf6mFa1I9
 l9o8O9ktXQH0ZDu8FBUYcVvVDZVwChGVfeefMGUFAZc48BzrT/kJTq91/ohrDYj3aW7I
 tMzw==
X-Gm-Message-State: AOJu0Yx+922eGhC6CA8MK9TWtMqa2oOPqaiYJBqreaxi/sYlJOG9iEGt
 0IrAcS0VckDQVNDjA5gxTQgqrNrtqyimLXFuLjaBti1RjBkRiyuqG5Req24Y1HiOuLYBcMQpr2/
 A
X-Gm-Gg: ASbGncskXuO7G6NajBSRAcczsz4SsMR1CQzd+299L8tDeXrpzWnlVRolGvlbKRNXL7h
 /Zjyzozj1WdfrB9xc/KBQhGDqA2jsTbkuIr1qcGvc0XUNjj6gsxhsnxt9DJ/j2MSsfJnNhxzC1g
 iLZhcS7xyogWsCg4FRU2Nsti01cUXgDlsoDvZQ6KwzJ8QeZB9K52eu5o3nQu4Pd+GvZuxjiY6do
 uO8dCpE4EYDR2CX7gA8OwVEIvhryfQWsOqw8A+IoCYs5qO3ULnFE6JItPo0NcEKVqiFmCY9qxMg
 vUBQ8JbUCi14pzhLCGMSmP1BH8F1jP4mK9lxwypnKllcWhs2MvoGpjpMfdTDREhlISyOSQeUTd9
 +drzLXIyhDQy0oPw=
X-Google-Smtp-Source: AGHT+IFaP9Y7bXngc9Lqme9Tw8x9r7WUXGDax6vlxEPNmb065OS1VNIAd/hK/9K7Uyj3DbVdgUyMtA==
X-Received: by 2002:a05:600c:4f94:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-4406ac1fd21mr31063485e9.31.1744997402450; 
 Fri, 18 Apr 2025 10:30:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e0183sm29554895e9.37.2025.04.18.10.30.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:30:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 11/14] hw/core/machine: Allow dynamic registration of
 valid CPU types
Date: Fri, 18 Apr 2025 19:29:05 +0200
Message-ID: <20250418172908.25147-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 hw/core/machine.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f43ac5d4d..647a29ff04d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -56,6 +56,13 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
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
@@ -306,6 +313,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
+    GList *valid_cpu_types_list;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b..ff27d533b5c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1538,6 +1538,12 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
     return mc->default_cpu_type;
 }
 
+void machine_class_add_valid_cpu_type(MachineClass *mc, const char *type)
+{
+    mc->valid_cpu_types_list = g_list_prepend(mc->valid_cpu_types_list,
+                                              g_strdup(type));
+}
+
 static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1581,6 +1587,30 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
             return false;
         }
     }
+    if (mc->valid_cpu_types_list) {
+        bool valid = false;
+        unsigned count = 0;
+        GList *l;
+
+        for (l = mc->valid_cpu_types_list; !valid && l != NULL; l = l->next) {
+            valid |= !!object_class_dynamic_cast(oc, l->data);
+            count++;
+        }
+
+        if (!valid) {
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+            mc->valid_cpu_types_list = g_list_reverse(mc->valid_cpu_types_list);
+            error_setg(errp, "Invalid CPU model: %s", requested);
+            error_append_hint(errp, "The valid models are: ");
+            for (l = mc->valid_cpu_types_list; l != NULL; l = l->next) {
+                g_autofree char *model = cpu_model_from_type(l->data);
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


