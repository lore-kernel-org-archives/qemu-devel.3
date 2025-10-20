Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34027CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy8q-0005Mh-Sj; Mon, 20 Oct 2025 18:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8k-0005Jq-IL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8g-0006Vw-6V
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4282fba734bso1170767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998440; x=1761603240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyUZ3dUUvHSOpFdYXBtExya1pV/LCHz+vT6iC7/BDnw=;
 b=T2agEUZhosHHE6Fhe4jhP88vb6p2/sseID80w4LCA9VrUtqwK3P1gYNX3Eo7laLHWd
 hsb323vkYHqhnXzUyH5AbJkudAIGAnVleX85rPUjoVKc+9NHHW3K+TeqRFfhZ54JGMSf
 DfvU+OKBRGxU/8IbgT4Ho7eL4mzm5IsAaAEUkIWORZJSuYpkTfmgWgSyNlir6axiCqUj
 XTFN0I2NtpYm9N/wLQD7rSlP+WhtM8SeO2frvpoNigtSkB4vvydcHmjzBQAeiDQ1N+ek
 6aeR7ctBsKDBFd+aNMb0VBTFR7YDNbyqJL6zJnB9TQ4qg/CPWa6Q/KUMyOtbGAA/r1/b
 jMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998440; x=1761603240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyUZ3dUUvHSOpFdYXBtExya1pV/LCHz+vT6iC7/BDnw=;
 b=NpSpN8nLsV7VDCF701VE608vE1kQxRt6bRGWZZv6qcDk0MrDj2Yr3O4382jwFdIBHX
 zhL9kXgJxtUey+dwkN8N+Qf9PIUJwTAGJBPtYWqQE9x5hFH9Z5Woh9O0vkcCmpN9ZDr5
 ZyBAMmri2wBc3gOCNvLLWua6haJrDKYldY7Io32Mj0lrYL+PSiyMTpd1q1FigoXotpDo
 xLJ0CdGp5TpIV7c9NOFjHfwWbwlCKWOXcIEt7KL52N4a6ubsYXJ8huA95/5gWrmut48P
 Uog/91kwZyzBdiB//0dHnLZkKse/cnQZZVrn8TP8SkJV/ahE5jDT65Y8/Y3JRKSQD0Oy
 NXTw==
X-Gm-Message-State: AOJu0YwfVAgkRcl/bPIeSpfcWdBvcFcqCGAN6bwLuB5ckawBfmugBJ4h
 5wVTyuJR1b/RzGTJeJvuUkpeJQOSIcJr4jRoAWF1yXsrFserB925jxbE7TZuD5VqqgPOe9a00ez
 Cp239+mA=
X-Gm-Gg: ASbGncsiR2Dg4SU0BAsDWqH9Mz5/loSG3jL2aUaXO9p/jVnNYq8OoS4yPyid891CQFG
 MbjJpzO4U0TzmLDwUcXnJqPRp8v5qcmfuJ3EbzCpmIa1R+KbI2XYnbtbs/wlBTG95q0WBmpbPx7
 e/5psc5maGstP7Q1DE5au4jmxY0aW9VCxn37EiSSvrREPgWXga4HNpOjv/GNhdhWnL6ILWizynO
 bbaNYRO4dpaU7/HSn0fzoLkTdqmgSNz+7Fhz863M5jfAhqUBAPuPTA7zVbjc9dGLQ6md9hdGE3x
 wWlZBmyWvaOIsWxadAny02FivY3lZoDY5/IztIu2e0yvdkas/OLXiUm8MgK7AnJtkFPZOjXP2aG
 nPYYaldlpIx9RWOAfWKf3EdKd7lgfd2Xb7UGnxIgCbO5tU+23APxPGfbot041BwdcweCP3Oe+Ao
 vkl5vyBY98lFKeghmtPrzY6+9TjhvxJ9IXn+Oku0jOCFERP7rwHL+XrU/7cwh6
X-Google-Smtp-Source: AGHT+IEJtMOVSNaJwysnOpGCfnCMJeJxRLV26eQH04CrGWlYnYFkfyfRhAVaXw5FIMCMxfv3dqmoiw==
X-Received: by 2002:a05:6000:2406:b0:427:a27:3a6c with SMTP id
 ffacd0b85a97d-4270a273c43mr8085781f8f.63.1760998440006; 
 Mon, 20 Oct 2025 15:14:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9f71sm17258998f8f.37.2025.10.20.15.13.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:13:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 15/30] hw/arm/virt: Register valid CPU types dynamically
Date: Tue, 21 Oct 2025 00:13:20 +0200
Message-ID: <20251020221336.66479-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Replace the static array returned as MachineClass::valid_cpu_types[]
by a runtime one generated by MachineClass::get_valid_cpu_types()
once the machine is created (its options being processed).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
FIXME: Richard comment:
>>> Why do these need to be strdup'ed?
>> g_slist_prepend() expects non-const.
>In a few patches this become a run-time check:
>  if (target_aarch64()) {
>    ...
>  }

FIXME: Pierrick comment:
> It seems it would be more easy if get_valid_cpu_types simply return a const* char* const (same as existing valid_cpu_types), and caller does not have the responsibility to free it.
> This way, the list can be built either with a static array initializer, or with a dynamic GPtrArray, that we keep under a local static variable, so it has to be built only once. We can debate the leak introduced but I don't think it's really a problem.
---
 hw/arm/virt.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 20e3f1094cb..e19da6fd901 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3256,36 +3256,41 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
+{
+    GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
+
+#ifdef CONFIG_TCG
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
+#ifdef TARGET_AARCH64
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+#endif /* TARGET_AARCH64 */
+#endif /* CONFIG_TCG */
+#ifdef TARGET_AARCH64
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+            g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
+#endif /* CONFIG_KVM || CONFIG_HVF */
+#endif /* TARGET_AARCH64 */
+    g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
+
+    return vct;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    static const char * const valid_cpu_types[] = {
-#ifdef CONFIG_TCG
-        ARM_CPU_TYPE_NAME("cortex-a7"),
-        ARM_CPU_TYPE_NAME("cortex-a15"),
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        ARM_CPU_TYPE_NAME("cortex-a55"),
-        ARM_CPU_TYPE_NAME("cortex-a72"),
-        ARM_CPU_TYPE_NAME("cortex-a76"),
-        ARM_CPU_TYPE_NAME("cortex-a710"),
-        ARM_CPU_TYPE_NAME("a64fx"),
-        ARM_CPU_TYPE_NAME("neoverse-n1"),
-        ARM_CPU_TYPE_NAME("neoverse-v1"),
-        ARM_CPU_TYPE_NAME("neoverse-n2"),
-#endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a53"),
-        ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-        ARM_CPU_TYPE_NAME("host"),
-#endif /* CONFIG_KVM || CONFIG_HVF */
-#endif /* TARGET_AARCH64 */
-        ARM_CPU_TYPE_NAME("max"),
-        NULL
-    };
 
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
@@ -3311,7 +3316,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
 #endif
-    mc->valid_cpu_types = valid_cpu_types;
+    mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-- 
2.51.0


