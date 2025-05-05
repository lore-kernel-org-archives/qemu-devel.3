Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE2AC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4P-0002Hs-Am; Sun, 04 May 2025 21:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4M-000265-4j
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4K-00037V-CI
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso1025103b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410191; x=1747014991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaIKPxnuDIO9RtYHmPPx5mO5g3g9VX4P8Ofr9oTYv0I=;
 b=Yf6fIdiVXkagDu+VgsbTdjFWWFjVrCT36ioEAwyisXkbOmk4rFZjXRIo3CqFBxSSjh
 M2XOJEG5oSzgvZ9EfYsh97TYN0UXOISN0d9p13SuGy5SnTmeSzDEWBEqRU8D3rh70xkv
 ZIgdFlWvluuzGbP0VM2juv/BQwi0hPAOqPtppv+mnSVEpJIfQ70kekSNipZn0FAce7tp
 5zSfPjQfcWzyHXlEo4EOX14nUljGXaZWg+T0FJUoiONwMx+Y+YhwEcOv8/wZs6ReEvhv
 O4rct0cYaXWJKbQJKxgll6pYscWkhReEMQi/XYTDGLtxxwTMeoxhRSGnQsJUr1lxz/h6
 bTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410191; x=1747014991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaIKPxnuDIO9RtYHmPPx5mO5g3g9VX4P8Ofr9oTYv0I=;
 b=MSquK1iRaNDgEvW1IZMIfy1MwVIK54MSiEfKDBxlX6h/5rKy5R+HiF1VOwwq4v1urE
 WvyduvWoJAgQ2c3ihF/QkpwA+Py+aW0td4n9E8Yv/BLX8fyl9fR/MZqEmV5ju0YZ9GxI
 VC5TsmHhhzVxGwa6kGI5tmd4ABnBY5s6UTsfrtjR/fAdVQr0T7e/fj7SLLWNbE+lH2O9
 curvfFiXPMQzLrs05SG3jWy4tA6lKylvzlaybMKjiEiOPET4D1gKHrvahQ74SIzwwgBP
 wU6/UmIUJ0YXCgQIbFMwouYnirQMCWh6HrOzkhB0Hnm2kNMvybQ6s4Mftfn6N2tTZ3BL
 zTAQ==
X-Gm-Message-State: AOJu0YxqkYr6TGRBXUFSy9zStxg48dEOpcCtPNEB2f5X8+vC0jvhViq3
 j9glPyH1Jzqy17JM6zEZoW11Lk3pdbmO+n2qSlKncKWB8YzNdlMzHfyODnM1sIyQpfYlwd9Hpwo
 FNxI=
X-Gm-Gg: ASbGnctu/4O4TbppNq9BLthWTtcw4bMh6mBX1KbWsLIgNgQzl29odFohB4wsaS/pze/
 /E41kwGE+WT1fFmYW8f2L9Jfdvs9gvug+GISb0C2kWS2DKmGkd0AWS3BQTnaU3UdIE3ecIq3oDv
 2Mw4BwG/8g4VJzKnfbm4E8KCLnQn5NT3cnYG9Xu6sBWoAFIsuw/7956x803W5Qd6V/S/x8XARYV
 czKDwfVnAT0+K65JHwHfCJt3FYervzOnte8PIZ+YvtoeD5U8r0YU3V440M2Y+Fm5GbhzigXbJ3j
 /Mf51MKxqXkzhdg+Uex2lTUnNZsWB02zdUzBhMOu
X-Google-Smtp-Source: AGHT+IGasy7FjzgJ95jnC6u+9mr0bhUE6vKNVWFzb5iSdvQTVXKhLaRg66T02sUairn8/pITB2lG9g==
X-Received: by 2002:a17:90b:5868:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30a619a53e6mr9850659a91.17.1746410190956; 
 Sun, 04 May 2025 18:56:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 48/48] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:23 -0700
Message-ID: <20250505015223.3895275-49-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vfp_helper.c | 4 +++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b32e2f4e27c..b1324c5c0a6 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,12 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index ad306f73eff..2245bafbe15 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'vfp_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -65,6 +64,7 @@ arm_common_system_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'arith_helper.c',
@@ -74,4 +74,5 @@ arm_user_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
-- 
2.47.2


