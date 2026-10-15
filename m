Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E234CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHEq-0007Mv-4c; Thu, 15 Oct 2026 04:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEj-0007Lu-JX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEh-0001g5-Ub
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792054490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=PFiQG1oTDIH4exnUcfpy+4dt+cnm3GQJdMGdZZGYpMlD+ghzgwN8zk4+uVIfjj0lgI9nct
 xImlE85PB1OFGeEToBzJ94Ks/cmbpMrB9FZJWkNe/IKbgBSBsvF9/EH4thKVwqEJOATcgn
 0zHNqIylbYQPh0qB6l+5Lzw4Asdh9E4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Lue4EgBkO_2-3G8oFjERsg-1; Thu, 15 Oct 2026 08:54:42 +0000
X-MC-Unique: Lue4EgBkO_2-3G8oFjERsg-1
X-Mimecast-MFC-AGG-ID: Lue4EgBkO_2-3G8oFjERsg_1792054477
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c69bdeaacso991773f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792054477; x=1792659277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=JtpGrxK2uJcnBrM8qkbP8WHJ8Nr4dHZv/a1J52G5YAvEbB2tfGyC140YkPDOJS0mxR
 hTz1NUdRyCfGGdsW4YDFS/9zCnPfGqGaRtOOx6xruInGPFGbfm7SRYN0SyW1Ty38Gwuh
 DJfM6gE35PnQfzp1k5AO4YjmWrCINq6fH1z4HwImUlVAVzf+k+xmwstmwI+dkKfOBs3b
 zX/v+QEvs+Q5lPn1uBzwUbUYrYhpoobYJ3PrPfbF1ZKw4I7LIRj5kYuD/b7sD06JL/8L
 HXwAp52KtrohQyuxrSfLV7dMK5lniUyvYwAeSjOPcawLGNyybUISzi0euvyaSXSlLtis
 ODqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054477; x=1792659277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=TjP+ALViMn6WJTD1k06nN1k2L8j3lwpFUY6NvQKMwTQtzV8C31bIsi1UJkh1zSZP5g
 4ydn4YyoolbpthP8YtiUu1bs2dkpSBUXdINwfGKCjCsbNnoxLtieZ8Q4W2mJwEglQn+G
 v+Tij0PlyBA+bg5MJ+eLt1qf6OWYX/jCdBonmhw9NqvG+4+Rg/4I1rMoLxPiIvEVF8AJ
 p01Ow2hLn06rGZO4E+p6UCHHUKFntrRByiBt1dkzurBYtPmMeSZN8ekHiAi8P1d3OJDt
 XxQkdgl1CKODzl9+3SOuwDwwFsEdxcQ0sUORIZbqHzFBmUdL3iXYdo5O579OClQXnelh
 BnAw==
X-Gm-Message-State: AFq9FYLTDG+D45gGJbCjAqUWaQQO3ZYsl56I4hrh3M96pWwGJjIpxT/f
 wRbpwLadlyz8AjB21DFXGd5ZQHIvZabaqeMB6r7DcUitj6h8ZpLyCn9u0pC9Qmre2ADjuNZoQSV
 Ml1FXacZsSR8fQm0NNjuliVxnTnMAxX+z3qbk4M8ZumibwUL3rek0NYCCPUThTSBVNDTJqCejLu
 4pCnbzX7kJ77sHS7RIIqds7WY4QUQ7wNU3ycTZkBic
X-Gm-Gg: AYBFou3rl7gVF5unNzYlelMiy1ELQ71mMki9z+1KJRUQcvVORGHuxSIEvhfOdfsSTmo
 nUKcgjukikp5iDBS519s5tSPY/zQm/KDPfkCBQnx5NYOQsTQuz30Iryc3JX+GUZuBWTBJ7vRRox
 w2luq1EhN0EIkjwYuW0QMCiex7+fMCQJ6DZk8RZTi/Ng6Mg6Kd7QcsNsfx++LNWUemxYFL3lsKD
 tZgfkEWkknonZOXcO+eZx85VFhxJOPChs+B1wlGYVGJYBLikAijOUQ6ANQg/wnTZNSh4j8fbszf
 0cdId3vo4gUn4jyUGTfQrXwwVWHyHcrX3K6PrS1XcPPev0Bb5d54+pV/sSyU90dtBp0yineSJbl
 bKCWsdm3SIPhpoNHnUKGlFMZWJ+lgOw7qCLLJSUdCc2yLNE4qW28G5H7qsqvib2lipSDExQg17L
 4r02g4
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id
 5b1f17b1804b1-4a18e4a3fc8mr351598825e9.15.1792054476773; 
 Thu, 15 Oct 2026 01:54:36 -0700 (PDT)
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id
 5b1f17b1804b1-4a18e4a3fc8mr351598355e9.15.1792054476319; 
 Thu, 15 Oct 2026 01:54:36 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa34sm17242168f8f.20.2026.10.15.01.54.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:54:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386/tcg: drop X86_TYPE_A
Date: Thu, 15 Oct 2026 10:54:31 +0200
Message-ID: <20261015085431.803961-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015085431.803961-1-pbonzini@redhat.com>
References: <20261015085431.803961-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Operand type A generally is converted to an immediate, except
for the LEAVE instruction.  The idea in the manual is that
d64 the operand type for the "POP EBP" part of the LEAVE, but
it does not really add much to the description in the table.
Just drop the operand so that all A-type operands are handled
as immediates.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 1 -
 target/i386/tcg/decode-new.c.inc | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index f18c7afca87..5f76b0c1b7a 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -22,7 +22,6 @@
 typedef enum X86OpType {
     X86_TYPE_None,
 
-    X86_TYPE_A, /* Implicit */
     X86_TYPE_B, /* VEX.vvvv selects a GPR */
     X86_TYPE_C, /* REG in the modrm byte selects a control register */
     X86_TYPE_D, /* REG in the modrm byte selects a debug register */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index fa0a5b1f4c3..3845fab5c85 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1970,7 +1970,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
 
     [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
-    [0xC9] = X86_OP_ENTRY1(LEAVE, A,d64),
+    [0xC9] = X86_OP_ENTRY0(LEAVE),
     [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
     [0xCB] = X86_OP_ENTRY0(RETF),
     [0xCC] = X86_OP_ENTRY0(INT3),
@@ -2548,7 +2548,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 {
     switch (type) {
     case X86_TYPE_None:  /* Implicit or absent */
-    case X86_TYPE_A:  /* Implicit */
     case X86_TYPE_F:  /* EFLAGS/RFLAGS */
     case X86_TYPE_X:  /* string source */
     case X86_TYPE_Y:  /* string destination */
-- 
2.56.0


