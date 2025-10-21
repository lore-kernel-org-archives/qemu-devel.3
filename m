Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB426CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJdy-0003NG-0Y; Tue, 21 Oct 2025 17:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJdt-0003Mu-LQ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:11:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJdr-0003vF-CY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:11:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710683a644so2681245e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761081097; x=1761685897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyUZ3dUUvHSOpFdYXBtExya1pV/LCHz+vT6iC7/BDnw=;
 b=wQyzWUc65WRBzRmzsgSf57JUAftulk9jaUvY2/oYs9IlnaP2FNRG9gfDS3GLfnUhaA
 OzbkKUCXtvhIdi3Y3EJ26RbsrJs1j3v/sFAvNl4lCWh3UfL1nvC13XOWWo8iZOmUvYoT
 W469ZssFPA4o+gnw9GmiUCDIHBWWQb4Gwtg4roEVLTfhDSR39MaRIS6/xNh8buvZGrTb
 07/w1fRE6ME8HFFL3idS5IdJCbo+hVPfzqj/ooEZ9wCLTXxBVVYAA91TobVhOlwX6kiU
 uA1/7fSsfLKPK8ElmeJjnG55nA5vNAH4pa5hYj83OzD9latZW9pFBpXce5m0Vp2670MW
 /EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761081097; x=1761685897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyUZ3dUUvHSOpFdYXBtExya1pV/LCHz+vT6iC7/BDnw=;
 b=kN1KgeAh5dm/iKGqKlok36M3aZ7Af6A4pL6px7hC2XnXVf4ULKDXwAWQSh1hADBq9v
 VXtWE4y28vlAL5+LguHAR54LFvvqInos086oRqGuCISyTmIBTb2K89aeUNcb3j5ruhT7
 fRJDcVhYIhKhB4p64/uoQdlghRAVVM26Ud47ly9StYaBAMkWty5zbqwRXa+JobWVV2JV
 67sD15i8OBQQ8H/5S/VcaQ5FjG5MKbHM+6qwxIgtOzmjFvgtv7IfcAyNRiC4AzcBx10J
 XWCKRj5hFgU6XensDo6AgS7FvzbHhuIahBj5wZU8tnGJOghwxNyBmwNZew93GpLY43rx
 cJbA==
X-Gm-Message-State: AOJu0YwYCAuox1reoe/QR3TSqn47cHCZOTh67Eh/nTAL24Ah+UAfgHj9
 zNO8SqHpIDDU0Nx+D3DP3qtijqMGStB8UQDdgqNtqBLlwu63tuhlb1kL5g4wQNPQEKTO92ocbS+
 VM+HOGkI=
X-Gm-Gg: ASbGnctHuaASDJ0oOTjkHwPEqO0Ll8dQYN3+iRQPlLDFpS+F8BZ8eWkpnuyXEkIEn/K
 OhsFprktbhhfidofA0ptUQUmtWxvGY1uoZw6shcLoSDr1U+r3XO3yw/fnKrPgd/9tcJ6WnNdjml
 tAevIvyXM1m/dAdbgag6Iw5nF/rd2GsXpoaPvKCKbYIejzq/5M3oC+Gcl0qZnHYHDOUjMFYeUf9
 la6nM3aXgWh56POGgM3uSKOxkhT+yVii1h+vWiBqOLYvu7QTcUmwLUjsw42HOShv72emYpTgK6c
 8JsHHpYnVkgk4yIMUv/zcz+NJNArAtsgN75+BSi+8AdnIwD+rlgwfRpbPtsRS3tHNV+sy9FjCpf
 +gZIu7kWFKQA5lFQcxcQTbJEzGaOboLxUUmBAGhYoYKoh49ZQnvZ7t1QBbrUzx/seAveE8Q7bDf
 /kp48Jq3JnZeCuR/kwHi2uNq87GfbPvIfHhg0exiQJ8vJh3lie8Fi4RZDkG4+j
X-Google-Smtp-Source: AGHT+IHx52OEVE/b0k1ISh19YZSSaWiHtdeIpFK8hpEs8Fuhu1AXeyQiZc1vvJCjxhswPzvBBz9T2w==
X-Received: by 2002:a05:600c:500d:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-475c3fc2ad6mr8075035e9.10.1761081097032; 
 Tue, 21 Oct 2025 14:11:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428a16bsm12006075e9.5.2025.10.21.14.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:11:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Zhao Liu <zhao1.liu@intel.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 07/19] hw/arm/virt: Register valid CPU types dynamically
Date: Tue, 21 Oct 2025 23:11:35 +0200
Message-ID: <20251021211135.61179-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


