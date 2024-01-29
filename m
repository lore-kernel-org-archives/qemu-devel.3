Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF7C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6a-00061C-Ez; Mon, 29 Jan 2024 18:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6R-0005xs-Vb
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6Q-00059u-F4
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d71cb97937so17976645ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571105; x=1707175905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZadEiersJPkOM/pXyufttHg+GMQ5Zo4Kp1sJsHlj50=;
 b=lqixDMYru1Q1JB1oX94IwKsxhnNiEG2JYlkP2obpahsxsl1TaC3tbP2UyyAdEVcRby
 H/WxmzSIFWtBaRAFrm61Y/fhgoCUAgRECAtTPuKCrZL+F/HRCkaDnoWZvKshVthm+fTK
 Q7LMWB05Ql+OIFVB2OA9DouJ2QL+8m3hmUwA5XU49LINMNbl6pYI1Eb+0TmzwZlmg6ZU
 6PSrg3k/a6J0OuztvWGubnryt5+uLJ0WR7TThb4i0WNZNZ2mXBWtGr1pcyzOSddHj2JF
 q9igrBSzn6fHJeSaUqCzTar69WiZijczi4/sbZxeLSnH+rrjNhn597fde87tu/jQRb7K
 fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571105; x=1707175905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZadEiersJPkOM/pXyufttHg+GMQ5Zo4Kp1sJsHlj50=;
 b=pX4KwLx2SQRhmEBjsYjjf5Q38So8y6VnI797IVx2Z37zobjCUCRdBM1z/J65NRcqJM
 zRQ+4IEQugB3AOSEZ7NPeh693aAP3fV86gezD3TC6cp2wI+ZeL7e4ZJxGMkXRhFqeLlH
 HfwK4yIMoTBIi9IOdPmNeQhH1ycGp8P+MII+o1TPydK2RqF8w2FrNLBTnL4hT1k2B70K
 rnq1S3mDttaqHCMczqr89kf9SkvsuhRXr7Pm2RqXX5aAXWFgVl6Bqp3PiokLy2dacyUD
 /+azrW1awMkpR7nVhB/EXrYP1N+cF0yfAtMHNE/YyC/WFHSIbe/8+XbqBW05OK8zhmmQ
 F3EA==
X-Gm-Message-State: AOJu0YzuGR+q+8hAhLfEQdA4AgIBYQ/2GDAOCl4stTZRlbss4HeDqTpt
 +Ol3mZB8L22p0/4vMrWKZAnOgXjcTW77QERR5xQY7mU30+8qMi3ZgXDqkYYqg39z/LdLWx8NYEF
 aE5s=
X-Google-Smtp-Source: AGHT+IHejJlJCvtrPOfKR0v5f2/92ewbIbG5EjEjaAEb5+cZ4vhd8ucPWLBWkCrERsEb1f5SG/zU7A==
X-Received: by 2002:a17:902:784b:b0:1d8:d73b:794f with SMTP id
 e11-20020a170902784b00b001d8d73b794fmr2219171pln.56.1706571105258; 
 Mon, 29 Jan 2024 15:31:45 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 25/33] target/rx: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:35 +1000
Message-Id: <20240129233043.34558-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 353132dac2..5205167da1 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -64,6 +64,11 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return 0;
+}
+
 static void rx_cpu_reset_hold(Object *obj)
 {
     RXCPU *cpu = RX_CPU(obj);
@@ -204,6 +209,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
 
     cc->class_by_name = rx_cpu_class_by_name;
     cc->has_work = rx_cpu_has_work;
+    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.34.1


