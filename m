Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF9C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kri-0005ov-Jt; Wed, 23 Apr 2025 20:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015k-TP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqK-0004l3-6P
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so345145b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456010; x=1746060810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVGDH0zXbPh1XWGLwpF7fHPSsEZ5O5FckAiSLdeKleA=;
 b=K2RIYbuMnu91NGDuNV1a39SXLBmveAsOhQgEHEvB+GRnrymGI+z1l9fiaT52S0NIHz
 QlMMO8wGh1797TpusMzq+tE1fBry3Z3LFCbGrI0TV13zi4t1u8uGvOwSywDeNKTG05mg
 NRWH3WXQJocbAAKFehNYyVXhYOEGO9Gzy5NpAQCNngHq+uNAEOCIW64YY/yUocKd1xx2
 UIl8axd4lF0O+6rC9zUS7bs6i+W3kze6kYbgKby+xVYp6NnbxIRE0zDvEHmQL7TCNYjL
 DEAo7C9zmZAQ6bgO2ximbjTiRr0JhltKdTGz8VDZQpbrA33vHRHg/Y48XSE6llTh/qMf
 /tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456010; x=1746060810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVGDH0zXbPh1XWGLwpF7fHPSsEZ5O5FckAiSLdeKleA=;
 b=DdT08D2/yRdQRfmeIZZnWe8zBXJkw8EfVkZhZZ+7ovCnakKsHiEszRuSkxaXZ7+P/q
 3+EYGwyRkKBsNvf6n/piE6zOJbUIE+NEwerR9GH6aMaeYzBOhZgIJhrQkZhtmoLxPbnl
 7Tw4jwp68r1cZWo9/3rLMhBcU4Nf8b7M0JvINz4kBGEex6AWIu63A1M1HPZuoDztEM4+
 zDVZnDYrbgkwa5hXc9fU8C4UmcGAFEsLsUqmVxMy7X6X0miMi372vGlw9zTzLztkJNQs
 2qWwx0g93VAiHCeFP3ZOAtib4uCw2C5v5PvznivscqAN8pfUyK2V398QAdZouNbE2ACk
 PgeA==
X-Gm-Message-State: AOJu0YzObD0pZ0UaJvAHVD4Cx584whmH594S1XT1Cutr6+Z0m0YZU1h2
 LRayj+iEFxiUfKoSbA6z30C/dx6tLqqzthyagt9k2KjVSpr/QS2782iOclEIw8lZoTHJTLp1PMm
 p
X-Gm-Gg: ASbGncvMC79vUC7Tz9aB9wwNpu20oWSAlHMqIYrTP0ID1UKs5wuEZIGJiNGgj5OWpHD
 3LEoDgAqWouw7EFLeFFe05gWCtHGjJzNCsP6+YMD1d3ELBQnbD3bhFJEEu5jfpRchgagPuHUoIZ
 iis5ErMBVu3yQ3fEuOFGU7L2ZBwRrj1BELZG5jMXb+XdqHhBT/Cuulz2DaYMO516JOALeXLDnsK
 /stCTQjkeuOxmt11Xgk7CQ6RI45+HB9pQ82HnYbS6uWphaC6zm7GQ1gL4YGvfhc7P7o5slSGaHn
 o4mr1jIRcXnOVsQRREVcxtXhVa1T1m/BoQ3iJME7nkTg9CrPxl1WQlp2H6vTSFraJjHwuf/eeeo
 =
X-Google-Smtp-Source: AGHT+IFHcq6SfYNiF8ZGCvH/3/xq/ZSR9GVqZgrGqCJlrgfLGm4qE9JDVfppBmqmSdbYx9MWX0cYNw==
X-Received: by 2002:a05:6a00:aa89:b0:736:5438:ccc with SMTP id
 d2e1a72fcca58-73e245f91ffmr1030456b3a.9.1745456010197; 
 Wed, 23 Apr 2025 17:53:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 074/148] target/alpha: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:19 -0700
Message-ID: <20250424004934.598783-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-4-philmd@linaro.org>
---
 target/alpha/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 584c2aa76b..56c96b1c4d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -238,6 +238,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
+    .mmu_index = alpha_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
@@ -262,7 +263,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.43.0


