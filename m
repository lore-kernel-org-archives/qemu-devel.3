Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E793C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6E-0004Cn-Vc; Fri, 20 Jun 2025 18:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfc3-00081w-Km
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfc2-0006em-3Q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450dd065828so15681535e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440792; x=1751045592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5426YMMlpheSh4FU6UOd+lkxpX6kErFBSOpvyVvgmM=;
 b=V9S7yQ+rwSb+oAXIFfhi6tFQj4LvX3n86xIVadkaYzvz58NwhDUi02m3z4AA8og7gR
 bsYO4OnyC/pl5jwo6XK+dyoE7jmKFNPw3dl8mg3ROsjECD+7tukOmY4r/ZTKTeOupV9W
 BfwxUcJ4bfzmua3spFB/2htaP00Kkvbeizx/xF946vTtGAQpYuT45EsRo6hfAZNjV0QO
 5LV6TwswzZOy/jx0X2u3eMwpwWoXa6yoXxzsiYghpNWihYkIIOJAb+5pJ//t7RgmJWeE
 EaLavCazbVBa0TiRJp2XLFC1XWjhIV8vVZ/10u1CYmZly4s8KZHcMoBj+Dgbvi9/DISt
 vz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440792; x=1751045592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5426YMMlpheSh4FU6UOd+lkxpX6kErFBSOpvyVvgmM=;
 b=gkVbMGM5F66tXbzLByVhspq2foUVlBXoYmD0teQcnTAHU2Pq1vMhSf6CCLFoO5NylD
 J+XQrK3DTSbHeFEvgMRch1BJjpY3DRFniimqBcR/t6QAjKiNNA+Ocdb4LuVU/2apn9jx
 ZGR7dwagA/GV2cRa7DcJDDwGnY8yjyHj1+M1Zyo18iDyFX6AbwIdsvJ3ODzDRN04iu90
 tDnLk1893mK2PGdKB89iDmKdOSZjkBmNgDq/qPmdJh5aqrgvmaWvdUMO0mr/drXyxoW9
 dp0jdpgbDFMjbb4YaMTfH/QrkH/KKWxseum+Os6Eko/W9kIV+D/gTxjxVIhvWovtpOk5
 8auw==
X-Gm-Message-State: AOJu0Yz+eed76EF+2+VFV131KqQTlHEbQ9PScFvdP9b42KLyzB2xjvUa
 SRqTdOH7UyzMW6b955qIoBCgn1v9OwTRb1qAY8jrfWXJJb6AVZNabNnzlxagO+uVnvjJI/8FZPY
 Ig8rMvMAj5Q==
X-Gm-Gg: ASbGnctu8e/MpJ3tfwslnOmS5GZfKHLi93yYmOD4u1+rEb3iTIEjxw6bya6kLV39S4n
 WH0f1gUAuNUrhanNCynxD7OH+Ut962TKADetfg03zqH3e38q9dk7Wuzk9HNwR7hJ3WLt+CsJzv3
 7Q5bhA0z4JRqctwhA7vebFi+/KXAlwGZFUowUFaSPgUUvTq0OV0Ki0wUIGZ5Ml6jjcrfCAFGNfQ
 3nJB2IhKi44vcA+Y7aMhyWACjRRHFdH6pLezAXnkqtCOfs8Ky/FJumPFOhSm2NZM06HsnmchjXR
 D0FunYFq96lIS/yxXtUF5rf+dsnodo+PUrBSv0FSy8qVRimpKQwST4APMUN9uWEDCDmmPpNZsvH
 9B0uOhOrCz4rioeACU72BSG2gZxheGonILeZgND6daGOAf/HnVTsM9DU0
X-Google-Smtp-Source: AGHT+IHKan2VYxrVqiAyn2BBoZo+cirWMGMpaQj4jmSKGCvZQW6mIB2lxw0K+RhfxntU9tewZeIkdQ==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f90c:31e3 with SMTP id
 ffacd0b85a97d-3a6d12d7abdmr3236742f8f.31.1750440791974; 
 Fri, 20 Jun 2025 10:33:11 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10502sm2671566f8f.18.2025.06.20.10.33.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 37/42] accel/hvf: Emulate HVC at EL2
Date: Fri, 20 Jun 2025 19:27:45 +0200
Message-ID: <20250620172751.94231-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3907ea8791e..a4f823f834d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -17,6 +17,7 @@
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "system/hw_accel.h"
+#include "system/tcg.h"
 #include "hvf_arm.h"
 #include "cpregs.h"
 
@@ -1117,6 +1118,8 @@ static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
     env->exception.syndrome = syndrome;
 
     arm_cpu_do_interrupt(cpu);
+    cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
+    cpu->exception_index = -1;
 }
 
 static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
@@ -2090,6 +2093,9 @@ int hvf_vcpu_exec(CPUState *cpu)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
+        } else if (tcg_enabled()) {
+            /* FIXME check we are called from EL1 (so EL0 -> UDEF) ? */
+            hvf_raise_exception(cpu, EXCP_HVC, syn_aa64_hvc(0), 2);
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
-- 
2.49.0


