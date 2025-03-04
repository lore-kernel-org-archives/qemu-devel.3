Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D456C282DC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiU-0007BP-2A; Tue, 04 Mar 2025 17:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahA-0005SZ-Nh
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah5-0006ZA-IK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:59 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e0813bd105so9784496a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127094; x=1741731894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl3FvxWtvNwG3y+1922WYsiibfe37dBnVTxNDuvBYeE=;
 b=RmXgQVLOISEuh9CEtfKesy4t9IZ58BvWXTmsMjTVJOwHIS2rboU+5qTmAeiWnDELaL
 fBWER288znTdXHmcpeu8hh84p+7QDZ0zUIvvvq5ewhk+mcgmEelCEYbnEf3+ynrvTZ8n
 ki4sGkSi+713i1ejspIGx2g6QE9KZrXTiYf7sTKL5ENxvRhV8rVp91bLrtkxo5zuwlZX
 3bOkgXIld343F7Ot4BZjXL4E5ce/bgZ25Fr2K30G2RW9laaA0p+h5i6afsCSprcNbpIC
 YF8eQ7Eciog9ZR+aJy938zD7iGVmkWiU0Hn7j7gIYVnpCYPY7HxRzkxMT7FxMm+nCjGT
 elqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127094; x=1741731894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hl3FvxWtvNwG3y+1922WYsiibfe37dBnVTxNDuvBYeE=;
 b=Qc8hEfddlNwlfUo8JJWsEUKk+IteIfRJhLzlOEPhnJlprEjtHkOqYV32wErkQ7u7r3
 iAEqQIxzgJH6z9Thhy7uW7OH8JxBEx2NCV8yj9Bfgc3Jr87gXzhe56Fvq4vDAFcbDZrV
 HOFIHtjb0Z32RKyYevI4wo2kN8HohkIengTEvZhRPuPOxGBJI6KpIwd7YuFUAcH3Ubbq
 kR4zIOokjgjrPKFIU3P1XJgjk/gR9omh2/ga7IWDF/1RoEe/mIQBVVLum1sxn//5Shgb
 qKzGzJ3dWcQhVyd9/VMNq0fuveuGkH3DBeabvZkduKQ1uENIOK/zcDibUxnaQM67hHDd
 CrwQ==
X-Gm-Message-State: AOJu0Yw4PNnqrFtaW//gqsFdhsBm4+QehQyWbuncBAifuWf8cev1xnVN
 6FT0XqwNXB7c4Obe4SqLolXiwGEgBwJXMMiP9zEkuvbkWHCcllCVXLW8bq9kbyE=
X-Gm-Gg: ASbGnctqu9iydQ2abiccleCRz/1+Lkg+ixk4Fa6Zdg0niqJywtteOLrBboiP4nApN+P
 jTUKex5aLyxqRO7yplCcAAiW4zTcshTx5YoLmqo7GByf5gDuV7lsywT0qMm+AD1/1NyR7Kz4ZmB
 dFRQHkTgmRjXuWhZV4fk0KiI46DyPGE22xBbH1mH5jmeKC9FsztIW9PfO3+q0L/8Wf4d5+gKid3
 kBnnbWyoChZyh1pBSEKIPnrYIUg+FMY4sylM2V2nsSxwYw+kfRQOVSW3AFR6JzVgtHpwdBVR0ml
 Ld6FUx61+bUUf4eqHo1RNCYbryHRL8pGm1I3yegrcn5OV2E=
X-Google-Smtp-Source: AGHT+IEtdFd1HT9HQujwN9FXl0uLNEqGpRiBKXOhBXdbsks+r7XX0BI4DhQUzu8s5RGaKH1TywQGPw==
X-Received: by 2002:a05:6402:3784:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e59f3d67famr765205a12.13.1741127093846; 
 Tue, 04 Mar 2025 14:24:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb5ad8sm8715799a12.34.2025.03.04.14.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 32B946082D;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 18/32] gitlab: add a new build_unit job to track build size
Date: Tue,  4 Mar 2025 22:24:25 +0000
Message-Id: <20250304222439.2035603-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We want to reduce the total number of build units in the system to get
on our way to a single binary. It will help to have some numbers so
lets add a job to gitlab to track our progress.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - do all json in python
---
 .gitlab-ci.d/check-units.py    | 66 ++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/static_checks.yml | 22 ++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100755 .gitlab-ci.d/check-units.py

diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
new file mode 100755
index 0000000000..268a4118d5
--- /dev/null
+++ b/.gitlab-ci.d/check-units.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+#
+# check-units.py: check the number of compilation units and identify
+#                 those that are rebuilt multiple times
+#
+# Copyright (C) 2025 Linaro Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from os import access, R_OK, path
+from sys import argv, exit
+import json
+from collections import Counter
+
+
+def extract_build_units(cc_path):
+    """
+    Extract the build units and their counds from compile_commands.json file.
+
+    Returns:
+        Hash table of ["unit"] = count
+    """
+
+    j = json.load(open(cc_path, 'r'))
+    files = [f['file'] for f in j]
+    build_units = Counter(files)
+
+    return build_units
+
+
+def analyse_units(build_units):
+    """
+    Analyse the build units and report stats and the top 10 rebuilds
+    """
+
+    print(f"Total source files: {len(build_units.keys())}")
+    print(f"Total build units: {sum(units.values())}")
+
+    # Create a sorted list by number of rebuilds
+    sorted_build_units = sorted(build_units.items(),
+                                key=lambda item: item[1],
+                                reverse=True)
+
+    print("Most rebuilt units:")
+    for unit, count in sorted_build_units[:20]:
+        print(f"  {unit} built {count} times")
+
+    print("Least rebuilt units:")
+    for unit, count in sorted_build_units[-10:]:
+        print(f"  {unit} built {count} times")
+
+
+if __name__ == "__main__":
+    if len(argv) != 2:
+        script_name = path.basename(argv[0])
+        print(f"Usage: {script_name} <path_to_compile_commands.json>")
+        exit(1)
+
+    cc_path = argv[1]
+    if path.isfile(cc_path) and access(cc_path, R_OK):
+        units = extract_build_units(cc_path)
+        analyse_units(units)
+        exit(0)
+    else:
+        print(f"{cc_path} doesn't exist or isn't readable")
+        exit(1)
diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index c0ba453382..c3ed6de453 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -70,3 +70,25 @@ check-rust-tools-nightly:
     expire_in: 2 days
     paths:
       - rust/target/doc
+
+check-build-units:
+  extends: .base_job_template
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
+  needs:
+    job: amd64-debian-container
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Install Tools"
+    - apt install --assume-yes --no-install-recommends jq
+    - section_end setup
+  script:
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - ../configure
+    - cd ..
+    - section_end configure
+    - section_start analyse "Analyse"
+    - .gitlab-ci.d/check-units.py build/compile_commands.json
+    - section_end analyse
-- 
2.39.5


