Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BDDC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcI-0005cv-5X; Wed, 23 Apr 2025 05:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbs-0004gL-TZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbq-0008MD-QM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MNa0JBZJFB5f+SaIpMmEEmSw19wZGPP2kb0KycL6UA=;
 b=LKmzIyfH/M5UeHr5PVQ+nnefymo3nxuggb6dzgrtErHCyIcqf06+GraPJrbU8A2oBDq/5y
 dQ5Y/XorYhKFFenzpLJLyuNrI8ukc8P489J/bz9he1nCxf/FP/OR9k26/s6/FPmmJpP4xf
 wgq7jY2YVy5vJZ0hit1QUwQi75P/tn0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-P97nW155P12cGvVfvF2hBQ-1; Wed, 23 Apr 2025 05:41:34 -0400
X-MC-Unique: P97nW155P12cGvVfvF2hBQ-1
X-Mimecast-MFC-AGG-ID: P97nW155P12cGvVfvF2hBQ_1745401294
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5f62cbc6d5cso4816555a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401293; x=1746006093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MNa0JBZJFB5f+SaIpMmEEmSw19wZGPP2kb0KycL6UA=;
 b=cOCbYHAQYwIT/AQMUwK829XINm4+SPDFNX7tN7dK3bqRPs6jxCQ+QZhdPnmi9eLiw3
 kJA4nq3PgtRqVo1iiaRpY/OsybOhrYiKZKTFz5Q31cFAyHQ2Tk3MrnoO+eihGT9l9p8k
 R517kslH0ok84OW/m15Ggyv6POSwIPZzaBttwOca7j6Kg/6FABl8lIx9G8KZkFli2dpc
 3Mg3B3HKBKk4HACLA0z8pGiLddziwQ/SS3+XvSiF+nMLj526Uwn0DPkDwdvJhI48JFXm
 xp+SQmcUNJHvJheRvSpToNXeC2nj+K3EE3gc7RkoIS72yZy+7SG1EeWxxnfs4QCgvG1R
 Lavw==
X-Gm-Message-State: AOJu0YycrlgJoUoUfkLKVyLXGSmskQaN85uYuz8961gsnW8wZozYFVkK
 a3noA/VS1mlPjK9+qQftVUn6/6CNNpFuwiXW6lk9I4ShTPlNNqaH2QsUMs4Ew2azRqtQTvrNkOx
 pE1YflBEO0mw5Q435ks+WocaxeZA17PSJkIuAwq8KMekSz67HJf45qevXMjpB+713oXzOhEmL0R
 3GHa5azLJrTqJJmfTW5pgWdqVE+GdQnhwc2Uen
X-Gm-Gg: ASbGncv1Mam7U/Z00BYWzvIGpgyYGIT/fVOU4yB1NzLfoQ1NBQ+Jqls4wtyTgq7xiLQ
 RJW+IbzpvBIfwS6/YNZiSq0/b0Orc1r4fpp6oZUx+6Cpe5CTayS1B8Zt5cd6/3e+3D8hcikTUVy
 L3J1IEHCDQix9baOxW1h1kPqmgAki2Tff64cJSD+1DDz3NpihnOWxA9AYNNYWI1lweTN2jNi2vH
 IEbAhBG6l54TzpNNQU4SNIb/AfB57Iycf4OpRr9zOb2WSPJteONy8lnkfwGfMq9Adc6JDH5OaNo
 CgP7+w+0z8ZLXYSg
X-Received: by 2002:a05:6402:2803:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5f6285f43f8mr15152593a12.30.1745401292904; 
 Wed, 23 Apr 2025 02:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN4SxggOAzSMVJ84hhhC5oPJPpTkR8NCheMS3WQMooHJOJMRZVnhLJKtV3fGqUP+4mA8Nryw==
X-Received: by 2002:a05:6402:2803:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5f6285f43f8mr15152575a12.30.1745401292452; 
 Wed, 23 Apr 2025 02:41:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6258545d9sm7222316a12.67.2025.04.23.02.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 13/34] target/i386/hvf: introduce x86_emul_ops
Date: Wed, 23 Apr 2025 11:40:43 +0200
Message-ID: <20250423094105.40692-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

This will be used to remove HVF specific code from the instruction emulator.

For now we only introduce two hooks for x86_decode.c. More hooks will be added
when the code is refactored.

The emulator initialization function now takes in a pointer to the ops structure.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-2-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.h | 10 +++++++++-
 target/i386/hvf/hvf.c     | 20 +++++++++++++++++++-
 target/i386/hvf/x86_emu.c |  5 ++++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index bc0fc72c761..1422d06ea18 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -23,7 +23,15 @@
 #include "x86_decode.h"
 #include "cpu.h"
 
-void init_emu(void);
+struct x86_emul_ops {
+    void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
+                                    enum X86Seg seg);
+};
+
+extern const struct x86_emul_ops *emul_ops;
+
+void init_emu(const struct x86_emul_ops *ops);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code);
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9ba0e04ac75..03456ffbc70 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -229,6 +229,24 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     return hv_vm_create(HV_VM_DEFAULT);
 }
 
+static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descriptor *desc,
+                                        X86Seg seg)
+{
+    struct vmx_segment vmx_segment;
+    vmx_read_segment_descriptor(s, &vmx_segment, seg);
+    vmx_segment_to_x86_descriptor(s, &vmx_segment, desc);
+}
+
+static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    vmx_read_mem(cpu, data, gva, bytes);
+}
+
+static const struct x86_emul_ops hvf_x86_emul_ops = {
+    .read_mem = hvf_read_mem,
+    .read_segment_descriptor = hvf_read_segment_descriptor,
+};
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -237,7 +255,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int r;
     uint64_t reqCap;
 
-    init_emu();
+    init_emu(&hvf_x86_emul_ops);
     init_decoder();
 
     if (hvf_state->hvf_caps == NULL) {
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ebba80a36b5..c15b5a7ca85 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1231,6 +1231,8 @@ static struct cmd_handler {
 
 static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
 
+const struct x86_emul_ops *emul_ops;
+
 static void init_cmd_handler(void)
 {
     int i;
@@ -1253,7 +1255,8 @@ bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
     return true;
 }
 
-void init_emu(void)
+void init_emu(const struct x86_emul_ops *o)
 {
+    emul_ops = o;
     init_cmd_handler();
 }
-- 
2.49.0


