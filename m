Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D54CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0e-0003yb-P5; Mon, 22 Sep 2025 05:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czH-0002An-UE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz4-0000dF-2z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45dfb8e986aso37501895e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533837; x=1759138637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsKBSNXGouODjqFbzXtr6MHfNWWtyiLAciJxtw6gymY=;
 b=W14YmG0MU6pRZxRSJ//7UCm8M0lxzH03+U3gfPI68YjEdUH2Jq6Bpx7i1PMSE7qqw0
 qZomsVQfAEY0B+pi6chGiZwOEIB/tRLnPfDgBL8wQbee6x+57Oi3fPsOGKajz0f8wH9z
 MNGXiOJAzOFdD3LZjjDpGY8gjWUQLz1ZNJd3y7zX5YPQruJDzVsA4g+bJMrNJOGBksCo
 2wa9njZLe0Aks0g2nkv9XJwdnvU5ZaNjyJX0uQzq21A1qyVEhQeff7f2El5jLn3YUrhK
 5uI4ci6VpxwhZhz4zSZMbh6UNA7/QwM2K6iAaTJtgbd3L7TpGhyhQW1IyosntETnTyNH
 nhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533837; x=1759138637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsKBSNXGouODjqFbzXtr6MHfNWWtyiLAciJxtw6gymY=;
 b=fItiIZEE3LhfJQT6NSfnNJSHJtP039OVTtBF+ejPmudQUD+i720z/hgCrN2fPPiRS7
 7co+V25joDTQ1Npi2y55QA1KrIF6ajYh6OJbctbawkRMMjSU0a0UrG3zQ1eUsxQbYNx1
 S0UJM2kvLVlmM4ty6PegWI/ZXpyWaDZ1rEzoYNl3tEbVRCZeMODE0UFtX+gDcpJr8aUW
 T6Ud8j3rn40Hk2+b4Py3tU43rWI2cokOnRnv5QsihqYjnurY3fNJeC1Y55rVgyyTRW9S
 anmJb9vP0CgnujwoxnktSJuhkl8TBiCH4+IY1jybpNtpz7ztK1cfA7xRA6086bTuHewG
 Zn2A==
X-Gm-Message-State: AOJu0YxqFlfz8XZfD9Xx6vFlRS1yFzRcZVjAZ0SxIXQIanbNegtMCrBV
 TOfbZ/c4SIdegiFHZFkiY+cCCB7v2mh8+S/59XwiWlF5UPV+SJzifmsm0RPAYSKEBeM=
X-Gm-Gg: ASbGnctaK9PJdX8WaxFwt3WQjis1o5IH57qiPerFCPypk8yBeSdeoKHDUWTwIz61hAe
 6nX0/x56q88OMPJxhVwhbsI/1SY9VqcfoMpDjqTetNKxGuuMPn7/y9lRrWWQvuUVnPGe1LGh//h
 kSp7oz+0Ugbz+OV2yLa4FkQ4mhK3KOcfmMNuuv2emnQOQLSS7syNYqL4brf1rDlB5k8fDzdzHyi
 0tVR2nOrVzKwxfbI2QhV3Wa5mvFnEuv0JTKGWkfJURIuXN7RFPvYX0+ORX8jcjAow4y2H6/96P9
 u0hqROktsNhAA1a0+2pimKiAIVq4QF7eeFdpZlV8EFJ8pp4xTnMPoahkvPv9pjoLy9h61X0n9Zz
 nuLfxYGx66eqPCo63dBS61eE=
X-Google-Smtp-Source: AGHT+IFIypwEWr8DwwXRt9q2058GETFtcA5IwQgWAc8iWw9WAXe+GbJKhxpFivk3Jk0kSuTLOE/8xw==
X-Received: by 2002:a05:600c:45d2:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-467e6f36218mr115147425e9.12.1758533837185; 
 Mon, 22 Sep 2025 02:37:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f190721esm192810625e9.10.2025.09.22.02.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD75A5F8FC;
 Mon, 22 Sep 2025 10:37:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 02/25] scripts/ci: add gitlab-failure-analysis script
Date: Mon, 22 Sep 2025 10:36:47 +0100
Message-ID: <20250922093711.2768983-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


