Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0187DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6f-00066v-Fx; Mon, 29 Jan 2024 18:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6P-0005xW-SJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:45 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6O-00059i-AY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so27845845ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571103; x=1707175903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNwfRTTrdrAUpr+OQpuLtBNdAMOm0+6sMEpzpDqnRE0=;
 b=n5sHElQ4PLIWR/+atVIL/xX1sQuRrYINqO5x0AgsfMCVYJwjUCQY3HOWGYJc/lXFdt
 IbW/35COovD6HuJsIdgY4ElVNWoLXTI9Wyvjr28NOAOvWqdchS7N44BOSiD1W5su+KMN
 is5RmrQ167qBrsUWOHpKO/zGaYO/g0G8iqAkSjSe4NfQaPgw3FVA7hImdPIFpQ8rum9j
 0JpCptU5dfJl6/kydCi0hCqvKHKdY0pmtJ4IICMGXcazoiKbuq3awVskfRUPvInK6tZk
 Pkh9f884P2mp1i2mdWKjrjz2G0hqrOg7kfq5NYQpMMjo/NAzTQKX2u9ueAbURmYyWYTx
 x5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571103; x=1707175903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNwfRTTrdrAUpr+OQpuLtBNdAMOm0+6sMEpzpDqnRE0=;
 b=RdC8Hf3uYvuW4y2wdV1L4P31tkDSCeJB7AO/cQXmK3XYA2zslLdGeOUjheZO9qc2KS
 nz4gg4YRQK0HHJ21A725nfcMtYablE0nTVLlSYWiHg+AvkG4rqywjtOAfcIL1cAhJu5T
 7IFf311WsnESblNRTOOktpZsInCY9Y3a2JOKGby7pTNTtGER4JD1xzESyfaB0/XXFhpe
 wgCn4XWRcDv8vQ4j/JWV5vLpu6gincILfmEST9l5s2cZLruruxM5FDDojDGHDI9PHd8v
 SjfVwcxY65RqQQss/Te3eUyAjYubmv6Ow2hoT7nhtJwTIphXlVvkM9n9sorEHvfTv93T
 w1Xg==
X-Gm-Message-State: AOJu0Yyok+8Y7uVEBBrU2OC+4KqoyA0uqoW2CryKueUdkfXUH/7meKOr
 fU4e5k1ohpE8QLh28ijAX9VrSpxjdnvOjFo2YCzLQEFg7v7Z3XZ42Ul3DUL1+iz6YaOWUwYKlej
 z5NU=
X-Google-Smtp-Source: AGHT+IFMIM2WFkNe9Wg3ScIMB6i6g03+Ak193/Hy5UUMxHgWOPoGb4aq0I/AaWPt3pBqAjsxMx/zlA==
X-Received: by 2002:a17:902:da82:b0:1d8:ffce:e9ed with SMTP id
 j2-20020a170902da8200b001d8ffcee9edmr1304068plx.65.1706571102986; 
 Mon, 29 Jan 2024 15:31:42 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 24/33] target/riscv: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:34 +1000
Message-Id: <20240129233043.34558-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cbfc7e781..be21fa09c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -867,6 +867,11 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #endif
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return riscv_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void riscv_cpu_reset_hold(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
@@ -1810,6 +1815,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work = riscv_cpu_has_work;
+    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
-- 
2.34.1


