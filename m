Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E679CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LJ-000852-9S; Fri, 26 Sep 2025 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LH-00084D-7B
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-00042a-T4
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso2205256f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892671; x=1759497471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4syHx7WycSoo7WnKZYyvkr/pUQB2YZb4jxe+1NDk0fE=;
 b=vvl73zRYwYEDz7/mRsszBkHAzwiJTcfSd0bZU7w9R1y28oDepCz30IMlCWIaMIjSiZ
 QXGcVSQwzvcam0mtpdy4DjPyUbD0v+c4KmalR1Hf2sH3XvZAxVS5w9CjiyGRQ7hKoS8o
 hIn/q63IbQprq1NLY2F4BTjLbZUjW325+rEXwUqShRF1cZOexFrrOqdjHeN0mN1U7gLK
 Ll38fNFbZnRIeL3EQB/AboCzzIeYdW6CsFUBZFubsProJK+6/4n1PnpxhClj3xrInSxD
 FQXRmJAXEHZPt6mjnLEprwIDYknlossmj9Ln9mr4VGTPYw+8qJIJCmG/ASwLTrSgnLH1
 ZlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892671; x=1759497471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4syHx7WycSoo7WnKZYyvkr/pUQB2YZb4jxe+1NDk0fE=;
 b=eG3sQUVux8zeSDgitbDBiYIV4qoB20W/1viUuIZ/oV5yBqYk3H57KkNbNHZ9LYzZsh
 Jw5wOP4SlfFd5BCXbw7i8R1mjRxnFgy1mgh4R6DEgDDZmqBOs/zB1HFEjMRw+gOn/cur
 oIU1zsW2qnEqAIgR3liUMimDUjtlQL+YB5uwVbuyli+Uo4g4aSgSwvAKJ68FUwauCW/j
 ctcqLq3w7wWWnq647ajb4pJl/hfzHV+eo7HMEfuqahObBBtaez9o/w4vpmVAnU3CymBO
 k0Z9zHAgEEIOzLDG7MmyJMBzbk0iGGiF1okjxDCBF6P1wJfLrghPUFVsZIkxZYu8QkEc
 6vsQ==
X-Gm-Message-State: AOJu0YyrmBjiyCii+O7xLBo6Wh+zxn7JP5++8bcDvVN3VmnCMh99y2XV
 Xhs+npnoMHzXnHI1VdEf8xKEO6uinNA4u52Hy8msVpartWZt9pgs30bJ5PbHbkftkZE=
X-Gm-Gg: ASbGncsCUWMreiOTo1XJIJiSpoqLjl4CkykMz7zc5qOxmPB+Yoalkt4tpovWvEuKUtL
 NnNmeG5+lGS0OHEn114via1pnDonrxLQpe/NlW1rWsdtkecRV1JG+5GTmxYxi2Z6wam0G0Yo9pG
 FYQEYs9AqFrpKtebcZuxqnuVSeGy3cOWR4IAKX44TvpV2yXDLgsniDxlruMb2Tvbo3F3tluEc3h
 7aG/Olr3tFHrxcWltRbt9UubbCbGoeiHE16Fh0IqKvI10qWxT6ITQ153wX+D2hNcVmbYCetMXsO
 +2YRFTIqxEAn26lsk1IM3p/08drEYhQI4u6UDkzbiU4vi5oJ0+AsqqukWLZGDYmZ4GHChbNsJLt
 lEgrelq163qsM2dlEemGUi4qm2n6nfs6s8g==
X-Google-Smtp-Source: AGHT+IHIWvDWMEeOnpVGSAMiXZZvEjPIdCvG9uZGsrWeHnNvcf5VGzNOUzxY0gbZMID750/Fusuiqw==
X-Received: by 2002:a05:6000:1887:b0:3dd:8b62:5fe7 with SMTP id
 ffacd0b85a97d-40e4ca79f1bmr5693777f8f.49.1758892671218; 
 Fri, 26 Sep 2025 06:17:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72facf9sm7271074f8f.13.2025.09.26.06.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B8A05F8CC;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 06/24] semihosting/arm-compat-semi: change
 common_semi_sys_exit_extended
Date: Fri, 26 Sep 2025 14:17:25 +0100
Message-ID: <20250926131744.432185-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We now check only is sys_exit is extended.
This allows to break dependency to TARGET_SYS_EXIT_EXTENDED which will
not be available anymore from this code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-8-alex.bennee@linaro.org>

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index da51f2d7f54..7bb442f24ca 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -34,9 +34,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     }
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
+    return is_a64(cpu_env(cs));
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7c8a59e0cc3..ba40e794dcc 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,9 +25,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
+    return sizeof(target_ulong) == 8;
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index a239cfc5a9d..26263a06b7a 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -755,7 +755,8 @@ void do_common_semihosting(CPUState *cs)
     {
         uint32_t ret;
 
-        if (common_semi_sys_exit_extended(cs, nr)) {
+        if (nr == TARGET_SYS_EXIT_EXTENDED ||
+            common_semi_sys_exit_is_extended(cs)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
-- 
2.47.3


