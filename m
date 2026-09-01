Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8FAC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OMx-0000vv-W7; Tue, 01 Sep 2026 09:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMv-0000vY-9j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMt-000774-HS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:41 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c252e703fa3so694917566b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268658; x=1788873458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KvmZdE5sHZHsp8nQ4URbmqmTTXnudp+zBG9tJOq6/2M=;
 b=Qun7uIPJWYbfTrQ7bCJkNzefhlLDsX/DywxdRRhRx48dO9p2yamlBQy6M72E9ZJGLa
 xQa7R4S5FuUjDA6SU8aCDWX68bqQMbDmnKHAtl0+L9FaQ76HYjZfTPnu5nNcJFa5uffH
 jBiVz/SV9zFIfLDa/w927m7Nk/OU9ooFOi6Z8EkoGAmL1IC2tVvSsAhdFkNA+9TY28nM
 wY3HB5JSRurLHg37HFhsy9tvzfNvBSOL1vdLZldwhkcawSStzXk0uguiOj7UJLhmcc0m
 PjzrrtxgzNpF5OzQGzhamDoUu0LHCJb5/ldYX6YJMXTU9Ljog1VpRQtXuRsKwydQxKiD
 m91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268658; x=1788873458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KvmZdE5sHZHsp8nQ4URbmqmTTXnudp+zBG9tJOq6/2M=;
 b=dHnUYzGCH7whjOT/hZqWv1OFaSA4VY3GnO4Ym1wg3wAM2OeyglOGHVkO3R+kvkH2Qk
 IRDLXFXBgPFrxJEW7sENmefUCxkhGQCFxz0Q1fjcHIv4ZNxOUQLkl0pS1vsAVuIEb8vp
 pS9aFiUzyyhQj8x+ZecWVUj3vryAVRPhOrX2tUgojGYzvlSGU/ckRtWfsExl/ltaXIle
 WwV/5gXcvp0jQT+L26twbjwTJpsfMGZYbyQ1juKIuGkBNxa4i3czPnrK6NM/CbHTH1vW
 EzV3y7ZHn+txKFuX3Ase4e1LQWlqKAAz+R4iIlKpI4zmZiE3o6fK5lwCyL6RFjvBiXoC
 P9Sg==
X-Gm-Message-State: AFuF++lcNzV7ist7TEK/PYIB1oHCjCFDrkCOz07ZKF2i4HZNj4O1BNpF
 srZomfm73uibvCReRNqW/GJyfXxgTdIorZAFHXfHSmyJHFcFvEMw+rf54hGI2M9Z08OXcV1GRT5
 FevMhRL0=
X-Gm-Gg: AR+sD11eYtCrUd73mIxYfzexwJH9gmvWzfxNULeDRtwFO0pKD8FKrK/yUrH7x1ESEKw
 9rShTMJyrKgqIS+KRtihRl9PjuBOC4XkB9KsOBo7kZvYql+g5+6FiFU4VFqeRv9WxDGnq6jvUZA
 o62vaKH5W2GcpBs5/UO5EjRCZWlVcD39rq+F7YyxlExGuUgT2ob8LoeMzslJl4Gjzt6LrPe2MwK
 IE1jflXC4rgAp1Pjz0CQeD0k5CrAuExRMechx0NTcGsxj94QeHl4pBKWXpDLjmxpQWuMSa3CwxY
 TfJcIgPZF6/yFANUzPX9BUJ0PSzT/N2NUQqJShrTg+EnGmeE8/K+SAgVrzVo4YdC7snx2Bj5xba
 wL6krb/iPVn8OXpuXQl9LhHvu8R0z1vjCc/vLxB/smGWwgW1NSV3aZS1rnFfHcCpzxfIlx8OleF
 tz+rnXwAIt5BEWUIJSm7ITKaixJEcZdXusM9/R7GPxXe2nFV9rx0LZU4ZHt2J9QzzHxZtuwKiJU
 C7OLUXXxRP9JJB8ggOt3YdckWstEA1JpDRAhu6e7v/YfjEuJHi2puT1yNP5M6zIhvbkYp69Tm5g
 6O2v
X-Received: by 2002:a17:906:2545:b0:c25:977e:5377 with SMTP id
 a640c23a62f3a-c25b3bde234mr501456966b.10.1788268657757; 
 Tue, 01 Sep 2026 06:17:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/58] target/arm: Correct reset value of SCTLR for arm926,
 arm1026
Date: Tue,  1 Sep 2026 14:16:37 +0100
Message-ID: <20260901131732.2263947-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

For the arm926 CPU we reset the SCTLR to 0x00090078.  This is not the
value specified in the ARM926EJ-S TRM (ARM DDI 0198E), which states
that bits 16 and 18 are SBO, bit 17 is SBZ, and bits [31:19] are SBZ.
It's also not the value seen on real hardware.

Similarly, for the arm1026 we use the same SCTLR reset value but
the TRM says that bits 18 and 16 are the SBO ones.

This has been wrong in QEMU since 2007 when we first started actively
resetting the SCTLR to some fixed value rather than zero.

This wrong value didn't affect any of QEMU's behaviour, because we
don't implement any handling of the old pre-v6 meanings of these bits
(which were IMPDEF), and their v8 reuse is guarded by appropriate
version checks.

Correct the reset values to 0x00050078 (i.e set bit 18 and not 19).

Cc: qemu-stable@nongnu.org
Fixes: 610c3c8afd99f4f11 ("Reset ARM cp15.c1_sys to default values. Fix XScale cp15 accesses.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4202
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821114138.4068582-1-peter.maydell@linaro.org
---
 target/arm/tcg/cpu32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bc07e33877a..241c1f5e966 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -33,7 +33,7 @@ static void arm926_initfn(Object *obj)
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
 
     /*
      * ARMv5 does not have the ID_ISAR registers, but we can still
@@ -74,7 +74,7 @@ static void arm1026_initfn(Object *obj)
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
     cpu->reset_auxcr = 1;
 
     /*
-- 
2.43.0


