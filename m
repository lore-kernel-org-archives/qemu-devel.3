Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9692DE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaJ-0004YM-Gf; Sun, 15 Dec 2024 04:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaI-0004Xl-6w
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaG-0006yS-Mr
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWAQn2YIR8aOSzjOe8Hz8zbe/CVb70iaUdD4Q/NtuH8=;
 b=PlHxwHNPZd6T9khewmyrnakfKV1Wv+at38aPZJX0qegBrTgH4mN/K5Hit3GPTUsW6ZYebj
 dzbbkjAYdq9Sdwq7imjaRVJ+S4bTRafwRTIjZWZOThsaMB5I0WJOXFHf8s+WBOWbCCp6I9
 QpHTylPudMCp1BW+bKF7Y6Uu/RTJ31g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-zysN8m5ENCqqylujJAy83w-1; Sun, 15 Dec 2024 04:06:38 -0500
X-MC-Unique: zysN8m5ENCqqylujJAy83w-1
X-Mimecast-MFC-AGG-ID: zysN8m5ENCqqylujJAy83w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e27c5949so1867104f8f.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253597; x=1734858397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWAQn2YIR8aOSzjOe8Hz8zbe/CVb70iaUdD4Q/NtuH8=;
 b=iL6KNMNxrFjUSSNixUL5M80cCMFf1SokHCchGXWkdZJfjXfWlnrzo+EBInDH+TmCNW
 FuoWLLWuknxtYN55954BkP8oSxXCJCLNdtRQqFsUSgzkAqjaOJL9WIggE0NUHz/D7fsS
 42wgpGk0ciE8GmPmtXKHAA+Pp7GM0NGGnkKOVRznVGjK7GTzoGPEKjKsx93e6B/FOtq4
 36VdaCIwvEfcIe9fvBg3+56pDqm8pt8nGE8PXax7p9PBfHHq2z/j3ePoDsmgtzuugMXX
 hIOCV75v2cTbkOMs6utc8wTtRcmUfF+HSw5ijFukOaUjO9DxfPURpM1hwlzdQNrcBw0b
 jG4A==
X-Gm-Message-State: AOJu0Yx8Frys+sJT2u7KUQT9ugLnYW4oYiOHgIsXBhp0NiEN/le3DzAb
 bbUa34OfKxXv+PU6uMLsa0tydcr/K99O4YSI6KqlOJEToG6zPxtTJrJ3nVmAu/y+GnxcmtiWcd3
 CNBVoVcwrmaoggszXH4FLv/JGLup2G5yMYQaD01Rgz+Vvi/iubB3BIS+ay7TGZHRXvBoxNjHJhm
 ZxO4EkmH1S/6I7XLP9zakYm49zM7Y2Zs2jWgMf
X-Gm-Gg: ASbGncv5oqCZidY7GLA7Mm31wAZvH91P8NhUJEmLw7phJkzsQflDHe9UfzH2n/rrZCU
 3lw9lcyDxRmGHoSJckFX5YPPhuIebQ3oDWFBkI1FU9BvV/e7ut32r/ELZHWaS7/CJ3FRdojGnTr
 xJksWzGe0DxQzgDV/lspRlwFemzNjXq/EnUHJLZNvVgbsV6c0QWs1Ry3KGXuJVQ0s5epmCVr/Fq
 4fbGTSID/NG5hW6BN1P1PXxN03kFHpSs8HaeChPFeMWDHsgLhWZlFXSvis=
X-Received: by 2002:a05:6000:4b1b:b0:385:dedb:a156 with SMTP id
 ffacd0b85a97d-38880af1254mr7564887f8f.6.1734253596922; 
 Sun, 15 Dec 2024 01:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX6l3+aqpqjQSxhFK/ZDIZ2Hw65I/cdyie38iZj2RGSUVR8c8FNnBvqtQWbj57Fu3/nhBqpw==
X-Received: by 2002:a05:6000:4b1b:b0:385:dedb:a156 with SMTP id
 ffacd0b85a97d-38880af1254mr7564860f8f.6.1734253596437; 
 Sun, 15 Dec 2024 01:06:36 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060582sm4640063f8f.93.2024.12.15.01.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 07/13] target/i386: fix RF handling for string instructions
Date: Sun, 15 Dec 2024 10:06:06 +0100
Message-ID: <20241215090613.89588-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

RF must be set on traps and interrupts from a string instruction,
except if they occur after the last iteration.  Ensure it is set
before giving the main loop a chance to execute.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0fe7ed4ec8d..4ff0ccf71cb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1336,6 +1336,14 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        bool is_repz_nz)
 {
     TCGLabel *done = gen_new_label();
+    bool had_rf = s->flags & HF_RF_MASK;
+
+    /*
+     * Even if EFLAGS.RF was set on entry (such as if we're on the second or
+     * later iteration and an exception or interrupt happened), force gen_eob()
+     * not to clear the flag.  We do that ourselves after the last iteration.
+     */
+    s->flags &= ~HF_RF_MASK;
 
     gen_update_cc_op(s);
     gen_op_jz_ecx(s, done);
@@ -1347,12 +1355,24 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
         gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
 
+    /*
+     * Traps or interrupts set RF_MASK if they happen after any iteration
+     * but the last.  Set it here before giving the main loop a chance to
+     * execute.  (For faults, seg_helper.c sets the flag as usual).
+     */
+    if (!had_rf) {
+        gen_set_eflags(s, RF_MASK);
+    }
+
     /* Go to the main loop but reenter the same instruction.  */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 
     /* CX/ECX/RCX is zero, or REPZ/REPNZ broke the repetition.  */
     gen_set_label(done);
     set_cc_op(s, CC_OP_DYNAMIC);
+    if (had_rf) {
+        gen_reset_eflags(s, RF_MASK);
+    }
     gen_jmp_rel_csize(s, 0, 1);
 }
 
@@ -2157,7 +2177,7 @@ gen_eob(DisasContext *s, int mode)
         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
-    if (s->base.tb->flags & HF_RF_MASK) {
+    if (s->flags & HF_RF_MASK) {
         gen_reset_eflags(s, RF_MASK);
     }
     if (mode == DISAS_EOB_RECHECK_TF) {
-- 
2.47.1


