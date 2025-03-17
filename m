Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B56EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSD-0000da-Ra; Mon, 17 Mar 2025 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS7-0000Yx-TN
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS4-00018P-Qv
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso23338305e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221703; x=1742826503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+SwrrX67kenI+BYFfzChB1e3tHX2NRLJrXjCUBc/EtU=;
 b=NaaUKEXZCPw0AG4v7+OB3EqnKQESV3Yi/XxS8n+cigLg9qEMeRKtON8s1rqQrceGRX
 jM0r6tOiXJLrDBrVDSXs/sLymbbp8isKMPYWs/rJ00uMNBTVgguf/FSlKsjTRzUBse++
 IZEO4Svtl/Kf/jxEIONwx+Q0SHxyoX9QjXF3oXjXTwFtzwMLXtV56d+WVxicPBUjNvZY
 RqIwoYpt/ElzST+4Tq6gM4rVHAAg+8vsNyJ+Hfm5DYaz3TUDBZSy0o45poR/+yyF2Ba0
 S0rKodHHv2xit7ZhQCoCUnuhXLrpiucyjhTth/umYHyqA90h7GJB/HbpLY8yZkD8aRAq
 5lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221703; x=1742826503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SwrrX67kenI+BYFfzChB1e3tHX2NRLJrXjCUBc/EtU=;
 b=eu1g7brn+S3GPuIMsufcsSX/S85m9W5Bsr8YMjQ26GbMOpy9gTLEWRrZZXhFFCxbHj
 2jY5ra44TpjpvuYH0g6FauVZv+V6R9EHld7zhA/tLBSpMQXnwG7lEJ6mQRKshTN6bYRx
 2s5yqb8iECv1G19xPzSwzCuNRJlIEZy35m9w2wHiTjpewQb/vPjmZmz95kiVijpdV461
 oBLCmIrk1AkRA4QiFIscWIimz2WfXCgIEjJyHc2s1/fvTv9rOYYiefR9WnsT7QPxkS2V
 PJD3mDruJ6brUrEOmiNKF0AbCqPb3mv6hnWdJxhu0smPIqp9g11bFd86Qaf1xaxJGnsX
 Yz8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLhvlff95DWhUlCcxuLj+W7nfpEwGOvIv0p1ORGMR4+mbe9QjARFEnPot7Qilm8RTi2oN4o5joNYp@nongnu.org
X-Gm-Message-State: AOJu0YyF9OoJYU604uEWkqeStNt4tsdPHapkzO0acJrH6YlcycPnI+o9
 YD1IKY9j+cpEUkCOZXS0Hzwj0QsX1VqRAvzGf0ulCIJpmbHZQ6CEQaDmtEyYrfk=
X-Gm-Gg: ASbGncvmiZmyPDh64QedVMBoOkPOW1PLOiPco9ppXk3mS7uLWU+X1Uwj++bf4abf0IF
 zuRASRr3M3HfGK0DY0S10mMExLvi90Cymotz4Zf7koAEgkHkZ6OBCg+rH/iDCznt+2lsDoQIWFV
 A72r23mT5c5FnlCdzzggSho2itkNjoAGAX1yUfn/R7HNp0qL5opSAK0gk07Ww2ckb5wpewD7vDV
 4UpRNlL1qfQlPcpb+v3y0aJ0KUwWlSKNvHggt3Qu/I//n1KP9lDG6VOA8wkT2iYoeRH8MDMFj7t
 3MaOIp4a/XxzonI45OBSCbCmn4TE65c2XRtHkq+/YAwW503NJRo=
X-Google-Smtp-Source: AGHT+IErkAhhdXBKho8GPlk0wYiIcg5Ye7a2sQXenDsQmAoDyf4+p9dqggPgZyjl8PeI5Virdqflzw==
X-Received: by 2002:a05:600c:3b8b:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-43d1ecb13camr135691515e9.17.1742221703155; 
 Mon, 17 Mar 2025 07:28:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 2/9] gdbstub: Allow gdb_core_xml_file to be set at
 runtime
Date: Mon, 17 Mar 2025 14:28:12 +0000
Message-ID: <20250317142819.900029-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Currently the CPUClass:gdb_core_xml_file setting is a simple 'const
char *' which the CPU class must set to a fixed string.  Allow the
CPU class to instead set a new method gdb_get_core_xml_file() which
returns this string.

This will allow Arm CPUs to use different XML files for AArch32 vs
AArch64 without having to have an extra AArch64-specific class type
purely to give somewhere to set cc->gdb_core_xml_file differently.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/cpu.h |  5 +++++
 gdbstub/gdbstub.c     | 23 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5873ee5998f..140d8a0bd79 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -132,6 +132,10 @@ struct SysemuCPUOps;
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
@@ -167,6 +171,7 @@ struct CPUClass {
 
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
2.43.0


