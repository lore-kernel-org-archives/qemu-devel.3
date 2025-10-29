Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC114CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Zx-0006W9-Ak; Wed, 29 Oct 2025 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ys-0005nW-5u
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003X3-VL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:05 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7042e50899so9031066b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753448; x=1762358248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vt4UkIzTYNn3Frk9IT9Ae6t7kuPopy2qxzZpm/RFBq0=;
 b=QaQxbpjDUXrMcIpdH7Gn+iNefA6+silyeADaI7XkCbp4c4GyN8wKB0B0Fxc8XLtDzV
 1ZgTOGSWFOgr+OiWlmTxXCcrepC4CaQoSEygsGO/6piOq3LqDdiaDMW/CcspIBYKyqvU
 NkXOiemBvWHnubYBPjvZOLx5hytTAvk67pwdZdyet8LwU9VDn7+5RzmeRjCMvo5zc1XV
 SW9ZJXE4iVbCyfhRkY05oCiozuY7ahIlbm4S7UDozJzIC+/xcoDiFO7i/P+AeZoL2LUZ
 A9t15SpqdY2pkktqLGcdSNqFtB6oqjR9b9HMB0QMprQgRxLIZ2OvFkPAr4obExEi5FEd
 lMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753448; x=1762358248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vt4UkIzTYNn3Frk9IT9Ae6t7kuPopy2qxzZpm/RFBq0=;
 b=jz/Y/XT361gBHb7gj2ru9m6BChgP0DNKD5ekJEcp+YX2WUrn1OLzwZBw9qUtaocahy
 9iaa9n+cft3Qb2Wuy8LSUYP/vfM298Sbdht1Ww6Cjncer+2fjWP9xMV3qQvjpLAuPwfG
 KLAnYqvTis0/2AJPcgxgdLrS5a5VQvPIhomGu44iGHlumCo2Fml0R4fvY1dwREykG54y
 MakQOaeTfSRoz/PRfZj/5zK8j+eyhBnFxNa9U0j/w7gDL/oLXgz+3T36D+HPo2KZJfd3
 El7703MAK/8kHoW0x93hbO/eRAijQvAX5cxIZNnhB43BebeDM2ogWzx5KOx5n8clcN0J
 2fEg==
X-Gm-Message-State: AOJu0Ywx/eUfdiIZTpUODC1+mol2Dqfcxk8BWJA4DqYA2ypV0Ym+hFhg
 054ylVOrxZ5Zdf9/8KyUxK3zVPCb2dr/72TXEbsKP8xp8Jfh5MagvG0d+mEDNU4axfs=
X-Gm-Gg: ASbGnctcyFwnFrWGq/YtndRUH1wCVfZF6M//bWeFS98S6K/9Lzy0islKs9cx503dBYs
 ouumg5qUTZlwv8MyWLKjqQW7lVogoyEB4FFObnvv472x93mHOT6NaCxHqR/K5FptRVE3ILDTWe7
 KI34RM/CcGapA7ZdChzeum2oFAVPkmNIUv3HCg2QIEk/SdlD2BHqNzP/gG7wHo0aJmNlBN+Pjnu
 5OgQhy/lHJJYF1A1lQN61z0qhlMnDm9Q0KwRq6VdEhN1fOT/vyVC0xnZj4i97k4j2Tbc9uSZFc4
 eTg8l7uOGFAYXZ9oyxn16ytXNOzviappnAOxwQykbvG4T9ZadZO1lpTsBvVc7oCrwO88N74O7mr
 BFOZRann4AKoquU4DzIHZ59xihFxQkPVk4LeV4rCHuIV2drgHaqRsJLuvie3CvVr+dHSD2ZoPOr
 +k
X-Google-Smtp-Source: AGHT+IGdHBkEtKTvs4lH7vVrF3ONWqmhMNQjVlAH5VBeznRboPjBEZCMMnVGgg9kTIdKMypns9iZ1g==
X-Received: by 2002:a17:906:6a10:b0:b6d:6c1a:31ae with SMTP id
 a640c23a62f3a-b703d5393a3mr343694666b.49.1761753448528; 
 Wed, 29 Oct 2025 08:57:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef96105sm12146231a12.19.2025.10.29.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53C0360DF5;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 25/35] target/sh4: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:34 +0000
Message-ID: <20251029155045.257802-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for SuperH targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-26-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 3b18a320b86..5d6295618f5 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -24,6 +24,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
@@ -60,6 +61,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     CPUSH4State *env = cpu_env(cs);
     int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     int do_exp, irq_vector = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     /* prioritize exceptions over interrupts */
 
@@ -176,12 +178,14 @@ void superh_cpu_do_interrupt(CPUState *cs)
             env->pc = env->vbr + 0x100;
             break;
         }
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         return;
     }
 
     if (do_irq) {
         env->intevt = irq_vector;
         env->pc = env->vbr + 0x600;
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         return;
     }
 }
-- 
2.47.3


