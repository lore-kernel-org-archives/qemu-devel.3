Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1047C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHr-0004jh-P2; Tue, 25 Aug 2026 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHo-0004jQ-Bx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHm-0000Me-2l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYNcIbotW5hwOefjX9E5TD5oRoLH0CWSyIOYzEQ2hQY=;
 b=SLRGLQ68Zekic/HAN69HNqkzIgrVBHHZ7g0EDzv+JKkEz1nnKt0OfUI6ft2IZNZkjsJIa/
 yzH6mVGyZ2MfhAVHjYxFxk7rwfa5BYQQ/txqjQsOUNvSbdcLLPZGP4PGSJt0HJHzeSTbgD
 L0TAs5iTaTsp85sU9N1BWdxpZ5MT+BA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_FS-NlgkNJqP3mlIqF6eow-1; Tue, 25 Aug 2026 08:29:48 -0400
X-MC-Unique: _FS-NlgkNJqP3mlIqF6eow-1
X-Mimecast-MFC-AGG-ID: _FS-NlgkNJqP3mlIqF6eow_1787660987
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so3215044a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660987; x=1788265787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XYNcIbotW5hwOefjX9E5TD5oRoLH0CWSyIOYzEQ2hQY=;
 b=UgZS14AYBOC+Jf7m6brZgOB1b6MDLwVjd6C1oPT3sKYd5FBQayTGSuMbH+EgV/guOr
 kdKsX8C3XAKCd9Ohhe/yAYdTGnH5oXjf5YDzj4AceMFjMi9tMhqxc3G8JI10MtflLGok
 elBfgYxjpjz6LHrJwPF5WzaGHLt3+PUvRSqFbQqcn4Nt93XMgZ7sl5+mjvtIPq7wApYC
 OCINreV4nblPdsRrj0rHVhM4ZKTbPUbVdhIZnx5wXjxGLFJzlmAHhc3xugV5KACzSIa/
 mvU664niqGoPo2okpfyLTSyhpFMGrA9yGNSUUdnETDi7otzXDTGUzJBc0FbaROVEaHFj
 h0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660987; x=1788265787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XYNcIbotW5hwOefjX9E5TD5oRoLH0CWSyIOYzEQ2hQY=;
 b=onJwFz1zGov1io2TiZ/kjjw6FRDfvwPPCWLb6SlPIm0F+lWNbu0oahx421hKdvIaco
 Tet4R8k3vmdLq54E0r/wz0H7Zav02Fc0ytev2LXf1E9/0JpbFSRSlXpPTUkUPVG1bENR
 MbzoVoV4LqZ8Lx/vELU3WddYO+tDSHqhLfHwnKVTt1tC6PbIXXn4CizvSakAFFC0k/8q
 Xu2Y0ccU1RFofodeheKAfCVZAo7/vzpytyV4h4YFqO6upWyVS4PMhjOa+2c+vmEuRbaG
 M5NHBoLMhlWGQZRuyL4XzRs+g7qLThKrDvykUtcdRd0R6QtxJOYDYvvcc7TbiksI3xYz
 qLig==
X-Gm-Message-State: AFuF++nveEl58BOCuIUIssUMD3j98NUURmdL7ylhFlgCcjic2RWIV6hw
 x6OuifFzVJGAV1tMa1PGIFAiIqV/rbebDAVMAeL2s/W8qEfgGlfLziTEOHzdv0yfnzTktlEx/xW
 JJ9C3f0NQqaoWeiZ8gv0VXPXFCo34tyr7C++gI/eJVYQH0okNWYlQciJmdZnhTUBgyiJpjoCsxJ
 PR9z0BuuoPo5GJ8/nqy9SxBM0cFHwRqbNJZtbbZ2W8
X-Gm-Gg: AR+sD13tkfP4KJGYCREcDNMf/3uZxoAXwn8ZYPZDkLMh1pOmh90dHlFfvISoy3Q5gbH
 CXzaRTXUnpAQ0Q6SSLap69gjeKIjQri6YI8RqwrMxDc1K2KekWQfO2vENXggq1Ii0MXdwguFYEf
 H0O7+M30xUkTLb861WtU6ePfiyN1MEPiCfpwWVXA2C90zMGWtdKG2M1bk1kOFF9CrubvScXIXQ0
 Fj8mVydKntYay16WHgLSi2Y9fZvNIy2mYzxT84oomlfrqCmXCv74lqAADy3GBQIwZftOZVPnt9U
 ufz6ZXKMl6kcVJzjWhOLkULeuQ/rETBQ+3CnSOroFsoccyE36n8A5d1dzynPXxmp3V1MXTfxSGs
 QalxkEV5REUojfFL++KAKOeUxl/wZxGPFf2HjE4KPG0pGvaWtILoLgwypzk0o+ot4yfEubX6F7H
 LqN+A=
X-Received: by 2002:a05:6402:52d0:b0:6a1:f895:1ba with SMTP id
 4fb4d7f45d1cf-6a582b93d5cmr25805301a12.12.1787660986824; 
 Tue, 25 Aug 2026 05:29:46 -0700 (PDT)
X-Received: by 2002:a05:6402:52d0:b0:6a1:f895:1ba with SMTP id
 4fb4d7f45d1cf-6a582b93d5cmr25805231a12.12.1787660986384; 
 Tue, 25 Aug 2026 05:29:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1c3003sm13410696a12.23.2026.08.25.05.29.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction
Date: Tue, 25 Aug 2026 14:29:11 +0200
Message-ID: <20260825122921.431739-11-pbonzini@redhat.com>
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

This is the same as an indirect jump, just with immediate operand.
The requirement of W=0 and 0x67 are already available in the decoder.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index c974ca9d7c5..4998712e86d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -184,6 +184,9 @@ typedef enum X86InsnCheck {
 
     /* No REX2 prefix allowed */
     X86_CHECK_no_rex2 = 8192,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 16384,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f59fd665f7..d215d28cec5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1991,6 +1991,7 @@ static const X86OpEntry opcodes_root[256] = {
 
 #ifdef TARGET_X86_64
 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+    [1] = X86_OP_ENTRY1(JMP_m,   I,q, p_00 chk2(W0, no_adr)),
 };
 
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
@@ -3081,6 +3082,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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


