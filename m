Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C180CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHEg-0007KS-45; Thu, 15 Oct 2026 04:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEd-0007GE-99
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEb-0001eb-Lx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792054483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=dKV39zPAqUyjcvJNtD3tfTg2y9hdPLnhKEaZIAAH8ldls+qcqKahXwO6mAJBhox2W/hsrM
 ug7WWffzGQ2KUKBw/KZ1SyIwSjWeWwxSCciGUZaEeX09oYiHglYGP8LT67zYKaAgOUekup
 SCQMS9QlHmc8VjjOAJS2kDNLr7KOGKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-0sK4ueEyPdKelmYqWmvpiQ-1; Thu, 15 Oct 2026 08:54:35 +0000
X-MC-Unique: 0sK4ueEyPdKelmYqWmvpiQ-1
X-Mimecast-MFC-AGG-ID: 0sK4ueEyPdKelmYqWmvpiQ_1792054474
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2856772f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792054474; x=1792659274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=LaipmVtNhhCLuuyykJM4ruPj673sHldE8r+DP7xKOi38pOkkM2FRjrnGJlM70kyy4n
 F46/VtGByejKI0rqDRq7WemchUSp15gf/XsEESyCl1tw5O3guG/rybwTbA4DD5y4/8/S
 kon4g55OveeMRZqdSuk9jBwKhIFJE8eWAllXbKf9gnS9ktVm+eKqLOiz2vZOx/0iBb6S
 p/dc3FEljKvtiJu7RJ+mdiEoOudfqJWgR8bGgH6D/W/ZfYlw88fMEMuRVKzLvwyOb+eZ
 JA2rk6mdM/ymYJHa+P3nk0VA3b9Z/zb6+MvzCDVC08twfFtZI1TG+XNBcfcfCznwj80M
 sydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054474; x=1792659274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JOT1FfeGJFko9PeHnfKF0r4AsYPCbMVBNSAPkotn58k=;
 b=yBKEb7Sou3OTrfBK4ErgT+OhcHDT8jb4iB7QC/YAQOX3P56ylHs1hdjesbwucheTO1
 pzVPOAUiXSCiS9tUJbJtjpIDDSIZ9pTnVq46Zx4i/CMsxbf8zEwCRZ2m92XQdoPU2ywc
 0uGqbL1xYTK6C3BWjO2bwZyoL7oxjbau4htF+2hpooGckOZmuT+E4S0ik5K8WZaWIpYj
 ec0VDm1IA1LWn3xsxuZaDJl/oaLr+if3/r0h35mpDaqQR9mXg7XjTT7s3p9qNOY3U87h
 b2+RD+D3H08DvsTfLsp52fI/xsWaNlYbHybO09nQYK6mH6ah+ZLCn5DlSAIXhwgR34Z/
 WJHg==
X-Gm-Message-State: AFq9FYIjN9+Em+yX3yyegeRSBFQCU9v+5h5UD8SYld7bsWYVwO2pruyo
 LRpQjmJ3T0P8XnClBybD5zVnoUimXsiKLePubf0ZKNkEx+oVDjvLAQvdXhTnRh2swz9p6yMQe50
 XeQfues8ebtZQy6hGVOFPVIGV9/QWfninaMu9FUKCFkGoSk0pLgGr8Za1b4cTDWJF9ttF+Tmqg7
 6feJyDWYwQ/qz/BhQah/qm6302/BpHDN1gxjsZZnyn
X-Gm-Gg: AYBFou1ZW8wdl5dGHY5DgZv4HT0xyaMOzAjBKQWGgUVnq1ziby+xs+KxiwYFpB4+CqO
 ce/kEeG6flnbndct+7bLV39tIJenBZ82vgeZ2rPPS1nhe9xg7zX84DN5oLGgqTHpkp6QuUtoPOS
 QLfQvsKAjLwEEDour1PivJt9p9pEFfWWn39Sp0evhRPh9LvY+PkUnH07FCWOKhOkSqah5CPPoTF
 QyFCmfX1UVCbIdqOURtDg43r6MKzZ2ktJdc7X3V/cdSz/g0t0qziHkV7WdOf+cch8nnF/qn+Ht/
 pz6sdlwL7qR82BRakYcGDEXkI2fCEHgBsWJBrV30/6z1SUqCPxtzVCtquT43wKhuP8VMktQqeex
 PrtIIWHjwYhkWV+1Hu3EXHq5HcQO9Y/bYZLyyHRIZv02VtEYY8IaDk5EYqyTT+lgAJfBqptDKGR
 pHdu97
X-Received: by 2002:a05:6000:400d:b0:487:27f6:a4e9 with SMTP id
 ffacd0b85a97d-48dbad50b27mr34440779f8f.57.1792054474458; 
 Thu, 15 Oct 2026 01:54:34 -0700 (PDT)
X-Received: by 2002:a05:6000:400d:b0:487:27f6:a4e9 with SMTP id
 ffacd0b85a97d-48dbad50b27mr34440741f8f.57.1792054473960; 
 Thu, 15 Oct 2026 01:54:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72d2b13sm12197102f8f.55.2026.10.15.01.54.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:54:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/i386/tcg: remove unused X86_TYPE_L
Date: Thu, 15 Oct 2026 10:54:30 +0200
Message-ID: <20261015085431.803961-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015085431.803961-1-pbonzini@redhat.com>
References: <20261015085431.803961-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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


