Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BE4C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xi-0005cR-Ir; Thu, 24 Apr 2025 18:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xf-0005Qo-Fg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xc-00011i-KJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso7683785e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533343; x=1746138143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjO/3zXTBwtw4qfy03dgjkoTna4gNBd/DkBFY/ooPAM=;
 b=C5tkt62l9CZ0bkpv2+o7OVUgM1VBncxCGi4Y0RqXOMGXLU58+drMnxv8g+6ObMlpai
 sgChAo/oqW5zN3P+ngt6lwkB8XY7JytEDM398pCyO2v1ow3NIOWjPe41zjOjkwEpYfwT
 IHzEOQXDsaR+wI0PEmGhiFJfHGlhzgm39MVVqpGI+SPPUUJ9eJsTxEGamkjkBbLDkGnt
 1ASI1b/nKeEEEITATyFFjVs7n8/fa8mzNI1lJCwiHwb/fF5P3MoHKBk48euAD7uYWHrH
 LcJK1a0gsJfVSzIXNu563xHSE253mYlNjWnVeazE3XaSte/FLOO9PS624gqsKcjSh9sV
 U44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533343; x=1746138143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjO/3zXTBwtw4qfy03dgjkoTna4gNBd/DkBFY/ooPAM=;
 b=fnLtlUvgqQk+ooRoxrN5jL3DqNFbokSVhTMpiPldUQGgxBtUtsOEBC+bogYCNEgQNh
 8HtZIStG1vhF02dQTO56v55OZZ0lMMb38huVMygNvYPXqLa3eBCRu5UxLTXp/xQoy0pA
 v3jYoBL6kPepUyWDV33tZNKmCRB4DDVR26/UxxcFYApHpzxRmfpyKnllFdIuDqD2GBYP
 Y7eGNyjDeAdX6HJsuuV5F/+eHdzmKS36ZTFbk2Xd4PRFF/NN1JbEq8s7O0amY5LqLPhg
 skO75O8l8fp9gNKi6h96GZQ9+2lSeoSIp/PiytCc78MyLWVxpK6vkvSGBXMjaZ+uBj9H
 0+/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq1IbzZWi36XpCiyrDHgfTGeGJiBM3ahaZZ8O3zVQ+csQvnC7RvOvOYExf4tUnH4LSI7/u4DTWJk0v@nongnu.org
X-Gm-Message-State: AOJu0YygDKA/wKWsyudZbJIVKIxnLqPO2BV6fKzcOcKiDF6ExR3C5TSr
 UVt/Yub5DcsctosUYcuST49BaffLUzIhS4jm5hlSrfPU1Y+JnXYxHrnAsOKY2Gc=
X-Gm-Gg: ASbGncvgvATE1+dVSYxLDTXFUIQIqLYkJuSqYRHZ9KTOsH/x6FkGameYrazTWyIXBi5
 ++FHPUXpLcu2qrZD9V2LvcbN+P3t3WKuVRUhkCTcJhlI1SUiqHlC9Dy4fNbKSfp7U/2TqAHH8zf
 3alAJwig00TqTYpUY2b6DT3xdIKSGSWE3r02IrX2QUa0rMAMNKgRyuwTflLPaOeLIQLHR21667u
 772SGOeZ7SHo1iiez9yLHiTtfLTJFWxbFsse/ywahiyrokNpqT8MMdnwnbiJWTqZPWp4vLYBqlZ
 WXrnlT4Bi6q8ecNb9Kzsil2VLHtaMTuXY3gi+B8mL72LL+XhtsmkQlaJYsCHd7hntq0Eqq4YuRE
 duCI2IQijw0vjKSM=
X-Google-Smtp-Source: AGHT+IErnv200VLFmcJzWMnXR916HjA7iwRKeQQREJLyO3L9GzpZfiJzwIcZjGH0jSI61cx58/XZMw==
X-Received: by 2002:a05:600c:35d3:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-440a3108c00mr11585625e9.10.1745533343212; 
 Thu, 24 Apr 2025 15:22:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a152csm36281065e9.12.2025.04.24.15.22.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 14/21] hw/core/machine: Allow dynamic registration of
 valid CPU types
Date: Fri, 25 Apr 2025 00:21:05 +0200
Message-ID: <20250424222112.36194-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 hw/core/machine.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3573907d597..700e4f4ccf3 100644
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
+    GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..0901a92b32a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1581,6 +1581,32 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
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
2.47.1


