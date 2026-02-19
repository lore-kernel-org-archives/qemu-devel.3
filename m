Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F68EE9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9dW-0000G1-5s; Thu, 19 Feb 2026 14:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cY-0004dH-TA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cW-0008Sm-LT
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so10276795e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529005; x=1772133805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0Rz7JY0DaonFeqLZbihnIdjPgrN0/EIWDH+188DHGU=;
 b=tkw9ryv77d4EdDZOADteiYadw7CCWPS2fQlWo85G6SEaIRDWFKK5NEnjE6VH8RTvaK
 FXdT5TEbuRqhg2VHVX9Oyv2P/abc1+r9Qo34roFlp+SUguC+B6K0xiAxFqrlmOA4vQ9B
 rzrytMdxzCx0/M0y1UA8Ahkvs4httXa6jxUPNh3QBbSMqskvbRwEM2aVcdDloiO1boOc
 eD9KzkTw9M8XzmuiSoftSpLb6zYUVrb+vQfruj6Qr2Dmco4Cga+fSyagAG9wWWSLYYdX
 0jAlS6bAGCvlZOVa0KAXQAaWQmbK3/Wlhpbj3CfjCQPDuDen1xWw0CMrsV+jH3Bu7ier
 IqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529005; x=1772133805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0Rz7JY0DaonFeqLZbihnIdjPgrN0/EIWDH+188DHGU=;
 b=rH3QiEh2KlyogQKGq2+Ff4UMwVHOyeibKLsTfjD9+LGy1WU5ecSGQS0HttdlBMO6tC
 Qdn5wp+UvLORtqVQ8ObtNhS3pT5QHOuQWcTY8X9uEOaPm9naTC6+tBlBeA1p9L0GHF5i
 WbaleZXtGp4vsgB8I/jikFPM5IzIVpX7F594jgKt5Lu8VHhxaWiI9UB8tG4ahe7FlEXx
 nB/lV5IJocXz392hmqQrrsPH7Q43aypdkvAbwgL1okKJJt7CUINRxy4d5arT2aC0vx89
 QP1aXQQcD5KvCUU2TikhYI2WJ/jTW8HCw/CsdSh9NgpyNXZUXLyUosDAwxT2xeEyQ0U9
 Ha1Q==
X-Gm-Message-State: AOJu0YyrVzEEm2s864YyARs6eKpla5Pgattfu1ra5Sal9FJsF/AyDbhc
 Xtfd9HjlrUqVVP0VOZy3mD/oiqAEGFBD693l0eF9v0LF7N5bkp8zeNPHzhE3KkNF4ligUKhJJrD
 W+F+BeKitRQ==
X-Gm-Gg: AZuq6aKEAXRC9HWCOtvESBNKH9pTXckMNc29a11lGndi01jtPrWNnm0COi8fgruDqJC
 Rk/spuTyFNiaGjfv5E2aCRa1EXZDNPn2fldCGmibuU9owdiR6DolUkEW41IQT4vz3Ss7r2bbSsG
 Rq31mewcHtqkvqsa9lPld8Q5ksh9Vo6pFunpAUHbFnkxEKVqsTtppMiYUjW0Zt1EBNt8LQnJKBy
 4zJ8+T5f5ty305FOKJGhcqcVJZ4g/eyXxcCYL4K53lqvASVUdQ+dDb90HCLl5aPlwrXznZf8yzY
 RECpZfuNDJO7bxPJtsP1AIpGccId6V5483zmePhDUge5vdZkpR0Za/2xNFQxnyxu7+ohMGT2FlY
 SNdAk+UGFVlT2Kf8GjIoanhcUPJ3L9YRddbB0Fambw+5vYfE3U4Mv7cdB40vbQpQpw4oZBGBzeX
 Nz3MzQeNd+BZRF5tpDgv6P20w/k5YuP0CjpWEk3kMknwNZmj5NepHx0POweQNWZHyQ4Q/f9GZ6
X-Received: by 2002:a05:600c:1d0b:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-483a009b770mr51916175e9.16.1771529005377; 
 Thu, 19 Feb 2026 11:23:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31d1e8esm35787745e9.12.2026.02.19.11.23.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 29/50] target/i386: Replace ldtul_p() -> ldn_p()
Date: Thu, 19 Feb 2026 20:19:31 +0100
Message-ID: <20260219191955.83815-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Prefer ldn_p(target_long_bits) over target-specific ldtul_p().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 291d56b8e13..f358bcf9e86 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -459,6 +459,7 @@ static int i386_cpu_gdb_get_egprs(CPUState *cs, GByteArray *mem_buf, int n)
 
 static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    const unsigned regsz = target_long_bits() / 8;
     CPUX86State *env = &X86_CPU(cs)->env;
 
     if (n >= 0 && n < EGPR_NUM) {
@@ -467,7 +468,7 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
          * XCR0[APX_F] (at least for modification in gdbstub) to be enabled.
          */
         if (env->hflags & HF_CS64_MASK && env->xcr0 & XSTATE_APX_MASK) {
-            env->regs[gpr_map[n + CPU_NB_REGS]] = ldtul_p(mem_buf);
+            env->regs[gpr_map[n + CPU_NB_REGS]] = ldn_p(mem_buf, regsz);
 
             /*
              * Per SDM Vol 1, "Processor Tracking of XSAVE-Managed State",
@@ -486,7 +487,7 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
                 env->xstate_bv |= XSTATE_APX_MASK;
             }
         }
-        return sizeof(target_ulong);
+        return regsz;
     }
     return 0;
 }
-- 
2.52.0


