Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B842C3DA41
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu2t-0008R0-OP; Sat, 22 Jun 2024 02:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2q-0008Mk-VT
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2p-0006Ns-Bs
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOCjIk5c0We/pHCIFj/HpCCrJicCDsoUAxu+ZvaTrjU=;
 b=au97MkwtejyEPLcgqfw6Irv1whA9nalydAzM2SK5dkUtWyTsR4M+rJqWSEwpxAy2TQfkmA
 3trBa6LtoM3/uvrbuC5EgZe2EZbqkZ9438G4HF+0LCir38V2D+EPsCpnf/oOU4myA8rpxO
 x50M5Wi4A7WJ7Pma7tHFsFnwX8A3iqQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ogEhLpiiMrqvj75MpzjytA-1; Sat, 22 Jun 2024 02:16:10 -0400
X-MC-Unique: ogEhLpiiMrqvj75MpzjytA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f4a6537f7so115068766b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036968; x=1719641768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOCjIk5c0We/pHCIFj/HpCCrJicCDsoUAxu+ZvaTrjU=;
 b=og1e5SEeHP7qkV/0Y0oo95SK6eQJI+R/z6Wzbuiq3FQNGghRcFjYJ6PdDiS0EtTCHf
 imoiTDc7yKW6lyZB5CkqosxwpcbhXUcCPBOsTPBWHAQytWdc/7VMV9V8QJWHvMsrgXAR
 Ht9t4fBQCjZ0StO939+EMz8RijlP37cc5vVBmB2v+WU0jlzak++P9RLvE40GyK5cpzKw
 05jZ67WQkMSTmi/3/VK3xiK1bk/Qc+kRgZd/m7t7tWGKp3Aessw66ekpM2FMEUrbxHFA
 qm9QSwWJP7Uz8pYLPkZFk0rrHU4eHC19ogD//ttwGWuLOzaWHGOyw6TDC/T3tiNr0vAL
 lXCw==
X-Gm-Message-State: AOJu0Yx8J0e06/yug8J6jRUu48cfHdybHLhuv1v+nrLVfC3LfxBpwIhN
 CFTtvOAfhx8Yqsk6RbdfexkkMf5GgAvyXhwG69dUhMAKVsxs/xLsytWZGxSge8nUw0mehUCdCsw
 y4wVutK0yi9R/EDJjaxddDZK/3UVhP8mp3YlmXuDJ537aWiIjeCn9y4d9Wma3qENV+0CBOi80jM
 SjJPag7zE5Fu5gyIz1bbbcUX7F3iJZG5hlEZTs
X-Received: by 2002:a17:907:cb81:b0:a6f:af8e:b76d with SMTP id
 a640c23a62f3a-a6faf8ec937mr557398666b.49.1719036968291; 
 Fri, 21 Jun 2024 23:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQV3VAbMGw8m1V3uVhhlQ3XW5FthTqIvvImgcg3zHXtASeVm2eGZV+RpL7mwQifglv9GrrpA==
X-Received: by 2002:a17:907:cb81:b0:a6f:af8e:b76d with SMTP id
 a640c23a62f3a-a6faf8ec937mr557398066b.49.1719036967969; 
 Fri, 21 Jun 2024 23:16:07 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf5492f5sm157016666b.125.2024.06.21.23.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/23] target/i386: give CC_OP_POPCNT low bits corresponding to
 MO_TL
Date: Sat, 22 Jun 2024 08:15:38 +0200
Message-ID: <20240622061558.530543-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Handle it like the other arithmetic cc_ops.  This simplifies a
bit the implementation of bit test instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 13 +++++++++++--
 target/i386/tcg/translate.c |  3 +--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f54cd93b3f9..8504a7998fd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1275,6 +1275,7 @@ typedef enum {
     CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
     CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_CLR, /* Z and P set, all other flags clear.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1331,8 +1332,16 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
+    /*
+     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
+     * is used or implemented, because the translation needs
+     * to zero-extend CC_DST anyway.
+     */
+    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
+    CC_OP_POPCNTW__,
+    CC_OP_POPCNTL__,
+    CC_OP_POPCNTQ__,
+    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index eb353dc3c9f..934c514e64f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1019,8 +1019,6 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
                              .imm = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
-    case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
@@ -3177,6 +3175,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case CC_OP_SHLB ... CC_OP_SHLQ:
         case CC_OP_SARB ... CC_OP_SARQ:
         case CC_OP_BMILGB ... CC_OP_BMILGQ:
+        case CC_OP_POPCNT:
             /* Z was going to be computed from the non-zero status of CC_DST.
                We can get that same Z value (and the new C value) by leaving
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
-- 
2.45.2


