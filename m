Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtss-0005h0-66; Thu, 23 Oct 2025 07:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsp-0005dK-He
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsn-0002cQ-Ov
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4710683a644so5929715e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220408; x=1761825208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beoY+BW3TD49vXs4CyggfoeGS9sL7sPb+rvUv38igys=;
 b=BwwRQGb29KJuD++PEy7/deVWWWk5EO6kxboBtncE54ANcyTvsBslqV4DKy26lZOdSK
 GX9qkioOpGGT62giYYOV0Ezr9PlH09tzmhEV7RTObljsEAcgrPdqS2prGyJ6vHEY6iyB
 PhM6Tl5oYSoKV6o/YZlieYpPntwBQ+TZzD0aUM/Z8RdNxrFh03ULLAi2gmBq4o/73s9/
 TRklmxINFacdnE/p8AJCSBhXqQzerSxf+Jf0yQUljnAFqv39VFg5w7gL1ZKgE7Bngixv
 1GxVDCQ3zkS23TK/fkGNiQ3gaEK2p1WlT+nrvNuEMHU2EXRoGqktzJy5aG2JSQz2TavU
 BF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220408; x=1761825208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beoY+BW3TD49vXs4CyggfoeGS9sL7sPb+rvUv38igys=;
 b=dK28XRAoq7iAB7rqzdtqO8j2mYmSU9RI8/2jrQyGMDy0JJ7cv+rCNKqECWsj2iMPjM
 vX7OxdVvFwEdMyKHw/d60GXeNNRqWjKfrp+IdCG8eMt7DMoG5a9PJxoHwtFHxcRB7kcK
 WP4k/8AnlrO0t0AvF71h5A19vB+36sqwNpjnv+QHaYPAN+hmGLGfrj+PXkyj/CQja1hZ
 YeRR7exmVvA9zciLzd8RbAzRr4PXbOizR1kFew0PzYFJ76OEZSXAgV70jschGVMT9Gn9
 DFSML5kv5qsuY3ahyOkDIiltUZZx2/k5BJq/Y8IrkYCdPVd0lcZr/Poe7UVQ/z8V43Kc
 39/g==
X-Gm-Message-State: AOJu0YxuG0+AWyuFg6LTKQA58kC5UUoTKhGCZUCI5YpZm0T7i7CJQzpz
 gwkPaR9psUN9tFe+L7dQlSYFd+iNa7/u6Bc73Zg6snKcj9AIQcoqBiQllWZZ/EyiBdOZ2u3iJOJ
 1kc6aVTg=
X-Gm-Gg: ASbGncvanxbnw/WamJQ+JUBfFewLIP5/Od5pSJzfy3IyGE41Fd6EWzn8SlKVT3QoOk0
 z9PvMcz9QYMiL4hXX5eGawtmC90wtiZ1HVEafqswmOzoOJd3a1S6w6Z1K9W/k4/KwiUtwH/b52Y
 fWR4lP1wuVGZRR4zU01y0g8b79zXyPgUcqBEvw7/SkwaC6cx5SWuND7+NI21CNeCfpOYYiymx0L
 gFEB4y72RdbD03pOAk1RpGzJL1OfsJ2s7sWxu2TxvANFNh6Bv0uqYJGX2u8zaD4IOteYGuiLye4
 UQ7p4cmTnPvsnuk3gzNIx4IrkydH+b3/A1rqK8VmH0Bm+G0jg2dhkg7oNUyhu7OUKxm4pwpbzbY
 1WTv4SF9pNlsUXoTWuOTHQYQ0mbW/Q2VXTMDekW1WB3F6jrMauD1M+8AUZYiddAc9Kn11eqEQ2C
 SaFT3hqN5bbumiZGKAgTELiHTutG5Qymz40iReMuI+i4T36oEPNQ==
X-Google-Smtp-Source: AGHT+IEvrVaFv23S/qiOlmTwaYFJc6krdyAxyqLA1qGzJQlG+jSjZWWZtjx+Z/sBE4y0MI3EH2Jb6g==
X-Received: by 2002:a05:600c:6553:b0:45d:e775:d8b8 with SMTP id
 5b1f17b1804b1-475c6f18746mr27739195e9.1.1761220407858; 
 Thu, 23 Oct 2025 04:53:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898cceebsm3564815f8f.37.2025.10.23.04.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 33/58] accel/hvf: Trace prefetch abort
Date: Thu, 23 Oct 2025 13:52:44 +0200
Message-ID: <20251023115311.6944-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 target/arm/hvf/hvf.c        | 11 +++++++++++
 target/arm/hvf/trace-events |  1 +
 2 files changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a045f83c9e2..77998ab90a6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1974,6 +1974,17 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
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


