Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE5CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8izc-0006hX-2q; Tue, 14 Oct 2025 13:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8iza-0006gs-6x
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8izS-000239-J0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so4311523f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760463552; x=1761068352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rW3CBjkfIGxpQAHfCQx06BXel4TTCBxWxu+26fAtQf8=;
 b=O9iF5Yb9p6r5epaWplv/V6N7hDCpoUfS517lpnqGXkQnRaYc0+SbhaaWN0x/qAl60/
 dAA/2bIbyG75nu0UpVshQX7stbmQ8hFX/rnjXtpWBV1m2LLlSUThCIS/4IIaTmLPQ5KU
 3pxgfVBcWZ2P1Fmx1JBRaGvK/nJ3M8T+FJXLMOBLF7ueJuvZ+pDMRQ4eJ74taV4bN0g/
 UUUr18HeYkipXjaEtyvrcCThr2WesUEbAUaIRPBkr5nM5Arf/PPtRJhnm40XDS1uclok
 4pNEdM1spbBNHHCdQO08J7V4kkpPnhpLGD2GabAYYKO0erxw6liRmGEj+9qiJiCVk5k1
 ERWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760463552; x=1761068352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rW3CBjkfIGxpQAHfCQx06BXel4TTCBxWxu+26fAtQf8=;
 b=LRD5UvrAWijTrFY8LyuCM6uKsN53dFiIOWX6BVnUYdFCOflnKF6kOFnGTRQSrH45GG
 zsEhTCcFb9fbyTBh5OSGG06ik6ObQj2LyVDbGnbrw/aFUVTdfW8BuUXWC21WM9L6pc9C
 3sH8efKGcdkVBz9XtEvzXEsAxtffuR30xPTruIPzShV/9JqMv5WpykjsA+i58F/J92DJ
 /xJrPqEAgkdiv7z25crKK/uvmxiljv6o2is4D1lZ5ZH1MMNJZ9hk1Z4I20cfjRJocDKj
 Kv2H52VpzW5EkouiYSy2uMI8LCZq3ilzVHGVkbvBLjdpWGO8nEk4FmXbC2Vs0KX/L4To
 BbTQ==
X-Gm-Message-State: AOJu0YzK7/50E59kptZnBm6iAWRyW4Y28HTPL2Pvr2zQubthImY/6gzO
 lNPyw/0ZfwGupDpx4D16pNRXvxqepyaAVNAnaZ8RSvWForu5fDJIDQbSnY8xEUH/oA2YKi4UyVK
 VGDHG+4wTWivw
X-Gm-Gg: ASbGncsFnu9SO7JxjdeOdIm7Gan+2NWE8qylsER0jTtMffm5+rVicGvVVz+cAXEaEpZ
 12iLxverqvYcAY64EFq3IvOzZyo2uPGNQlFKq+QJOtZTC/ZNiY6bD+pPci6tylkjVxbqDctYcEM
 kpB0mSZ7tmLAyeXLKSEJojba+e8ZqCcC5gFz/OCdh6qZPlWQm/N8a4olFjNtG5eTAw4tlye4iQ/
 JvfbfYXLDDpAwvPsJP5OLhCuTpx+Ddn+Qiwd84uDljcMiO9Q+6dq782JEFT4zRwLV9+ef7+TzyD
 BKveDB3P00yOXw4hq2N7IaZ9WF42Ps9z0UDcBJsq91xJV/WBWyq9/do5rfj+isQqvc2KOMl0CDJ
 17i8Ws3NU8qQTWvrzdtGZ107gFeaYnbWODgyXIsfQNciWssCiNgCYlCWcFLc3WrpDhMZZUBaXox
 l/go1IwhSmFOwidNvOlOE=
X-Google-Smtp-Source: AGHT+IFYw8Ryr3VNlmGSC6jxDJ0pz3B4MRW52uJkgQ5NpF8h8xj/3o2UiH1WZlQeQtzwrQVbd3CJMg==
X-Received: by 2002:a05:6000:2484:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-4266e8f8008mr18642806f8f.38.1760463552303; 
 Tue, 14 Oct 2025 10:39:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8a06sm24742531f8f.55.2025.10.14.10.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 10:39:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/3] docker: Stop building 32-bit PowerPC images
Date: Tue, 14 Oct 2025 19:38:58 +0200
Message-ID: <20251014173900.87497-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014173900.87497-1-philmd@linaro.org>
References: <20251014173900.87497-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Besides, the Ubuntu
distribution we are using to cross-build dropped support for
32-bit PPC as of Ubuntu 18.04 LTS [*].

  Given the recent announcement that the powerpc architecture
  would be dropped from the upcoming Debian release, there
  has been a good deal of discussion about the future of this
  architecture in Ubuntu as well [...].

  Unlike the ppc64el architecture, there is no longer upstream
  support for the 32-bit, big-endian powerpc architecture [...].

  The Technical Board has therefore determined that the powerpc
  port should not be included in the Ubuntu 17.04 (zesty) release.

  The powerpc architecture will continue to be supported as part
  of existing stable releases.  Since powerpc is included in
  Ubuntu 16.04 LTS, security updates for existing packages can be
  expected until April 2021.

Next commits will remove support for 32-bit PPC hosts. Stop
building the powerpc Docker image.

[*] https://lists.ubuntu.com/archives/ubuntu-devel-announce/2016-December/001199.html

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                                             | 1 -
 tests/docker/dockerfiles/debian-all-test-cross.docker | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configure b/configure
index 461b53dd605..ce76a00aff1 100755
--- a/configure
+++ b/configure
@@ -1362,7 +1362,6 @@ fi
 : ${cross_prefix_mips64="mips64-linux-gnuabi64-"}
 : ${cross_prefix_mipsel="mipsel-linux-gnu-"}
 : ${cross_prefix_mips="mips-linux-gnu-"}
-: ${cross_prefix_ppc="powerpc-linux-gnu-"}
 : ${cross_prefix_ppc64="powerpc64-linux-gnu-"}
 : ${cross_prefix_ppc64le="$cross_prefix_ppc64"}
 : ${cross_prefix_riscv64="riscv64-linux-gnu-"}
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e60..08361cbe6b5 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -58,7 +58,6 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
   fi && \
-- 
2.51.0


