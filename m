Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE8C77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3d-0000a3-BW; Fri, 20 Jun 2025 18:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfa9-0007mp-EQ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfa7-0006R5-Ob
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d54214adso15791655e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440673; x=1751045473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgZw0o98z4SO2YkblX4Gw60mybDcjZ9BGBxkTRtPdgE=;
 b=xFrZXRNwEI9sb82eB/HvgKeEhpJggsz1zkSfYkyDRjmyKdbOWwoVFaR0Wfl9HC/W62
 zzBU+TJD8hG6w0ybVnhiKWqg1TCopCI2W9Eihuu7VJOAsx4meOgY4ZUUpNfwkE+1z25n
 QCe2XaXUbpWjCJcvGsvQLUMrz2zujfBBHJ5U4rXR2JB4ty4l/zk74nKeUXYB0/UbLU7p
 /q0L38+RQWB8cvobc7iCUk9SbTeSTRvk55IUiU8sWVuTFhsQTHIjugys+DI2nMvRDaJ0
 7Wcr9H7hei8n023h2nbYor+Ldf94PNU2MLrbRVSNGaggC8TSinKOsFJJY/0dKzf5iUd1
 Xwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440673; x=1751045473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgZw0o98z4SO2YkblX4Gw60mybDcjZ9BGBxkTRtPdgE=;
 b=TWdf1H/wReXwNn6XpGO8JKTihHTS3tLYL8scBnKE5EfJdasa2q/fbfb16zPVUTZnn/
 DIdwfHmi0bDmTU2NHPXKzTt3L94G0PMVLkGSm5oQQvAC/ZVlRrnmv+9polglfqzmn9bQ
 LPBz1kEzD0+ZVYtSczatDwj5hjMskjRM7j0azbqmqqmb27Z4YT9REP4BdzUl5rkXeT7V
 Hy0F0lvLHhMImJOc7RVtTis0fBseNzMy9mxcXzaxJOfZ09L2Vo7z6eu7TWDYx+GdnDUB
 TQbu5cdAf5HcNhVDMEDomvah3abM3yLBskzjuQl3Ep8S11Nwt/rz3WmssvRNUUcxdBXj
 Y+Aw==
X-Gm-Message-State: AOJu0Yy60URt1bPpWAp82ByMQHwE7YcJBA+PCauqHDm+qXnXmWWZnXrh
 jDq/fiBGIbU7ACS9En0Fjh5inHKojsbEyXdC9tRu/n31HVOf7lDH4CBidhmM8mEplIhMyLc7d3B
 XUWMTMNIxww==
X-Gm-Gg: ASbGnctT6C/eVmA8aGk+RGhmmWLws8TfijuQ42CRcAvgiBGdIXVfuIJgkapYPGf1g8R
 pq+3hXwhBOUdncRQgV92nwUEjBnO+PNOqsuQMl+CNjcRKC4kzO2d4X01YfhFAjWSjxf8mIObBQC
 srvJC0Xs7P3Z1IKfmoFgfuckPaeck8KX9C5e1ZhGpT8Lsmue+G1uZN63aIPBX0cO7SEd+Gd7uKB
 qRcE/wwpxPGmU+r30RyFyv4LJy13nYouymR65k2auZgd/V2rdR6IW6eccUX0W8YUw3wEI1n1da2
 STaH/SceWny+IfKKYUlw/m5O81KSakJWUX1+kT3xmrqnqI5MhufRhynDvvbPI2dDebqAtRkgocG
 cBqi4Rk6aW5HKEqs4PaCYr3P5CXQXmR2N6j+nHJNMVigtFDohyjI/XxHc
X-Google-Smtp-Source: AGHT+IE2Nc+f21UZUiaa7E/GuLOlv8d7Qf+QSYY8sQrd+jvJAQHtCYZFaPeTMVfrkHR8umhH26jEUA==
X-Received: by 2002:a05:600c:4754:b0:453:23fe:ca86 with SMTP id
 5b1f17b1804b1-453659be4d6mr34945525e9.4.1750440672902; 
 Fri, 20 Jun 2025 10:31:12 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10502sm2667961f8f.18.2025.06.20.10.31.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:12 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 22/42] accel/split: Add few trace events in
 cpu_thread_routine handler
Date: Fri, 20 Jun 2025 19:27:30 +0200
Message-ID: <20250620172751.94231-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 meson.build                   | 1 +
 accel/split/trace.h           | 2 ++
 accel/split/split-accel-ops.c | 7 +++++++
 accel/split/trace-events      | 9 +++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 accel/split/trace.h
 create mode 100644 accel/split/trace-events

diff --git a/meson.build b/meson.build
index 5004678a26b..06c32e0e958 100644
--- a/meson.build
+++ b/meson.build
@@ -3635,6 +3635,7 @@ if have_system
   trace_events_subdirs += [
     'accel/hvf',
     'accel/kvm',
+    'accel/split',
     'audio',
     'backends',
     'backends/tpm',
diff --git a/accel/split/trace.h b/accel/split/trace.h
new file mode 100644
index 00000000000..46b45388930
--- /dev/null
+++ b/accel/split/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-accel_split.h"
diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 1766834d537..399bf71a9ec 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -17,6 +17,7 @@
 #include "system/hw_accel.h"
 #include "system/tcg.h"
 #include "split-accel.h"
+#include "trace.h"
 
 #include "accel/accel-internal.h"
 #include "accel/tcg/tcg-accel-ops-mttcg.h"
@@ -64,13 +65,18 @@ static void *split_cpu_thread_routine(void *arg)
         if (cpu_can_run(cpu)) {
             if (acs->use_hw) {
                 r = hwops->exec_vcpu_thread(cpu);
+                trace_accel_split_exec_vcpu_thread_hw(r);
             } else {
                 r = swops->exec_vcpu_thread(cpu);
+                trace_accel_split_exec_vcpu_thread_sw(r);
             }
             switch (r) {
             case 0:
                 if (acs->use_hw) {
                     acs->use_hw = cpu_acceleratable(cpu);
+                    if (!acs->use_hw) {
+                        trace_accel_split_sw_emulate();
+                    }
                 }
                 break;
             case EXCP_INTERRUPT:
@@ -95,6 +101,7 @@ static void *split_cpu_thread_routine(void *arg)
                 break;
             case EXCP_HWACCEL:
                 assert(!acs->use_hw);
+                trace_accel_split_hw_accelerate();
                 acs->use_hw = true;
                 break;
             default:
diff --git a/accel/split/trace-events b/accel/split/trace-events
new file mode 100644
index 00000000000..c0b9fd97d1d
--- /dev/null
+++ b/accel/split/trace-events
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See docs/devel/tracing.rst for syntax documentation.
+
+# split-accel-ops.c
+accel_split_exec_vcpu_thread_sw(int retval) "sw: rv:0x%x"
+accel_split_exec_vcpu_thread_hw(int retval) "hw: rv:0x%x"
+accel_split_hw_accelerate(void) ""
+accel_split_sw_emulate(void) ""
-- 
2.49.0


