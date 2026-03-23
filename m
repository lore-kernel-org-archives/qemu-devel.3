Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE6BF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hen-0005b7-Kk; Mon, 23 Mar 2026 11:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he4-0005Eo-9n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he1-0007tX-DR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so335806866b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281404; x=1774886204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjPZC73viIsdKu1CaxgQ6rVZFRaPF///HYQPK4UbREA=;
 b=e7imMg2PsWq/sSAQW5nI3B5oqhFkVMOjBUb+FrVdP+HlRjkDrBhPd3ncSGDESw7Q0D
 rrKRUD1LkSbaMDkVESl33v7spdpGdKUXJ9nfuC0vTltIj/gomgGqjEatr5HWtkNTDsC4
 C/o9dYNn0Ox+WpAC2vjb4eifYzlwAc27rHi309XqxMt7zJFz4bzoEqWOuQVc/mZqBdCY
 BAB8ikua3NA5D+ViFQiiLTD4seyxOknCOctONyaOqD94Nicx+aXQSudN/Y+lWCGJREzG
 4PTtkVKTfWO1kYNpstPepnvx/utZDnhu1KK2gAcrEvj6yqxIhqrIwdmBwsc4SnUPvxj2
 S+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281404; x=1774886204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vjPZC73viIsdKu1CaxgQ6rVZFRaPF///HYQPK4UbREA=;
 b=qLUoKHgu/frSxuo6/KcRaQIXU40iZOHp3kBKV8LFEri34/67EsmvoBr3M3dyVExSOd
 tdUdgYUPvmUCEYWpRBdvJ64pmCp/cBEMMfwMGel++/nvA+R6AqBlI2Mr6SfwnMj1lpOY
 rk93VYzAPCLdheZa9mn9KH4YtaikcIShCy7ENsK1jDJ4lWPYqs2ppMfBjrinc6eu4Ugu
 DHVepPCks3VWfJdlw9h8HVljkDBTrPdNO9zb8rjbMsglisjNbWzWCrbY1SSj1aIjB/Go
 xgO92RQ0F5XlkFqvnPpNr6zSt1U6TS7EoyodgGPGWJcIX73gJPT7ZA1inIrCoQjmqfl8
 V84Q==
X-Gm-Message-State: AOJu0YxFXdkMoVCiTRcZLUEZLnoLvExk92u+2OWgWry8HbYDlzEz4fQv
 AM9Bnlo6Xea6hsWO9mVXG5kHR5D8sA5F/MTX+VMa1vLbYc8EK2TlUU9hpDyAOLVHDg4=
X-Gm-Gg: ATEYQzyfxcSNQyaoWf6cAhQAfc+vGOQWqQTRtIEpXGqO7XrGbkKvWZj1Dvxl0oXPHZt
 2eevM/yJ7t7gV8gkDNHeA0Xv2pJuLLzh3QJ5Dc8USZkjpWWk1vDRvbd8jbCdCQ84d4jJKyTpXul
 uuC/dpyiw+/XyZBYOUSmqUYCU9ZQ3dEJ/d1ttcCF2XOR609vSuSJHRS5smXk0/44Tw2qpX5iNtk
 hbb/r6rItsIq1ljVSPTvqgQDV3e90vT5CxFmys/SUSDzB2aqdAQRrT037fzpPtHMckM/0VeQZNU
 +NaY5Bbd78M/6jzs+5owAZDPlQAaoFFf+2nQJPsHLtC9jka1ZRPzfbzoPFMADY3eafjgPFa0bTy
 kAnAAgBHzmjA/itAN6P6Ll6yIfmr4kzFJ6w1JwXw9noBW5pi2wmlwno5I4zQVk4KK+snqVhK/4N
 dw38+hrBhdAvD/tTfiCkWBXjM=
X-Received: by 2002:a17:907:394:b0:b97:7157:e1d8 with SMTP id
 a640c23a62f3a-b982f362ce4mr676821866b.31.1774281403930; 
 Mon, 23 Mar 2026 08:56:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dff5sm509273466b.24.2026.03.23.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6297D5F8D9;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/8] tests/lcitool: Update openSUSE to version 16
Date: Mon, 23 Mar 2026 15:56:35 +0000
Message-ID: <20260323155637.145015-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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
Message-ID: <20260320155107.2143191-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 42c45fe47a0..eea90306728 100755
--- a/configure
+++ b/configure
@@ -927,7 +927,6 @@ if ! check_py_version "$python"; then
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


