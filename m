Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE81CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYa6-0005HX-DH; Tue, 16 Sep 2025 12:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyYZg-00056F-U9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:30:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyYZe-0003x9-Ow
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:30:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45f2a69d876so18037315e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758040233; x=1758645033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=08NDD1ErT/3oi4rF+4yZtUe9bOClH+zyfbJJkn4vUVs=;
 b=UhcS7hVD+02FQcCsGft2nfjiVWXoIECekiOjJaju1LeDHpyt1MpLtH2zH5fDRnS3dM
 oVhJpABrPne721FKSCuwf9QMvqOUMMBYImon7qYVq3WKgDs+JO8hE1b9W7BG2p1d92EG
 M8reG5Jgr4Wb1ZsAOLQ6vi3AUtd8l6X8v4it3YXjGmccXNSy15CxvRV4+0vBROM04r3G
 GP25KUtwDf28sZTcieHxW2XmeOjTDz7MHPk07CV5gz2cgCcqMVT7K+fbhn47+060Bx0c
 j0shveMJgcGnrA7tk/G73A7e2BJBPXsdNIRuxFDahzJOoB54hzhtGJlRTVy1TFWkso8i
 7uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758040233; x=1758645033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08NDD1ErT/3oi4rF+4yZtUe9bOClH+zyfbJJkn4vUVs=;
 b=aNPhHFf3NlrxQot5GaJ0/VuevyEfM8k2nd2SghYUlVswS7ZcmFmgv5+NaLuaRDBg3h
 DN50O6A4QA0fcB+JCeOQlKwl/rM335OsIL7Vl71uCKAWwZg46HfMT907ojsfgFtWZO19
 oQgxt6B0DJTKwtXnp/JE2Nwclwn+XotI6oucZrGHTA1VQwn5PXmHh3S/ukekdKtK/JyA
 bKQtgUE25QvV/GdfidREbxb/dHs1yb5z1fgEJnpyd4C3TQRvYTS0bAn4/zucGxzpRCUO
 TiT/c5p9bXj3JPAwTor6Oz0amhOsakN2ZV4ynUuQgVLXCtLNTqUZwlV5SXwndGeuKoOO
 /iBw==
X-Gm-Message-State: AOJu0Yy25cyGFncHexsxJ7t9H28siqUpw7Ems9bEUKbrg/uCUGYVwSme
 UOrJX7JyV+je6pDhKb1oyseC3MIo23C7d7SUfKucdD5gaoGmlf/qBm0WeTnylWWdPSgYkhMl1K7
 yUiku
X-Gm-Gg: ASbGncveXBIdByP6vW85gWdYYI7mjqnT7GsGIYNBx8XwXuO3CzBkOBNC7Z4tD0Rp7Sr
 vy9l1Fkoe/kky+4crlzwMFslPyY/GGS7j4pj/ode60uFKAi4uFbe6KasqtLf+Rrb0tBw/cdG/fn
 S152BsmTT8NGThWufPeVhnMPfbE34ybjPHEtmLbBQ/Oqy/AUnAfYWLEaWG4Y5ZpNzUtK7jkgH19
 JfVcXb+bq4F+7RwzDheeG33ulKRu6/01u7IptcGDhYcoyd6VkV+dP9o2GK4CrjurAqZc51zdMs1
 C89Zxy2OJd1aBm4ff/JrxgAdEeJoXIyJRts1/KBBIlny1CIcFHexG2jnjk6ZH6NJSmew3fFQYb8
 XwEtE4COS+k+P7HfxNyIh80gDl9XG
X-Google-Smtp-Source: AGHT+IEeB08fn2iez01GmnSFfE8fFuD5SsjB+pXqoJLbUkwA1TAdEtvtDyWU3PNX1PpU5Q//wnHqyg==
X-Received: by 2002:a7b:c04b:0:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-45f212050femr115274075e9.33.1758040232700; 
 Tue, 16 Sep 2025 09:30:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775b13sm23136653f8f.10.2025.09.16.09.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:30:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for
 htags
Date: Tue, 16 Sep 2025 17:30:30 +0100
Message-ID: <20250916163030.1467893-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

In commit 52a21689cd829 we added a workaround for a bug in older
versions of htags where they fail with a weird error message if the
environment is too large.  However, we missed one variable which
gitlab CI can set to the body of the commit message:
CI_COMMIT_DESCRIPTION.

Add this to the variables we unset when running htags, so that
the 'pages' job doesn't fail if the most recent commit happens
to have a very large commit message.

Cc: qemu-stable@nongnu.org
Fixes: 52a21689cd8 (".gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a600637..37a53bf105d 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -736,7 +736,7 @@ pages:
     - make gtags
     # We unset variables to work around a bug in some htags versions
     # which causes it to fail when the environment is large
-    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= CI_COMMIT_DESCRIPTION= htags
         -anT --tree-view=filetree -m qemu_init
         -t "Welcome to the QEMU sourcecode"
     - mv HTML public/src
-- 
2.43.0


