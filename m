Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16BCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmbf-000672-03; Wed, 24 Apr 2024 20:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmb7-0005Jd-W5
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmaw-0007ue-1F
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so4009705ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003448; x=1714608248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=pMqXt2EIg+My+S0q42+uYmZ+cUJBMtM22sKVVCDDOFwSHcv24Kx9Ibn+/dALcrC2MC
 gG2hiwvnCIc3mAILeqPH+w+6bdtIaf0I4CIH9AnZSpZNWTRj9fx/aoLn35TeLx5lpAF1
 qtGJK/rsWf3ew9hq9ZuelQ02i+CkhrvEoK2wL+2SrIdhFX7TA+WMdbHeN8t7x+RqpQdZ
 kC91ZEP6sDagvI+XZJwAlQXhhVXU35qb9Bsx+TDTxEn8qz51gG+LGADTZU+1q+97zaF3
 U8KPaSRzhijU/fqcoCE66be0l3pRNzV+Ona58PZBofVZ+sVYVDb7jiCT3R58o3SXz1xd
 nYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003448; x=1714608248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=T/BCpk34I1y7gJrAjNlmsrRsYf3+G5bm5C3+cXrYUcZrzjx/WtQL/zRhexf6jdt1E9
 Qi5fhoZVD6m3+TKIG7nkvU0VEpdRqoRZCLt5ji9RhSDQcbuRNSkeZwIx8YJ/U4NsEazs
 Ll+W0xn586dn5eSXOjtm9LM66UJl84mPN3e6Gfx1QuFh53xMDLlGpyBTYmUWXM4yZxty
 +wTwFHWK3Bpixv51FdTeogp5CaeWDdsC70uCheFsiqqkmYwkXpInNkzTaWTLB6Sbo9My
 N6Pn+rcLAWJzt/MqKcU9GQnyOsusLLMuCfQC2o0t8tHxInvkn3lBJjXflU36Exb2l/hk
 bxtw==
X-Gm-Message-State: AOJu0Yw45bMa/nnOmJmAWs4GxAL2mt++gJ9C6HZiexzdgMtAtb9OWdPy
 uu9/4O2xexzpAcwFGfVBF37Rwak+0J2d3C7VaFyQUx3ioIVvSmg8Nw0X6BaD24BWFk9gLblVlXN
 4
X-Google-Smtp-Source: AGHT+IHPzEB8gO3zzYGmEHlUxgJkxzW07d6Mi5kXyJloLWNc3ioMEZayyF04iISmdFkpB0cSJiTGEA==
X-Received: by 2002:a17:902:cf12:b0:1e5:11ac:a283 with SMTP id
 i18-20020a170902cf1200b001e511aca283mr5418959plg.9.1714003448453; 
 Wed, 24 Apr 2024 17:04:08 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm12483717plb.296.2024.04.24.17.04.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/45] target/hppa: Log cpu state on return-from-interrupt
Date: Wed, 24 Apr 2024 17:00:23 -0700
Message-Id: <20240425000023.1002026-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Inverse of the logging on taking an interrupt.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/sys_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 22d6c89964..9b43b556fd 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -93,6 +94,17 @@ void HELPER(rfi)(CPUHPPAState *env)
     env->iaoq_b = env->cr_back[1];
     env->iasq_f = (env->cr[CR_IIASQ] << 32) & ~(env->iaoq_f & mask);
     env->iasq_b = (env->cr_back[0] << 32) & ~(env->iaoq_b & mask);
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            CPUState *cs = env_cpu(env);
+
+            fprintf(logfile, "RFI: cpu %d\n", cs->cpu_index);
+            hppa_cpu_dump_state(cs, logfile, 0);
+            qemu_log_unlock(logfile);
+        }
+    }
 }
 
 static void getshadowregs(CPUHPPAState *env)
-- 
2.34.1


