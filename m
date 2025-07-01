Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A95C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFZ-0006UY-Ep; Tue, 01 Jul 2025 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEq-0005TK-2v
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEo-0007RO-1O
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so38380785e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381130; x=1751985930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfIXmPf89XXe1HBqtw6MJ15ZCEw8ryCmetzhx/QXCNQ=;
 b=T/uN01lK39/IysIkQwtjYzi6GMdSAW5FLXeO4snsj2KDo0TBO5K2hkv+uOXhFT5B2m
 sPbQXVmhWJAYW0UjUvArRQWBsCFqLfz947p8Tg2VThAkjwfR3EL49vv3aKn/k9n8rRxG
 qoYu2wGIXcOaO89VMD3Aej0rXvzSDw5h6y/tWBQvUuCnhN32WbGjrTviNRlHbWiIMnnk
 oEYI51EwQZ0TcS6kpOA1+kXN41y2pwuIspT4N3lrAH6YF6vSabzgjT3dXLnx6xlaJdrh
 WNrQio+RVwYFgotTVHMD7ZMiypgSYW+SUp1nX0u5hkYqZtNLRN30M3KrWaNhcmkC+Ur5
 b+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381130; x=1751985930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfIXmPf89XXe1HBqtw6MJ15ZCEw8ryCmetzhx/QXCNQ=;
 b=RDWfpk/PQoDEPTMNfhpcCQ2TZM4UTC9PMAhnq2FNfbZcwfl6H8iFh/wvyu1LrTPoNY
 sM8a2NMAyaZmtjdddPz0CVVnXHp+jRChGNEFHBziOMjLxX4yHvroSVAHwpoZim5zmZpO
 n3fAw7YUXTXozTbcKiz4rz93W1mxSQQ/oU9owfM+Hv5cGG5ASxNjur4eKBl/7lP3vfc9
 dSyBYiGxNdvdUsHViYX2hmB3aKG8YVjWlDdeoRdQyKV3EznXFaE265Bqpy6PQtIMXDMu
 kNARn2Fh568HXtVtTk4ahnSKe/TgGRsParpH6vmFztccHkddKF2YFTcQm+InwHbY+XWH
 1k1w==
X-Gm-Message-State: AOJu0Yz33IjYftxKKBmy1x/kmxzk/kplh/IiYf3dbR9S3Lcu996NgIqo
 PMJh8kdHBjguDAGT6zPxyD6T8ri3X2O+Wr2SE7qCQZhUJeGmMWJbR2TpcJU5APj0CmFMcmynRNP
 l4xSv
X-Gm-Gg: ASbGncvtp7252exVQqKMV1CpbPQZPziF+mlR+/wzkTxNwtkyNKJMgwbJapbkGb2hHC/
 Vi5zqJQ8he4o2Q+XMZ/mJQaGp7FD+6Au7IHRitPHcu6sYui3tYcrqf9rOKoYiS8o+8oFPzS+sWP
 GHA65VXMzHRIsyvJ6frHU3XRZtDAfQFZY6bSSilr/eCdPFD2QRfPHGeURTWyk/GFLjRzbSEWaZd
 fRdcjqoDv/OmUxezhh11XjOWEM8jt/25W7hbhenvU/AtApc3KMOuNZshW7OMK/s7iZSn+K5f59i
 Y6JBpxQa0mJ6V+qyw05GnbnCrkzkI5qjHdFEFinOTTLaEdHBrNEKKpATd9lqqBXnAkeMjQLtZmy
 EuKuXTs1ctnWRZ3XWKrGLdPVDgtDA0dUXkH1H
X-Google-Smtp-Source: AGHT+IH0NoSf77UejRAzWuRL0iFSipP2VY63L8cEMTMGmuU/liKUetL2tlYYBu3h5d2mQXPqPKegDQ==
X-Received: by 2002:a05:600c:3494:b0:453:5c30:a1fd with SMTP id
 5b1f17b1804b1-453a33d6fb9mr68703175e9.8.1751381130323; 
 Tue, 01 Jul 2025 07:45:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a72dasm167627045e9.16.2025.07.01.07.45.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 55/68] accel/tcg: Factor tcg_vcpu_init() out for re-use
Date: Tue,  1 Jul 2025 16:40:03 +0200
Message-ID: <20250701144017.43487-56-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 accel/tcg/tcg-accel-ops.h       | 2 ++
 accel/tcg/tcg-accel-ops-mttcg.c | 4 +++-
 accel/tcg/tcg-accel-ops-rr.c    | 4 +++-
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 129af89c3e7..1263a666774 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -20,4 +20,6 @@ int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
+int tcg_vcpu_init(CPUState *cpu);
+
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 96ce065eb59..4de506a80ca 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -79,8 +79,10 @@ void *mttcg_cpu_thread_routine(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index fc33a13e4e8..9578bc639cb 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -192,7 +192,9 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 4931e536beb..83fb2d1362c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -76,6 +76,13 @@ void tcg_vcpu_thread_precreate(CPUState *cpu)
     tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
 }
 
+int tcg_vcpu_init(CPUState *cpu)
+{
+    cpu->neg.can_do_io = true;
+
+    return 0;
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


