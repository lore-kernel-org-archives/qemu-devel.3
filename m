Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89023C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVq5-00026g-I3; Thu, 15 May 2025 06:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVni-0005YS-PI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVng-0008Hw-RQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso6419485e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304811; x=1747909611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0T18u5dfvkN8bXblBycY0dLZlOVP/4FWka2uqgCFYHo=;
 b=Y4Fzh5UofR8Pca559WSCb15rTSfo9wgCM5AG98cmNeYD14dVSdz0m7MnFek2WOqpLd
 EWxZS5lHam0N3Tr6pe+mxjYBAe7mTM4zRwc5bEOGe2zi+JvbJKDKvsNAiPoPGSxlbcNQ
 BgldFjlPBMlcEQM3Swjv4yTdfQ67gf0ZwIEtaic1uZtuvCeQ/Gmae21tfNRxHoLxca7z
 pTcrZJI+mx6g42AcDkT3kfoa9GPTdiuiWw7yTDhp+RV5VzF5nZpuma2WgXHCa2LxAEnZ
 W0KitsLX93Cs4N5y6k0qzAMyYOMshwOAaCEhSbv03R58jheL3hdKv1tbDA8bNfSkIeQ/
 sINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304811; x=1747909611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0T18u5dfvkN8bXblBycY0dLZlOVP/4FWka2uqgCFYHo=;
 b=gbQXkfKpbV0bFB4+FnNnReUuTj40rNPbW01m7Xe81n5xfJDHz51xJ64+VMZg0M9xYy
 7leHIqj+r6W3WPydLwyFHsz+DPmFrUqAovOi9Oza5ChKzCcwbEaOjumfawB0iuF5Pb1D
 pley8MgbQA3+HB+KdKnWdfyROwlYKDMRFPmMluS/Vb9bm/GlxCJ99J1H1htxigS0QSfk
 h/MHuJpR6BuGeJ4zTMljJDykS+RYlzXA7Whykoo0jMakmjEIjO5eDSosqL8/Ot0t/Kq5
 3eBwxAxFJWaTrsMu4n0cw+Reo/4uOEh8lY4xlQVFnptTEmNUIIsRliMA7nM6vzBaYzOc
 t/Lg==
X-Gm-Message-State: AOJu0YwqoFWUXaB8yI2Rxub0sMzrR0SMrNG2Yt58V2KGhV7rxev7cACd
 uVVWsGDamYCY9Tm/0niYGjJP1yleW/iPIuRQUSmLpJjfQWV/IQ60ky0aiOVVrcIXuoOPCCjojNc
 93u0=
X-Gm-Gg: ASbGncsoqA8qbLJdvvWlNzdF6ofJbKjpMKHAFiPH9JltcPs1tJYs/4d5DukijMe1KuE
 sAUTEWG5D0UbMIi0fS1m+EN22Sd1IypDgV1sPYGXX4LcKDDU2rmiQATI+tr682nwv/UXpgPMkWG
 /vlyp1tX2ricEsqTvMvvS4o+BZUt3luUQDwWF3sMC9gzrkXOTTk1D0axy/1Lun3ll7ahiKIGseR
 FSZu3pHN/kE8GVsd1j0WaXjAuvli3zpsFj+o5BM4iFXoPCDg7QfnR6iiF7gk+2qgNAuP80IJoTI
 Tpi8YrCRWGbbqDtQ+96Xk6bHcLK+PP1yBmMBbOb+cb7T4U+UzmokCWOprw==
X-Google-Smtp-Source: AGHT+IHHpqPp2HUjSx/t0YUuJYDNzAoydXoO0yR9mNKiqOzGc3SB6giRzPOiHgdxXtmSU6kmsJZekA==
X-Received: by 2002:a05:600c:c0c3:10b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-442f217983bmr47233855e9.31.1747304810748; 
 Thu, 15 May 2025 03:26:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/58] target/arm/tcg/hflags: compile file twice (system, user)
Date: Thu, 15 May 2025 11:25:39 +0100
Message-ID: <20250515102546.2149601-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-42-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c    | 4 +++-
 target/arm/tcg/meson.build | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index fd407a7b28e..1ccec63bbd4 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -9,11 +9,13 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 2f73eefe383..cee00b24cda 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
@@ -66,3 +65,10 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 arm_common_ss.add(files(
   'crypto_helper.c',
 ))
+
+arm_common_system_ss.add(files(
+  'hflags.c',
+))
+arm_user_ss.add(files(
+  'hflags.c',
+))
-- 
2.43.0


