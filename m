Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7BFC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnD-0004q0-P1; Thu, 15 May 2025 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnB-0004lt-3G
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn9-0008B0-09
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso8398095e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304777; x=1747909577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZkRqD+LMx6swHQ6xUEIIe9lCbzC5g6w0oxlU/fhgdns=;
 b=xrtVaEQm9jSjMWAhfgxfzNuJ7t9MrRWT6xnCCusKvbwOaoi4BCwU8T0VpLG2gD7V2d
 Per4h4YwYuBCedbGJueC25cubgveFeL0dVV+NbHjxeGkBIuvSTfUNOr620zcjlU7/eWv
 1cW4ivrDzP5jyLeO/h8YNtPTzi5g28R9/yvldo8UlC57HXmENVmzZFFcN1hOp/S2G1D8
 7MG49ZNGmoUaK3dqsCdSUJBG1huRztEWwoNWJwtBGdilmLCYruqY1t/YG2ivyrLfJpvt
 zGD+aSPIPeLZAKX6kuD/AYAh3NFfAtwR8iNsjSwgI7dxYoGNWNl7+jCv3lSGbZdzNcg6
 4YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304777; x=1747909577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkRqD+LMx6swHQ6xUEIIe9lCbzC5g6w0oxlU/fhgdns=;
 b=m1PpK3cVW5LWtL0n138gqBRyhR+Fbmw5VJiNT2FqQWjomL1fdueX9B4DFTw8lrlGD6
 YiRdyH7xi4ucS8mio/X/PaIXpl4IBL7EgSHwS2i972XI1uBjX6nm2Q5zr9O+1pkiRGD4
 4D0GKAKKoSDHImxMQPlMIgHWfbDnBrzCPSmJYHqmJFl1HjhDWbwEScv7DrF7Wwsegiqm
 4Sv59k6TTskr6EBtxg+Pvf+SmThOQhjt0HHtl3PjMHwH9TJJKNP1ZapkcdVmxRjcWar8
 0+D1KWf9gSLvruY87/hTSdiEkfxJ0T8pVc41pj0fH+lVNDfqpakzCfXzTKuWdQslNQcD
 vATg==
X-Gm-Message-State: AOJu0YxlK5509Ky1Rx6bc51SsSzllfzDSFBJ/0mhZ6faFEP1BObjixKP
 zxCzpwo/ibzNkEDbD+Xgk21JMrbZGiH4KtMGBQKkpJiXx6dG6w460XtYRCIE9NX8nwVh6lqg7xZ
 upwY=
X-Gm-Gg: ASbGncsGPdW6socxIqG5FV3VIn5gyCozwxf1V8W3Df3xZb4QTgSuHq84oxqCEbgCyuM
 OJY5jHcODURCUUViRTSRusNEAu/1AAIDzwryL9IIy+mwkplv0szowRI0NM1+7Ob4VQR3iIMjvJY
 MalTQU1b6FSaa8fVg9C6tsvGYlHQFTVnlhryJ+wpbDnWfPZgEMLlmdXwGdNcc4CKOYsqozvWkPx
 X7s2hOBTjMgQ0vb37+Z8oeIhgBx01qMm9pJc7fmymPsODahmo9E6H+349BOZ/Ty7rkFTYXV9r9A
 I5h+MZwr4Nv3pNBCdYfcVraXX65NCyL3ef3/gP4mwGLJz123GWu5u/R4+Q==
X-Google-Smtp-Source: AGHT+IF5O7HbINRD69gyaPxOPZyNjz5dF2FMdUWYEBmFax0WLG7DrmBZvTmfaGLRVSQIsrhQPlZJJQ==
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-442f2178679mr71249315e9.31.1747304777280; 
 Thu, 15 May 2025 03:26:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/58] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Thu, 15 May 2025 11:25:09 +0100
Message-ID: <20250515102546.2149601-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-12-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.43.0


