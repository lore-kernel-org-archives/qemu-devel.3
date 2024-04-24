Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97BAC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5m-0005yK-Km; Wed, 24 Apr 2024 19:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5k-0005wn-PN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:56 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5j-0003gI-Ab
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so1093497a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001514; x=1714606314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTEdbzvaPZ/DA9LDwzi5gJjEqG8BdnHD2TfpPnHz8Cg=;
 b=WtrZRvAR7c8/KLgs/GCQq0vICz6EYMXmPtlum+7ELxOIwNO8p10TZigFK6quMGyOGT
 ukruwTK+s9ItUmwEd4JS9ZT8frxhUbHgJ7F/DpdYa23chCM+SR2y2Eu+S5TNEOyiKGDp
 EMk5qLloSoM6q0Xf45v/rEf3XShCSGg++hanXuITghiilHN5GonTqTywu9elkVLHmcZF
 WQTCIJUwRoSQFsWFFIqUDXq21sX6SDb7yeLaTjKY4un1b64YApyE31zovl9Q9URNlNyD
 wCKkmc8ynhCquyMWc2kZz1OUW2PelYH2DVq4oWkIA+ZcdetafIjbVszyUZGkSGIeo7Eh
 D/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001514; x=1714606314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTEdbzvaPZ/DA9LDwzi5gJjEqG8BdnHD2TfpPnHz8Cg=;
 b=uw/k8AtQpb4JwtCMFqFrvbhbiY23GI7NHMMgXsx/Fy/5j/wn609cZwCrImbgcbhkef
 u9W8jXhGxan8wGIC6zJ74fk13CTZ3jkph1KBRX8B8F+/cp6eP/mD26bGKDMxi1gNwfYl
 YUwXHAxRzatA7wSw/rnJzGrWdlib0zfAF4ttpE435Q/s+MwrNsuHf7vXFy6bJM51jbca
 u3ClJU7hSnyNMdjv5luKnTdLfhM40IrPOakpIFTEVkQ246a2oNmLe0AwKtWLGO2VyyiN
 hoAuikqNmqPKff4bFY4lDXgj/RB+7ZnKqGGD1f8RsU6HJ67c38VUYJNS3QBSC806GRvD
 Z+5Q==
X-Gm-Message-State: AOJu0Ywv/X5b6IHfnOCDqnJfJ3IyLral6GSvm8Qo+JsFh26VvtSZDubx
 0j1ewUHVpQ1bQM2VoO/CRphGchVjLxbAah3FwIwZXHbLoD4qqWaVCyXExuH5JdMjlmrxRjdPOfr
 o
X-Google-Smtp-Source: AGHT+IGhQvUXGLGqZooc7EV5140QBmNuSt+fez1SV1MrIMvhEi0rLFhOl+2DLs7ub28eAQ6qFWczrQ==
X-Received: by 2002:a17:90b:98:b0:2a2:faf4:71da with SMTP id
 bb24-20020a17090b009800b002a2faf471damr1706459pjb.10.1714001514068; 
 Wed, 24 Apr 2024 16:31:54 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/33] target/microblaze: Use translator_ldl
Date: Wed, 24 Apr 2024 16:31:22 -0700
Message-Id: <20240424233131.988727-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 08d98dab07..bac7e30cd1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
@@ -1636,7 +1635,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
+    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.34.1


