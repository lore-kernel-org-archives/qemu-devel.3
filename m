Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE24CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYd-0000rg-An; Wed, 25 Sep 2024 13:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYR-0000Kk-Ej
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYM-0000bi-12
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3770320574aso10932f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284307; x=1727889107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXjwiUjPDmRUKmjejukivCx1FVXlutJ/frWtXF30WgI=;
 b=DmvUCoMWt6YjzQP5P9iNrwQIT794xzg1V+2HKnXggV2KY56PniGD3AHAQXp43laCqG
 I96q95z4osqcz05t+VfffePQgkvlKUuKpd36LJARnVjiyNC6buf3LeCboPoUyiDnMbIm
 k9gzTGec18NfMoBLbsyqyoRv/rIhEn1ieUdqUxInd6WxPdxH+uS8ht4yDsX/4A8sTnep
 WFLm6LxUAg38ltdBr7UMUsHAwAJfY6udakoNB97gkQdIevaON8HYeNaf+QbF6dg3JVTh
 w5vMPcyShbGyMjhFOmbBoK+5ooU6qyinH0TfE4viO1eH4mVu+LnsQd3Lu3biYgXc8oU8
 Ey5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284307; x=1727889107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXjwiUjPDmRUKmjejukivCx1FVXlutJ/frWtXF30WgI=;
 b=PeOOQoyRHbdnqhVQ3kKpGS1xukwkGOBdd2Bh9h88c3vBWYbtS6bNah3TMMYFcwZY+e
 6ghC/0lWJWKZP1o6+ATbKG1jwcjIz7nFS6HiEUfo8Pbd1geBwjnF5i/93RVgJi2LS4WT
 hRUfF8caAzx9hG9LIQysN7x8zhywaP6Xzkj51H44fEbimR2+k5ujp1veq5cwmf5O4r2Q
 OFL/vFcCc2OIRsF5f1UOLQIZgikjVtlPUsU3qfQbABERkIYRlfhXWlMHhQOJngD17b5P
 Onwk4TIf2D8Qamj9UaEXBQRyoZ9piQSoFTqHcy5b8vsQd66zrYJ9dKxR7PNIcZivpCaw
 T+iw==
X-Gm-Message-State: AOJu0YydLh+g+P475EgISW9e+sIqCcr5H7nxnoAyob3ZpfvYvpj8aCS/
 SI+Mfp8xMaRFnY8VSEw5OhjC8H3jUSYRqJYIykytRFZ0+lVX5FD17PdGS5Acwiw=
X-Google-Smtp-Source: AGHT+IHV6HV/eWaJfeffMpjzbiz3n6OhSG/OKMDSorPfnryDAPUV5GyUbaXuXJP53F/aVYvFjacx1g==
X-Received: by 2002:a5d:6685:0:b0:374:c977:7453 with SMTP id
 ffacd0b85a97d-37cc24762e0mr2263987f8f.25.1727284307287; 
 Wed, 25 Sep 2024 10:11:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e90274aa0sm35547145e9.0.2024.09.25.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8619C5F92F;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 02/10] tests/docker: Fix microblaze atomics
Date: Wed, 25 Sep 2024 18:11:32 +0100
Message-Id: <20240925171140.1307033-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


