Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21632C3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC574-0006K2-Rr; Mon, 05 May 2025 19:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56w-0006Bw-65
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56t-0003X1-0K
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so56056605ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487229; x=1747092029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=riX4BfyviGDNrYMsd2+RDXBekRdeJjJdFN4Q5Qe/iDlIJuL8Lew40oEp7aSca8xcbf
 klcCKwc5gHh79AfcNvNSElDego1mlnWhjjdXxFR9LT5aonH7C/9sHeRKZPFS4GLRX61f
 aWG/LxutTsU/Hpv9q6zi9+r/TXTQcyPGu9M7XlJ2RVt5WTrP5xG+QFKhTq3glEAUIOGo
 JlgP3PCK4dka7s/ZYw43g/ueAF1jTUbsr6uTmcg3qW1qsNLHHbjds0Ng484ncMDvZ8/s
 vS1Bn8oFshVC9FEOMGmbvqVn9Sez40w59G3kpqTEiWsY5HYX6dEQ3gT+hp2TblnlVVG3
 ZbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487229; x=1747092029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=VPnga9hjNgWuqXwuvVgY9ZSPPQW9cfmVtkyPPHvDDytBxuEdSkZsbF0rSYzTAyfA6I
 5pRz8liNH+B97FKRb7BWnPZL7K8MN1YcAZhWN4oOmK60EV0e/sHErt81tQz4flVM+OAq
 pXj2GBK3vtIEcgd35PuhN60XfsoyEP84D3uQRlQx7uNIE988X4OUieDBWez61tD3Xh/R
 mWI0/Z2RBUceXWSRdvjwyuKP4pEk7ZC/dGHnDe0A39c37y9IhiIHNRxeyGKVpe22GY2F
 xHSgf6Oa2D7+tsahoqpGoJ7TV6NZIaqJLiNpefSMm0bLe0nOSrmTPDMi+Rcqkq7hA8zE
 FLcA==
X-Gm-Message-State: AOJu0Yyv8wfOM3Sagg3xhMR+g+LYUOtp3UF3plnFZ7J7U9124yXAsk2R
 skMus2lebLrWtDgBQIHdFb1hSGhjoeVhpE8QyKeoNmnhNCCxoL4HIf9I6Mz6VI0huod40t2nlkE
 NOy4=
X-Gm-Gg: ASbGncuYjQJoDebVFeSUYTBXv2TK57aqA9P3vkxL0AhcLxbBVDbbgEOaSlWmNYngRfw
 qISpzF9JCkJ6xMytgvPg1YJ0ymVqo5j44FIfqjGDb3g2Vwj3USJ/esVmnCCzGRhKyLCgBkFDcFl
 PtSZq2szjWLOZWr6pV7SvF1+w+kauuqOMgbl0j6p/y3aFbXFWwFYchWcePTPr2f9LMzA2vUPklz
 2UAbkWIR71fWWvG8jNQRkt+J1BSOm8tHXbmu85qUgUNuawjKgK+zunDSWW8PniD72k02Z+ROz1Q
 wcHJulIhkZQMAypmFKOlKaL+fNVXJ98r+XEHWUmw
X-Google-Smtp-Source: AGHT+IGafCDnzbl4XsOgKn16x55qDqZR3cRsQY1YC271VQ2ahGmfB+GhbWbfsVVZQQMU78koO3U2SA==
X-Received: by 2002:a17:902:ea0b:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22e32f08e17mr13948765ad.39.1746487229414; 
 Mon, 05 May 2025 16:20:29 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 10/50] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Mon,  5 May 2025 16:19:35 -0700
Message-ID: <20250505232015.130990-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Call is guarded by is_a64(env), so it's safe to expose without needing
to assert anything.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b11e8866f..00ae2778058 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


