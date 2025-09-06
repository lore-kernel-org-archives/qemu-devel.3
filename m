Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1ECA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKW-0000VR-TS; Sat, 06 Sep 2025 01:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK2-0000CX-55
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJp-0006oy-UF
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45ddc7d5731so4963115e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135909; x=1757740709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWFu/FOotqt+eEC1erBIyw/Wf7YECCKKISB9pmV9BoQ=;
 b=AcdprEV95CW04Vi96zV/7dYROmx+zp8IsU8MMruMayI42BTnUAHlJfOF7vNyPyK/Qn
 dxgQrz/5+6xnczCwzSvT7WbcdO5X6Q2TANa+h8RGoWwOz8sy2G1EWqjbAaP8jMLPlDEY
 iiHX6Mi73r5Jk4JnYkIGoqcrDJDyOSPk9/KsQm0GKC4u7f2GgmfQXGsia/odJ5ErLnf4
 pLxRfLLBkdEpUqQBKlb1etGeBrZxEJtQcpLH77pUvF2sEbwxJHuMFUGu89ta2lxsuwGg
 BIXkfWLOOvldpAYyV1PB6BQpboxw6qOrZSG2Y6+aeqH4yA1z7mAkEvTGMFCTXpM2V6XQ
 u3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135909; x=1757740709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWFu/FOotqt+eEC1erBIyw/Wf7YECCKKISB9pmV9BoQ=;
 b=bi8C85Y/uPwrUj2nUEvOl+z1CSAiQmzy1h0/nOXk7W08N2qjC09G3UzZEY0Op/v7Wj
 1C1HpaN/d8az/0yu1C2452BxIK1HdvZkwlNc/hMXmXNvO7MYBukPsbK7hJYWUJNUwKAl
 GSv+BzUy8tq+fuMUtMg/vdDdvmsuwmqB9vU0aKCfbQ3psggilbb3YimUEW5nD7RDmxiI
 hEWhK8iChranijKo3RSS2gxWi4lzVpdANIqgz5gLsvzxnEzhgRQzwlRACNHoSyp2pzdR
 CIoZjk2GDBL2NiOX4zRkOoz3V5yJk9xVEllGxN3QWxf1o92qNSTx3WYbIbA9fh9VQGTJ
 0y+w==
X-Gm-Message-State: AOJu0Yx5VE6rpWuEMdv4B04CvzD/pmitO7jXCU1up87AgpdlQxBRZMYV
 ylygLG1P0O8cWlZs7BnPSMjh9R9iRNJA2TZ0aE2/b90ye9VxlTXgKM5JVkIgGNr1ewDjcnXJx0i
 e8XhrZ3Q=
X-Gm-Gg: ASbGnctX4AmWQoNRYOIaAaCU7HSEWqb5P6vXQN4aT8lh7ibXo/LlXuP/jn4ZjWrcNqT
 vv1dLdg4j/P0jATzRtxbIl8jai2IlufLr3d2K2HmK2avPWjZ2I+xtm0vGd5nQnRbHHiPWTlghQm
 23mBzG9+dOvDHfw+ylVO/nPGvbUXTwO6ZRYUWtQ4SwnBCoDzP7mBLVx2kRu/Jyw1R/y4xAdmVbG
 3xSyQXLOxiNibx9dJ/HcrFFy7VfV0+Uwgwqut1H32AcbtPNBtS5KxZmVUmuR9pvWQ4P3m7UcNuu
 hrTknZwcF0gd2fdS6vhdkbrg0Lc9DnGJZX793hkZjVWAYF8Y4mmSMlzmE1HxC02YvT25i5q965N
 9bcMGn0otHWpLAO0GEeRXgF0m4S/sEyekR9026Atir26oGESnqyi4Wv1BBjb+SM2s3hvygWEXtg
 YNGadu50o=
X-Google-Smtp-Source: AGHT+IHBxE9W1OtcwdfWI8AuGrh/X5ENXub/MjIMfZMIDP+iHrqVsuNx8WGo3o/SmAWeNIAB9C+xtw==
X-Received: by 2002:a05:600c:6298:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-45dddecdaa7mr9221505e9.24.1757135908773; 
 Fri, 05 Sep 2025 22:18:28 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 08/11] plugins: Use tb_flush__exclusive
Date: Sat,  6 Sep 2025 07:18:17 +0200
Message-ID: <20250906051820.160432-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In all cases, we are already within start_exclusive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c   | 6 ++----
 plugins/loader.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index c6e9ef1478..4ae1a6ae17 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -248,7 +248,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
         }
         plugin.scoreboard_alloc_size = scoreboard_size;
         /* force all tb to be flushed, as scoreboard pointers were changed. */
-        tb_flush(cpu);
+        tb_flush__exclusive();
     }
     end_exclusive();
 }
@@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
      * with the one in fork_start(). That is:
      * - start_exclusive(), which acquires qemu_cpu_list_lock,
      *   must be called before acquiring plugin.lock.
-     * - tb_flush(), which acquires mmap_lock(), must be called
-     *   while plugin.lock is not held.
      */
     start_exclusive();
 
@@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
     }
     qemu_rec_mutex_unlock(&plugin.lock);
 
-    tb_flush(current_cpu);
+    tb_flush__exclusive();
     end_exclusive();
 
     /* now it's safe to handle the exit case */
diff --git a/plugins/loader.c b/plugins/loader.c
index 8f0d75c904..6849e1c518 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -378,7 +378,7 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
     struct qemu_plugin_reset_data *data = arg.host_ptr;
 
     g_assert(cpu_in_exclusive_context(cpu));
-    tb_flush(cpu);
+    tb_flush__exclusive();
     plugin_reset_destroy(data);
 }
 
-- 
2.43.0


