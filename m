Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108CCC77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4P-0000mJ-1Y; Fri, 20 Jun 2025 18:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKL-000122-CJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKE-0004FL-Jd
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso1802339f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439687; x=1751044487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15D3isY4l+uwS25oxkiN7c++y0O/h98h4xMzv+uZTLM=;
 b=dw9divZfakRx3L/ZXpqX0ATIauP+zS0lMTH3kA1UEg69eVt7jVCP1uVr76liIbzVun
 C4U5RJ3BB1QS44jCSLi5Ro/B30yK6pcPAqNMuijnpbTHA+krCbqxvEyeHKkloXb7sbFo
 SiIddZbdXe28WosQPNpB2wG0LPipHk3QRzYtd2ejqR481bxkvOI8GkN5eXRE/9U7oG3r
 aj1V0TUdRT9xobhz0/6gn+MVOpdWsYCgaBlfoPxLjT5n6XjGOkoyMkCi2G2TceMOZzsY
 Z6Sru/jE6y4wjFdG+kDXJZnKnAiIDW2b7JoruWCG1dTcQGRoQnQQMQfOKSfPyExrqRDq
 OC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439687; x=1751044487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15D3isY4l+uwS25oxkiN7c++y0O/h98h4xMzv+uZTLM=;
 b=XvcvxEczHbHpgfqWNdl1FEAgCw9PjLLFzbYgiFkMMATIsiIT4QgtsC8SSxVG93qPST
 YMX+urV2lKhqBcZ98WUXQAtjhgEVc2vYeLQbgfbf79hC2YiAB0LV/pnwgFuxXK7Zzkyd
 e85ADaxHeq4pBfeadopwn3LfJNmIsLbzvSkdvhJrNidyEaJ+8Rnx4Y+fSDQAscbbFHDP
 siFSTF3aBoTPiUAvkcfHGafFVUMBZc0tfi4mebcb5vuqYqYJUs++GTV149p/aYw2wnW/
 5KhU35OhKN1Udl3lFv8UvlgVbnfGZNAAXyiXinAYkCxgEG6neKRo4hIpB+bykumfmGb+
 sAXQ==
X-Gm-Message-State: AOJu0YySh9aEe5XGtfeMUGzEcNc6fdYzbSu2jREfAdhyPgj1vBGeYq6+
 7WjEdeaeBZ/DtPomFQyu8qSLDA7ZLXOzs6xlH+ClPW0kaTFbuQSVA/nVYRPiyP0ncUafits/+p/
 F9XWw3D4=
X-Gm-Gg: ASbGncsqcXdz7FnBzRaBx+aR93xCEC3RswheZlmR6p1BqAWre66NRgK3/ZzpXxSpba7
 7utNFnVSA3P8UopX6w3dd1jKzXIh2pg8O86T09pKLbXTEUJbDUAmVjrtcJ95n/VziojgdXmPqxI
 Gzx2OBrtzjM89i2FZzwcZLA1LM99fnPA+XaJLO9fjaRCuxsP5YA6n1xrweAcLDFB9Hrx8r/hm9L
 kchKZq5KxaAQWHblz+n9qwt4Jc8rM2D6mHKdwhTn2mvfvv9m3gltCTQOXI+eUdQJ9anf3E07Reu
 hsvq2EpTHj85hxgLxlr+lDtiyZepgJUphHkC19shWEoFOY6iJBdw7NsShRS3iVQ+eUOc9PYNin6
 Bw8tvnr2Gi8qQcsgy3GWAnCF4Wh8BcG+3gC+5
X-Google-Smtp-Source: AGHT+IHExyLiz2129GUCSXtaD+vCib6+sbpI5YJ0gJYGGhiF/JKuIudRNmVOpZu05vpSTsPs3M109Q==
X-Received: by 2002:a05:6000:4917:b0:3a4:fa09:d13b with SMTP id
 ffacd0b85a97d-3a6d1333f71mr3804288f8f.59.1750439687161; 
 Fri, 20 Jun 2025 10:14:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453632312a3sm41221035e9.1.2025.06.20.10.14.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 13/48] accel: Move cpu_common_[un]realize()
 declarations to AccelOpsClass
Date: Fri, 20 Jun 2025 19:13:06 +0200
Message-ID: <20250620171342.92678-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

AccelClass is for methods dealing with AccelState.
When dealing with vCPUs, we want AccelOpsClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h       |  2 --
 include/system/accel-ops.h |  2 ++
 accel/accel-common.c       | 10 ++++++----
 accel/tcg/tcg-accel-ops.c  |  3 +++
 accel/tcg/tcg-all.c        |  2 --
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 04d252d3d65..aee0a2e3309 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,8 +41,6 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(MachineState *ms, AccelState *as);
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d854b84a66a..fb199dc78f0 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -34,6 +34,8 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 1d04610f55e..d1a5f3ca3df 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -102,10 +102,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     }
 
     /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+    if (acc->ops->cpu_common_realize
+        && !acc->ops->cpu_common_realize(cpu, errp)) {
         return false;
     }
-    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+    if (acc->ops->cpu_target_realize
+        && !acc->ops->cpu_target_realize(cpu, errp)) {
         return false;
     }
 
@@ -118,8 +120,8 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
+    if (acc->ops->cpu_common_unrealize) {
+        acc->ops->cpu_common_unrealize(cpu);
     }
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 07b1ec4ea50..95ff451c148 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -46,6 +46,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -212,6 +213,8 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_common_realize = tcg_exec_realizefn;
+    ops->cpu_common_unrealize = tcg_exec_unrealizefn;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 164bba41ed9..28206ca5e76 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -244,8 +244,6 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
-    ac->cpu_common_realize = tcg_exec_realizefn;
-    ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


