Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B043CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcoX-0004Ew-3V; Tue, 28 Oct 2025 02:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcoV-0004Cj-5q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:04:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcoS-0005kR-VJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:04:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3197737f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631446; x=1762236246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xn1hBfvpsHSz1gYz2L9i4rhmWW2kN0qXymZ6HJBhx7M=;
 b=DwvhGkjXuFF7+TLPoxN730CdP0OSjB96gP3pkyoAuodVI4dfmCIE3kIoSiFMLU17fG
 E/jJKZ3eRMAxdbxyiYRewzl2ne6/q8qkXgbWfuO4Z+Nfjb35AG8YPCzz01cb8NFEmoxy
 C/xqK/bD9oiu2hQ6bkSYKU/8CQ6xqPUNjiORzmEf2+AqcWuchCv9m+mDjwof86hruSf1
 bcrQbEy9gNXAWONs6dJciLpzXMEvn/vZJmqf+r791nJRQue2KO6N8CjLFjVxEqMatWZS
 zTimxPJJ3hxoShvBaoTW0doj+5McHKud2SeafnX53WLmT/FupRSq6z6kiflQTPszWFFa
 HHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631446; x=1762236246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xn1hBfvpsHSz1gYz2L9i4rhmWW2kN0qXymZ6HJBhx7M=;
 b=SD5r0xxIqCw2DPN6h9FuUyCkWoA7809VAXO3umyn6/ty+LP4xCgaHbgv5JLYcP2Xtx
 FAXUyAoHqG/Qb+VI5lWgXRhsGgO7MFhH86wAv/TraVYtwAWKIQw8jAs8jcaMm7jk3XV6
 B0j5bQB+QDn4+rqzQMiwtvt5R4r+l3HYFUvnniE0uggzbnQk5GuZ2X2C+oLAP1zJIZWL
 bzbk8T2U8Nrctp6Okj5as/K9ch//Ny1jtA8IsKHB0F78nv5hjtd5pLjIsMw4JJW8AsZj
 AAwleSYxJreegZrpVvh8R7WjaO1fbvtLkzBUQqEi6WZbWQwizGFHywgwNa4+tmIyJfcQ
 2jmw==
X-Gm-Message-State: AOJu0Yzh2AKasI1JZOh+FwbVBEMMjOzpUJXSvMnz1WddioZ3SBqcTqPg
 fM1UGnMfHGZacqYWVUG3DldDTLqAQBB4HEBsKZ7xhhUlaLW44X730/Shj+EEcyQY9O9bBrpYrFN
 NClB7Q1o=
X-Gm-Gg: ASbGncsQW99T/dJe1CrnW998EFHICCOHu4p1GXmf7nXKA4WvAWY6Bp0yvCMJUJ2ydIF
 Lh2Q0/xAxNPaA3w1FZ2WvhcENpZoEhy3+mFjKhg7dTlEHpGlGn/6bvKj9yauhVV7mpJUK7aZrDb
 1qU+ndDD8qi2pPjJn8GTIi5wW89ojnd81CCkBAC709LmHoy3Myg2mSbeJJkP8VkgLKsqtfZSH53
 g1wygxq1XuAp9hsi3Vf2TFoXL/q2J1WHUbEl31Pa6XJ9s01SYeNh/zzkqlNjjn6mITKGpWJcPe2
 j3q9VkSz2+nZmW1jPt7c1Qj4voz9yhugz7GEQyjZ4sN8yQjmLcbQASKc6342kxeZtKTJYMxim05
 HYvG7dTgNBlQ3Ye60oV4ztA38qsE1hVQSLqODPhDi5i9sX8js4JwHuNKC5LUJgPs+xRmHTbKi6D
 Dt3qKCQZOlIlRoz6y3WZ0PminpV0YCFoxFM55twTuuKjVeDlTFmWOKh/Y=
X-Google-Smtp-Source: AGHT+IFOk/Fv4mLKlzE/tHV2k7ujL4eD6BoTdajwOCc2as4saYM/Jjgd+oVbiA5xEqHNioY5AT6b6Q==
X-Received: by 2002:a05:6000:1a87:b0:425:7c32:d969 with SMTP id
 ffacd0b85a97d-429a7e52f3cmr2003885f8f.5.1761631446405; 
 Mon, 27 Oct 2025 23:04:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5678sm18089059f8f.22.2025.10.27.23.04.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:04:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 30/59] accel/hvf: Trace prefetch abort
Date: Tue, 28 Oct 2025 06:42:06 +0100
Message-ID: <20251028054238.14949-31-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 11 +++++++++++
 target/arm/hvf/trace-events |  1 +
 2 files changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 805fe75e6b1..de1e8fb8a05 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1963,6 +1963,17 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
         }
         break;
+    case EC_INSNABORT: {
+        uint32_t set = (syndrome >> 12) & 3;
+        bool fnv = (syndrome >> 10) & 1;
+        bool ea = (syndrome >> 9) & 1;
+        bool s1ptw = (syndrome >> 7) & 1;
+        uint32_t ifsc = (syndrome >> 0) & 0x3f;
+
+        trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
+
+        /* fall through */
+    }
     default:
         cpu_synchronize_state(cpu);
         trace_hvf_exit(syndrome, ec, env->pc);
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 29387780e3f..b0d3d7bd322 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -3,6 +3,7 @@ hvf_unhandled_sysreg_write(uint64_t pc, uint32_t reg, uint32_t op0, uint32_t op1
 hvf_inject_fiq(void) "injecting FIQ"
 hvf_inject_irq(void) "injecting IRQ"
 hvf_data_abort(uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
+hvf_insn_abort(uint64_t pc, uint32_t set, bool fnv, bool ea, bool s1ptw, uint32_t ifsc) "insn abort: [pc=0x%"PRIx64" set=%d fnv=%d ea=%d s1ptw=%d ifsc=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
 hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
-- 
2.51.0


