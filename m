Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ACDC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRv-00066Y-KZ; Fri, 04 Jul 2025 06:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRo-00064W-Oa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRm-0006cZ-Os
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so5177255e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624109; x=1752228909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o6bhqsFMFs7mcPHK86doFfOhErUfzngUDVxx9M5BYVo=;
 b=KJTukJXFPns2BhaHHaD6SLOj32PiZ8x+ZiZ2yXGUdDYm/UUz3LYhpwzcdaUQajV8+A
 ZETRcvIY2ZlGUws84/vCqx0DHcVjgWa6WLXfHG4iyBx7jydmtCezz5o2k++iZlnBei76
 +pZx6nEpbH000ABSiU9pwdFV3PGtiOiaE6oaGRnz07Tb5KBuQenT0ctG5HiBD/rDp5Kq
 Zj1lxSeIfLrOlRzCZnp3Ve+TfZut3WammpsVLjNazeUJeEFnuvk4Hpa72tGhnKLYAo9T
 qA7pTvUrqrkBZNyQD4BAXIwky84ViK4oE52UGZ5xraI/IOR0pzjtDCYZoPZdaCrmQ3Cp
 ZvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624109; x=1752228909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6bhqsFMFs7mcPHK86doFfOhErUfzngUDVxx9M5BYVo=;
 b=VL7KyIlzVuWNR6i8Q73VQjuk3CkwRsIjVr6PBs/sBk4tNJN15s0eX95twDAQRuoO+A
 E7/fmir+1WmBNprjAjdhBYuSuZ3snoCbE3eTFQHk77xF9v4SkyLM2g3+YfZYDyDk10zB
 C2hj8/mGMyi+Z+q2Fy9yt321HNu4thlIDF2zsmKn3CA5VZF/Kc6LHxzhxhlJoZDBw/GZ
 iA0uDwNk3XQu3sqTR7yP26pylfa1nc+vHJxcz95F4Qagz1QlY3aKdygEr5UeoQe9KGc5
 A68pGuLG+hqnwwxaTlL0vtHSDvrtwtGtdXFj8dvHSaEQA83aSnX+spBenJ5HWL1NQNt0
 5Q5Q==
X-Gm-Message-State: AOJu0Yzj74vjSf7Fjh/4iwMrhcbqltLsZbQJ/cE+EYQk3933T7uRnyyG
 SFlbQpF04fu7AX/4KgWtLTtoERY3kOzHy68C6w/47YsLAABZsuHrd2U25unt5ilYL+9m8LuwYJ3
 TNYGGruI=
X-Gm-Gg: ASbGncsgHWifdY2tAXwr6NrSm8Q+NHFj2BlJaN1UYlB/Pb9kvQlrIbyVDkfgsmpvrqP
 r7VUuSF2avbbRvmTp6zWsp6YowI+jB29YlRK/p+k5fTtkf+HNnt4S/UfSUDLXcb4k5NSDj1/2d8
 2FHFNmeVQTq2/96UkFaGJXjgWw7SjNq0nh4DYsvdOHJVFWCcsA1g0qd4y2O3JmLh1bmqoShWQ9n
 W8WHplX3W2AhPyWc8FFsukzWaHbg+Tq1MPwWEKos8QzIGNZ8f/A+ZDsfGDoFz4qIuCv6wc+UL7Z
 jTwGYUw7zwu/TGSK7iESdtcdwHhZSiUJdli101b0nFZx0w2A5Liao8uFwt13A3pUmLl2xRkEQHL
 mXWTUELqkBB6Wc8xC/Ue7uJBr+r4A9167RBY6
X-Google-Smtp-Source: AGHT+IEENzCbIdg7CplaJct7Up06tSjJHrmqapkzmUFTTiK2sRR+WHLgxWxJCZgTGJiLmUP2yOnCdg==
X-Received: by 2002:a05:600d:1a:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-454b306c4c4mr16348295e9.2.1751624108585; 
 Fri, 04 Jul 2025 03:15:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454adc71aadsm39418505e9.25.2025.07.04.03.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] accel/tcg: Factor tcg_dump_stats() out for re-use
Date: Fri,  4 Jul 2025 12:14:08 +0200
Message-ID: <20250704101433.8813-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-11-philmd@linaro.org>
---
 accel/tcg/internal-common.h |  2 ++
 accel/tcg/monitor.c         | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..77a3a0684a5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_dump_stats(GString *buf);
+
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 6d9cc11d94c..e7ed7281a4b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -200,6 +200,13 @@ static void dump_exec_info(GString *buf)
     tcg_dump_flush_info(buf);
 }
 
+void tcg_dump_stats(GString *buf)
+{
+    dump_accel_info(buf);
+    dump_exec_info(buf);
+    dump_drift_info(buf);
+}
+
 HumanReadableText *qmp_x_query_jit(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
@@ -209,9 +216,7 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
         return NULL;
     }
 
-    dump_accel_info(buf);
-    dump_exec_info(buf);
-    dump_drift_info(buf);
+    tcg_dump_stats(buf);
 
     return human_readable_text_from_str(buf);
 }
-- 
2.49.0


