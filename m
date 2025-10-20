Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5D4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnJ7-0001tw-Ms; Mon, 20 Oct 2025 06:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnI6-0000lp-Mz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnI4-0000GU-Mj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so33457705e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956737; x=1761561537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qI+hF79G3saS4cJM9gBn0qvW7x/aK3K4EItDfXm9eIU=;
 b=nr621hplieuOYnv9ySTfae4yw73s1+XQi5hmYq7Tdq8uXpztfGawEVM/e0nBVTFZQZ
 9ehm3vVXbGAtU2RJrH6wGVnPU/p7/PTmSkqXW4o915dqCYeF41fId2nkUUwllKrWNCiE
 sfYT5m4BQ4+dDiHwmQ20qr6YcdZf8SnBHYODaSQZRMJpddfN9sAB+clVvPxFIYGYmg+I
 b+E/YDTSx/p46tzC/k/tumoqN4Y7UnQhZ5tNRKSkUwLrRw+Fmf/v7a0Kq1QNpWd3y35s
 7UQgqDs3hxVGR9BqVTtmKK9FIyGtsyFa1Kt+G2Qh2B4PDH0bTN62ZNMXVLdP5vcV8uZC
 F0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956737; x=1761561537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qI+hF79G3saS4cJM9gBn0qvW7x/aK3K4EItDfXm9eIU=;
 b=wKOGGkfGVyEqQadNOaOAdwqUpO4Ef9hJvAe7+8zB8AIj+jYiGVWn4AWXSkzEZvZFCd
 msN2Sr0o9+uWsbXKHkAKzrv074/5xViDiPnXyxOH1g1R/+fxFUs7lJhwjfwEv/eCepi6
 YSt6NIgX1aeHc+n4FXrsnN7vaatoUvvcM/ttLcBAxm2X+hKrmm+GR/qK+8a2Bdzzzb22
 PG+F1OJq1hDXRYSPvlTpl3odX6e7ZnVobROCr8rDYQne/EhfhmSRNFj/of8tp1BhicTJ
 WS793kG682LLvjN4aNSXIgCQrnHI4bHSYXJmaGPRY+eeEQmP4/lUvMd3rn4XXyCIMIMV
 WkHA==
X-Gm-Message-State: AOJu0Yxb6lqqBusboSTniczGYB+T14YQRZ9WXryYL6OKuzZRE4bdXeK7
 kKTl8X6SxdQqjSCfYDbsbjXEkda8xxlf1oheKHjVslzBL5rnQGLh6TD6ULul6zsRxU0Q6dpQitk
 jyJgKvzE=
X-Gm-Gg: ASbGncul29XTj+wHi53LbqhjMOr2YxGRUn6JujQ7d2z8Mr4frx4TlLsB4Tsvn3qoZvR
 RfnIip2lmx3jwI9Gnt4qjebLZCFyfmJiV6o6oCzwPBzr9tf/TFdONp93vB3jf5zB5Cm1aq/4IMv
 XJ/e0PaAQpz0w4rlrKIYTa/Hca727j9y1rkWUxUwbFZSz3cvM5gATagVLjh5wEjJmdXMecSWVbX
 iVn28h9D/EQjfDKOr3/7nsfjQ6DIGUQ8ulBlIhVPUe+tNwl4cwrtlUEfwcZP5rLal7CK5JMLxyr
 7gkHvHQL6xWmkSWmQxqmrSHB0+mP0NXrXW4gTApKgkdXl5WHqKCyMoPGGuoTFgAfBy4z0Cvl3Vj
 mNiLQiPUsGeOl+cuoiPvtBcfgk+ZD+EHSVqpra0tBy+YZC/61oZrURLXHJcMI1nm/LbQTZ9bNzb
 Rr4TYSBbLgPeK1Ff+pDneGEoU+GDmODl7TXr2FeD9atZQsq0cJYw==
X-Google-Smtp-Source: AGHT+IGkiVeRk8iHXbbwarjONT3Tc41KOvva+qopWq1+Dk4GjlVt2+f7Q0Q/jxdpBNdogpqMLN5a2w==
X-Received: by 2002:adf:a30a:0:b0:427:537:39e0 with SMTP id
 ffacd0b85a97d-42705373ac1mr6211391f8f.14.1760956736641; 
 Mon, 20 Oct 2025 03:38:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715257d972sm141722655e9.1.2025.10.20.03.38.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/18] target/ppc/kvm: Remove kvmppc_get_host_model() as unused
Date: Mon, 20 Oct 2025 12:38:04 +0200
Message-ID: <20251020103815.78415-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 target/ppc/kvm_ppc.h | 6 ------
 target/ppc/kvm.c     | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f24cc4de3c2..742881231e1 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -21,7 +21,6 @@
 
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
-bool kvmppc_get_host_model(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
 int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -128,11 +127,6 @@ static inline uint32_t kvmppc_get_tbfreq(void)
     return 0;
 }
 
-static inline bool kvmppc_get_host_model(char **buf)
-{
-    return false;
-}
-
 static inline uint64_t kvmppc_get_clockfreq(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb61e99f9d4..43124bf1c78 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,11 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
     return cached_tbfreq;
 }
 
-bool kvmppc_get_host_model(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
-}
-
 /* Try to find a device tree node for a CPU with clock-frequency property */
 static int kvmppc_find_cpu_dt(char *buf, int buf_len)
 {
-- 
2.51.0


