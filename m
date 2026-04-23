Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33990F9936E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKk-000118-Mv; Thu, 23 Apr 2026 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJU-0000Vw-76
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJN-0005Gf-EL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wp33Zu4qX2y8IsRyjTpZaoSUC9xqRB2bWLr9ktJjOXU=;
 b=e3TTqoB53qAyk+6vnR/GgyqugX8Qky95l3gHxMoeGlTilh93WHowXkq1hqRwdRJFKItKmb
 3OY4yQyOzRAx6+aaSc1yNJ9Dm7N2loPOkg2GJl1ieXQADQDpoonNzZSj4Frfp7ew1qG0wZ
 EaL3r9orndvS+Ci2xRnmPmLCRP5qTGE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-_02stSVoNa20Kzszx5lWvw-1; Thu, 23 Apr 2026 06:29:29 -0400
X-MC-Unique: _02stSVoNa20Kzszx5lWvw-1
X-Mimecast-MFC-AGG-ID: _02stSVoNa20Kzszx5lWvw_1776940169
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488dcaf2f2fso52902285e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940168; x=1777544968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp33Zu4qX2y8IsRyjTpZaoSUC9xqRB2bWLr9ktJjOXU=;
 b=rqJYVfThLjWhJcs2j2khdSgRg48jmr+tMQ29M01x2ESkLa+RFUgsoSLC6hH900l857
 pEjf51MPJPJIhqiS783ayoRYsaEOx+E9GJ+1at5wJtJK7SCs2rmLSdjoDT7VI1DdV1q+
 OJwRVpioclSDX4G/HCVgmNj8fueW2krlxys5iZ3v0fHIungLB5JKOHLPXVdcNp6aClQI
 bcNnd/U29fvfzm7i/p8oUM/UF618mt80x2XfbEdpKE/YeLewCrzf/6sxl3Q20WeBQCu5
 a61HMEhtRKl7De/GWqvI+9r/xbr4jn4itlSgfrSZ3UWmhWjB2mOnh5X6BQk5aStBoaXI
 N6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940168; x=1777544968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wp33Zu4qX2y8IsRyjTpZaoSUC9xqRB2bWLr9ktJjOXU=;
 b=A56nLrdg4pD/y4TvYdufDR6DThZQXPmiKLJ1j485Ad44QMH24DvncYwkNpqnTHV2WL
 aaZsF6phdYWfmXYGyGeM2lMrZsGv9+dmBzces9YeXbDqWhUvosKFEPJck4e1SFe1Dfjd
 0/XmqNF5gMRj7Gf2MKeJW93fbDGqMLYCOx6Ks6P6SdYS79LBFzq2OywuaJujiSHreilE
 vbx6jJ0pDoqUUC2I725F+3Xn8iVITcjyG/fQHapZyJZaZBCvsed42ArYCektjoqlR4o8
 aSKfI5K+2gX53BJLgbcvZnDtRno3UhkqdqbggGSt9LdBs9GaGKHmMGHz0NduQlUgGuES
 XgOQ==
X-Gm-Message-State: AOJu0Yw5mxTMGB7Bmizs0auBSXz2IiCUfj2/jca+SnDLlrkKAnU1o0Kt
 KwNNfVQuoII3gPx/LD5qbKcSDGnLXwtCUw4rZZ1o25R9StD2t+QbkB0TD3eufyIZUFwLnoo/GnK
 C+8UbZfOLexmPBLA6+NlL6A5JAABajAgI9JlszA8ed0IuWIbE+wQiU4uimkmZ4dBhPYTCWdZyBH
 umqB32evJVq7s3CqsN0FZREZyP3MnA/ZUxzmRjC2du
X-Gm-Gg: AeBDiet32hxGRW7yD3CsKnhxxJWtSMwF2lRKeAr2N/5BaN9Ihuf6grdjfR6e8+ven0s
 q4DmgKU1G4CUMnFHKTFMsnG+CJxj3HTKhO97vWkgtE2bhm2o5Hp+todD9WEB8ZjBmkhnYiscSdl
 vYg2jNKJ/Pal3tA6k2g6F05k8mHOq2ZGsq8D1TC/DUYgPygmpVzv+A5BZxwZVkn+2Yn44mnb0hJ
 38nRJO40XD5J1ckuzbFC+GeZRynBNWQmIE1IB7SkswyexZBCuKAnRSnD7M/4y/nr0YuvnwxgGhj
 sDoiACvJRXm+kZKOywxp2en/C7SfjpXO8L+jt2TDxZsD5Bak2/gN3GJCe4jjC4t1JNnDQY3CMhP
 e05XUXrRj4faV5Cg/lqg1fcq+enE0zkguUCme8yAU3yz9YyH1SZP+j+9yhL2tQTTnvSBWLB496c
 fjOk9TUYoup9aKqaCd3BT5G8YlsH0hB1w2pxE=
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id
 5b1f17b1804b1-488fb78e576mr259686055e9.27.1776940168151; 
 Thu, 23 Apr 2026 03:29:28 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id
 5b1f17b1804b1-488fb78e576mr259685645e9.27.1776940167591; 
 Thu, 23 Apr 2026 03:29:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5549f582sm64450985e9.33.2026.04.23.03.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 02/25] target/i386: fix missing PF_INSTR in SIGSEGV context
Date: Thu, 23 Apr 2026 12:28:59 +0200
Message-ID: <20260423102922.443639-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Simon Scherer <scherer.simon89@gmail.com>

When running linux-user emulation, the SIGSEGV handler does not
correctly set the 4th bit (PF_INSTR) in the error_code variable of
the context argument (context->uc_mcontext.gregs[REG_ERR]).

Because this bit is never set, guest applications cannot distinguish
if a fault was due to missing executable permissions. This patch
ensures that when a page fault occurs during an instruction fetch,
the PF_INSTR flag is properly populated in the signal context.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3384
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260413115622.160212-1-scherer.simon89@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/user/excp_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index 98fab4cbc3f..6c5df5e0e88 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -36,9 +36,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * signal and set exception_index to EXCP_INTERRUPT.
      */
     env->cr[2] = addr;
-    env->error_code = ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
-                    | (maperr ? 0 : PG_ERROR_P_MASK)
-                    | PG_ERROR_U_MASK;
+    env->error_code = (maperr ? 0 : PG_ERROR_P_MASK)
+                    | ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
+                    | PG_ERROR_U_MASK
+                    | ((access_type == MMU_INST_FETCH) ? PG_ERROR_I_D_MASK : 0);
     cs->exception_index = EXCP0E_PAGE;
 
     /* Disable do_interrupt_user. */
-- 
2.53.0


