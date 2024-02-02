Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40897C48295
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb4-0000L6-Gb; Fri, 02 Feb 2024 10:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0000KA-M1
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaz-0004Tx-CE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so20019535e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888208; x=1707493008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5StY4SEF1HqNavbZgDZFaGtFNMi7VFPlW6TJWe8PFDk=;
 b=AN3R/cLWeUNdW6G5mioLSQQWObYdw2Ic6Rpe29zIXZNHmIQp++zbGBtf/gXC/gtb2x
 ZV9ldLT+3PGyB1di5HtBUAfz3tM8qOyD0r4Mi7S/6zzolw60yZVf0xUvJzWWQh+UsNO4
 N0dTscO6irzuI5B8AVGBZSJJUAUHSA96vM4fUVsQwFEEsFZmyXwSSJFfbpyOgR+agYBV
 M2JZFDXX5vp/Kjs1L60QnwHZ/ztIEGLfGNUB2BxwogFBiuXmjDT2KqWi+J76ESLpeHvv
 sbqlId2pwI8xHvPCdEGDtbLCZX+wXEHKyk/mqu7foksFdHByozn43txfCprFrwRSEaHB
 n+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888208; x=1707493008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5StY4SEF1HqNavbZgDZFaGtFNMi7VFPlW6TJWe8PFDk=;
 b=aJeatF2/UUlx/0xF8G/dzdPa2Lq7zuzDkPAdlWXXS1suBkY2EwXQo6KEBaHSCToLc6
 Zty72gQFvI7KxhalIZQo2LiaTxlAofZYlZ2ZfsOkXYnv0fKBwkodKRsARyR9d0S+u94z
 VoB8wDTOFIQvPiyJBaXPBdjNYXRpCAtkc/JLsb9A2JPuyHm7Kii5tGgVsptU3+CrjFvc
 vjR4qp0Iz60sAKkt9VFxoISlhc86+VHVRwfhPT+3easfQVQu41BddokRbwY7EWSukq0K
 kAvyxbh3/z6ASlQMlxBH2LIBTlL5vaHIXXctknzVi66uYKdTl2fJiIJBrfpL6+E5eNGv
 G6PA==
X-Gm-Message-State: AOJu0YwNTCQdllQ4prujMjiKhB9eLEOfyxkbMg4I8tbjTaWxIar0xskY
 02x7mJVPPMAmJAtgtiKtqFU6N8hdg7X/HN+iWNw+UT+A243DFnW+zoat3v+C03jQKkV5sgUhz5i
 b
X-Google-Smtp-Source: AGHT+IFRU0u0rGkIS8w66XSJYn1PYq2UtZX64tyTkgSmZprxlX7nPG2MwbWVVnCpEECGT++Uscq3ZA==
X-Received: by 2002:a05:600c:3c88:b0:40e:fce3:3daf with SMTP id
 bg8-20020a05600c3c8800b0040efce33dafmr6802597wmb.19.1706888207980; 
 Fri, 02 Feb 2024 07:36:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/36] hw/arm/vexpress: Check for CPU types in
 machine_run_board_init()
Date: Fri,  2 Feb 2024 15:36:21 +0000
Message-Id: <20240202153637.3710444-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Leverage the common code introduced in commit c9cf636d48 ("machine:
Add a valid_cpu_types property") to check for the single valid CPU
type. Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240129151828.59544-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/vexpress.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f1b45245d5d..1a14c1933e9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -783,22 +783,30 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
 
 static void vexpress_a9_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A9";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a9_daughterboard;
 }
 
 static void vexpress_a15_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A15";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a15_daughterboard;
 
-- 
2.34.1


