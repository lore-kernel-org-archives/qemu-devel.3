Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FEC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHX-0004fj-Kn; Tue, 25 Aug 2026 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHV-0004fV-Lt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHU-0000Gh-2s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcyMmZEfNzdyoJm+GiWJ/XuB8ugXsgxUdEvqfhgkWHw=;
 b=jGXaZCJOIlMAo4M83iqYkL+27l9TMoWTOQH5ti3LvsbC84B2/JD8cEpwRSrGAJYAEGBnFL
 iRTV69SIu3l5KRV8ajRzRjuPFupt+AWSbPurcmaYEuaGplO+PhucSDfQEE++md0tsnCqn2
 Bd45bT3HnM4tAvj8ssuPHEMEgRw0h2U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Ns73Kp5BNWWzkI6Bl1kI6A-1; Tue, 25 Aug 2026 08:29:29 -0400
X-MC-Unique: Ns73Kp5BNWWzkI6Bl1kI6A-1
X-Mimecast-MFC-AGG-ID: Ns73Kp5BNWWzkI6Bl1kI6A_1787660968
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15ceb17a28so355740666b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660968; x=1788265768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xcyMmZEfNzdyoJm+GiWJ/XuB8ugXsgxUdEvqfhgkWHw=;
 b=NYTeg+9LJV3C3uP4+vbPKcdih6e/XjtJHgat+q0WDxPdGZU8UVAaNkxWJ5r8pMu80T
 OCBJYOwjz9pjwdtHAdU34uC4aNt9c4dHe+nH07qTwiHIT25E4EMMwBDUm3mGIVbGx8S8
 FZ76ikUowojIy/ue8Tp90sVbLzKYR3Ev/p2shCXz7+SnWIwcme8jfZzGJGjIzOQ/WqVf
 +7oAUK2TXmcuIeAaWxb66C4tNuVJeWUCo8c5ddiSKRvB8160sKQm/s7JFMZcP1bSmObf
 ACNM5EOkBDLgOL74cbLH6mVcI7ssfV1LXlkNmeHOvwtcnlTKHHgJ95JWH82ckEcPC6cd
 Of8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660968; x=1788265768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xcyMmZEfNzdyoJm+GiWJ/XuB8ugXsgxUdEvqfhgkWHw=;
 b=g9PqGo3rCy+qBo8+YC1A7awkFuVYaXdayjH8TCLmvKmyMEydUI389SZevWDoxzQDuj
 2fqauRqIbEQUzoGl/3bvbeHXHb9uQMuMR4tHWgis9VaG7s2JJTgnUT5DBFFPs0KSQs/q
 1/WFXO562TpGWmTr7whLBt4MffL2wrKhIUidmJYCb82jGDsQLLGzvOdGw+dHg3ulkaFJ
 tyLZZspqfhDJF6yPKz+/3Pnw8L9YqhYT628bLUqKnuqzi7j3GQohvh8LziQcR5IiIW4h
 FpUbcwGb+Yik0Xcl43JNgpYyiVGYuEHmLQMHX7uPvc11HVhuri1H9ZCwLo30FciblI16
 UKdQ==
X-Gm-Message-State: AFuF++nGJBUV+lvZc5wPuyb4aHamPTYJdrlrh9usI5PTICd59AH0dBl0
 uoz8eaFEHAGg1TypiWzwsI1dI+S+pcADEB9WOOZlBPj6tel60g2QxBP/S3ePQSp+ahc1Iqhp25o
 +4ciUqacvdgc3nFfz70Ci02PpWFulWV48/qNVuu3qzoudjdDeryWGstGtYFO7+PktZjYXLGc3Lx
 ywwbOObPdk4wxq3HjG8tf64m6jD+GkpnwB2+a3h8/5
X-Gm-Gg: AR+sD10cRef9ttZpm8WYedaT/2ShHo9oJ4iWSs22+1SghtEBe+Jr9j95NafJ+Wy5Wvu
 c1qQH/PElOFk4fas6ML+y+QdMlnE7YaoT8k8gK79xmKSGevYAbksGCyeVSB+X931iqnvpwsHe03
 3VK12GDqWZjtwjCf63zDkckfORlipsimqP8LSXB5YZlWdNEU9xbEAULuEzlI1fjBJd77cC6jsX2
 uZYCStVbvC/Fs03kxisPWh5aObjVXjqCGMUNY8lDZJP1eGZ/SKZoE0ixRRO42gcEMUndEWvZi4W
 EsRcEYjP0KwmRcuUI+gXI3xQoFHEpPu+tGenYB+DkynZ5VnHsGx3kal4xOO2CxTaAYRqKyedtl7
 jqunjXU/NrVyzVa72xZGquJyfQhoEaa2pO/qDrGCYIvpDUZNRwq1+MgPLkJ7ztJzfLl35sCwcxf
 PL6+w=
X-Received: by 2002:a05:6938:a08e:10b0:c21:7584:fc58 with SMTP id
 a640c23a62f3a-c24e5b5531emr510039866b.12.1787660968279; 
 Tue, 25 Aug 2026 05:29:28 -0700 (PDT)
X-Received: by 2002:a05:6938:a08e:10b0:c21:7584:fc58 with SMTP id
 a640c23a62f3a-c24e5b5531emr510033966b.12.1787660967676; 
 Tue, 25 Aug 2026 05:29:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496296cafsm1823489266b.14.2026.08.25.05.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/20] target/i386/tcg: inline gen_ext_tl
Date: Tue, 25 Aug 2026 14:29:03 +0200
Message-ID: <20260825122921.431739-3-pbonzini@redhat.com>
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

It has been mostly replaced by tcg_gen_ext_tl(), other than for a single
appearance in gen_op_j_ecx().  No need to have a separate function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++++++--------------
 target/i386/tcg/emit.c.inc  |  4 ----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d1791550772..70f9bb42209 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -640,23 +640,17 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
     gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
-static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
-{
-    if (size == MO_TL) {
-        return src;
-    }
-    if (!dst) {
-        dst = tcg_temp_new();
-    }
-    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
-    return dst;
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
+    TCGv cmpval;
+    if (s->aflag == MO_TL) {
+        cmpval = cpu_regs[R_ECX];
+    } else {
+        cmpval = tcg_temp_new();
+        tcg_gen_ext_tl(cmpval, cpu_regs[R_ECX], s->aflag);
+    }
 
-    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
+    tcg_gen_brcondi_tl(cond, cmpval, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 968abd47a73..c83ab809408 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1686,10 +1686,6 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
         ot_full |= MO_SIGN;
     }
 
-    /*
-     * cmpv will be moved to cc_src *after* cpu_regs[] is written back, so use
-     * tcg_gen_ext_tl instead of gen_ext_tl.
-     */
     tcg_gen_ext_tl(cmpv, cpu_regs[decode->op[1].n], ot_full);
 
     /*
-- 
2.55.0


