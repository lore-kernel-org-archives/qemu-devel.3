Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F17ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBt-0004Xn-BF; Mon, 09 Sep 2024 13:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBo-0004Fh-QT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBm-00061F-1U
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-205909af9b5so35747515ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902913; x=1726507713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6Arbealq7Du7diM22GihreKOWvo4phbCNo2pJpa0rw=;
 b=PkLPutRMFk0MuN6tqpXDZOpgVePGUae1ML6g/1KNrF5uGG77KFJqGbgyTKYgEv47Oi
 iNBIUTVz++1BlTn0Q1q5Mn/ETdc6MgHvteT8+gpQvtRV5dFhEyS2YGzYjv98wZSkn9Zf
 VTkIj16jwBme8Hy0JPxdbSfAfkv+WMMpJtsQ0jvikhJcwWXk0qnz6CoaK1ff30Xt0tDO
 APwsn4ZChZr1vB6hD1/ZVk4BegPRS3APqJ67LHsuprAEu4IkmmsNSHGBAP1/WvGbJY+s
 6zo2voZnrVKt0PRbwHsAZLsM9Ek1HmqyIyCs5q2Zt+cUHkIdgaIYwlqdqiUVMAt7AbOu
 jKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902913; x=1726507713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6Arbealq7Du7diM22GihreKOWvo4phbCNo2pJpa0rw=;
 b=B2XQPtSRagH3uA+45mEHZf4hM29SNYT0navehcPs6c863kSxG2b2SnTjaE//wQQ16W
 CEn4QF11BD3inPbJctR5yjqM86cBq9YT9LAnzm0YscS2wsrO0sZSBdWgMOz8bV3TuTt6
 +nBs7OWYec2zzbvgLcQmNFI88VJcWBWBDzFywjR+h1Eeol5ba0OmHhuMbScX+mV4CIkj
 WK9qlp28KOp+h6IYLQNZ631svyu3bdg1SFF2Cu8Co3EtcFmkgpjDz8Ara7q1tZCmx8FK
 bTrp3nZjYAnhoiubc59J/P4l9r2O2QCjtz4pUoTrWV9zHUd93tR6v1spPiwNymqItXIc
 xx9w==
X-Gm-Message-State: AOJu0YwuBuVcObGLnbNW7tB3S3sCz0fbsqRIMRhFK0vigCoxO/nO5M2h
 fdxb1EhEpC+rGSygfR4WzKlRu9rfsrihxArhE7GJ9soqZK9OwWtfXX54PRTEYYhI7Yu2zhdnBEd
 D
X-Google-Smtp-Source: AGHT+IE0oJrS+9pPaR9g9kS7dPxzEkM1obD2x8iiHhXJh0ZQHKu8LfcvKL4wel8T91GaEJ+7gvq+vg==
X-Received: by 2002:a17:902:f68b:b0:1fb:62e8:ae98 with SMTP id
 d9443c01a7336-206f04a10dbmr159117575ad.3.1725902912704; 
 Mon, 09 Sep 2024 10:28:32 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/26] target/m68k: Introduce
 M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Mon,  9 Sep 2024 10:28:05 -0700
Message-ID: <20240909172823.649837-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Set for 68020 and 68030, but does nothing so far.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h | 2 ++
 target/m68k/cpu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 389cd1f364..b40c5b64fe 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -572,6 +572,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* FPU supports packed decimal real format */
+    M68K_FEATURE_FPU_PACKED_DECIMAL,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 8c28db2e95..188afc57f8 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -182,6 +182,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
 }
 
 /*
@@ -224,6 +225,7 @@ static void m68040_cpu_initfn(Object *obj)
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
+    m68k_unset_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
-- 
2.43.0


