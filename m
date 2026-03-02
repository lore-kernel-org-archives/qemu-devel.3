Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C4CD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyts-0003Hu-PL; Mon, 02 Mar 2026 03:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytV-0001yr-Nd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytT-0001br-0U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QmbZVQLw7we7iRqAwvFKjmYWGyjd6I1ZKI7CG2NM7E=;
 b=QLLffVDz39xjQ9lroxsV2dle/AoUswb9t0sfDRRde+25oaSXizVfTa9lgbD9gcTmCjUK9m
 S3N8y0kRyHCp6C/625lOR8gOqlebzc98UBhCLc0xnGKtVnZap8Q7khkzPm3pQ5M4Td0dvh
 rLDCJ7xP1Qpypxoo9k7gelVds6OMcKc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-sVbcy2V1PYKq6mMdhIVdgw-1; Mon, 02 Mar 2026 03:44:44 -0500
X-MC-Unique: sVbcy2V1PYKq6mMdhIVdgw-1
X-Mimecast-MFC-AGG-ID: sVbcy2V1PYKq6mMdhIVdgw_1772441083
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso53775135e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441082; x=1773045882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QmbZVQLw7we7iRqAwvFKjmYWGyjd6I1ZKI7CG2NM7E=;
 b=fZPsd4N+EeYLrdl3aK3tyqpHN6cWhN6Dx0lznHQXiN5duSHQBkKBadllxWmSFBC+B5
 CW9R8QnfcuB1aiboMgQ6Mbz9sbOwYEhx/hVGjAlc+50hGSlE0Tehmgm9NkL+suvADbx+
 k39PzH67fibx+0zQt9xiY/I+IL9y9CADrsfr9wxI3Bb80PtisEBAtAv4qsgYMp0uaxP9
 7sZAvSdjtbQ1VnvWSAwOQdGa9qXYo+stUuZX6j38YQoUYyF0gIj03wJ00dtxOk/83gw3
 1J/sTaAEJ2AN/7lJT+yoO9xCNHS+YgTSeYPXsscS2U6+0hwLWnxg/+BIkhKLDMDRt1Ck
 j4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441082; x=1773045882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+QmbZVQLw7we7iRqAwvFKjmYWGyjd6I1ZKI7CG2NM7E=;
 b=W0uqI5SyJla6yanxwBnI+gpAtxCOgx9F/bEM1ZjajBoMoYCroBDqFY3TY74L5EeQsj
 6MKKA0kzH75f8DqaIk6itLWjzAjDvumcchErqesIxWM+X9/WtuEqrUBSkpcBmsS8uz2d
 j9gvUFkZNQAzNu+5+HtNjd2SHDJ7xlHdpz8aHMht7uBXCjnvI9or098edApte5qer0Rq
 qDDx8+VCIMgLm15U1hLPTEBJTsCtrNqBe1dFvrhLpuKmgylaKHPIn0iXAF6ro8YsqaK0
 6Tx+bCooyvWAwfk54D3yuugzpzM/cHCWYh4BK+mAwiQHtGb3RGkg2AZ+dKQatpnRxQIq
 lxfw==
X-Gm-Message-State: AOJu0Ywz2x6g9f9TWRkYpBEs0Z+qzqiscYp/En7cyJzmGm2AKNi8Xyi1
 MRGsJBWq3ZlK3rllr+yigTdx7bx0w52egDYxa3IIA3Uj7H9EbyIO6KYY62khdlLUA9kwEsg6ylg
 1SMoftFcQ/rRJk/UFC6yhysiXDT981T1nJs9e7nysksDMlfyp3r3OR7QMJO8WFrbrI6/tgtF9Oy
 ameTpUd941KG2076OO//RT2iGWnBNZU7LKIcMYN12m
X-Gm-Gg: ATEYQzx4Q//G8DAk1KHPZia/F/R2eh9dpW0BJ364svZn22c8gl5IIyr1dKDeL1xHOdS
 A234EQSjkPrsuACDpoSAJ80FJfu93l1B/jRvN5mP+368jUZlG8OA6USfD/a8jeG+UIjPLJZVRiM
 Lli0BkFkQTHzAuEk1sCTArWrSX2xn5TWH1AM/TVa4DD0ylwkm078vr1HwxJTTj7uhygsgBTGr1H
 v9ZDixTfmcG3ZjCsgSx677Lex8Blpj0vsil36otWzeKeJQ9g/FxAVAgQ/Xjkb4MBuXaaBhRTdKl
 akB+MIcr1vLrBVCUWu4Jkm9O4c+Zpk3LSPYOiyL1hu3xaLopy7ZJ++NHAfzzFc8oxv+FuAu8lVc
 qeXzgLi5qpYMTl33l6/v4kO4iVlgO3OAodLSlQ2ls3RpuvoGCv0f4G7QhI63AXI4eYELR3cHEIh
 OXX0YI38WJQNYIKdZDIZB/zPQGdC0=
X-Received: by 2002:a05:600c:6217:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-483c9bc5bb6mr200303335e9.28.1772441081912; 
 Mon, 02 Mar 2026 00:44:41 -0800 (PST)
X-Received: by 2002:a05:600c:6217:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-483c9bc5bb6mr200302845e9.28.1772441081498; 
 Mon, 02 Mar 2026 00:44:41 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm391024115e9.10.2026.03.02.00.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 023/102] target/i386: emulate: raise an exception on
 translation fault
Date: Mon,  2 Mar 2026 09:42:18 +0100
Message-ID: <20260302084338.473368-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-23-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 11e17c2db1d..8261ca16351 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -240,8 +240,29 @@ MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa
     return res;
 }
 
+static int translate_res_to_error_code(MMUTranslateResult res, bool is_write, bool is_user)
+{
+    int error_code = 0;
+    if (is_user) {
+        error_code |= PG_ERROR_U_MASK;
+    }
+    if (!(res & MMU_TRANSLATE_PAGE_NOT_MAPPED)) {
+        error_code |= PG_ERROR_P_MASK;
+    }
+    if (is_write && (res & MMU_TRANSLATE_PRIV_VIOLATION)) {
+        error_code |= PG_ERROR_W_MASK;
+    }
+    if (res & MMU_TRANSLATE_INVALID_PT_FLAGS) {
+        error_code |= PG_ERROR_RSVD_MASK;
+    }
+    return error_code;
+}
+
 static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
     MemTxResult mem_tx_res;
     uint64_t gpa;
@@ -252,6 +273,9 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
 
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
         if (translate_res) {
+            int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
+            env->cr[2] = gva;
+            x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
 
@@ -284,6 +308,9 @@ MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gv
 
 static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
     MemTxResult mem_tx_res;
     uint64_t gpa;
@@ -294,6 +321,9 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
 
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
         if (translate_res) {
+            int error_code = translate_res_to_error_code(translate_res, false, is_user(cpu));
+            env->cr[2] = gva;
+            x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
         mem_tx_res = address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-- 
2.53.0


