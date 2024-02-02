Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AC0C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSh-0001PU-Gh; Fri, 02 Feb 2024 00:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSX-0001Hg-Lk
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:29 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSV-0001qg-Vm
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:29 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ddd19552e6so1100649b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853086; x=1707457886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m31ykn6MQscxmLhUVwK1jeDu4gpHyJfjJcp6vG3u6hA=;
 b=oAyJCs97KNVVxOzeCmVtNNAW+mswAaravTr5f9wLKEhq0tJOUPihMf38Hm91LDS6Hs
 SVLoSWkX2G7S1aU+ifVhpFvIgP2+gkIUnUalXWrqB/At0NuPoFSqgRnXzosNqtQsUxgF
 t204ztPPiZWcAQnerlZWuE48DPRnvYd974rafTzm8G16ArEMFovHMkEtG73AlgF04ISU
 fdN4mMz/smV1dG2a7opPOUopV/j9Lc/OAmNwvHDVdg8eBhPLUlLUvXpZ5u7+vXzC8dZ4
 CRM8RGXLTIE+rveAP7DUpGkiyOdlQ9T5d8yqQ0H3t4tHGxrdbgmeMTa27aoZfp0lBDlr
 XBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853086; x=1707457886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m31ykn6MQscxmLhUVwK1jeDu4gpHyJfjJcp6vG3u6hA=;
 b=qyPJW3vtBua7dtcbOW4wfYMwGbRkYUpV6Kv/plp/YvtEq/bvDkYTAroWi4wcJ9hhFx
 4+J963hjOZY+C6+owFNzUJSxKRnGsPxY2JzaAg8TL83IFdgtI+U7IbRBd/INRqAMCnDo
 idgGdVgljXNL8qLMZM2pq/GrdVcHKLm/cLIt6KjENJ9axxSP5bYBiYeMRKdmqAY1bd0g
 1W2pWvBa1zO6iZmQqge6d5E6TPC4v5tbCrvGMmd6/4FxzXOSeIpxfmhQ3rED/44VbJ2X
 IllyxwA0bWld2IyiOV4K9dYaecimSZlXH/EBG/55L+bQppxJy/Nh/XaoTlqUWWzsO6W8
 kpfg==
X-Gm-Message-State: AOJu0Yzlc5su6GBzv1N/M0afZ8sknBfjXds+ybvCWnIDIb/h4olcqB87
 sON8wrxnsuXzOfuHVgEO/kR8UUiJW9WubkxkLbuvlSJCcjvh+FHIwEYfpQ8KdK/ewo9UQmBFwry
 pVhc=
X-Google-Smtp-Source: AGHT+IGDuuz9iaP2Rrpdtqzgp5CYQHJKzzNu8ZXWRPPt8cdSUn0AjDSoXjnJgPm71vAUv4AbNsAWYQ==
X-Received: by 2002:aa7:8895:0:b0:6dd:8891:c4 with SMTP id
 z21-20020aa78895000000b006dd889100c4mr8852354pfe.25.1706853086620; 
 Thu, 01 Feb 2024 21:51:26 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/57] target/ppc: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:00 +1000
Message-Id: <20240202055036.684176-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/ppc/cpu_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 86c8031765..9931372a08 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7105,6 +7105,11 @@ static bool ppc_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ppc_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void ppc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
@@ -7372,6 +7377,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = ppc_cpu_class_by_name;
     cc->has_work = ppc_cpu_has_work;
+    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.34.1


