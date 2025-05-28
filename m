Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A27BC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBz4-0003j3-Cc; Wed, 28 May 2025 04:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwP-0008Nw-Fe
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0005KD-T5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso2795758f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420089; x=1749024889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fr966vAOTgkrG/VVtr6nBXhAc4LBlzm/ej5sJCBkj0Y=;
 b=KkW0aW6eyuFpxwGUiIeZSupkW1BDHnIcRwf6evrS3ajXzyeBDz243wdsgvhN07pHQC
 tBZ29sBnhpmSwGVtKs+S3B6V6lebDDNGtbgWt6sfQ9R+so+83Wm+wMhrve5LYFc5YJeu
 FclfLEltmtOXMKFFOeGQJSJeJAG+rpfHu23urjT2R2unVMCdu0ExVNfqdJ2CrFwlAA55
 nX4B4HKGxx4d9mr4lxpkou/m5eKm7YIoTTBpgHEW+dcUYKZZ4BbmvZJ7AnWtIraPr5ze
 aucefHMFUnb+WycER5AqWU4atDA+3SUDABV9/Ev1DNnkTMO1IUm8E2Nka6a8Ue1dkNhe
 4gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420089; x=1749024889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr966vAOTgkrG/VVtr6nBXhAc4LBlzm/ej5sJCBkj0Y=;
 b=Y1+d7DmbhkM7bFglC+m4pNY8TmhjeHoHv3R2czePkOJ/OfSuopEdscgoCfolCYPZVO
 LgZtjn99IXhiu4VgKbjyp/gXDNbCxiE+2i2bqMFEBf0PCoBX57G0h5MGe2A+vxumbRkW
 9wyI0f1MvkZOhwChWGhLfV+Ndq7S7+pWbVS1siMuLSmrKDFMXb35E09I+//QSEuYXKPl
 LZRyI5ZpExF6gXQh5ZEZz1r0jU7Xf3xiUjUO+HNk3+e2QoGA7ZwFl+dwFvisJoT5Je0S
 K0BWaY/ApVUrJn2mmhoiGsOU0T/mA19FIv36/k9uu/JtP/GqxYtvWNe3bwmocVuRXTdx
 9PFA==
X-Gm-Message-State: AOJu0YxYs3xaLSJROer6hih+UCz1nFqkMdAhHOfu4pu2tsPZyXIpQswS
 /D5L4YMVRD2mAQbapKU7djLwXssK8rq2DMuCUJtnqHpHUAzJp9qceyu4I3Nyjd9+aFi1P9KnmrG
 uLXadJwWLAA==
X-Gm-Gg: ASbGncv9aKKVwcD52oj3dZjb503NL+fNAPUE1VOX10FxgCNKEIlqe1oZ3lz6RPoVHoW
 MJ2Sd//GyxAl1YciRcY2T8RBcuIYRwoUxTwl2OOr9JDJkF3pysNTv1ZAjN3bjHilbl+znanBvGa
 FwONsjmNsq8gL+qdWS5UxUZlnGyMZVUJnwm+KhycU5Tve6wDm4HfHQPGy857/pBJaQbmT0MPvM+
 SZEx0AKsZRRS72aCL2MGBqrsJuWDgqc3uyjhs1aOTUWLnXfwU44KwPe5R0/0CTH83mEMniHLnmS
 7/JQrOU513MEQ7b/FAhs2n8QI0aJb0j7Yvy/Mntp6TKZxvykfyHNvT4+6vpzOVMnBx8=
X-Google-Smtp-Source: AGHT+IEuTyn2+fXTBGCxuvwwAOWxE4DYoe2fogb3vfEAv3yw/yjUw4qJtb3zZYGOImc+l4CQOoMvDg==
X-Received: by 2002:a5d:5f42:0:b0:3a4:da29:d14e with SMTP id
 ffacd0b85a97d-3a4da29d2e1mr8581626f8f.28.1748420088802; 
 Wed, 28 May 2025 01:14:48 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/28] target/s390x: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:08 +0100
Message-ID: <20250528081410.157251-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the existing wrap_address function.

Cc: qemu-s390x@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9c1158ebcc..f05ce317da 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -347,6 +347,14 @@ static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
     };
 }
 
+#ifndef CONFIG_USER_ONLY
+static vaddr s390_pointer_wrap(CPUState *cs, int mmu_idx,
+                               vaddr result, vaddr base)
+{
+    return wrap_address(cpu_env(cs), result);
+}
+#endif
+
 static const TCGCPUOps s390_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
@@ -367,6 +375,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .record_sigbus = s390_cpu_record_sigbus,
 #else
     .tlb_fill = s390_cpu_tlb_fill,
+    .pointer_wrap = s390_pointer_wrap,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


