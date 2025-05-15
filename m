Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411BFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpP-0001Ma-A7; Thu, 15 May 2025 06:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnh-0005X7-SO
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnf-0008HN-4w
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so6071725e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304809; x=1747909609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LWZityl3Dx64taRs5l4r1AoYIXbjRwWByF1wfRUq6sU=;
 b=pcyi6fZ0R0tnQ0VIEYMyIzCEj+miK2Ko5iuePALpg10NRyzL6NtPH9eG/ku/X/jA/D
 vJ0RXaXrJpmgB/jcoIpTbdnDBUuEldmcN5+hF/52O+tsd+2oLo2lNbrZAUAq11SeSigA
 PGhhwk7DksrlFJCSy1EgaoBujm+nWdk56WxPeh5ldp4z0+p0aRBTWaXS84f1HxRv1nn1
 hSDwtqAsdV75p/lfYE+IJqq4TfER109WSxrdAWkNNBuGdP1uomuExI4RVmA4/ur8Sq0B
 jF42VFvBlJEBVO2WY6QBZmWm6cBo7hTUJ2kETvwQmLOl+kPiFWTeI6WZ/w7QhKJ0cZ6M
 gvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304809; x=1747909609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWZityl3Dx64taRs5l4r1AoYIXbjRwWByF1wfRUq6sU=;
 b=EvuMfOy1ABuyPFp+GqXtEnhhxMwshiA8dt+KETyRC3cv49vFzJBj+xPCbz54iB2Djl
 BPrQJv6M+O4bdvLxJPf+Qdj670IqO0dg3G8ZGI0WWIjETc6MNAzVIwakQDw792FYE6HJ
 n+FqrkGGRLkkhctqca3gj35OQOYx3akJTJ8CFyVh5ZGw9spL+GN8lOzWP2Kcvuwuc3Dv
 S8e81rjM8wnB/57bxO6aZmK9q846BZVTuAmKWXaPsfeiYg49YtNuKtc/zt7I7jq7LQfC
 l4IkSrRPCcT3VfSFPsRrRIeDZaVQYes4Ro772TVyYhyEjqDGlPHj2OMmLuFeY/3fQW+7
 gPjQ==
X-Gm-Message-State: AOJu0Yx8LaUWP7ORyBMN0M911CjznTH54dfmJjheND9H1yk0zONRYnuA
 lgIPHGFGo73AVMuJpT30uz7bIwup8fpYsjHF9I2lXPiefvvs49vQ4sNlcy0FBPYUyQ+GF0SmIWG
 Anmw=
X-Gm-Gg: ASbGnctXzk4xL7kZSLFYkzp3rvQtYZcvKUFRCbOwHwAZjZbk5p22p0qeURxS/EK4BBP
 FRnp/45Sy0lJ6nE7AEyaUwlKxSYkbgSlxfEDz4FE3Z6tR/cEvAQ1nlrXwzGbsOqwtYculaULjoJ
 l3hwPIvMJYNTMhKE2aXHrbjqHpPoQmC1WWDwBd82vYobRwkPuEFr37mObavXQq/gLU7VbKUb6lT
 isiY0wtkPoTYiB2f9sAdeSzPEbJfuOufhrOTmypvtKjg/0K1MS6gI5lXB1PCkSvy0pFZ+3puHS9
 aQie0o+l2EaTyK4X+dByIkX6w/b7hheYJTummSMHoT7IZWsRsvcl+xphHw==
X-Google-Smtp-Source: AGHT+IGwU8HkNASyCJAbSPszC7hZpVOikEqjpwczHSeSKd5zFs+9ir6hrBz8maOK9B49LZ7Rktzdjg==
X-Received: by 2002:a5d:5f8e:0:b0:3a3:5bf8:36f6 with SMTP id
 ffacd0b85a97d-3a35bf838cemr224114f8f.55.1747304809514; 
 Thu, 15 May 2025 03:26:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/58] target/arm/tcg/crypto_helper: compile file once
Date: Thu, 15 May 2025 11:25:38 +0100
Message-ID: <20250515102546.2149601-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Message-id: 20250512180502.2395029-41-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 6 ++++--
 target/arm/tcg/meson.build     | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 7cadd61e124..3428bd1bf0b 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -10,14 +10,16 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index dd12ccedb18..2f73eefe383 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
@@ -63,3 +62,7 @@ arm_system_ss.add(files(
 
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+
+arm_common_ss.add(files(
+  'crypto_helper.c',
+))
-- 
2.43.0


