Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA5C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEVT-0002k7-SD; Thu, 20 Jun 2024 05:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVJ-0002OO-T1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVH-0005VY-FL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XXSgEZfF/mgmRYz0quvK+Q6GbqXkOMqVfYjFVsm7Z8=;
 b=O7e1TyQ0PJbfz6Txx4FnALtlCFlgMLg+kNtxapZXbMTdYSzeARo7J8IglakYwZt6yQRF0D
 siX2s4wPet7ndcV5HbLsikGkQ0eKfWhq0fHxz5Igzt+WntH3Vb9h/ogjaaG5Xn3rGYIyrk
 wxFHHghNljegosbY9xtTi0Fg5Sg6CUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-HiETnE3uPDC0zqstn5-MNQ-1; Thu, 20 Jun 2024 05:54:43 -0400
X-MC-Unique: HiETnE3uPDC0zqstn5-MNQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f8ebdf8a6so35175966b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877282; x=1719482082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XXSgEZfF/mgmRYz0quvK+Q6GbqXkOMqVfYjFVsm7Z8=;
 b=WLSW69onZzTeKPcynJKEnKj7ZROtSz1a37KiKMa8dXt5DWrB8MRsO8GGDfEE53azII
 i1sA+BqKhQ6NnnV+oj4Rnj7el89JZ08lK6TTIfzbfnDlBaCPbI883ithlmdUkoMcwoHC
 kjuCg/b16PIQQvMyd9GimDOKyOhQ6X7bXkWCHYA3AIXajsZd7PFfJP99ldD1r2YDiEET
 JA/iAqvIlEU52JJgTz6JdJ+pOLhnj1IZ6Va/s/eHjudTnvFyPb9ssyeh9p66rfDW82KH
 7XmZy3DAAGimLtV5VqFmHosURJ1t6DeG6YvwmnQdH8twd63mINyxQaf+IcsYD4Z3murb
 Rghw==
X-Gm-Message-State: AOJu0YwiT4JUb1YTX2kts3GOzTTqeYLZK6/eKTRw6VhxJveCof9VXspi
 kXC3/ytn0etp2rznMD7IJGXn2uRrihQXQbu4Ydb6WACdQhrqVTI/jC/BJqBnEWmWr7zQy4Rq9Wn
 JkqMzMrH3aD1h2IXOQbercy+UO/GbmCgQvbZswlh6+ttflVh02xlY+2WPOaJk41Ri5X/BkDSmtP
 39eCJwggWeDpz0pia8/j5i9t2CcnJj864yZCE2
X-Received: by 2002:a17:907:6a13:b0:a6f:24fe:f2a7 with SMTP id
 a640c23a62f3a-a6fab6031e1mr286686166b.10.1718877281878; 
 Thu, 20 Jun 2024 02:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXz4UgcktpibJ/v6PfNF6u7yqPSa6JSiZMXF44wNlG1iXI3yijP7uD6DZNi7HrkOuBDQI2g==
X-Received: by 2002:a17:907:6a13:b0:a6f:24fe:f2a7 with SMTP id
 a640c23a62f3a-a6fab6031e1mr286684166b.10.1718877281232; 
 Thu, 20 Jun 2024 02:54:41 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f9bbb08d6sm182920666b.3.2024.06.20.02.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/10] target/i386: do not check PREFIX_LOCK in old-style
 decoder
Date: Thu, 20 Jun 2024 11:54:16 +0200
Message-ID: <20240620095419.386958-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index c60f18c7482..501a1ef9313 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2878,7 +2878,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
         switch ((modrm >> 3) & 7) {
         case 7:
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
+                (s->prefix & PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
@@ -2898,7 +2898,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 6: /* RDRAND */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
@@ -3058,8 +3058,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd0: /* xgetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3069,8 +3068,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd1: /* xsetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
@@ -3237,8 +3235,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             gen_st_modrm(s, decode, ot);
             break;
         case 0xee: /* rdpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3246,8 +3243,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -3323,7 +3319,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3331,7 +3326,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3345,7 +3339,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3374,7 +3368,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndldx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -3410,7 +3403,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3438,7 +3430,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3450,7 +3441,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3477,7 +3468,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndstx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
-- 
2.45.2


