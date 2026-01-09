Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052DCD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56m-0004Tg-2n; Fri, 09 Jan 2026 00:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56k-0004PY-Ro
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:22 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56j-0003jK-Dp
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:22 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c0bccb8037eso1858559a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936740; x=1768541540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y+LhU9hq0Bk+02Du8zS1W+Oe4dPFYfKVgaFDuLWOsQ=;
 b=OTBbt0ykJQxsNSEzJonuNao/I02FZPRjhL9Qn+ODmotTqIbn8Ru6kPzHxaQnenHZn0
 WLch4TdGynTxcTg4/+DCQGpjsKktf25cUE3RVX+54Yrqpo3M3kvb7bD9Cg/O45ZOF/y+
 pAlvAh1+xTXudmIDFVZGViHLCzoe5o0GTxWcY9ZvhUWjWjZ6l8/TEYlBQlv5p1KynI9y
 EpE9hOcZ6YbsUXHCM+OIhAZ/5BKD19Aszc3iwLXY+9K5JOheuPIYm+thL7BDxzPzPkK9
 KA3XAh1klHRAWsZLNibgf3UbIDI/gdDxJhAKDCKJQ1hlZ2C0tmO2+NdOqtWBzIUCc72z
 uFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936740; x=1768541540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2y+LhU9hq0Bk+02Du8zS1W+Oe4dPFYfKVgaFDuLWOsQ=;
 b=leFGvNPz0tQI5yq5Igte180f2CojnWBC6DJNa6Ilxn/pnuZvR/yAqQsaPEICBoQKyB
 oZofazxD+Ojg5vTBDYp1EEq0TioOVZPrKTET6CFmOIxoq3AEcTZZr+MZUGgOU1S04hMF
 CwUdSmAWKJwnMUReIUDfArTDVGY4qYI0qJ8wW6ppHHZ4BqfdMZc75FYfrmR95rDP+tVa
 qAmWkUTK8hErm858yW0Tisz4d9cuCg/fsiVnwUPFtGKH1Y8W/M4SRDIkbP+WfO0ojz1l
 Qi41VErXNuPbpV0ncqPNiCxet+UkfrHZ+L/VtrmVa8WbQA/4fsytGXEvIgONUbD+qCFd
 nBJw==
X-Gm-Message-State: AOJu0YzIzTFnfIYxnQyibH1l+hFWWUiuRixFhYi95VP/MLCTcvPHZ42c
 Z/HTUjzxAMJK5MVTYP1A/ZqmwbSN0zClPmblIrRfRgIktgV5AdzMkOC7OSa3QCRazralj72XcaO
 6QHxQ
X-Gm-Gg: AY/fxX7rtUGW7tiaR1XgwNIg86DeLUnbhhIYMwagMVX8fUPqB8oSF/JNPALsDmRR4h6
 Zw74J8yUBlrshImjbpNVqAy6k7v8QKY2A7ZqYY8ADz9fGDAEzvQlffSwjKZ2ENYaBcQLo8DXBeN
 g/YE9MZI/XEauzllTSVi+S1zm3ila4jUFWP8FKcVBDVbNO7LFpm32C7WQEeJORz8E2WkhApwtJD
 sT3mT+RrihwdHW9j61jfd7BdBZMCWLxOrIAhvLd1Bl2q0S/WQywZOaGS+oqj76Y6VWzaGGVZFZU
 Yg9v3JIxNW9yCMX0cu+0doILxPhAwlbQCDitoIUr92vTPccXk5bfyOGUN3lan8I6J4/CTRIOgHj
 knf6uZ11nZy8/DXHYrpr79eWXmJmodqesPSthFqKNPx/poDmMOPpgynz7YxdmlH1OilOsZ5YXoq
 GPtuFr4hrIOK6PhKau4I22pWJ1Mwiaf3o3X8KLYMpJOfGayPfFR8RmSyYiQREUFPv9
X-Google-Smtp-Source: AGHT+IGRDVxO1DCJT+hv1os/DI6uO3/Ui9wQaqMXnaWoz2qQxx8BQTCrb5lIUObtqQ8u4zh4l1R6/A==
X-Received: by 2002:a17:90b:2f47:b0:340:ba29:d3b6 with SMTP id
 98e67ed59e1d1-34f68bd1b3cmr8495473a91.6.1767936740030; 
 Thu, 08 Jan 2026 21:32:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 17/29] target/arm/tcg/translate-vfp.c: make compilation unit
 common
Date: Thu,  8 Jan 2026 21:31:46 -0800
Message-ID: <20260109053158.2800705-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 2 ++
 target/arm/tcg/meson.build     | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 8d9d1ab877a..78a38a0c23b 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -21,6 +21,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index b09957195f5..c0c31a88ba5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-  'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,13 +59,17 @@ arm_common_ss.add(files(
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(files(
+arm_common_system_ss.add(
+  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+  files(
   'cpregs-at.c',
   'hflags.c',
   'neon_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
@@ -74,6 +77,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


