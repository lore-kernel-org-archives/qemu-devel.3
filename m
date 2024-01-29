Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE8C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb65-0005cR-Al; Mon, 29 Jan 2024 18:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5p-0005Sl-Gp
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:17 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5o-00051w-0y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d74045c463so17491895ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571066; x=1707175866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DGeNqrAocEQBW3s9u83YvGPr3pag37tdDcMnd/na+Q=;
 b=UA6D7EO5jXR4QP8vGpycYMlJv+UYl4IzVMN2HB7ELXtmiaTtlTaOnJP+G0WPGOoqSo
 n/igXfzq2ZhxTL7toyVwIyTfQ9WxTGUvB05OiSHmVv9KDgTMQjrhQqflt9PlfOt8HgnI
 +pS5vlISP9ufDjQhFOv7PgrH38keO8H2GUrUJ7zNjI/gs99HXPKMEoUNsQGzT6cHFqZY
 O/VW2HoO892bufSVOzkxVxah+3CB25Em/0hMYsaJgoblyWUdWj0Qy4WrEqPbkjKqnGx6
 /JMrqzPo1qjj8rLRcReCGzbpoEBRLgUfiso8Sl6LDu7RqzIqtCBwrNPsrkF2h7TLQoTR
 iO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571066; x=1707175866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DGeNqrAocEQBW3s9u83YvGPr3pag37tdDcMnd/na+Q=;
 b=XWQTtrfY790ZywybrRUwB4LHwSTeaFUiLJmhhLfUxio8NEg5g+Ge/Ua4fR2Wo/l55b
 lvvO6V2wXUI8DpnTcPLW4I89Rf2HLwbAIa7Y0NU68p06RXWwYcmbf6PjtHvuBnCr0dLO
 MavIguTDsT9CIkTUsdexWQw/PudgNlhSY7j4HKK9KzpKEZP3ZdIMTy1XMeRG54zr5fTh
 6jL7F+baLniAqAjz5Y28OlXOCkUpiOxY9WrEqVnvrPCzQYFOREech1aZBmL07LRO+/4T
 59n8U8ba4KMRssWEKo1KIaU1LfW3c8MN+lkJLpcVK8ECDC2PFnDDmHK3xu/WUL8qJnCI
 Ww6A==
X-Gm-Message-State: AOJu0Yx6+LZs1bscl6ZUIQ76vYtQcp8i1JekiEmymiJTSjPvwKrs3QfE
 vUvAMyr4ApLPV65nTEFL54/+03H2DFmsWnGaK/gTcNCI+napzQ/6soasuO/qLYVLHsDR2QxG9rf
 5ZuM=
X-Google-Smtp-Source: AGHT+IFolqqLKjKl90ShxfQPNRzkcgQF4TVKPn9szr+T7VPCdxTLmobQvXlJggZHWjne/7HzwAYrEA==
X-Received: by 2002:a17:902:e548:b0:1d4:4467:97dc with SMTP id
 n8-20020a170902e54800b001d4446797dcmr4328746plf.6.1706571066295; 
 Mon, 29 Jan 2024 15:31:06 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 08/33] target/cris: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:18 +1000
Message-Id: <20240129233043.34558-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


