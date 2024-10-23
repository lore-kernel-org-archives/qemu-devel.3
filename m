Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43DCCDDE6F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZdB-0007KO-OX; Wed, 23 Oct 2024 07:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd2-0007DN-Rp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zcy-00033q-2e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso8038746a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683249; x=1730288049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XNjfi7hRi9preQg6Skm6jboyJIHM73C5JCjrQ/Fxa0=;
 b=gSmwH/Q7+/Rr63a5baY/EhChgY05Q+7PZiQg5QMVSsfGV/n6SwHdDJrX6PesT8nIMK
 MzmwJjrzf+eucnctEoNIT3GNuFAMf1+5eoOnTPCbupzGMgseX1vvMP+AD5aQWqLPMFDt
 v/GdB8TpJGt4TJC12Lt6a95pR831IwU3cs+GZX/lSAFjQQLxhxOcbTajXKYtk9hXNl6d
 KSNgF95du3C5sTwTSKqeKuFJHfO+NOxh77lBSss1lNLoapIIFb9OxKgAKk+p+HEUtqD1
 ZTctnlWF9ctvXbGY9f8PdqNkzcTP7dfyAv1iHqjBc2W/UonqxXCJrPEGhaBXAwyPdmSh
 b2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683249; x=1730288049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XNjfi7hRi9preQg6Skm6jboyJIHM73C5JCjrQ/Fxa0=;
 b=XwjhhQ6acA6tEnJeWcqHTPslswawVkeH6H6cSRoQbzNxKFxBOMfyUv1z3hUWnRAd2z
 RY0wu4LDG1O5ub+TGy96Nw2dtJ0LnBYI5UsEJW0hbvefe6yCfE3AO3iL6M4ZDvbcqCBv
 ZGGNjMQ+8ONnJFRNGnFBqcdMVH+4mq1Ps86Ia0KTduHUQrAxWDsM49QFmiilkbuNXOOP
 RLO5r46fwQL4qGxwZaaHVRskmPADzKDRPJ02dmpZLKVCdmgjWaBtuyJTTsi1vDQAPFIG
 /bOE2dR5vDXhax29iZDBuFAyv4nma+3ADInfRuBxU3jfT7XnQs245N1mZhsJk1oMFnAG
 8ADw==
X-Gm-Message-State: AOJu0YyHiPW5TNzrF/4+sAZ/8GacI/odiT5ao3yTSDJ23IMFiEJU4khc
 M4aOb31xBUfjD49HTwMkcuVsGdl4DbBdDEx1eXfdoBLHGoclW3NLgE/U7gr6ols=
X-Google-Smtp-Source: AGHT+IHbBHuAhyUoRAK6Z+ouKhhEjsA1T4wrJBvMTAuUApw84TIFTJaW/QBSBiQQ9GXdgQDRf9QMxg==
X-Received: by 2002:a05:6402:434c:b0:5c4:51b3:d75f with SMTP id
 4fb4d7f45d1cf-5cb8af72080mr1849170a12.24.1729683248677; 
 Wed, 23 Oct 2024 04:34:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb766710d1sm2661378a12.90.2024.10.23.04.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11D8C5F8AD;
 Wed, 23 Oct 2024 12:34:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 01/18] tests/docker: Fix microblaze atomics
Date: Wed, 23 Oct 2024 12:33:49 +0100
Message-Id: <20241023113406.1284676-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

GCC produces invalid code for microblaze atomics.

The fix is unfortunately not upstream, so fetch it from an external
location and apply it locally.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241022105614.839199-2-alex.bennee@linaro.org>
Message-Id: <20240919152308.10440-1-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../debian-microblaze-cross.d/build-toolchain.sh          | 8 ++++++++
 tests/docker/dockerfiles/debian-toolchain.docker          | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh b/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
index 23ec0aa9a7..c5cd0aa931 100755
--- a/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
+++ b/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
@@ -10,6 +10,8 @@ TOOLCHAIN_INSTALL=/usr/local
 TOOLCHAIN_BIN=${TOOLCHAIN_INSTALL}/bin
 CROSS_SYSROOT=${TOOLCHAIN_INSTALL}/$TARGET/sys-root
 
+GCC_PATCH0_URL=https://raw.githubusercontent.com/Xilinx/meta-xilinx/refs/tags/xlnx-rel-v2024.1/meta-microblaze/recipes-devtools/gcc/gcc-12/0009-Patch-microblaze-Fix-atomic-boolean-return-value.patch
+
 export PATH=${TOOLCHAIN_BIN}:$PATH
 
 #
@@ -31,6 +33,12 @@ mv gcc-11.2.0 src-gcc
 mv musl-1.2.2 src-musl
 mv linux-5.10.70 src-linux
 
+#
+# Patch gcc
+#
+
+wget -O - ${GCC_PATCH0_URL} | patch -d src-gcc -p1
+
 mkdir -p bld-hdr bld-binu bld-gcc bld-musl
 mkdir -p ${CROSS_SYSROOT}/usr/include
 
diff --git a/tests/docker/dockerfiles/debian-toolchain.docker b/tests/docker/dockerfiles/debian-toolchain.docker
index 687a97fec4..ab4ce29533 100644
--- a/tests/docker/dockerfiles/debian-toolchain.docker
+++ b/tests/docker/dockerfiles/debian-toolchain.docker
@@ -10,6 +10,8 @@ FROM docker.io/library/debian:11-slim
 # ??? The build-dep isn't working, missing a number of
 # minimal build dependiencies, e.g. libmpc.
 
+RUN sed 's/^deb /deb-src /' </etc/apt/sources.list >/etc/apt/sources.list.d/deb-src.list
+
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
@@ -33,6 +35,11 @@ RUN cd /root && ./build-toolchain.sh
 # and the build trees by restoring the original image,
 # then copying the built toolchain from stage 0.
 FROM docker.io/library/debian:11-slim
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        libmpc3
 COPY --from=0 /usr/local /usr/local
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.39.5


