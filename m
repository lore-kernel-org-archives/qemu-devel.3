Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CCCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcVB-0003st-KZ; Tue, 28 Oct 2025 01:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcV9-0003sF-OR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:44:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcV7-0002fY-DI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:44:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so3587740f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630247; x=1762235047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBz1h7xoI5jpeN42Mwomv4Cjv0TFppAuDOiSUpLPuUU=;
 b=e++vs5eYPJG2Zd+gjKShqhcHqIDRUPrKZ5EiDBJjERlirso/kWI8u2HSc9WoYwj569
 nh08UdDnPtf7yx1nsq/mv9OZi0O0QtzWMi26HtplC4B8SH8ippeH9F09c6acsC6wWidA
 nxevdbTqgYnG23zDfmQ/1bFhoPMhViYHMzMykvpJKujfu76FKTykslch+E6qzaA89aUn
 iSI3nwZhhY8RsH+2q+AQmD0yGTwabkIVQ27kM22VNjonhPexe4DFp1qsFYUT8NX1fmzS
 DLW3e3aI0ZGGdwNPxq27EpLIHJg20UwZLfwFNWjQv/FQGxP8b7L1+hP608FD52lhmr8Y
 TEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630247; x=1762235047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBz1h7xoI5jpeN42Mwomv4Cjv0TFppAuDOiSUpLPuUU=;
 b=NTb1RSpsQ8CZRjyHhMdaRC+x9kiMw6fRQu2vcbFm4hWiLsGvX0am/iXWA9B07UD6d2
 gXR51aVoqrcJRyXBQKfS/fZIXbAt0rExj091YibX+UApdqfaFYM7TPtIVzLeyZHDAlb8
 DP+yEu1hA4JzNSCOK1jgwcHU5pU6X1GqhkvfybVCEZiTeS/E97YAWMcphiqAHh0oTYIs
 osd4+zUvVGL3SShjL+A35LAp/uaKC6Kdj2q/jW4jFo1SQm7Ts01/8Kcd7v+NMeU3WSAd
 H6iLBsMS333pc+IZ4iENU6AjzcZSkMVA1aw+32D+Rw+uQoWjfux/0O8EG2S5dPJkrXjM
 8NWA==
X-Gm-Message-State: AOJu0Yw3CwE7Ukl/s58iZGUAvaLdFeW1DlJeXG7N5x4tF1U9ozvwBTvo
 OW5v1vi+HwvsjiOcXNJGNJdqw1NNu1v6gOjuFUTj1Qxfj2PdQSgYT10qLJcsiTg/0CKYTuA6L3R
 ZVK0vqqk=
X-Gm-Gg: ASbGncvf5oft0k6BfJAAkFmKijpU1r/QF7SqdpfLxXBHgU1rO6WCised4QbvMBVW9dU
 XVTIRTJKZItXee8MRoHNeED8SRgmMa7rCArmzmIMktQNFgIVr+q73lb2KA6xTy3tyzG9qAVGvBZ
 c8yN1GxkX+toERlaYu4JO7/VyWAvJ13IqeLHutq6RaGlrb0uBZj/ildz8tXZAP6vPHJSc9solzE
 1C4BmOgUfvyHzTQcsXLs/edL0fjVQpBbHKA+u0g6FmJXpwfBMTA+uR4cyFh953u0+XSJoIwcE3i
 gI8Qo7+UeohyRaiMtPmOnl9g7swq1JMbUAI04tJWPTbgn90S8fSxqmiKoDF2fUJRtwvhLo4LagT
 Q+3KBck9Cd9LmGlInFI7GdBj9MOyeoiujL3O5ZxW3kn0znQgWRht6/gjaYNghbhR5ixJC3kTuUY
 ltxNYajT2CVNTdUSCusaOvWL3vtLUr0Z4mRvM6MKXQ9q11kDpEPihHC/l8862Gpqua2Q==
X-Google-Smtp-Source: AGHT+IE4wKU8AXN8Sm+NpRzVaqVtZmvVrpQId8MYFfGR67jlaRS/smQv17rEYB1G3ZJPafnCU7O5iw==
X-Received: by 2002:a5d:5849:0:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-429a7e82730mr1394199f8f.48.1761630246731; 
 Mon, 27 Oct 2025 22:44:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm17763906f8f.12.2025.10.27.22.44.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:44:06 -0700 (PDT)
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
Subject: [PATCH v3 02/59] target/arm/hvf: Trace vCPU KICK events
Date: Tue, 28 Oct 2025 06:41:38 +0100
Message-ID: <20251028054238.14949-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 1 +
 target/arm/hvf/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 83db1088384..91bbd3a6aae 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -963,6 +963,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
     hv_vcpus_exit(&cpu->accel->fd, 1);
 }
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b29a995f3d3..538af6e0707 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -12,3 +12,4 @@ hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
+hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.51.0


