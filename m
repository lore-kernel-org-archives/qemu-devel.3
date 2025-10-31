Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E0CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxU-00059L-Cu; Fri, 31 Oct 2025 14:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxQ-00056z-9Y
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwg-0006JB-6M
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso32174695e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935629; x=1762540429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4El+9jx0CZWN3GoFyj+ScMNSnwLS8gAMz8wgcCQs7ig=;
 b=OY1h6KZkMi4htvfhHUkjd81CrQK3u67yqrygPpt2RwTX8Xd8xXt8XegU50tXWasNOK
 C6KDnKYBCMMWVL3XQ5Z+P9Y+GmRoSv71NYMKX+FItJ+uy3XeQYsT/26PGzQS6f+QU8qo
 EJFvcVOi35euo5rQUBkngxY05WVIPBmB7OJybMF/OTJ1ra5QBTYISgj3D3VDJb+yzF0g
 LZj1isu2R1dqcIWeBRieszQNc8+/I5CG4kNTj0QetW4ZT6lE4iZ3axQOAKDKB/eYGn71
 T0IEJX4UjBuMQ9YMHt0SxaSTp3Ufi8IaFRk4DsZWtDYNuUfIXrUIXG6YjCh3KfxvFgnh
 pM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935629; x=1762540429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4El+9jx0CZWN3GoFyj+ScMNSnwLS8gAMz8wgcCQs7ig=;
 b=JMhqc4OeOc+QBCP2l3yCm6O4r9fEqq/Cyr6r13EwbKsScOBoHUxqgVO9Z+74YE05ha
 6tsltVWWVueftmnruIisSAn562jJAomgY1Hu6U1TLdSSQMOwHSHF9ryp1h2vogTed4c7
 xXIpdd/Fk6f43xBq1zYMjUL/ACY6RowyjYIOk/FnPK/V1e79V/jwbZ7tWosEc/81niei
 7rB0grl8NIdlxFSK8Y4Q8sHtpcGj+LxUV5lUbnmg72D/eXnDh/yWk7WDeMVYDUp3Vncn
 4IgZxjzjUiSaCivmsy4jrAO36m6thd4HO7C60bTrw6lQTcSQvmrMeQSlznjPyqZXMuDl
 uGbw==
X-Gm-Message-State: AOJu0YwinThmSA/be9hc/KW8XDNNzk0TZuPrr6UCdENxmW+SjTOkWwlA
 YdffhZzf6sxSKQHw482YOnb4Z/4msIwOgzcUHDGeSQPTOKOEbXClAYnGT9TETNkwhBVmlsR8UBM
 /WLFi
X-Gm-Gg: ASbGnctrWcUwt2c6nsypAvI6HHoGGq2E/5kheOOJQpHgO0E3ooZ3JaZ8T2Fi+qrg6Ui
 velJNC771jf71Ynp8jO2yqYwGUcOokGm3R3ax485N7scuBN2ySt0Oz4m56drSdkMycedOWriFZu
 R712dpl58X0WZCNiISh7bkFqYJUny4KE0Q4z20zGsBQD7oLSVvgLkc/a6qcKBHad/HdHCLBEr/m
 0cUKawXT7aN6uu23b9gL23ridNspf8baZqovENbAEDjcGlxPiwAVG18nP90a3QWoRcWREiJeyQK
 KUwbqW4B7Feg9tDOOmO54yzyizxhgwyDRNU0YP0DHTSystvfjgSCRNdzMvoZc/MKmwd/K5qZuq5
 L24SHOvUakJmyDcnYasZKfOQAJR3v5AeKDpnAPIBQpPV7IvL4txc2ncQXCdrxfUVhf1J5DnFUMC
 wKVPv/sg==
X-Google-Smtp-Source: AGHT+IFMxHZk/JOK6HuOLeBrZiNTjfiREnR6Yw0LZuajZNfuaYG9AbD6fRhP3NU3mMaezpontY85NA==
X-Received: by 2002:a05:600c:828c:b0:476:651d:27e6 with SMTP id
 5b1f17b1804b1-477308a8967mr46458305e9.36.1761935628533; 
 Fri, 31 Oct 2025 11:33:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/38] accel/hvf: Trace prefetch abort
Date: Fri, 31 Oct 2025 18:33:10 +0000
Message-ID: <20251031183310.3778349-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


