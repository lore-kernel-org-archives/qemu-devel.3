Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E15C44503
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCrz-0004MJ-Hp; Tue, 07 Jul 2026 16:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrx-0004LB-Jj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:17 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrv-0003T0-7o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc97653887so275185ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457894; x=1784062694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYPNqqFbEEezjw6Z+RjX7uYmTjv7+lxqJe/BllIbo+w=;
 b=c8iEk8sNk+/Byofe/AqN2i5V/qzSZMIze/+IoupP6CMr9jwaZ3SFAZllLjOoxvxiSm
 hH8tdEhR5+z3LssfxHn48+hOuhqFZsz66UhLARqiVnbwS0FoCd3RL4bjWsqVPAB7cJi9
 k7e8/mg/6TJ1P/eU7OfPETwGFMlCp9JihBr8bC82zI+QfMqv6DUG5yA3lvFp4eUKK0gJ
 Y+88TfM5gVMz5kkik5BcNi1Q550FIuq8Q5TXoJc8UcybyAQNS3TI9ONk5nQ4vBwxeJEj
 p9Ff99UpayMdHKtG/rkPOJiIGyaxKpSEpDxBhs2q73iYtTapf7aX5b8R4yP8izy2QXYs
 TyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457894; x=1784062694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NYPNqqFbEEezjw6Z+RjX7uYmTjv7+lxqJe/BllIbo+w=;
 b=pjO2+wdBFtEgEw/CBGX7ClVz1YYo7gJ8mbqz2K05mAi0yUOaL/2Wid3cA8pxadclzg
 iRz844yvMLiKz03y6rYWyVQ27yVMpORB9vr76S8g+7r2pegoOQbxQ2LfI2fEXShIvhem
 Nzed+p9zWjo9EHdRwqNE0vgPe/fon2S0EGHqq0s+MXm5BEwk5xhHwBMC74hVX2Tecmxl
 WX/X/rwStu3Uk9Ka6/j4vHvCz1csFKP8AsqErEYlhYT83pr1ESxDG1CmjJpTzsKkSGMg
 9WXb81XI7klx38LGnkkD9MoZVhkRucdDLIZ6L+a47sBG8GN3ZeCH7Heb+a7G61XnR06j
 QCoQ==
X-Gm-Message-State: AOJu0YxvYZmcBcsyGSrsF87YAxim9xXpZEzlyMkmUhzAa5YmgjwBoG8c
 stwwk3ZsaxRNlUcd47ZEIwi3lVZafVUgxp/pFjbbRU0uqdW0HYZjbxSmeldzS6MKhM5lmsSEi1X
 0nnXB
X-Gm-Gg: AfdE7cn9Thc+trv91eF6aLhpxOONEuYUXrIGLFLF9dZbixyqaUufseKZSEtJ8E5O3CI
 imsLQWIHMftuCxItMt3CDLceAvM+XEbY8XQ5AE0PFb8ERozN/c0vGfXbD5Bu5hBpUBCsZzbHjyB
 I0GSpXDp986cRBvHDnXYPxHJc7TJh8Kn4gY0dJI+u8LwCu6cZWhnL+OX6H2PQMkrT90KE5BYtyE
 mEuROxnczV95cw8omtaKRk7h7N2EroUjR1FUQxFrY7vZiwnQbfOPh697cB902J2T/VkhodlBYu6
 8259NvOBDkavHafLy6bPicwFr0vyZPhuy6SuFMsXNQ7ZpwHZDIGiOGEfjH+YeCUvbFZP18r2m5o
 w5hL+15qG7lTU20IVYkzQfRKduZcpGswA7gHCskw5yqBYfJrav9iYhxSSh8pvKNAq3cOUiI1QdA
 QrYkbKG1gsxlM3fPwG5oelafHnOCShsH1X78WIBnkPZn4uecg=
X-Received: by 2002:a17:903:19cd:b0:2cb:2b69:8d53 with SMTP id
 d9443c01a7336-2ccbf043ac6mr68530635ad.37.1783457893418; 
 Tue, 07 Jul 2026 13:58:13 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/6] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only
 plugins
Date: Tue,  7 Jul 2026 13:58:05 -0700
Message-ID: <20260707205810.303376-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In 6d03226b422 we set TLB_MMIO to a non-zero value for user-only
so that we could return a non-zero value from probe_* functions
so that we could force callers like Arm SVE vector moves to use
the slow path rather than direct access.  All for the sake of
exposing these accesses to plugins.

Back then, TLB_FORCE_SLOW did not exist, so TLB_MMIO seemed like
a reasonable solution.  However, user-only doesn't really have
MMIO and this has knock-on effects, like forcing Arm SVE first-fault
vector loads to stop.  Better to use TLB_FORCE_SLOW as a more exact
trigger for plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260702171057.47998-1-richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 7 ++++---
 accel/tcg/user-exec.c    | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 357e79095c..e12cddf234 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -27,12 +27,13 @@
 
 /*
  * Allow some level of source compatibility with softmmu.
- * Invalid is set when the page does not have requested permissions.
- * MMIO is set when we want the target helper to use the functional
+ * INVALID is set when the page does not have requested permissions.
+ * FORCE_SLOW is set when we want the target helper to use the functional
  * interface for load/store so that plugins see the access.
  */
 #define TLB_INVALID_MASK     (1 << 0)
-#define TLB_MMIO             (1 << 1)
+#define TLB_FORCE_SLOW       (1 << 1)
+#define TLB_MMIO             0
 #define TLB_WATCHPOINT       0
 
 #else
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7704e4017d..e4629b837d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -769,7 +769,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         if (page_flags & acc_flag) {
             if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-                return TLB_MMIO;
+                return TLB_FORCE_SLOW;
             }
             return 0; /* success */
         }
@@ -804,7 +804,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
-    g_assert((flags & ~TLB_MMIO) == 0);
+    g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
 }
-- 
2.43.0


