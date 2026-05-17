Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E26CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPH-0007Vl-G7; Sat, 16 May 2026 20:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOi-0007DT-5d
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:31 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOb-0004xX-5y
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83945063f70so1038088b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977815; x=1779582615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CH8sn0raFot2c6HYSuCv/vuUo7CdYLWHtN+GrqCIxQ=;
 b=uy014aMwhKRPk/HxYOkbD+aJEbXJG1e5oUvQ2oVFG4jdWDEp9WuqKCJSV3zmqzkRso
 aij0igU9wkKozuJHJMuvkYQjxx7fty3jpDTpMZ4Mlumj/5QFn3TH5nuxQAoXCR3ApjMZ
 1ZMWWbify8xrlUL5mryvLe/4XQKzfXPUz/mPttra6aR1WVqbNcNviXbObTjO8G+FpOwv
 zeI5twh5bJEbyx5JPFcuiQIwsoK3JTAupq1o4I6xW97gq+6CgbGQDTIqOvV36TGhqtF/
 pgsSKfvEDE2vZsueOXX2qIAPF0xYg6z2TZzznvQHTfR8SiutDWyZdqQGEsmkxEUAqnUH
 qT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977815; x=1779582615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CH8sn0raFot2c6HYSuCv/vuUo7CdYLWHtN+GrqCIxQ=;
 b=r6ICr4NN2RPnbLmviMITyRiIA/ycde19AsH270HVxUGa0b4V6xaO6kVkUfQBgu62EP
 beyxtSYoElSuy1Bq++wBECkMF9/xa6wd9wwnsDbL1hRUjLwgvojO6UDLBXt6TOCqOYR4
 hCmenPF5a3gTdob5rGadfRCUliZWB2BqU/dnaQGj/8t/l1wikq5f4CoZBvCozkTkDHFg
 0bTcLvMxRAPVHFLuP91n1GTbUsjBYlpS7DFJW3QrYb0natXCac/BCuw/eKIKCwlXgdy9
 Z+2KgDy5EjhLK/nICbWePCflDka+s70kSiLaa7ytqOYzHPClXsZ1JXePgynt6sCKS7R9
 Gksg==
X-Gm-Message-State: AOJu0Yxw2eXRKS3xROQOJ5ZskSZ0NMDyo7miDhY3IIoM46gFHfxIMglP
 wlTO1ik6/d9rKGfkv/7GtMQNLblEZjplweUMpkzkIShkEhYPI4w/UpSeWa4LV4qYf7lg1NbEwOl
 8bnOJ
X-Gm-Gg: Acq92OGUnZg1ZfasJmSdAcSVI71OC4OWa9tGPHhYY/II0cOUJbEZT1H6HiQz65tgSgz
 yRezwQyH+wL+72iXJSelzJwKxt1JZn1rjZhmiAaGK+CRFjcfK1CwAxSvQAWl8gkquK/dHFTxN3y
 0SIbyUa/NRXSKQgTF9uf9G/XXlACUNHy18S7IbI788+hw484wwmiolEzPJRWgTfNlk6/2t/fnhh
 CepfboEu+eGriWPnnJBx7sELkg/ZWL/xkzuAJSVdoGJyS/Whp9EDhso7khdH4Kqqw1NzprjJMOQ
 oQrD91YxfVHqxhiUgcdPUJGKljeQV1jqylb8rzHnRFv1AXcJh1Oj9wV+rl+JHh8Ms0jR+efFVHI
 zslTR7M8DMIHCyAQrIeeJe519dSSwBxj6BJrQxhg4IVmKz9Ef36Aw0cfbIM7KLm4Reivgwfvn3f
 Kb9kBncx/wjuXVVrVFmk0XoJZZsww0yxbxx3EWheg=
X-Received: by 2002:a05:6a00:14c4:b0:82a:146d:36a3 with SMTP id
 d2e1a72fcca58-83f33c9570fmr7885654b3a.21.1778977815132; 
 Sat, 16 May 2026 17:30:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 12/63] target/arm: Clear FPMR on ResetSVEState
Date: Sat, 16 May 2026 17:29:11 -0700
Message-ID: <20260517003002.321430-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

FPMR is cleared when entering or exiting Streaming Mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7eb7031294..3d6e7f1ccc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4856,6 +4856,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0


