Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D61C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpL-0002Tm-8H; Sun, 27 Jul 2025 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwop-0001ul-US
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:20 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwon-0000DS-2p
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61530559887so361515a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605188; x=1754209988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0P+T/rWVfYGmP03p8n51BDfhO6swy1gGfsWg4f3jEHE=;
 b=KeXAFb38Hx+sFNUs3LtL7AV7iyRf/jq9o3RSbkKKZyh6KSy583YJ2dhl4mkxMDteT/
 GR7cmBmehOA3PMNQj6MAFKEmff67z/RpOoAlRSDZgpAkUU3LXcYYaKloSI/hLKZsOlIi
 vCxktZnCFu8WrkNk2BpnrpMBWmCpOeOgaOuyAKNRJ3Edl1BVb8R4RqyJ5rvav31ncSJS
 FXTmJx0sEYdXgenZQDGeD/8HCa1v5j0wvRd5lljhc97/7SR42iW45TSlmJQpFyPTaedP
 VAxrg8uCbx+FJnVIQqMqLZL4t0clWHFNNfNiG2xH7C0AWnlmsS8TSHH+zzEaMsDzp0Dt
 UOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605188; x=1754209988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0P+T/rWVfYGmP03p8n51BDfhO6swy1gGfsWg4f3jEHE=;
 b=NOV6KQ5a5K4MMwXyJwQkSUH0/yrlhw+dz5yDObVEq7lGiB0F5tWtzoZ6jykBpzewEU
 1+HApQSKxlFxNvPWqgU4VAMZfNwf/zyTJCvQ6uUk4mKWMw02X+Zr1ZxJqt9veNznMP7/
 KBN06frYZKaStKInvGjlhJVsx/UG16/8ckxhqw+zkAavMXxntDrSpBHlGjAV4wyz3iY9
 NnGYdXoTzG+rJMpA3yvhxtgjolKKljPOQ+vDayE5sGZKiqPYfQPMQHRoiIToW7Xci8Bm
 LAMWrgl1kAvmquCPRdl3XzaKlYVAFtWg64vadTPxiplZHqcUZt3pI5WWRQYpRwRA86GC
 hB4Q==
X-Gm-Message-State: AOJu0YxEcVJiPumcdA6Vbt01Nb/8WTGcb8QMmPH9IE+D7j+tisvrcUkh
 26YKwKdn/ycxAEgB1QfhozEP4xOTf27RS0Xtl/x7WCNNhXNclvrwmySYPx3OGqvO7RI=
X-Gm-Gg: ASbGncsK4MI0HNKP26E73wXUf+6FXyToZKgAjsV3756H0YPGd6xqHERUPp+QP+ksXsU
 muvdH9Kue4qcMjilkIgTLtyCGZvuUdDXYe7uzhrgBJQTiHcP01felNA7Eex+Weq8oLbRAKlEH9D
 LnYsczqTLK3llWFGrM+a/6XchQrNyJZlda/4z5kOtPfj2d9SDPvgcy7zTdfx6CIG7NrEMrR2Io0
 tRsl74Ug1lx3x2VxhExA0C9QYWyLfoGGqN3R2Oun6AHgomjz+nOblSUDx6YvZWoo9z52XeozSU4
 3ead2gjFkMjOaFcott5G0dftjbec6wuQ5Z8Uu6kvwGC/UoyoDHiLxOTWg6rxAsTE9KkXFsUamdO
 lc4fp7NtCS2oceZBRNY+kFYc=
X-Google-Smtp-Source: AGHT+IH6kTk+HPrJ5IvoKo6LfSbVvXx702UwZlnSJzV6kKPU1U1L0MoSk+c18CnJ+LPAfeoV6dR6hA==
X-Received: by 2002:a05:6402:354b:b0:607:ea0c:65b2 with SMTP id
 4fb4d7f45d1cf-614f1e09062mr6930025a12.31.1753605188006; 
 Sun, 27 Jul 2025 01:33:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500aedddfsm1796179a12.67.2025.07.27.01.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 435725F8F3;
 Sun, 27 Jul 2025 09:32:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/14] tests/docker: handle host-arch selection for
 all-test-cross
Date: Sun, 27 Jul 2025 09:32:52 +0100
Message-ID: <20250727083254.3826585-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
Message-ID: <20250725154517.3523095-14-alex.bennee@linaro.org>

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


