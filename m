Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B4C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0U-0004yB-Ld; Fri, 24 May 2024 04:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0R-0004vQ-Vt
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0Q-0000Ij-HQ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixOp6LvLNnzS8WvJ2+NP52iNUpz5IJz+mvxbQUZVrIs=;
 b=MwPzXSkcCL44rrP8Okadr1GjPBdm856ajPpNesfrcvvRXmd7kRRYSXwwMfbIWLa01yiCpn
 7Pi3on2ByzucvM/+A4zTudGaBTO1re3mAnxYzifGOMcKb2ZerXQ15FtOG+JAWTOmckUCR0
 GgJwRrLkvwNGd8Q7icP2R8J2ihTxDwY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-HhaF9CRpOo6dlO8gRd19Pw-1; Fri, 24 May 2024 04:10:23 -0400
X-MC-Unique: HhaF9CRpOo6dlO8gRd19Pw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a626ac4c2faso29134666b.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538222; x=1717143022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixOp6LvLNnzS8WvJ2+NP52iNUpz5IJz+mvxbQUZVrIs=;
 b=fOQqk4tXZF+UhtmFbEv4qa02o1hWRmfx97+yY1IGc2nQHQhKpUM8ABzqX60r/mUD/T
 MTTe/F1zycldcqbc5ZbeMSc6TCc6cjhJdYJ5VHTDDiynNLNOevk3psO3FNp0Dm8KNiIM
 MGGopooCUA8Nqs/gNcheRD0ezVeEU75NCJlrWk/x2OV6ZyPydV+Ts4qQvdOg/oO8dfz5
 YGpZW+aOc+8aX+jOhTzMpRqunp2RAHGVQHp6VfcoSobI+1pNEmd+2VO2sYi7HvRlh0Ll
 3E/M3mY3vtx4pDzDo3TUJ/JaS0P1AP1Na3xYPSjCa7kbHA4URRqzUaGQs0Tf502aMdPu
 m0PQ==
X-Gm-Message-State: AOJu0YwfxbvNzH3u7qWnBBaZfck66eu4K71hOfWLlNbcxwMBiVrNjOp5
 n2F7af3oR0oEPuh84YoNP7DluWsOUr0PActsYt2JHFAUF64wBtPmZFUQJbCn20ds8Y0svhpbsMk
 fczT+ds6ewU7xDgDB7cd9EhRxxNRtj5edZEUx8c09/FBwjGskljAtMw8aPU0eztedPpPczXwWVR
 yqkSyARCQdVgPYZRqb4Ah3I8Wd08klyHkSGLHp
X-Received: by 2002:a17:906:6d97:b0:a62:47d7:247d with SMTP id
 a640c23a62f3a-a626511b0bamr151011066b.56.1716538222107; 
 Fri, 24 May 2024 01:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERgUJ9LLDxEfzhYR7dL04Z73ysvaupWkBNld1gCtLdc/mWLVXQtv9HwfGc1BhGk6t4kDCSWA==
X-Received: by 2002:a17:906:6d97:b0:a62:47d7:247d with SMTP id
 a640c23a62f3a-a626511b0bamr151008566b.56.1716538221520; 
 Fri, 24 May 2024 01:10:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda6e1esm89631466b.215.2024.05.24.01.10.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] target/i386: remove unnecessary gen_update_cc_op before
 gen_eob*
Date: Fri, 24 May 2024 10:10:04 +0200
Message-ID: <20240524081019.1141359-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is already handled in gen_eob().  Before adding another DISAS_*
case, remove the double calls.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76be7425800..f44edb3c29c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4776,14 +4776,12 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
-        gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
         /* fall through */
     case DISAS_EOB_ONLY:
         gen_eob(dc);
         break;
     case DISAS_EOB_INHIBIT_IRQ:
-        gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc);
         break;
-- 
2.45.1


