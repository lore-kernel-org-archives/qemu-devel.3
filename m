Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D07CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjGl-0008Ld-Gm; Mon, 08 Sep 2025 17:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjGj-0008J7-4r
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:19:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjGd-0003vK-Uz
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:19:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso41704315e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757366353; x=1757971153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xibwi7rfuEb3/Xo1PL7/uqC3f7xcE1du+2zcg8ZdWdg=;
 b=pItEuJT0uO2qO4zotUSrLTsA+ik3VWK8+/bHEKN1fcGNIvWD2F1NDM+wrebn6ziUH0
 k1064NqLgAK1mj+WXVCxYqFZ1zZWvYqK7PY+rqQqrjgRFxF826XD6aCUgXC18u0jq2mP
 /q+MnYlwuYRDo1ieeUaRBFv9/hQu/rzjMlct5fFrUF6vmdAMQpNqfl4CVl0GWlCny6tP
 FFqyiwGt6TchMGbTwZ8g7d7Oc/9kP9z4w76W66FzI9pwKtMnuiS+XBdcjYJnJhsC/BIw
 B8tSCa5/Y72OwPGhBzK6Nvgfj5ycFNM6E+DShvUf/1YCzfj8iAVyBwtkCPiFm/elnEXN
 xOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757366353; x=1757971153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xibwi7rfuEb3/Xo1PL7/uqC3f7xcE1du+2zcg8ZdWdg=;
 b=J2vs+7vZakZHcBpmUAioxEeOUJzzpJhTNd2ZQO4LdH2mUsy+ACebN+VxASxyFURW4y
 miZEwSMBV8K/O++A9jffBVM3Io6KtGhu+62L9GU/lT6vp645cgFTl1CALCuAJLGayj6Q
 su/eV+4JFVVngZIxrTCCiBwBoI/MNmfMkyWPnHj73df4mOAdUF2UAjtcPM3ofsBypyhE
 y2IXt8S8o5JPYOfsXPMgAYvv5gwp2R81LKJu6takme4FX2zaBti6phfADQ9/O/F+Vb0w
 HjIWaMgK97Mi+0jqvo43dE/2Qgmb5sv4lQMzSCqRlQo+JB1W5w00v+9I79aakRRd6lEE
 8a7g==
X-Gm-Message-State: AOJu0Yx+2wYiP9SBpuGjacBBAldzEqD+9gPyxA9UGwA8II9uE58Kw1b8
 7tMrSA7ElmVF0G2/6r4N/0PfGFI9j2llY457tGTgC+QLJTc4YqkstFen/rzmbfAwTb8=
X-Gm-Gg: ASbGncuxuD50VeVvbOkshEBcL4kaeYwInArxZhFC8NfbnQ0DI1qqq6Q6UrnPXfiqMKH
 3XJhW612F+B+wvIz7GQhh4T34KuGKGQdFirsaKephVqcB486AZWXCmwiJNi0+RdePfJAnbPYZZQ
 e8RSQlFbiV9pDs7CnBK7AOLSLeo+PpyXtZYQtgKWQ23knEFswPQ0UlfxqIi2ap024j87tSqApmY
 ke787AZHe/TQPGeln3IFYruI2Rf75SL1GhERONnz4F1GjXhiqaHprYIoana4o16uUTM965t7w2E
 5giL5k5ZkrYYxys+QIpGgqK7/oa50+kmQnQ41kLsxTGA4YkYXtG7Tx699EFtlzzccv1JRAGkbwV
 aV3CXoW70Udj2YyLdZW6OEmo=
X-Google-Smtp-Source: AGHT+IGriSglRiCWAEHjGRLvfsZbg9oa4kKSrIogTemoynZWO8yRNCWNobsBNJzrYAgxUdG+30PebQ==
X-Received: by 2002:a05:600c:1d16:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-45dddec9927mr113257245e9.16.1757366353390; 
 Mon, 08 Sep 2025 14:19:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45decf8759esm8250405e9.23.2025.09.08.14.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:19:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8DF75F7C1;
 Mon, 08 Sep 2025 22:19:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] scripts/ci: add gitlab-failure-analysis script
Date: Mon,  8 Sep 2025 22:18:59 +0100
Message-ID: <20250908211859.2678847-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
analyse the failure modes they have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/gitlab-failure-analysis | 65 ++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 scripts/ci/gitlab-failure-analysis

diff --git a/scripts/ci/gitlab-failure-analysis b/scripts/ci/gitlab-failure-analysis
new file mode 100755
index 00000000000..195db63a0c0
--- /dev/null
+++ b/scripts/ci/gitlab-failure-analysis
@@ -0,0 +1,65 @@
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
+                    default="staging",
+                    help="The name of the branch (default: 'staging')")
+parser.add_argument("--count", type=int,
+                    default=3,
+                    help="The number of failed runs to fetch.")
+
+
+if __name__ == "__main__":
+    args = parser.parse_args()
+
+    gl = gitlab.Gitlab(url=args.gitlab, private_token=args.token)
+    project = gl.projects.get(args.id)
+
+    # Use an iterator to fetch the pipelines
+    pipe_iter = project.pipelines.list(iterator=True,
+                                       status="failed",
+                                       ref=args.branch)
+    pipe_failed = [next(pipe_iter) for _ in range(args.count)]
+
+    # Check each failed pipeline
+    for p in pipe_failed:
+
+        jobs = p.jobs.list(get_all = True)
+        failed_jobs = [j for j in jobs if j.status == "failed"]
+        skipped_jobs = [j for j in jobs if j.status == "skipped"]
+        manual_jobs = [j for j in jobs if j.status == "manual"]
+
+        test_report = p.test_report.get()
+
+        print(f"Failed pipeline {p.id}, total jobs {len(jobs)}, "
+              f"skipped {len(skipped_jobs)}, "
+              f"failed {len(failed_jobs)}, ",
+              f"{test_report.total_count} tests, "
+              f"{test_report.failed_count} failed tests")
+
+        for j in failed_jobs:
+            print(f"  Failed {j.id}, {j.name}, {j.web_url}")
-- 
2.47.3


