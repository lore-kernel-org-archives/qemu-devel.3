Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF289C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpq-0008Gy-3P; Wed, 23 Sep 2026 13:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnx-0006mq-EJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnv-0003j3-9F
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSmYu9L/iGp8dgqFhpTW6B1FJFhdvend4JDdu4OhBL4=;
 b=hPMdV4qNoWYIeackQoHJZg+5n+x5c7dLJSW53q/jwqb0SQkx8aCcCNoqTe3orcgmIQiXuU
 fBkm2E61hjme86/7ZxuRJPQq4fR7lIuZy3l3FwJ8gybnzpoSeqFJFRTzKK0oUBnP8B8uEE
 A5pU1xpaPYuW6MB7LC7LoQy8UKykhWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-JJAEXh7COZqNL41fMeqpAA-1; Wed, 23 Sep 2026 13:30:43 -0400
X-MC-Unique: JJAEXh7COZqNL41fMeqpAA-1
X-Mimecast-MFC-AGG-ID: JJAEXh7COZqNL41fMeqpAA_1790184643
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so9679925e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184642; x=1790789442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSmYu9L/iGp8dgqFhpTW6B1FJFhdvend4JDdu4OhBL4=;
 b=Lfj5W6He2skECCHA+sRvrVYlTt4KRe9VEvXc0Pkr9twzdjAhDqY4Y0Ae3QpTj9nAc+
 yew458fdYvbvZmxkBsZoSQyK60BP2K1AzLCgol7Yk4/7hL/N/GhiTNf4kLkLCDjaV96A
 X+t6vpuH+jWoprH369ylbEEaCTztshN6pwXbrhCPN2x02i//PWIXpyPc0et6tw1i5zKA
 z9CAh6qwng4b+DSjiJKyiA3SuGbXjt+aVZqWsyzMPk+i46eosNGed7go8xJZekZ293LQ
 IoP+TTbIVuD2MUZiMWFNUAu9XCUSDVztt3PIwBaNkuoEZe02v2mgYEbLLfNTLtlop81n
 5XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184642; x=1790789442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BSmYu9L/iGp8dgqFhpTW6B1FJFhdvend4JDdu4OhBL4=;
 b=fVt1986D1RKpc+GGyXTz2u0RnrYrlF3Rkez+SKWrWSleca1l7Z1Ixus29T9E9R4btB
 K9/gHB2317aTwDK3EWVJi4EWkjWxMbKBpTv+LV01J42w9lFdZ4hRDdp7zJ3LXWSt4iGR
 FxpKc1kBeHBP3mTSqEhdys5aXCCAHjwAjdoODSNlxPiqDsHzcwwiYbneoT5V3Wsi17rs
 QEd3A8Lr64At//R/fziRdr9FREMLC7r/49V0wVSbblNOpJNgIEYdQXBSea8gLclgem8N
 5hj3rVk5eDiJZXONqadk5jJhhyVECuBaNqpSQZBhpi2cpdqJtxlkIFZs887fj9oIWZ2T
 Fswg==
X-Gm-Message-State: AFuF++kZRLAvuUl/bzXn8+1yw7i4HT3uuPHMMnOMDvI7/CpEqs795gOB
 50InMXK3ESQOO3EXeuJwXP8hAyCPoKi7LFzedq3IN+yQljzU/aarEsEzSJqyfgrQxC8/0dVyySb
 e1WmtDUiYB0Gcg4zJVSPCkpOxtqmUR+ybRg9ZnD6ZbiQS52vDpA6qZdGQ+Q5R/GnzVvTvNW09wo
 foufQcH0DkNCwYCoKWRuQ9vHGb/8BuDoKK027WQ8Zg
X-Gm-Gg: AYBFou2Oq6LEaC6WxSgFyTWqnV+8BpoottaNb02dzndgaC5b/S71nX2YodbendNgkR+
 pMBpIlzwbPQCu7vdj0JYyPhR75ucCRNe9IMGK4QdBVTmZWDh6UfOXDUvCFAZBSCpkWr0sflbc/F
 eGsyeAhWWP3OgGQzhy0t2TErJ7ew+XYV6D9MgBvJ1WD1FWR6N7lVNJFn44p/QnhjflvZs3LtPFi
 C49fThXrplZbF98+U8c194hz5RIH8XMiiP0h5mruc12WXPRVwIE0jzkQ46XXqKkgwpe/VEvHd3V
 JUJQyDKP0w07AtTErFXayVwl0w9b0uMr6ff+fiCMTVLMnec/8tNv4OFY4/mzBcj1AR30dGkHUcP
 S4W2JZcThjwBdNLTca+yOTA8f0zRc6UXMCaU3HQp6Y/u9+qxCXAGayNndTtui0oe5AWYzSHB7mk
 lk7Ixq
X-Received: by 2002:a05:600c:4584:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49fdf15b21dmr55901475e9.30.1790184642643; 
 Wed, 23 Sep 2026 10:30:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4584:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49fdf15b21dmr55900845e9.30.1790184642152; 
 Wed, 23 Sep 2026 10:30:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dff204sm1414225e9.14.2026.09.23.10.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 07/17] target/i386/tcg: mark XSAVE* as not allowing REX2
Date: Wed, 23 Sep 2026 19:30:11 +0200
Message-ID: <20260923173021.317809-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
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

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a3702b00614..b4b0567e7ca 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No REX2 prefix allowed */
+    X86_CHECK_no_rex2 = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d8299a760c3..c4f12ba6c13 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -486,9 +486,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
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
 
@@ -3008,15 +3008,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
2.55.0


