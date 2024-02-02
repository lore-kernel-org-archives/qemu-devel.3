Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA46C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRy-00016o-F5; Fri, 02 Feb 2024 00:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRx-000165-5i
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:53 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRu-0001cQ-Ay
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:52 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d8df34835aso320193a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853049; x=1707457849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zf0HbVX8gvUwqhja+dnyq/HEcNPpSpWkMmM6ss3Zow=;
 b=YnnonL4dfILdH4WWHiCC2VZVGZvGDqCOIwfg68aklOHD7NUwrWiJcuIhiaXkh05QSk
 W97giU4a8gm5jc3LbHyvLpekTqosExf45HurDMcXViVVB7Xe+8VbaT3RbkPrwzEyZ9Bj
 XyeA2ukjRRHg+6ITpAMyVJgDSwIu5aJG5Ne1r6OE7iq5isUPG5VAZ7/D3gsXQE57OYZZ
 VpWN0cPZ8g8LqrxvBBC7XAteSWP82tZLqVvOIAEorOZy7LLLOqPNEPL2z7MKQbFL/fDY
 Ceotu180+Jt/xo4rQhhylXzfP5+rzjECJ20P7cc9iauZY/aRvOC2WaPs0YRjZ2Q/0LIq
 +DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853049; x=1707457849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zf0HbVX8gvUwqhja+dnyq/HEcNPpSpWkMmM6ss3Zow=;
 b=tG4oVPXRIcTZE28nzcYJ/u4J1llVb4UAcFCqh348Wcz5pcLXx3BcgYvcayUdz43Ctg
 uIhpVXhQwxt/K/R7Z90rjCqipArVJ+/jJ4N/K5CoeazeX7op03pG47v3Pl99+4EGo37Z
 U3lyV9bMj7JYwa/MQvpTXAJFNevkl72ovDaG3Oyy6r+ht/Xw8l9xuTmXxiGxbgMTc5wd
 k3gR71CxzY8ulHXPI8bjVH8xmnT2SlC5RKLX90UV09EIOzHJuo/pz99r8+MXputqxweb
 EGGA2nD7j1/cqJSrgcwrTnKtZ6MmFMWRrLa4ovGEZu5jnl3TGzwxe2JkapPlQjLHrLIq
 x6Bw==
X-Gm-Message-State: AOJu0YwtXhkBECMXbRR9a4i4wQP/+v8oK41ea+D0kxGJhaFP0vmvzH3O
 PLvbnmnell4YYZEYl+cogpyYMvjrXSrsaeF9+RbxueDBEzO2dKnvgh4ybsDlPAgKr/TJAjmAfbX
 oAAE=
X-Google-Smtp-Source: AGHT+IFU+C/slZTYWO8/Q8Peb+y3BiqaW28VQygYOUBInclJcnP6vaNquTc/CilY3urv68iw3pa2XA==
X-Received: by 2002:a05:6a20:6b9c:b0:19c:9a00:1351 with SMTP id
 bu28-20020a056a206b9c00b0019c9a001351mr1778846pzb.25.1706853048999; 
 Thu, 01 Feb 2024 21:50:48 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/57] target/alpha: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:42 +1000
Message-Id: <20240202055036.684176-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index de705c3703..bf70173a25 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -64,6 +64,11 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_MCHK);
 }
 
+static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return alpha_env_mmu_index(cpu_env(cs));
+}
+
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_alpha_ev6;
@@ -230,6 +235,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
+    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.34.1


