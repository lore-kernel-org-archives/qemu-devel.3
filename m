Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ADAC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr51-00047D-VA; Sat, 22 Aug 2026 15:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr50-00044c-1g
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:34 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr4y-0005lk-CO
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:33 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81f64e8dfbcso32052717b3.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425711; x=1788030511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=L6IgcZQk+sAoLDyzk9uG8nbvrDJ4yGicKQxlZg8wiaOin9ABIPTXTxm3ksoLk4AdJL
 cmD/FnURoLhCkrCf6QoeQxDCuxM5gXIqZgLHXbBZGReje/FyvivsMi90oofNhVfSd34f
 iSdWk7BP8rW0hMh5J7FmgIjGRir3DzJWhV9Txw7k1dO0sCFwftytpTKayJA/EnUcr/nk
 HO04sISyslhCZCRkNO611NEpYJDUx71N5MzsXtG/opSrLYso/cCZVjFTV5tVsgyiIQ0y
 nNVh4JIwUUz6UN3jCkVtqJcdnrE6gBNXORSkYVfD3W8Fq3tTKKMK/iQPES7h6C29AIl2
 gywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425711; x=1788030511;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qoJCBK/eJXzgVER7xSpcF+/HlWQEqa8pDFs252ZZUaI=;
 b=TiFw1+cLMc9KdbbEqRaoCoqjo5a8XonLHNmVsy3+eyoq73yhLb13bCgjTAaX/FFRr4
 MbLg87woJjCcTl9C768x+TuBcrYZMGaDck2o4B/t5jjNC4S848NEQ19XfuwQd2loU4UW
 iPB/kECQu83ECt2ZwAbhwzhBl5IhxunXZhkdEQjNMuFNsjma/jmZdUHvr1zSQfCNe7pI
 mBds2GfYGnHfqsbVcOCxhvbomzBqdtZWS4uatvcs/wNL+WdmquxCCT1X+TJ6cNCHWcKG
 nsIDsW108YEIEPwv4w/Xo2E+GdrF/Nsil7PWkZJcEudNU6hKWHTpOl0/dep8LafeeLKO
 c/XA==
X-Gm-Message-State: AFuF++lnL6qAG40c2ccba0RewS0+W4QEv0K2m/2ag4v02EWnJseTYo7X
 St5fAnnzF294/ZdxMASRcAGyDoOxQKQ+tOVpdC3R5/uHfI3rLd8CN/dJ4x4ZQ7mPOmY=
X-Gm-Gg: AR+sD13lXUN89kG4rsi1lGEfkgV6P0pFuZc3qOcDQ0B+yju4NhsZAW9u41xQNBpK0/B
 8w6pYJBpyoIgBC4bqnObNFM38laVmCxDBFQOHrKfkLamxxlRWwW5OJooteNvRlmjPtXR0SjuM+Z
 nDnWxhGKDhcu3YZXgGtXEp9sqD/ZEz5FoIKeumXD4y3HCqIvm980ffWi8G6PAM2aLY4+bYiAL9g
 3NUsZ/Rsb9WuYifNJlgYxVWKKiD4LRsjx4G/028FOEUIxjFme+E/nUoGhGaXXSZJ5Xi/RNV/pzP
 RiRnBxI8Ku2pIeuUNQogZHC5CkXsbms84rddPNt+AOisodt/g/vopKJvn35tUMZMIIgGfSAoT5/
 6cRoXe1DvBQAOP6jkCLCzkyKiljviGUw2XAMqn2azltySNvxAM73bGARryVQevamSF/Ytl2+cb6
 O5C2MRFk95vNNhVSY99uYDb2I8Yo/WiVrzZgg0gxn54F0DF/lY8ydqTE8yjPM8Ekz+WAPJ1nbKX
 p8OPpzuQBnI2ybkJPr15ERWg0cBcKclHHSfThBg
X-Received: by 2002:a05:690c:e1c4:10b0:820:1281:8deb with SMTP id
 00721157ae682-849f08113c4mr51716717b3.8.1787425711249; 
 Sat, 22 Aug 2026 12:08:31 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84cab854483sm13222017b3.33.2026.08.22.12.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:29 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 3/7] accel/tcg: skip the can_do_io stores in user-only
 builds
Date: Sat, 22 Aug 2026 15:08:14 -0400
Message-ID: <20260822190818.1829249-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Every translation block stores to cpu->neg.can_do_io twice: false before
the first instruction, true before the last one. Nothing reads it in a
user-only build. There is no memory-mapped I/O in linux-user, and every
reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
tcg-accel-ops-icount.c.

Two stores per TB is not much on its own, but TBs are short. An emulated
alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
-O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
68 billion stores for nothing.

Measured on an x86-64 host, LTO build, on top of the preceding two
patches:

    before: 1,469,772,951,575 instructions
    after:  1,402,667,803,616 instructions   -4.57%

    before: 121.04s wall clock
    after:  115.56s wall clock              -4.53%

The emulated compiler produces byte-identical output.

v3: Use #ifndef CONFIG_USER_ONLY again rather than
    if (IS_ENABLED(CONFIG_USER_ONLY)). QEMU's IS_ENABLED() is IS_EMPTY(),
    which is only true for a symbol Meson defines empty; CONFIG_USER_ONLY
    is defined as 1, so the test was always false and v2 emitted the two
    stores after all. The measurements above are from the working form.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 57daded60f..6c8fcd7a20 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -21,12 +21,14 @@
 #include "disas/disas.h"
 #include "tb-internal.h"
 
+#ifndef CONFIG_USER_ONLY
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
     QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
     tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
                     offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
 }
+#endif
 
 bool translator_io_start(DisasContextBase *db)
 {
@@ -210,17 +212,25 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     /*
      * Manage can_do_io for the translation block: set to false before
      * the first insn and set to true before the last insn.
+     *
+     * Nothing reads can_do_io in user-only builds.  There is no MMIO
+     * there, and every reader (cputlb.c, watchpoint.c, icount) is in
+     * system_ss, so skip the two stores per TB entirely.
      */
     if (db->num_insns == 1) {
         tcg_debug_assert(first_insn_start == db->insn_start);
     } else {
         tcg_debug_assert(first_insn_start != db->insn_start);
+#ifndef CONFIG_USER_ONLY
         tcg_ctx->emit_before_op = first_insn_start;
         set_can_do_io(db, false);
+#endif
     }
+#ifndef CONFIG_USER_ONLY
     tcg_ctx->emit_before_op = db->insn_start;
     set_can_do_io(db, true);
     tcg_ctx->emit_before_op = NULL;
+#endif
 
     /* May be used by disas_log or plugin callbacks. */
     tb->size = db->pc_next - db->pc_first;
-- 
2.54.0


