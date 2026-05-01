Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1AFCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuQ-00047B-5y; Fri, 01 May 2026 06:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuJ-00042y-C6
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuH-0000FA-Ml
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso21250545e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630536; x=1778235336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0V88ZatR1lmUbDKzZHFEAjN9VwU8JnhgBh76WZWQXeA=;
 b=Qiniast3dXqeeeH3qdR5d1ZwTVtFg8I/a5wC2WXY3dlbp8IyEa6yVO2KNyipFRv7bQ
 JvyjgcwDGqZdMAwV06EfywabXuD13bh8KyGx4x6/UXan/CHv3jEkqjEp2YBr9nXZqLnr
 FdioDthAlCejkkAkn88RLIHGp/CnAiCtJLzvLGIBRk5ynADkU2HknRTWlzGjVs4DTO+U
 YrSYQXJxnUhPv9xcdYFO7nzdm3qoKkq5qLTSHk+ltH1CUtWyqCU0/pngAUtpY3TSd7nV
 +HqPrFZQqhMCo4WPlnkhNjojQVK9KUPZ5oMLoX8T2yq70RrFs4Cf1Retp0b3V5I7tocE
 AmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630536; x=1778235336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0V88ZatR1lmUbDKzZHFEAjN9VwU8JnhgBh76WZWQXeA=;
 b=pRE2u/gMMXyAAVIiAAyzIuvbcHD45GmILHujpcTXgY13aJMiFXdUYg5PysurRn1HzY
 Zgh2E8uIijhKqejQDzEzNntTBU1BdK5iPodWHvK1qdpKbPK8aESn0vmZEQ6j8Ypox6ju
 mAniPwgcQcaD0EMrw5NQKoXfMfADeKj+cN4YfTyBolHCtcvEW/6gJUAPmEB0VI29IBE6
 oRIXq5kAmlISCgg8iDxt8YZ4YtcQ0lkESTlBB3FQD9s4CfeMLMdWpSlCUmFV3K+FBoVS
 cNF/agOG7WjUZse0xS2k57PKOxpTa31uxpZWBCGLhSlEu5iUXA2kJDLSaZZpIujXXMZC
 R+ww==
X-Gm-Message-State: AOJu0YxEP89dWDUP/XtViTxv5ijCvBzqIyQvXAJQ7392STIhvEUOrA+7
 KK8dwERzvLxsBDlbW/bnxpj5Azm9LjlpTBoDII2e10ZNIN9RYB6WI+rNdWUHYK1LMgG7t9h0vWP
 pwwj9
X-Gm-Gg: AeBDietFWhKGxXCvUh9kKimGXSV1U82bN0uVAsMb3LZFow13XU7bSsdy+7fQBrcOLv2
 sMARzZkTnGTqzwIjzaIx6cX0HTbhFVPCc88zyUQaU7lixmJr0exOMCbcX5JSZ7gMEdaYlHrDOhK
 lqiR7xQmSIgNhF5+37SpctL+iJkYYyBiJZ3Kkd1FP5KeXiJtfYGBtW0I/PRnEkHDhpFbhzOkou5
 0KTmIXKCpaEu5EivDuIqm/dVC63xKtSu1lY1YaKAf3proo/yDmG/wsOhCGGkDJxCE91LrqW4qYA
 RSpH3ZAEVFHzcm0z2HE8irD3mNZr5pWRkTAMISUwwnKfFKAZOhvK2yFxnq7RqXfWeBxkSfLfkww
 9eBaY6d24+a9lDV8WTmPLoppW97g0Q7CDUBocHOwr5rlNZdOyRscUbJISzLJT85GD1HzAljD+9h
 l7HHZEumk8bP7iaUFuCnIXZGt/M6kTTZRPL/Y3rWDdDRswIiX9wQss8lUyXu2GaqxMn7TQvRbH3
 NZEtl5NcCXP9Q6pW0wFSBDnVHddbJpEVURqJmNfGCP1j/c4KcH6
X-Received: by 2002:a05:600c:354d:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-48a8445e8bcmr105631535e9.28.1777630536211; 
 Fri, 01 May 2026 03:15:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/28] target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
Date: Fri,  1 May 2026 11:15:01 +0100
Message-ID: <20260501101505.3485916-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-12-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ecfe06cd8c..1894be6b0e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -296,6 +296,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1719,6 +1723,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -2007,6 +2019,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.43.0


