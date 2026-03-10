Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9651FD88C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05GW-0002jK-4t; Tue, 10 Mar 2026 18:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05GU-0002eu-SO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:09:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05GS-00024F-JY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:09:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso39746455e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180558; x=1773785358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qP6mhvfboagZfdnGf3ePpi/j0YnGinN2WFbaLK9p8Qk=;
 b=FyzJq8ompTB1vnmDeHT7mrlRPVs6mT8Y5Xj8TI6RJxTtTLCHubM8X7wGM2wyUBcWeY
 y8/COXycor8j1zp6j+dw1Kq/sphbVCL3dzl5c5fAESfeVU1G9QV9cFefTmpCUduhbCrG
 XqF22Zk1zRFGhjmqOTyv7E+8hFSr8C16uL0SI2FOr8/Zb1n2YJQkVsBb9uAVPtCywgUq
 axU9X1l0nuXAsNpHEJZBWrpLZEthhF/I2ut0qW5wj2KlQHazN+7kNBtIwTOeS8au9JVJ
 ZCvYCEk0Vn3AtrVRgllbHEGDPmcZcCmTpgkaMYmaYXcf+xRBLE2OES1ZPxskl+L/3iCw
 D0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180558; x=1773785358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qP6mhvfboagZfdnGf3ePpi/j0YnGinN2WFbaLK9p8Qk=;
 b=j73EtwPurIU3zQcRrdeWE7GVpXAf5XGgIokoP88werH+H4pUHEIdCevEvFP36O5hS6
 1OTofX+L17ttE7h1mTJ9/6abk8GctOe5nBnDLKXr8BMMH7VCRtCwv6VIMejLOPbzI6u/
 nBs3c1idEBRr7MGa7R2zZ2uVjmIODFbQ/KgMmMLgpprKq5S84/J9ZqyfHdjXy6leQ7Xv
 VDmujcdYL5pVPu16T9ZuGrmxKdhAjKYh5djryhNq4c28Kxkv2kgjrIQjgYo1QDfFb6lb
 uhdz77BsH0mw2Df9lduG55lbVxC0CGSLbkqugUJUSVsG3ucVZhwX0BPD5wMukNIVxsGW
 se5w==
X-Gm-Message-State: AOJu0YyCIsfYGbPk3xiVgMTi2Dxws6JoFDz18Oy8olI4Zwo8/jzeHXmS
 5vYSZDMv0Y54T3TawEAiJDfOppYN8CUi8Hz9WejmGTJ2kw/HhUkwS9VszVYsae9q99f8qLq/7Jp
 afAPbrJQ=
X-Gm-Gg: ATEYQzxiOukRZ1GeBx11c/vNEtWck9zzUsT9CMB0q4LzrecZV1Fxp8/xX9g0DPpMZd5
 Vsfg2EKvRiKL/IFAFVsDsvcpdA0JQXrS/gXGOvCpRV79aE5Ae0uDXUOEasDDndqnpCQN4k3skhA
 ZkVeJ9G4SID9wS7o0JsUw3Jbj4ADwZf2G0S3BPFIkcidB0DYTYx67kkdjwd+vTjNKgaU+E9XFox
 UuAvhNWNTWY4lM1p4VNVdTnPIRI2xUZF0lnt+k+8K3IGpRjERbfpUF+/H3QlBjwe202SEdaHKLE
 abysqAAL5JPPWuAHl8cQ6xi6Dxcv55Shs0EEqGQCjx8tpZ9ysP5E4pLQd0aEmPVnBH1FENZ5QDI
 3amJr3txslhatR4+qZua4DqeemqtbZxPIqa27c053LPADO94Y4sBLz4IW/cYE64vOYwLOXcW96Y
 /Glvq62EZbHgGkWCfWpyAFdat+u2SW120x5rUIlJk6TSxBGYehmP6pay6I7OoBzNQn6wUSVTyz
X-Received: by 2002:a05:600c:3106:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-4854b10576cmr7933025e9.16.1773180557569; 
 Tue, 10 Mar 2026 15:09:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f406sm101442325e9.13.2026.03.10.15.09.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:09:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 04/12] gdbstub: Add trace events for around XML parsing /
 generation
Date: Tue, 10 Mar 2026 22:59:07 +0100
Message-ID: <20260310215916.55815-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add trace events to help follow how the various files in
gdb-xml/ are parsed or generated at runtime.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c    | 14 ++++++++++++++
 gdbstub/trace-events |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 221951c22b0..5c1a18e055c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -478,6 +478,10 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
 
     builder->feature->num_regs = builder->regs->len;
     builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
+    trace_gdbxml_feature_builder_header(builder->feature->name,
+                                        builder->feature->xmlname,
+                                        builder->feature->num_regs);
+    trace_gdbxml_feature_builder_content(builder->feature->xml);
 }
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
@@ -511,6 +515,10 @@ GArray *gdb_get_register_list(CPUState *cpu)
                 name,
                 r->feature->name
             };
+            trace_gdbxml_get_register_list(r->feature->name,
+                                           r->feature->xmlname,
+                                           r->feature->base_reg,
+                                           r->base_reg + i, name);
             g_array_append_val(results, desc);
         }
     }
@@ -563,6 +571,8 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
         .feature = feature
     };
 
+    trace_gdbxml_register_feature(feature->name, feature->xmlname,
+                                  base_reg, feature->num_regs);
     g_array_append_val(cpu->gdb_regs, s);
 }
 
@@ -598,6 +608,10 @@ void gdb_init_cpu(CPUState *cpu)
     } else {
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
+
+    trace_gdbxml_init_cpu(object_get_typename(OBJECT(cpu)), cpu->cpu_index,
+                          cpu->gdb_num_regs, cpu->gdb_num_g_regs,
+                          cc->gdb_num_core_regs);
 }
 
 void gdb_register_coprocessor(CPUState *cpu,
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 4fd126a38c1..8caee36c242 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -28,5 +28,11 @@ gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
+gdbxml_init_cpu(const char *typename, unsigned id, unsigned gdb_num_regs, unsigned gdb_num_g_regs, unsigned gdb_num_core_regs) "%s:%d regs:%u g_regs:%u core_regs:%u"
+gdbxml_register_feature(const char *featname, const char *xmlname, unsigned base_reg, unsigned num_regs) "%s (%s) @%u +%u"
+gdbxml_feature_builder_header(const char *name, const char *xmlname, int num_regs) "%s (%s) regs:%d"
+gdbxml_feature_builder_content(const char *xml) "%s"
+gdbxml_get_register_list(const char *featname, const char *xmlname, unsigned feat_base_reg, unsigned base_reg, const char *regname) "%s (%s) [%u,%u]:%s"
+
 # system.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.53.0


