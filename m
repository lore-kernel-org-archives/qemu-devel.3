Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5D4C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY4m-0004Ff-PQ; Wed, 10 Jul 2024 10:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRY4i-0004EY-Ud
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRY4d-0003fc-Jh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720620814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sOqN3xVOsEEQkK4Qkb2LFpu1wYXF9OWAkkvBOLYi0oM=;
 b=RRYPd8if5dDH9x4WO+o/w7pDi8RH/N3IPbWKw36svsiE0bQwrTWlNVmysVVjjryRIkwlOi
 wufs1e8tPpWmwfZpNraN8Vr6hLllewMk5P1Em8eXMSJPCZg6XQxn9LtMb0MOPJvb5hullr
 eHNREuPd4r0DYdqdVwyO2ShCTqIlB/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hMSbvUZuNV2vgfhHSRpJqA-1; Wed, 10 Jul 2024 10:13:32 -0400
X-MC-Unique: hMSbvUZuNV2vgfhHSRpJqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367987cff30so4145364f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620810; x=1721225610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOqN3xVOsEEQkK4Qkb2LFpu1wYXF9OWAkkvBOLYi0oM=;
 b=drMrBkCiyVOJ4PMI+XPpD3TgP3KylwDZ/p2qNlyeAKN9+EFLM8iuPR5HTdhej+r2Db
 UXumpwmDnWyZ+jTkepo4yD56xrwtNJpJOsHX8oMnVYHkkZeSC9SQqnvHbOudkALtzra8
 rIIiOPZ8UrqVOZ8BtN4gK/9NJrHxgvsaESfEjIo9yC4Hk3B6q3k94qA+syq5vYOUm9GH
 PXNWYpz3Es1PORO8LEfL7aN/Rb4CdcYFljKwISPi/i5n8udIFK5TQcG941UPoMxyhpSM
 pODY5JWolAWVOloHpw322lQ7/9xHXj7gwIbGGJ3oafEug6ZnpSKm0vQPcfn1CgEHHk56
 LbVw==
X-Gm-Message-State: AOJu0YyhEg3x66AwnkvJJkVt4MQvionc5/fThlo9nsxkhDvcIAyn0ANi
 UKgfwo/87NY24w7zTy2Nzus/4pH4tiaXHxEG+kLUHa5dJWkL3FYjVrPLTc2ElRUSiB650dI6KuY
 fG3VAarQrqLaBa2uDP9tjkZpwX/XHXXQSC7wczYErtmZU7pv17UaOuT8TpIwyFrooHJkTFqqteH
 TtgoMwp37/Gc13xR03HLJKY2npYnVSV5e51uZP
X-Received: by 2002:adf:f383:0:b0:367:8e4d:5d49 with SMTP id
 ffacd0b85a97d-367ceacb3a0mr3584989f8f.48.1720620810519; 
 Wed, 10 Jul 2024 07:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyJbFK+TQf3iscWXWhgnZdDhEr3dB1MgFpf2LJp3vT/Swr+I5bd0CWGFaLkd6DrqnByTR31g==
X-Received: by 2002:adf:f383:0:b0:367:8e4d:5d49 with SMTP id
 ffacd0b85a97d-367ceacb3a0mr3584971f8f.48.1720620810063; 
 Wed, 10 Jul 2024 07:13:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb22aasm5442090f8f.117.2024.07.10.07.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:13:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] target/i386/tcg: fix POP to memory in long mode
Date: Wed, 10 Jul 2024 16:13:28 +0200
Message-ID: <20240710141328.388955-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In long mode, POP to memory will write a full 64-bit value.  However,
the call to gen_writeback() in gen_POP will use MO_32 because the
decoding table is incorrect.

The bug was latent until commit aea49fbb01a ("target/i386: use gen_writeback()
within gen_POP()", 2024-06-08), and then became visible because gen_op_st_v
now receives op->ot instead of the "ot" returned by gen_pop_T0.

Analyzed-by: Clément Chigot <chigot@adacore.com>
Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
Tested-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 target/i386/tcg/emit.c.inc       | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0d846c32c22..d2da1d396d5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1717,7 +1717,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
     [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
     [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
-    [0x8F] = X86_OP_GROUPw(group1A, E,v),
+    [0x8F] = X86_OP_GROUPw(group1A, E,d64),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
     [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc7477833bc..c6c2c7257b9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2788,6 +2788,8 @@ static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
     X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
 
+    /* Only 16/32-bit access in 32-bit mode, 16/64-bit access in long mode.  */
+    assert(ot == op->ot);
     if (op->has_ea || op->unit == X86_OP_SEG) {
         /* NOTE: order is important for MMU exceptions */
         gen_writeback(s, decode, 0, s->T0);
-- 
2.45.2


