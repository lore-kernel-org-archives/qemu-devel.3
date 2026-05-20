Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AB9CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZQ-00087L-SN; Wed, 20 May 2026 14:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ9-0007L4-A2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYv-0000ap-Qv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:45 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-369576666d5so2436203a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301351; x=1779906151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4z/S8c2O3c8fRzj3kByIQacIL6SNCt5eRr0Q+G3fOlQ=;
 b=TTGrAftuxBevc332izlKx3CwYWZr7pQz/kHg8OtXWgi+TaH/phj9FeAHJuzTGkzOZY
 6wfeCZnJpmjlXPC309en+J8IVKvHjUK/NFfavXBZT+kNHh9o7HO09bKJ+J3APRUDbL1i
 ax70t3b2MDFrHEKjpb35GtU4F2z7nH4CNCiEbxm57dzskQ2EN9pspT/y1XL4BDnRP+4r
 lNJ4x3J2hzsDhmTDmgM3siUF3UzySeYpoYaQLnJHruSIMOdH9a5OLkMnQfj1MHObj3sc
 tIbuU/tuzDfeyR4DDNPeLTZtA5E5gG0hLUqieNx5oscQ31upiuLLS0Na0Zb+/qyWyQob
 TjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301351; x=1779906151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4z/S8c2O3c8fRzj3kByIQacIL6SNCt5eRr0Q+G3fOlQ=;
 b=TZXCW15ZKZ0sD4dxY9wtFJ+0VydqMzqD6XbQL2PZ8VTdvnDlFsJMhlzNS/24zZB5NZ
 IyXysOXdG+TorpFyzYDmEz5bVohCLMw6XXr97qPLtMVNom2CfUfBfoLcMxAnnvcFLOFO
 KLEdb10j9aJyxCd0lsLNmlHTkv7sT/5dHFLT96AIBSO+5NZYiTYyGBBGNvS70QVjlNre
 RfGyg3DFwR2vinyaTuT3Xd2Vd7oYChQdNQV5w4NBixlE5ZpiuXhG1VxfnkgH5S2RlpVh
 jtqy6F6Rs7UMweX9nRBi9Phuo+uADhynJu3whQC1+IJnx5el/xpu59qPdKsa7+1DcNcR
 0csQ==
X-Gm-Message-State: AOJu0Yz1YR/XomndfRYJcKQdVFkN6T6NRsIMlYaBEM+YjO3LzBovz2XB
 jxxtHGgzFgv5UlT7z6KSbg0ooNRv9if54eGFKKi0Wo7cZ3AVD0VyH0o7ce7+HcvNR0ibpoxWsBc
 SNpNaMWQ=
X-Gm-Gg: Acq92OGSgXezMx8AJMvkpvftat7SIXTGmBH2v94v+cAY2B4xF4Suv+LQpu7jAP1b36Q
 oAtnfUR0NMboyRr+t0kJ1NOL4/E47ONJAG9Qb8Y5Uc4as1XzVvedAuaj7anIbs2vVuLX4tIQCYA
 3FDy7WXiLtlYtIMce4a2qPJpGch5fdk7aZqEgd9NWIeE1H9xs9oK6jZFb3FRXTmqrHeev5FINz4
 CE8HCrgcg4F/e41ODhUzsWPLlC+xfGLPxwqiEjqTOb5WeORoLUC/qMuvvhSaaXme3DdM0hjMWHZ
 eEV5I8zg0xj1ly3fMgX4gOt6k0Eo7299xSgluAjuhUjSh16qpTOWjpdVejitSq0QO4ou4olmzxM
 5vJb6JE1uHahziDz5rbpDoKMaaJJEyHVZYh0eF5iqev7N3LNIY5jjo3VCAeb6CXVQzTDYvigUAR
 e85Mj5o2xDiA/LBB6DS7GdCsgubSuVRzP1Nan8IKk=
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-369519ffc97mr24984372a91.9.1779301350706; 
 Wed, 20 May 2026 11:22:30 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 23/64] target/arm: Set e4m3_nan_is_snan
Date: Wed, 20 May 2026 11:21:32 -0700
Message-ID: <20260520182213.872945-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

The unique e4m3 nan encoding is SNaN for Arm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vfp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 8d3f6e3a2e..c10b085f08 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -46,6 +46,7 @@ void arm_set_default_fp_behaviours(float_status *s)
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
     set_float_default_nan_pattern(0b01000000, s);
+    set_float_e4m3_nan_is_snan(true, s);
 }
 
 /*
@@ -67,6 +68,7 @@ void arm_set_ah_fp_behaviours(float_status *s)
     set_float_infzeronan_rule(float_infzeronan_dnan_never |
                               float_infzeronan_suppress_invalid, s);
     set_float_default_nan_pattern(0b11000000, s);
+    set_float_e4m3_nan_is_snan(true, s);
 }
 
 /* Convert host exception flags to vfp form.  */
-- 
2.43.0


