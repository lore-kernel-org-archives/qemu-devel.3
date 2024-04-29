Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A269C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NAh-0004hw-Ce; Mon, 29 Apr 2024 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAc-0004gC-4H
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAZ-0003GE-M1
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa83so27531255e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714382365; x=1714987165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ8b4g3seUv7uUos7FZr6jyaqNHB6m9TX8jMWGCsuNE=;
 b=FNQ95OdFfTAXdH5K6I9wEYq0BnF760LxmRuRZ6jgqAcVUa3DE0B5Ya4C5+XTWRmtDH
 qcXcIdiCMFDN3hUcM+/vqXF2EI5NMcNgYsZeQA0BJ8/2CNn9yDJcAe3thgR0YvrcE3iZ
 EcO6Ua2hjQVvsrHYIkiI/hivCjWix7vcluAFMvb6sq2MYHpCUQJBRhsr8PRI60z0Qo3B
 jdkjZAGdwliS/asbrAfp040V6385ycAZ6Bc/9dJh/RbzHRgsUu6Jwt1jY+Z6ndTgydEy
 4qz1ii6hU+SFiHRmmRFuksSoGrZbTS298g42t1Cd3ltjmPTfHOb0LOnI8CI7h/NuLcE3
 DJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714382365; x=1714987165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJ8b4g3seUv7uUos7FZr6jyaqNHB6m9TX8jMWGCsuNE=;
 b=wMEVB/h4Hgc4mF4XXPLjGIOc8dER4OelC4zK/0R0oaDF3OkwgHnneloF5eT/CEZ5Mv
 Y+JcX0x/IJuxMwJOeOMqLiHbsjhU4cojON52l5RRCk6mq6FhnR/nYNeZBnsX8sv3wv67
 1meUgGVemT5cKSllj5Kk/wG2ga4YPLPR2wVKgACCEMwwzQN0/rbpKbSRkJSGQRXhV583
 g4wJFfV/JGfzKsg/7MhIMca+AVwwlfiy6NTrde2J/ZKxGOOVupvgRdSW5yk+rGwy9C+K
 B2d2hrgGGof2RB39hlSg2tIQ46dEKBghSoRBMQPKHsAZ9tPcPPNGwaRgWvIuMPBPlKmv
 aEdw==
X-Gm-Message-State: AOJu0YxvRonalDLzYeGx2QBsjXJx+Tc5NxszXNMTwdB85AVhVWvLRqoJ
 7BjGP0TEaP/gCEVwYxHuzSo9nOiw9graKC9yMxknB0VfjRKOKxY0HC1s7r9hg/PPO2oOVV/wLi+
 4/4s=
X-Google-Smtp-Source: AGHT+IFFgmVwa9R394PE9ymyzBL0/XnUUIHyf2GyjgwZwiCVYioICxIHHMtzbWjWPxPEq5kJFbJQFg==
X-Received: by 2002:a05:600c:46cf:b0:41c:5eb:4f8f with SMTP id
 q15-20020a05600c46cf00b0041c05eb4f8fmr3651849wmo.15.1714382365250; 
 Mon, 29 Apr 2024 02:19:25 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 fl23-20020a05600c0b9700b0041bc41287cesm9312838wmb.16.2024.04.29.02.19.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 02:19:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] accel/whpx: Fix NULL dereference in whpx_init_vcpu()
Date: Mon, 29 Apr 2024 11:19:17 +0200
Message-ID: <20240429091918.27429-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429091918.27429-1-philmd@linaro.org>
References: <20240429091918.27429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

When mechanically moving the @dirty field to AccelCPUState
in commit 9ad49538c7, we neglected cpu->accel is still NULL
when we want to dereference it.

Fixes: 9ad49538c7 ("accel/whpx: Use accel-specific per-vcpu @dirty field")
Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Suggested-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b08e644517..a6674a826d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2236,7 +2236,7 @@ int whpx_init_vcpu(CPUState *cpu)
     }
 
     vcpu->interruptable = true;
-    cpu->accel->dirty = true;
+    vcpu->dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.41.0


