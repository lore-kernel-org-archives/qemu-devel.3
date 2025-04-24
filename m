Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420D8C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84yD-00080c-Hl; Thu, 24 Apr 2025 18:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84yA-0007hP-47
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84y8-00016G-72
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1205104f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533374; x=1746138174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OslDaHmml5vji5p+h0aO4Re5CvOPTyryghOTVR1940=;
 b=iGr2VF6qR6dD5QmH0cuPlGxDzXDbybyYeFIlRfZACkJtuBBgUeXP8abVQU/8WWD4iA
 +gOwE0RoH8U4uuf9A5vKtXiA1449IdojKiB4QpGTZhvsxdn0Kbu81JjPkOVLK1/99gjm
 dAVRV+qZ6eWcAiIX20S3NLlz1KSqKZLEFm0Lrl59o+6uULbC65bI+WssO7pGTE8UCZw5
 97WZMF4tTKQ02phzK0EeGXjZ4uh0y5bwzcY4uXzEssAH9iJhfbt5VX1z2DzmiV6Y++81
 jG8FJsfVtdlL7N6eZPuWCJJ8eq8y2fFhLRWg22SiaFRJp5tKvagBdvj7nXvoDZTh2mZn
 /BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533374; x=1746138174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OslDaHmml5vji5p+h0aO4Re5CvOPTyryghOTVR1940=;
 b=NwFyC7gmZpkHXu862is0nLWIGjqyfEcp6srviUHrXEja6rGfWtfoK1WKPbdUmG3ITb
 gDkdQ4pxqIKW3XZqGF5L5sjdqA8SYd4Drht9L7/Za/mZpdVe+F16RED+l6N3jky5Yd7S
 QHl8KHTfEvAf1KI+p8OX2xng92CI196tcTf9LC+/6oyjEVgT4INDf5hgoXFfofSZBDib
 mYwR1b/n1hrbu6DnWQ4C8qvOdnLZ59/Sur22mTUASLh3UC3Nu7N9/nfKJAVDXdC/USBP
 sXJwazkmEVrwOcwnnXAniDwmvBzyo6m+CR74PIRdhROfFQmTz8DH5DJkf62mQpLfKigo
 bDWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiTNevtKkaK3c+ZDz1c6lriLeDa/fs1agrZDKVS1t2vTe1bKzHdFwK7H2xSogQsNGFQlwV9RcORaJg@nongnu.org
X-Gm-Message-State: AOJu0YyV3FmCLmDtI+RQC/MDvR3k/rgmHxwzpC92+xkzVCAaKwhMAcq4
 0J7pt7+CYtNlSr+rMkFNGniWJx6g5jVwdMcIQZnC3X+196P3UFkMV3ICnUJ9WCZAQWUAWnaNksY
 p
X-Gm-Gg: ASbGncsgzxdP7//MVVVFszDo1pj08dCJPVtIJecZSKEpAgSD1GUvK/u8HkmqbWWhYdV
 ReTIdrBqNLOBC203B58Oq4Ur9YMQm9RnSyHaZSab91U+3NRijbCqg5k9WkZQZVgzrHBjp8JC8kS
 I+5bEn8aUtZONRmNXblYLxrkebqd+fLIkNl/IHv+XMuaSvuecnfGliaGb7b14RyBRbibpza8drA
 QYT11eIq8ireTDbs5KAU1tJx2jQSh+zbvLpfJZedjXfaS5kugZToSrJlgAqrvY66Cefwz16jJ5q
 8QjXz7S7aDGVoNLeBGNJaZj9lAxJhhIeLXYqAfS0Cq+4VX8u1A4bCMdKKInXUCplA8SLEEsqEgO
 2tBRZi8DncAYoFMc=
X-Google-Smtp-Source: AGHT+IF8CnB/61HtCBa/S0zjFEETlUaUPAmtSU2jkvAHWNRX544HOjaOGuViFvYC9N0x0osqjbOntA==
X-Received: by 2002:a5d:5f86:0:b0:39c:30d9:3b5c with SMTP id
 ffacd0b85a97d-3a072bb3ee1mr730921f8f.39.1745533374479; 
 Thu, 24 Apr 2025 15:22:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm511485f8f.27.2025.04.24.15.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 20/21] hw/core: Introduce
 MachineClass::get_default_cpu_type() helper
Date: Fri, 25 Apr 2025 00:21:11 +0200
Message-ID: <20250424222112.36194-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/boards.h |  6 ++++++
 hw/core/machine.c   | 10 ++++++++++
 system/vl.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 700e4f4ccf3..cc2f81cefeb 100644
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
     GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
+    const char *(*get_default_cpu_type)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0901a92b32a..ba9ddf1b1f7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1541,6 +1541,16 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
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


