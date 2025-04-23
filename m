Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4C8C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcj-0006bn-Cw; Wed, 23 Apr 2025 05:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc4-000574-7D
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc2-0008NR-38
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OT4XQr3P98GwFzQI0F4wcCbYrMCD1ziXjFmYKeB1AUc=;
 b=TWa0zkxcMyJ+XPQ+bYEjcf6Ohlf4KgXC88vIxAhwRVd3Bbwt9glRpxv0exssvRMvQ6oc6A
 GptXZXYrgTPiYljkKUuZRAJHmrU6yaIDIooAKWZ1RQ1YokPOSHPDyQ2pnmLc7tPdsfloPe
 CP7GBZjLfAK+vHEkRqHLq73FhAVH0wI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-PhkYex-MNxKb8eVhch9MHQ-1; Wed, 23 Apr 2025 05:41:47 -0400
X-MC-Unique: PhkYex-MNxKb8eVhch9MHQ-1
X-Mimecast-MFC-AGG-ID: PhkYex-MNxKb8eVhch9MHQ_1745401306
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso290113266b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401305; x=1746006105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OT4XQr3P98GwFzQI0F4wcCbYrMCD1ziXjFmYKeB1AUc=;
 b=nZh2r5rBeSykAwf34ouWm6jV5Km6whyEp0ardd3JmDiRiLh6dIj4f9q/cDhZZMGifT
 2SPJnNkWeNxkhTGGpi/wocr7XslgKlg4Li/kWOrYUsYaxMkkfGpmKwJZZn6BK3pLz3KE
 GefnTw/BVoa+9I/KEzCx1ihApC6gxo+4iI8IqcOOskga5Akd0JLbtXCvsdsYc6liJ2mc
 CWC8mY1XvWRtIUvoDYok1YwgcN1iYaClWyC6MG3OAp6Fq6OuLWgp8iEe+hJZEUHXC4bY
 3wd5pzkOJxMFnm6EcaMO88+TjSbkDxq1L5xzT2CpcXS5hLLlAwxS/6yNSdMm/XpQOkBE
 Qebg==
X-Gm-Message-State: AOJu0Yx91J1eC2z6za7KhHJy/W8R6gbCIl0aRtFy5cHuKqEaeCZzEa4T
 AAsJJj4kUXfMceJqp5LGpI6MXhJWnqm28yRFDePW31kwS16O1ak6k7AikalFTLNyiMRpr7AnVZv
 K0Zb/KD7m2gFcRw5DD2k0QKbINhMYeJ+1aMTIy4tXAoWtkUeFYLwYPgLtlB2UBZUy7ch0kQaKXb
 B70pV/sVvKthknMVX7BWxZhGb/SQ+41j03Ks6t
X-Gm-Gg: ASbGncvcx84EzXRpe7Mvfp2W4tatkM8VpTLOx01Wy7mLAKhbwEMwJc99uAMn0Z4SSeT
 hb37hIMRa/p0wGUpZoqBZwarBrq+EXiz3GzT52C7eKZBYojDYYO5wuZHXVFdmZ7c0QhBd5R/Mdv
 mLl35Q95meDel3e8fxeMJMNISQDSBWGhc6rswUnCu+o6MEGft31ZsSS9VrH8mw2MwA5SnC+EPJW
 lbHw79dQI8jWflE8xcbAm0WrJcSwHBKPnxRWfCFov7myE38bRySszfQH2/JF13gIh78R9+h7HE7
 nioZnl6qb78jsTBB
X-Received: by 2002:a17:907:9801:b0:ac3:48e4:f8bb with SMTP id
 a640c23a62f3a-acb74d655d9mr1913821666b.41.1745401305363; 
 Wed, 23 Apr 2025 02:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSRrsLlXLPQgaCjy1C1tCFn4YRshcCSrTO+ceHqCcnb4S9oa5iV93Alnm5Klc0Zi9yo/IeMQ==
X-Received: by 2002:a17:907:9801:b0:ac3:48e4:f8bb with SMTP id
 a640c23a62f3a-acb74d655d9mr1913819966b.41.1745401304895; 
 Wed, 23 Apr 2025 02:41:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefd8a2sm794056066b.90.2025.04.23.02.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 18/34] target/i386/hvf: provide and use write_mem in emul_ops
Date: Wed, 23 Apr 2025 11:40:48 +0200
Message-ID: <20250423094105.40692-19-pbonzini@redhat.com>
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-7-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.h | 1 +
 target/i386/hvf/hvf.c     | 6 ++++++
 target/i386/hvf/x86_emu.c | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 40cc786694e..107c1f1ac86 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -25,6 +25,7 @@
 
 struct x86_emul_ops {
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1cecb765952..e4f48a79fb7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -242,8 +242,14 @@ static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
     vmx_read_mem(cpu, data, gva, bytes);
 }
 
+static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    vmx_write_mem(cpu, gva, data, bytes);
+}
+
 static const struct x86_emul_ops hvf_x86_emul_ops = {
     .read_mem = hvf_read_mem,
+    .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
 };
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 7b816b5a1da..3ff41c35d89 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -179,7 +179,7 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
         write_val_to_reg(ptr, val, size);
         return;
     }
-    vmx_write_mem(env_cpu(env), ptr, &val, size);
+    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
 }
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
@@ -489,8 +489,8 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->emu_mmio_buf,
-                  decode->operand_size);
+    emul_ops->write_mem(env_cpu(env), env->emu_mmio_buf, addr,
+                        decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -596,7 +596,7 @@ static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    vmx_write_mem(env_cpu(env), addr, &val, decode->operand_size);
+    emul_ops->write_mem(env_cpu(env), &val, addr, decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
-- 
2.49.0


