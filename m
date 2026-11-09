Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE66606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsFaOZDt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUYL-0007YL-Tg; Mon, 09 Nov 2026 13:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xQUYE-0007Tr-3L
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xQUYA-00067A-RH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3bk/eVkd28vuCJgHYUXEVLJN2TVuhyrY6wlAP5JhMjo=;
 b=gsFaOZDtPl+FQWLB/h6chRSSrqU5Pa56A86GQAmDINdK9TLOR78gOK0bo9TpbMAnj97Tx1
 9VAHRiX9JaDJncP/9IiVAL8kKbC4QN4+Dqoe3KKjLEXWBOgOAjCQDF5Hv5NWaXv2+gTPKU
 YZRCShh2fyobpFoDPZpOpEUZsN5abTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-R7o5zj_LMNm-YyuyZ3oWlg-1; Mon,
 09 Nov 2026 13:57:00 -0500
X-MC-Unique: R7o5zj_LMNm-YyuyZ3oWlg-1
X-Mimecast-MFC-AGG-ID: R7o5zj_LMNm-YyuyZ3oWlg_1794250619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57B051956077
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2026 18:56:59 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A58A43001DA5
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2026 18:56:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/tcg: reject VEX encodings of PBLENDVB,
 BLENDVPS and BLENDVPD
Date: Mon,  9 Nov 2026 19:56:56 +0100
Message-ID: <20261109185656.1068651-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The opcodes 66 0F 38 10, 14 and 15 (PBLENDVB, BLENDVPS and BLENDVPD) have
vex_class 4, which allows both the legacy and the VEX encoding, so
VEX.66.0F38 10, 14 and 15 were decoded as the same instructions.  The VEX
forms of these instructions are VPBLENDVB, VBLENDVPS and VBLENDVPD, which
have four operands and are in map 0F 3A, so the VEX opcodes in map 0F 38
should raise #UD.

Keep vex_class 4, which provides the legacy SSE checks, and add a new
vex_special that raises #UD if the VEX or EVEX prefix is present.  This
is borderline disgusting, but an effective solution to x86's opcode sprawl
will have to wait for a new AI policy...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h      |  3 ++
 tests/tcg/i386/test-i386-blendv.c | 51 +++++++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc  | 16 +++++++---
 tests/tcg/i386/meson.build        |  1 +
 tests/tcg/x86_64/meson.build      |  1 +
 5 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-blendv.c

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index b40c75fa222..7f7ed3b6cf4 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -257,6 +257,9 @@ typedef enum X86InsnSpecial {
 typedef enum X86VEXSpecial {
     X86_VEX_None,
 
+    /* SSE and AVX instructions use different encoding */
+    X86_VEX_SSEOnly,
+
     /* Legacy SSE instructions that allow unaligned operands */
     X86_VEX_SSEUnaligned,
 
diff --git a/tests/tcg/i386/test-i386-blendv.c b/tests/tcg/i386/test-i386-blendv.c
new file mode 100644
index 00000000000..4f111fa4745
--- /dev/null
+++ b/tests/tcg/i386/test-i386-blendv.c
@@ -0,0 +1,51 @@
+/*
+ * Check that the legacy BLENDVPS, BLENDVPD and PBLENDVB exist, while the
+ * VEX encodings in the same opcodes do not (VBLENDVPS and the others are in
+ * map 0F 3A as they add *two* register operands, and the second is encoded
+ * in an immediate byte).
+ */
+#include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static sigjmp_buf jmp_env;
+
+static void sigill_handler(int sig)
+{
+    siglongjmp(jmp_env, 1);
+}
+
+/* 66 0F 38 xx with modrm = 11 001 001 (xmm1, xmm1 operands).  */
+#define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, " #op ", 0xc9" \
+                                     : : : "xmm0", "xmm1")
+
+/* Same but encoded with a VEX3 prefix: RXB=111b, mmmmm=2 (0F38), w=0,
+ * VVVV=1111b (forced because QEMU does not list an Hx operand),
+ * l=0 (128-bit), pp=1 (66h).  */
+#define VEX_INSN(op) asm volatile(".byte 0xc4, 0xe2, 0x79, " #op ", 0xc9")
+
+#define CHECK_VEX_ILLEGAL(op)                                         \
+    do {                                                              \
+        if (sigsetjmp(jmp_env, 1) == 0) {                             \
+            VEX_INSN(op);                                             \
+            printf("VEX " #op " did not fault\n");                    \
+            exit(1);                                                  \
+        }                                                             \
+    } while (0)
+
+int main(void)
+{
+    struct sigaction act = { .sa_handler = sigill_handler };
+
+    sigaction(SIGILL, &act, NULL);
+
+    SSE_INSN(0x10);
+    SSE_INSN(0x14);
+    SSE_INSN(0x15);
+
+    CHECK_VEX_ILLEGAL(0x10);
+    CHECK_VEX_ILLEGAL(0x14);
+    CHECK_VEX_ILLEGAL(0x15);
+    return 0;
+}
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9bcc0f76864..b91e3718cb5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -120,7 +120,8 @@
  *
  *    (*)  AMD lists VPBLENDVB as related to SSE4.1 PBLENDVB, which may
  *         explain why it is considered exception class 4.  However,
- *         Intel says that VEX-only instructions should be in class 6...
+ *         the two have different encodings (in 0F38 for SSE, in 0F3A
+ *         for AVX).
  *
  *    (+)  Not found in Intel's table 2-16
  *
@@ -250,6 +251,7 @@
 #define vex2_rep3 .vex_class = 2, .vex_special = X86_VEX_REPScalar,
 #define vex3 .vex_class = 3,
 #define vex4 .vex_class = 4,
+#define sse4 .vex_class = 4, .vex_special = X86_VEX_SSEOnly,
 #define vex4_unal .vex_class = 4, .vex_special = X86_VEX_SSEUnaligned,
 #define vex4_rep5 .vex_class = 4, .vex_special = X86_VEX_REPScalar,
 #define vex5 .vex_class = 5,
@@ -732,10 +734,10 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x06] = X86_OP_ENTRY3(PHSUBD,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x07] = X86_OP_ENTRY3(PHSUBSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
-    [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
+    [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
     [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 chk(W0) cpuid(F16C) p_66),
-    [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
-    [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
+    [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
+    [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
     [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66), /* vpermps */
     [0x17] = X86_OP_ENTRY3(VPTEST,    None,None, V,x,  W,x,   vex4 cpuid(SSE41) p_66),
@@ -3109,6 +3111,12 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
         break;
 
+    case X86_VEX_SSEOnly:
+        if (s->prefix & PREFIX_VEX) {
+            goto illegal;
+        }
+        break;
+
     case X86_VEX_SSEUnaligned:
         /* handled in sse_needs_alignment.  */
         break;
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 648b516582e..c912f37fab7 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -10,6 +10,7 @@ tests += {
   },
   'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
   'test-i386-adcox.c': {'cflags': ['-O2']},
+  'test-i386-blendv.c': {},
   'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
   'test-i386-f2xm1.c': {},
   'test-i386-fbstp.c': {},
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index fc7f48e98eb..9738d04220b 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -47,6 +47,7 @@ tests += {
     'exe_name': 'test-x86_64'
   },
   '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
+  '../i386/test-i386-blendv.c': {},
   '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
   '../i386/test-idiv-overflow.c': {},
 }
-- 
2.56.0


