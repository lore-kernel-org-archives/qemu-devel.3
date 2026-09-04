Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE5C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJP-0006CZ-EI; Fri, 04 Sep 2026 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJN-0006C4-Qp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJJ-0006ud-HJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso9440575e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525984; x=1789130784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dOSUepCPWAWiVnU7uqB1g6HY6ho0kwTrvzKaOUlf+Vo=;
 b=PN/vBmS1WrOQzRHALOaprlsQWnApQKSSboGfKqxD2JPqxdF6VKHKLsA0pvz8sRExPh
 1FXpS9JxJBHkqpqKf/f/1dWt8iWw8bFCtrfHAN89M+E5OWo0DnraVqadMRqCmEh1BIHi
 I7lGXJfrd+K7KyO+CPXnaKfqi+X6p42VAFTTX/CmddNeOmwG+HDYnISzOSoK7RSVTXAo
 /JuII6/fNHt/U0F2M5PHVjqDEtmxFZxhEVbNR79jR5pwFTraSiJy2EHtaYyl3YIXwPKV
 BP7MbzdZE4E0srKh1OvzRbQH86DntcgFP1LDudpnX6iXij7e42wIt09of7dTqMTqHYDl
 8V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525984; x=1789130784;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dOSUepCPWAWiVnU7uqB1g6HY6ho0kwTrvzKaOUlf+Vo=;
 b=qgLu4qWd4oe6KxAkqNsLnv3vyf0j1jPm7XHiTsvSvAeVtRvOvHYEAeplK8Hik81Lth
 Py84hflGAubgPlwFppPIEhhzNiVTHFenHinak3NS42AcLJ2h9kKBNPp1d21zClLrFYZ3
 K8UMFmxaCczQPPfd0m/FAB9Z8WPQnPVfzRfRLHDNP/ilFAwNgB7zzPPWlpwWUFY16KmX
 d2A6xq8rFn0UZOl2O4bsUphkrsXRykNNawIznQjtGKwh9O8eaecfQsXqkh4pDyVEaOGI
 jbG49w9nzhlI7Vy2gdKzscvCBPlmtWvA6t3vC6Ur2gg1bjW01z9qC4AyLEC1aaAG9pDe
 FY9A==
X-Gm-Message-State: AFuF++lfM40vhsGcQRjqg5SwhKyaWaL3Yr96SaWmORDjbp+KsT6SbxEj
 JVvpEoCHfVaUvJDU6Rsdy9Xim44fzdjxVgKvQ7eJ2ggVnJdaVzkRBrccQd+bN0Q1Uo4=
X-Gm-Gg: AYBFou38PMHErJbQUPWHMbBhlNg6fV1PDDurL8HQGMcrI/+ORbiKU7DdrM8LYLxdLbv
 YTIRgEE4mBVj8cfjq7/ygdpXPKC8m4QlFkXXd0gLFmGXSmjX3tJa3ABxaPSQhgWw47NpnJB2BGS
 znO2lRn1Jg/Yw5+i1TAMT4X7ytXYWUFKA1+3mPx8XBL9IUjnkYAl7/+EGIkI2dFPGpwDmN9x4EN
 jIFvx+XJo6kuCvNFL0cLnZeQvsLbRuSragyIhCHGd0SwMRWg7iu31d/OuC4KSoo6tNWbXbez893
 2cT8NMDk5lcLkncNDgsHx36UL6VqUU5XljP2t+riE9rvgVrmdkN5cag6bgfyTgff6SptwnSZx/r
 i/PygkU146zz3fSqVroMW9uUKq+dm/W64YnEAc0yHRGwcMdxgYQJfekGj2tpp0w9hlY7vRoK7uA
 7uXkCsfDTYybqJ0QX612gtm5igCnUFq8PIId8Xbc6FzuiwHA==
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49cf825c119mr105479445e9.16.1788525982619; 
 Fri, 04 Sep 2026 05:46:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm149526505e9.15.2026.09.04.05.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D60361D10;
 Fri, 04 Sep 2026 13:46:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 068/105] tests/docker/dockerfiles/debian-all-test-cross.docker:
 add or1k toolchain
Date: Fri,  4 Sep 2026 13:45:22 +0100
Message-ID: <20260904124604.2207440-69-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-69-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6bc611b0e6c..9a71af0e41d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -172,7 +172,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 833185f6072..c0ab05a5ff3 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
-- 
2.47.3


