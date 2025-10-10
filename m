Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49021CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cr4-0008Ab-Pn; Fri, 10 Oct 2025 09:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqg-0007kN-42
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpZ-00042H-2k
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso12211945e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101601; x=1760706401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SyGaerV0C5N7nCZ88ffo5AJUgGih2eXIaapWHvbWGT0=;
 b=mnh0R9r/1ABmaoW2OX6hH6Q2RFy47R/m5qC22ziYugIgR9rCRShoIbU/Gdo4QB+eQO
 vh68PPSGoJhzaWS4jxb7ZE9AWcG9YOVUe6g5kwRKFiShVnBsgDqlRAxFkZqQAg7/nVt+
 omUZ9HuwV5lwLU+mHxmKUqFg0XmPyFfsBLgylyuBLtsIt+jhmCwVR/oYJvzjMldsRIdD
 odd2uuOW27V+ltqou6/EHYT5YnWgTutJ4MKw1sDzHKB4CAeW0ZHyrFskuB6JDhu5jFzV
 /t4GocEuBhnMDYQtn/HUT/X1Qy8UINlXiEiaRLNe0umnWygzflp1JK26ahKtM+v+zEYA
 m7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101601; x=1760706401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyGaerV0C5N7nCZ88ffo5AJUgGih2eXIaapWHvbWGT0=;
 b=SVILS246dtSWu9um+58ZDULmAGbyzpyQOL1zMWcq6oYxzyZc0AIQwjnd9rcls34r5T
 O5Aj46rSjtf5wdCpC6zD6Ti6uV5xtO+MD6YWsFhy/qeUeX7rNc3ZOsZhY2XPGgMqiGc9
 m2QuGI5gge0U3+r2bR4bLom5D7PsuMMUI7rqScYOykKqy3Bp9jSF/v8wcTiNxi3HvQLi
 ldX8wxVH+IfVvFrmRwQzHeBhfOBfTnWT+/xccgzLlA4BMPafUQm0LkwgRKFEKCU+mlcd
 +HB2rlZWdX8xib645+LJ1BoD5sUxKvV6D6Oy7re0p/MmdIXWIUNFNxggVf52qRDFdBLw
 B7rA==
X-Gm-Message-State: AOJu0YwHlEPHvmHhNntW1wTT4LageeAo4hIMD2I2Fo0RRCkY7j3Y2kUu
 /P0xOqVzCkGbzx4iBTMYeqNar1IEORVYgriuc2rmYcmGJdzQF9oh9YfxC05AbNWHLdbnK1MSWsk
 fxEg5
X-Gm-Gg: ASbGncsK74ROVdvaamH3sEkxwOIejOs+9eqjojIJKtWvfqtR4u55Y4yl2cJVtdpcLtV
 Cpm0oJy6J33Y4Vva3wMXg6miAz9nb+UGQ3pHr9Cehe90kvE7n5kZ4t1koEtoz/UM3jHda6mAfYe
 K4TR2OnHp87Rr3nQvwdBx0Jc+yWuFPftxt6ftqgXSeTQx2XVL/jLOprtwEl0uZ9bzAtGqU86Ec0
 UZE5q5vZJCDEX1iCU3JcZVYEJUYptW+cgoFA7yO/cIySD1KybhTy5EecqZJotx6eMurNujoIIrz
 7j/HgccyxnzZ6Aof65tjAKzogvpVvhVGz/+EaqxTaPcpMpvFis1X7Rq2I3zBiTUyjdb/WMb9z6I
 kO9WNPDXDkEqEOCy+uli+zEJICDmFbs+x28hU3Nl0vY1wyYZleO4=
X-Google-Smtp-Source: AGHT+IFIYYFzsRITfOnPu37Dg4WsOCpXFBPAxAFeTyInfX/2gJb1DKy6k+hYfRkcDgIHq9a7x/f8eg==
X-Received: by 2002:a05:600c:4ed1:b0:46f:b42e:ed85 with SMTP id
 5b1f17b1804b1-46fb42eedfcmr25986025e9.38.1760101600599; 
 Fri, 10 Oct 2025 06:06:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/76] linux-user/aarch64: Allocate new gcs stack on clone
Date: Fri, 10 Oct 2025 14:05:15 +0100
Message-ID: <20251010130527.3921602-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allocate the new stack early, so that error reporting need
not clean up other objects.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-65-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 56695de680f..dffe6c20160 100644
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


