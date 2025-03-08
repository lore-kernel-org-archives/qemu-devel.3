Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17509C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dk-00026V-Gx; Sat, 08 Mar 2025 17:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DX-0001rX-EL
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:26 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DS-0001w1-Nm
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso1532645f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471216; x=1742076016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTSEMACn/0c5V64g3syCaGORLmqpk06iMyajsjrmkkM=;
 b=lDfIzRwgFb6wEVHFhPzssMJk6moPZsFF3BzBQLLXqolmIBrjSksfMJW5Awd0JU5HVl
 nKCm+fxd95qh01aorjAb2fWSyMRBC4aSw7K0tjcY5LvObNv6u0uWQZK48hFUTqhTKRIO
 2yNFSyi371DshywSwu4T3+0XrswGZp1T4xDHAOb/KDSulr2qm+n655Gy4cpeYm8YfqXJ
 iR3vOm/liQkuQUsZX2yCeUoDYtMYLlXXK1widWgUhgh/BSbdaZwEewq6UVh7uZIVLdYt
 5hHDr3t3avEGisu9nZE63D8oLUqGREkyXE0tMzudRKO7EMLo5uHClRcYAw8q2fVaNmTM
 wg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471216; x=1742076016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTSEMACn/0c5V64g3syCaGORLmqpk06iMyajsjrmkkM=;
 b=uwjz3SuYZaI1oF7JYT3f8WJaQW654fUT3tmrNGo4RozAaBlTtK3bep5zozIwuZMpKq
 /uPoGIF4CPjPcBBCNX9XeCIYDEddWnGYdJU9Pmzu4f1c22iqqN0+X65VVDHxdznZoAMq
 YjcpyQN+BvYv4z2XKY4/ehH8+dxOxeYGcrOMS0/yT5Wf5r5MaJHCQRhgUtpurPV/6rtS
 ngDVH1z/jQOPhNtKR+4HW6I6P69Gk0YfpbQku7LaaxmbTVIYefPfgJjaXFSUGXWOBPT2
 BD/Sd27SZuDjkwxVSsUzRn2nGTJJxTzskW2YnuYAkbH+cP1O5SOiktNsEFHvmA+LfYVy
 KhOw==
X-Gm-Message-State: AOJu0YyLxjTKkT0TNzSdQWf7xxYZDemOu+zuXpMZnkQiVfvhaOiwhAXQ
 0JZTOyEjinHPXvLnMoLjLx5CWq2XUBFWayaBDRNJRubnaRxBIQnuVyfs2/QsqNQ=
X-Gm-Gg: ASbGncuI9kO1zEZLGVfSMfVFVZHy2xi+DEfejgVIxKK/DN65WaJ6upAvLF6D7J3Jclr
 1mFl09LGO+HOOryaWzaYtx92YVDDdcC8lj8+K3sYAOeRxadIPmdHcjW1laJqmzBhY61ws2UsZwH
 m/U+nB5zH3t5f7BnFFly4VBrxycqA7RTHsyOmQyMob1qfJGalgLm/ZmPNKF/kvyXJC6tAP/xe80
 O7TPUwl+e3jSDmCXPhivYN4t6NQBVlDwub29Swz6kD+LO9JvMeSYDS2IaUEJHTDgSjsjo6Ldt9M
 S4JmP8rmmNOnfiD3AXlyibQWvIF6gKuRsHo8v1H0cXqtcmw=
X-Google-Smtp-Source: AGHT+IHYfYjxPrkXuOnOq+vY62bioRZRXxmlVPlDwKoY7XYC+i/711BHt+GUhOYmZzGc9U1Um8XFEg==
X-Received: by 2002:a5d:588f:0:b0:391:1806:e23d with SMTP id
 ffacd0b85a97d-39132d7a3b6mr4613227f8f.6.1741471216368; 
 Sat, 08 Mar 2025 14:00:16 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2bacsm9947154f8f.78.2025.03.08.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FA65606CF;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 18/31] gitlab: add a new build_unit job to track build size
Date: Sat,  8 Mar 2025 21:53:13 +0000
Message-Id: <20250308215326.2907828-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

We want to reduce the total number of build units in the system to get
on our way to a single binary. It will help to have some numbers so
lets add a job to gitlab to track our progress.

Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-19-alex.bennee@linaro.org>

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


