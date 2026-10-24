Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E5606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=ZjJl96ZV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVnT-0007OZ-Fw; Sat, 24 Oct 2026 03:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>)
 id 1xKVnQ-0007OM-3j; Sat, 24 Oct 2026 03:04:04 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>)
 id 1xKVnN-000835-Vd; Sat, 24 Oct 2026 03:04:03 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792825438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UybR/c4eJ3nqQgKXE31f5NtX/slPcOQRxgAYRyW9/RA=;
 b=ZjJl96ZV0AVbFzwZM7GkY3LGEHXb0Z0w5sS3wVdCNrIq9awD6B2uiJX5p+hYSyWJyBmq7c
 Hu+5KIRGVQXYKOfRUCHW+sYY7eb0QmgwtkeyWvUhOUeRkAWKXOAmfGytqxGOoU2xJ2/oCU
 JQNKldy3WQCvxVAaNlcXQLp8V6Y0/y4=
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Stian Halseth <stian@itx.no>,
 qemu-stable@nongnu.org
Subject: [PATCH v2] accel/tcg: Do not chain from a TB freed by tb_gen_code's
 flush
Date: Sat, 24 Oct 2026 09:03:47 +0200
Message-ID: <20261024070347.1202239-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a serial context, tb_gen_code() flushes a full code buffer and
retries in place. cpu_exec_loop() then chains its last_tb, now freed,
into the new TB. When that TB is invalidated, tb_jmp_unlink() follows
the stale entry and qemu crashes inside its SIGSEGV handler.

Drop last_tb when tb_gen_code() has flushed.

Since commit 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb
chaining in user-only builds"), user-only builds hit this easily,
e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.

Cc: qemu-stable@nongnu.org
Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Matt Turner <mattst88@gmail.com>
---
v2:
- Drop the second Fixes: tag. 25e5c6a320db only makes it easy to hit (Matt)
- Cc qemu-stable (Matt)
- Rebased on master, code unchanged

v1: https://lore.kernel.org/qemu-devel/20261023113245.562358-1-stian@itx.no/

 accel/tcg/cpu-exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5b4bca5084..600e8c5fa8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -968,11 +968,17 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
             if (tb == NULL) {
                 CPUJumpCache *jc;
                 uint32_t h;
+                unsigned flush_count = qatomic_read(&tb_ctx.tb_flush_count);
 
                 mmap_lock();
                 tb = tb_gen_code(cpu, s);
                 mmap_unlock();
 
+                /* tb_gen_code may have flushed, freeing last_tb. */
+                if (flush_count != qatomic_read(&tb_ctx.tb_flush_count)) {
+                    last_tb = NULL;
+                }
+
                 /*
                  * We add the TB in the virtual pc hash table
                  * for the fast lookup
-- 
2.43.0


