Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D5C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7fM-00036U-JR; Fri, 14 Feb 2025 21:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tj7fL-00036M-D2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:12:23 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tj7fJ-0006Gx-6b
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:12:23 -0500
Received: from localhost.localdomain (dynamic-cpe-pool.orcon.net.nz
 [121.99.116.25] (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51F2C2mw3738646
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sat, 15 Feb 2025 02:12:07 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=W8Y57oVc header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739585529;
 bh=uXHzRMjEpLGuTGUlrGl4EFfcfWanv9s/K+av2UjFd4g=;
 h=From:To:Cc:Subject:Date:From;
 b=W8Y57oVc8YecjRwVrcRLIXxXolplHi6gtBn956wrm2QamGWvrd8YI4ZvV+1ucI/30
 9yEZC2w7wSwwrcQ+gfHWjxqKG4aqmPucewo/2sShekNjuLxkB/56oUD/2sWgkh4X83
 VO0FuPWnjeGfIwn1BuYOx+0+AkKNgb7bym2t9ouEIrCLwOHkV1r02aWAR7wJDFVXOG
 fW6RVIpCipZsHxgfoM3GCaYCS8hZkjNQpYn9qf9yDkbB26+ks+4sNBAUOu01a0j0jX
 ihrXTAnFOO/UhgmqOTS7JDuqKhPt2XmH4Y879guMU5xSoZ3KO4gnjHFRRLEAgMAq7h
 rW+2Ulr1AjpTQ==
From: Michael Clark <michael@anarch128.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Clark <michael@anarch128.org>
Subject: [PATCH] tcg: refactor pool data for simplicity and comprehension
Date: Sat, 15 Feb 2025 15:11:20 +1300
Message-ID: <20250215021120.1647083-1-michael@anarch128.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

the intent of this patch is more conventional nomenclature
but the constant pool data code is also simplified a little.

- merge new_pool_{alloc,insert} -> new_pool_data.
- rename TCGLabelPoolData -> TCGData.
- rename pool_labels -> pool_data.
- rename macro TCG_TARGET_NEED_POOL_DATA.
- move TCGData struct definition into tcg.h.
- comment translation block epilogue members.

TCGLabelPoolData is ambiguous and asks for potential confusion
with the unrelated TCGLabel type. there is no label in the sense
of TCGLabel. the structure contains data to be emitted at the end
of translation blocks at data_gen_ptr in tcg_out_pool_finalize.
rtype and label save emitting a seperate TCGRelocation which
would be a more conventional but slightly more costly approach.

the label member is merely a pointer to the instruction text to
be updated with the relative address of the constant, the primary
data is the constant data pool at the end of translation blocks.
this relates more closely to .data sections in offline codegen
if we were to imagine a translation block has .text and .data.

thus TCGData is more succinct and more reflective of what the
structure contains; data emitted in the constant data pool at
the end of translation blocks. also, pool_labels is renamed to
pool_data as the primary contents of the list is constant data.

finally, new_pool_alloc and new_pool_insert are merged into a
single function named new_pool_data, which moves nlongs to the
end of the parameter list with varargs to allocate, copy, and
insert constant data items to simplify new_pool_label et al.
a successive step would be to collapse callers into calling
new_pool_data and remove a layer of indirection.

Signed-off-by: Michael Clark <michael@anarch128.org>
---
 include/tcg/tcg.h    | 16 ++++++++--
 tcg/tcg.c            | 72 ++++++++++++++------------------------------
 tcg/tci/tcg-target.h |  2 +-
 3 files changed, 37 insertions(+), 53 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 1d1d668f527b..df0b4a36adb9 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -118,6 +118,15 @@ struct TCGLabel {
     QSIMPLEQ_ENTRY(TCGLabel) next;
 };
 
+typedef struct TCGData {
+    struct TCGData *next;
+    tcg_insn_unit *label;
+    intptr_t addend;
+    int rtype;
+    unsigned nlong;
+    tcg_target_ulong data[];
+} TCGData;
+
 typedef struct TCGPool {
     struct TCGPool *next;
     int size;
@@ -392,10 +401,13 @@ struct TCGContext {
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
 
-    /* These structures are private to tcg-target.c.inc.  */
+    /* load store slow path emitted at the end of translation blocks */
     QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;
-    struct TCGLabelPoolData *pool_labels;
 
+    /* labled constant data emitted at the end of translation blocks */
+    TCGData *pool_data;
+
+    /* labeled exit request emitted at the end of translation blocks */
     TCGLabel *exitreq_label;
 
 #ifdef CONFIG_PLUGIN
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43b6712286c3..4a84fc8adc04 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -657,38 +657,29 @@ static TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
 }
 
 /*
- * Allocate new constant pool entries.
+ * Create new constant pool data and insert into the pool.
  */
 
-typedef struct TCGLabelPoolData {
-    struct TCGLabelPoolData *next;
-    tcg_insn_unit *label;
-    intptr_t addend;
-    int rtype;
-    unsigned nlong;
-    tcg_target_ulong data[];
-} TCGLabelPoolData;
-
-static TCGLabelPoolData *new_pool_alloc(TCGContext *s, int nlong, int rtype,
-                                        tcg_insn_unit *label, intptr_t addend)
+static void new_pool_data(TCGContext *s, int rtype, tcg_insn_unit *label,
+                          intptr_t addend, int nlong, ...)
 {
-    TCGLabelPoolData *n = tcg_malloc(sizeof(TCGLabelPoolData)
-                                     + sizeof(tcg_target_ulong) * nlong);
+    TCGData *n, *i, **pp;
+    va_list ap;
+
+    n = tcg_malloc(sizeof(TCGData) + sizeof(tcg_target_ulong) * nlong);
 
     n->label = label;
     n->addend = addend;
     n->rtype = rtype;
     n->nlong = nlong;
-    return n;
-}
 
-static void new_pool_insert(TCGContext *s, TCGLabelPoolData *n)
-{
-    TCGLabelPoolData *i, **pp;
-    int nlong = n->nlong;
+    va_start(ap, nlong);
+    for(size_t l = 0; l < nlong; l++) {
+        n->data[l] = va_arg(ap, tcg_target_ulong);
+    }
 
     /* Insertion sort on the pool.  */
-    for (pp = &s->pool_labels; (i = *pp) != NULL; pp = &i->next) {
+    for (pp = &s->pool_data; (i = *pp) != NULL; pp = &i->next) {
         if (nlong > i->nlong) {
             break;
         }
@@ -708,9 +699,7 @@ __attribute__((unused))
 static void new_pool_label(TCGContext *s, tcg_target_ulong d, int rtype,
                            tcg_insn_unit *label, intptr_t addend)
 {
-    TCGLabelPoolData *n = new_pool_alloc(s, 1, rtype, label, addend);
-    n->data[0] = d;
-    new_pool_insert(s, n);
+    new_pool_data(s, rtype, label, addend, 1, d);
 }
 
 /* For v64 or v128, depending on the host.  */
@@ -719,10 +708,7 @@ static void new_pool_l2(TCGContext *s, int rtype, tcg_insn_unit *label,
                         intptr_t addend, tcg_target_ulong d0,
                         tcg_target_ulong d1)
 {
-    TCGLabelPoolData *n = new_pool_alloc(s, 2, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    new_pool_insert(s, n);
+    new_pool_data(s, rtype, label, addend, 2, d0, d1);
 }
 
 /* For v128 or v256, depending on the host.  */
@@ -732,12 +718,7 @@ static void new_pool_l4(TCGContext *s, int rtype, tcg_insn_unit *label,
                         tcg_target_ulong d1, tcg_target_ulong d2,
                         tcg_target_ulong d3)
 {
-    TCGLabelPoolData *n = new_pool_alloc(s, 4, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    n->data[2] = d2;
-    n->data[3] = d3;
-    new_pool_insert(s, n);
+    new_pool_data(s, rtype, label, addend, 4, d0, d1, d2, d3);
 }
 
 /* For v256, for 32-bit host.  */
@@ -749,16 +730,7 @@ static void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
                         tcg_target_ulong d5, tcg_target_ulong d6,
                         tcg_target_ulong d7)
 {
-    TCGLabelPoolData *n = new_pool_alloc(s, 8, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    n->data[2] = d2;
-    n->data[3] = d3;
-    n->data[4] = d4;
-    n->data[5] = d5;
-    n->data[6] = d6;
-    n->data[7] = d7;
-    new_pool_insert(s, n);
+    new_pool_data(s, rtype, label, addend, 8, d0, d1, d2, d3, d4, d5, d6, d7);
 }
 
 /*
@@ -792,8 +764,8 @@ static int tcg_out_ldst_finalize(TCGContext *s)
 
 static int tcg_out_pool_finalize(TCGContext *s)
 {
-    TCGLabelPoolData *p = s->pool_labels;
-    TCGLabelPoolData *l = NULL;
+    TCGData *p = s->pool_data;
+    TCGData *l = NULL;
     void *a;
 
     if (p == NULL) {
@@ -1598,15 +1570,15 @@ void tcg_prologue_init(void)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
-    s->pool_labels = NULL;
+#ifdef TCG_TARGET_NEED_POOL_DATA
+    s->pool_data = NULL;
 #endif
 
     qemu_thread_jit_write();
     /* Generate the prologue.  */
     tcg_target_qemu_prologue(s);
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
+#ifdef TCG_TARGET_NEED_POOL_DATA
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
         int result = tcg_out_pool_finalize(s);
@@ -6407,7 +6379,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->data_gen_ptr = NULL;
 
     QSIMPLEQ_INIT(&s->ldst_labels);
-    s->pool_labels = NULL;
+    s->pool_data = NULL;
 
     start_words = s->insn_start_words;
     s->gen_insn_data =
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index a9ca493d20f6..448c2330ef0f 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -72,6 +72,6 @@ typedef enum {
 } TCGReg;
 
 #define HAVE_TCG_QEMU_TB_EXEC
-#define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_NEED_POOL_DATA
 
 #endif /* TCG_TARGET_H */
-- 
2.43.0


