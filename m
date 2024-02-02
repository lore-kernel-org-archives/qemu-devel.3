Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40160C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmS7-0001Bc-4C; Fri, 02 Feb 2024 00:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS5-0001BE-OJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:01 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS4-0001fa-Cc
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:01 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bda4bd14e2so1399379b6e.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853059; x=1707457859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl6EjnJRU6kShqd/niIm85pRxEWSBZnxx+3jHXQP+xk=;
 b=f0qm9sxa0ONR3baund09AVANG9wD7i6WtYbb6FskGnYQyvFR9g3961dW6TFDCaGykm
 6R8Z2ikjTWEMcCGd605X9VH1yAfEvEqcQ5zD00831uTR+1VqDIHHlNR45fe1567Euc/t
 +USEKYPSZKBuu8Dy3GKwXpsABZNuZTkHQGkLxKuAegPY/+kfK6HwJh7tnsWtD1J7idCW
 ulGtY8eOhmjF0kqw5eK9kYgQ3GglXDrd5OUJVJAbOcDO6pepNIceFg8s/MFMLvwFcFEH
 iFsft8yxkqI70auiz1UMOQzA4mVeuwf9GCVSG7L5Rnf7TJTtMxCoN+TJ9z9oDIKLaPuJ
 GnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853059; x=1707457859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wl6EjnJRU6kShqd/niIm85pRxEWSBZnxx+3jHXQP+xk=;
 b=ZtOuKFMQzV1IHkBP+96fBtSMwW/HGs6KX9dWe3sNiaW+UYeKA1VukMo+93yjdDM9pl
 CVkz1IYjT1Q+17wUl7KLtHxYYeXN3oyk8S3YC9hdoRzTuEOJLlEPFMMh/1k3bK3LqTIa
 aFrXhItIcNhJTpGbVCF1RXshxxbjk3pISDCECpiGK6T+3RrJzJqAE1ca5+NzgJtPxTet
 UupSVk39eo/eqOI5ExvvJ45DU4PORkD8y0IlsQTX9Ac7lo0Tu6IUKWNfzrB5AtZMB3hN
 aw9H1ULrafqHfKP8dE64aww8lA1nLNOb/3PyeT572fpOr16ygnEDxbricscSKrIK6apL
 4Bxg==
X-Gm-Message-State: AOJu0YwGRl5TaGwTCcgmu3rHhlDcz+sf5l0VsczWE4e7/jPszq2DuODF
 p1OnpnxRD3xaDVXpXgasmXKnXy4unRaSS1LIpIHFjD9HNl0FGtDf8wdTtcn5gI9spFnrqgGiyWQ
 4RNw=
X-Google-Smtp-Source: AGHT+IGeHLjjMeesHXfp/vUe9yHC9Bct8Mm5aPNJhmDsezL2Qlmk//CIjqlL6lP1Np06X6fQ+Go2PQ==
X-Received: by 2002:a05:6808:11ca:b0:3bd:9ab2:fc5a with SMTP id
 p10-20020a05680811ca00b003bd9ab2fc5amr7394076oiv.54.1706853059265; 
 Thu, 01 Feb 2024 21:50:59 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/57] target/cris: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:47 +1000
Message-Id: <20240202055036.684176-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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
 target/cris/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 6349148b65..163fb05d58 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -56,6 +56,11 @@ static bool cris_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+static int cris_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return !!(cpu_env(cs)->pregs[PR_CCS] & U_FLAG);
+}
+
 static void cris_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
@@ -274,6 +279,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
+    cc->mmu_index = cris_cpu_mmu_index;
     cc->dump_state = cris_cpu_dump_state;
     cc->set_pc = cris_cpu_set_pc;
     cc->get_pc = cris_cpu_get_pc;
-- 
2.34.1


