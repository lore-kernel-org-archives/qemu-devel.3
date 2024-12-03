Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0120E74AD0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZCW-0006f8-3I; Tue, 03 Dec 2024 15:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCT-0006d2-CY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCQ-0003HR-FS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e2c52c21so2425554f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733256524; x=1733861324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z+oPOY9zkW5nSvF8Evg7C1/iJ6Xb0OH2wlMJp2C/qo=;
 b=YLV+bVm+CDkPYgz/oNo/X5B1LzpiKtLPA1L1DECw989piUmWhVt3sxoqSMGyx2rFRM
 RhQweMZl2VCyh1o0bTzrPEsROQKHDwB7JV6RJ/I3TkYs+DPpUYfpyCxlRxbChhL6eQsg
 yg1AXBCzA4Btk5nVtrDLkBCaCKDx7hLsdc3phpuz+3pbFc8oOD1kCtIUjB85YArxadrf
 vMoaTljs0G0LFNBF45NaqSdxY+GXdxm84ZLNiasTtnUo14LubNyvoVSWzisgOQJ5uIPc
 8knvXmivopHF8pMirJmF0OkV3cs4zhlLZFxp/CzBwYWr+O1kWCuK29w9TEs/MGJSVc4P
 mYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733256524; x=1733861324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z+oPOY9zkW5nSvF8Evg7C1/iJ6Xb0OH2wlMJp2C/qo=;
 b=BtiSN9z5+96sHaT3L+S7yOU2ukZSfIrdoF+iItmZygpV8D+c19sW7F+KfBA1wRMrB4
 WSiSyGNGCvUJVL7E2iOv7M8W19alYCPinCD75w44++eWk9pwXIR5sL6J9KkL/Zo4j2W6
 WONoN9bk/QhJVLMpQPpUXCp2Q51t38Ohr6GgQilrS0Jw6XD7y6nzY1a+iX0F8FCdyg4a
 SH2FL8Xt9plJ9vMBpKxzZQk/exQuGFfsnLkiWKgiXEqRMHaZfeQp20pgfIumFTFp1L3g
 h26Fu6MXnKrHb355JSPhz0zozg0jGhaK8+WMIHcPVlPPThi4FBGpW48Kw69UNx4dvIas
 YqkA==
X-Gm-Message-State: AOJu0YxX/XVkiEQPZ6wYtcdOUjKDZIDun7k3CEqGmfQ+EewnNaL+tNAU
 Z8fGM1j/IuXvnZKHo38hT2L3WGg9MBktWXMsMiJ0EursiwGTkQU6iyTJSD7928T9mhPHtJPJ3K9
 V
X-Gm-Gg: ASbGncu25O710Q8NInoaDJt2Ew/KSt0Fswvpj79/LtVl3PbvwNvTNMNJGkIZGEIRX1j
 FklL6svF3XCMPKY79bK3TI2vnKPiqpPSKQBaEf428F6UbQQiPaEckl/2TuyQOaq07Khtmf4Dpg4
 QlmlEIvsUIdoc9O315O90I4cRfFhr7HyDBlHZb9jHH1oIzLjljBc8ljCbyaQerbtr4nkpuGK8kK
 yZBz46KV4w2zK/ugGpVUDly2fRJJ6n7ATBFNRo0+o/08HeaiyIj0fQs3MqV7q6Ppqq9CvaIEN0T
 LQ==
X-Google-Smtp-Source: AGHT+IF4fQBFsW+NxSAbs2sW/fx5c+t0fCV00XJKeHtclBhrZEnCA1P0iSmfPf4+zcf1Z+IAPSERkw==
X-Received: by 2002:a05:6000:1a88:b0:385:e9ca:4e2a with SMTP id
 ffacd0b85a97d-385fd3f2168mr3266300f8f.4.1733256524368; 
 Tue, 03 Dec 2024 12:08:44 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e3c21ba7sm10804489f8f.53.2024.12.03.12.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 12:08:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/riscv: Include missing headers in 'internals.h'
Date: Tue,  3 Dec 2024 21:08:28 +0100
Message-ID: <20241203200828.47311-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203200828.47311-1-philmd@linaro.org>
References: <20241203200828.47311-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Rather than relying on implicit includes, explicit them,
in order to avoid when refactoring unrelated headers:

  target/riscv/internals.h:49:15: error: use of undeclared identifier 'PRV_S'
     49 |         ret = PRV_S;
        |               ^
  target/riscv/internals.h:93:9: error: call to undeclared function 'env_archcpu'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     93 |     if (env_archcpu(env)->cfg.ext_zfinx) {
        |         ^
  target/riscv/internals.h:101:15: error: unknown type name 'float32'; did you mean 'float'?
    101 | static inline float32 check_nanbox_s(CPURISCVState *env, uint64_t f)
        |               ^~~~~~~
        |               float

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ddbdee885bc..76934eaa7b5 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -19,7 +19,10 @@
 #ifndef RISCV_CPU_INTERNALS_H
 #define RISCV_CPU_INTERNALS_H
 
+#include "exec/cpu-common.h"
 #include "hw/registerfields.h"
+#include "fpu/softfloat-types.h"
+#include "target/riscv/cpu_bits.h"
 
 /*
  * The current MMU Modes are:
-- 
2.45.2


