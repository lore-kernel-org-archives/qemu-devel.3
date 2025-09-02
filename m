Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC37CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmz-0000V4-HC; Tue, 02 Sep 2025 09:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmq-0000Rw-3J
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQml-0004Re-R7
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b8b2712d8so24370555e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818650; x=1757423450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s4e3k0wKe8UGrBw6C9hTIgyim+urVYyDtWjW9sJuOOM=;
 b=ImE1ZzK3EPhN0SjsN/KKkknb8GCQ/iUGH1IxQ/CFcWDkpA/V7QHkCwvbtrL7DUSI7H
 bY+jdT1+dLhgtRt1utwi92KNw6/04lLtsx0Qe1iB/dr94deXdLmCQNRohjEUChfOKb5l
 8kwtvGTttYFpvmuqD957OszQfR+RwPz8hruYBeI9z1omBMjcNfD1lEbzpVELhSsSIWo7
 1GPHd/VLqdYIiWS5kH3tZZBB8udlVVUHjMIlcWyCEWvPYiqTgrWGH4Y17q/maAVnI+0s
 /0Gd6tYCujqlaBBI+xk7B7HfpRtvuO7Myus3KZ25K5IrnHma66JKi6Q11elA3BWyVIB7
 /cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818650; x=1757423450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4e3k0wKe8UGrBw6C9hTIgyim+urVYyDtWjW9sJuOOM=;
 b=uDgy3aVplbH5yHqUvMKnOFW9yc29a7Q7GdIQ3Q+K8+NKA816p+Jxo9erGZ7YcmeIdz
 d9D0UC5gGlQxa/ymmnhemnPxCY1RjMqH/mS1Z4FiLSeve3MLCNSc2C/1zejjssetIlXo
 J1zybA3mUI8LLOSsFHxLv+Jja6FTPT0niIzSAJRz8BYz/0YeaM0yCvnxOvvzSoiM8mk8
 hmVCbcpUyB9H+RoxuzJYmEv7Ko0wGqIZMmFaQVm+tkH5qjBHfyvC//95o1KX7978Ve3a
 4pfpMy1pFfz8pcxl3ssVq3cqMKYf+wn1Rw2A3/xfeDP0qcJebrk/4BBDhGBq61pV66DK
 oGTQ==
X-Gm-Message-State: AOJu0Yy4EWP16uYbHC33uNa3F49RkJsJZdwHtojtMyduPx/9x3jjDEfP
 L1Kul7JQyfQxrisDLeqdMU+tZ6/88pg/TKSi0UW7YiJssuoGNlhskIBFnJSH6gxHsgXoUAoLThG
 ibJoc
X-Gm-Gg: ASbGncs1KvwN/p/V2BfA++BSH4ReI7lCC+aN2zRSrtZtCtTp/yAFOnWMiX4gUmI9E2n
 sjLXdfGvwbqhvpjwfafAHoONkA0q+Cp2ZiX6GBImTVeHZZS13L4fZQEOewsmaQpsg2acuuduK9v
 KKBMgjeJOB2dPPdrLdGMY3+GwcDgWEQpcKBwPERygjBrBSPERgtofJfWIovFYnkvqbN/AkqXCac
 Yf17m8Dls6fPqQgSE2mIP3MZ6qOY3c+se88tqFHhefOMZbYepm6gjD5Azq5ryv9N+VGqQyt+Gma
 9+nrS5LfuiOr4OucLe9364v4vS0oBEMpHCUqBahqsAYfiTQ59Lmm7BK2zFtTspIMMPq19JeB5+2
 PyQr24D3YLwjdvndF/ycOQBgzzFO1TgdKfoMTxxDiTte4NLMZUzhSFfOCLGYY1OYOc2p1CNjA1f
 xgfUhiHF2hbHfCH7I6TA==
X-Google-Smtp-Source: AGHT+IHZeBlnqkqhZ9Nk0M2gqdnPA2dZDS6kjHgFx1Q+HMQd5baXMf81tcqspQFV4oOmHxjiSUSYXw==
X-Received: by 2002:a05:600c:154b:b0:45b:9961:9c0c with SMTP id
 5b1f17b1804b1-45b99619d89mr17214445e9.33.1756818650157; 
 Tue, 02 Sep 2025 06:10:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e898b99sm197199575e9.19.2025.09.02.06.10.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/39] cpu-target: build compilation unit once for user/system
Date: Tue,  2 Sep 2025 15:09:44 +0200
Message-ID: <20250902131016.84968-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250730220519.1140447-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build        | 3 ++-
 cpu-target.c       | 5 -----
 target-info-stub.c | 4 ++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 0d42de61ae6..7ff84787cf1 100644
--- a/meson.build
+++ b/meson.build
@@ -3876,7 +3876,8 @@ if have_block
 endif
 
 common_ss.add(files('cpu-common.c'))
-specific_ss.add(files('cpu-target.c'))
+user_ss.add(files('cpu-target.c'))
+system_ss.add(files('cpu-target.c'))
 
 subdir('system')
 
diff --git a/cpu-target.c b/cpu-target.c
index 772e35495b8..f030e2c642e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -27,10 +26,6 @@
 #include "hw/core/cpu.h"
 #include "trace/trace-root.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
diff --git a/target-info-stub.c b/target-info-stub.c
index ca0caa3686c..d96d8249c1d 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,6 +12,10 @@
 #include "hw/boards.h"
 #include "cpu.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = SYS_EMU_TARGET__MAX,
-- 
2.51.0


