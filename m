Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E583CF537D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua3-0001Eh-BJ; Thu, 24 Oct 2024 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZo-0001AG-BQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:20 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZm-0003pc-Bg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:19 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso104950366b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763777; x=1730368577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhyVCt5uiJi85ejZ/liwkfrDbqe1iEIJ3VaYNksmEf8=;
 b=KGCauwgxMeLcAMQpET/y7GQ3CRSX460Fykcw8GA6Ssl0eeTVh9ZZfj6Drwlqv8Wtjf
 yUz+Cp/jlxvFWtoMQ6PKL/kx158T6I/s5DwZHLQnYN/cDCLRCk59IVxpORtlvO6W7zJw
 Bmf7/4sKDV1XnFiACOSN1XGUwW6uc/j3SQvDzPwaIdoKvCvWSz6TntQcU8VPdkpgbCj1
 dv2pVVzZDHkRuHaqaZPwPEgUxHwcoSdyYOVlXHXtTKZL3DRoFfO97ZkrDp78CoJNRMjZ
 yT0leupqxhICUNWUqTtRMKVgofoD+UgBA015tuJ2LnruubSjJxUVc8ShcSmmFXZoAfYL
 EPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763777; x=1730368577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhyVCt5uiJi85ejZ/liwkfrDbqe1iEIJ3VaYNksmEf8=;
 b=CkHT/8rVP6ihXnwCHowj/M8FC8Qpi32BuRIRmjaHQflwtyoesut1VX+r3jB6w58Twc
 aN42XS2CP4S/vKqjAvddLngJu/Vj8yvxOqNE24wOn3ww6gAdU0F2qaFwAkSXJU8EO1vP
 3ncdNq+46h1hL4D7MDkO2r5NniCG/KzUZpHsKZlmYf+pJvxKgYO7bBLf2hP79YPdtDXQ
 vrl0rBamdkK25R+8801Tv9Y4mHsg2QrJ5V0b+qNe5zRda6SxJvBxLvOm4GBk+AETCSmF
 oJ3kYOiWpL/RgViS8vqt0Nnw0d4Z280KRor6M3PizaIRg5Vp33Tbc/8ulUflmyvyrDCp
 x4WQ==
X-Gm-Message-State: AOJu0YzmzVChnpVN36eAXoXpV8YsdJTgoePnFg+NHSnXlvAdNHz6Vz5Y
 NXQEGHV/F0f92YMduSkd6UOEmHriaw9en2Umed/JNK7D/sz6sJEujhFVbquDKKg=
X-Google-Smtp-Source: AGHT+IGCeuP6tz39a/1oAphVljr37cgXvwnlFyGo7pPmvkn6YhDqvl9o0PqOocbWZE9euzvxzmsvfw==
X-Received: by 2002:a17:906:db02:b0:a9a:f53:a5c6 with SMTP id
 a640c23a62f3a-a9abf96b501mr572318266b.65.1729763776966; 
 Thu, 24 Oct 2024 02:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a913706b2sm592190766b.121.2024.10.24.02.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A0F45FC19;
 Thu, 24 Oct 2024 10:56:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robbin Ehn <rehn@rivosinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/17] plugins: fix qemu_plugin_reset
Date: Thu, 24 Oct 2024 10:56:03 +0100
Message-Id: <20241024095603.1813285-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

34e5e1 refactored the plugin context initialization. After this change,
tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
one plugin at least is active.

When uninstalling the last plugin active, we stopped reinitializing
tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
This results in an error as they don't appear in a plugin op sequence as
expected.

The correct fix is to make sure we reset plugin translation variables
after current block translation ends. This way, we can catch any
potential misuse of those after a given block, in more than fixing the
current bug.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Robbin Ehn <rehn@rivosinc.com>
Message-Id: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
[AJB: trim patch version details from commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-19-alex.bennee@linaro.org>

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2ee4c22bef..0f47bfbb48 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -467,4 +467,8 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 
     /* inject the instrumentation at the appropriate places */
     plugin_gen_inject(ptb);
+
+    /* reset plugin translation state (plugin_tb is reused between blocks) */
+    tcg_ctx->plugin_db = NULL;
+    tcg_ctx->plugin_insn = NULL;
 }
-- 
2.39.5


