Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C0CC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4M-00025S-DM; Sun, 04 May 2025 21:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4I-0001gx-8X
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4G-00035n-C0
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3015001f862so2853987a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410187; x=1747014987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZO3KsYydwb/hhf/3jAlul68iv5kVCsUNHbrEnCVSccQ=;
 b=JFVD6cZrspp0DBbobeV659UQbRevWvcBK+idkkVswnZcgD2/j9opDS62XlU52vSJVA
 cZz5DUrubathfuYI25lXh63VEBWbwXhaDdcub7ZNB3Wpj47N+OupVzk3vVrHe1Ig1zfk
 Z4tVTfDG+L85OnhM7weNgoGuYfwr4ghdOOsYPDwAI4zAzLjVFhKNPKoDf7x/zExEc6JF
 tGbaVXsFwZAyIgcStI8myKe6FhqPCLd8RKRI9gYG7I/yy/NNlaqNeoccQc+Jw9MpCtaf
 iYTZAVR52IcyjeCCcliaOszajmIwbgpxVuUugC6F+kPVCzivCjT+ekjONbSPjFKtnJlb
 Hhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410187; x=1747014987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZO3KsYydwb/hhf/3jAlul68iv5kVCsUNHbrEnCVSccQ=;
 b=p1U3fpqIE4wISBIKGlErzWilJ7407aznJTqDyyesiLaD9rSwFc8mecT7tNA0uRahhh
 mbtFbbq6DcxwodbgclBHUa6BYprgyrgLHnoy5JOMn7Jd/Hi/suh1s0BIAs7yMQy05FkQ
 KeeM19n/3d86PM++8axtJQ4SLI6a5NqviCZR4Tgo8G4jfYvg7ImXPoVqPs8ahtlegd6X
 arXhldT78cnJqFNbOrSPcdAcqj2YHis0c+Inbhh3YpkiAXGwnVJVIqNcv52SXNhEgkRm
 A8w+ytxAjoHvpfBVXslDQpGupuGrJbTrOo19bUdqq3KuRX158ABpxEpl/TLsUnLv9inC
 saPw==
X-Gm-Message-State: AOJu0YwPzBItaQ5ROBB7+DesPk/AkuIIvXqqHqYx7D/VM8D4p/GQGKL4
 TsKs/E1ha5Wnbc2J2tNtRHGAUPxHThyVMy8yHK5bAEzPs9IFpFHzGNjq1CuKjSaO6YzDC8jGFwj
 cIdU=
X-Gm-Gg: ASbGncsBQ8RGo1bU1l39Dkeg/hWAq0TcSUcE6rBGSBG4BOoRU/4alZRxu5NbVMaibcr
 3ZQ2SpbKLk0ofVEBnSQErTw7kd+WVc7Jcm2PdD+k333yJBUMqDWKDw05DLOH83hPGBqsR0Q6GcP
 Y5vFEZSFiY2kF6B1anrW2ZagoUHC539j2eOLlnhyVb1wmk3j3FAtMnKM/GBO2JIci1Pf1iG99ct
 AotdW2mc3G9OII4bk0RUyoq/jcktGNyp6bMb/LH5ELPZ+5FOTgPMMcmZmP8omGxqBAPvo2AOkGC
 LpdaibQWr+enoFfrbnn4KQUmtNPvfIBtpjcDWnnC
X-Google-Smtp-Source: AGHT+IH175QUPJQzYav/+wT4s9mklMwFf3mSzJzmCFtDGR27Aua7f548KaJOC+1dQss+Y/arG83hIg==
X-Received: by 2002:a17:90b:2dc7:b0:303:75a7:26a4 with SMTP id
 98e67ed59e1d1-30a5adf923dmr11588398a91.7.1746410186889; 
 Sun, 04 May 2025 18:56:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 43/48] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:18 -0700
Message-ID: <20250505015223.3895275-44-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/iwmmxt_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103e..ba054b6b4db 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,9 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 8623152a645..3482921ccf0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
@@ -65,8 +64,10 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 arm_common_system_ss.add(files(
   'crypto_helper.c',
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
 arm_user_ss.add(files(
   'crypto_helper.c',
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
-- 
2.47.2


