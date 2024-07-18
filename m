Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5141C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhh-0003Xs-IO; Thu, 18 Jul 2024 05:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhf-0003R3-Pn
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:35 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNha-0007cf-Jw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:35 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77dc08db60so63136566b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295929; x=1721900729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiL23Hf/vBV9ASWOfC+7pEltV8d4GARYopmJ0bnXGMI=;
 b=oAqv5y7efXP8VZJsMi9NkSSjAz1PDY2/FWnDQPravbv48re10J5Zz+4gpmiEqKI93N
 BiSrv57RKrVvhqgZSq0qElfezGSChzuUR/T5kmaxL9S0C5zs3lzLEM/4HCTT3H/ZtcGY
 bBfvnFJ5rjKSYi9PQJOsmJlbyJXOwtPneKEqqgsphY0J/WbkCa30RFnZrsgXQhs1iCuh
 iF3+oC7IV4ENGIci1csj3LvfEcksyaZHZMeAa6kS5xL5qnnj+FapMsMF4WS+GATJrES3
 ha2HJStXCj//Zgs0dMu9nZvTGjm4OPztI8VdQ//q4MlmBLhSPIxUGTp3ith2/GJNE/wX
 xr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295929; x=1721900729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiL23Hf/vBV9ASWOfC+7pEltV8d4GARYopmJ0bnXGMI=;
 b=fIpwKWG/l5IwxGZuDj4sBTCE8Z4d3AsZosrwbHyYuhqkxe0wEGJKikHYEPU2Lg4xRN
 n1AvWZVOn25fEDzZMS/BEJG9Wp3OMJARcpIUxto7OfrDjBu5FuNZZUQLOn5it8NqGY2G
 TcDAvu1Pqnq92aNtiqBMRJ5B3YTM8pzfuRBOsaDJ+HgSqlhRHZk9pedR1LP5Y6D6slF8
 UD60NehE7GBWnzOm8+bNYD3NmrWc/Ag9SEortCbNcM2mxOU+TGV0m7mH67V7tOs6+Ulf
 e4jDLrlWqE+h6AZJBwmVmwd5/CmQSyRtRDxLvg/l2gncAbMSwzfM5CGFAM9VVysGXdzG
 7izQ==
X-Gm-Message-State: AOJu0Yw77ZC48N8U0H3TlR8wzxcP4C5xgGHF8nCKsurICNiAa5rVjcFb
 sSP8yC/ssCzqcgETEY4Qiz3/YlV9xXltUCISQzvFw4MT5RqA2X/RNCqcKC6bPmY=
X-Google-Smtp-Source: AGHT+IGQI/pPnJuEEdIGRE6OkI35AhkDPbD5QaRD09+BbsYjY+Qm+7PPzuvxz801Cln92zyNtr+2eQ==
X-Received: by 2002:a17:907:c0e:b0:a6f:4e1f:e613 with SMTP id
 a640c23a62f3a-a7a012f6e53mr421023566b.37.1721295928544; 
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5d202fsm538844866b.78.2024.07.18.02.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13C9B5F7B4;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 01/15] testing: bump to latest libvirt-ci
Date: Thu, 18 Jul 2024 10:45:09 +0100
Message-Id: <20240718094523.1198645-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

This brings in the latest python mappings for the BSD updates.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus/freebsd-13.vars |  2 +-
 tests/lcitool/libvirt-ci            |  2 +-
 tests/vm/generated/freebsd.json     | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-13.vars
index 3785afca36..29ab9645f9 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-13.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 0e9490cebc..789b4601bc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
+Subproject commit 789b4601bce4e01f43fdb6ad4ce5ab4e46674440
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 2d5895ebed..2a361cecd0 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -51,13 +51,13 @@
     "pixman",
     "pkgconf",
     "png",
-    "py39-numpy",
-    "py39-pillow",
-    "py39-pip",
-    "py39-sphinx",
-    "py39-sphinx_rtd_theme",
-    "py39-tomli",
-    "py39-yaml",
+    "py311-numpy",
+    "py311-pillow",
+    "py311-pip",
+    "py311-sphinx",
+    "py311-sphinx_rtd_theme",
+    "py311-tomli",
+    "py311-yaml",
     "python3",
     "rpm2cpio",
     "sdl2",
-- 
2.39.2


