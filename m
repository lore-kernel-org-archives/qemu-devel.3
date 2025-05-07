Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D2CC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoTx-000109-LP; Wed, 07 May 2025 19:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTY-0000Uu-7D
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTW-00037i-66
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e331215dbso12829335ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661613; x=1747266413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45kfheSbx4dAVwou8HhqFlnvbUQXjacWSTonOtivRHk=;
 b=mIj0uvfNa/Qj92xklINiEWzcwOc9Bw0OuhCDSBd1Im/hRgql+5vh31htjs8l5mSfMO
 7RhUNNSICNASY8PROIxvKWzgAvNCl+wMKSVJGJ8zlwqA8DAiDzu83ew1bzL75oat52Gz
 xK+77LvXQzmoXhIXKzENyHnB9XhfOCkXMolfKmHFhZfMAMyDdXBnU8xUsmUi2UcyKUnw
 x2SuuIDS4LszUCRpt6pf+ZcMCu2arbTvec58T/Fh7avoEnAXXMQcRmq7Nx0fdbI3FGKq
 OBiUL+YDwerfFKPIR0ZPQUFnYXRlqaX4/vAnaT1PVx9LOkMkYjhPFFHV5ZlJ7gPFL91i
 KE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661613; x=1747266413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45kfheSbx4dAVwou8HhqFlnvbUQXjacWSTonOtivRHk=;
 b=HORkqpRbC28dWy0DsxLPZtKzYOD2MoX9ReEv6Nj/TMgy3kvAbpM87uozbqsNr4hAl+
 rckqNhVgDYJToRvVyCpoy+3Uvt5nTmmfPzRB5U/WpbeXngO032GV2ApTqS/xWnAVurfp
 ceGYQSIPa2hqzzRQez3Ovl9TagiN2b0rsV2ftuBq9syPt3GnAtATLEIh0Nhy5nv1t2+S
 MIiY8udf3nuoFGmg4hQSp8UIP9DH4jI81cax4bp1vWiTyYBC+msUMAIs8MZOgmQuKjqe
 R2tSwWnvxhmb8kH3KtkQNXhNuZIheZwAJluVPNY8M3t6jlm9YsSk1xZQkdNIJJobXthg
 JFuQ==
X-Gm-Message-State: AOJu0YzeFysDXaPXsDGNY0to0JHAd/TAVHwb6+6n/JcYUB8QEpzSdj7S
 FZ+xqp6J430Fk0cCPtWUbFTA2yXYmZhZztoKtK6uD3Tu22Nt6YJL/TMoO+O74cN9hRyYv91MVDW
 m1YtdZw==
X-Gm-Gg: ASbGncsTy5tgNd59bH0pV7VRVWUHLkyOe2wwosSMOJ2CxZvz74qiR4v7D2otuPLBa3O
 zVlt7auxQf8KWVuGTh3+7zd19uo4TyhQuYkBTDNMjRUCaJU+GTwmknMxQ/Ex+F3E+6d4wCjgaKG
 FeMlzxMXyUd3bJaBZfGl2z2TgkBml5rED5nHVJKNDSR/AjjrQr1xhI4dJJ+oNhKSxn/WcRxmDSb
 Zq3IqzGAd796puz2DMNqTK/G4xwtusQif9Pbs22DKeCdyeDSEEbMNJAt4uzVbR7wUREPygctOLW
 EwjlSzT8ILw+pc6ToQAxnCaclZYS9OhhsR/IZT7x
X-Google-Smtp-Source: AGHT+IGWvpZIZhAgezTm3+CpU6FhffPhuJ9OaI0G4/I1LkJJeHKcE9WZB+AxsD5YfZnzuRYarly32A==
X-Received: by 2002:a17:902:ea0e:b0:22e:491b:20d5 with SMTP id
 d9443c01a7336-22e847990b8mr19124445ad.26.1746661612749; 
 Wed, 07 May 2025 16:46:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 41/49] target/arm/tcg/crypto_helper: compile file once
Date: Wed,  7 May 2025 16:42:32 -0700
Message-ID: <20250507234241.957746-42-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


