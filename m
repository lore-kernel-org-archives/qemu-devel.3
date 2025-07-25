Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329FBC87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKlc-0003hm-SM; Fri, 25 Jul 2025 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKjj-0001Vg-Ez
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:53:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKjh-0004W7-A3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:53:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso4340668a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458805; x=1754063605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrulWaSwIxFGytiImL4H5+DMK7ozTuMqwCSA3RbLeNU=;
 b=pzdta49QQ8RobqPB88GlhxHIQFrelR3eSmut/X+O8vJZN0I3ffjYEth6KHSdvo3nzL
 kXXbtRG+oMqnWRZ0C0xsNZGceYsaivhsjf12ymtGE9utvwinG4nzD9c0sTEM/dqeGef6
 es904AWWX38UYbR+eoNoRw94lkaUJwemtBT1LtJtPJeDSNwOhP5wR4BX0KxQAaTHVjMl
 RzaZpk4A67gDXWQoaAreIwlKD838egiYFNjiNEI+fFtYptfKmvUMLCbsrAwYAKusCVKw
 i6W8jPyiXQHyC3MFRFlaZYHkRNGWe4a07jy7DE2V1yrM0I0EAQx6Z/ubWPZvRRfntm0s
 +hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458805; x=1754063605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrulWaSwIxFGytiImL4H5+DMK7ozTuMqwCSA3RbLeNU=;
 b=jyI8jhDBxn6ZOSpkHg9QWTu4aCS9EiadLkXsmDqImpBqogdvGnuGVueYdXvtKpGwae
 +u+zxGBRijSCjdoNhK6+lZ5F7XZKmWhByselJejhD29vzpuIhP2P/5vs5WMtdwOgXLdJ
 vZy7Rd2j1cTopyQKdUpfDwAA8+mawS3il9HSnTe5yaLxHYR4airdf4AQ0KpzbQtrLxKL
 BNDvsexJJVac0QcMBZVF6j1MmecYOyxuLJCi/OKv2/1KodvHR7rL/g5DoRyg4ZBzkYNX
 CamRuZ47QacGslGNi6RQLQBZpxKmVsggaaYa8IvzfGf0pPj1/Hz1PX5LR0PxX7OivWTf
 2ffQ==
X-Gm-Message-State: AOJu0YxWM/BgepHKTMRCKjDd+pqUXNpKcTZFZDNMERDdcNYdLfFkPS5p
 r1Mty9FG8VjCNZs+XurQoJGeUMtrUHnWdEMQeSZ163hliUCbpAkEXebfKdZrbEFsmmE=
X-Gm-Gg: ASbGnctJ4fFRfk2BmtH9ugsKe9k9j4I21TcurW9F07Q412KxV/fjp1AnYP2ssg7Z8tz
 vYRA88wu652njjtktF0RySfgvVfC1JT12J28HliM1wf4YdcNHO+uWhgX9etlowLByDK+/VSyTmi
 9DJCkGMfNsIGjj4b8DpXD+70iuntRphHyJ/apkGCFONiJ6FctXU9hDjbS0SMoa1mAjOOLlbKraz
 VPlsNuySu+XbNgu1PlhdNJ1asmyzMovcGXpXRqzrsKMCMusZJDJEuDKGlw8dgMPYAE7L+ESRIO6
 r9uPxftk4/LGADTzoPub9RoxdwM9D8UX4tixOfHtmpOFNTTklhZldvQvpNYpn6i91d213EQcOIB
 Yn8BmcHrGc5g6RMR+BZw4ZiE=
X-Google-Smtp-Source: AGHT+IFF3hgbpssAvateYaMu3GTSDq8Qr551LSd7GjpC5ioMH2Zj0LJ+6Nxct/igeonmgdR4xM2OVA==
X-Received: by 2002:a05:6402:848:b0:612:a497:5042 with SMTP id
 4fb4d7f45d1cf-614f1f29c6bmr2537149a12.27.1753458805000; 
 Fri, 25 Jul 2025 08:53:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500a581d7sm19142a12.24.2025.07.25.08.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:53:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C0005F8F3;
 Fri, 25 Jul 2025 16:45:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 13/14] tests/docker: handle host-arch selection
 for all-test-cross
Date: Fri, 25 Jul 2025 16:45:16 +0100
Message-ID: <20250725154517.3523095-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

When building on non-x86 we get a bunch but not all of the compilers.
Handle this in the Dockerfile by probing the arch and expanding the
list available.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - expand all arches in a single RUN statement
---
 .../dockerfiles/debian-all-test-cross.docker  | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 5aa43749ebe..ef69bbc8a51 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         bison \
         ccache \
         clang  \
+        dpkg-dev \
         flex \
+        gcc \
         git \
         libclang-rt-dev \
         ninja-build \
@@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         python3-venv \
         python3-wheel
 
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        gcc-aarch64-linux-gnu \
+# All the generally available compilers
+ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-hppa-linux-gnu \
-        libc6-dev-hppa-cross \
-        gcc-m68k-linux-gnu \
-        libc6-dev-m68k-cross \
         gcc-mips-linux-gnu \
         libc6-dev-mips-cross \
         gcc-mips64-linux-gnuabi64 \
@@ -51,18 +48,25 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-mips64el-cross \
         gcc-mipsel-linux-gnu \
         libc6-dev-mipsel-cross \
-        gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross \
-        gcc-powerpc64-linux-gnu \
-        libc6-dev-ppc64-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
         libc6-dev-riscv64-cross \
         gcc-s390x-linux-gnu \
-        libc6-dev-s390x-cross \
-        gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross && \
+        libc6-dev-s390x-cross
+
+RUN if dpkg-architecture -e amd64; then \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
+  fi && \
+  echo "compilers: ${AVAILABLE_COMPILERS}"
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 
-- 
2.47.2


