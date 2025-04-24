Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11719C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krN-0003iV-TO; Wed, 23 Apr 2025 20:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015R-Pm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqA-0004ip-QD
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so375035a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456001; x=1746060801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/LWI/F8VdrNv0zLmIvQDUtowepeiN+2e5bv51DEBF8=;
 b=vPTGnB2bhpozCVRyRfwMQXR8xnX8gHfiz1JYz6HUtFEcbRsHzO1OC5fZ610ctYHEHQ
 3oG0jPogUIswU9wAWtGemTEpfS04XWjmpFoO29m3GNqT71EwK+GRUvSr4/VKjOoJ7UvA
 TCe5UqOg5ZzTLjveEBNpr94AtNMnjixmPHxYEPBJSG4LInZpANx+rSzOQ3rDCph8nA20
 Dxe4EhoCXoqoRa54BnGRPAcH7pkvEN4jS6eo5nNe/eWQlCcIpwqBG7BtGZskcHCKtCyn
 kdx1boOBeF3G3lzI/ikEBi9IG9ZV3uMTKyl1Q+xK0htykvvE1m5Hu6wckJEMW+5HK2rR
 QQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456001; x=1746060801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/LWI/F8VdrNv0zLmIvQDUtowepeiN+2e5bv51DEBF8=;
 b=mINLlJ98MNTnkMA2R8L/osj8qfGg5HYdD8aBFJsUDX0CXwEbwAaTfAu2pGx+lHtuLO
 +83a5cfqlKhU8WL8cr0UzHvQuA/h0spX5SNA8gMiKUmEDNvrCiBjMcF2jmyNeNbKIW4x
 ncygF1EyKft8FndZhgPMrxCTZDiHp33HfTWumpV8p3euIE546Eu23yvRksqxspLUSbKL
 QcGuNrxzyrs54JKA4w1ptpHDPJsa5tD697h8U82CfMT6FfD15hOX20iVJvU9FJ9N1KEm
 /W0QdecQjOG1ahPowxRg+Bl1yc/xw7dLcvh0KOO1Rx6YOhhW6hsG6LHC495orJi1k4BI
 3/0A==
X-Gm-Message-State: AOJu0YxMdLh1kcHV/rANfXqBcRe+ZfL9L25cTnQKietkGH2TWWRjcO4Y
 hQSRuBUEsK59Ih1Ja3mgYi8zfHFPNPIPPc/hp1mkTs1SRBv0TVoQ2uixagyIEuSWicHzn6FXrLf
 a
X-Gm-Gg: ASbGncufVJDNxSNwjhIcAEHWoW4KMo6Git7NfFdhXGh6fm5aQTSpReyOmAWokKOg4Vw
 ugBE+z7wv57UK2ov5UtHFBT489WJie8gawmzNNVG+LVKcGtpZLIZ3urBhy5KpV9LEs+veKsBQLO
 JdVfVfpcSncObti+RIiZVcsnXyluImXPA7a4Bu0i3qzas3/ookA78Hbzzo16MELulQN2Pk/tQdO
 Pl2wtPpv3MVwRHbLMRlJABiXzjJp3/nWNMkdeR3cLuLExXmzGRPIF38kAzFlo8LRW0rjy4UFDXz
 tZ/s7xs2tefw19neQ0ODkLcZKds9WQLq6rvSSqHrAKman6DrAy44S/uKyzEZGdJgTWA7gz47CTE
 =
X-Google-Smtp-Source: AGHT+IFrJKoJb4xUJG1reokIwTargxByO+7E8mEdMlKNjA4RWIckT9EP3iGAvch63GiCjVd3MV9aSA==
X-Received: by 2002:a05:6a21:1509:b0:1f5:6e00:14c9 with SMTP id
 adf61e73a8af0-20444ee3970mr881665637.15.1745456001173; 
 Wed, 23 Apr 2025 17:53:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 060/148] target/riscv: Remove ifndef CONFIG_USER_ONLY from
 cpu_cfg.h
Date: Wed, 23 Apr 2025 17:48:05 -0700
Message-ID: <20250424004934.598783-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

While RISCVCPUConfig.satp_mode is unused for user-only,
this header is used from disas/riscv.h, whose users are
only built once.  The savings of 4 bytes isn't worth it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_cfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..cfe371b829 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,9 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
-#ifndef CONFIG_USER_ONLY
     RISCVSATPMap satp_mode;
-#endif
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
-- 
2.43.0


