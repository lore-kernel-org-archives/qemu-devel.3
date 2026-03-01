Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644DDFD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi11-0000ZB-7H; Sun, 01 Mar 2026 09:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0f-0000P3-LN
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0d-0005lW-DB
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azZnkVp/NSVUI74ENWvUxmzX3QZO7A1ubP1tdWLgtW8=;
 b=Bhtc7AYCsFVVjthkaSWh7ZmBSHVQUnudAw/D0Di7a4HxByWmvE/S2jbSRl1aENB+qAgoO4
 YzOfBAt6DWpHSb1NrXywlYbzGVWcaIHpRPHQaSLuMyqrhGTMewJWPIz4Tb6K1gqrevw8Q6
 5t3PmrEgDI9cB5G2f3Chosj9xm8RP3k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-mZj38lEgNOSTlBb2MUpMvg-1; Sun, 01 Mar 2026 09:43:00 -0500
X-MC-Unique: mZj38lEgNOSTlBb2MUpMvg-1
X-Mimecast-MFC-AGG-ID: mZj38lEgNOSTlBb2MUpMvg_1772376179
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so43586965e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376179; x=1772980979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=azZnkVp/NSVUI74ENWvUxmzX3QZO7A1ubP1tdWLgtW8=;
 b=Mgu3Efwc+Zd8xSrFzp55BhsF92/81IEIX1m0abDqqRxRzwktRRwoHU3fMwHD9YzCVy
 /jy/bnK5msUdyEUuC9AFf237o8Z8gvuYv57jAwXc1RculjFoH7YmQ9hNSNZ28b3MTSZu
 OpqBSjnkqm+aPrUQcWjihxaaeVH1DgLzOTLFqfCt9bJrkjLatrw/R3sX0XbuRtYcnqNg
 h+HMuvVg2tnBW8k/7pGDTcEHb3TkvgkvuDX58L1NVyvy/6/w3pCFDilGdSvyDxQX7e0/
 DMZ6d9PH+nZaMy0h4Ecej8HI3GaAWyAU5re/XbOsk1OOnsDJ/fGPXOhR63IGA3NM/1hT
 Zzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376179; x=1772980979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=azZnkVp/NSVUI74ENWvUxmzX3QZO7A1ubP1tdWLgtW8=;
 b=Jqz/qOZlGjW7lUZaQZ23NLwQ+N6/QnAMemY1/95BWnYaqAH5Xdgx7zqAEUIcC++psf
 zImKfaNyITkajbSTv3b4L14OYqSVFMq1suiuPsF6XxRN5/8o6OAPFe2szBSrOGe09HxQ
 CwpSBJW7PVT8tV5IIWjilrfR4h8zK7pFC0Hti/CvaeH1qm+lAVeG7Fs4bm4SUUPGQobk
 1/m9b/kZJTKBq63H2FfvUSnJUdApAWrf0ET4J665VYNZAb0WB1WdrETpreDMF2EIBksF
 4rfWJet5297Z8ApnMAB4whWVOq5GnqxHkMU6vqbEhNotOVgz67B8RITBt0wdshWlnblI
 MzHQ==
X-Gm-Message-State: AOJu0Yzw50fgLV+zXhia9npa+sqp6xCTJFSCltUYmk9WVF5V4PD3nxf6
 v3Se2vzI6s1PD+ZcStQdt3unsl3w31f2HM/4yMzlwR4gESA6I9j4LmXgGJnUOzBi7d0JHiZGW9L
 ME5kozIpRGK9/jrZCzpFHaTF9w1OAOeKJD55JWTCO9TgP8Pwd+wQj1kUDsvQtGVXaNvY6CHV5ES
 iuS6D4Q+W9LqV2wbyDc6btqEdZcExVtbOj+GvDx5jZ
X-Gm-Gg: ATEYQzwuaRxqrndY63jlCQFJU4c9zRrxjjvg4RrGPgi3Cr1o8DCD8zb3yO72hsmxu0q
 mxbNNE6gbLuwP3dZcAh26KHSCcC9YpZQ5TIdxYcFsKAvCDy4uT58TqEluQLCW8Dodk1Le1eHs+a
 YnsV5/P4tmXK2+OysPqobMPwmSBrBeghaF0KQ0nji/qfqwY/iqoI7awcd8AowTNOa4wPKnhV8yK
 qdfNw6W++83hz2YyrGWEL6O64+mKEF3WJ4yfw/7WbmAIMMq2dVEcvzc3a0ZXuGamYSiSl6/yWbM
 vU/HMIa8pCYZIl1v6lB9shJHnDyUpV5AWyF+hjMPJc9mBBKuxwOjHxtAOR4AkBAGCEhV5MvqVmt
 YGSf1LsIQkk3eO/vKLR9Qns0pYRecrzsYH1JeuSOi65afsXeqO0DhVs1yuyrKgnhUhEYMTqTfLB
 N5CAVgBLBxsGs6iPvqE/eS0B+Xvo4=
X-Received: by 2002:a05:600c:982:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-483c33eaf99mr157314965e9.14.1772376178969; 
 Sun, 01 Mar 2026 06:42:58 -0800 (PST)
X-Received: by 2002:a05:600c:982:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-483c33eaf99mr157314585e9.14.1772376178379; 
 Sun, 01 Mar 2026 06:42:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b34b6252sm4871536f8f.10.2026.03.01.06.42.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] target/i386/tcg: optimize CCMP
Date: Sun,  1 Mar 2026 15:42:18 +0100
Message-ID: <20260301144218.458140-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use CC_OP_SUB* and CC_OP_LOGIC* if specific dfv values make it possible;
this avoids having to compute the carry.  This happens relatively often
for dfv=0, and also for dfv=sf for code produced by clang.

Of the combinations that cannot be optimized, both GCC and clang
generate Z.  GCC also generates OS and OSZ.

Do not bother doing this for CTEST; the savings are modest because it
does not need complex code to compute the carry-out vector (CC_SRC
is always 0).  In addition, trivially replacing the arguments to the AND
would only support dfv=0 (produced by -2 & 2) or dfv=S (produced by -2 &
-2), because TEST cannot produce any value where CF or OF are not zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 63 +++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a1c3680db3c..da0e00e6652 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1748,6 +1748,56 @@ static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, u
                        decode->cc_dst, tcg_constant_tl(dst));
 }
 
+static bool gen_ccmp_movcond(DisasContext *s, int cond, uint32_t dfv, MemOp ot)
+{
+    target_ulong op0, op1, max_int;
+    if (cond == (CCMP_T << 1)) {
+        return true;
+    }
+
+    /*
+     * For some values of dfv, it's possible to overwrite operands
+     * instead of using CC_OP_CCMP.
+     */
+    max_int = (target_ulong)1 << ((8 << ot) - 1);
+    switch(dfv) {
+    case 0:
+        op0 = 1, op1 = 0;
+        break;
+    case CC_P|CC_C:
+        op0 = 1, op1 = -16;
+        break;
+    case CC_S:
+        op0 = -3, op1 = 0;
+        break;
+    case CC_S|CC_P|CC_C:
+        op0 = 0, op1 = 16;
+        break;
+    case CC_O:
+        /*
+         * For 8-bit results the sign bit is in bit 7 and, having no copies to the
+         * right, it flips the parity flag.
+         */
+        op0 = -max_int, op1 = 16 + (ot == MO_8);
+        break;
+    case CC_O|CC_S|CC_P|CC_C:
+        /* Same here. */
+        op0 = max_int, op1 = -1 - (ot == MO_8);
+        break;
+    default:
+        return false;
+    }
+
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+    if (!cc.use_reg2) {
+        cc.reg2 = tcg_constant_tl(cc.imm);
+    }
+
+    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2, s->T0, tcg_constant_tl(op0));
+    tcg_gen_movcond_tl(cc.cond, s->T1, cc.reg, cc.reg2, s->T1, tcg_constant_tl(op1));
+    return true;
+}
+
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -1756,16 +1806,15 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[1].ot;
     TCGv cout;
 
-    switch (cond) {
-    case CCMP_T << 1:
-        gen_SUB(s, decode);
-        return;
-    case (CCMP_T << 1) | 1:
+    if (cond == ((CCMP_T << 1) | 1)) {
         decode->cc_op = CC_OP_EFLAGS;
         decode->cc_src = tcg_constant_tl(dfv);
         return;
-    default:
-        break;
+    }
+
+    if (gen_ccmp_movcond(s, cond, dfv, ot)) {
+        gen_SUB(s, decode);
+        return;
     }
 
     decode->cc_op = CC_OP_CCMPB + ot;
-- 
2.52.0


