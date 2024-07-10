Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQq0-000110-NZ; Wed, 10 Jul 2024 02:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpz-0000wS-Hm
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpx-0000vn-RH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Ql2wQ9TsVXf1SgGfQDPRSm5NqN+wHIJJjqUCwnWnLM=;
 b=PAL1BvbJoJeEb3IZ9g/rHXe6cPxoCHnHEHHHbTQv5EbeId8sZhzv5qzk3k4RxfcsQEvoFr
 rjr6THt2cJOhxuwkvPQ5O9I3HcofrZ2rPGlGVzBtF1aTMtXslFHAJtOGFsnqS3IScRbiTu
 WlTfgQtjZKvPn5p4K0BvMCeiyeyMt9M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-rMBVv1Q7NHKdKnkxgR4H_w-1; Wed, 10 Jul 2024 02:29:53 -0400
X-MC-Unique: rMBVv1Q7NHKdKnkxgR4H_w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso4038819f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592991; x=1721197791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ql2wQ9TsVXf1SgGfQDPRSm5NqN+wHIJJjqUCwnWnLM=;
 b=ni8ogAtxN6GfVhfpvp/Gzie7yXFrUfKM/y98DKpFpqSeky1GelurX/uwW9zMUjpbj+
 kCt41Kgy67piUHwKizc3zfqS8dC379XBu5UHMR9SloZjNEQ1wBtED6mi0WShlWnzt0jf
 VG+we104JqC4tqJRRXX3r+B8NlrnOFOxYoXjBSkbdKNsmz/gWtT2NESq6UaVEDfdgxcT
 g8bdvDu5vk8QZT+QDHMHXph/QdX+MAsDPP2dWrEquptO6pYyx1GdIcm3pDn66VnJJF0c
 VUtn5wWwCi1s+qX/aDKow5MVz/oVUQ5nTsASXATk/xaxyw3n5Ry83db+sq1xmW7MJywp
 UtJQ==
X-Gm-Message-State: AOJu0Yycdl3/4ZpO3e88h6akeD9/NJGWIRKhA6JvdhjZIF6mefcI89d0
 sCwIq3I1+MeG15E8e4PTHFW6aTdcpuLkDfXxCdHhNLMBUhOXm+VheLNUgWKkDn0/9nhzZx8h2ph
 wjo7UIlygxStL2a4BUNA2MhQ7IoV6h9W5X9BLpWdKIHzvfHpKM7bdtk3Bb2xG8Lt0RG7PNfd+IO
 s+FRQsI08CRRU46Uw/f3w5k/yCLv4hPafh4UT5
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr2710222f8f.22.1720592991217; 
 Tue, 09 Jul 2024 23:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwouR3TO5lOWSmKO2x+OIXS3QBTsbFDmj3fcKeeVcSJ9tc6Hpn0lAFPJtC7bk4zCdIJhL/cA==
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr2710212f8f.22.1720592990856; 
 Tue, 09 Jul 2024 23:29:50 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde847bdsm4361702f8f.41.2024.07.09.23.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 10/10] target/i386/tcg: save current task state before loading
 new one
Date: Wed, 10 Jul 2024 08:29:20 +0200
Message-ID: <20240710062920.73063-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is how the steps are ordered in the manual.  EFLAGS.NT is
overwritten after the fact in the saved image.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 85 +++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 77f2c65c3cf..7663e653e84 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -325,6 +325,42 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     access_prepare_mmu(&new, env, tss_base, tss_limit,
 		       MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);
 
+    /* save the current state in the old TSS */
+    old_eflags = cpu_compute_eflags(env);
+    if (old_type & 8) {
+        /* 32 bit */
+        access_stl(&old, env->tr.base + 0x20, next_eip);
+        access_stl(&old, env->tr.base + 0x24, old_eflags);
+        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
+        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
+        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
+        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
+        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
+        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
+        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
+        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
+        for (i = 0; i < 6; i++) {
+            access_stw(&old, env->tr.base + (0x48 + i * 4),
+                       env->segs[i].selector);
+        }
+    } else {
+        /* 16 bit */
+        access_stw(&old, env->tr.base + 0x0e, next_eip);
+        access_stw(&old, env->tr.base + 0x10, old_eflags);
+        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
+        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
+        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
+        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
+        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
+        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
+        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
+        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
+        for (i = 0; i < 4; i++) {
+            access_stw(&old, env->tr.base + (0x22 + i * 2),
+                       env->segs[i].selector);
+        }
+    }
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
@@ -364,49 +400,16 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
         tss_set_busy(env, env->tr.selector, 0, retaddr);
     }
-    old_eflags = cpu_compute_eflags(env);
+
     if (source == SWITCH_TSS_IRET) {
         old_eflags &= ~NT_MASK;
+        if (old_type & 8) {
+            access_stl(&old, env->tr.base + 0x24, old_eflags);
+        } else {
+            access_stw(&old, env->tr.base + 0x10, old_eflags);
+	}
     }
 
-    /* save the current state in the old TSS */
-    if (old_type & 8) {
-        /* 32 bit */
-        access_stl(&old, env->tr.base + 0x20, next_eip);
-        access_stl(&old, env->tr.base + 0x24, old_eflags);
-        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
-        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
-        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
-        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
-        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
-        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
-        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
-        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
-        for (i = 0; i < 6; i++) {
-            access_stw(&old, env->tr.base + (0x48 + i * 4),
-                       env->segs[i].selector);
-        }
-    } else {
-        /* 16 bit */
-        access_stw(&old, env->tr.base + 0x0e, next_eip);
-        access_stw(&old, env->tr.base + 0x10, old_eflags);
-        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
-        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
-        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
-        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
-        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
-        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
-        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
-        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
-        for (i = 0; i < 4; i++) {
-            access_stw(&old, env->tr.base + (0x22 + i * 2),
-                       env->segs[i].selector);
-        }
-    }
-
-    /* now if an exception occurs, it will occurs in the next task
-       context */
-
     if (source == SWITCH_TSS_CALL) {
         cpu_stw_kernel_ra(env, tss_base, env->tr.selector, retaddr);
         new_eflags |= NT_MASK;
@@ -418,7 +421,9 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     }
 
     /* set the new CPU state */
-    /* from this point, any exception which occurs can give problems */
+
+    /* now if an exception occurs, it will occur in the next task context */
+
     env->cr[0] |= CR0_TS_MASK;
     env->hflags |= HF_TS_MASK;
     env->tr.selector = tss_selector;
-- 
2.45.2


