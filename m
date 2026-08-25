Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D28C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHW-0004ff-It; Tue, 25 Aug 2026 08:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHU-0004f8-8y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHS-0000Fk-1Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agyvsEgRoH86yWxlKsSyP4w5XhhdItqtvJol0QfbWWA=;
 b=WB/mFpjdBRlgp4rY2WRYGk2nc2fxFTNvB85i+mWE8SWO6TnLGB4VFuIPsouqOE8oD9onn4
 qJzI/6Yd8PLfsD1WkHO3MxAZQam5sccQ8LarsbQjlAdTPq6ItuppFexx7RLuckIvEGP4/r
 vLn8xPY4M4pNINuNzEFn3zjByrVxy0I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-TJhou4S5NkuqEKPoc22svg-1; Tue, 25 Aug 2026 08:29:27 -0400
X-MC-Unique: TJhou4S5NkuqEKPoc22svg-1
X-Mimecast-MFC-AGG-ID: TJhou4S5NkuqEKPoc22svg_1787660966
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c21946c03e5so82093566b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660966; x=1788265766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=agyvsEgRoH86yWxlKsSyP4w5XhhdItqtvJol0QfbWWA=;
 b=SKCxcrNkAnC4LbwEN3DtSIQHuT7IuffitFW5q1D+7w5lKM5YqcBWm1peRUWU538/Dh
 v0JSRIpuY4lOGFzUCUGKDI4n6DWCJlAbj0vXIJXvf3hP1EZlus7FydnjYPaaXnxup0Zw
 vjjTVJYV0//Uvm56Ma02IEQxqB8WK6qRgvavPGlkXW4IvrXLBm39pt3hXfo6rDgO6eCM
 t+l5oAg/v0cdNSmo8fZZUpjkSybHCHQIORdyUlAdplcpgxj8AEgojcxyi1kDHQgln+DA
 jSrwAmPMaEvz6/8mLSOKmQdnb2SuwcYD5qFAwoUGqMe4kX2FkBKYfblvr/rFAdKkixq4
 u1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660966; x=1788265766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=agyvsEgRoH86yWxlKsSyP4w5XhhdItqtvJol0QfbWWA=;
 b=Tg4DC8D7x+u0NNd4bn6bUKZoXPeaXxA0WUx8tiaQEZlMFl7TzITrlmMjviB0pPpWXH
 TgJWr6u83/uSTWbIGNArIaKxz54XXdnmaJG7cZCgVJgJz8smEUKmeHyc5Im0/Ix8pJe0
 YK+2XiufSatHU8LbEVPDHP+th7fwrZsgOscwmfNixIkaVKA9qjOFlswpshNxOhpIQQdP
 vizwv1HK3GOYX09BFYurmHdfEohrA1PLBH6waeiHTAmGENFrFuGQ0aiGwLEu+enG5aO7
 69j46HnUXj7qCfTo+THZe/jk19GX2k88MWzNTTREgdrRLThjXJnL9YjxXwudyiiI79/P
 4uXg==
X-Gm-Message-State: AFuF++mZzP8MFZwM/4fhDdnCx88dqEcOdIyJISjYXUGiTLM2eg68jYBA
 F5Vw1WCPtS/wV27DZHD7BKXFHquDHpZ6/KF1tmCdURVEMt9JcYos6RX7EMYgwMAynGTNJzPhYZw
 nG0clFaBTwxoZjaj8msL7StkDas2PKrVstHDVuNZL3+VnVC6QMYSPWaGikBauk8mqu04x8MhiXs
 64kcOZeP4Xw4JosPhWfDq9j+9gq/0XhEYyC6SckpW4
X-Gm-Gg: AR+sD12KT+1aHb6X5z8s+FU8FznCyH5Meo8n0nEz27JxYHmjmWgIDdd1K+mDWUu+kWH
 APMyN4cIVozBhQtzGwHtbCYZM8zcCOzWYJgzaoCvYFY1bntTaPrzH1DWY/QFW3mOTTsLRU6m2Wx
 Uf3uT4mUXoKy4R/UWO4bYvGFku2vPHLepa2DxQhd1B/ZClTNv7tr1whLRDM8TVAe7ZAX88rmeOk
 cUf3KiSKnffM0TuslrjXmdmccUEpqBbbAWFghaV2P1iJ1i9dV/2G1V4jxh1PTQFSRzyfZbce9dK
 1RJpoGrRMqaNugivH96HR24JaNyY3B1/oLS4kXY8BVsgx4Efc8T62wAEQIapYQPDsKm7WCmoNN6
 HbjujWPV58+T9/B5vt9B13q6qQkP8nu4V4/6QKCAb2jF6HS07ABRRGzCcfGpg38GXgDE/cfi9UI
 0lvJU=
X-Received: by 2002:a17:907:9619:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c24e2df3d90mr623853166b.10.1787660965811; 
 Tue, 25 Aug 2026 05:29:25 -0700 (PDT)
X-Received: by 2002:a17:907:9619:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c24e2df3d90mr623847766b.10.1787660965289; 
 Tue, 25 Aug 2026 05:29:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496297c7dsm1717386866b.20.2026.08.25.05.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/20] target/i386/tcg: do not reuse cc_srcT
Date: Tue, 25 Aug 2026 14:29:02 +0200
Message-ID: <20260825122921.431739-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use a different temporary for every instruction that uses it in the
translation block.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c |  6 ++++--
 target/i386/tcg/emit.c.inc  | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2115c5cd24b..d1791550772 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -342,7 +342,7 @@ static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
         tcg_gen_discard_tl(cpu_cc_src2);
     }
     if (dead & USES_CC_SRCT) {
-        tcg_gen_discard_tl(s->cc_srcT);
+        s->cc_srcT = NULL;
     }
 
     if (dirty && s->cc_op == CC_OP_DYNAMIC) {
@@ -1236,6 +1236,7 @@ static void gen_lods(DisasContext *s, MemOp ot, TCGv dshift)
 
 static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    s->cc_srcT = tcg_temp_new();
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     tcg_gen_mov_tl(cpu_cc_src, s->T1);
@@ -1248,6 +1249,7 @@ static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 
 static void gen_cmps(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    s->cc_srcT = tcg_temp_new();
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
@@ -3484,7 +3486,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->cc_srcT = tcg_temp_new();
+    dc->cc_srcT = NULL;
 }
 
 static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766f..968abd47a73 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1699,6 +1699,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
      * - s->cc_srcT: memory operand (lhs for comparison)
      * - cmpv: rhs for comparison
      */
+    s->cc_srcT = tcg_temp_new();
     gen_set_label(label_top);
     gen_op_ld_v(s, ot_full, s->cc_srcT, s->A0);
     tcg_gen_sub_tl(s->T0, s->cc_srcT, cmpv);
@@ -1800,11 +1801,12 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     dest = gen_op_deposit_reg_v(s, ot, R_EAX, s->T0, oldv);
     tcg_gen_movcond_tl(TCG_COND_NE, dest, oldv, cmpv, s->T0, dest);
 
-    tcg_gen_mov_tl(s->cc_srcT, cmpv);
-    tcg_gen_sub_tl(cmpv, cmpv, oldv);
-    decode->cc_dst = cmpv;
+    s->cc_srcT = cmpv;
+    decode->cc_dst = tcg_temp_new();
     decode->cc_src = oldv;
     decode->cc_op = CC_OP_SUBB + ot;
+
+    tcg_gen_sub_tl(decode->cc_dst, cmpv, oldv);
 }
 
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
@@ -2722,7 +2724,7 @@ static void gen_NEG(DisasContext *s, X86DecodedInsn *decode)
 
     decode->cc_dst = s->T0;
     decode->cc_src = oldv;
-    tcg_gen_movi_tl(s->cc_srcT, 0);
+    s->cc_srcT = tcg_constant_tl(0);
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
@@ -4114,6 +4116,7 @@ static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
+    s->cc_srcT = tcg_temp_new();
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_neg_tl(s->T0, s->T1);
         tcg_gen_atomic_fetch_add_tl(s->cc_srcT, s->A0, s->T0,
-- 
2.55.0


