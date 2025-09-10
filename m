Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E8FCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 13:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwLH7-0003ZY-OT; Wed, 10 Sep 2025 09:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwLH6-0003Z3-16
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:54:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwLGy-0002AS-EF
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:54:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dde353b47so21311015e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757512442; x=1758117242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HsKBSNXGouODjqFbzXtr6MHfNWWtyiLAciJxtw6gymY=;
 b=fpiPhp+6Jm+iHwm6fGfbhXsWvRo4Tzclq1xSolaV+54tvg8CnM5To1r9xpVbgIxhAz
 5lERqDgkSgACR2wyDbKbd4rr9pCuUYDoUXeRGc1WacKUApjfrOBtZGRC9eb/v4Lc6uRL
 NVE7GzCm5TGc+NrRB0J52iDJLQHCMJl+cg8LMHIt3m5xtc8g/rQgkefQnDmMeNPM0ZAD
 UZmlOCmivQizZ5DCd7RXplxNIYViLkM8DJzAXDaQBImoXMybxiJxFzrjuPd2M04knGdY
 H/M/4Bb29p1mqa2LyT2hrQjGovh0biCffG0PjEmj5W4j3S/BcFPtcild9o/sMUHYfvJp
 R1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757512442; x=1758117242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsKBSNXGouODjqFbzXtr6MHfNWWtyiLAciJxtw6gymY=;
 b=kZdtpO4YHBrvaSXxtgWtQvb8Aje1BRQSTy5NRVxY+GExGMYwdBLRzDPLfLaUk79DO/
 cHpvonZTa6FilbMQt6ymIhxQitsbhxIoYYW5P0xS+jYdFBRrqxKWJyJdZcPIfj1tA4bv
 bf4bSkdmHZFw6W+JZtT6XjmjuXk60Agh1H/IU3JiRqG753WWFlKIk2bAbx5Dl7PBMYRy
 xlWtE4awiZKdYjyYhB1SBLoS51iGDbnpyJcbwOeUrSvR2N2li3AWyszfY3Jm0El2DlyX
 1Ya2npeXBvhtzw8WimAxaYbw+I8lHvk08OUYyrZnrKgLMv/9ZkuMVs4UNJFpq6hQiOgI
 17jg==
X-Gm-Message-State: AOJu0YxLpmHfnwF5L3I3LiPoxWaX94J8wDvgYse2ujdNgXKtLtuGj6Ac
 2DiU90tE8wcQJwU75LQHTW/Q3aeq//UJY14G2DtEkqXqnBCdqZKH/cNaKyParIH/r94=
X-Gm-Gg: ASbGncswflCFesSzaflDod+uPGYhxjALJUITaO5NMA5nbOSyImgyJAHoGnrabMFJMQX
 s7pyW5TrVrJHy0Ha+aXzGiPv6cL8ffhP16xR//kevQU9j1+S4fgjDnbzi4zqZTq9UOMZja/FRCC
 Jflo49yyGsfbteVrhAv2y6CrK/hO1R8fyNZ6GCZACQwSjXQMtUVkL4uBKBBTdi2KrKaTjolI+JN
 HGp3LP22YfUwcKt7r5jlWIBgWhzApLtje8E3AWrlAmH8MO5XVELKhEpjtrVJ5j3Mk+Stj7PNmyv
 5L1jaACO/Uwg0jsJQ4UVZMbvgDgKrtYNj0zVt8ZppZcB09ksy7XkUCzy45YhwmMSTNxTFZFwTr/
 4evhamSvndvoOY8tVZsMfqDkP3tg2v19xUw==
X-Google-Smtp-Source: AGHT+IEGH96P4Jo76weYObUN0cLXLaUIHEuCi9HH3gAQYsRB990bgFzESxDtlIP8fIIxUU6vvNJjlA==
X-Received: by 2002:a05:600c:3513:b0:45d:d88d:9ed9 with SMTP id
 5b1f17b1804b1-45df8b8ca57mr21767625e9.34.1757512441719; 
 Wed, 10 Sep 2025 06:54:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7521bff6esm6816746f8f.13.2025.09.10.06.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 06:54:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B68F5F82D;
 Wed, 10 Sep 2025 14:54:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] scripts/ci: add gitlab-failure-analysis script
Date: Wed, 10 Sep 2025 14:53:57 +0100
Message-ID: <20250910135357.3042016-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

This is a script designed to collect data from multiple pipelines and
analyse the failure modes they have. By default it will probe the last
3 failed jobs on the staging branch. However this can all be
controlled by the CLI:

  ./scripts/ci/gitlab-failure-analysis --count 2 --branch=testing/next --id 39915562 --status=
  running pipeline 2028486060, total jobs 125, skipped 5, failed 0,  39742 tests, 0 failed tests
  success pipeline 2015018135, total jobs 125, skipped 5, failed 0,  49219 tests, 0 failed tests

You can also skip failing jobs and just dump the tests:

  ./scripts/ci/gitlab-failure-analysis --branch= --id 39915562 --status= --skip-jobs --pipeline 1946202491 1919542960
  failed pipeline 1946202491, total jobs 127, skipped 5, failed 26,  38742 tests, 278 skipped tests, 2 failed tests
    Failed test qemu.qemu:qtest+qtest-s390x / qtest-s390x/boot-serial-test, check-system-opensuse, 1 /s390x/boot-serial/s390-ccw-virtio - FATAL-ERROR: Failed to find expected string. Please check '/tmp/qtest-boot-serial-sW77EA3'
    Failed test qemu.qemu:qtest+qtest-aarch64 / qtest-aarch64/arm-cpu-features, check-system-opensuse, 1 /aarch64/arm/query-cpu-model-expansion - ERROR:../tests/qtest/arm-cpu-features.c:459:test_query_cpu_model_expansion: assertion failed (_error == "The CPU type 'host' requires KVM"): ("The CPU type 'host' requires hardware accelerator" == "The CPU type 'host' requires KVM")
  failed pipeline 1919542960, total jobs 127, skipped 5, failed 2,  48753 tests, 441 skipped tests, 1 failed tests
    Failed test qemu.qemu:unit / test-aio, msys2-64bit, 12 /aio/timer/schedule - ERROR:../tests/unit/test-aio.c:413:test_timer_schedule: assertion failed: (aio_poll(ctx, true))

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - allow status selection, handle empty strings as None
  - allow individual pipeline selection
  - extract individual tests
  - allow skipping of jobs
---
 scripts/ci/gitlab-failure-analysis | 117 +++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100755 scripts/ci/gitlab-failure-analysis

diff --git a/scripts/ci/gitlab-failure-analysis b/scripts/ci/gitlab-failure-analysis
new file mode 100755
index 00000000000..906725be973
--- /dev/null
+++ b/scripts/ci/gitlab-failure-analysis
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+#
+# A script to analyse failures in the gitlab pipelines. It requires an
+# API key from gitlab with the following permissions:
+#  - api
+#  - read_repository
+#  - read_user
+#
+
+import argparse
+import gitlab
+import os
+
+#
+# Arguments
+#
+class NoneForEmptyStringAction(argparse.Action):
+    def __call__(self, parser, namespace, value, option_string=None):
+        if value == '':
+            setattr(namespace, self.dest, None)
+        else:
+            setattr(namespace, self.dest, value)
+
+
+parser = argparse.ArgumentParser(description="Analyse failed GitLab CI runs.")
+
+parser.add_argument("--gitlab",
+                    default="https://gitlab.com",
+                    help="GitLab instance URL (default: https://gitlab.com).")
+parser.add_argument("--id", default=11167699,
+                    type=int,
+                    help="GitLab project id (default: 11167699 for qemu-project/qemu)")
+parser.add_argument("--token",
+                    default=os.getenv("GITLAB_TOKEN"),
+                    help="Your personal access token with 'api' scope.")
+parser.add_argument("--branch",
+                    type=str,
+                    default="staging",
+                    action=NoneForEmptyStringAction,
+                    help="The name of the branch (default: 'staging')")
+parser.add_argument("--status",
+                    type=str,
+                    action=NoneForEmptyStringAction,
+                    default="failed",
+                    help="Filter by branch status (default: 'failed')")
+parser.add_argument("--count", type=int,
+                    default=3,
+                    help="The number of failed runs to fetch.")
+parser.add_argument("--skip-jobs",
+                    default=False,
+                    action='store_true',
+                    help="Skip dumping the job info")
+parser.add_argument("--pipeline", type=int,
+                    nargs="+",
+                    default=None,
+                    help="Explicit pipeline ID(s) to fetch.")
+
+
+if __name__ == "__main__":
+    args = parser.parse_args()
+
+    gl = gitlab.Gitlab(url=args.gitlab, private_token=args.token)
+    project = gl.projects.get(args.id)
+
+
+    pipelines_to_process = []
+
+    # Use explicit pipeline IDs if provided, otherwise fetch a list
+    if args.pipeline:
+        args.count = len(args.pipeline)
+        for p_id in args.pipeline:
+            pipelines_to_process.append(project.pipelines.get(p_id))
+    else:
+        # Use an iterator to fetch the pipelines
+        pipe_iter = project.pipelines.list(iterator=True,
+                                           status=args.status,
+                                           ref=args.branch)
+        # Check each failed pipeline
+        pipelines_to_process = [next(pipe_iter) for _ in range(args.count)]
+
+    # Check each pipeline
+    for p in pipelines_to_process:
+
+        jobs = p.jobs.list(get_all=True)
+        failed_jobs = [j for j in jobs if j.status == "failed"]
+        skipped_jobs = [j for j in jobs if j.status == "skipped"]
+        manual_jobs = [j for j in jobs if j.status == "manual"]
+
+        trs = p.test_report_summary.get()
+        total = trs.total["count"]
+        skipped = trs.total["skipped"]
+        failed = trs.total["failed"]
+
+        print(f"{p.status} pipeline {p.id}, total jobs {len(jobs)}, "
+              f"skipped {len(skipped_jobs)}, "
+              f"failed {len(failed_jobs)}, ",
+              f"{total} tests, "
+              f"{skipped} skipped tests, "
+              f"{failed} failed tests")
+
+        if not args.skip_jobs:
+            for j in failed_jobs:
+                print(f"  Failed job {j.id}, {j.name}, {j.web_url}")
+
+        # It seems we can only extract failing tests from the full
+        # test report, maybe there is some way to filter it.
+
+        if failed > 0:
+            ftr = p.test_report.get()
+            failed_suites = [s for s in ftr.test_suites if
+                             s["failed_count"] > 0]
+            for fs in failed_suites:
+                name = fs["name"]
+                tests = fs["test_cases"]
+                failed_tests = [t for t in tests if t["status"] == 'failed']
+                for t in failed_tests:
+                    print(f"  Failed test {t["classname"]}, {name}, {t["name"]}")
-- 
2.47.3


