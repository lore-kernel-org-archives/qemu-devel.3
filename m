Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE0DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8ts-0002Hl-H0; Wed, 30 Apr 2025 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8to-0002De-VA
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tn-0002gE-CG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so8799013a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025138; x=1746629938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79feuVbSA3OZXSuVa7NrT3EuBCFmbt5HBuWm1ioEXwU=;
 b=SOomiNmiSPtISi8Pm/NNCUl/OaHWwrlc3E8gcJNcx9wIWx8VZoPoj59SpFrdXSp9YW
 w1QipK+yWjlmw/r3ban1gWFdCgTxQhVTgPtuV7Ur4k6Gzu1+FftHwwuQFvRP9DFnvEcu
 4mzoW+ix9a8975T7nSXmlIKM3mRFDZa9ytTVlwKSDUTaGx97XnhGt2Vzk2q11rRoqfNn
 VYX7NDhl6EazbRXb0CNxNq5cGgf9bypT6dkHs/f9vkG4DWA3A9HOtuVKYAsAENGXITd3
 ntzd64+EeArvAWlYW57K8KKeZ4/dV+xqQyzqbrRCTZu67FePfXcT89EoXVExh7NlP35N
 DYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025138; x=1746629938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79feuVbSA3OZXSuVa7NrT3EuBCFmbt5HBuWm1ioEXwU=;
 b=MM0UA1cc4He/IFux5aOCiiSCGs6EgeOibA5yPDl2G8f0FOk8OdD7Hms++HHwsDgP7y
 x2HlC3DERn5UXqxLSw2IgcXcmqi6LJwimMIMtcSItsF45OX5Vml+h8z/i3lXNML7slMu
 ItckpQuycIh1rywyyVs6IvmvZx/zoq7Yi/djii8ZLRhRq/c/eYBjvqbdDi7o/bU12xhC
 a/eXt/K//hmJoee23cX0hCQKX1myFLyfSGJaW+fXh/iXybTHS6bmDrNn66Fi0acTL3l6
 RBVLL8a0K1EuT3CWIfrbJCiFqNA3XsPPWuD0yBQySzVZaVNSnOqFKwhxzhFc00iYCqrG
 qunw==
X-Gm-Message-State: AOJu0YzBjj3xHFXlhUZYczTeYdufrUs1mTrMLtFn4aZqj8jduXO86lZN
 cKzzl0Q8vhTP17S3OwkfH4/T7UVObi8wIFl7kyb/UGnKV8ix4SopkpUp+y56aGJPW79CGEpjIN1
 d
X-Gm-Gg: ASbGncswcR6hiFitHDboU7Q98s5XR/df+5nJG9GI6KGQ7yInnnR1+b9HaLaNO9issoX
 aSNxSScybNXhPQa/dbdlhIJ3s9dxjRJjH4HK4rhsr1e8XgFpm0Ytz0eqwpIj3WpOO2BbFeepUpt
 QspYOndvPd1GIZI1fSlV/jnAaQEgSzMNIPexCe2J+nW28smdhNE8ausnbVPR1iFIE2wX5XTdQQW
 6/IbHO5wiSahaQNarvLFrI6Opujmpj25veH49IqWDqTAEqHfBA2QGqURa23IYFlqihNtF8AbtTU
 wQAIXhbTDf0ye11MZUINy8TN80C264ULXzHQGXxG
X-Google-Smtp-Source: AGHT+IFcPSYMEawhY5AFhMcqnmC1qmJS+McSdrxVpFL+4NerpRE7eHPdIhkyAZPWxp5bRrr56/ggDw==
X-Received: by 2002:a17:90b:3c0b:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-30a332e99e7mr5932263a91.11.1746025137624; 
 Wed, 30 Apr 2025 07:58:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/12] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Wed, 30 Apr 2025 07:58:33 -0700
Message-ID: <20250430145838.1790471-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07f279fec8c..37b11e8866f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


