Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D04C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLS-0003Ov-Hs; Fri, 04 Jul 2025 10:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIG-00056d-BH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:39 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIC-0005fj-Mc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:34 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso744686fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638891; x=1752243691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0c51w8AYDL/49JMSyoGkHo6/JBfxrEamVE7ZAljwTg=;
 b=fW7uRizWLaDJlnTNXz04RxOj39Divnr4cL35vHjustIaEiXmKY24mPK/iPGfT3Uqcy
 WWbYQ2Hgsjwbhm/KUIPJDlq9SmAP0M8d73g//2y/DMY8vq9HSYOyq53tAnwZo7Z+m62z
 a4afp5jZelR8MtAV93+KwnW+RFFyxvjhW1w6r0KGMT0k+QKVx6rzeNO5rEbqCPODSlaF
 D5Ft8BLRq+/yrA1dR7nR+SxooJfI+fiWd9xl11Xtyj1ijCiilF8XDmyCOT5LZUn6sOkk
 LUh3Sk5Cyvg7pvuO5qzEsN61RC0nH0RMrIjnk8G0lHjQAWY8kAH2Io2jDU5gl0F70MX3
 clZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638891; x=1752243691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0c51w8AYDL/49JMSyoGkHo6/JBfxrEamVE7ZAljwTg=;
 b=tJG6LxydEyiuBMWSISQ4iWf+yucbRV8SsvNJNsECYF6B4TEMeklTA5iOPXV2Wmiwy6
 W7FdEgbegELKmS+2vVEvFFsmkpNuBlDR9NkSutFeKW2K46ML8H//N2elx0ybPfajATNA
 ADXAICTpuCBcutk1Rv7xM4RZIFBllYz8czmy1qpUJCIDdgV9FuoHfOgrYNpcuDqpRBvg
 LEokXVX1wvJSHk3emlIcipN66VOt39C0xY4VgdjXqlfFvJd2cL7sU0S3Ec8NoPMU4ou3
 k9I8PoJXWH8Qj2FU87tVkZN7LtyAiEBN7bYi2NDjec6nr5d9s/1EEpVJfxn8wRwGvIs7
 lfOA==
X-Gm-Message-State: AOJu0YwU82p0VB62/QIYTAb0/Oc5Wr7rPuzx1wAHqK2gDkTZADLRe/Wu
 Tyq9/rZQv9xXctzuXXafosNU5pm4HSJpWyRoG21C0BUAup6pYBRi+BnfCvbXjlTEK2r1rY0XM6P
 MGJA4nJg=
X-Gm-Gg: ASbGncszuCMJCerVcMgouJkrIaj2Kwe54D+H28M+wR9HwCgG4rCYx/pOAIGu4BKu2FW
 vjAYf0F2LDgwZqJHuci5o4pmFmHfO20IQ0v5KTGF/i45edc14nIm5+5wYKat5nX7QB5SFanthzd
 vAU19neeBUYbL0A9Fu5+6bitUKFW/LSBsePVun594FbiUrWpzGZS1yy6kW4zuUvmJmRmxkvszqz
 dsfW1k8BdleQN7Vr1FxOnCKeV9SxA2GrbCVyTlbcH1bC1X1+TfL9OwOQbPxLNKOS5QO78qA0Q1u
 qF2Gd9cOveHwi2uVjpKQ/cc4VG0lPrL8eAZb+/60ZSkwD5E1GTA1lFyAyBqYfgN5QeIfkn8M2Zr
 6VTe+akjdIJKRjbMIJPqQ9J8nIrPBFAtyeFSEdUB+rnW8JE9k
X-Google-Smtp-Source: AGHT+IEoN8nvP7Q8uZI/Y+augkC21gEoiSX56lbXoApTmbbJ/2JtUmmpcWJbXKyIpD+pbTsWZrY6ZA==
X-Received: by 2002:a05:6871:e026:b0:296:a67c:d239 with SMTP id
 586e51a60fabf-2f796c0a276mr1688684fac.12.1751638891473; 
 Fri, 04 Jul 2025 07:21:31 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 015/108] target/arm: Add ZT0
Date: Fri,  4 Jul 2025 08:19:38 -0600
Message-ID: <20250704142112.1018902-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

This is a 512-bit array introduced with SME2.
Save it only when ZA is in use.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/machine.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6041a9357..cbc2043483 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -716,6 +716,9 @@ typedef struct CPUArchState {
     uint64_t scxtnum_el[4];
 
     struct {
+        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
+        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
+
         /*
          * SME ZA storage -- 256 x 256 byte array, with bytes in host
          * word order, as we do with vfp.zregs[].  This corresponds to
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6e73368ef9..6986915bee 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -321,6 +321,25 @@ static const VMStateDescription vmstate_za = {
     }
 };
 
+static bool zt0_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
+}
+
+static const VMStateDescription vmstate_zt0 = {
+    .name = "cpu/zt0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = zt0_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
+                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool serror_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1096,6 +1115,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m_security,
         &vmstate_sve,
         &vmstate_za,
+        &vmstate_zt0,
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.43.0


