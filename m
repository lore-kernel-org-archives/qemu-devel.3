Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B522C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSh-0007Pf-Ua; Fri, 04 Jul 2025 06:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSe-0007Am-6t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSY-0006rn-05
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so325651f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624155; x=1752228955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DHgtj6RnlNfzvgIpTQEpgIYEYW1t3P49hcW2EZzF7SM=;
 b=azg+bDI3ht9DWYNGe2XFlE1gfttU0S5Sr977BejvAq1THbXSIgyd4b/QvQnrMt2qDt
 l7WV66WUoDdPEHvayZHlP9dTNyXh5mwLiCREdkUnZD4wR5ku8mwRyO9nvgjPCK91XrkD
 H26OZAcfQhYeYOoqTWoXOfyrQd+O2vGEU9OgktDg4E/vbYNBfh021SvLzxqXFuassst8
 V4aTf84Xv+yf+1aM6HmeQKzxHCAX7PqsCagdYKKkRP46/PmOtpMNlwzK0UuqYvcbdshQ
 E/2w0R4hrKJymLjq4Sc72Vlpz6m12Mul2J55tNvn6d/Bjh7zZhOfQLX8Ij/7ZXOkfMvw
 a1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624155; x=1752228955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHgtj6RnlNfzvgIpTQEpgIYEYW1t3P49hcW2EZzF7SM=;
 b=ih2L/WYo+APfkhgqIdLRhv742TK2AOfEUXMJn5VaNqlhUPcNd48KMmKlG5VNsiWf/9
 X0XbFCa5PhTRPqoQEWpHORWP09HXEey0HjZhwXbOIBne8Y/TBmCTyM65pe9bcgQmu1OR
 FL4oNt/U8NxnQ49xAZkTEd+8Gb1dYtn8ZGrsl9T2AzO3tX6KuFONsCdrUwSVjf2WY4HH
 /0WrGPbDmSdrhyrdLau7qx/JYQh8nS9nEYHCD/ZKcbWCai2mfgn+SsDEkk1nuwAueflU
 hPsrR66Gd7Yz8fMN4/Yxs9BA4wg3cKCTAyYnbQ4x3fmp9w4lONaaaxsVglHElgO1N3rN
 vg7g==
X-Gm-Message-State: AOJu0Yy61G4LQ1ajFnKcEciQICZ8NhtCahcOQFRzD7xjpCP6nuGjEwjP
 JtR6LnXw+M+708lJnNsOFm7C4N7zKlzG2eys/xplmTOwp7iDzEfcqO4yMMF+tF6dThf5/A3+tOK
 1945PARA=
X-Gm-Gg: ASbGnctf6aHFX/TOmZnNi64Qbq6Gb/FtuiJ7wWFTd4OOI8jnR8SWYgsDcgNaCZ6HULs
 G60OJXn4KxXYC6PsV1DA7lgs7/VH89d1Ct0MDLFfTnYNU07+RikqX93qsvMNED+jdBO/vREpznH
 dXK5ySBmlk21s2U5DlBe/e2UhCCnhsZm5+TLlGVIDST2Io10DjqAHkX2Naje2/8h9q3pYbLoPjT
 1dKD2JZUBnQxjXgFf5PoqExH4U6vSHGXra6ak15esasAVSAnUjIHaZZWbOIm2W1G3SWnqlbdJQd
 xaTMpvh5EZi9sNy5QUzhV7emXKxYPjrtKQNQSRx90JyDK5AVvXQBHCX7IkzcS1DpHn1xh0GDLwS
 LNsMs9JA6Na+x6bBSDxJIvjw3OvtT/64zwpHSqluT0qCNcCg=
X-Google-Smtp-Source: AGHT+IEaNnX+oIdu/VkZGU35Zogc/geR0mUa6T6yx5sAQqFiI6/BgfPPo+rrsD6g3OkXg/7z6+rm2w==
X-Received: by 2002:a5d:64e7:0:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3b4964ee263mr1564110f8f.58.1751624154613; 
 Fri, 04 Jul 2025 03:15:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0941sm2089446f8f.26.2025.07.04.03.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/31] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Fri,  4 Jul 2025 12:14:18 +0200
Message-ID: <20250704101433.8813-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Message-Id: <20250703173248.44995-24-philmd@linaro.org>
---
 include/system/accel-ops.h | 8 ++++++++
 include/system/hw_accel.h  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 55f91cea25d..a4e706b49c9 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -40,6 +40,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..fa9228d5d2d 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,6 +28,14 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
-- 
2.49.0


