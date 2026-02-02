Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35B0E7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu41-0006jo-2r; Mon, 02 Feb 2026 08:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu3z-0006ir-UE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu3x-0002Z6-R0
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:59 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso33790445e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039236; x=1770644036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDml/3LbO2JMFRFM4BlBDbVveOOqyhxoiv/BC5ZJtJI=;
 b=VvQ8spOkgdkAWL1+wkthNpGG+T40UkCnLlLLooqC9eYk9Se7KQs4YlpJZshnrDIoQW
 8EWG49TnDb9JZo7xU6RTpMN5FZQ0M3Vtwbd0e7HFB+deuzTmFnXQi1DdMj8aMMFKiLOG
 NYyQOs8SUqZAL6H4s8+AsdDkXVlkzfGZhSUX+OL9STZz3A2E4lVSGDA4PzSz4FsWMzu4
 Jn7j+9chMljljyF/XHaLZH3qlw9vUskHd5LjbyekcGOXuX6ixnBjZilQ198EyxmuTw/V
 Cd/xhV1fyGaUVJPsrAI8YaWgBwfW5hgrxVsdJu/yXZRX5nY/mGY58x3dBmnk50PakQmv
 1lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039236; x=1770644036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDml/3LbO2JMFRFM4BlBDbVveOOqyhxoiv/BC5ZJtJI=;
 b=UtvQaLPytoQJ7xMdhAE7A1B8lZJZIgmlz1mjPrO0NSqqEKlRvg2lXA3aqdMZxZejvk
 ycyJHMtp20+dOo7EeZU9cdP64QpLdMEjoMl1Z0YbDK8J5IiV3cI+qepWuTcMEoFhPltA
 g44BExscFnT0VV0Y4Ehwm3dV2p39EnOOIoQ3EyVsaNoxD0Km3Z1UmC1YUAMrMUG0nAk7
 tOpa1Xj6+TzoZUDOp2RUI5vaJI4C+CpxEJPNKFFPMFflYCufRz9j2XV6r6dNFP96mXDG
 0Ahdj/3RyFx1KKsmbEViX5AeI7Lyo9r7cR8Fb6SuN+7ZonAVG6gRsagtcGaSXsNG77dB
 4bzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSXd1mQwtU7A7+516ZKxOYWLgjU/UXD/Fuc9GFfS7tV7+mM655iRrE9GvCBKBrgNuYgOIASkP1BWBX@nongnu.org
X-Gm-Message-State: AOJu0Yzsm8LabWNIR614N4SJoYgTD4FTswGQkm7zrAaZXEJVKA+FsFEJ
 fWmY7Mj4BgpxOjBE3AI/CxKOOvC9oB+93uaOIJ4gaeCl1TeZvQA9pa4Ek1iM+qv2L0U=
X-Gm-Gg: AZuq6aJ9HVqKA0EJTe7Et43S1LitUk20ZSdbSbKzLlo9hEoR9xMbc1kJx6or2gy1yRH
 UYrJ3s89fg5zZgw3SnRxzG+ygfkyDiSpofXCXaUZSGXFIVsnc85NkZ7OzfefK0vpKcAe8dH9jBy
 MUVcuGzCQA1h48sB3n1mxEfqId9IMgrNct4EImY71q+gRskxVl+4fKy9aXRwypgtXBojo4FsfRs
 n03d59GXwCdnbZTePrqvByZ1zJ8LSGnQdBpOcFoAWSmJgE1/kIOja8WgTGOK+EimxaQUEz5raIw
 o7x75q2qCyXyrdLl4Z/H/WUoFyTiTHMh3qKcCOb1UHCy7BGhMi2EYqB1cHEvykaYIB0x5EccI/D
 Q/+7PIsMZy3jL4uFjNEJmtCHO+H7H8QN5TDy+Dp2JPcP0wV3r9MzHcC0Kqn8ciRhLhAA4y1v/jB
 /8fAJby4l7ycssb4mNK/v6/a/o+RfPz4cbTaq/IETP
X-Received: by 2002:a05:600c:b99:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-482db49a4a6mr164780935e9.29.1770039236266; 
 Mon, 02 Feb 2026 05:33:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:33:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 01/15] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
Date: Mon,  2 Feb 2026 13:33:39 +0000
Message-ID: <20260202133353.2231685-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

In aarch64_sve_narrow_vq() we assert that the new VQ is within
the maximum supported range for the CPU. We forgot to update
this to account for SME, which might have a different maximum.

Update the assert to permit any VQ which is valid for either
SVE or SME.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
CC stable on this one, because it might also be a problem for
a CPU with both SME and SVE but where the SVE max VL is less
than the SME max VL.
---
 target/arm/helper.c    | 2 +-
 target/arm/internals.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e86ceb130c..e7aa5ec2f2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10079,7 +10079,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= arm_max_vq(env_archcpu(env)));
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7b641342a..8ec2750847 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1808,6 +1808,15 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
     ((1 << (1 - 1)) | (1 << (2 - 1)) |                  \
      (1 << (4 - 1)) | (1 << (8 - 1)) | (1 << (16 - 1)))
 
+/*
+ * Return the maximum SVE/SME VQ for this CPU. This defines
+ * the maximum possible size of the Zn vector registers.
+ */
+static inline int arm_max_vq(ARMCPU *cpu)
+{
+    return MAX(cpu->sve_max_vq, cpu->sme_max_vq);
+}
+
 /*
  * Return true if it is possible to take a fine-grained-trap to EL2.
  */
-- 
2.43.0


