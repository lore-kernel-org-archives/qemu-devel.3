Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B54C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYc-00027G-CK; Mon, 21 Jul 2025 09:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY9-00008Q-36
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY6-0005HG-Os
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso2532543f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104441; x=1753709241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZRW/Th0xabms8q7W0G10Em2Wy3GHDA1PbTBnv9Ysvg=;
 b=qnDAoPzmy+ZbeB4jt/pQtGeE0PRQ6rjL3/rTinVyB4VH5jXf5A8NHiU24gzPnFv12j
 G/9KFVh/re3Al8ZETIAQL27mVrj1DbLH9Dxe6RfXmlCwYlT+08vgANPjC1Oima2m3sHN
 9Hw1NqKG7EO4MS7SfDkfW68UynYjLrduoA/zhk3Z8kfeLlWE+0BXj13Ca3DP4XIwwS/R
 Xs+EQ7Yp3jsBkNANgghgbFHr4iDLr7kK8rkB12w1yEaXq4pWe6+KDsKvWx7mftNK6vXl
 jxCDfazyCQ4eFStMHG9Fr+TOn94qHOHEs7rOISn0BcogFlvEK5AJG/ibiQaIVxMCOhj6
 ocfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104441; x=1753709241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZRW/Th0xabms8q7W0G10Em2Wy3GHDA1PbTBnv9Ysvg=;
 b=GS8C+u+Er98DeDHUjIpN9lf3eNderMaam4MXyE+zt8syj3iZ2DKkXuRp5Owhre4Y97
 5I+soDAPrlu7gcdMaMr5LIHICSymr5BkSGjTFoqKpdxLlTGF7XNFvINR4ig5X2qOU5jy
 G7NXsiSxNVS5Qdm5RKrsmgUDU6rqnVL++XzBZZsL5Snz+81hWZF1TdaNjQnre3Yp5W4h
 9lFYvHYeS7EDbZXn0KHzMSg5NGqtzm/kLu5SyvPnjIdBWnYYPKmChABZA5BBC9O62MRZ
 MEvwHUZ1/BEHSVsJsP0NDKoSDvIhHt2yxAnRzXquxpPFkhNRQj1wt0Jwe8EPJnUCqEMH
 075A==
X-Gm-Message-State: AOJu0YzeOJSrpWdzfG5Z88bn1BdJwLKD3cZfigs1BX96IH6q2iF7rGms
 Vp8q6rGIG446xKfU30YrD/GvkaPk7cL2sRxCLfCcEm6Mxhtu6QcPt323P8THkCd6lMWs+1qiUb3
 PDV4W
X-Gm-Gg: ASbGncstkcEwV4mBTSwrrHMdxTfeMPsZaub2CwaLriP47giWkrxE1UqeEfWTFLjaYf5
 MXyW/QW9bZoDldlr7bii+PY5d6ZdyockuFptH8KKlAz1o8heR4NlZIHxqc07/4WqZ3dE4sjPVAz
 z/T+am5v6+mNp0d3gIzYGAQCXxlY6yHALRK3KV1MdNO56q5LBQtf2wJYLyauhycLyfmo3Tkxl6u
 K/yoQhJcnuu8kU4MiXjeYbhlt3uXXvL5V6glQmmSLR8Fw91P+aT7MsLBDT1nkIdGyZC+WDwzewG
 f7SqAjs/s301muF4eSLI9yV7cavZ0P87WTZsUuzlmRIPTCAd40lt3HXF5PexyWk4hBOlXsZzntf
 9EWSfBW8bdMeFD05dzxLrzUuuS8l9
X-Google-Smtp-Source: AGHT+IF/dkPhJZ8o+uUVPOF9mFfnWFLyopZg7FJnE9GKnaurGcM9bO9Pxaszb3DwzjqL61JSawcoXw==
X-Received: by 2002:a5d:5f46:0:b0:3a6:d145:e2cc with SMTP id
 ffacd0b85a97d-3b613e66ef4mr12995791f8f.15.1753104440928; 
 Mon, 21 Jul 2025 06:27:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] hvf: arm: Remove $pc from trace_hvf_data_abort()
Date: Mon, 21 Jul 2025 14:26:58 +0100
Message-ID: <20250721132718.2835729-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

We don't synchronize vcpu registers from the hardware accelerator (e.g., by
cpu_synchronize_state()) in the Dabort handler, so env->pc points to the
instruction which has nothing to do with the Dabort at all.

And it doesn't seem to make much sense to log PC in every Dabort handler,
let's just remove it from this trace event.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Message-id: 20250713154719.4248-1-zenghui.yu@linux.dev
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 2 +-
 target/arm/hvf/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9cfcdc08bb..8f93e42b34b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2005,7 +2005,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
 
-        trace_hvf_data_abort(env->pc, hvf_exit->exception.virtual_address,
+        trace_hvf_data_abort(hvf_exit->exception.virtual_address,
                              hvf_exit->exception.physical_address, isv,
                              iswrite, s1ptw, len, srt);
 
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b49746f28d1..b29a995f3d3 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -2,7 +2,7 @@ hvf_unhandled_sysreg_read(uint64_t pc, uint32_t reg, uint32_t op0, uint32_t op1,
 hvf_unhandled_sysreg_write(uint64_t pc, uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2) "unhandled sysreg write at pc=0x%"PRIx64": 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d)"
 hvf_inject_fiq(void) "injecting FIQ"
 hvf_inject_irq(void) "injecting IRQ"
-hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
+hvf_data_abort(uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
 hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
-- 
2.43.0


