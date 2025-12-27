Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622CCE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQww-0001nU-4G; Sat, 27 Dec 2025 04:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwi-0001b5-BT
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwg-0007Nz-6Z
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGKQcTYH8NslXOFyWO8VlfRFFvEFNB+uFId5LqaXI7k=;
 b=gtmG7ZE1C/2R0HmPcFo4ubSQxySn11MH/2PE4xDN9TIpg0Y2hgv5xQ8tB4SCZgGzOxN0xE
 UmRp1Fs0QmUea0+EwPRk5xLKKpwHsY0aDW3XGvDN8qj8QvhWP/SuoKIp/k04FLkfC4gmoE
 rfGEtG7akYqfzIibthoteodmoT0S2hY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-hDH96O2qNyyexJstnGpFKg-1; Sat, 27 Dec 2025 04:50:43 -0500
X-MC-Unique: hDH96O2qNyyexJstnGpFKg-1
X-Mimecast-MFC-AGG-ID: hDH96O2qNyyexJstnGpFKg_1766829043
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so3984504f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829041; x=1767433841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGKQcTYH8NslXOFyWO8VlfRFFvEFNB+uFId5LqaXI7k=;
 b=L7PVAuCE6/4sgH83knuHX6YM1yt9Av9KY09AH9iLgsMklDv5F9ykMH3zRRHeh3A+cB
 ZybZKdR8+q/nbULBY8QJLQWHnGTJYU44nlC1b1q9IcT82Pq0YRE6Zqo60EqW03pEbUH2
 MJ9k1yXqO/eEvg0lQ4Te8GimHabJXuWXJbSXMXw/DMGfnLfZ3uXyZaCqutfPHy716SAc
 nEwo8e4mz2NAI3kF44o08CCOGc4yQdT+tSQd/fqHuU/Kw7vC1lbO0K138yBPJXb6LDZg
 Iajd6EKgZtv0sJPDnDDZxyAGPhZ5lxbOGroFzhAFHMChdJzxm6qTkJ6FJroFiFT+n28R
 PWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829041; x=1767433841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGKQcTYH8NslXOFyWO8VlfRFFvEFNB+uFId5LqaXI7k=;
 b=LDCuIHkJO4oZ5Gpxm1vVxlVYz5PUjqntYTgJ6xlOQkUvykK7YG8qIDwJ6dcQuZNqH7
 kXKsBw4OxM0bMO1URLwDSQXHJ7XdXIm6elsQoqsM5sHYLWxKOSK/vh2ans3m1sAA90MR
 Zv99coj2zKQKVd5JNDN8Ouxc9r09PtGnv2gGpVUQlG9JhofoiOLFUwFbTxYWKFBTZkR+
 DrzgeJ8W33vKtFU/i2HrWk1NsqN3xEj0VrZ4h9cprV2my224SSTJuLHvTp6rufI6mKeZ
 Vg8fs1gw88TviqHZWXP4X+sIuFJD5WumiOJ1JFwdQcdHoVS0Wi3agHYf+/S541RKiHr7
 6UzQ==
X-Gm-Message-State: AOJu0YxggdSfuXNyGdaKawYJaL/9wn3hlS3pVGB8JAhJGKtr3yHTCmeC
 Vn0IID0TqK1i2pM+QGTrBUvW+LHOVIr1IXJfVFc8T2LXtnaDsmiX64pB7z4kX/Quczo9BWXOlAJ
 t0MTmwE0H+WTBeN+c1gPWSc659D/4stVv+6+vQmuGz7865z9ORYJdsu6vV53x+7vYD2oiLlPjgB
 MP+WtZAScwtz+pDRJM2VT1ACfs7A2qaKBJpt9+eoPK
X-Gm-Gg: AY/fxX5KLWWoSmw89SeALXgEHJbA9ybgIWh8y2lo7bYPqXmL+iPENhYFhPg/hAGByGK
 DKbNYzNlb5RcG83wvz+vFJXPa5Fdq5YvSndoBkU4gr73RoJL5uKkrxoduVQLxdEwlNBEtuO52jK
 dDniOLwqlnFBV6upYUrT48CqffmYoyCIFVnxNO1j20as1972zRmm9ZMcoyz0mM9q1YsBmao49cY
 4Kq9r/Avf/7G0HoxRZorspXoTIs5uug/3+GZ4kKS1J/beYM+PCpvEsU1er8bF6yeXO7s8SAOHFK
 /S67Nh43TwWSEJoALaZQm+5cP4IZ6+gzMeda/gFw/pGaij7dimmDpg56j2NY6SgG5RySvQt4pc/
 /SD+SNSwO6jjjmkMkcPfTfit+ZfrsJzpBW93YdBQYzJ87CFECUmbLol5kkH8CI2x6WfUnO6Xu01
 KGFOY1WOg2vOgYlNE=
X-Received: by 2002:a05:6000:402b:b0:430:f6c0:6c5e with SMTP id
 ffacd0b85a97d-4324e4d013cmr26755165f8f.28.1766829041324; 
 Sat, 27 Dec 2025 01:50:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlG9oVmfpeGCQmN23pt/pr4g7uDeJNmyQmcCnH+Yw+SOyTFiWrgMhzvt3zQv3Nj47CRhxLlQ==
X-Received: by 2002:a05:6000:402b:b0:430:f6c0:6c5e with SMTP id
 ffacd0b85a97d-4324e4d013cmr26755144f8f.28.1766829040764; 
 Sat, 27 Dec 2025 01:50:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm49215690f8f.8.2025.12.27.01.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 130/153] target/i386/tcg: add a CCOp for SBB x,x
Date: Sat, 27 Dec 2025 10:47:35 +0100
Message-ID: <20251227094759.35658-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is more efficient both when generating code and when testing
flags.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 13 ++++++++++++-
 target/i386/cpu-dump.c      |  2 ++
 target/i386/tcg/cc_helper.c |  6 ++++++
 target/i386/tcg/translate.c | 13 +++++++++++++
 target/i386/tcg/emit.c.inc  | 33 ++++++---------------------------
 5 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fc634883649..697dde375c6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1565,7 +1565,18 @@ typedef enum {
     CC_OP_POPCNTL__,
     CC_OP_POPCNTQ__,
     CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
-#define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
+
+    /*
+     * Note that only CC_OP_SBB_SELF (i.e. the one with MO_TL size)
+     * is used or implemented, because the translator sign-extends
+     * the -1 or 0 value that is written in CC_DST.
+     */
+    CC_OP_SBB_SELFB__, /* S/Z/C/A via CC_DST, O clear, P set.  */
+    CC_OP_SBB_SELFW__,
+    CC_OP_SBB_SELFL__,
+    CC_OP_SBB_SELFQ__,
+    CC_OP_SBB_SELF = sizeof(target_ulong) == 8 ? CC_OP_SBB_SELFQ__ : CC_OP_SBB_SELFL__,
+#define CC_OP_LAST_BWLQ CC_OP_SBB_SELFQ__
 
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
 } CCOp;
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index ed8fd363c6b..9e290c0b9b4 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -91,6 +91,8 @@ static const char * const cc_op_str[] = {
     [CC_OP_BMILGQ] = "BMILGQ",
 
     [CC_OP_POPCNT] = "POPCNT",
+
+    [CC_OP_SBB_SELF] = "SBBx,x",
 };
 
 static void
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f1940b40927..1e022da7b02 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -84,6 +84,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         return src1;
     case CC_OP_POPCNT:
         return dst ? 0 : CC_Z;
+    case CC_OP_SBB_SELF:
+	/* dst is either all zeros (--Z-P-) or all ones (-S-APC) */
+        return (dst & (CC_Z|CC_A|CC_C|CC_S)) ^ (CC_P | CC_Z);
 
     case CC_OP_MULB:
         return compute_all_mulb(dst, src1);
@@ -246,6 +249,9 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_MULQ:
         return src1 != 0;
 
+    case CC_OP_SBB_SELF:
+        return dst & 1;
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return dst;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d3e5e4d8edb..5aa38a912bd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -304,6 +304,7 @@ static const uint8_t cc_op_live_[] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_POPCNT] = USES_CC_DST,
+    [CC_OP_SBB_SELF] = USES_CC_DST,
 };
 
 static uint8_t cc_op_live(CCOp op)
@@ -938,6 +939,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         size = cc_op_size(s->cc_op);
         return gen_prepare_val_nz(cpu_cc_src, size, false);
 
+    case CC_OP_SBB_SELF:
+        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst };
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
@@ -999,6 +1003,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .no_setcond = true };
+    case CC_OP_SBB_SELF:
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
@@ -1078,6 +1083,14 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         break;
 
+    case CC_OP_SBB_SELF:
+        /* checking for nonzero is usually the most efficient */
+        if (jcc_op == JCC_L || jcc_op == JCC_B || jcc_op == JCC_S) {
+            jcc_op = JCC_Z;
+            inv = !inv;
+        }
+        goto slow_jcc;
+
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
         /* Mostly used for test+jump */
         size = s->cc_op - CC_OP_LOGICB;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8dac4d09da1..0fde3d669d9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3876,37 +3876,16 @@ static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
         return;
     }
 
-    c_in = tcg_temp_new();
-    gen_compute_eflags_c(s, c_in);
-
-    /*
-     * Here the change is as follows:
-     * CC_SBB: src1 = T0, src2 = T0, src3 = c_in
-     * CC_SUB: src1 = 0, src2 = c_in (no src3)
-     *
-     * The difference also does not matter:
-     * - AF is bit 4 of dst^src1^src2, but bit 4 of src1^src2 is zero in both cases
-     *   therefore AF comes straight from dst (in fact it is c_in)
-     * - for OF, src1 and src2 have the same sign in both cases, meaning there
-     *   can be no overflow
-     */
+    /* SBB x,x has its own CCOp so that's even easier.  */
     if (decode->e.op2 != X86_TYPE_I && !decode->op[0].has_ea && decode->op[0].n == decode->op[2].n) {
-        if (s->cc_op == CC_OP_DYNAMIC) {
-            tcg_gen_neg_tl(s->T0, c_in);
-        } else {
-            /*
-             * Do not negate c_in because it will often be dead and only the
-             * instruction generated by negsetcond will survive.
-             */
-            gen_neg_setcc(s, JCC_B << 1, s->T0);
-        }
-        tcg_gen_movi_tl(s->cc_srcT, 0);
-        decode->cc_src = c_in;
-        decode->cc_dst = s->T0;
-        decode->cc_op = CC_OP_SUBB + ot;
+        gen_neg_setcc(s, JCC_B << 1, s->T0);
+        prepare_update1_cc(decode, s, CC_OP_SBB_SELF);
         return;
     }
 
+    c_in = tcg_temp_new();
+    gen_compute_eflags_c(s, c_in);
+
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, s->T1, c_in);
         tcg_gen_neg_tl(s->T0, s->T0);
-- 
2.52.0


