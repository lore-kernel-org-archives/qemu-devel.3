Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21685C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 20:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44sE-0002qf-5Y; Mon, 06 May 2024 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44sD-0002qR-Bf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 16:23:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44sB-0002Km-PB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 16:23:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso10044305ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715027022; x=1715631822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m0eJGNUlooKDeMH1p2pEaGYVXklEYo8OHVoXTBAaJeM=;
 b=JwnqBhJxyIuwIgrA1/Wuzf7eKxiHvdrv50yKQhhRon991lmwOx5TWEb+8Dcirw71zP
 JUaKzEbFRWMK0+vSSlAimcfvdPPko70DvupWimAdPhDNh2Y+1N1Iw2oPtCvJYyL75zDM
 pk9faBapD5bpL57Xo7+CKiHEAQwgATrm98CBOaORFWPk10K8d3vkGEEB9nFpCaatVagQ
 zgqsAJwOutwszg9zwjMEoYz0jsUaPbfcVnb1T9Fpkf9cDoZZQGz8FYxc1mH4QxZXPDjk
 QZHp8Hyfii/z/Jn+7M9vmZVuBvJNbLX7Ez3QYHavs/u3JE05X3AVE1ykMbkDtbGUiGuC
 Jogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715027022; x=1715631822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0eJGNUlooKDeMH1p2pEaGYVXklEYo8OHVoXTBAaJeM=;
 b=n9NNEfPX7F4bVJYqSFXrvUIGn439IyyiIfTqM21hT0Rmg6pVc5BJYihG23aN0GvHP7
 q3+nTiInP/5mS6UmQNOt3g0BOuC6F4ySAsuG8wEBeSLd/hznOyqjEd33EZCl0E86vXAC
 e/7KwAzMY8iY65ldUi3Y4hQm19TyRqgSG174x1zNO3SnfxRx+0fI8+B1FtcbzOvJkNGf
 xiLkFfNnbi1eKwzd+3Lso143TJ7Z4hxIVW4JglSwcu0R+4OZHpQFzBQHoW4gHcvgYNaH
 gkJ2rCJ7ye60D8xf30Wl65j07iEwhrJwDb3n7Jpr3mu5esc7+kyjSqegRbrg7K1xUr3k
 Zp4Q==
X-Gm-Message-State: AOJu0YxQClQt+uIQUk8Nl/nJZiQnN01TxzpFsrSvQeXHCtHOWmD+Zzel
 Cffx8X5gJ7HlaYPiK5Ft+oFoNZrjOfJf9r0wJryPvpbLXG+DVeFIK7ki/WGvikzfNotb403Kzu3
 Z
X-Google-Smtp-Source: AGHT+IFs0ZM93GaxX5eqf+g+AbtUZWgN4YJPoUcm+qfQX4YKsTNayrOt+AsveNNMsxCkg6bYFczd2Q==
X-Received: by 2002:a17:902:e890:b0:1eb:52fd:fe3b with SMTP id
 w16-20020a170902e89000b001eb52fdfe3bmr12971062plg.8.1715027022217; 
 Mon, 06 May 2024 13:23:42 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a170903234800b001e2b4f513e1sm8664975plh.106.2024.05.06.13.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 13:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	thuth@redhat.com
Subject: [PATCH] gitlab: Rename ubuntu-22.04-s390x-all to *-system
Date: Mon,  6 May 2024 13:23:41 -0700
Message-Id: <20240506202341.422814-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

We already build the linux-user binaries with
ubuntu-22.04-s390x-all-linux, so there's no need to do it again.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 3a2b1e1d24..c3f16d77bb 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -21,7 +21,7 @@ ubuntu-22.04-s390x-all-linux:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-all:
+ubuntu-22.04-s390x-all-system:
  extends: .custom_runner_template
  needs: []
  stage: build
@@ -35,7 +35,7 @@ ubuntu-22.04-s390x-all:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh
+ - ../configure --disable-libssh --disable-user
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
-- 
2.34.1


