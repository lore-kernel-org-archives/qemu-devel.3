Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KE7i8Zgq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiB-0002SR-Qk; Wed, 18 Nov 2026 07:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei1-0002Od-4S
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehz-0004d4-1U
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfQcmG91yWl6zvzhfI63W87v4UztEacgTICOmW0sh8A=;
 b=KE7i8ZgqntBjmEOMFrnO3wTy9XljjAgQYnk5j6//z3xV024Rhm0UH/QciH7Qi+FzMvXvsA
 SDcfi0IwE4fqobzbrXYK2yQCE8pS5VjP7iw6NaT8IemgwZA4y5X16/iS2z7Xe+tf8c0mH6
 ILHOnSPups9LkU8enIY4EpRinkgs9MA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-jpARrI3fMdSgp-yFYkU2tQ-1; Wed,
 18 Nov 2026 07:24:12 -0500
X-MC-Unique: jpARrI3fMdSgp-yFYkU2tQ-1
X-Mimecast-MFC-AGG-ID: jpARrI3fMdSgp-yFYkU2tQ_1795004651
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33F131956057
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:11 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 857E018004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/26] target/i386/tcg: add bytecode based opcode decoder
Date: Wed, 18 Nov 2026 13:23:41 +0100
Message-ID: <20261118122357.659634-11-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an interpreter for the program that maps the opcode bytes, ModRM
and prefix information to a row of a table of X86OpEntry structs.  The
program can then replace the X86DecodeFunc helpers.

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 134 +++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2dc5f2ecf9e..7fdd7a86f46 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2762,6 +2762,140 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
     return e->valid_prefix & (1 << sse_prefixes);
 }
 
+#if 0
+static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid);
+
+#include "decode-table.h"
+
+/* Compute the value of a selector for OP_MATCH, OP_SELECT and OP_SWITCH.  */
+static unsigned decode_selector(DisasContext *s, CPUX86State *env,
+                                X86DecodeStep step, uint8_t b)
+{
+    switch (step.sel) {
+    case X86_SEL_BYTE:
+        return b;
+    case X86_SEL_REG:
+        return (get_modrm(s, env) >> 3) & 7;
+    case X86_SEL_MOD:
+        return (get_modrm(s, env) >> 6) == 3;
+    case X86_SEL_PREFIX:
+        if (s->prefix & PREFIX_REPNZ) {
+            return X86_PREFIX_F2;
+        } else if (s->prefix & PREFIX_REPZ) {
+            return X86_PREFIX_F3;
+        } else if (s->prefix & PREFIX_DATA) {
+            return X86_PREFIX_66;
+        } else {
+            return X86_PREFIX_NP;
+        }
+    case X86_SEL_ENC:
+        if (s->prefix & PREFIX_EVEX) {
+            return X86_ENC_EVEX;
+        } else if (s->prefix & PREFIX_VEX) {
+            return X86_ENC_VEX;
+        } else if (s->prefix & PREFIX_REX2) {
+            return X86_ENC_REX2;
+        } else {
+            return X86_ENC_LEGACY;
+        }
+    case X86_SEL_W:
+        return s->vex_w;
+    case X86_SEL_L:
+        return s->vex_l;
+    case X86_SEL_MODE64:
+        return CODE64(s);
+    case X86_SEL_ND:
+        return EVEX_APX_ND(s);
+    case X86_SEL_NF:
+        return EVEX_APX_NF(s);
+    case X86_SEL_CPUID:
+        return has_cpuid_feature(s, step.arg);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*
+ * Run decode_program from the entry point for the given opcode map (0-7),
+ * and return the X86OpEntry for the instruction or NULL for #UD.  The last
+ * opcode byte that was fetched is left in *b.
+ */
+static const X86OpEntry *decode_run(DisasContext *s, CPUX86State *env,
+                                    int map, uint8_t *b)
+{
+    int pc = map;
+
+    for (;;) {
+        const X86DecodeStep step = decode_program[pc];
+        unsigned v, limit;
+
+        switch (step.kind) {
+        case OP_UD:
+            return NULL;
+        case OP_RET:
+            if (step.sel == X86_SEL_None) {
+                return &decode_rows[step.target];
+            }
+            v = decode_selector(s, env, step, *b);
+            if (v <= step.arg) {
+                return &decode_rows[step.target + v];
+            }
+            pc++;
+            break;
+        case OP_JMP:
+            pc = step.target;
+            break;
+
+        case OP_SET:
+            switch (step.sel) {
+            case X86_SEL_W:
+                s->vex_w = step.arg;
+                break;
+            case X86_SEL_L:
+                s->vex_l = step.arg;
+                break;
+            case X86_SEL_MOD:
+                assert(step.arg == 1);
+                get_modrm(s, env);
+                s->modrm |= 0xC0;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            pc++;
+            break;
+
+        case OP_MATCH:
+            v = decode_selector(s, env, step, *b);
+            if (step.sel == X86_SEL_BYTE) {
+                v = (v == step.arg);
+            } else if (step.sel != X86_SEL_CPUID) {
+                v = (step.arg >> v) & 1;
+            }
+            pc = v ? pc + 1 : step.target;
+            break;
+
+        case OP_SELECT:
+        case OP_SWITCH:
+            v = decode_selector(s, env, step, *b);
+            /* For X86_SEL_CPUID, arg is the feature.  */
+            limit = step.sel == X86_SEL_CPUID ? 1 : step.arg;
+            if (v > limit) {
+                return NULL;
+            }
+            if (step.kind == OP_SELECT) {
+                return &decode_rows[step.target + v];
+            }
+            pc = step.target + v;
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+#endif
+
 static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                         X86DecodedInsn *decode)
 {
-- 
2.56.0



