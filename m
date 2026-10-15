Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF804CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ6P-0006CN-6M; Thu, 15 Oct 2026 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6J-0005vR-EU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6H-0007yJ-8E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=TRkvClKb4ntYH09pTU9Ev1mAk/IyC/nNLoIZSkwT2bibrqKbmOewSPzGbwR6AeKk4BnQIg
 U8gBXzX1Kw5W9nYsfNDBYU3IFWPcZ5YAmjC2RvrTdhtfgVw4JK//e3rh8o++ISYFCUyMSI
 1UHaU9g7xmecSVkbOKOwLgp27sV5c0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-rJorJxnsPoO37TVV5Blkmw-1; Thu, 15 Oct 2026 10:54:14 +0000
X-MC-Unique: rJorJxnsPoO37TVV5Blkmw-1
X-Mimecast-MFC-AGG-ID: rJorJxnsPoO37TVV5Blkmw_1792061654
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso4154844f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061653; x=1792666453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=bvylLXd6ojccL08czabQ0J+gxbDBVUOZSeuq1qQtzH8RRhrmA0eKn6vkjwmbWaTDET
 7HD+x3S/1RlSJG0YjrEjPXXxlI29oRPL1XzRlyuVRyRNYGGXEe7rZ8l9DL9fF3EsMyVi
 wUZPJrEVoiVwjCcjWkHYtu15JK9Vji/VpVpfQyW/CQY67PGZtaEHrJobTKM+AmnjkKOJ
 ik1rCwTt39zudfWGbiIg/xPCc0hKiL2G8UPpQh8KauQw2kjXQ0YRLJn0JOfGJGSCjCOC
 gdZ98+5tA2B80sPKPEfNOWTCOw/crUXiTb7SbkapeYtdszzLvBgZfagyHYwOiBtZQWXa
 85yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061653; x=1792666453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nLruPu5Ftu0GhJbrHd+YxZZtnKux0tD3uDcRxZ+FsB0=;
 b=ATbUhFPz1sh+hK97JujgDtRpohsSg5mOPTHF0NEUOrYC3+cfFAda4NYF07QniIL3L4
 /aDtc9TYGbIbsIlkSmr/ogCXJvZVkiZawwFePgeb1/RYlvF64kRMHRfynY6xivuTxwKP
 jyEhWr2rJrvVrNAR8+RHtdnhqUX+wBOWUIBb74yoGBbn2i2gT64/aq6FZrdQ7HvckQ/N
 O3e+qj4Qu+FngMRWW6Mfr7v4R7GRinFO6q6/HwLX1gmFF/ytP61mZLzB2Yg8KGjBZufz
 I9zWDvydHWQQp+ZSaYbPk2yzk+QOOYwE93R7fx3zKUp+GEteu9TlxM7JotbP4U+4ip8j
 fkEA==
X-Gm-Message-State: AFq9FYKtpBFusfWgPhmRSdEwd10TsvA0oQWAUVjvYL3mXqkhRhFq95zk
 7chFrzI+Je2FKWGa2eC80OlvDwRbqzBumZUxL680u8pmkwfjr3Wwpu1LKYn9wtoQLawPX8Urz7c
 Me5x+vMLKxL8eQwfejHJK/rUluqkJ09kPV5ux+PM1BYuCiCZ3VgD9oAzJwk5Yw6aSiDT/Zsb12i
 BiYfZHi0LrBoCdXrqRfY1kNbtQE/8u8z+SwdAx4hQQ
X-Gm-Gg: AYBFou3LZLf3I4kdupjL3pdMpSlY/yKHruBrvE5SmOrUpz/vzNYzUm0FCBgOLEW/iPF
 5BjCXdssVxQsAzhDpfhlrA4VIpJMdnk4p6nJLKQC2l3rph6fb5vGkzBAvQVM2UUa63ta1JNdoaq
 477EeGGwmGA7YnBuZN3Lz1S68Q6wLoLEga1IhjS3ZCgLBeXaN9LmVTXi6OwxhAzRpZgOD2TdtI3
 7h8lICirxcmGG2rbc2/f5zDdSQzZHNMXySvvPl7DnDT/KevKXdKCBmHjQPg6aB66pa9aMrGGH1Q
 dg3XvW5Vh828HpqOt7bM5GylKZ/QJ7dg/5xsO8Ju+O4CkEz+9ZmC7eyebFTO/bLUz6bZl2wVisL
 VlX8cCGLL2jB5K+BUJ8nFGcw2kPVlCClf5uBPxCZ5NC4BAupJqh5OfQAEeaeMps8uch7Ybs6lQt
 l7DToX
X-Received: by 2002:a05:6000:26ca:b0:48d:c15b:5d29 with SMTP id
 ffacd0b85a97d-48dc15b5de2mr35473656f8f.2.1792061653630; 
 Thu, 15 Oct 2026 03:54:13 -0700 (PDT)
X-Received: by 2002:a05:6000:26ca:b0:48d:c15b:5d29 with SMTP id
 ffacd0b85a97d-48dc15b5de2mr35473613f8f.2.1792061653095; 
 Thu, 15 Oct 2026 03:54:13 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa34sm17815277f8f.20.2026.10.15.03.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] target/i386/tcg: drop X86_TYPE_A
Date: Thu, 15 Oct 2026 12:53:38 +0200
Message-ID: <20261015105347.827029-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
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


