Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60B6E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCtz-00027G-Ld; Tue, 07 Jan 2025 11:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCtx-000236-9T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:57:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCtv-0006th-BK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:57:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso15169060f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736269074; x=1736873874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2nl2q/jhmEGUG+F/0rLUrlSD8XWQpV+qDK7U0WrjiI=;
 b=ep1UI+ph1tfkafoqMiSs+87E1a+xmrIw95FPIQRlraBQsakLCgmET5SRQaaYEiaav+
 tGwApgixu7MHSp9kJRG9g6zejrd4ixwzQrQO1bnca0ZP/G3lvwS7D47UDQE22X5Lee0j
 7MDgRLU8qEKcdb3AS/i520g4dzUVbRcoGJdn32ibJO+JtDzsYNxTgLYClB84M/6RQooN
 TCMBk6HtB5SPSXH7SOATKEI0r6B6jFD+QBOT4dOk4KiSqKYfnzjf6q7aya19aXt+kpJD
 DnQirlOVB+7Lc+0MBNQoNTznli5fE6AAlMnsGq5a7MnkDip9iAdoi+bg2oHicPXXdQKf
 xNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736269074; x=1736873874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2nl2q/jhmEGUG+F/0rLUrlSD8XWQpV+qDK7U0WrjiI=;
 b=mdNp/cfGFO0ke8swRiIxc2QL79f/XLdFrhnl8Z+fPRSe1Qjhe/7+XTXt+ZzwFTlLvT
 qGgWZS4TZjtXT4A0y4aoopAjDi2SY08/LO39eIA9h1rUBmThKz3jXvPxnw5qvvka0pg0
 kjnwYX2NSRKeFYtVCvPxVetjWsK51nebXL2M/L6b+EIFK160nyttOTIlBFYbUky0MEvk
 G6mmxPKB9kN0QAoaTSGae0ZUVTmGmqMXObuKy17/qbNs3AuV+abmIMLvWWrc2Gl4vrPQ
 VWsYBTmPs5xYKHNnL+T/tyZIWmxr4huFRc87E/UZbJ65He/RTzueyUrMHjhWoGwM7jah
 DbxA==
X-Gm-Message-State: AOJu0YxbtaQN6uL2kwMa9pksS9mzocYypiA23l/SMHh1dKIQafp/KoNP
 qU+9fHHPTd7rE/ptmv9sL8Qb9Geixk/fKyV2RvUpua7PM8YhHPDhNSEglvb3ROs=
X-Gm-Gg: ASbGncsRs78mfkIV2bjSJbUIbZoGD+gyEU4n2f8Oa4yeWI3vVQ6AkjZyu5M/e5qtWgj
 Lf5zKLZr7ASFiVcnryTnhkA8rhNXniCYCh50roFHnVU1jMKpv6WU1qAQxmwBtuetupDfWcqS3gL
 5cIF6cVhMHrr8CPLzsd8ASx7dkel/UaygEVUeEeM41UHnG5Fe/jvZus2jexKHKxsZaqDgcLNTM0
 2UnvGft0n7n6gCsS1pmqC4jo9WsFo2OQutrWmrNA7t3ORfibP3RHlM=
X-Google-Smtp-Source: AGHT+IGRf/DUfHTpWX1mrFa1rZyRHPWojHW3ZkaRYvLYQTxAPMD/fqdIkKloQyWPx+nXncAI4HJpZA==
X-Received: by 2002:a05:6000:704:b0:385:fd24:3317 with SMTP id
 ffacd0b85a97d-38a221e2389mr51337852f8f.1.1736269073626; 
 Tue, 07 Jan 2025 08:57:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm605560395e9.14.2025.01.07.08.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:57:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB81C5FDC6;
 Tue,  7 Jan 2025 16:52:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 21/29] tests/lcitool: bump to latest version of libvirt-ci
Date: Tue,  7 Jan 2025 16:51:59 +0000
Message-Id: <20250107165208.743958-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

We will shortly need this to build our riscv64 cross container.
However to keep the delta down just do the bump first. As ccache4 is
now preferred for FreeBSD to get the latest version there is a little
update in the FreeBSD metadata.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars | 2 +-
 tests/lcitool/libvirt-ci            | 2 +-
 tests/vm/generated/freebsd.json     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 0a7ac5e0e1..0997c47af5 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9ad3f70bde..b6a65806bc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
+Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 3cb7fb7060..81fc38d798 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -13,7 +13,7 @@
     "bzip2",
     "ca_root_nss",
     "capstone4",
-    "ccache",
+    "ccache4",
     "cmocka",
     "ctags",
     "curl",
-- 
2.39.5


