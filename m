Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41DCA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB1P-0005bB-Mh; Mon, 28 Sep 2026 09:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0t-0005Kh-9e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0r-0004Ny-PU
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqfITIckhsSsexITlySNw/eWwXrgrWBFFC4E40/xu1w=;
 b=DzaHPz6US1CtfSTpSxcKwU/wWmAUtYLFfZyuMLSdBiNUuwQkmqVLd66VUkWFL4m6hOtD/d
 W06DO6lETBnWJNhG82OJoY0SdeOCj2nMxYyVmd8wmK3zp18QAqQQ+iiWwls163pRD/WkAi
 T+klh3tW4RUykSnrKNLnVPlJODscnd8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-1jaeiqxFPtmAakR48xhURA-1; Mon, 28 Sep 2026 09:03:19 -0400
X-MC-Unique: 1jaeiqxFPtmAakR48xhURA-1
X-Mimecast-MFC-AGG-ID: 1jaeiqxFPtmAakR48xhURA_1790600598
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c29959eb71fso304297266b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600598; x=1791205398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lqfITIckhsSsexITlySNw/eWwXrgrWBFFC4E40/xu1w=;
 b=nvQQCMRJn1uqQyjeNCQGCn9o3d4FqFzAENSnY4VuWW0AyG6EQ6H5c+Fnt7nNizxP0m
 XhNOFr4WfkRJo9LdEUQlLpDJ2Dz0rvv0gvNcJ2R3jdt0rYt++IQGGHxSCUUERqYJ76SU
 OYcmz/RM5Ki+P8PWIaJsglpJrZOOCHXmrF9x0ZHsFjSRHm6fmZea+ssHwNVVufk7sN87
 2D5jgGIpSIJv6ewEyghDEQwYD/75z46Jlde+n8wt8gz7i5HNSR186DYTDrTOQfQX+wpn
 1TgMj7pNKavEnmRrAMcQPA225Qj0hJrE+qiFPhqOf4qDZ//lstzy1NCIAx87rH4a1gnL
 UWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600598; x=1791205398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lqfITIckhsSsexITlySNw/eWwXrgrWBFFC4E40/xu1w=;
 b=ZBiPcIAtBkTV5TT/GoG9iUoO+MM1MWRvRREWZb+vwA3vvQq6TAqUUsfw2KMoIe/jEw
 L63kn10Yj0hKdq1AHCM6OvSIhggOPk+RkQ68EKKKXCwdA2wfby42q+6k9dpNT7uIWFrT
 rC7HrSRICxmpfCG9tBe9Xt69qabX4dsfQ/Ms1EvfBwlJ1c26PLLQo6bztQgwV+/DHQzm
 AcQH/f1iEHPHdtsNheE8L7rtJVItZ3UMY4mZoyDxLsgxeOAEOCikASx+ezc6eHcnVzIU
 1WCFbL8msTEhQG7MSQnpRxuJ7KGFxCzKH75ww007+lx1DIjkh4b986WPCJXklJxqvC0A
 pasQ==
X-Gm-Message-State: AFuF++lVMmUYJGtPiLn3qbvPzMPbHhJLs3JoLDK7ALaHrXUlLfjvx3J2
 vCj8Y9YLcPd8uydUSjVyqOU7Y9L/1YvYrxyF4GiVU63TGfs3V2LKBEiGfAovNG4w4C3ODwGZPKa
 PtdGpMsgT9/UEYDeesFJYmMrKssxYwJcnMywsUnKmxlErsQeS+QWh6Fnh080NfuSINIQBDx6aAi
 5sxsDuMRNOVG0enz2VsfOd0GUDsf5YlmjO/3o4J0m/
X-Gm-Gg: AYBFou1sVj/cqqSGllZKZ1G6Rgn1R+cBico/Fd0xq+u0b9quBKBayAg/EZZeD064u4S
 SadQUOGuXt026XJw9UmeXOTyjcNyGI3wgrm258IGKokMJdTdYDrrck484ZRMZocuB3sdLYJMFcQ
 7SNSrHvDMPcPO2oqPU2kYS3CzxJPuU3lztSyDS4H2N9/3VeOOJSk8PioYVUFO+Z2Az04XxOWiHV
 +q44qvlmIERNw8iEhikz0Gj6YM0ZlhTXQA3RbgVlSt5pyyT5n517Q2Xe3bLH2Xn5U5FLcW/5qvp
 wR3428crq6b2aGLrGxZxjZRQLXRepd578hVtpFB95QBQLeWC0Ix6p5WjJwX7mBPjwi8X2rO2/YH
 ftbHR3k+KmTZz13P89oZm2UoazAuFLm20ItqvTnKhCDER6YvmhbvWzj9Rwk71n84DuPdH61FU2Z
 9/w/hL
X-Received: by 2002:a17:907:9487:b0:c25:cb7a:12d6 with SMTP id
 a640c23a62f3a-c2ac528c69amr905544866b.14.1790600598185; 
 Mon, 28 Sep 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a17:907:9487:b0:c25:cb7a:12d6 with SMTP id
 a640c23a62f3a-c2ac528c69amr905541766b.14.1790600597678; 
 Mon, 28 Sep 2026 06:03:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2bf3c6ba9dsm327241366b.13.2026.09.28.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/30] target/i386/tcg: unify MOVBE and BSWAP generators
Date: Mon, 28 Sep 2026 15:02:13 +0200
Message-ID: <20260928130228.877003-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


