Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD210C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcd-0006DB-JL; Wed, 23 Apr 2025 05:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc1-00052F-5h
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wby-0008N7-Ml
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0SUlbe8R2I5US+HJHkeWwOiX0tbQlzoXs3rWkoTkwg=;
 b=Zz2r38Rgywg/6Id4jZKxUYish+kwwhGSkUqw8sRy5AD2vSYuRdXuNU60YqOOLLAmqEQY9p
 uZzJ2yvKTGmZPGAdaq5aEbpY+3lVK1S1qkuuRFtMQpvs8qtpOOZr35wMaY2HnGb0la8vnA
 k8rT/eTOBWLnkfg0Q3USU5hF+ta8YpE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Z7Xk7l3yPxaWzIT8CXo1_g-1; Wed, 23 Apr 2025 05:41:44 -0400
X-MC-Unique: Z7Xk7l3yPxaWzIT8CXo1_g-1
X-Mimecast-MFC-AGG-ID: Z7Xk7l3yPxaWzIT8CXo1_g_1745401303
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e5c808e777so5167500a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401302; x=1746006102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0SUlbe8R2I5US+HJHkeWwOiX0tbQlzoXs3rWkoTkwg=;
 b=PzMQygcjEzkJYgGwNWR5S6OQUagU+n6D+0/AiTMLs47jUF90piyG2c2kYgGda3/HPK
 D21XF1aScpBBYcmdJs1CcXN72G5Ii6/6dQ36gQMtaGsQZuBLB6MLKhfMwmg0gwL5I2b/
 82MweRCUoWnpHIzCEe2LvPi8w43rUu1TnpkNHudeqCU0FEAk4tYP5+vFUUqfQ9QBXnDv
 oAoev3SYQ6FhNBXjZCPee1p/TjcO+/DviRpmqlxwfrMcaw3Px8iT3Rjxu0O26G5jTBN2
 kPbDZqXmC0DGpka3t3O+G1m8krMu6ZueIz5R5EMPPmyIhpKVPH2QLr1OPLjZFiozup+j
 2BsQ==
X-Gm-Message-State: AOJu0YyLrI/spa/zdnOcYgGewBhDp9bw/uUrFSc6yDxsbk2VsrY95wYh
 K67IDf/JjbYGyw8Lzy8nv9f5CMI2ExogpwCN6m1BpLpYhZprc06Mjm6YfDLSxevbGwO62XGIasW
 6caZ21/FsLCuHxik7Tnrevai790BKWrJ9z95+q0NpiNevt79klfyVucfzmV/0n7vubCbBxKj4YC
 Zyq44M0LE+toJJ4yihBtsHSbvdPKX4bhp/Fjzf
X-Gm-Gg: ASbGncvJh0t2ICueztKyAG9Y1lr4XTDpRp7sX36AnvbqTW8mhBFzrTFU9K1xxCd4uUN
 yG7RUNZGZ8jnkAZUwQIKhoFnxX24KuCvtFmRPuRAHkgF1nAgCe/aEeEiOFl05+lgLh03Zn6LO68
 vNdKIb0zf6ZIZ+hUIuxb+jQtZLcmaagBHtkzvM7ucpwM3YigFEC5OOpJR3FgXv8kndBWbA2rd5J
 j1WpAPBIXKoXGOOIpPKI1lmaXmnCTyTiyCNlxTHm+duMi4MSOQKEvHtDtApyPwB0Z+ZbCn8iQH9
 +o7u9oZVU2zbhCyX
X-Received: by 2002:a05:6402:1d4a:b0:5f4:9017:c6a1 with SMTP id
 4fb4d7f45d1cf-5f6285e8cf8mr17274965a12.25.1745401302303; 
 Wed, 23 Apr 2025 02:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6//6dHMHXIDmD5wU+GcaR35UpRorXNsOPjlf96JcULWAth4gTy5Gr6kvaBwl8dHPZ/Rl9CA==
X-Received: by 2002:a05:6402:1d4a:b0:5f4:9017:c6a1 with SMTP id
 4fb4d7f45d1cf-5f6285e8cf8mr17274904a12.25.1745401300859; 
 Wed, 23 Apr 2025 02:41:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625592cffsm7130750a12.35.2025.04.23.02.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 17/34] target/i386/hvf: use emul_ops->read_mem in x86_emu.c
Date: Wed, 23 Apr 2025 11:40:47 +0200
Message-ID: <20250423094105.40692-18-pbonzini@redhat.com>
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

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-6-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index e59a73e00d5..7b816b5a1da 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -184,7 +184,7 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
     return env->emu_mmio_buf;
 }
 
@@ -510,8 +510,8 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
-                 decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, addr,
+                       decode->operand_size);
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
 
@@ -620,7 +620,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    vmx_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -645,7 +645,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    vmx_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.49.0


