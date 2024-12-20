Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F92E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSGK-0002U9-W6; Thu, 19 Dec 2024 20:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG2-0001bR-W1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFw-0004fj-TD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:50 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1286392b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659803; x=1735264603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxMLDcONSvYYPpx6U61hKxGfs4I1jXSi4kLYiSJ5F/M=;
 b=T8JLuBjbOEx046Ywy1jWOxYGt1/wiexzVdZsgAPfAhB0Pv6dmKTI96en+pd8H/Qbty
 dQgeCaFtoKmKa4xR0KI03eK0DnT7KSvVM7SfFisZqxamMGig7oDIMeJ/6Lrtar8eaFX9
 PMel3u4bRPlikf1kcJCtAVhzrjOADR4gRY3sMwxwVGqgQqK3aSpLBiEhSSfpBSSnuP6y
 QeEIHW/k+9nlQTgSph4/j0bdJn2m+RNXT3fLnFuwUdsGxnM8EELqv0UMMbDD8A6vo1dd
 zNluOoULBYI8Jrv0GI7Snt56JuY7h2kDdFU/MPe3vRleUKsYUu7mfmJfEcI7gDYOo6KL
 acKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659803; x=1735264603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxMLDcONSvYYPpx6U61hKxGfs4I1jXSi4kLYiSJ5F/M=;
 b=cbFoUQ3F5YACcKjsaf2wqr9U4bdDPYww5W7monbrbJGPb78VVqCoEuxuxTp0NzIV4Y
 VglTvZedEb4A2ac63jcSqFXL7hAZ2C18RM5e6LvmcmIOde5VowkBIzcUqqLmAzIGcFYD
 x/047E0AuYW2dW8+ewnSQdjIv1/vWlHcNLpYvHEt7Bovpdg8YZeR4g+sv+JfFwUP119A
 RGMoJ6grDmPFhfJxHYzd5UH3GLKRIpD+tD0UD68DEg7BhtclocLBqFbcpytPiw3OL2RA
 miJYDY0PDXUGWna3aKsQeA/yri9QOZQZObs4mfHEHOGa/MGWUHxohASScAyGaHV6vcfz
 1hew==
X-Gm-Message-State: AOJu0Yx8AbWAbTviTZXwEkQnUr59xs4jSMssgUnpC3xxR9gbGetRPmmB
 zROtWAETNp+01o+ihSdhHlrKJAdcTx2ApjkIz2IACkjoHHDXHuQ1dwVup+oi
X-Gm-Gg: ASbGnctTkwkgYs5SGbIQTl0vQgx0v5LX3gIe7sl4kcztsZCydLoa8GlRbcqWMb/bpyi
 oEjNQeVAUmy2cNTi2ACl5scVj7irQafe099E4oTX0/U841OTvjen1IHTIyioqQAKesJweos859u
 Cbe6+kV8UGTNedcfz00NldHbJ/R8dhZb1+Yt6W/JGju0M3/GBui6p1UYt+YZjWjuhgA3elrMTd1
 eizBWelF4AB4QQehPm7ytlvxWX5llWKSzV3h8ybd19RUBXFtZFHXywgedmyGUG+84gCkqYW0XBo
 0Eso530quZAQg1+BARbRd7lX88rr1KdSAMpSZROoobkCsSpPYnPLn03G0r4nAyI=
X-Google-Smtp-Source: AGHT+IGAiSiuSSvLpM6nnMH6yL3ZmYkDN5tqj3bUfD+Xv6H/8LCM66bVlpBleCGsmrf39Ll5+jCbHQ==
X-Received: by 2002:a05:6a00:6f0b:b0:725:b4f7:378e with SMTP id
 d2e1a72fcca58-72abdbe0cb5mr1400116b3a.0.1734659803439; 
 Thu, 19 Dec 2024 17:56:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 36/39] target/riscv: Include missing headers in 'internals.h'
Date: Fri, 20 Dec 2024 11:54:36 +1000
Message-ID: <20241220015441.317236-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241203200828.47311-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ddbdee885b..76934eaa7b 100644
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
2.47.1


