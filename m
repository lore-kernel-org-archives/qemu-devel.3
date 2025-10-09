Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B587CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQP-0008DF-Jy; Thu, 09 Oct 2025 03:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQN-0008Br-46
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQH-0004Mp-Cs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8HYpUdO2P7nAh/MHMViByHQJ/N9zXJCXtwAC6CreTc=;
 b=Zc17l/c1JIlz+OdbgRcQyYgpVIrgPtHbu0xSQfNnW83yDiPK5htVl2JYr8/+DGXVAW9oKC
 ssScmEw9A9wsjwYOIZ57qdL8PNgqAFtBzPPWLCZhe5MEt4mvCpb3Woz24vBonMZgne5p3l
 5a1S2Jj8HFlunWO7sthG8V1gnqOoEhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-brftt72HOnW11E6qbFwZlw-1; Thu, 09 Oct 2025 03:50:47 -0400
X-MC-Unique: brftt72HOnW11E6qbFwZlw-1
X-Mimecast-MFC-AGG-ID: brftt72HOnW11E6qbFwZlw_1759996246
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f93db57449so436874f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996245; x=1760601045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8HYpUdO2P7nAh/MHMViByHQJ/N9zXJCXtwAC6CreTc=;
 b=hMwp8ATFH4FQe2Gh5Gl5zqf1t54UsxXNBdfy3/mOvDmZkzvq9AhWo/6B3XHsowATW4
 Z8Ghgt5zxNhgMVmrW05bdzkrtCNVutXnktjZGmhzmhoEP2tqO/aGhXmELL9wOZXvpyuI
 hIjWA8O/bSnZ+zKxFe8W4EFOTz7GFpWL4R9G8Zz5eOjfytZ7YgXfrMUSij8PQ7ZS0V7y
 DwGsyQQ38rMVAM3cDGysiHndxKgL+HHAEd++/wiKppbdzI1jd9u/AHJH9dozrrE1B218
 zBhzzJksQoZr3etMad9qnht6UXh+vLSbSPJl+fwh6mhEobrOtQBB/IVgD4cXnFKwaRt9
 4DVg==
X-Gm-Message-State: AOJu0YykTHQG4+DkUi7BYSnMkAqoHSRGYBQIQuk2ByxF3es4qSZpU1zu
 Oy7/GDpuBGJVfHnlFULagt3YUYlA80KmNWu1RyT/j8RUJPoj5WbgSgctzWcFiVYtzyMvyoKNfJD
 Jll3Wp3edf6UIm0QJMUxVclBZ5UWDM9xang7eF/23I8fF1uKo2I6LtPtY+ICEIPrx3NV8tIjbVX
 7TsHnDiKdWuzI396n00nceu6J6wyX4rtzkSdEg2gHOf6U=
X-Gm-Gg: ASbGncv9D6q+eY0HO/zT6MTgWMEqRp+NBh7hErhWQrJXWOxNNkOS5zyQmP06/Uymr1f
 HWJDczOZ/Rzxqz/KzNhs8N7Nqecw9jclfyVVkm68KKQQ+bnIn6RYJxjcASP1IhZZwpJnDZJ61Lb
 hJ0sPZpUYQ2icaeF7IBCUshY4dhf/QJXAZBmsZQrHoy+3Lwv9ewC8dnbZIayxZI0BFixyOFcp4y
 k08V42gWo5FG4yBE+4l+52MdM4p+l47/vLrpyXUM7d63wS/QExCVFr8EjcZKWj6L+K52Z1lWhc4
 vmtMG7c1T7FlP6tMsjkYLCwjH146eRbKxENF0r9AyUx4oxXY5zad35GGhgpvzkg61GvEIsz1eBO
 9K8NeCXk6f0PMIiPT4JYlCdtgmTrI+LNgyCPA4uPGVn4yLXoN
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4266e7d44f1mr4180462f8f.39.1759996244648; 
 Thu, 09 Oct 2025 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAKpfSXghO/EWp8z5+s6JW65nAgBB9/RMLk5Xkr+m0p+hGQr11MJJ74krAwxsR/EmUt77D8A==
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4266e7d44f1mr4180441f8f.39.1759996244193; 
 Thu, 09 Oct 2025 00:50:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab960sm33305506f8f.13.2025.10.09.00.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 08/35] target/i386/emulate: Allow instruction decoding from
 stream
Date: Thu,  9 Oct 2025 09:49:58 +0200
Message-ID: <20251009075026.505715-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Introduce a new helper function to decode x86 instructions from a
raw instruction byte stream. MSHV delivers an instruction stream in a
buffer of the vm_exit message. It can be used to speed up MMIO
emulation, since instructions do not have to be fetched and translated.

Added "fetch_instruction()" op to x86_emul_ops() to improve
traceability.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-3-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.h |  9 +++++++++
 target/i386/emulate/x86_emu.h    |  2 ++
 target/i386/emulate/x86_decode.c | 27 +++++++++++++++++++++++----
 target/i386/emulate/x86_emu.c    |  3 ++-
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
index 927645af1a3..1cadf3694f0 100644
--- a/target/i386/emulate/x86_decode.h
+++ b/target/i386/emulate/x86_decode.h
@@ -272,6 +272,11 @@ typedef struct x86_decode_op {
     };
 } x86_decode_op;
 
+typedef struct x86_insn_stream {
+    const uint8_t *bytes;
+    size_t len;
+} x86_insn_stream;
+
 typedef struct x86_decode {
     int len;
     uint8_t opcode[4];
@@ -298,11 +303,15 @@ typedef struct x86_decode {
     struct x86_modrm modrm;
     struct x86_decode_op op[4];
     bool is_fpu;
+
+    x86_insn_stream *stream;
 } x86_decode;
 
 uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream);
 
 void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
                   int is_extended, int size);
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a1a961284b2..05686b162f6 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -24,6 +24,8 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
+    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
+                              int bytes);
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 2eca39802e3..97bd6f1a3be 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -71,10 +71,16 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    emul_ops->read_mem(env_cpu(env), &val, va, size);
+
+    /* copy the bytes from the instruction stream, if available */
+    if (decode->stream && decode->len + size <= decode->stream->len) {
+        memcpy(&val, decode->stream->bytes + decode->len, size);
+    } else {
+        target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
+        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+    }
     decode->len += size;
-    
+
     return val;
 }
 
@@ -2076,9 +2082,10 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
     memset(decode, 0, sizeof(*decode));
+
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2088,6 +2095,18 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
     return decode->len;
 }
 
+uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+{
+    return decode_opcode(env, decode);
+}
+
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream)
+{
+    decode->stream = stream;
+    return decode_opcode(env, decode);
+}
+
 void init_decoder(void)
 {
     int i;
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index db7a7f7437d..4409f7bc134 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1246,7 +1246,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
+                env->eip,
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.51.0


