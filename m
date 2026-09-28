Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3AECA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2l-0006Xp-NU; Mon, 28 Sep 2026 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1A-0005b2-LJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB19-0004QZ-4B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwRkL9B59N2S1JX3QDPCKGi7X6Tvnoj/YBAUQHlpIzQ=;
 b=UsHnUpJ3JHKDZYFflIxgwgnwmmOmc3bwhE+vQLU3EAffchVVCtFFJseau1IHCKnbcvlxgX
 rtSYXhz/iHsiJwjkxWnWgODMR2lN0B1kj1sVGwz/KRZQ7uioD1KDes9s4vzCGZrVHPRTzN
 iyhBk4pLBOXdRY+Ck/hRp8e3H38IBYk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-8HDEBq3HNQym8h18MxIPiA-1; Mon, 28 Sep 2026 09:03:36 -0400
X-MC-Unique: 8HDEBq3HNQym8h18MxIPiA-1
X-Mimecast-MFC-AGG-ID: 8HDEBq3HNQym8h18MxIPiA_1790600616
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c294ae16922so370626966b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600616; x=1791205416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwRkL9B59N2S1JX3QDPCKGi7X6Tvnoj/YBAUQHlpIzQ=;
 b=FH32kdTk2hjcOpWSbst149R6rA6dOmJPO4zapOi99X1q8Hx/zq/wuiS5AezYqNXhIL
 Xbnr6kLGKhNcmZ9yTPj45KQqjYfj+vjME5zYgS4kT8RmnaLykzt/korMlupSgbE5LYzA
 2cvFc5CYdNfW1uKI05/+uzHshkBl3ytzg4LwHso/FptxwKfT4bKldXjK00kzIroZs8nt
 hbV6GjsXl5pFDPOvfNyUc78k5jw03HH1cu06zkoFtEicOSHqi1iqQm+lQfjeZ+/pn0fq
 kw/ZkDUKchgCe6eN6Xuarz8jwQaBsYdyd5e4UGd9+PsMtxVRV9NOppTG6IdKh+rCECPC
 jCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600616; x=1791205416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwRkL9B59N2S1JX3QDPCKGi7X6Tvnoj/YBAUQHlpIzQ=;
 b=tqqBR7RUfUaMAKBEsntKznpAURU1/bn/xIau4qOSi7KgOdQTJZxk3V1zEkoT7oMklZ
 Nmp3x8XkOuNJFvtxyvxLnwQpX1t+5kxDVILwvPw5ojOKn0npH+2EYPCFyUbO8ceoFkfq
 KaZbksHUi4xheOgoI1TD4E0kSMdViIrOMHV+EH9d2f7OUvEFdyxV8FoaPvz8xuMwDV7y
 uFGcfWacojWoh5xsEPHG/x6I0WNE7zXZP40k/mzKwCv+lFqVqhZF2zjz0zJ/R1lVYgyo
 Vl2OmNcq+ABGcNRHDZlqswQ2mrIsARaDdxGyVuAmzJ0lIsHqD2w48ZJ+ei0SKlwEHxor
 wA/g==
X-Gm-Message-State: AFuF++m1TMpGxzCKuMq8ke0bl8QaUMhf1G1B3bfBKkGWXKgLPRpR12zd
 0EuPHkFsnM87ZIBD5jdlY+3f4Aw6TIDNhM82q7B1tzXX835iszJmF1Hd0xdkJeVdzhcLUDpZTtM
 j7NUnoaSLcDCuCKyE+6lanTubuKi4kodKZOZb+kLHQWqduLVsbTD9E7XwSTLuWLRMg9QpRfpXPs
 FAhbNHIGXoyM05x9sCPVP6s4iDlbeN5JLF9ihvscMA
X-Gm-Gg: AYBFou2NfovGNawnQjRHLR9bAWWRhh6dQv0ZXLi2FyipzUPBcMe1qqE6he2UPa7fLcJ
 08sTGAQLIgYPXZ++4jnGNkbzErY0M/lubftQLxp3HmiMV14lZ1X4W5fSIhA5nsPf9UrF4I7+2VI
 +e/CsipUJaJfoY4tKVXUaCeRrkjVKe2SjhYjvF1LEiBGElJG6LMePdkTsP4hyv3HdUI0s1dWMmo
 Fqty0iYp/qRa5Nz8YUXZ58yV5rr3Yu52zb552mOKwH5zALxLE9jT8cO/2gVnMOhSmoBTyLFSh6g
 hVHEtTw5S24D4zhybrJUzqfCwHqQaIBvS+2FZzdue0Vr2/ifZTyzq9s6CMoW4lWn2gFYA9lkIFk
 6X6ykOH5d0msZw3GHQZMClumSjNN9WE4mM6rJDG2h0ugFO1w5nyGsumQPDegsJOmgrLZhusosjx
 5wSTXJ
X-Received: by 2002:a17:906:9fd2:b0:c29:c079:676d with SMTP id
 a640c23a62f3a-c2ac2389cf1mr1052225166b.3.1790600615535; 
 Mon, 28 Sep 2026 06:03:35 -0700 (PDT)
X-Received: by 2002:a17:906:9fd2:b0:c29:c079:676d with SMTP id
 a640c23a62f3a-c2ac2389cf1mr1052222566b.3.1790600615084; 
 Mon, 28 Sep 2026 06:03:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dc1f8413dsm251743266b.55.2026.09.28.06.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/30] target/i386/tcg: implement JMPABS instruction
Date: Mon, 28 Sep 2026 15:02:19 +0200
Message-ID: <20260928130228.877003-22-pbonzini@redhat.com>
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

This is the same as an indirect jump, just with immediate operand.
The requirement of W=0 and 0x67 are already available in the decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index bb686c9efd0..eb692503680 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -190,6 +190,9 @@ typedef enum X86InsnCheck {
 
     /* No REX2 prefix allowed */
     X86_CHECK_no_rex2 = 8192,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 16384,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f79098e8348..b42a4fd47dd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1993,6 +1993,7 @@ static const X86OpEntry opcodes_root[256] = {
 
 #ifdef TARGET_X86_64
 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+    [1] = X86_OP_ENTRYr(JMP_m,   I,q, p_00 chk2(W0, no_adr)), /* JMPABS */
 };
 
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
@@ -3119,6 +3120,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
+            goto illegal_op;
+        }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
         }
-- 
2.55.0


