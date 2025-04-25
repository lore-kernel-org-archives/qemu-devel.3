Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88760C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1I-00034d-DS; Fri, 25 Apr 2025 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0Z-0001T6-2V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0U-0003tj-VM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so23068165e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595024; x=1746199824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex/E2xCBWHEai+sxwrZADL0ldrbpBVfhX+RO14sMF64=;
 b=KCci/5Z3h1ztVEMlH4dR6oAA4vHYuNNcduP8cY7DNAbZSdXJQGVHfzhEv/LsSjOg1V
 eRw6htDcKd09U6s3gLicMoQucQJiTlinu9HcOnzjVj7kvhWl2Uj/pe/Y+xWhrPuRJIhN
 ako7VsEo9On5jcXtfzaDU9pJx+Z8D2anP1K7v12j6WVFmyMpBrtRNqQUnIofQY+uWh12
 w1hjEqrzdz3dAVBvBjWK0Ws3aBoVnGCRZVjtgy+zs5qAbnebZakEt9UDxd5FiF/UQIO8
 LIqIZnGsZl5GLe7ojzMA0eeZZFWQt8wsMANDr5CZIwPgXTKMYjYcZkUPTLbYQ1Au1ah4
 qm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595024; x=1746199824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ex/E2xCBWHEai+sxwrZADL0ldrbpBVfhX+RO14sMF64=;
 b=JuFg/KQDkKH26KypswM8bn/ROS/5gN5/l8rrokcC3dgs3ETKlglKT+qGGem37p7duO
 ekaEF2fo2kspfCpYbPqf1VR1oaXvfO+xx37krspgpOK/kLwTzQ+2SNk36fFtxHLpxl4q
 WzVH0b+Jm3M9zp8zF63FCgL4Y1rNUZvKeylLjzbpZX+7YWCyvjZQfzH+Goj71iXchwFw
 Wm74VXhIzJLvdlZdLUAoVXkCuiaGL2gwzS0KIGUC2r5nN7AR17oiA+zxfuWGVhoZzv+Z
 N6qI/+ZTcX33VTDjdmz8rAOunQ1n6ueJz/Zbzg0H7y/88gQku3S0yDA4nNnfLERc2zuz
 DscA==
X-Gm-Message-State: AOJu0Yw/e2huXnMK7bS2C3XMYYzUfHVSLPRA7L2V0Y/AThZXvlUUsAE3
 gZjThMb9OJPsHSAE6vacykc3L3ijk0qoXE3lVV+l3/utULWNsN/Df48VqA951og48uNboqSbh1s
 Y
X-Gm-Gg: ASbGncsycTm4sGBZaHyXPdJJAtmSO5GHcfavcElulVOix2U8ErIdSM4tv5/2rffnm35
 PZrt7FnUoRdE80EKoe6ta5FZC+PQeP3G2SDVJg8Tom5cz8YAARv4xUpHMt7srpTyhcDtiq4lcVy
 XyAQ2z2Hhoj+J3CdTp7EmBle9Sm0oAgT6T6jXSiOnePJN7WC07v8UdMY01axLFxy5U3b+lGzxqU
 NP/5Ew1uS9Wyu9grAqJgfKmDNImH0kWxGapy6hTgwiGCingbEkWpHdgif7bhJqaO1DeFt2W49ju
 JAkM6P/eSWcvL5zkvcry5E0m7zb5Li81HpEqk4Jgfgqlt8ALGTEOFyrpqXaaqi0frNglU7Zkgkd
 vKAtagzhAJFZzzFk=
X-Google-Smtp-Source: AGHT+IFx7YnImKhTUyO79AuicihCgTHhfMnGZGp/CzHOlE9MFoosudDeKbFExWd+FWV6pB5k3BtloQ==
X-Received: by 2002:a05:600c:1e0b:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-440a66ad403mr27267835e9.30.1745595024433; 
 Fri, 25 Apr 2025 08:30:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e47307sm2673782f8f.65.2025.04.25.08.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/58] gdbstub: Allow gdb_core_xml_file to be set at runtime
Date: Fri, 25 Apr 2025 17:28:04 +0200
Message-ID: <20250425152843.69638-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently the CPUClass:gdb_core_xml_file setting is a simple 'const
char *' which the CPU class must set to a fixed string.  Allow the
CPU class to instead set a new method gdb_get_core_xml_file() which
returns this string.

This will allow Arm CPUs to use different XML files for AArch32 vs
AArch64 without having to have an extra AArch64-specific class type
purely to give somewhere to set cc->gdb_core_xml_file differently.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250317142819.900029-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h |  5 +++++
 gdbstub/gdbstub.c     | 23 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6ea246514ea..2a02d4f0789 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -131,6 +131,10 @@ struct SysemuCPUOps;
  * @gdb_num_core_regs: Number of core registers accessible to GDB or 0 to infer
  *                     from @gdb_core_xml_file.
  * @gdb_core_xml_file: File name for core registers GDB XML description.
+ * @gdb_get_core_xml_file: Optional callback that returns the file name for
+ * the core registers GDB XML description. The returned value is expected to
+ * be a simple constant string: the caller will not g_free() it. If this
+ * is NULL then @gdb_core_xml_file will be used instead.
  * @gdb_stop_before_watchpoint: Indicates whether GDB expects the CPU to stop
  *           before the insn which triggers a watchpoint rather than after it.
  * @gdb_arch_name: Optional callback that returns the architecture name known
@@ -166,6 +170,7 @@ struct CPUClass {
 
     const char *gdb_core_xml_file;
     const gchar * (*gdb_arch_name)(CPUState *cpu);
+    const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163f..565f6b33a90 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -565,15 +565,30 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
     g_array_append_val(cpu->gdb_regs, s);
 }
 
+static const char *gdb_get_core_xml_file(CPUState *cpu)
+{
+    CPUClass *cc = cpu->cc;
+
+    /*
+     * The CPU class can provide the XML filename via a method,
+     * or as a simple fixed string field.
+     */
+    if (cc->gdb_get_core_xml_file) {
+        return cc->gdb_get_core_xml_file(cpu);
+    }
+    return cc->gdb_core_xml_file;
+}
+
 void gdb_init_cpu(CPUState *cpu)
 {
     CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
+    const char *xmlfile = gdb_get_core_xml_file(cpu);
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
 
-    if (cc->gdb_core_xml_file) {
-        feature = gdb_find_static_feature(cc->gdb_core_xml_file);
+    if (xmlfile) {
+        feature = gdb_find_static_feature(xmlfile);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
@@ -1644,7 +1659,7 @@ void gdb_extend_qsupported_features(char *qflags)
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
-    if (first_cpu->cc->gdb_core_xml_file) {
+    if (gdb_get_core_xml_file(first_cpu)) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
@@ -1701,7 +1716,7 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
     }
 
     process = gdb_get_cpu_process(gdbserver_state.g_cpu);
-    if (!gdbserver_state.g_cpu->cc->gdb_core_xml_file) {
+    if (!gdb_get_core_xml_file(gdbserver_state.g_cpu)) {
         gdb_put_packet("");
         return;
     }
-- 
2.47.1


