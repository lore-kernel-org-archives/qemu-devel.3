Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31FCC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7Yy-0003jW-QT; Tue, 25 Jun 2024 10:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sM7Yx-0003jA-QY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:27 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sM7Yw-0003If-6c
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:27 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a725282b926so322563366b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719327264; x=1719932064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rnhd2HdxiWDbdoILqbmbP7uevpKCJ9UaclSpvRdkW3A=;
 b=E8D0wKG1VtbGFCYEcp8X5WZBWFKHkhQMNCIRSUIakTmAv+arODRSLsmhGDVywAqd1j
 OY/e8S3evce8iF9qpBwwSXUVDoi3c++Uu0Gu98NFGUVqvbQ2mdj3B5FeX/72PWEkcZoo
 YZ+oJM1297bYUYE3Vso19D8a93u/08GIsTaicNE0dtgMinRwf5tGmJC3J1QDMSnuNgi+
 JPS6oIzx3fJpbsSHdy8pDe4yxT8kuZIRcoJi3RXPRa0Ak3J1TcWLQy43rj/V7ZuJnBau
 DGresPBw7fMa6ki1ZhRftq0inJhPfY+g5RMaaoLm1ritV5q9ENjDY7dJ/pgKIwsZioHm
 lDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327264; x=1719932064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rnhd2HdxiWDbdoILqbmbP7uevpKCJ9UaclSpvRdkW3A=;
 b=TL9ir2U60QbIGVCR+T/AuNfxb4PglkkZ1JcvVqzBouOYJXfr5e6HNt0LmHTUFwT0Ln
 g0gRLYm2Bfn+vVE8GnLCmTvrPl7SM0sfoH6vhjS0x4oxzknkcCOv/h+zLLyNmF77xEDl
 Xi/Jnv0UrcKpQv9WQZGzY16/pDdEd9wgrakN1VVtgbWAs9jIAcHvQiw65AIBfEeEhAOm
 hesRK0wNuBGX1u8YIxLgQyhUTD5e/lIlBf/O6juZI/dTTjfW67vrhla5VkJfRrr5fjx6
 7gicGSfwIVY7IKI2H4A81CjkHURSKDgp0xt4geTpgOc56EqsGJ0hcwk6LIe7YwhkpgL3
 2lRg==
X-Gm-Message-State: AOJu0YxlJZ/98DZzaXcigD+khl1Asdp57zjuoRSbc2ZcUOTzY1WZFL16
 4kFZbm6SYzLXNGpy2A2NB9iSG9dfU6bPtASxlaaJxkPlhXdR+Rpuk66I9izMC+A=
X-Google-Smtp-Source: AGHT+IFgzHyx606CyMS3zfEANHM3EurFBKmwywlCq1qE0x+yOmu2F1RLk4Z3ohvh1CECHwiERPf5IA==
X-Received: by 2002:a17:906:4903:b0:a6f:b428:30fa with SMTP id
 a640c23a62f3a-a7245dc9c41mr457231666b.59.1719327263941; 
 Tue, 25 Jun 2024 07:54:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72751178a2sm68068966b.17.2024.06.25.07.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E86B5F85F;
 Tue, 25 Jun 2024 15:54:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] testing: restore some testing for i686
Date: Tue, 25 Jun 2024 15:54:18 +0100
Message-Id: <20240625145418.694476-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

The commit 4f9a8315e6 (gitlab-ci.d/crossbuilds: Drop the i386 system
emulation job) was a little too aggressive dropping testing for 32 bit
system builds. Partially revert but using the debian-i686 cross build
images this time as fedora has deprecated the 32 bit stuff.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 47bdb99b5b..5ba728f641 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -37,6 +37,16 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
+cross-i686-system:
+  extends:
+    - .cross_system_build_job
+    - .cross_test_artifacts
+  needs:
+    job: i686-debian-cross-container
+  variables:
+    IMAGE: debian-i686-cross
+    MAKE_CHECK_ARGS: check-qtest
+
 cross-i686-user:
   extends:
     - .cross_user_build_job
-- 
2.39.2


