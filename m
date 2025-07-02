Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039A2C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2f9-0002yO-Vw; Wed, 02 Jul 2025 14:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2er-0002a9-9R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2el-0002ld-2K
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so43544145e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482683; x=1752087483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZapE+BsIWKP1uR9SD9UqThOOP5DO0oP7K7FrxAXgmYg=;
 b=p155/E+FLZ2U1ujpCLgmrcF3fIs6Wf/AHyuPzNee1rbzlHapycxfq5RhNg5R+jCHri
 X6R8rJOZFtE8NBWxjPNMvKCJjjAtFrN80EwGGrEW4cJk7aVNFSzehcqqH1uY+k565Ymw
 5W9apLUQGR1t+Cyd4d0MTicyWlA2Y1fKw3IDIi8CHc/v6N1AaKf6CBgGlgj69Fdi8Zct
 LmyoBol1MM/7SnxTt2n/sme5GDoI8P0T5VhzD/ZP8Y+SmGIBkSeHo7FdnT6AkF9CI3Wu
 z3ElVOeM0tTJAfLjiAetsZuL/xRi9NDpjiEiOI13ULpxH75lhClDzaTC1nSEWAe7sBmp
 J+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482683; x=1752087483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZapE+BsIWKP1uR9SD9UqThOOP5DO0oP7K7FrxAXgmYg=;
 b=D5frHn2f0Ef5+LVk2/Z/208W5HRMu7O2PxXkoXs6NqeYjsWQWMtWApF3W4sMboGLQb
 lxRG5yALUcqHvA1mqZU3CNKTFg+q6/DorQ/i9M/EoQxAGnygXcGR/lfABDLxCliRj7fs
 JpyIaOcnJAWjrIN029BNthBezpS7PL+8G/xOpamsSopaosZplwGFOvS3me+U5JVBu9LH
 +RO+1LW381capdxZN55TFdZEwop2rkNcnuZsBUl1mLwmTExwvQ9ECkSTi/HUdXsJ0U7W
 +/A7GNvveFCIyQl/aRCK7zaGKpZxkIdxCvCklFnFn/8TlL6+rIbAnl1ulXd4sBuZ5+I1
 aNGA==
X-Gm-Message-State: AOJu0Yx/ers48dSHH607xPU2WHYoRoasgQXgnn//GWh3wMZCTTLod0dd
 GvrTfjRibORCcp9Tn27q/jHDW+HdYwBJK0bHI9Wy5cROnH0uN0Vp1KRSxWv45edcGTnKTM1GsfR
 xoxGL
X-Gm-Gg: ASbGnctubP6sq1URaRXZnpcGRZwKTeq8bQH+KosXEwpV71PgyWdr5D07w9fQYfCbnnK
 1oKh2prEw3SK8i5FT0+vJsGtZYetuufZiB1gePsh4rlDyClWF+qOSj7nTep2ZnlDWYTt/MYgmXF
 4smu81A344zliqsYlXa4jyYDW7r+KwyiljNTO0gVwCazVsGqySJymUdSERvL4zsRIQkOdueMeZN
 sdG33uF/8bA95D56ZVkIuiattwQDw6y+6fJ27Lz2aajsGGSI3bp5udwyfpwOLhw4sntYgEiZFcS
 p0sdCnw0dm+0Qf2I85recvv8p6HVUR1MWeQRj0JzonUKdZlYBt7mqrdK+hox7c10/fkK9LNlebl
 ma7aJzw/ACHOk8I/MSxQfQFJZrFha6/ANQZ/J
X-Google-Smtp-Source: AGHT+IGq//4zguArg/D85BhZUqn72m5MpoHcLlwFP20LxyFkrGfC/Pzh7vI5dY70Y2Zm8t0YEwlQXQ==
X-Received: by 2002:a05:600c:1c90:b0:441:ac58:ead5 with SMTP id
 5b1f17b1804b1-454a3736717mr42956465e9.31.1751482683511; 
 Wed, 02 Jul 2025 11:58:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac48esm5465455e9.37.2025.07.02.11.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 37/65] accel/system: Document cpu_synchronize_state()
Date: Wed,  2 Jul 2025 20:52:59 +0200
Message-ID: <20250702185332.43650-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index 2a89641aa81..ac0283cffba 100644
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


