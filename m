Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19273CAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LC-00081g-LH; Fri, 26 Sep 2025 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28L9-00080x-LB
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Ks-000429-Sy
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso6958855e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892669; x=1759497469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/bRTlt+mHsgTlsr9RW/nD8staDPYyKjxTlCJTfUZE8=;
 b=HJutUhhXkahZKxenyFoPfcb5b8UKtf3wNjIPMOCLf0+Ufcbbmu5zpbNjo1S36fnOkV
 pzpXGxEgefsGD932cCGVXjxaQbLeVIfW//ISMZQLt01xd1RHep+g08J7IH4ZVCiPhGtz
 wGTFGUFsrXwkdxUIQVoXtduZYwm9ZjccKxLTk+K8Tmul1czulwC6K2k8SnlneKlA5SYF
 /CouVrd1ZNYCGpeMt+wY+fStS9jPY3ECW2qqHzpkozmyoeC7pJ4u3VzsFTRqTxqRI34K
 uiKRO/cpb1yto79l4/tp/tG0eE5OSJ80VOofwcUl6QsKrExBMBSempXl4nrfGBpGN9w7
 K4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892669; x=1759497469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/bRTlt+mHsgTlsr9RW/nD8staDPYyKjxTlCJTfUZE8=;
 b=kdpipfn7LwhuBAsa6MHOQDbVF3qx0NZ99aR7hkhAhWyIxFPAJ+LwmVC+42DYkED+ox
 gwT6exrehfTJ0fp/8Ph6w0RPGd6sq9hddrnWGyQgJsSsN+3FX/DbKtsfHcONfIjci1h7
 oTGtjz2E5Jst/JQPMQMR3fXI1ZHxpjFFGYsl8vGQe9VCYeenaNxSP74nFkGdgDwJvbeH
 8kUvByji+EsEzd21JZ9nhWGqWKXrZ8hwHzcmszQxybxhSC57f+u7Bn3RaeDJnM18ZtxM
 TUWHtShPzfTPzC8UpVVCPvgPey0d/SUYRG3hSn3m1GNBTRqgf3scBO3R0NeC4ZMfUBCn
 IRsg==
X-Gm-Message-State: AOJu0Yz136YE/kuZwWwtT0j3/5/KdKZt0yRKvDdJNgPs6fA+7HCmU8Vy
 sWSZPXrgT8B7Dqvo+7Bm3EqvFaOw4h8w25oVoPW5GRgSA4xNdtw/Y6YVc5ht8MMxg+E=
X-Gm-Gg: ASbGncskxRS4JmbKZamwOvpxfECUhqbGnbGXowofXOpJ4LhblCYdhhXG7K5J/RJ5u9T
 a9iCT6Ouv7MbA8jnakHubKE0sU/lWCsVUjgPmPaRUW5ioIVwzXIV7wTdOyZ0ZA43XFeC9QOJ7xJ
 onKlimtTwm/7ByIxrq0quL+e0V5iXPAsuyUa+aSjshcWR8PqfoLdV8wSU4pqRvy8ErgZJfFskQc
 NMgLi4Ji3PKvoaBKkTRXouFMG7XFEMLYEQOPkB4Icv3e7k/+54dcG5fgikh2t7X8YxC+LYMgE9y
 5gU5QKwNAbk0y6edOEJ3d+502/O6wzctrozWsqRFwuq+05gMJwkQifBobA50/UsFxdF7a5XSKIm
 dlv8XJQYHlgM+JkofLIkt8mUCjGAbbxRU5A==
X-Google-Smtp-Source: AGHT+IEoJsuvq3T1s/LuLL9mpKiE3/d0FvBOstG3kJOabwc2WvsVIPouUlA1QrCjkcjbKB0ZjXT9xw==
X-Received: by 2002:a05:600c:3551:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-46e32a13207mr69480315e9.28.1758892668509; 
 Fri, 26 Sep 2025 06:17:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bf701dsm73403215e9.24.2025.09.26.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C19CD5F7D9;
 Fri, 26 Sep 2025 14:17:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/24] scripts/ci: add gitlab-failure-analysis script
Date: Fri, 26 Sep 2025 14:17:20 +0100
Message-ID: <20250926131744.432185-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-ID: <20250922093711.2768983-3-alex.bennee@linaro.org>

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


