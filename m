Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A181C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F3E-00009N-3B; Tue, 22 Apr 2025 10:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F30-0007v5-OK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2z-0005Hf-0o
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so4593928f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333787; x=1745938587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKvZwIjHssYNiGyKthzi4mDa1O4lfY8uqFgDa2um9gk=;
 b=ChmoK2cFOaby6mCU1ywLRfv8XB9PhJEU0HAPulmtPgOf1k0z2OSV9qQ6U21I2bxE8A
 8Ev+Npzf+WahxJWviR4f3qEIrUe0GWv/BoQ0Kj6k75Xb5FryR6hGjllF4Vi/3wRPSnfE
 jmYRQXUtlaDqbILNSQ7OnCNccEPpzlOnQaO6fZYsCCVfMFnNwikby41rXYzXnZQoYQgK
 8W4AS8TBPF/x2Fb9XXTPmUbr/P0oJWcYuRo/EOSax4JDgkDzoJSYc9AXHWBBh0Oi1Q5y
 pkjX2Kj5V8glxEyFfwanE/nBujamQLPDY0aYChEQhOWGXvD+gL3IE0yxg6na/e6NI0t/
 yJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333787; x=1745938587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKvZwIjHssYNiGyKthzi4mDa1O4lfY8uqFgDa2um9gk=;
 b=WMf3+xDX/Y6UJ1EmeuyhWIa7JgefmLMlfeIj8hML2whUgUB7iicpOg8TcD1s5k+/8W
 wLZ5WfhPNX94TpXyaeUAEce/gEG5mSE1jTOPiBzl71WLxH/+KV8NjhH7WojxU3E18aSB
 0iUK6vIxKS9CrReGVJWAeuit1qy4ktKzZzLqzZ6cLiYiAO456L25JzJjrVb3G5yl6z1I
 OeI8mjdPedSFXX4pCdn7UE0BZLiGuPLBEy0hbgE0lGYGG02df9OsAu8oqHnOAqqlrNRQ
 tQOCtagUNnM5f+/RxfAQABLYd3riQ9Zm4cNL+3YxFxo2EZMXEAiNMXxH0q9a4sUUeDgQ
 6SMg==
X-Gm-Message-State: AOJu0Yz34c3IACLfYwVReGOeLp9w18L6rhG6X+Tq1WsBCdtscVkYOLLc
 WyDDf2VU6GryWaZPE0EZBErEvSl2oMQ1oYkOW69MfqH0ikoBdl94DRcH/juCIaqgO/pZM8q4KDy
 G
X-Gm-Gg: ASbGncvsh+RGRnpmWU7s0jFvAZk99QXlGm3KK+9o7UWx5eftuqtReQ/bdFiA69UV5LL
 tA71HuPlPzv12MXRVncy8PqkCUw6kPhJmDl6yan4NULNSqfy4YykhHZZman5fIqdAPswNP6dw+V
 ANU5Nu3729Yh4Qt5PVZgXsXK5t9Jt7UcScx2+RWn1fEP3wz5Zy9OE2j2jDmryrhZll8E0cm2Dd+
 miGVRM5cBMoZ2DcpL1CyHe7+TtI2x9fwlJOnQC60AmRDyLbcGfEp2gr+TMA1EN3HPyQNHxVmBU9
 yDios8xbXkK68acLkC0JtEI1EgRAHkuovMCgxshuNTBaEQ0EO5AXSQUWXybS37KdEezNkLhrVkM
 xEuwA9QicsUiJe65LI8gurGG+HQ==
X-Google-Smtp-Source: AGHT+IGrHP8yRaAvCiLm0XXpQhl09fHcEBm1gr4j2oxOrJuYlD3b/Uz19hKqkWo0qGd3Aw00jA7kIQ==
X-Received: by 2002:a5d:598b:0:b0:39c:cc7:3c97 with SMTP id
 ffacd0b85a97d-39efbaf133dmr12396604f8f.50.1745333787293; 
 Tue, 22 Apr 2025 07:56:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcdasm176925945e9.20.2025.04.22.07.56.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 18/19] hw/core: Introduce
 MachineClass::get_default_cpu_type() helper
Date: Tue, 22 Apr 2025 16:55:00 +0200
Message-ID: <20250422145502.70770-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

MachineClass::get_default_cpu_type() runs once the machine is
created, being able to evaluate runtime checks; it returns the
machine default CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  6 ++++++
 hw/core/machine.c   | 10 ++++++++++
 system/vl.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index be0c0f04804..6a0b02db42e 100644
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
@@ -310,6 +315,7 @@ struct MachineClass {
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
     GSList *(*get_valid_cpu_types)(const MachineState *ms);
+    const char *(*get_default_cpu_type)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8b40735ef98..89169a2dbae 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1538,6 +1538,16 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
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
index e8706a9ce87..338f9d75289 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3825,7 +3825,7 @@ void qemu_init(int argc, char **argv)
     migration_object_init();
 
     /* parse features once if machine provides default cpu_type */
-    current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
+    current_machine->cpu_type = machine_default_cpu_type(current_machine);
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
-- 
2.47.1


