Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79668CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoCy-0006Qr-9r; Wed, 30 Sep 2026 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCo-0006PW-Ga
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCl-0005J9-D2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jW131SUAZL4r1wNAL31jTOYaxYTkRe/vwBhIXFgW3wI=;
 b=jFAimNneUx2xRUhM22UfuWBi1PgHdjqr/yK3Vyw2n2Xu3fkUp5RZzLola9xzPpGUqR1mna
 /KqCxPbZ5vEgkjMk63KbjrtuLH4g31OedikN8sVw9yAyq2OQco4f/VmYOYYsfZOQb5gxiO
 J2VLYmUWasr3S67AaMXxw5j/e2lg9z8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-zR7uEdsnP-26tcq9E7J-xg-1; Wed, 30 Sep 2026 02:54:11 -0400
X-MC-Unique: zR7uEdsnP-26tcq9E7J-xg-1
X-Mimecast-MFC-AGG-ID: zR7uEdsnP-26tcq9E7J-xg_1790751250
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so36941185e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790751250; x=1791356050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jW131SUAZL4r1wNAL31jTOYaxYTkRe/vwBhIXFgW3wI=;
 b=YeQEYZ/32c/JhTGtTJX0q9BwsAHYy6nXZdsm35GZp9rbc2olmABIP35JKzcpEdX6Uv
 pMMlOtRRncTC1Th1Eu1H83vwdazl/GFnA0ypCtM2ueXIdyThbWFtuG1GtOpWvxYJvO6G
 Hz2CwkMT5SyBOcQM6W6jmmsOyJ0rC+DcWCFty44f9g3dBTVnDlfyUPnys4rj3pFcHM0o
 bCpooBm9seV8JoxyG2EG+/RCGOq7eO7HXXFykIjD4eFTJf9tYqkJkBVjyWPSbQrugpcW
 CURnbPA6QRVfc5M/iBZtbLksW4DR+s6hZPwzE9X8WbvaFpfAaPUe3iwXPewdJKF7m3RN
 LiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751250; x=1791356050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jW131SUAZL4r1wNAL31jTOYaxYTkRe/vwBhIXFgW3wI=;
 b=nf9801SejhjesbBU5DA13KmZanBDR6q9CkvF1cRazCnaR2zZ0XKpls5GQP4oauZ1Nj
 Fdn0LmGIWpu3lHpJ8Gpiwu2t81d8cD2QquUjx07hBLdviLtQH/Z01jAO6v48pjD9eTuF
 cljRKGqr+4mC7td1+ELsLwLiPkxQ09xqJCl5rhJa7+TjbwTI64yNAU+lpuQmnGq+m+60
 vM9scy744OuB/ZVfpxPMyeO+RxQIAfUBKWxgjmc5xo83QxyOsNV/tUSneev6ykTOxqc7
 5O9thmD1oe88Iqwba5src9nmaWFny/LXtlbIzRiBBpUmzkDCVRIiW0HWM9DcQaQq/rIN
 BmRQ==
X-Gm-Message-State: AFuF++nH79M676qGQU0Vb+HIFSbV+QZlFyfqmoCjJTk0VKHZtMsVtwP2
 jYBjjjVuxoGLkpR++ewZdqAT9snK5OIayLSdChRlbM+ztMciLtr8n4Jrb8CgOv+Ts9tdmiSFU9O
 FPrlkucAiPFkP41QyGcruw/oxaXNhQUpqphz/rEouGgWrsVubOaymDdkr6mbVaJTn4VVQf7UlCO
 iA7O0VxIYgW5zHGJlhtrKQRvL9SQ2ceRzC0bq0kC9i
X-Gm-Gg: AYBFou3FpTiYCK01oMxS4R/j2TbLmMOQN3ftWC0YsOfwLv1i/TVOr7scKd0EdQ+408i
 NrtJzUhYwynQOct41LM6/StajCv7tsoccnSTB8P/8F6rAq9cxS9tCtX9QP1dxv+BMAzgOhH34Oj
 8cHleqID2OQgDimbVwudEOuD/MAp9AKGM1pwR3P9iX6x3fUGu0uMbVsV5fkeBn1OZOYqXj9KA3+
 bNDNKs8nO52kZ79q1rwmook7OA4HmwCisKFuqONK9YQl/BPyMzYRvTMGcZTy4yeEdNu/vPCkxjn
 axxxtJmMCPowy/udyT8xSf3DHdhQK+dqsI65MpEesLeUUXswNc8i/zamHDCHFgZsjHNYs9xqJvO
 MkxNhW+9b2dQNf2KMQ36QgJGV2M3U5m+YgnNPUYTYBEvDOmBcm81SVDApAz13zctbSc+WVriAY8
 TU+CVU
X-Received: by 2002:a05:600c:c162:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a01addecdfmr5255595e9.7.1790751250245; 
 Tue, 29 Sep 2026 23:54:10 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a01addecdfmr5255285e9.7.1790751249864; 
 Tue, 29 Sep 2026 23:54:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017bad33fsm21208245e9.4.2026.09.29.23.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:54:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH 1/3] target/i386/tcg: extract validate_cr0_exceptions()
Date: Wed, 30 Sep 2026 08:54:04 +0200
Message-ID: <20260930065406.738374-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930065406.738374-1-pbonzini@redhat.com>
References: <20260930065406.738374-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The checks on CR0.TS and CR0.EM must be done after all #UD checks,
so extract them to their own functions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 39 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e3..996e12d03d2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2742,23 +2742,39 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
         goto illegal;
     }
-
-    if (s->flags & HF_TS_MASK) {
-        goto nm_exception;
-    }
-    if (s->flags & HF_EM_MASK) {
-        goto illegal;
-    }
     return true;
 
-nm_exception:
-    gen_NM_exception(s);
-    return false;
 illegal:
     gen_illegal_opcode(s);
     return false;
 }
 
+/* Called after decode_ops, so that #UD for invalid encodings has priority over #NM.  */
+static bool validate_cr0_exceptions(DisasContext *s, X86DecodedInsn *decode)
+{
+    switch (decode->e.vex_class) {
+    case 0:
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        return true;
+    default:
+        break;
+    }
+
+    if (s->flags & HF_TS_MASK) {
+        gen_NM_exception(s);
+        return false;
+    }
+    if (s->flags & HF_EM_MASK) {
+        gen_illegal_opcode(s);
+        return false;
+    }
+    return true;
+}
+
 static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
 {
     if (qemu_loglevel_mask(LOG_UNIMP)) {
@@ -3037,6 +3053,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     if (!decode_ops(s, env, decode_func, &decode)) {
         goto illegal_op;
     }
+    if (!validate_cr0_exceptions(s, &decode)) {
+        return;
+    }
 
     switch (decode.e.special) {
     case X86_SPECIAL_None:
-- 
2.55.0


