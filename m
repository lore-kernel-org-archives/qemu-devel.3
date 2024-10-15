Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B916D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNG-0006GL-U7; Tue, 15 Oct 2024 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNE-0006Dx-8V
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNC-0003Lq-Mc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5+M/LXHMzLCA/Rz9fG4sCDfrEoeocpuKFsAteejmB0=;
 b=IC1lrVanhUgE1cl4UJGCnYu5UqVc/rTe9TdMdy07fcrSbBmnsI7na+oHFgtSXWsKWDrwP6
 Ds7/k9kadbzQ/P6BjfA4KdKtjrbISOiY5dSCwYjHFZUoWBaayZDnWvaMRENnkOiCO38iky
 8znD11P/WJCGiJ3azcNIyn0+SVgQnv0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-aZzT6hqtM6ikloea9xszWQ-1; Tue, 15 Oct 2024 10:18:04 -0400
X-MC-Unique: aZzT6hqtM6ikloea9xszWQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so1640797f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001883; x=1729606683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5+M/LXHMzLCA/Rz9fG4sCDfrEoeocpuKFsAteejmB0=;
 b=iUK702sXLPw5unZ3RLUeNlnistaFuTbbj1sMSZe1+fTv2EESn67onMeprNgSpW9WVD
 fIZnzsVXT2xodoT3KkUM8/hoQT8BeKgXIVKUpYDmE3xwaBjZB4YI6a5/YZ1+ySfZ4maI
 tI7L+sjxaFWvNvhKwNLhcg9/AVkqo9mqg1F2eIjx8hkABMPYg2APJrFBmH+PmVLdYgzn
 TibMoal//5FFsHduyJXMwhJOfxELNYrNc2XvrlIvzG4SqlDQQW8VB3N9nzgP+JYLuan8
 XIX9eAgBhJIGfPuPkvfjc3FQtEXgK3JIaL8KzYj6BvcfMLBfOr9M9pM4QHINSWsXrYFY
 zTkw==
X-Gm-Message-State: AOJu0Ywpa03ZyCVL7hfyp4DY8zesNr2s22VG85P2sbqnjCNnpWq3e9LE
 x6h6vN7L9RE5m6EgY8E8Pnt1BBKPZh2z/0xw997MjULxBEPNRQus7r06A7tRDyeMGEmY4/vgUto
 ew9h+6PRLfrnS8kkPHkZ/YbH+MytZNSKf9J/v/ubhs9awWjBtHoF713H5H46O7ug1cms5DoMtfH
 APGuoOrmVMTj/H0kxadTDH9OQB9ww9Bhp7rg8JGpE=
X-Received: by 2002:adf:f9c8:0:b0:37d:415c:f27c with SMTP id
 ffacd0b85a97d-37d5ffb9969mr7650767f8f.38.1729001882779; 
 Tue, 15 Oct 2024 07:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH90VasnVgsCclkSA9KLRJBHRflatwX3GVoWtZZtXAe4DeYWi+4Sisxacn1Rku8AQJUY1Xg8w==
X-Received: by 2002:adf:f9c8:0:b0:37d:415c:f27c with SMTP id
 ffacd0b85a97d-37d5ffb9969mr7650745f8f.38.1729001882188; 
 Tue, 15 Oct 2024 07:18:02 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf82b1sm1710908f8f.72.2024.10.15.07.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/25] target/i386: do not check PREFIX_LOCK in old-style
 decoder
Date: Tue, 15 Oct 2024 16:17:00 +0200
Message-ID: <20241015141711.528342-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is already checked before getting there.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1d3b5f35c39..f4bffef9e28 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2869,7 +2869,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
         switch ((modrm >> 3) & 7) {
         case 7:
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
+                (s->prefix & PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
@@ -2889,7 +2889,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 6: /* RDRAND */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
@@ -3049,8 +3049,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd0: /* xgetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3060,8 +3059,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd1: /* xsetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
@@ -3228,8 +3226,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             gen_st_modrm(s, decode, ot);
             break;
         case 0xee: /* rdpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3237,8 +3234,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -3314,7 +3310,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3322,7 +3317,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3336,7 +3330,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3365,7 +3359,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndldx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -3401,7 +3394,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3429,7 +3421,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3441,7 +3432,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3468,7 +3459,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndstx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
-- 
2.46.2


