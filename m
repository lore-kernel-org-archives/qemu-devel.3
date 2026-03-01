Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8AAFD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0E-0000Hw-VJ; Sun, 01 Mar 2026 09:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0D-0000HO-4S
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0B-0005iY-N9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vT0k0DbWLV0v+4dOwNHhJjYWwhIfPiojeDvq7lIW4gI=;
 b=PiMfrlayx3Dxo0veOYbsN5YLXWwAz2CwT4sz9N0+gBueNTzm08Oghp/UGCQk24H4rDEMf8
 R1HVP33uHFBBKFGyAuVFznFLDhS/PuXCD7qAn1kYK0zX61jzW/2PM7rstMo1PQ/tdza2fd
 OmlgSHCOZDD2KZE1ZP67cAoNSG6sWj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Uxag58liNSKAqKY24xQiaw-1; Sun, 01 Mar 2026 09:42:33 -0500
X-MC-Unique: Uxag58liNSKAqKY24xQiaw-1
X-Mimecast-MFC-AGG-ID: Uxag58liNSKAqKY24xQiaw_1772376152
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439af95a718so681791f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376152; x=1772980952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vT0k0DbWLV0v+4dOwNHhJjYWwhIfPiojeDvq7lIW4gI=;
 b=HhBzZ7AD8P6G20/+jOQUi5jtXpr1t8xBczz91/cB8/vcp6/gN10770I98UhuUjIv15
 JEyxPXwOa0cucQc03gP3e+PaR2c9h3/9mFF1VKKvXPP/pLawoHw0ZaKAq9zXcj5qoHqp
 Ib386d/U9ZtA07Dk+gSiVoeTkeJVnCCfDus6VhWVh4XKeYlr9A8hZJG6rrEhvUSLFAA4
 myEeU9BKHVxBtY2zneePWl+GaTqOe2zzx3AagoWUArk5MBktptxMS9kRUutsSwjTLQ0p
 /v2FJRmtcrbSvoB3yYYLUtSvWLdfYvdMLOp+SpaiOpW4Rf1GSyr4dsdgkCc201+KFNtH
 k25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376152; x=1772980952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vT0k0DbWLV0v+4dOwNHhJjYWwhIfPiojeDvq7lIW4gI=;
 b=QdSO0rMQQ3EaMrbj3aRMutWPmVWNapx/GtScZt1KUZEKbikDWirQgteFct9RoxXJWE
 PBe4PJYzon3a1mut+nMlwLI3Ldu9RynDMEm/afrJze+/TUMnL6raepSRiFFTUfO1WzRD
 gYNIcYLkoktr0zGDSgHpyBg5676Q0ff8EsEXkQu7qlLMOfBEEjwtkmma/awb9oP2jbuS
 gTzlk461XUnOsDSJ0uWI4E2BRWQt6pROgRnX00Jct3OnmH3N9bQaeXVA5xydcMaSdIUe
 NynunMo6JeBzM+HrShMnTYdC9A6LgDDLRXlhMb/MAjO5vM4jCQ9zsG24vHASAH7yJTKQ
 EglQ==
X-Gm-Message-State: AOJu0YxKoMzXINA1GQYmlzBDJAym/dgcDWp73+TXi7h0aAhBH8N1BOal
 1c0ie1/ExIGQGLBvGKmOZHiFaWKRmofp9HDGAymePpblIAaDktzgAt7ZgIq3iBtoFs2p2PFDNz1
 Xvrz6elymx3t+D1pZHA92u6Mpg4+JZo29kASlg17x93Xxl7x6GjwrksG1gHc8agYAbt43xq0jgn
 K4ZtQ8dpvtucMuVJkatAgWJxkDu3SQCHHuGgTLn/r6
X-Gm-Gg: ATEYQzz4YQ9CQw0XVTWTJeKxNXQtajgWUi6AVk6NCwMrbaR3E3lun1cfhWeBDheQ90v
 8gKgVxCAjx8VqONiAh5MYvSWev3UUX575aDGp/UUIvPnuUQcG9gY+x5Hs62f2jsC/u4RuQGqDYO
 4rtsbKKb+sM7KtdQ13nzLHVRVyQrN3F5TL54TMidXoXF2ssePjuMP7NaW+shsbHaFRptcwGBRqH
 4TreOeHlqutmRE5PYWqxTbZP6AQPLCyPUoQnxme9tWA1DvgYUAQM1IMBNVrKsZUpNbozeB6kMOH
 iaL8shAzAXJ89KfvBLjmZEGNXn7V09jOHIS1WY7eei7EkBY3djHGBKx0CqfNBJSQ/2M10kDaNLf
 PTws7yVoBEFeMJAEkGn6lsNBlec1fyEuv+clCrLa1Vrn849/qD1IsmyIU+V5O3nsHXdDTfRIfGn
 JuJW8txGMDJtbC6IwXMFuS5el3WbU=
X-Received: by 2002:a05:6000:2c04:b0:439:b486:ba5e with SMTP id
 ffacd0b85a97d-439b486c3c9mr2854752f8f.51.1772376151715; 
 Sun, 01 Mar 2026 06:42:31 -0800 (PST)
X-Received: by 2002:a05:6000:2c04:b0:439:b486:ba5e with SMTP id
 ffacd0b85a97d-439b486c3c9mr2854702f8f.51.1772376151243; 
 Sun, 01 Mar 2026 06:42:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm2625607f8f.26.2026.03.01.06.42.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/18] target/i386/tcg: mark XSAVE* as not allowing REX2
Date: Sun,  1 Mar 2026 15:42:05 +0100
Message-ID: <20260301144218.458140-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 92822969003..c974ca9d7c5 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -181,6 +181,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No REX2 prefix allowed */
+    X86_CHECK_no_rex2 = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 6fab597fafc..b968db2b8ad 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -481,9 +481,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
         [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
         [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00),
-        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00),
-        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00),
+        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00 chk(no_rex2)),
         [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
     };
 
@@ -2963,15 +2963,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
-        if (decode.e.check & X86_CHECK_prot_or_vm86) {
-            if (!PE(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_prot_or_vm86) && !PE(s)) {
+            goto illegal_op;
         }
-        if (decode.e.check & X86_CHECK_no_vm86) {
-            if (VM86(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
+            goto illegal_op;
         }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
-- 
2.52.0


