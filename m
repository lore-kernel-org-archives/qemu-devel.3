Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B272EC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpd-0007lx-CX; Wed, 23 Sep 2026 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnv-0006mf-HM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnq-0003hi-Ku
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sbr6D52DYyEcysDu/13ACnGhICxj2RMwy7hEFb8nKI=;
 b=HXOQxKIU36t3EwEYtJhpdVNOW0hY+ishIKhN96S4rawfk9D2v2WNpxWWr9YQj1R4i2Nvs6
 +ogLbPlh0tRmLTs8AwxTQN7BlbVh9YA1WayS100ymmVEdvOBvl0QZ5TdNPF5utwcRqiJpE
 ZthnM+9h69Ee/N2OV81pG2B+aJjITKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-GxDT-29cNpGsikk-wJSp9Q-1; Wed, 23 Sep 2026 13:30:35 -0400
X-MC-Unique: GxDT-29cNpGsikk-wJSp9Q-1
X-Mimecast-MFC-AGG-ID: GxDT-29cNpGsikk-wJSp9Q_1790184634
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48709a1fbd0so868091f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184634; x=1790789434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0sbr6D52DYyEcysDu/13ACnGhICxj2RMwy7hEFb8nKI=;
 b=ItEcwdXWZV1iqxKKIHKVKLtzvxiJrz5Og8mYeUoHEleqauJB3iA5ScaEHjguXA3wHL
 RXagBNMPcYMIE2kDwO4BBhsJ089XNoxrDrSPINj2fS8VdvducBulGCekwThgTSQF3Aft
 AoTAovwiBtbQQtMDukqyeDJWdTyYeUlWL8AGwPiz+UNa88n6MSe5u9f7G+Oi/MnsUJqV
 xd3+MqA5z1USx+igiO+2KzdjVpa808q9rJi4e57MvCmjok58dDg0KUSg01Ich4ybUwlb
 PvxBmY2EiiJsA7E1rm9Fl/Kdlb5EIHwc/JctXggxwOS11Adz4KGtSp+DuBZLRQSCB50V
 SayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184634; x=1790789434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0sbr6D52DYyEcysDu/13ACnGhICxj2RMwy7hEFb8nKI=;
 b=jQlD0HZvvqFw6P8klfFFP4+KYQfiVT1JabcSlNnzK5+sb5nCoQ89Ff7WymPc3Dw4Tz
 1r5aFgN9eQvZgWviUR1TBgCrll+f0hmi+rlbX0Wr5ck6ruL6yzvHEbpZRTJJor5nCtrq
 0t9bTZuwq8xGn/XdcXkVkfB6NX+c11OPn4mTFVchoGcwWUaTjqSyes/FFuKTOQcNUwfi
 Y2BrX7WcQVHs6LMv8lTVHEWzQlz9GfqaV7Fn5Jex1b2TFZJFN9TCFEzEx6ce2j6cF9Dl
 0ajr6spB20NeUXw064Xa0z9Mg79b/UkYoUjc2D3iv5IhnlykttQ93yxn96tvW4raDeLN
 /9cA==
X-Gm-Message-State: AFuF++neerN6BQPqHLSXIolQJsj7tQ7GVOQuTJoGioVfeH+t3A+Juvhc
 nFHxYUZ/pt9+hXcDrdpOWvm2Vjya38/PQTjIfTb0JFb8Igj5ThJjMLsGAtppyNIotjZMPFvkEUW
 GVmlNhlmlTdKyRAi2VDnjGAWcdcwZD0ZeYPyENqBCMPB+ofAItzc7UF7V1opNaaGG2sVccITXvp
 jp/AUt6dLJnRXdVqg9mJPFsOG46IrPLsS2k0MFaVJB
X-Gm-Gg: AYBFou3JKuRvslFHj1cREoN8tGj09lylwGg7xk849HWLMjom1Y9ibAPPQ2LuK0zbdil
 a7nd6EUr/pqX30+trG7XfZ06ajl0Hy3yCvBjf/FuyjFIDQZGUE3njAUoNWvdOYJJWalza2DvzWA
 vwUohtzqOrtJbnQPxnwXyhn+V3pZBvYD23osmBL5bfB6ac5vTMrTU3t7tMAwk8BIy/CgZSrF2MA
 olywCQUNB6gNFu9Ys1crAQUH++5A1xt4RqQjGEOgXzLktzbAmfESE1gO+RcxPtZjW1lp9VNR/lN
 g89E9V5dvC8zzsAI+LwrRjI3CBs9Dsu+QbhHDsr1Awu+eMv8iv5uYoOdfeahhn/KRYwT87ykSY6
 qPQMRvaG4+8ZIHO8n3s+k8vNeAmWxbyd243VMT/p9uKBDyOqRi/RC0rdZQyJGJSbEzLN/s++l2q
 W6a/eI
X-Received: by 2002:a05:6000:4906:b0:488:54ff:67c9 with SMTP id
 ffacd0b85a97d-4886709dba7mr6055971f8f.46.1790184634220; 
 Wed, 23 Sep 2026 10:30:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4906:b0:488:54ff:67c9 with SMTP id
 ffacd0b85a97d-4886709dba7mr6055927f8f.46.1790184633783; 
 Wed, 23 Sep 2026 10:30:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863fbsm7583082f8f.11.2026.09.23.10.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 04/17] target/i386/tcg: unify MOVBE and BSWAP generators
Date: Wed, 23 Sep 2026 19:30:08 +0200
Message-ID: <20260923173021.317809-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

APX allows register-to-register MOVBE, which is normally done by BSWAP
(except 16-bit is also allowed).  Modify gen_MOVBE to also handle
BSWAP.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e4700473c9f..5a880b9760e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1435,17 +1435,6 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
 }
 
-static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
-{
-#ifdef TARGET_X86_64
-    if (s->dflag == MO_64) {
-        tcg_gen_bswap64_i64(s->T0, s->T0);
-        return;
-    }
-#endif
-    tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
-}
-
 static TCGv gen_bt_mask(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -2519,10 +2508,19 @@ static void gen_MOVBE(DisasContext *s, X86DecodedInsn *decode)
     /* M operand type does not load/store */
     if (decode->e.op0 == X86_TYPE_M) {
         tcg_gen_qemu_st_tl(s->T0, s->A0, s->mem_index, ot | MO_BE);
-    } else {
+    } else if (decode->e.op1 == X86_TYPE_M) {
         tcg_gen_qemu_ld_tl(s->T0, s->A0, s->mem_index, ot | MO_BE);
+#ifdef TARGET_X86_64
+    } else if (ot == MO_64) {
+        tcg_gen_bswap64_tl(s->T0, s->T0);
+#endif
+    } else if (ot == MO_32) {
+        tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
+    } else {
+        tcg_gen_bswap16_tl(s->T0, s->T0, TCG_BSWAP_OZ);
     }
 }
+#define gen_BSWAP gen_MOVBE
 
 static void gen_MOVD_from(DisasContext *s, X86DecodedInsn *decode)
 {
-- 
2.55.0


