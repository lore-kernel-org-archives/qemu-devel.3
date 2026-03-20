Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9661098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8G-0007bZ-2H; Fri, 20 Mar 2026 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c84-0007Y2-ST
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:16 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c82-0005Wb-Kn
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:16 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso233966466b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021873; x=1774626673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtLMyhKZH4sz8kIt9TlWF7CjiscfCuFlHPtCM7GrpFU=;
 b=uH5tJ9eNJ1WflTfCVokMdrqvd2AV2q1ofChTaLLeKAjjFCIV5zZY20tA3+S8Zp4oNS
 JkonkQzSk+s7+88WieQL+lfS4OILjg1iLyXOU+eVU/nnMypS7JlKI3nnHWtXPOu3A1BK
 7N7TWjhu6yQ1IxlcPUKhVnkPWSWUTX+4uLn855Hj5oDatTeGAhksgyXYqon19RTYbfO0
 3Cal55ri7IrrFgHBQwub5Q2KhhjjDnrTIuTVwX70XL1eb4BCjvJAGTgTqOfJSVL4vE6m
 iVQP+RYGC92E6zf18ysY9lyeQuIBgCBNPZfZOPS+UMKV/FzxLAylM+J29OD3FwsP2nVV
 keSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021873; x=1774626673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OtLMyhKZH4sz8kIt9TlWF7CjiscfCuFlHPtCM7GrpFU=;
 b=oHHzny+GBHwSGaqk37Zu3rQM1OHLrkEPwoPzvn5Cq8vTzMosAZfo+aOIO4IDDoGXjL
 Tg0tlXbPonuJwwLLp5bz9CZX98dnUkvvjTCRhSzb0r8yoyAlYf6sUM3lbWpNOmUdbsU+
 8I6aBw5JfxRq9m1+1ERxgzmSmzlZuOJvTzdt/iTytocDB1jbDZfmMCuAEQ4mOMYvP7Qu
 cLXgabhjBgDKesoH0eYF9PJ23qVROzgV5nBI2lBqgKozzpnp9ZVSYl069dE7l/NiCfkJ
 HqxoelbsmxkzXXsTa8v51Ap6fHXWKrLl4SdjvrpuUBOQimnFHxH8ZNG6s/anVxS7Cnha
 57bw==
X-Gm-Message-State: AOJu0Yx0ZNbRuerOJgHBAYjL7cNLFpsP7ls0YnflT4Lpu+048IzqlSm4
 +Hlqnqk353BTI/XgS1dpnuGDSgOnsWkqBOMaeemhVb4WTMT3E0iHvfgDcVF8mLmDImI=
X-Gm-Gg: ATEYQzzXRvAtYMZGHNJD0DvY8mgO1Zz1qV0KrtHAPutNJBQmvyQNupYD2psUOxULz+m
 C9fuhGsNKKDqa7R2MyWYrxKWXZxFt+etFssrl7UwBuXvn9AC18Vxze0RB4YYDESnVnkkbnZUTL9
 vz1JcsloOYjfIyNblcl8Q6zuVlT196upMLr2ssaIT+jyRrAC2vBSfofxaI+KQew+FnRCpaBiAWY
 HS6Zli0rwpauP9T2hrG8xiIITZMSkW0I/NXIF+7C6YQm7DPUWNt42IWpQwMJrW9fCc/K2Mb2RPf
 0GABtzEPQDU0Pcugc+NZ20uHGxfkKnf2t+zLhXvQhAKDQv0J97SxtqFjnsi/m2u8N9nt+JsiJVU
 3WgeKKcSfwzn2b7LAN4aSqtGg+6aoliqBq+FkhWVC04f9HPwwe7DNiVLtd+hw8Kri2+7NrYzoXu
 uKfYD/QYKeauNe/RfP6L1fujDFBaT0O1PozA==
X-Received: by 2002:a17:906:e94a:b0:b98:2493:4770 with SMTP id
 a640c23a62f3a-b982f28b4bbmr210614866b.21.1774021872746; 
 Fri, 20 Mar 2026 08:51:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43ca4sm174703166b.11.2026.03.20.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58BE25F93F;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 6/8] tests/lcitool: Update openSUSE to version 16
Date: Fri, 20 Mar 2026 15:51:05 +0000
Message-ID: <20260320155107.2143191-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Thomas Huth <thuth@redhat.com>

The first version of openSUSE 15 has been released in 2018, and
according to our support policy, we "support the most recent major
version at all times for up to five years after its initial release."

Since openSUSE 16 has been released a while ago, and openSUSE is
clearly older than 5 years already, it's time to update to version 16
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260316135407.209072-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                  |  1 -
 tests/lcitool/mappings.yml | 58 --------------------------------------
 tests/lcitool/refresh      |  2 +-
 3 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/configure b/configure
index cd1dadd8bb2..f3603fd9160 100755
--- a/configure
+++ b/configure
@@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
   error_exit "Cannot use '$python', Python >= 3.9 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
-             "  openSUSE Leap 15.3+: zypper install python39" \
              "  CentOS: dnf install python3.12"
 fi
 
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 60618971584..62fe60d047f 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -3,70 +3,17 @@ mappings:
   bindgen:
     Ubuntu2204:
 
-  flake8:
-    OpenSUSELeap15:
-
   meson:
-    OpenSUSELeap15:
     # Use Meson from PyPI wherever Rust is enabled
     Debian:
     Fedora:
     Ubuntu:
 
-  python3:
-    OpenSUSELeap15: python311-base
-
-  python3-PyYAML:
-    OpenSUSELeap15:
-
-  python3-devel:
-    OpenSUSELeap15: python311-devel
-
-  python3-docutils:
-    OpenSUSELeap15:
-
-  python3-numpy:
-    OpenSUSELeap15:
-
-  python3-opencv:
-    OpenSUSELeap15:
-
-  python3-pillow:
-    OpenSUSELeap15:
-
-  python3-pip:
-    OpenSUSELeap15: python311-pip
-
-  python3-pillow:
-    OpenSUSELeap15:
-
-  python3-selinux:
-    OpenSUSELeap15:
-
-  python3-setuptools:
-    OpenSUSELeap15: python311-setuptools
-
-  python3-sphinx:
-    OpenSUSELeap15:
-
-  python3-sphinx-rtd-theme:
-    OpenSUSELeap15:
-
-  python3-sqlite3:
-    OpenSUSELeap15: python311
-
   python3-tomli:
     # test using tomllib
     apk:
     Fedora:
     Debian12:
-    OpenSUSELeap15:
-
-  python3-venv:
-    OpenSUSELeap15: python311-base
-
-  python3-wheel:
-    OpenSUSELeap15: python311-wheel
 
   rust:
     Debian12: rustc-web
@@ -79,12 +26,7 @@ pypi_mappings:
     default: meson==1.8.1
 
   # Drop packages that need devel headers
-  python3-numpy:
-    OpenSUSELeap15:
-
-  # see above
   python3-tomli:
     apk:
     Fedora:
     Debian12:
-    OpenSUSELeap15:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 79a280feab4..e4d01d792b7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -226,7 +226,7 @@ try:
     generate_dockerfile("debian", "debian-13",
                         trailer="".join(debian13_extras))
     generate_dockerfile("fedora", "fedora-43")
-    generate_dockerfile("opensuse-leap", "opensuse-leap-15")
+    generate_dockerfile("opensuse-leap", "opensuse-leap-16")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
                         trailer="".join(ubuntu2204_rust_extras),
                         # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
-- 
2.47.3


