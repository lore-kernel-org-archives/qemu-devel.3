Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10167CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ZH-0005vD-1Y; Wed, 29 Oct 2025 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yf-0005Mm-9C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003X5-U5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:55 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so7795266b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753449; x=1762358249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho1xOLvnUOE2rAtG4NNgx7NGGv2rZs1C03ISFU94cQY=;
 b=JDnf2u2BtIhm+pSUvE3Wz3XAYfrhyfMnMnKtf/aCrNTsCC8U22AmViI+yzi5ZYnWXA
 qJWJwKuE67agW6InV2+gZychMG9kPVDEI5Ps4l4jI7yH7L3eHheLdqaG5SjJGzYwAxKK
 mIb+cJggF/tNKw6jKf4yEKDKdwq6+q7SK1Btm3xso43LLwxxtgvc0Fr/IQUJ4ghpivDM
 KnhGxh3nuXGPmNd3C2Hxtr8FwzETlMDEZhDByiw8Ur3his+kNPaakflz6/WUQ0D+aveb
 FdLIScjIq+x+uYlk4E19IF7ZwF8Bb9yi0/G+iWWV2/S/jTby61ih7HvdlNU1Bel+hglZ
 aVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753449; x=1762358249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ho1xOLvnUOE2rAtG4NNgx7NGGv2rZs1C03ISFU94cQY=;
 b=Fw/OSNqudU8koJBemZpPAIKUAQjrebIw1yz1tHFh8cjofq18lnl/UuV1ABxqpRnZvq
 sSR937AFbw3LoAVDOc4VtYpzm5g4mqHnS45LpJZ5hRIVeA2KG9ZX+O+OUMkl7anqYwvC
 HmnMooy5tPzjDS+1yZ79m/748/ewik4epggWbqBCDoHHB0pM+1o3unyqsCYq6avW8lz9
 U2oEmcimY6gDM+jqa7fmBACWL76zLy7ae8IiV7WRfE9PQuNlbvBrJnwJtf2m63FnwwUB
 bfcz4O89Dq+WySxAzDihCp9dfOMNukbW+Mo90jWiHlJg+MvsbI7rQ7vR1kNP3i2sqdHE
 sARA==
X-Gm-Message-State: AOJu0YwwhVansX37AnxbPbp+j4yHwX3bG8BC9Q++wW396PKAMQRCBWmj
 VaGzHdv883EcHcW4qQk7TRbcyWV+FvYCvXTMqOaGaBCtd9geeBd64+fnFawGtOBD3SE=
X-Gm-Gg: ASbGncseM9jSV3jBFsZ0Esm5wiCWXJyEni/Zhz/EGiz+gXZvSNxQTliBVW0mLoBgs8G
 KlHZhx/KFYQDmkgnmNJ1syR+297M2uS7+osA6d1BvSyiCpGqfjPeXV2pr5UqiGZstcDsWbMF6kC
 EEq8QS1KJ9KoNEtK2qSR+awPokuP6UpHhd74TNVCnrGV6lVuDFf1ECJvpgmMmrs7xNCF7fijMCu
 uYf4g8zHqlrZOiz72eqmNngYBXVhithiSRkMdoQ5Msmmhg4vNL55wbJJEHML408tPU0TXJh+a+P
 oKzTaPhRNOGLksFUCF+GbGMzSHJgLP0IsFvl7Bx8Bet7TPBzY5bRDO7gMBmrnRNeMlbACMYyjGI
 VoUazagcBdIlrGTyvTYuJqTyDPPRQ49VIr94DFECeXOrIvUDHVybFV+1UokI4PzSUQ4EBC2j/lL
 zr
X-Google-Smtp-Source: AGHT+IFqlCMGlEgviwc8U0M+EKB/vdZRqFt9uG9JK9q4jw5HEyW/eQbBUiVtJTbVN6mxsQ7i9neDjg==
X-Received: by 2002:a17:906:fd87:b0:b4f:e357:78f8 with SMTP id
 a640c23a62f3a-b703d5c70bamr352665666b.52.1761753448905; 
 Wed, 29 Oct 2025 08:57:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541fc31sm1458507366b.60.2025.10.29.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8610B5F929;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 17/35] target/m68k: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:26 +0000
Message-ID: <20251029155045.257802-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Motorola 68000 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-18-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af84..e9c20a8e032 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 
@@ -183,6 +184,21 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    case EXCP_SEMIHOSTING:
+        qemu_plugin_vcpu_hostcall_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+        break;
+    }
+}
+
 static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = env_cpu(env);
@@ -203,6 +219,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             return;
         case EXCP_SEMIHOSTING:
             do_m68k_semihosting(env, env->dregs[0]);
+            qemu_plugin_vcpu_hostcall_cb(cs, retaddr);
             return;
         }
     }
@@ -239,6 +256,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, retaddr);
 }
 
 static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
@@ -277,6 +296,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     uint32_t sp;
     uint32_t vector;
     uint16_t sr, oldsr;
+    uint64_t last_pc = env->pc;
 
     if (!is_hw) {
         switch (cs->exception_index) {
@@ -417,6 +437,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
-- 
2.47.3


