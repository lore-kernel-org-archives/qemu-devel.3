Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A1BD59D68
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfF9-00052l-Sm; Mon, 25 Nov 2024 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF7-00051a-Ef
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:33 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF2-0004li-Vl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so16710815e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564767; x=1733169567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWjtUwTz+qxGQM43m+Z3dIisqsvdUtxVeJqucaNK404=;
 b=VaqGWztdmjGBnuY3B+g+bgbMKFRPI3+XgQ1yin5XCp1ScU4Nw1g2wpvyY7Q91lc62I
 Eyx61VE+q2UY7GBWhhiLG5rnkFcXSEKDSLQQvAWgMt9Z0hn8mxSLOUxNczGlNMLYETPx
 CauY52b6ktT9TdUixc+O/VHIe/ZMW0+4EBs/AphNTD1DA9FgCrL+bdJTxdtTJ0mYQDJT
 /2QNhbDqpRgYMYpx95rrDccVrUUzan22JVIYn4cpyPOkAnQ3goV5YmS4JrX+HIXzO1gp
 AQSeHpjzJ64+jRnusoibF28XnBiwhUtdnRVuKBh2iYX53cRQmrar7ISNRD4mgYiV2C3K
 hK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564767; x=1733169567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWjtUwTz+qxGQM43m+Z3dIisqsvdUtxVeJqucaNK404=;
 b=c08CQ5uCold7R+7jzXvYlp2udEVUxnxhfCQ7E8PF/o68ft6vaeJSHmyGP3vz5Ifodb
 hnhhOAg+bG9bCB4oZ7ewZokVvJ8t7W9OrX4KGH4McPsjQkOa8dJwxh94Cwjy0pUUJvKn
 eBBQSNFxUYt0Dk7BY0IH/4+41HWJP31EjCIHu/jmONHTwJvbA62driS6M+Cl9H4poNEM
 T21MM6LmJjjYvutX18t/FN5T+oqe3gjV8XpTmDYbR/+gxdF7b8erZUcs/MSM+vgaedxm
 vx6FGxdCStyhFy/oy7WVrSdXiJJ31BpugOpB1M6S+g2Yz3/YpFdnBvsWediyBDY/FKUQ
 AFFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnPM5Ef7KUtsHXYlGlhNXv5UrmojTi0HWB2ALGGr2BL51zf65ZzKmyc7q5oqkKu4XeBBCY3tWXDqKQ@nongnu.org
X-Gm-Message-State: AOJu0YwkFdRwZErXJ9kNtbu4VbvYbXduur7qbmSmPm0D8knqMOYtZSil
 MYmkwoPMAogIhXv6bdAV7JURxsWanpZGYMy8trJBRqSBteuoeqihnYjQFvqWTmo=
X-Gm-Gg: ASbGncufMcfjvQlR/yan1sgLrLhqOkdN6QUgufA+W6Dui5OSfJqqZF0QJ0w27Q9IpuY
 hlcMsG0vNagNvvEOuni5HDCAWVFlqp7ssyQEIeNV1vQMMb0tQ0crdOKrJwQFwJkgNpFuJ89yt07
 7F6auRpvuw+M8izSNjUrspwxJk5gi2w501ZZ9yZWfWim6sm9DpTNfRRfxK8kO1ty/yHNVNV38U7
 p9IX30NJN1qYhaYsWHDd6AS7owY8S9yWO4edwmHs4J17jYJ/kj3tytZOwwd7N/TMX23
X-Google-Smtp-Source: AGHT+IHn5QrVSKT8f+HZbb5tv4/jHNV6uqmDU1SLfzrB1hHig0KKaWqz8lFSXW23mKSBRR1e1l/D4Q==
X-Received: by 2002:a05:600c:1c8f:b0:434:9e51:4db4 with SMTP id
 5b1f17b1804b1-4349e515028mr48346395e9.6.1732564767551; 
 Mon, 25 Nov 2024 11:59:27 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:27 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 05/26] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Mon, 25 Nov 2024 19:56:04 +0000
Message-ID: <20241125195626.856992-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
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

The confidential guest support in KVM limits the number of registers
that we can read and write. Split the get/put_registers function to
prepare for it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 440c3ac8c6..0c80992f7c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2062,7 +2062,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, int level, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2165,6 +2165,19 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, level, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2246,7 +2259,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2349,6 +2362,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.47.0


