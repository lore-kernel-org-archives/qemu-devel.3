Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB7CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEt-0002mY-HP; Wed, 08 Oct 2025 18:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDF-0001Kp-LT
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCW-0007QO-TC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso271549b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960797; x=1760565597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvGI0BB4BkgReDRlpJ0vAJBgFtwv/7JiHcnBRC6GEYg=;
 b=pUhb5OyMxaQygNxsjjlKcHB4KhdjfKsPN4vcBfvrpqtSDXZ4e0qNiRnRdzonN/gQGw
 a/AXuf6hEKeQM/fpf1KOx14gTSGvUDGv45I5QaBvXGEZCaSa387q5xkAu6nWmUBlkneQ
 b4pqlWaQTGuisY2bCLMwwzD7tUYp2+QMh6QjQAR0wppwK67k7kDcDpywp7LhqEIivsHO
 eQ7CTnm/3hFsdVDKt1jPlonpKzMJea5N0wkw9snLYais2wgjnLxd0nVKljV2WerD1axk
 CKCV0v13ONjJr2ld0m+uz1CBmcDzesDUR0tUPZsWVwWV/dNUVmvy+TSsM7IYSGt0TYHk
 r2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960797; x=1760565597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvGI0BB4BkgReDRlpJ0vAJBgFtwv/7JiHcnBRC6GEYg=;
 b=Xr69RONEuP0aRN2UcOIgTr9OzE8HHbM/Gpg7eJ/xhypqj4jQSUU7E8eIFbKlnWUym5
 tzKwL+1CLmlPhwD8w2lS9x03CR8Wu/rofhB9ybaVDqel0dgkQ7NtWHm35wf8r6eGkc+8
 zZd4ng+S49ZkkY55BCFF7z6BCWBpO41UEHMu1MYBDFrZDKXyCyYXflhzzZjUiyIN5cIx
 hZF9ZqOgHZ1CCtRIvdgg2FavFxUPQxA3HQXkqXoe6AsAjFsYuToXVlvQeIydt+n9ehET
 5gTefLk/OAjZzUJ3Se9KUHICftsL1H0G65Hy5I9oYMBP6Yw6/DCx1xKBJGiMcbIRlMYn
 OI0Q==
X-Gm-Message-State: AOJu0YzNpYKpCQwoZc6TZQnYy9+QoXjT3ZQoqIC4QkvUUYQXE/6DBiR9
 TKC6+5Po+XmspA8Liw48xOv+eU9BdmisJi6OGuPQxGbj/aeIsC6Z39mc7UiPHEbgW6GZN70scgL
 +Tx/wXbA=
X-Gm-Gg: ASbGncv6lv0j5U8fB0iwrjc4BFwlM3zNWrLE6E+NBkyQBbtsY4UrMknrYU5HZ2cZhDT
 MFq5XDyhNV+16CCPKe95nxlzuJ8zn/HPuRcgC2+4dS8xGBzb07x1G1cKWlM89ozOjAh984j37wm
 evO01urf5U+5WB63XSML72h4kdPTLJk6Yuv911OTDMPblE5XZ7vnZzlMuvFRr0Vei23QOqOEm4X
 iJKgCQiIoJWm936vBt2oIUlwHsiAn5Q8MkO9l5oJg/6Er6gCyY428Wn6aFk1XgSkvC5d64pM3mJ
 UoJn45j3uPUPdc1ZrNyGAwehCADbXYzGLMHKGGb8le2IFcNA1ISd8B1q8p8oZE4bxfQU/cAkdeu
 6MMVi5aHjLLCg21jUMgk4r69MpkKuVjdDkHBRQTtDAAzNCNcFZSnfg7YV
X-Google-Smtp-Source: AGHT+IEAc4GvzAL0dv6Msuxwa3X4zbXmrRXsmweaAEN2LppmiCVAAL0iVf0LqYNHR2xRWG/nrI84Bg==
X-Received: by 2002:a05:6a00:464e:b0:780:fff4:f7db with SMTP id
 d2e1a72fcca58-793874402c2mr5837938b3a.15.1759960796805; 
 Wed, 08 Oct 2025 14:59:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 64/73] linux-user/aarch64: Allocate new gcs stack on clone
Date: Wed,  8 Oct 2025 14:56:04 -0700
Message-ID: <20251008215613.300150-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Allocate the new stack early, so that error reporting need
not clean up other objects.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 56695de680..dffe6c2016 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6686,6 +6686,21 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts = g_new0(TaskState, 1);
         init_task_state(ts);
 
+#ifdef TARGET_AARCH64
+        /*
+         * If GCS is enabled in the parent thread, it is also enabled
+         * in the child thread, but with a newly allocated stack.
+         */
+        abi_long new_gcspr = 0;
+        if (env->cp15.gcscr_el[0] & GCSCR_PCRSEL) {
+            new_gcspr = gcs_new_stack(ts);
+            if (new_gcspr == -1) {
+                g_free(ts);
+                return -TARGET_ENOMEM;
+            }
+        }
+#endif
+
         /* Grab a mutex so that thread setup appears atomic.  */
         pthread_mutex_lock(&clone_lock);
 
@@ -6707,6 +6722,11 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts->info = parent_ts->info;
         ts->signal_mask = parent_ts->signal_mask;
 
+#ifdef TARGET_AARCH64
+        ts->gcs_el0_locked = parent_ts->gcs_el0_locked;
+        new_env->cp15.gcspr_el[0] = new_gcspr;
+#endif
+
         if (flags & CLONE_CHILD_CLEARTID) {
             ts->child_tidptr = child_tidptr;
         }
-- 
2.43.0


