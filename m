Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A2CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJ7-00022G-N0; Tue, 14 Oct 2025 16:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ2-000218-G0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIr-0005K5-CY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:35 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-271d1305ad7so91248735ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472442; x=1761077242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1lTFXn6uKuCiyCV0s/y9SEm5jCxZH9j54VQidGTnOE=;
 b=clv/snpUmw92lG6VX1H7vED5jSjGT1uZGgfRAY/ch9YYcu/sKydyvLFl/+O6BQ770+
 RYUQJFzBA5EDcn38k5Yf0I+jFBDKY7u9ml4LbKJZINeEoq8e6LqMlX76bYctrxG+7iCs
 LVDA1C311n14osUblOs66EqgF5dCsrMSstEjpnvx12KyXbs8MFso6YxLeZ4avdxSehMS
 Azxv7cc+nKwt/0uJaFazGnwJY2d5t5n2wFFlOhSuMVBAs+UQLfK510jNlrv7aO60fmzy
 xsEm2uPHoqK1Xjgz0weqqHgc7I5UnvC+BH36BZsdJqGuXb4Ove1szSClYOcH2DVnS0Rh
 6NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472442; x=1761077242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1lTFXn6uKuCiyCV0s/y9SEm5jCxZH9j54VQidGTnOE=;
 b=qKunjxMgfPmKa+wyAYp7EmU2eYF03bW+lDRnt0YSP5TBENin39+obAzAsJ/f8LBoXJ
 CBbL23Q+xEDbzVFv2ftLPZbXZLxja6YbDHCHT/zbfmgwYII09v+BGjBYPdIsehDq6/w2
 c+zubhIsxYc8sZKeew/0vx9IH6BGwXukNw8dFUipkzUjrxmlnzzTVwAFKY6hELYvx357
 JwV60HwqQye5xwuF6TXWWTTjgOg8UVSTeNGolKWt9DVpaYvnbAR919XynWgfKFdhsdPh
 9Og++krsDX6ixObc5XPsY0URQzOvsZatE5t/t3FPpm3vDFUlafcTY0ZVJ4oK15XvkIF5
 OL+w==
X-Gm-Message-State: AOJu0YzsWYLkn0ACqpwpRpZ63oggHcyzHfedZh5m4Ze80Zy7YB9TiG0x
 +9wpWtS4tsq1ICFnjtH0VGSduE0b0I9KXQ1f5TEaZ9+eqLIlRbNKzhLqdji+DW456Q6GTmYw5cm
 SWWolnJ4=
X-Gm-Gg: ASbGncvM6lFsse8vpI7dplfR8qPDZCk54EWrXnbq7pOPIniIDce0co4wLNFxcHuSf7b
 vQfO/089QZWvsPm9sQP4fMJ809NrXwPAC5K0mc1VmUkJhIbR+CoT3Ffcxe+GrSKxIoDRwihxYZR
 p6WU5ZMCbpxWzyEGoW0BI+R+OUPP5ATc0I2jY1YNc7nR0Z7yfaO9KNUXEIC517pn6X8pzHrK9rI
 L7pQ2ftXsQ+P8xb/FRcq7NXC2BWQYe9WUcBN2YS9DcJ3ygU39Riko1Ruhd30SCdXcQekFRQgye9
 INJgjoDSr+DZjBm69O4is08F0obbMNXGBMPgRaS09lLTKHRPoHCzYcjSPNbfl309wELDRR6ht++
 NNIEgUjOjqPRxjKIE0KUtnA/MscS4olZD6i9T45REHiDlw9Lopzv3JLZP7u1ySw==
X-Google-Smtp-Source: AGHT+IHAu5TFFyFx1nMwVkb1PXZIOMOpGle0COxxdWE7E6K1YFCbxJa3M8xJ8WIMzN2izlLCMsfW8g==
X-Received: by 2002:a17:903:19c5:b0:27e:f07c:8413 with SMTP id
 d9443c01a7336-29027356911mr278840405ad.9.1760472442010; 
 Tue, 14 Oct 2025 13:07:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/37] target/arm: Asserts for ARM_CP_128BIT in
 define_one_arm_cp_reg
Date: Tue, 14 Oct 2025 13:06:45 -0700
Message-ID: <20251014200718.422022-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

128-bit registers are aarch64 only; disallow non-zero reset values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c0b8889db..3b06704963 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7805,6 +7805,22 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
     /* AArch32 64-bit registers have only CRm and Opc1 fields. */
     assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
+    if (r->type & ARM_CP_128BIT) {
+        /*
+         * Only AArch64 regs are 128-bit.  There is usually an AArch32 64-bit
+         * register aliasing the low half, which must be defined separately due
+         * to encoding conflicts above.
+         */
+        assert(r->state == ARM_CP_STATE_AA64);
+        /*
+         * All 128-bit regs are UNKNOWN at reset, so there's no need
+         * for either resetvalue or resetfn.  For those EL2 registers
+         * that become CONST RES0 for EL3 with EL2 disabled, we allow
+         * ARM_CP_CONST, but only with value 0.
+         */
+        assert(r->resetvalue == 0);
+        assert(r->resetfn == NULL);
+    }
     /* op0 only exists in the AArch64 encodings */
     assert(r->state != ARM_CP_STATE_AA32 || r->opc0 == 0);
 
-- 
2.43.0


