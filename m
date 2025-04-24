Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62359C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837l-0008Ey-OR; Thu, 24 Apr 2025 16:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837X-0008DE-W5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837W-0004za-Co
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso10637915e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526268; x=1746131068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddcO3MH/wvfN8le+HNpO9SiipEJHLq56ZFRiij0VC60=;
 b=lAOvFslaf00f9nFc0JlWmm/ZQZ0+gYXD0tnWD4T0FX9fLfQv/XsF/ZxE4E/Dyysrsr
 rmuGf/QFDMPyfRcFBMmCrGVeATJiAMB0TarEfp1IquzhU4fnUhqIdaB/BPvZolQtVgPS
 qu5txQJCc6zethSDaaM4A9mfNPcXa7KVD+AFQ4/qrm6tGOgzyMZpDVL/VDTB64DeVSYt
 XEHS39y4LqadM6QcIz107QIL+24MbUKrKF5fU94N9MDhCMVMvtrdtaCFS2ZhWw29BYpq
 mAuyFsbJ02szYFbZyr3+x9x8nhSEff0Fh491+6XtkTWl6l2V2qbtfScl8H7QdZRuzA1n
 Gn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526268; x=1746131068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddcO3MH/wvfN8le+HNpO9SiipEJHLq56ZFRiij0VC60=;
 b=Ta38ZTz4R0Q2txdGZJc9DGdN+eDPvt3Dg+UVUsaO/Bho5DjSJJBJ5g34z5gZf7IIK8
 ZgsxyU5BggN+76NetEFk5WZCvvJ1Iwt+4f7aO5fY/Puv19Y1EEJSJunYlpB2GnAvcCJJ
 FQqCZ7eA89JZPlmWG0JVBi09sCC4WSUinxsyfzDmTgS1Xd4vuHMnmHa9L1CkBIf7VOvj
 nYPFLn1qoY5lMfYP2gClp2sGXpO8IB8ABqSMCtnYSPGoSYUE4+j7c7i9niLSbPeD9uto
 52kFFRjeiZW9VRIelhAdwSE6muBbOHfQD9oKWnBRLez1uLzndt5CzdjeA+FfI0/o6EDC
 XfLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnFnD5TYdRQq5LE3MXv1rpCTKe1W4f8f0+bv4musnIqWgIrjQrWGDEWiIt5iADP6bk2t/64su8BH2H@nongnu.org
X-Gm-Message-State: AOJu0YwXA5WzX1a5TPThrbZ1JL9YSyBB+CdU1xrzWt0uJ9dcBopzXO6w
 TkGhBt6HfTiMrHcmx4YWGDOyc2GRYN7GU5pDkygStz2IuuQc67W0yZ5jSfRhKL9yMOjJcBJrHZB
 x
X-Gm-Gg: ASbGncuK/CqsZvPx4AdQXlf7HW61fUMhBt3QCH21fDAUT6xIZR2IwReJhxn3O79QDSr
 QTG9+1cKYaNJlbOa6aN2fOEU/HAInWHQr02PxSDvVCREeIthDxKK2WhOooWv9glqWY1LB80ppWn
 NDgY2SrM4zJ5iUy+vEQanO+V5z2esc9nTSCJHixsD8gP9BEUPD3QVtZTt8PSxsjGW+uAfsdg47F
 vKrrndUs7WkcYidi2LvU8JCloYyP33Y4LB2w931o4/9XzgQMsV4yGtmsEDX6pkHZviqXaPG0+mp
 2YzRqW7WrxTF+3sDI6VrOlR203elakR4beDvljps1eBzxZfYDU8LnvoZxeFJJ/65HmwDoiIR3zd
 X69WLZO64D5bPXYNJjGVfszZcBA==
X-Google-Smtp-Source: AGHT+IFnGxfr/sr4kkMJfRBriFTUG64cuc12dSB7Iz5BQGnZ/6vb3aIvFhYPNj4Zyhozk5U2/eWg0Q==
X-Received: by 2002:a05:600c:8710:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-440a31a409bmr9219915e9.31.1745526268450; 
 Thu, 24 Apr 2025 13:24:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm32728515e9.21.2025.04.24.13.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 03/13] accel/tcg: Correct list of included headers in
 tcg-stub.c
Date: Thu, 24 Apr 2025 22:24:02 +0200
Message-ID: <20250424202412.91612-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In commit 3549118b498 we moved cpu_loop_exit*() declarations to
"exec/cpu-common.h" but neglected to update tcg-stub.c. We missed
it because "exec/cpu-common.h" is indirectly pulled in via
"exec/exec-all.h" -> "exec/translation-block.h". Include it
directly instead of the not necessary "exec/exec-all.h".

Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
removed the need for "exec/tb-flush.h", so remote it too.

Fixes: 3549118b498 ("exec: Move cpu_loop_foo() functions to 'cpu-common.h'")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 accel/stubs/tcg-stub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index b2b9881bdfb..3b76b8b17c1 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,8 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/tb-flush.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
-- 
2.47.1


