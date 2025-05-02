Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5276AC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAsWB-0003tM-TS; Fri, 02 May 2025 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW9-0003sn-IZ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW7-0005FN-UX
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746200495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq+ksrrzmRU5e3CQiDfdSG+3l9vDGDH9VPK5MruBMrk=;
 b=AcpomNyWbPY0BYIgV3h7Rvg4vDRROX3FccTf/a276qaBLk8+JAMfg08OUVTmzBqJmbLTOX
 d+lVq0I8A5r2kUe8NTw8f301sY0U/Fgu1C6Ds96FaQ8oU3yoXQjxamb7vTjAEVFRVNw/9H
 +7w66WNIA8gZIABjVJzvYrYoQXZ9API=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-xypc1sOPMZeVKBYHdAuuSA-1; Fri, 02 May 2025 11:41:34 -0400
X-MC-Unique: xypc1sOPMZeVKBYHdAuuSA-1
X-Mimecast-MFC-AGG-ID: xypc1sOPMZeVKBYHdAuuSA_1746200493
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso629697f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746200492; x=1746805292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mq+ksrrzmRU5e3CQiDfdSG+3l9vDGDH9VPK5MruBMrk=;
 b=soDoJHBsbuoENH0btLFKq1D3JjUJmavxk3yXOWuXK7NGcz7MeMYwSHJG1WamwLKD76
 9o5Br7LRsMdPPsDSyMTzd1GJyvx0j6Q41CPXMxhd3bdYOjSnbtizvDXkYgBz9KpIQ12a
 9vv0hnY1srnAyqC+zepKKMZs5vTtIi/rDmg6pwCujkssYE+zW8dFXG4s3yAqnDIJQbe4
 WudgLQl54lCfH5IDadaonX63L4EGLTapVAe0O081cD9JULN36ctD+mYnjoiffZWXA+1G
 MDSGEk0zMfiQiwFPtxEirD4vlnsvx+vkSoz1jqDaV2ruLi+zSGTUcB8c7FHyVqUyJmz4
 G9Yw==
X-Gm-Message-State: AOJu0YzGF2YGRl3JG3oHaj++eaGsbWX9zF6PqpdYupN4SBuPd+2LQAre
 A/tNSLDGH6dRn9LcAleVr5+arlOtgB8jYI2x8QhR26byF9MLq/AyA3oDgcPJdM381wbG1WG6rhN
 Hy5gYmfU1cVc3+M7XRvtjUy4BBFHkElYpLCcvnNLQZhK3dZxi2zCY3AMum1q/9IvdP7jcMAyARj
 AyHB0uuDRAcQvhXcNG0VhOOm3xp4bs5iaHy6IY
X-Gm-Gg: ASbGncthqF4p8qOOceO3eDePgujkR6sW4G0+bEy+dto/d77SmbJc0FZ89tqp/VR7ugo
 3oN2eapjWhs0f5Rh3n68nXA3DiwWQamzUUv6HBzSaxxS9l44YIPsIE4XCWEeecv9CHLhqYzWD8o
 /fixWPQbiIVZbVlS0Hq8XjEVKnHxrNoSt3SeM6aDYx/I4VIPu38PF4Jo1lZMhFAU7pItpwRObn9
 8NzXRW7S1eVDaRkk5Opgcd01fbz/LgWqUiDHKg6xcn0qHWzkD4/sr53MQ2slgM3xiA0p2nm+wEW
 iZrFviYZI3KQTxU=
X-Received: by 2002:a05:6000:40db:b0:39f:efb:c2f6 with SMTP id
 ffacd0b85a97d-3a099adcb13mr2468132f8f.33.1746200492240; 
 Fri, 02 May 2025 08:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGS7iLLAlsD7SjMZLl0Y4ur9Z12e72C3wCiW0Pf1FKLDQrwprdBD1vQ/TEhZbvMOP5WU1SZA==
X-Received: by 2002:a05:6000:40db:b0:39f:efb:c2f6 with SMTP id
 ffacd0b85a97d-3a099adcb13mr2468104f8f.33.1746200491787; 
 Fri, 02 May 2025 08:41:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cc9sm2435177f8f.9.2025.05.02.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:41:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/i386: do not block singlestep for STI
Date: Fri,  2 May 2025 17:41:25 +0200
Message-ID: <20250502154125.152090-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502154125.152090-1-pbonzini@redhat.com>
References: <20250502154125.152090-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

STI will trigger a singlestep exception even if it has inhibit-IRQ
behavior.  Do not suppress single-step for all IRQ-inhibiting
instructions, instead special case MOV SS and POP SS.

Cc: qemu-stable@nongnu.org
Fixes: f0f0136abba ("target/i386: no single-step exception after MOV or POP SS", 2024-05-25)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a4e935b043b..ed43c95c1d9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2047,11 +2047,15 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
      * stop as a special handling must be done to disable hardware
      * interrupts for the next instruction.
      *
+     * This is the last instruction, so it's okay to overwrite
+     * HF_TF_MASK; the next TB will start with the flag set.
+     *
      * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
      * might have been set above.
      */
     if (inhibit_irq) {
         s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
+        s->flags &= ~HF_TF_MASK;
     }
 }
 
@@ -2302,7 +2306,7 @@ gen_eob(DisasContext *s, int mode)
     if (mode == DISAS_EOB_RECHECK_TF) {
         gen_helper_rechecking_single_step(tcg_env);
         tcg_gen_exit_tb(NULL, 0);
-    } else if ((s->flags & HF_TF_MASK) && mode != DISAS_EOB_INHIBIT_IRQ) {
+    } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
     } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
-- 
2.49.0


