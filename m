Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F3AC282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4Zb-0005SI-9A; Fri, 28 Feb 2025 12:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1to4ZZ-0005No-Gt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:54:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1to4ZX-0006iM-8M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:54:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso21795005e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740765289; x=1741370089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jtvMelRpMHPT9gIgF1y4kKqGNE8vJVEvR/SuEBPumP4=;
 b=zC+UbZvSxGiLqrwyVReJbbT76AqmTZf+G3YAbpr1Z/7+LeEoYB9gekFAKPBSCKxanU
 eXyXTa36DOrvki1Prirldp+j+d10zKmMrAVvi9+eJ328ZR228hU4Xa/kK/b/1ukFYbUz
 aOqERCWVUMHChhGRslZq+nSwcypKnDgrchchgXjB/3+V35fKnGm+WphkBmze7gkBrfEM
 Yz+jeNqgICbCct0SmX0vQPem+IXuCvhtv3Tcb0smGFZLefg6grFU3HEG1XYt7/X5D+UB
 K94sf95syhJQcCp7E3xbZ/ouDJ2XhVwyQYsoc3RDLxhIj+ViKWqur8ayi147BD0bmFnK
 uMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740765289; x=1741370089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtvMelRpMHPT9gIgF1y4kKqGNE8vJVEvR/SuEBPumP4=;
 b=mHfUxIG//MoQshUXrjF0hplgx1msAFPJv/E79y3viL1pyznmWAoqO9Culvn6svsbhZ
 S9E8kMYzIQKm8Ogw1jumvIv7mCkTyOjSYyK7lXujKBaulxMhQOdRsjxUefQ6pixppt79
 tSfgc2fzDK3kbmiB1A+02xbtsT3mKMq4BRlrl4trs76bOhi0EIsMKiyL+RBU1OsA0wnO
 FcS3FHTZsglIkdzuro6LocLVQzBbFGy97KXjD9Ua7BtUJPCo95AWgYrVmha5U0TtysdV
 LJPfD+e4ib/jH4c7xz9bvgkJeEgRvynl1v4Is+BMgqeVMX007CQX9iRTMpBApY5j7AP9
 pGoA==
X-Gm-Message-State: AOJu0YxT2nkCVCKdYwVUmaO1dJBPip8fjUc06vuR5loeozqBeSyVCuTw
 URrSfaiyN77orggwPdeHs1L7xbVc3g1Zzaq0sFtYdj3KO9j78XZf2EqtjxkBH2M=
X-Gm-Gg: ASbGncvHme0hDYJ/GOfIB4ZkVV1QoDjgz5qiFs6tbwt0fR0kUULhcV+9qGpOLI93tct
 DXlPvGoHpMhpMYn7fLjRTvMNmcO11/gtghbxhQ1iBCvQTPJnZvUIM6ruorXqlrky7CzgYsPo+ek
 lJQdG3+jgQnLkq4iAUydpTCznBMphgGrrVzMArsjoHGhmYmXaB9EgbktUreaUOsKNh7iiZDiRES
 epAOJcfRrqltoXMtMa6RHvJ0CQcS9U+axAQ7AKLehci1SoRRJlFFyvjhQw3PFd4ZGOPesAQ6G0I
 HV01aHKLQdivsDakjQsrCN8QAD83
X-Google-Smtp-Source: AGHT+IEEUmZW/ghjkQdLqnqP8A/kZ0JNuvsioQ6f+TTIDp2YbRs//2RhmU2AjUQyqVEfH5hhsYKJKA==
X-Received: by 2002:a05:600c:1c8e:b0:43a:b0ac:b10c with SMTP id
 5b1f17b1804b1-43ba6744a10mr29506175e9.26.1740765288904; 
 Fri, 28 Feb 2025 09:54:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73717230sm62409275e9.19.2025.02.28.09.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:54:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95B615F7DE;
 Fri, 28 Feb 2025 17:54:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] gitlab: add a new build_unit job to track build size
Date: Fri, 28 Feb 2025 17:54:41 +0000
Message-Id: <20250228175441.674384-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
 .gitlab-ci.d/check-units.py    | 95 ++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/static_checks.yml | 22 ++++++++
 2 files changed, 117 insertions(+)
 create mode 100755 .gitlab-ci.d/check-units.py

diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
new file mode 100755
index 0000000000..aca63bd481
--- /dev/null
+++ b/.gitlab-ci.d/check-units.py
@@ -0,0 +1,95 @@
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
+from subprocess import check_output, CalledProcessError
+from sys import argv, exit
+import re
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
+    # Make jq/shell do the heavy lifting
+    cmd = f"jq < {cc_path} '.[] | .file' | sort | uniq -c | sort -rn"
+
+    try:
+        # Execute the shell command and capture the output
+        result = check_output(cmd, shell=True)
+    except CalledProcessError as exp:
+        print(f"Error executing {cmd}: {exp}")
+        exit(1)
+
+    lines = result.decode().strip().split('\n')
+
+    # Create a dictionary to store the build unit frequencies
+    build_units = {}
+
+    # extract from string of form: ' 65 "../../fpu/softfloat.c"'
+    ext_pat = re.compile(r'^\s*(\d+)\s+"([^"]+)"')
+
+    # strip leading ../
+    norm_pat = re.compile(r'^((\.\./)+|/+)')
+
+    # Process each line of the output
+    for line in lines:
+        match = re.match(ext_pat, line)
+        if match:
+            count = int(match.group(1))
+            unit_path = re.sub(norm_pat, '', match.group(2))
+
+            # Store the count in the dictionary
+            build_units[unit_path] = count
+        else:
+            print(f"couldn't process {line}")
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
+    for unit, count in sorted_build_units[:10]:
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


