Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CF9F99344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtX-0006Lt-VR; Thu, 23 Apr 2026 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtV-0006LD-1h
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtT-00021m-BD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6632854f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938565; x=1777543365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sj7ySvrLIG8cYiwe04sHLUzq9pGSUkXjv3mIv8QEZI0=;
 b=kM9GKcX2CJRZprm4Dj07BJOrDC3u++cXMQlNDFMIQ67BaWCUorUc6z7I4L+5E8QoFa
 lWfBz399UKT/pxTd50xQJqg+sdE5TB7Nq2Ey9zFISbMkveZ0ukOPbgmlHSAOZAQZLoWu
 aUGfuulysjXGq0go+4SDyTUF/JxHf7RG52SbrzzX0z0cwEbWoY8OMdHtoGCez3+bzogo
 PhE2VsnTlpIiDUr8bg+yKljWoAaECbpkYvkuxjfXmUjYkxlv6Ys3N/JrwVzVqESdrQww
 TKdOXfOD61clUNDKagB0iTp/BrlrM02YH77OVw7oWXMMIuEFGbbID0/jGONw9CJhlW82
 YbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938565; x=1777543365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sj7ySvrLIG8cYiwe04sHLUzq9pGSUkXjv3mIv8QEZI0=;
 b=muW7c2iluwLmXb3zhH3WQ+VWw9e1OMCI2nE7fiJaTRtcrwxYtjLCQNmIzhMdI710lY
 FY/krrPFGblxzRdv6hVbLv6iWlbdMD/WLcvG6sZwNhqc/YupJcktOHsgE9kAANMX1fvG
 9U9sLCMdprOUvG3Rry1AWC9zm8/52cFUcFJBPEK7nvox8OebZKTdp0o54nxFw2ZDDf1B
 V9phq7BlGFry59mVrnmjO0AG7SVL5zcU73BqdXkhZdMIBGeZI3PJBHKDr+U769ZgdzWb
 mXdNkm0U01pdmFeSoq34+g0kGCHxoLNnoRPREgTX3ntQh6nGkqAdQHPDkNN1zjTl/1lK
 erNA==
X-Gm-Message-State: AOJu0YzKkCKMynZmdGOrzRvks8NwArJuoJsimXm9xXNxCaoWRord8Xtq
 J9EMG+p2hhqO9EZtL3qGrKcA+l55KEQfNNgmIc4l3CrlXyMxU9f08BlDvU67RzM0llOgMroeZ+W
 xfrnT
X-Gm-Gg: AeBDietZH1OjWu2duurRPy37zu5LQ61zZm65v+u5kZ4+bi0p8ewNRX8Yyo3w1DBW704
 Y0ZSS8YKrOWxbuLz6rG4/uL5DHjLtb0Q9fsDG9XY2I2D9CVbfVrw0CeyO32bWjxpjfStR25vTIR
 69itnDlF5ELXy909/iHLrfBVD69mhSfADjKbyfnrZ8s3neH9iVUOjCBXhJnJ1RUzTsFC/WQG8Ej
 YrhX/OHTtmIqylCx5GAk5hQKJ0bBVdIHgEKumxtXQAjiL52k9gm1kiXS6xYY1aGcIpH0yzW5hPY
 nn6GM70vOtF3lxYvtj3pq2Ve5GpY37AONjSMHNuq+DKng9nlDuL3bKdEI/vvJ++/fM6kS5p6vUS
 y6asV+tBUtvW5GhGYTOTsgUir3/7sTvVU2DlewbJrZtu4Lj2V00Mto6gb5LPKdciLuDa0NDBNtu
 DL1BLosgCgwdKrjPm4Tnn+eN2WCFFYD3FJs2n4H8sk7T/fiSGE6ANwyk/6278txQ6FGvPZwrzkb
 HANoZC8r3Vtsix67S5gAnBja0v1pbrAgl+jvNvVpQ==
X-Received: by 2002:a05:6000:2308:b0:43d:76d8:5794 with SMTP id
 ffacd0b85a97d-43fe3e14f8dmr43432131f8f.36.1776938565312; 
 Thu, 23 Apr 2026 03:02:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/59] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Thu, 23 Apr 2026 11:01:43 +0100
Message-ID: <20260423100229.2941820-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We need to stub a64_translate_init and gen_a64_update_pc.
At this point, we don't need to do anything for aarch64_translator_ops
since it's just an external symbol.

We can now include target/arm/tcg/translate.h from common code, since
all target specific bits have been removed, or can be specialized with
specific defines.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build |  1 +
 target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
 target/arm/tcg/translate.h | 10 ----------
 3 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 target/arm/tcg/stubs32.c

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5f59156055..3e96c77df7 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -21,6 +21,7 @@ gen_a32 = [
 
 arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
+arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
new file mode 100644
index 0000000000..c5a0bc61f4
--- /dev/null
+++ b/target/arm/tcg/stubs32.c
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/tcg/translate.h"
+
+
+void gen_a64_update_pc(DisasContext *s, int64_t diff)
+{
+    g_assert_not_reached();
+}
+
+void a64_translate_init(void)
+{
+    /* Don't initialize for 32 bits. Call site will be fixed later. */
+}
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index e28eac54af..77fdc5f3a1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -357,19 +357,9 @@ static inline int curr_insn_len(DisasContext *s)
 /* CPU state was modified dynamically; no need to exit, but do not chain. */
 #define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
-#ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_update_pc(DisasContext *s, int64_t diff);
 extern const TranslatorOps aarch64_translator_ops;
-#else
-static inline void a64_translate_init(void)
-{
-}
-
-static inline void gen_a64_update_pc(DisasContext *s, int64_t diff)
-{
-}
-#endif
 
 void arm_test_cc(DisasCompare *cmp, int cc);
 void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
-- 
2.43.0


