Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E56BCC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ6O-00065L-GV; Thu, 15 Oct 2026 06:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6F-0005rl-G4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6D-0007xj-Tj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=JS11d48waJ8fOyYlWJ6lopHAUQtS7kQQdbAY8b11n3IlNra54cQ/TzPVsXP3A6Jbzp4c0D
 8qPYTI4nEEa2cTKspRAsUN/OJ6CyiB1fJVwN9092NYTamWgg0kFHOLlS8eNT7j/BszKy7C
 +tH3bx76B63FCcDO/ivKTKNj1vboR7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Ekpp9e90MyitZfGJaRUevQ-1; Thu, 15 Oct 2026 10:54:11 +0000
X-MC-Unique: Ekpp9e90MyitZfGJaRUevQ-1
X-Mimecast-MFC-AGG-ID: Ekpp9e90MyitZfGJaRUevQ_1792061651
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso12513115e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061650; x=1792666450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=ABkJj8dD+9Nk67xZ2ddSwk6DII2r5tS2reOf2vlty1BGl5+B7ELDK4Sq0zlLo1aNWR
 Py7+PI42eWwvnvHRAZ+CLR2RHGCu4LFbKF5nzmBJCHTp6eE0EeRbglv+FKOcoDwZa3HH
 3w/gEKyyYi2XjnjVTUfOh/Vkn8jaMsuhLC2pkCVFXkk8xKSurhdZX8tiiwv+42SDhMBb
 CGswin+B6+jrmLzwfU7NzYJ4LavJw1HEPGmQXZE/pcP3H/1ZbJEt4+7p/T46bB3MhNmH
 vPeYg4+cd6kDKoHsSQZVYQMVkr7I2Ei2x9ZUIQeDTgxcHrufnU90/+FkM2YE5iOn53E4
 baoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061650; x=1792666450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=Nt+Qdhiw0rwpv0nscolFcqsBJmbNaKCxuTuUdZ1UgGAvF1HW9zlOFwVwRA64AHqvom
 R9Yk+75Ew9zt8mfGll0kFJV+WX+p8iOUzlAEjD0dTpEV8Dpc498eqSXtIMCcpmLVdZDW
 urOJ28jixaenYRSedgvkpaldVVk2zDHj/YuD8XZcKYm1RtLpc6kLjno1rsnfWV+ZBgLR
 s3nweXnbWUAiGDCdJgnflBAgHI85pAmpedZsioortvjlAxhgg7dYbO+nW49711K4Ub22
 AKmPLSQhxBTkIDHwbrvCrScxal8SNTTDw6okM30T9e8v+5Uk2AeFmdBn8u3he+Ls2MtS
 G0Ug==
X-Gm-Message-State: AFq9FYLRhAUgMPo5Uybobx4QlOpMCIhz9lN/d57aeQK+/+zBp03lll1P
 okyCTrFrlwEUReSOimTF+jNF0xsBhiiBE7GjgSmkGhBL5N5m9AYOJIHVXeej3OZb1mnphq5cO51
 2mUOtkS552bif5mh6Ozv1Wy4PCtwPlbN5LsiYmUxN7j1SkYgiVjeO//qsOlxDbQfZoUXzPZIwnE
 Bj1BBwg7GWQT4QmZnmVzPiGTq6ROTMhDh9Q4obut2Z
X-Gm-Gg: AYBFou2cVMcfjwyuiWvyRcKi42MLFoCfudnTjRZRb5SrTC8OFj6UuN9dvkJO+GeXvbO
 GPnmACu02tHZG4hHKYSRkzgKjl22/BPXyiMT8dPcYfL3Hle7obTE/zhQim7XBmABGgnLThOzwvH
 75Iu3mVhyi4iJ/s+/7kmFsMb3+x3o+KQUCGJJb8EZiHKcVLdbBohfI/nHTW6tbSvF1BEy7mn1Li
 ouWKcTmR1AQFUAj7f3996kN7Yv2wWVybTsTHeck9Kz2PKhrP/VB29M4ByJDiZpTTpVcInqcw4oM
 FY2N4lR1g+Q0tMRqCFvYprW85DmPK1/8CD68RJ3G2SoN8+WY5ab1bbeYuAISRtRP1tTs1ko9c/u
 qaVomXNLYhOvdvOb3/YFvcYcmfOl/la9e7V0weGH423EPj+4frYA7H3l8rUX1j4oaUmhj2tt9Jb
 MwOZz2
X-Received: by 2002:a05:600c:19c8:b0:4a0:1a7f:2abb with SMTP id
 5b1f17b1804b1-4a18e47ab20mr384814565e9.11.1792061650670; 
 Thu, 15 Oct 2026 03:54:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:4a0:1a7f:2abb with SMTP id
 5b1f17b1804b1-4a18e47ab20mr384814175e9.11.1792061650315; 
 Thu, 15 Oct 2026 03:54:10 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac4f65sm18185415f8f.39.2026.10.15.03.54.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] target/i386/tcg: remove unused X86_TYPE_L
Date: Thu, 15 Oct 2026 12:53:37 +0200
Message-ID: <20261015105347.827029-4-pbonzini@redhat.com>
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

The decoding tables do not use "L,x", because the only instructions
that take a register from the upper 4 bits of an immediate (VBLENDVPS,
VBLENDVPD and VPBLENDVB) use it for a fourth operand that, as far
as the decoder is concerned, is always an 8-bit immediate.  Therefore,
X86_TYPE_L is dead code - remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 1 -
 target/i386/tcg/decode-new.c.inc | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index d8cab8d92d0..f18c7afca87 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -32,7 +32,6 @@ typedef enum X86OpType {
     X86_TYPE_H, /* For AVX, VEX.vvvv selects an XMM/YMM register */
     X86_TYPE_I, /* Immediate */
     X86_TYPE_J, /* Relative offset for a jump */
-    X86_TYPE_L, /* The upper 4 bits of the immediate select a 128-bit register */
     X86_TYPE_M, /* modrm byte selects a memory operand */
     X86_TYPE_N, /* R/M in the modrm byte selects an MMX register */
     X86_TYPE_O, /* Absolute address encoded in the instruction */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d3352b17fdf..fa0a5b1f4c3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2717,10 +2717,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         decode->immediate = op->imm = insn_get(env, s, op->ot);
         break;
 
-    case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
-        op->n = insn_get(env, s, op->ot) >> 4;
-        break;
-
     case X86_TYPE_2op:
         *op = decode->op[0];
         break;
-- 
2.56.0


