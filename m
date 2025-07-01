Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B470C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDH-0002uf-18; Tue, 01 Jul 2025 10:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcD3-0002ac-6X
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCx-00075x-99
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so36169525e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381016; x=1751985816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LMdB5rdj7iJY8MWJoU9iJ4flVpEl2P/b1SOEUaavlU=;
 b=dV+vzAOgBfeoDbQQH0HAyxqxyquOPBdV21SglErwhDGb9TTBBxqte9UetONQLnrVBl
 wfqOlQgFTE89m5z6h62OjKt/CNE3J4KTz9PKhk9afJvM7ExKLGbJV7bRNUp4zJIG4Tqg
 U1cubGeVPKClRLmgkZafM7Hbf6hOfmw0zccfub39Ths5GK/IBl4mDF/TKGX375DFA+mJ
 By38tdvW3iakSzS14t4ULTiwULP5pSyB5TANtJY1Jfy/EhX7jfps8UvMMTOEg58d52vl
 EvYfZiPf/RR8uk4hKPX0Q5x+6tyZIVQA5hPdE5iiUQnxxY4FcYgVFO4qGsfrmWBRux/A
 HNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381016; x=1751985816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LMdB5rdj7iJY8MWJoU9iJ4flVpEl2P/b1SOEUaavlU=;
 b=CGhJDRnQs1YjMyKAywm5HTWv7EY2SnSvtHhLQezL0iHk5FUA/Sr6p/vslZH9tQbmLk
 R5ZYwWvkxn6jHpsc3+TXT5LE6fsIuCJOqXZ/a45tbjVmzwQztgARkm3TprEdo0j33LU4
 teGqFifpTH9Zs9lL5hQrPvs5/v7a8CXJGPYvLE1RuhdVp/eCQM0l5xrHXOY5WRubv3Of
 6VknqKp3UB0Wdn5NCQeTkMdAKyXyruulO7ZdYdvM4LJHBPC0i4uvJMO9rz0hFcA06Cb8
 JBcVk+lQ/yWSQJCOylai36GQO0K61+6FgkUb+TPRSrEJN74+ME17t8EWWHwWzUbQ1mGL
 G/xA==
X-Gm-Message-State: AOJu0YwTFpZ39k6dtCESCoxEc6xHMvQn1wQBcmaSBarwMA70IefIHfAx
 GEUc0a2uM4eAp0gTUd5oAX3XTT0S6LwnQAnu7nq/FKie5YfGCg9uItVNK/MrJgOoEr2elQd7B1L
 TrHNc
X-Gm-Gg: ASbGncvmIg/miPxuwkEnT1+zFrx4hhACHUJbr2cLYs3Ls7j4tGXdRNK5tyIzRGBgVhE
 EshNmWqX11Oxg+R87gm6JIQxC1mPN3PaXd9K4r6RLhx9fUeDrORtfdIEB2LcXjnUBIpegSSSqv2
 3HkuCBh0TQUMfDsMIUKrmh7gqqiZsuW+zPp0b8DV4gkNM9XyBai1V4AogVoEMhSfG8egJVrMXAK
 8HW8a7ywE3gHKxYooT+MYOKkoK+pV8dZyJL9QMOLmT87waz/SVBAVM+Qmi8vq3qhmqj3XnXmKym
 duhDv2RE1hnxuG9cLcSUtJFJmuI0k2ZFolh0o7fhIE9ChIt19EltZggUJeY81zP4nlSmGnmbqnI
 ve76+fd5Ts8+FyH2Z3ZXpGb124B6z5ItbbpCogR1suCN+61I=
X-Google-Smtp-Source: AGHT+IH4ZZLhjc2gVnqZh+GSOZDENGbz7RXFOsXUA3DiG7THYsRRTJ8RD4CVR3hmlThnxlnfP/A9xw==
X-Received: by 2002:a05:600c:444e:b0:450:cf00:20f5 with SMTP id
 5b1f17b1804b1-453a7c18ecdmr46522295e9.9.1751381016016; 
 Tue, 01 Jul 2025 07:43:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234be76sm198394635e9.15.2025.07.01.07.43.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 37/68] accel/system: Document cpu_synchronize_state()
Date: Tue,  1 Jul 2025 16:39:45 +0200
Message-ID: <20250701144017.43487-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 include/system/accel-ops.h |  8 ++++++++
 include/system/hw_accel.h  | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 106ff56d880..6f9aebbee8f 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -45,6 +45,14 @@ struct AccelOpsClass {
 
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
+    /**
+     * synchronize_state:
+     * synchronize_pre_loadvm:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers from the hardware accelerator
+     * (the hardware accelerator is the reference).
+     */
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 380e9e640b6..574c9738408 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -17,9 +17,18 @@
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
+/**
+ * cpu_synchronize_state:
+ * cpu_synchronize_pre_loadvm:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers from the hardware accelerator
+ * (the hardware accelerator is the reference).
+ */
 void cpu_synchronize_state(CPUState *cpu);
-void cpu_synchronize_post_reset(CPUState *cpu);
-void cpu_synchronize_post_init(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


