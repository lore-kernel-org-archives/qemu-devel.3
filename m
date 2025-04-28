Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FADC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoG-00057t-Ge; Mon, 28 Apr 2025 16:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoE-000571-2M
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoC-0000bf-FH
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:33 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so4836318b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871031; x=1746475831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb64jDbydlHs1gsAgmEL7amkIFYp+vQ2o3FW/Pq/bbI=;
 b=qSB1W+cJbxTJgPYztAd5jYORuoquCStrrLA9aBuWSu7Jnt2QfBfyjKDg+ADg10fVzs
 SPqE5BxIK+Fayh5qUL/BciXvGB3nCMhQlm9++B3dGB2bBwTvQlOGcfMijPecBMmZ97It
 8oz4lPABuah0R2J2sKCdoBkJ4HDDZOAJ6YLDxd8XYH0UN6Q5vt9H1OgbKzMOJNhO9JHl
 C61Kvqw/d6ztu/QeJQHt0Z+ke1RBWIEepmGVE9Ubms3TUqZcGD1tw/ljLx6/dZIBb9nR
 IPPX9/VLNi/f/Aukn8wtZJFpUC49TPx6M7yqkoaYmE0Ke9595uHN8Oqo/2594Fxrsu6d
 LQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871031; x=1746475831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kb64jDbydlHs1gsAgmEL7amkIFYp+vQ2o3FW/Pq/bbI=;
 b=HG7Hijd/sJmjIyTp8PG9jAoGZQgADuaaieVmChViDMNLgJohN04A8pCR4uDi8/4U6r
 Tah5jVcncHQ7T9kPtDyHJc+htIFR5JVK6l3ZoSuM4K167Y+KXWk92q0IQbGHnUeQls7g
 nPcRc0EY75XGs/xCtqvf8jVi6cJkLqR1CSoIFdyWJ4+sbJZ8DjzSzYDTTSRV1AH+qjWJ
 tq6aS6+SCnp9OjtShz/azpgtMtVuxCF/HZ3X7TWLiDXiQAWM1gIGt/8q0cODATdOw3+x
 opdqQEQlCprTtQyryoSBWO/QtcEChmWyWmqPYkKAKxhq9kscklyTdL0PNYiQGRJgenZr
 m3YQ==
X-Gm-Message-State: AOJu0YwooDY8nHABBuSSOqOuW8uv2Ze78XIg/IfSmXjYwL0cr2KWbOQr
 E6b8q4XBM8UeyeCQfuhDMyCWQuYsqqlg5AEzQmBy8CkWpqvz1dD17eWKTshe/4MUs7LNy/782Ug
 4
X-Gm-Gg: ASbGncvyjQ6+9iIMy5IbtrHoJwSg5RXdIyRsEOx8rZTihSQkDlvtIpjsE/tbZ/z/RcR
 aDQIPnUmL3bsB9QnDiOEj459n450m7QTeM/iR9Po3GMzOGeMT91bkpFJ4nDlUJ0Qe+BJFZzMVYV
 Nz4CrbATUGH+1A0D6bhaeP3FtptX6keb/ZiaNOKEPG/mDS1DwWjSgq0qzhY8O4rj8Qae7ZHlQhd
 6I0FX5gqAEdeKd5IW03x4UjVVFOCwC637UaZ4SH+S9vd54EGNClThd20H0XhE3gx+bi8j67Yps6
 NqaDYA6zdK9lCsnCoFxIdCJcDrvpS69bpPGaHvf5dJ9QUMWyd0xSOkM7UMfXIRq4IqWkHXBk4Hf
 a0/k3O4T3rA==
X-Google-Smtp-Source: AGHT+IFC3b6Di07GyZpJYiaR4ZgcBN9F49kuL3KhcdXdBVv0RW4CnvPiwy0HCbVpfc5ua/qzfbgTQg==
X-Received: by 2002:a05:6a00:2286:b0:739:4a93:a5db with SMTP id
 d2e1a72fcca58-73ff7396ad8mr12590319b3a.22.1745871030766; 
 Mon, 28 Apr 2025 13:10:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 01/10] accel/tcg: Generalize fake_user_interrupt test
Date: Mon, 28 Apr 2025 13:10:19 -0700
Message-ID: <20250428201028.1699157-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Test for the hook being present instead of ifdef TARGET_I386.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 279df5fae7..8ff4a34509 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -732,10 +732,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
      * If user mode only, we simulate a fake exception which will be
      * handled outside the cpu execution loop.
      */
-#if defined(TARGET_I386)
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    tcg_ops->fake_user_interrupt(cpu);
-#endif /* TARGET_I386 */
+    if (tcg_ops->fake_user_interrupt) {
+        tcg_ops->fake_user_interrupt(cpu);
+    }
     *ret = cpu->exception_index;
     cpu->exception_index = -1;
     return true;
-- 
2.43.0


