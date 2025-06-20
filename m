Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80030C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5r-0003RD-Pv; Fri, 20 Jun 2025 18:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfY9-000799-V4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfY5-0005vs-FH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453634d8609so10078845e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440547; x=1751045347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wzg/smp28gVGoOk/QXqAN9Gw07kWBQjfeMgpREuKWCc=;
 b=FoveTgaqwtjaYbU/b1DB79FOzObtt9D1kWHtn93zASNdspxjDJUW6SrcPTvXGcrgSt
 UZPkaLx9z5BTHW71+XIfnbIwyYIYObvUGzI7cmEvNoh4d4wOW5CzT9tF5600LxKZYlqw
 3GQxwofRyrHMFl+hDIlcSYBbBX9z7099V9ylsxDoiNXA0sM1lhAQkStuQib/0Is3LuiD
 avuGDWmrcNgxCqPxLMRz3dsEmdmcI8SL6b3Zw6tZRWDcy1N/foFFOkmvzHDbAh5CGFrQ
 JVJ3gBpxK1ldeCqDhLVEonQKcqxBHxq7yvFOoGclLYxbjvmow0xpFy2vrXhE92/ZhGlW
 DZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440547; x=1751045347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wzg/smp28gVGoOk/QXqAN9Gw07kWBQjfeMgpREuKWCc=;
 b=GzFmV9IaqP2c7Z1DuEYtlkPcM3olzHalXt/+EWJfx6hMbO2/ZpHQkYyWjv7MjcGBY4
 OAp+/TUqVesodnrTYcaLraMLYgFFrmQ6gcQ4bWy39+ELZgF98Yz1P84+dq9bq4S8aF93
 T42MkFszHzpi9qIVBVOMxvTEmaw5uqHkonqYRVLd3tUnO6xWAKIyjPivdOedQjO4dGwa
 nuIYuRqdEf/NaQFS6Lkx/WOF9q1hHMAE+RluyIULysy0uyxphN2bR1hUK+vf4Udh0K1i
 az9M4HxYid1KqU0t9YT0supF7ohP1bDbUCkeLj6lpbXa5fO/O4MEG2zGWOxTDSVoZSqk
 aNKQ==
X-Gm-Message-State: AOJu0YxcKa4YSV/gkoucw79Ue0fBM+aJ86chHaMRJkmxmaLv2NcNzWaD
 IxzeTLJ76L0IATTS38Vewah0zfP0XFQPKPMnIZt8k8WSkovL33AaVSauyMJKOufi0pTJ4Zkbe4U
 2VXT6gzoFag==
X-Gm-Gg: ASbGnctDWINNaU38c8xAIn1G3/2K5iqd8nLqRj5gcd2qFGtWUFnuB5QAqwD+j6kJv7F
 s8+Rz5Z3hz6OiQT/v0jE2BWK/8mcGK8npie4eJ8BxsebTx4ig4fHeETSyCkR7ab44I6wikturfV
 XQ4qfd47Elbaznqc1e9OZL9dEW+GZ76FYBLWxy7slRz3Iw49sZQtbDOpeExOYxgLc8VTAXLFuGM
 ZQhsAmEPOo3BLshBzZ1Fy5MzxJeLU+gQx2hdftrCaTBgKAigsyuUypN0VjQPVuUoSe3vwM1qAKC
 k+L9/lZwkM6Ac7KPLUoBqEexw6EX/sqA59SEkbaloR/UGfUQtU2fpPx2emnGWnjJBXdNF0s5Hak
 kA+i6RbCt1+vN348MnULyUfGlcYkXuJ9KfiiFLFWKAuFK9RFzCa8ErUqnuGWlLJDRHho=
X-Google-Smtp-Source: AGHT+IH3tEAqP1uqhaV/gRrHbPnq0ZhYpelYFjMFNOTFXNVM1PbNzDVPrRsjrDpStU4LdOQfahT0jQ==
X-Received: by 2002:a5d:584c:0:b0:3a4:e6bb:2d32 with SMTP id
 ffacd0b85a97d-3a6d12a2416mr3169478f8f.22.1750440547318; 
 Fri, 20 Jun 2025 10:29:07 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c6a7sm2649591f8f.51.2025.06.20.10.29.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:06 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 09/42] accel/split: Add cpu_thread_routine() stub
Date: Fri, 20 Jun 2025 19:27:17 +0200
Message-ID: <20250620172751.94231-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 70 ++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index e5c1d51d426..294ea79420e 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -7,11 +7,79 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
+#include "exec/cpu-common.h"
 #include "system/accel-ops.h"
+#include "system/cpus.h"
 
 static void *split_cpu_thread_routine(void *arg)
 {
-    g_assert_not_reached();
+    CPUState *cpu = arg;
+    int r;
+
+    /* TODO: check accel allowed */
+
+    rcu_register_thread();
+
+    bql_lock();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+
+    /* TODO: init_vcpu_thread() */
+    /* TODO: allocate AccelCPUState */
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    do {
+        r = 0;
+
+        if (cpu_can_run(cpu)) {
+            r = 0; /* TODO: exec_vcpu_thread() */
+            switch (r) {
+            case 0:
+                break;
+            case EXCP_INTERRUPT:
+                break;
+            case EXCP_YIELD:
+                break;
+            case EXCP_DEBUG:
+                cpu_handle_guest_debug(cpu);
+                break;
+            case EXCP_HALTED:
+                /*
+                 * Usually cpu->halted is set, but may have already been
+                 * reset by another thread by the time we arrive here.
+                 */
+                break;
+            case EXCP_ATOMIC:
+                bql_unlock();
+                cpu_exec_step_atomic(cpu);
+                bql_lock();
+                break;
+            default:
+                /* Ignore everything else? */
+                break;
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    /* TODO: destroy_vcpu_thread() */
+
+    cpu_thread_signal_destroyed(cpu);
+    bql_unlock();
+
+    rcu_unregister_thread();
+
+    return NULL;
 }
 
 static void split_ops_init(AccelClass *ac)
-- 
2.49.0


