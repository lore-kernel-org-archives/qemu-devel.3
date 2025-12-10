Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012EBD3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4y-0005AR-8Y; Wed, 10 Dec 2025 08:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4G-0004pp-Dt
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4E-0003Dd-RX
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7AEJmbZf7v9i6z1nQi1Rikw91z3HR65sA3q4HWlvD4=;
 b=TiF/7w3S1x20swz5vfxZUlq0ZCgUZMXInFgnLQQINAhICYgXmf9rsyOO482eim0o5lv8eI
 PNxed8Kr5E6Vv4R2veFLnCexS28ZAZULl/icCiT+eiJD2KivAxTYMrd3vuv6iFATf0KGD1
 piBfQ0DFMynu7HTSniT7Qejh78ZX+Gg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314--sVhK-PFMaGt2sXH4cGPng-1; Wed, 10 Dec 2025 08:17:16 -0500
X-MC-Unique: -sVhK-PFMaGt2sXH4cGPng-1
X-Mimecast-MFC-AGG-ID: -sVhK-PFMaGt2sXH4cGPng_1765372635
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42f9f40a9bbso903471f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372635; x=1765977435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7AEJmbZf7v9i6z1nQi1Rikw91z3HR65sA3q4HWlvD4=;
 b=D5SuBOPBJjIgizBkwdpMlJAUO1/plWoPNmRRBR2uwSbAs+5gJabaoN0WlSxyWpv9vW
 5QUbI4rGUo2/0atJbeyu3a86/hEmPRt3RNSdrXGEa+9RTvcpnqcWKHjGgYKgDZuKvt8L
 c+NpM4FhDYgVxfn8a4Yl70NdOwr6cdGh4TeQ81rKyOhi2Q80HY6jGGOLPBZvF9JHskHO
 q8Jo8w1mFzSILZlIpBGhJXAbvI5slLZuYUCWAU2UNbT8LGvB2zAF409emx515y8SS2+X
 XO551c+nb7Kv+6hxxGHVk8MDXuYblcAFqHLjHdDf88Ki6W76JoZn78UpEEcQqplyi7l1
 F6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372635; x=1765977435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w7AEJmbZf7v9i6z1nQi1Rikw91z3HR65sA3q4HWlvD4=;
 b=m8ALZqnICq23jYrYqX/mCzHlQ6+9g6Czbx7/BKeIVZlyxAXdRX0KAUhHj/e4DYP9ty
 EufFaHORHP2EXk2JQS1eZImMeaCRoc3caBgbaPE2bhjsjrf4CGEDCbeiMKVJadyQ6tn+
 noq1qUGHYF4qQPIqhVgogdPYgOEkjHVCW1HwPhqXKK8Db6oR+cd7DT3zHEL8x55FRlNe
 +Mq16IaAL7chDT64pdnQ3VffcLYLDZBzYJpTpOWJ7fgV3wXuOPKtlTW8Ft8dzJZ/Y6e4
 jV2m8wwMI1A7q1GksOSd1j+V/6RyGfa46+bN5q3MOb9dtnfZ1L1nEE0SbjI0Q391TlOM
 xDIw==
X-Gm-Message-State: AOJu0YzTRFHeilzP2cuWm2cBg0UAkuvVVwKFfuIQWWPDXJZRKWE07uM1
 fp1qNwjCvArdnspERVm3NbNS/ckHb1uXIY+vNTy7NsVhpofxvfcW8e2t+8d39K6GIrnxitz1O29
 rfG6f+y1YMahBqVlyii0prRX7yhV+9DBbneIcJlwMXozqH5/tyZ5ly5VElXsDqB+SdqP4ozak7x
 xd4Xw68/yTMNVqXT0iYnJ/fFTfmmDsyqAEDex6y5F2
X-Gm-Gg: AY/fxX48TuDkg5EeWIEsCEANO83c48RzaoZk7VABfvjEUnOML1WpSPM+l9LpuumW6Ku
 2T++39PwLKG8Vr4JjLL3hM2hDbPStAcR3e2jnG0mEl+KK31QaYNlD/0ZMvo2fvGaNkVPArfTbfv
 U55FGfB9/ySwcKW5qRL2HqhtNYOu6NpOcG71wxbd13XwjICsTzgzcLPvEDln+kYN6YcgZDABg4i
 YslI/0z0aW5+grbgTAQQ2Yvgn8Xdi1SY29257U4Kh7ELcFmi8AbdfQX7FF/kHEqiQw9BKbxqX6P
 +v+SACW5Rufc4zEZucppYYKyDC+8gK/zkx1gQ6gCHy2gSFGpuhZxOyxnRUzay64vAA8bekMv9At
 HhqOp1Ll/kzK4589YwtcF0xjBlLRPs70ELdaBbSt81twBOFRb4blm1Q+OHXKyY1smOaFRRRlQwH
 EyMuH3KZFEk0qeXmM=
X-Received: by 2002:a05:6000:2dca:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-42fa39d8813mr2395876f8f.27.1765372635056; 
 Wed, 10 Dec 2025 05:17:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqv0EWeqS28mftM1SugKVcOniDl1yTJDnXhrn/uR0Pgn6+qSseM/I5Q8d8tl9YylqKeDfdHg==
X-Received: by 2002:a05:6000:2dca:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-42fa39d8813mr2395844f8f.27.1765372634503; 
 Wed, 10 Dec 2025 05:17:14 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353be1sm36602697f8f.39.2025.12.10.05.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/18] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for
 fcom STn and fcomp STn
Date: Wed, 10 Dec 2025 14:16:46 +0100
Message-ID: <20251210131653.852163-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Treat specially the undocumented ops, instead of treating specially the
two d8/0 opcodes that have undocumented variants: just call
gen_helper_fp_arith_ST0_FT0 for all opcodes in the d8/0 encoding.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3c55b62bdec..8f50071a4f4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2777,7 +2777,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
-        case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
+        case 0x00 ... 0x07: /* fxxx st, sti */
             gen_helper_fmov_FT0_STN(tcg_env,
                                     tcg_constant_i32(opreg));
             gen_helper_fp_arith_ST0_FT0(op & 7);
@@ -2790,12 +2790,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 gen_helper_fpop(tcg_env);
             }
             break;
-        case 0x02: /* fcom */
         case 0x22: /* fcom2, undocumented op */
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fcom_ST0_FT0(tcg_env);
             break;
-        case 0x03: /* fcomp */
         case 0x23: /* fcomp3, undocumented op */
         case 0x32: /* fcomp5, undocumented op */
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-- 
2.52.0


