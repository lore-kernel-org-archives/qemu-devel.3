Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27186C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1E-0004Sq-4v; Sun, 04 May 2025 21:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0u-00041M-Ud
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0002cU-4r
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so3893224b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409975; x=1747014775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=HONpYIzx0db+HXiV2DQijn8zZzNf/qcD86lfnAGZpODvEDysgoWHSY0mYT2NnLyWH5
 +zLMrZCEZMrhuwVbQRjYlUyuCZnM5pyWhrgKym2tnOaVT5ZZkMRR6/YgHCMRRwxQRNbF
 v7qRorJAiJYnLGtOlFOiuSWHcF1QAaLs7OoGEaWko827c+LGUstNATJRUWODMvbkdedq
 vF83CSRkpWBAIR1X9uxeUzjecRtURDdKxC+9NrReZ1YXJaVx+kH9R9AT3kj+kXMgMPQJ
 xM7YYmH5oebykIsgHPMiFy8YzkhLYrejJkCBixkHED2Rt31QISpGnGpjqSgSoM/IN4On
 5YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409975; x=1747014775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=YzS1dJRp0kqgeJRANWYeHNwNzjyLAAu1tB7H0G07RExQEcxH5Q0oaOapSMbfLITiiE
 rVVB6pBycIUS8FmryW/cjJhRfSn2KG9BhpLrQQDgLLMWQ1QRUsfYopaLLqg+ScCIdS4t
 mok99H72I5HTdc5EoVRCJR9XXBj4mOL+55MMAX00wOe5HdtoMSEhJYRtZJIn847g9e/5
 uTu01CqB9BPyIW7fQ3JhJeGKp3qWW4duaaSbp4WWQsptqat2US7f2LEYXzibniNMePu8
 4gJAUMO2u5ZUzNrDHo7Vmn8lkziJjRgSY88lMepxw1EOEnqdE2z+Y5wth4cbRMK6zowP
 D7Kg==
X-Gm-Message-State: AOJu0YyUwXXRyfRntIjMuPfxJnDCUnOmklF8Hl82k58J3/3fjVPs9eKk
 qLSkzBJB5tjbUY/OkB5labdZwogX8hZr0H/wdtyN5K8Er6B0p5K0Lw3I0ok9gXZJ4+VOOtXQCNq
 J2xE=
X-Gm-Gg: ASbGncvys/K0LAubBsaycsWWJxwCUtAS673gSTzp9YbBPJdIxVUVc5g00sTqB9b2xlU
 SWN72kvDPoZBx++eBVOfWm6k9+uwFwMkP5qJ//8ST/PyIYxtkL90OAvIc9ofiFVBR33ocspm2l0
 8Mi4CNgkgpC2hkGrYBB2kjVYX2WkqPeshbBqGy5jAN+dzX4mKPAM2T2h3pE1YV92mI2qsYDhXga
 DzSGXUj1m6axpem0UUqjQPW6e7y6q4cI2zhzFRfw4W0X74hYGo4aVqM/BfE0qhycbqKnRmEKIRQ
 w5foDbNTffjhXxpnPRPiUVudcdVUi+3zcrX+QJV+
X-Google-Smtp-Source: AGHT+IFov8TPcHO/7aZomFK+AG+jlBt3spUroyr7V1nRBJYJVIGK7covInHsA0gbZOIJ3WBHEurTkA==
X-Received: by 2002:a05:6a21:1743:b0:1f5:63f9:9eb4 with SMTP id
 adf61e73a8af0-20e97dafce0mr8559737637.35.1746409975059; 
 Sun, 04 May 2025 18:52:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 29/48] target/arm/arm-powerctl: compile file once (system)
Date: Sun,  4 May 2025 18:52:04 -0700
Message-ID: <20250505015223.3895275-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


