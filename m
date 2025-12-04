Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A078D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKF-0006zZ-HI; Thu, 04 Dec 2025 14:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKC-0006xr-K0
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKB-0007MR-2R
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:12 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so16510415e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877749; x=1765482549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwr6SJXDzfiH4WLxERFX4BKWKQ004HtcOpP5D0SIEe8=;
 b=rQytlILSHFHdYLPw/5Rw/B9Lt3GKslHSjpcl9shkFJ9mUYIGJI9hee9oLSJCejbu78
 yndronq1Q5yeXU9cnwEwZH4wiW3/UDc8H3w8afOpmuBBMqW1J4vaWrzO2KXHZGYcOmYa
 cNVqLiCTWyOp7B88dtYQ3YtmwCNRBwTQsG3ZKeNuaCz5Fy5eEEBq+zbU4jn4A/V5K/v2
 BIJ1z3Tgpv0T9rAZeoCEqq1B8VYVpy6PhQqs5Vs7uDSS7OcPo0lIZRDfpaTKLKZsEcOF
 6G6zMcjS8LOjioluA69ZsM+bak/c9n1Gb10DB3TYp++n7Bx+HNnM5pTDDudP1TpBz6Yg
 9F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877749; x=1765482549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwr6SJXDzfiH4WLxERFX4BKWKQ004HtcOpP5D0SIEe8=;
 b=ub2yqUacfb+CcpAg7A4ptgohwLFVT5vQxAmXo8hoOpoCk1v/8hWRkRIxjxVSM1Y3pS
 D5qYd2L21bm+Sq2mswmBHE6dTMqqIC8ke1zoDTFPN0PknrQxkl7Vv3NJsL7w3zQkNRoo
 RZO4dqPSUt5Gg3FnKwu+2ZQlk9RLIwFDmSf0FCspLn08xwUpSsxHWO2qWzwrnDIuFsYd
 76qHxKBV5qttfDxFHsbhE6Pdir/jzwMJjqCEILAehJSXJOtDnW/P8ibVIvLprVoJchAf
 eFQ78qEg6KQ/DBC1Rfs+f4snP20HqUqHWkLXfQwC/q3lKexqcQTj2ivT4rq6ESoaNohk
 hsmw==
X-Gm-Message-State: AOJu0YxkWvtFpnBblXRXu7ktPPlvM6+LtDuIrwqol2trq6iLKFSNh0nE
 CqbPak+erV56sYPGogougPe9dbq7hJ4BV6Egf8IWAgTadTKP2/9X5fG0n4MB4Bykzxo=
X-Gm-Gg: ASbGncut4NMQoaAoRI/UgqvHw6xyr/ulaLzIrj82S40j7S1P3LVl2GgC3jIigfL2knK
 ba5V0noVUWbD5Ye4q5+/dDyDJ1aCLi/JOQs86eQDZuwBBuRvINYY0AlRbOC6LemiHsdy03DRIzY
 2M+lQnfoqzPeq0B2AO689n9jGpy082yz6PowbnnoNu3kJBTKUnB4FAPk8QF2xDKcY0ZZsTCn3ty
 wAi3+qmRcBiFD02fAKsw3JxHuPfYOAx9qwbIEcz0S/PXQRbxg0jC+l+oaGE+CaL5RS57iQMWeQv
 UcwBlcAqMn9cBegAVRU6JubesR5siyiltPy9Ii1PTtVuUB3ETcSE5quR/7lEhp4DrrhWdlhKq7e
 q95jN3PtbtUBdtNDG0Q8j8LcDqIEWKoaODZ6fOmWcgAx0d9alKztkWB8ZomvHkiwCAL4ZRI3M5Y
 SGY2fP+z4lYVs=
X-Google-Smtp-Source: AGHT+IEURp2ddX9F66ZN4UABL0j7NBn9KBTaQPiVCBVuW+HQwU/OkpDX93Ej1CQl0G7XOY3NDM8Xsg==
X-Received: by 2002:a05:600c:154c:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4792f28b98amr41995775e9.17.1764877749454; 
 Thu, 04 Dec 2025 11:49:09 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b14adeasm44348345e9.10.2025.12.04.11.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F6215F8FE;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 07/11] tests/docker: drop --disable-[tools|system] from
 all-test-cross
Date: Thu,  4 Dec 2025 19:48:58 +0000
Message-ID: <20251204194902.1340008-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

We use this container to build system images in CI which do not honour
QEMU_CONFIGURE_OPTS. Drop the --disables from the container so
developers don not need to jump through hoops trying to replicate that
on their workstations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 2 +-
 tests/lcitool/refresh                                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 1b01cfe8504..04d424c1a0d 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -90,7 +90,7 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV QEMU_CONFIGURE_OPTS --disable-docs
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index c5e936112c6..9df607a55f8 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -197,7 +197,7 @@ debian_all_test_cross_compilers = [
     "apt install -y --no-install-recommends \\\n",
     "${AVAILABLE_COMPILERS} && \\\n",
     "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools\n",
+    "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
     "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
 ]
 
-- 
2.47.3


