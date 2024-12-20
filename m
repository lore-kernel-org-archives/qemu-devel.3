Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D1DE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfi2-0000uu-Ka; Fri, 20 Dec 2024 11:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhn-0000RK-Hs
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhl-00089b-Up
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361c705434so15608745e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711500; x=1735316300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hV0gRaFv2VBQtuTxUa/ulndjRXYAGisn/eeSilawuU=;
 b=HlZBhiFGne6p1UDwjGk7atGL37dombwgDZ431ib1jla7Q9xQXCAjpAS02nnxlj2WVE
 q7AMmZpWxg6XP7zLvAKHt1+uoaVHOaeWnjkFk3vNOtprCnexZjQOWhTyj8TJfsL4UFTb
 sYLACsMv0WrmLuJCNMxFlaTL2qbQNo8YQETMfj+/wi+ElVArE7W5N9JuDQOYKbK8vYiD
 Fgau+or5b0glghr+SspqYzIJXWM7ZKvdrE/kep4heR9moxZM+SWO43NjsCbNMEaPM0Yt
 eFl2dV8ElCniDWbyhWiM5T0hR7vaGbO0Zi1zL1KwKZcNWk7bt4Yp8MyknxrwJSncLAL9
 WSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711500; x=1735316300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hV0gRaFv2VBQtuTxUa/ulndjRXYAGisn/eeSilawuU=;
 b=Te4e8iay1/JueiHF/2ygmHGjNr4PEXu4oih70uUXvK3S40eRLhT7BcgPm9qBS1n4EG
 qM4ijMy7gSdIn5pexVFUsbgszW1i70/hMRY6LVbvzoF38vKQv3Z8IxQgF4zlFEyR7j3N
 1n7JvjPNH7YUZ3pdHF0kZTBLHTjrqx3PD7H0l1McEw5+whdrQc7IH0Dy+qWQ+5tFHAzZ
 UdmeGPDmKDgx3Ux5mzSJWZ2vFdtAJH0i2o1kf5GKfhK5i7C5LHcxm6Nn9Q0uWGQTqJXu
 ePjUTwDWerMA2eGhZWcrprdJ1o1jYaYd/p306t2o4G5zo+wLRARG1wWLid8mEjWTyp1l
 CPCA==
X-Gm-Message-State: AOJu0YwOV6S7RuYkznZ6QU3NdT96BIag0HxE4/u5RI07rlnn4Fdgc4ai
 KVSQQpAEBf5gii8NTaoTGWBy7GDNG3cTesxX1HnyNvE8+LFOSHbk9un+xx7LQwI04GkwmDYQQ79
 7
X-Gm-Gg: ASbGncuCoOxoec+5Ln0HUb6Mudpq3cN18QQ8+yEFngg3DY0rhdiLN84u1ra5yhRrraG
 32hBn9H9JQ5Dulp/qEekjRyAxXEZ+1/Oto/frEnWjs+kzvHTkmShRyzWeCiZrvvg0D9VlCCpUXc
 t7xYOH8TibphLjsIEVc/0XEMhvc0EhdipabKtzPFhWMHlqTMYODl2lkRlGpYYv4vLri+D/cZ4mU
 gffEUx3FU6HUhCEvAZ/LVnoNlFxef5ZVYKkh8/AXmIC9r1amA8Qzr9VnhkHyt4uxFVhJf6mvxk=
X-Google-Smtp-Source: AGHT+IF8yttbmiTXC1SGiVb+1Ak7qgni2UmrV8zy3v+uJNU37pFjzn+19ZAVgTjJ4hFKBeaRfZlZ1g==
X-Received: by 2002:a05:6000:471e:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a222007dcmr3447843f8f.35.1734711500087; 
 Fri, 20 Dec 2024 08:18:20 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43664b15365sm33602635e9.7.2024.12.20.08.18.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/59] accel/tcg: Really restrict cpu_io_recompile() to system
 emulation
Date: Fri, 20 Dec 2024 17:15:23 +0100
Message-ID: <20241220161551.89317-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit 38fc4b11e03 ("accel/tcg: Restrict cpu_io_recompile() to
system emulation") inadvertently restricted cpu_io_recompile()
to SoftMMU. Correct to restrict to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241216160514.56630-1-philmd@linaro.org>
---
 accel/tcg/internal-target.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1cfa318dc6c..3ed81e740d3 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -36,9 +36,9 @@ static inline void page_table_config_init(void) { }
 void page_table_config_init(void);
 #endif
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
-#endif /* CONFIG_SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 
 /**
  * tcg_req_mo:
-- 
2.47.1


