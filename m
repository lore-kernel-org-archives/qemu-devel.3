Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C2C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfD-0001ey-TZ; Wed, 09 Sep 2026 11:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfC-0001eP-2o
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf9-0002qa-Uz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cdb/tr56eVLilxXQOAAtT08NGtDN7d8H2xoi0GsgBFA=;
 b=PElm/o+qBaXwz7WDwTrb8QVRvYxqqmeCwIQSlBS7lqZM514GbZmOzdrTYVr0fsC7Vw4WF6
 +eu3PVfl2YZDGJMwXsu1py3lg6pe9kqTA2JkFknoZ0yPEe1r3fOuMvrv1N1dKA3iM1Tcfs
 5bMPxwC2eV+v+lU0sifXgEb5Ks22HG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-5bwpvL02P9WXkyZ29fEVBw-1; Wed, 09 Sep 2026 11:56:37 -0400
X-MC-Unique: 5bwpvL02P9WXkyZ29fEVBw-1
X-Mimecast-MFC-AGG-ID: 5bwpvL02P9WXkyZ29fEVBw_1788969396
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e05af072so5025008f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969396; x=1789574196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cdb/tr56eVLilxXQOAAtT08NGtDN7d8H2xoi0GsgBFA=;
 b=gESugly4NPlwOZbm/EuzpgNmZ4+MzidUZ15Cp6dmI287nApnU79gRcbPFZqQuWCAlZ
 +Wb6cQsIuUfiBCBmCkfYGsp5Q6DeWn6EoB5KVjkARmTqcai3LStM80JFhi+2l4QcW3+b
 6e/8rjfay/85edd7CHAJusM0s7v+41zFxRo694Sbqb4JrJBswj4jDpjcNjkQL82FqPHl
 qnHBn6dnSVu1QPtjD7RgOaNFOFGyyJJekh0gIoUcxpNEAUZ4i2u/PNLqWQx/1oUa2yUY
 KWEn8+Q5o/XJhMA0qFrFpJG39UddCWM4d5AEESDBBwNs7Vvc0H9Ip3sMPv87rlzQR/fE
 VrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969396; x=1789574196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cdb/tr56eVLilxXQOAAtT08NGtDN7d8H2xoi0GsgBFA=;
 b=Z/dj7nCh9yj/pZcYveX8ph6s9zLb9+B/9HiNYI7xIErj80zEV8Gj/OjsdqvRQimxCa
 RgT0R0hRUMVVQTMvRMt3ukHozJwxBvvUNgXyjfM40Qey4LxN5N0yK8/gdX/jkaooYHvD
 DvgyikF3gqsIgWuHjXkCPSm23M+t3TSjbtnuyFWX+8/TlEaYMwDNtFAuW//ABFgPKAnb
 NX+ClzPateVeGnJteQJ9d7eynGgiy3ZvRtJsKsXd+v2mSlzK6ZJy8caecCSi1AiOe1yw
 VXsrPSzT/CQvXpYiMPVGC+b9iIYcmMigsm5Uncuvj7XMBhHsbTmuJa89A1zZbudIdMAC
 wh4A==
X-Gm-Message-State: AFuF++k4rw5hwT+iQX6/RYwD0Y+9P3bQ662TUix2PALK265fiiLht7V+
 VuQjOOZBUJMGtrWoMT1fuhqJADpfjMBGtPrvPSLT0EfcDzlIgfo+U373sbqBpsw9O/hVJ5jZ9W4
 VCU6GY+0sAoK74IrONwihKD6xLbCZZhHDCusbfhU20zMy+xi1UU50v+/nyJ0sxLNyZxGpepS2tW
 cT/7Z+zo5Bnth6MdrRoEQs//8Zb42gWX8UILepNRbe
X-Gm-Gg: AYBFou1N1J2GlKg0b+Je89qdL3HpfGoURjUrH7kxmLfaY7os+F2eIMW0gmj0Ipa0HFa
 djZk1l66nalEEF5vrZ7mxSm/lowDTPPQ318dyHNT3cIous9Tl5CCWdG4XWRXOxEsCMMveQyPgg4
 ATGVdILv94H4EBN0XmQUlaYD6v96MP65WW8C7KcDwa6f7TBa943WMIgHctJMbIWRnRzcmkGMYgr
 HYe/98W54t+kbtglBotemdFKpAIpTxElA/b4D44l1gX9CUThs/VG2Qv8UTelf/1Fh5XPUrIZjPD
 NfCnKycSpBR5rcaSrbDWKDYR5QZDXZJcPyr4K50joNj8aLtP3VJnMfG1/EBAU0ihjLhDIEdlLIt
 w5f/F5yYBgLWXKdYPIcn+objl8nLd8KshFC6nHIwoGl21cG6SzvlNSTpLPRCxvaFXJND8X5+GXt
 vLi6IL
X-Received: by 2002:a05:6000:1882:b0:485:8313:9f43 with SMTP id
 ffacd0b85a97d-485872b86b9mr39495998f8f.25.1788969396278; 
 Wed, 09 Sep 2026 08:56:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1882:b0:485:8313:9f43 with SMTP id
 ffacd0b85a97d-485872b86b9mr39495962f8f.25.1788969395834; 
 Wed, 09 Sep 2026 08:56:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm34734996f8f.11.2026.09.09.08.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 03/12] target/i386: Update FPU tag word for FXTRACT's old ST(0)
Date: Wed,  9 Sep 2026 17:56:15 +0200
Message-ID: <20260909155624.1082893-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
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

From: Simon Scherer <scherer.simon89@gmail.com>

FXTRACT writes two registers: the old ST(0) gets the exponent (it
becomes ST(1) after the push), and the new ST(0) gets the
significand. Both should end up marked valid in the FPU tag word.

helper_fxtract() only marks the new one valid, via fpush(). The old
ST(0) just keeps whatever tag it had before the instruction, even
though it was just written with the exponent. So if it happened to
be tagged empty beforehand, it is still (wrongly) tagged empty
afterwards.

Add a fpush_fxtract() helper that does the usual fpush() and also
marks the old ST(0) (now ST(1)) valid, and use it in place of plain
fpush() at all previous call sites in helper_fxtract().

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4395
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260901085839.138094-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 56fb94c957b..df16c54c208 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1814,6 +1814,13 @@ void helper_fpatan(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
+/* fpush() only validates the new top. FXTRACT also needs ST(1) validated. */
+static inline void fpush_fxtract(CPUX86State *env)
+{
+    fpush(env);
+    env->fptags[(env->fpstt + 1) & 7] = 0;
+}
+
 void helper_fxtract(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
@@ -1825,22 +1832,22 @@ void helper_fxtract(CPUX86State *env)
         /* Easy way to generate -inf and raising division by 0 exception */
         ST0 = floatx80_div(floatx80_chs(floatx80_one), floatx80_zero,
                            &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = temp.d;
     } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_any_nan(ST0)) {
         if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
         ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
@@ -1856,7 +1863,7 @@ void helper_fxtract(CPUX86State *env)
         }
         /* DP exponent bias */
         ST0 = int32_to_floatx80(expdif, &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         BIASEXPONENT(temp);
         ST0 = temp.d;
     }
-- 
2.55.0


