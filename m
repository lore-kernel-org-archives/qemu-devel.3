Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50334CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojhP-00045W-72; Wed, 20 Aug 2025 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojhA-00042s-LN
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojh0-0006uK-Jn
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso6630911f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755699680; x=1756304480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=772OS377XKtHYwDSpPY0kVBlSk5H9tu1pRyE03fGer0=;
 b=pDOj7wpTXQU/66Ut8ttnzAspPjOrtPBw/mYVdAT1hBgg23xbHncBA1Q4M9qWiN31VD
 ejLe4kt6N5egUQTTAZBpf+YPqwj3S8LeI+uJWYcghg9EnzL178YCID8GA/mDobXDFxVK
 MNLU1bJBKITWfwmZRrVjfI7In/9KwEwlukRG8ev5ju/YBG3T7UqwBzeON82+EJVIBM9z
 gR/SUmPVZzbLf0USqJHEuRjkNs3XYON0wqhM+WbXjkzhu2XhMaobbXzGj/dKvG18CI+l
 XJsDIcRDTCwkwcFsyAUOBvDQEkiNJiR/yQWKpMvtajb9N711mOcILX/rc3uRbUHgQ/3d
 dDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755699680; x=1756304480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=772OS377XKtHYwDSpPY0kVBlSk5H9tu1pRyE03fGer0=;
 b=LzY0LZOCcJ/NrB0ok/EXv0V0jEgvbo9YKpKxDWOn4Ig5fraULctncBwB5n2jN5i8Eg
 Ei6MS+L351LafWfy3riRm9bNjR9g9IN48PDGyuWjndvE1eZZheYi5AJuTryYWZOkSSt+
 mynUM5XdAf9F0hC7u7xuBFuweNTpAqApd1ZM+1a3qXNRnDRrpd7F4e7qkEVRqfMaqllD
 WLvJ/b6u3YpwCB8zpHqOWBU9PnITXZ8s3VP9i3E6IOROIw2ed94VtWu+C1WbrM5A7E8s
 0ljXfaXXMw5IcdqXRWuRQqc0NpXw2lVDKlwE2DUME9uvB84XSBh57tm/Eqpbnrg8PSgQ
 /4XA==
X-Gm-Message-State: AOJu0Yzl/YKALz6UT/9gtuOQOw6zjXJGQM1q8Qt+B6yGBYn7pTWMmQmn
 btOl7bLb3jnMSCgFdRGVdjJ4No+GEKuFNYhNrn4EIMlvpZZdaWY0U8Z2GrhjSoZB4Z7lim/aH7Z
 GjMhn
X-Gm-Gg: ASbGncu2Np014TFc29lU9fsz9aMsLWCrvmXpTQOavjz/vK4XFSWEQIXGAgQqRDE3icU
 CG6yX1yrbEEgYLaYhfBgBolAp3yo96gJ6n1YtwFnIPozChaVGs0bYLCY7FhqnZqCRpgIF706WAv
 VCjr0Kpg3H68xn25NiPf8/znVcf2FkAFwThGfsnCsABF9jWZtyhiR8ju9mckycd3QV8d7NhbwQT
 LK4gmQtkzgBgKM3BBU1IUcYL96X7mlYt2ISlJvzN9dgpjudUCkavkAk52GOEPMrMMARMgNBOQqN
 KNhu6m/68V3gK4BTs7ym8xUqakF3tq4ISEWqqFE7KfmN3rGUjUjzdnAQ7EuN8rYQwPtkQ3uqi5Y
 ZkvqtM2DnFP3n8N1Oaes3x9MEeCPBZ7V2Dfw+KVcfPUwB7bGGhRhqnKKDNtFTAgP7JCsHSb8caT
 wemg==
X-Google-Smtp-Source: AGHT+IFZcugBSIteUr+AXN34bVPQfFvD0EvZ55dsD4gOzvw8mmmEnu2+3T8qRpyJlOczFY+YnTARYQ==
X-Received: by 2002:a05:6000:24c9:b0:3b8:d69b:93b with SMTP id
 ffacd0b85a97d-3c32ecce485mr2008274f8f.52.1755699680169; 
 Wed, 20 Aug 2025 07:21:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c07487986fsm8927591f8f.1.2025.08.20.07.21.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 07:21:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/5] gitlab: Stop cross-testing for 32-bit MIPS hosts
Date: Wed, 20 Aug 2025 16:21:05 +0200
Message-ID: <20250820142108.46639-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820142108.46639-1-philmd@linaro.org>
References: <20250820142108.46639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Next commits will
remove support for 32-bit MIPS hosts. Stop cross-building
QEMU on our CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/container-cross.yml |  6 ------
 .gitlab-ci.d/crossbuilds.yml     | 14 --------------
 2 files changed, 20 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75b..0fd7341afac 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mipsel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mipsel-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 3f76c901ba8..721aea77a27 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,20 +68,6 @@ cross-i686-tci:
     # would otherwise be using a parallelism of 9.
     MAKE_CHECK_ARGS: check check-tcg -j2
 
-cross-mipsel-system:
-  extends: .cross_system_build_job
-  needs:
-    job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mipsel-user:
-  extends: .cross_user_build_job
-  needs:
-    job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.51.0


