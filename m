Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53790D3C546
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4t-00055v-Uw; Wed, 10 Dec 2025 08:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4S-0004sH-Gx
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4Q-0003PL-5r
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T58pmygptBEW1S74SQK7LzWey5RYMiEFbwtFfeU0U9k=;
 b=V4av+D4h0SBfw1AeXA10m5khPMaGq/6sC3B7ZKnLI9ZizHubrHB7xcKzbLvr8xfI1RFXe5
 D+0eztcVQkyquKVEvbRfaFMUnP4+S/kep4Up1bpXyqg6eS1r59QdKJUNiFsUeNpQMZgYZq
 OIhse7JtwxzpudfUz2tlPQwNyAWnRz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-9l25pSSeOfuS8lLkIPfhZg-1; Wed, 10 Dec 2025 08:17:28 -0500
X-MC-Unique: 9l25pSSeOfuS8lLkIPfhZg-1
X-Mimecast-MFC-AGG-ID: 9l25pSSeOfuS8lLkIPfhZg_1765372647
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42f9e62b4feso489617f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372646; x=1765977446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T58pmygptBEW1S74SQK7LzWey5RYMiEFbwtFfeU0U9k=;
 b=aQ5G/HFAwz96e74xPtbZv03cmfMfRBwut1TrkDRQ+3W4LGz8yhrZfYGkzZPrHnZVvW
 WUm/hBKvwOq4XxySsHuBFHRKa7aV5ZHph0jjWeHCtfBpksSbRl89An0JYNX1ityypxOj
 gzLL8TDK6HZSzIvxs1cKS6z6PChSV6wTjCokTJtDCFbK6mGsDbwCbvg3l27TY9+zWDFL
 APt29t7tf5CXT4NLk4ZOcv/bNo8ZFuSpBPkVca5fJBsnbpJVEd85P8rj7C0KMs96V1xU
 RqfLqiK7JSDPWDFRxRe588zXUkmKFWqVMLJF9BARXKTk1Wp6g45qqehF0uoHqdK5/ppz
 c3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372646; x=1765977446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T58pmygptBEW1S74SQK7LzWey5RYMiEFbwtFfeU0U9k=;
 b=fMyo1CxOBmth5bwmFtpX/ZyhcAGQRJE3BlFu7YCuNapy0jwz5TcgQt/uoQGY8u3823
 JN/OGjxzejYu2QtiUzCFIvyoIUtH/9LJ10pztvLrkiSBRcah64Of0g97Xo1uiCu0lum9
 5Vy619+k8xJWstChgGG3veB6DJkasWp9IjVw5LxC1Xsv/QrH5s5Ly5PSjocJGjPZTmy0
 xoNQb3V8SjIUw0oiKSsGsakmnjB3CX55vPBYhM8HKrRRzMr81u9qHEfQLxitM5VzCH/0
 wOq5N2r6XvtoLBo9Cb8xgesosjDdqUIXAOTIuVRyVSrZe+sYg4sBTLtMBsrRZEqEHSsf
 dRCg==
X-Gm-Message-State: AOJu0YwihvBIi+j94GnwabJqP3Y5TziL9yjwB8n4qzZ9hg7Cg22DeMyc
 Kly5Z4UfOGp2AMqTUYGIA17mRXALwhM3DkNX2MeNHOXw8BRTYtvsS6nWVleGwxtF5OIv+8H8Xmz
 bGdeaYkF8E03vJ44FhUi5GoZck0VduOgGwi0b9Y5jqIRW8+WduCTUTuP9pEWWULn1OP4bMU1XXN
 bq04f5nRkU0+ZSkCeryh6mT0nmY/IwDzmuLHUn2QjQ
X-Gm-Gg: AY/fxX7vALTEYt6xdAmFyA8/gIGtoXFTXZuI9iBCFe7sFfJXIXN+0lpghGxZGEUTFzN
 d7m5zUeFCnwBms/spfCytggZsqKGgBXq8zG2hOtFCML1o4xAhQJgStTSB6wt6FSteb4kuUtRi+w
 ravjcBslZr+SBoTq9ac2X33RkzoTGQFn5fGbmN/roSByGraISbcYuRyibjTUdlx3+Z93fEOTCKR
 a8m1Oe3f0K++GWOQZgfy0gB92c76NFu4kl/d1vzD+K2BT64OofReiyE2g3rnnPVRD4Ol3iQj/Sd
 VSC91tg7vWVE7axlPpuHpy/lmpjYv4p5yOOt9IX5KRqJb56P5FbOvnWFIFOgK98ZWfvJX8STm9Y
 3hrpuojr+WoJ6nvwWEV5+UISVq7nv1i2sBed5Raa86yodV5wm/KrJq/KAyPfimNhSRnPlD2cRaT
 cl5ANRH5UKf/LCI6c=
X-Received: by 2002:a05:6000:240f:b0:42f:8817:7ee with SMTP id
 ffacd0b85a97d-42fa0872da8mr6469339f8f.31.1765372645829; 
 Wed, 10 Dec 2025 05:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs9Y47lAuZfMZNcrNi6UeA02rRHu5q5aUlw+v/5J6llmAv+4Fj1bHvuHGkXiTSgbP7vJhTuA==
X-Received: by 2002:a05:6000:240f:b0:42f:8817:7ee with SMTP id
 ffacd0b85a97d-42fa0872da8mr6469282f8f.31.1765372645000; 
 Wed, 10 Dec 2025 05:17:25 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331aeasm37524162f8f.37.2025.12.10.05.17.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] target/i386/tcg: move fetch code out of translate.c
Date: Wed, 10 Dec 2025 14:16:53 +0100
Message-ID: <20251210131653.852163-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Let translate.c only concern itself with TCG code generation.  Move everything
that uses CPUX86State*, as well as gen_lea_modrm_0 now that it is only used
to fill decode->mem, to decode-new.c.inc.

While at it also rename gen_lea_modrm_0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 271 ------------------------------
 target/i386/tcg/decode-new.c.inc | 277 ++++++++++++++++++++++++++++++-
 2 files changed, 274 insertions(+), 274 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 17ad4ccacaf..a905efdfbbd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1644,182 +1644,6 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
     return cc_src;
 }
 
-#define X86_MAX_INSN_LENGTH 15
-
-static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
-{
-    uint64_t pc = s->pc;
-
-    /* This is a subsequent insn that crosses a page boundary.  */
-    if (s->base.num_insns > 1 &&
-        !translator_is_same_page(&s->base, s->pc + num_bytes - 1)) {
-        siglongjmp(s->jmpbuf, 2);
-    }
-
-    s->pc += num_bytes;
-    if (unlikely(cur_insn_len(s) > X86_MAX_INSN_LENGTH)) {
-        /* If the instruction's 16th byte is on a different page than the 1st, a
-         * page fault on the second page wins over the general protection fault
-         * caused by the instruction being too long.
-         * This can happen even if the operand is only one byte long!
-         */
-        if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
-            (void)translator_ldub(env, &s->base,
-                                  (s->pc - 1) & TARGET_PAGE_MASK);
-        }
-        siglongjmp(s->jmpbuf, 1);
-    }
-
-    return pc;
-}
-
-static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
-{
-    return translator_ldub(env, &s->base, advance_pc(env, s, 1));
-}
-
-static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
-{
-    return translator_lduw(env, &s->base, advance_pc(env, s, 2));
-}
-
-static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
-{
-    return translator_ldl(env, &s->base, advance_pc(env, s, 4));
-}
-
-#ifdef TARGET_X86_64
-static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
-{
-    return translator_ldq(env, &s->base, advance_pc(env, s, 8));
-}
-#endif
-
-/* Decompose an address.  */
-
-static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
-                                    int modrm, bool is_vsib)
-{
-    int def_seg, base, index, scale, mod, rm;
-    target_long disp;
-    bool havesib;
-
-    def_seg = R_DS;
-    index = -1;
-    scale = 0;
-    disp = 0;
-
-    mod = (modrm >> 6) & 3;
-    rm = modrm & 7;
-    base = rm | REX_B(s);
-
-    if (mod == 3) {
-        /* Normally filtered out earlier, but including this path
-           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
-        goto done;
-    }
-
-    switch (s->aflag) {
-    case MO_64:
-    case MO_32:
-        havesib = 0;
-        if (rm == 4) {
-            int code = x86_ldub_code(env, s);
-            scale = (code >> 6) & 3;
-            index = ((code >> 3) & 7) | REX_X(s);
-            if (index == 4 && !is_vsib) {
-                index = -1;  /* no index */
-            }
-            base = (code & 7) | REX_B(s);
-            havesib = 1;
-        }
-
-        switch (mod) {
-        case 0:
-            if ((base & 7) == 5) {
-                base = -1;
-                disp = (int32_t)x86_ldl_code(env, s);
-                if (CODE64(s) && !havesib) {
-                    base = -2;
-                    disp += s->pc + s->rip_offset;
-                }
-            }
-            break;
-        case 1:
-            disp = (int8_t)x86_ldub_code(env, s);
-            break;
-        default:
-        case 2:
-            disp = (int32_t)x86_ldl_code(env, s);
-            break;
-        }
-
-        /* For correct popl handling with esp.  */
-        if (base == R_ESP && s->popl_esp_hack) {
-            disp += s->popl_esp_hack;
-        }
-        if (base == R_EBP || base == R_ESP) {
-            def_seg = R_SS;
-        }
-        break;
-
-    case MO_16:
-        if (mod == 0) {
-            if (rm == 6) {
-                base = -1;
-                disp = x86_lduw_code(env, s);
-                break;
-            }
-        } else if (mod == 1) {
-            disp = (int8_t)x86_ldub_code(env, s);
-        } else {
-            disp = (int16_t)x86_lduw_code(env, s);
-        }
-
-        switch (rm) {
-        case 0:
-            base = R_EBX;
-            index = R_ESI;
-            break;
-        case 1:
-            base = R_EBX;
-            index = R_EDI;
-            break;
-        case 2:
-            base = R_EBP;
-            index = R_ESI;
-            def_seg = R_SS;
-            break;
-        case 3:
-            base = R_EBP;
-            index = R_EDI;
-            def_seg = R_SS;
-            break;
-        case 4:
-            base = R_ESI;
-            break;
-        case 5:
-            base = R_EDI;
-            break;
-        case 6:
-            base = R_EBP;
-            def_seg = R_SS;
-            break;
-        default:
-        case 7:
-            base = R_EBX;
-            break;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
- done:
-    return (AddressParts){ def_seg, base, index, scale, disp };
-}
-
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 {
@@ -1904,79 +1728,6 @@ static void gen_st_modrm(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
     }
 }
 
-static target_ulong insn_get_addr(CPUX86State *env, DisasContext *s, MemOp ot)
-{
-    target_ulong ret;
-
-    switch (ot) {
-    case MO_8:
-        ret = x86_ldub_code(env, s);
-        break;
-    case MO_16:
-        ret = x86_lduw_code(env, s);
-        break;
-    case MO_32:
-        ret = x86_ldl_code(env, s);
-        break;
-#ifdef TARGET_X86_64
-    case MO_64:
-        ret = x86_ldq_code(env, s);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
-    return ret;
-}
-
-static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, MemOp ot)
-{
-    uint32_t ret;
-
-    switch (ot) {
-    case MO_8:
-        ret = x86_ldub_code(env, s);
-        break;
-    case MO_16:
-        ret = x86_lduw_code(env, s);
-        break;
-    case MO_32:
-#ifdef TARGET_X86_64
-    case MO_64:
-#endif
-        ret = x86_ldl_code(env, s);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return ret;
-}
-
-static target_long insn_get_signed(CPUX86State *env, DisasContext *s, MemOp ot)
-{
-    target_long ret;
-
-    switch (ot) {
-    case MO_8:
-        ret = (int8_t) x86_ldub_code(env, s);
-        break;
-    case MO_16:
-        ret = (int16_t) x86_lduw_code(env, s);
-        break;
-    case MO_32:
-        ret = (int32_t) x86_ldl_code(env, s);
-        break;
-#ifdef TARGET_X86_64
-    case MO_64:
-        ret = x86_ldq_code(env, s);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
-    return ret;
-}
-
 static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
                                         TCGLabel *not_taken, TCGLabel *taken)
 {
@@ -2221,28 +1972,6 @@ static void gen_leave(DisasContext *s)
     gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
 }
 
-/* Similarly, except that the assumption here is that we don't decode
-   the instruction at all -- either a missing opcode, an unimplemented
-   feature, or just a bogus instruction stream.  */
-static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
-{
-    gen_illegal_opcode(s);
-
-    if (qemu_loglevel_mask(LOG_UNIMP)) {
-        FILE *logfile = qemu_log_trylock();
-        if (logfile) {
-            target_ulong pc = s->base.pc_next, end = s->pc;
-
-            fprintf(logfile, "ILLOPC: " TARGET_FMT_lx ":", pc);
-            for (; pc < end; ++pc) {
-                fprintf(logfile, " %02x", translator_ldub(env, &s->base, pc));
-            }
-            fprintf(logfile, "\n");
-            qemu_log_unlock(logfile);
-        }
-    }
-}
-
 /* an interrupt is different from an exception because of the
    privilege checks */
 static void gen_interrupt(DisasContext *s, uint8_t intno)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9d17bae7e75..b4aa300ab47 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -279,6 +279,130 @@
 
 #define UNKNOWN_OPCODE ((X86OpEntry) {})
 
+#define X86_MAX_INSN_LENGTH 15
+
+static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
+{
+    uint64_t pc = s->pc;
+
+    /* This is a subsequent insn that crosses a page boundary.  */
+    if (s->base.num_insns > 1 &&
+        !translator_is_same_page(&s->base, s->pc + num_bytes - 1)) {
+        siglongjmp(s->jmpbuf, 2);
+    }
+
+    s->pc += num_bytes;
+    if (unlikely(cur_insn_len(s) > X86_MAX_INSN_LENGTH)) {
+        /* If the instruction's 16th byte is on a different page than the 1st, a
+         * page fault on the second page wins over the general protection fault
+         * caused by the instruction being too long.
+         * This can happen even if the operand is only one byte long!
+         */
+        if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
+            (void)translator_ldub(env, &s->base,
+                                  (s->pc - 1) & TARGET_PAGE_MASK);
+        }
+        siglongjmp(s->jmpbuf, 1);
+    }
+
+    return pc;
+}
+
+static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
+{
+    return translator_ldub(env, &s->base, advance_pc(env, s, 1));
+}
+
+static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
+{
+    return translator_lduw(env, &s->base, advance_pc(env, s, 2));
+}
+
+static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
+{
+    return translator_ldl(env, &s->base, advance_pc(env, s, 4));
+}
+
+#ifdef TARGET_X86_64
+static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
+{
+    return translator_ldq(env, &s->base, advance_pc(env, s, 8));
+}
+#endif
+
+static target_ulong insn_get_addr(CPUX86State *env, DisasContext *s, MemOp ot)
+{
+    target_ulong ret;
+
+    switch (ot) {
+    case MO_8:
+        ret = x86_ldub_code(env, s);
+        break;
+    case MO_16:
+        ret = x86_lduw_code(env, s);
+        break;
+    case MO_32:
+        ret = x86_ldl_code(env, s);
+        break;
+#ifdef TARGET_X86_64
+    case MO_64:
+        ret = x86_ldq_code(env, s);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
+static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, MemOp ot)
+{
+    uint32_t ret;
+
+    switch (ot) {
+    case MO_8:
+        ret = x86_ldub_code(env, s);
+        break;
+    case MO_16:
+        ret = x86_lduw_code(env, s);
+        break;
+    case MO_32:
+#ifdef TARGET_X86_64
+    case MO_64:
+#endif
+        ret = x86_ldl_code(env, s);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
+static target_long insn_get_signed(CPUX86State *env, DisasContext *s, MemOp ot)
+{
+    target_long ret;
+
+    switch (ot) {
+    case MO_8:
+        ret = (int8_t) x86_ldub_code(env, s);
+        break;
+    case MO_16:
+        ret = (int16_t) x86_lduw_code(env, s);
+        break;
+    case MO_32:
+        ret = (int32_t) x86_ldl_code(env, s);
+        break;
+#ifdef TARGET_X86_64
+    case MO_64:
+        ret = x86_ldq_code(env, s);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
 static uint8_t get_modrm(DisasContext *s, CPUX86State *env)
 {
     if (!s->has_modrm) {
@@ -1883,6 +2007,130 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = opcodes_root[*b];
 }
 
+/* Decompose an address.  */
+static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
+                                         int modrm, bool is_vsib)
+{
+    int def_seg, base, index, scale, mod, rm;
+    target_long disp;
+    bool havesib;
+
+    def_seg = R_DS;
+    index = -1;
+    scale = 0;
+    disp = 0;
+
+    mod = (modrm >> 6) & 3;
+    rm = modrm & 7;
+    base = rm | REX_B(s);
+
+    if (mod == 3) {
+        /* Normally filtered out earlier, but including this path
+           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
+        goto done;
+    }
+
+    switch (s->aflag) {
+    case MO_64:
+    case MO_32:
+        havesib = 0;
+        if (rm == 4) {
+            int code = x86_ldub_code(env, s);
+            scale = (code >> 6) & 3;
+            index = ((code >> 3) & 7) | REX_X(s);
+            if (index == 4 && !is_vsib) {
+                index = -1;  /* no index */
+            }
+            base = (code & 7) | REX_B(s);
+            havesib = 1;
+        }
+
+        switch (mod) {
+        case 0:
+            if ((base & 7) == 5) {
+                base = -1;
+                disp = (int32_t)x86_ldl_code(env, s);
+                if (CODE64(s) && !havesib) {
+                    base = -2;
+                    disp += s->pc + s->rip_offset;
+                }
+            }
+            break;
+        case 1:
+            disp = (int8_t)x86_ldub_code(env, s);
+            break;
+        default:
+        case 2:
+            disp = (int32_t)x86_ldl_code(env, s);
+            break;
+        }
+
+        /* For correct popl handling with esp.  */
+        if (base == R_ESP && s->popl_esp_hack) {
+            disp += s->popl_esp_hack;
+        }
+        if (base == R_EBP || base == R_ESP) {
+            def_seg = R_SS;
+        }
+        break;
+
+    case MO_16:
+        if (mod == 0) {
+            if (rm == 6) {
+                base = -1;
+                disp = x86_lduw_code(env, s);
+                break;
+            }
+        } else if (mod == 1) {
+            disp = (int8_t)x86_ldub_code(env, s);
+        } else {
+            disp = (int16_t)x86_lduw_code(env, s);
+        }
+
+        switch (rm) {
+        case 0:
+            base = R_EBX;
+            index = R_ESI;
+            break;
+        case 1:
+            base = R_EBX;
+            index = R_EDI;
+            break;
+        case 2:
+            base = R_EBP;
+            index = R_ESI;
+            def_seg = R_SS;
+            break;
+        case 3:
+            base = R_EBP;
+            index = R_EDI;
+            def_seg = R_SS;
+            break;
+        case 4:
+            base = R_ESI;
+            break;
+        case 5:
+            base = R_EDI;
+            break;
+        case 6:
+            base = R_EBP;
+            def_seg = R_SS;
+            break;
+        default:
+        case 7:
+            base = R_EBX;
+            break;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+ done:
+    return (AddressParts){ def_seg, base, index, scale, disp };
+}
+
 static int decode_modrm(DisasContext *s, CPUX86State *env,
                         X86DecodedInsn *decode, X86DecodedOp *op)
 {
@@ -1895,8 +2143,8 @@ static int decode_modrm(DisasContext *s, CPUX86State *env,
     } else {
         op->has_ea = true;
         op->n = -1;
-        decode->mem = gen_lea_modrm_0(env, s, modrm,
-                                      decode->e.vex_class == 12);
+        decode->mem = decode_modrm_address(env, s, get_modrm(s, env),
+                                           decode->e.vex_class == 12);
     }
     return modrm;
 }
@@ -2516,6 +2764,23 @@ illegal:
     return false;
 }
 
+static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
+{
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            target_ulong pc = s->base.pc_next, end = s->pc;
+
+            fprintf(logfile, "ILLOPC: " TARGET_FMT_lx ":", pc);
+            for (; pc < end; ++pc) {
+                fprintf(logfile, " %02x", translator_ldub(env, &s->base, pc));
+            }
+            fprintf(logfile, "\n");
+            qemu_log_unlock(logfile);
+        }
+    }
+}
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2902,5 +3167,11 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     gen_illegal_opcode(s);
     return;
  unknown_op:
-    gen_unknown_opcode(env, s);
+    /*
+     * Similarly, except that the assumption here is that we don't decode
+     * the instruction at all -- either a missing opcode, an unimplemented
+     * feature, or just a bogus instruction stream.
+     */
+    gen_illegal_opcode(s);
+    dump_unknown_opcode(env, s);
 }
-- 
2.52.0


