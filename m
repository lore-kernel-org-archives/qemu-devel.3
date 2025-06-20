Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2D0C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4m-0001Iz-5P; Fri, 20 Jun 2025 18:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfa0-0007k5-UQ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZz-0006OD-AX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1836758f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440665; x=1751045465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvUHSxDWfq8FMweHWOsqHlOKAxkf7U2O6uoFwbeRVyM=;
 b=idv787+u7fqx5yP2mSnEJbyA3wjfsTbBi4mGvoTTGtjeV8riPZaHE6/4pcleMZI3ky
 XOou0SlOR6vMjIC/u8DwzU3xZbxve9NtXrgRjUejdN3gRDedMlsk9EQ/mMfOJTlwwuKN
 q0Z+Dk8JDpcb1FAPiD9qaqfwanFCdAZKF0jAdYBe4dQWMXf8TZijQMonV/+vAYrwxY/6
 4KCusIe+MfL49jHDgerIFlBw0OZXGsNbhwsau5LsUCCYIKW9hibf7AB9Q8dzhA6Aut2Y
 gPunl344mre7XGMepJpWzrt1VgGbDk+eOiTeWmdJEupwvR/hE4y1E8fu9wQvUV5Doeeg
 CAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440665; x=1751045465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvUHSxDWfq8FMweHWOsqHlOKAxkf7U2O6uoFwbeRVyM=;
 b=Ko3OmQvKvFPKzF4y1x+gnYPe+BQh+wpB229pi0a1zZ1xu7TVzfkFkH8LRtPQP121vS
 rVCqR9h1rYraCAnYOh5A/k+Umc3s/H9rvgGAJdqIxeNxW81B+tNtAvQv/YTgcDsxyzzq
 /16thPa1dX3MWuXg6KvWlX7QZ49jEbIkehYc96zroVsqtDYMnaRQz6auxmCWcDn7uddt
 fesUzDkUKnvvFde926PGLe5p4yymWtSfIatgMWPVTpu1kf+/uZ4zElEnVWkx9IdTSPJg
 XXVeN1V8nTNyrlzk3SrVAfk7Br3viurSEZrqUSJ/nE0cT2brrXch2Ait9PvOjvGDMovW
 qXdw==
X-Gm-Message-State: AOJu0YwDkAp1hFgzJzhf0LFRxbBAGNY5bAsO53Sut86ow5jT+wToFq/f
 nbUmDlrG2ekC+ZX+o46B2ViF1/pfJjOLZOc8hjv8hlYb2FpfE8QCMjUI+Qvqn8sNvVXHP+YkOjt
 +jWoge8C9Tw==
X-Gm-Gg: ASbGncsnWwq8gphG/WHr3TwYrXhGkAHnEEOKhHBj/XWqN3I52tZedUqgfPh7ya3rt1l
 tMIZkKtHBwG3+7OfBfhZhjY5nMI6s+jQqDRvIfPpH2VA1v5Us7lihTxQmktjY9JdtI+PuRFBBtZ
 LWeK8iuR9VMxki/r+g3QM5HYn/7D6hf1CbJKMnjyEOad46xlR/4K9C2QtE4ko5plAoZRs2ECMGk
 27Y1J3uBUU2IuUccZOHR3gAF531jLKjdWCkdH2SonlOp5InXnRj33k8jNddT3PU5gR3j9vwOcvx
 W+3o7HEgO7mKKchcUvtRpcOoyII/cSv+65tEltj4plFZqQtnm/IcuZR9gqCOsZQzimfyvqsbWhO
 amSW4IX6YfoajGSfQdrfECOBFLITQSmWCMAcl48hWol3qw9Bsn4z5862j
X-Google-Smtp-Source: AGHT+IFXnx9WlIHKvsq637oS9xNnqUoUl4E3p1e1gfA6cIEDz8JIXCUKhdMPMZ/ETv5pcCBEukBxCQ==
X-Received: by 2002:a05:6000:2004:b0:3a6:c925:ff57 with SMTP id
 ffacd0b85a97d-3a6d12a377bmr3378035f8f.13.1750440664662; 
 Fri, 20 Jun 2025 10:31:04 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c0fcsm2649111f8f.62.2025.06.20.10.31.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 21/42] accel/split: Set use_hw in
 cpu_thread_routine() and switch over
Date: Fri, 20 Jun 2025 19:27:29 +0200
Message-ID: <20250620172751.94231-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Introduce the EXCP_HWACCEL definition to switch to
hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel.h     |  1 +
 include/exec/cpu-common.h     |  1 +
 accel/split/split-accel-ops.c | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
index 87a08454ce6..8a2888507f3 100644
--- a/accel/split/split-accel.h
+++ b/accel/split/split-accel.h
@@ -42,6 +42,7 @@ struct AccelCPUState {
     char pad[128];
 
     AccelState *accel;
+
     bool use_hw;
 };
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a68485547d5..6216be5f5e3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -20,6 +20,7 @@
 #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+#define EXCP_HWACCEL    0x10006 /* use hardware accelerator */
 
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 3278e01f18a..1766834d537 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -10,9 +10,12 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "exec/cpu-interrupt.h"
 #include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
+#include "system/hw_accel.h"
+#include "system/tcg.h"
 #include "split-accel.h"
 
 #include "accel/accel-internal.h"
@@ -66,10 +69,14 @@ static void *split_cpu_thread_routine(void *arg)
             }
             switch (r) {
             case 0:
+                if (acs->use_hw) {
+                    acs->use_hw = cpu_acceleratable(cpu);
+                }
                 break;
             case EXCP_INTERRUPT:
                 break;
             case EXCP_YIELD:
+                assert(!acs->use_hw);
                 break;
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -86,6 +93,10 @@ static void *split_cpu_thread_routine(void *arg)
                 cpu_exec_step_atomic(cpu);
                 bql_lock();
                 break;
+            case EXCP_HWACCEL:
+                assert(!acs->use_hw);
+                acs->use_hw = true;
+                break;
             default:
                 /* Ignore everything else? */
                 break;
-- 
2.49.0


