Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D04CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4M-00017W-My; Mon, 11 May 2026 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU48-0000yW-Tj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU46-0007pH-GI
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so54350885e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519109; x=1779123909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsTmcr1ROXhN8RCfX2ITQq2p88Z+pOcK43k57qJbwqY=;
 b=QjzOQp4ynQ7Fd/e2LToByvZN4RxFX4bbX7KzRWU78w6eY2gbwPSwQ6ZWmGSpZJuXm/
 qVN4sYG+C6/3w90rPOaI52xnsuAJdZh9Asc4QNxvVqjeFJB5X8bNzT/drCA5tEnKNOBZ
 nGcVPDxV2lLKvi5w+ksqgBIijh5NihBY1du2gfF3YR+F3yIliRUp5p1PKCPZMwO3bwCY
 8IStqRnF9c9XKAMll1UK4/aMVYooFaCEIFsuB/9orDnx7ALP4FjUhjDuhfYMlppb70t7
 9cYmwFPC3ObF90O5RozJRdzjLkZBEA07LK/XoNbGNasCDgL65ZzhQFlZmbUykmaXvKbb
 Ap9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519109; x=1779123909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KsTmcr1ROXhN8RCfX2ITQq2p88Z+pOcK43k57qJbwqY=;
 b=j1c/fNfqvxqhbLr7K5sA8Lau4cXvTEXqwQ1ybybG9B+icJGtZu7T1FnDpaMiqko0Se
 J3E4f8rqcSNsOz8VCC8UIhg/JAjMYuoY45/tsqhESUzd9AJ/lVJBpChRgFfDnFmzAzLc
 KKOFg/vdfatcGzMu8+JOmKZecGFD4em1V5uLfZislTMpK7RiBq06RoVbXNPwR7/PKL8Y
 sfyRVa84nGaHjTKMu3B9pcn4Xo1QQ30tGB6Y4kG7jkZq7v8/EdUkjkdC+psflxrWwRAE
 vdCePeoFadyCqpFfryF4sd0EB8taI9VwNrVXsP+glJ1mLr9W3Kg5fGwiWhn69exgrQqV
 3c6Q==
X-Gm-Message-State: AOJu0Yz5RFCOYdueqz4NKvSPqiVDI63GwLw+bdW7Ag+C1rysuYlwecm9
 yvo43p6q10nup5uKDpiA8MLRbt5C3fdlYrmwfJfU19lUaTPyeVjemwt0K8L1JvDK/hknuP9FCbk
 d+6DpUEU=
X-Gm-Gg: Acq92OFzJew0uatWR3KzDq/w+bDrAD3PsH184pxVzA4bhMNaiZslqlkln9xqmFfqQxh
 Ja7MRG1i0VdYmgz4IZiTYTdtu+zygI5EN1tTHHlTZ95RNprAuuDseEtnOxALsooy5vccvvrrm4l
 r0OVSqcityIsh6zMYkyEZNZmAQqfnzGRG1ssTc01XKXkMxMMkzY7xTiRfgau4EJlTLN9MwcBUe5
 gKlCDU1heoQMkBNnvjnL8rndqCHyltU6Cip1b28E1KlLY76X1WzjodBmSNXrvkt3Y7Hgc+S6F3c
 8brFFbiIf5xLjz+lz0cJS9HfablF+qnZgapfvGftfqGUte8QfZeRPDlKarnIBfU/OAKwWi91W2p
 Fza4o1M6l+k7k82BFj0DprX/noVxWlfKFo8NYNLLrqjMTBhPyzWWUQhzI/ff9PjNxK260IbGUJD
 wR3GOvwprZqlCyxmSe490VxXkAUhpoovMLSA==
X-Received: by 2002:a05:600c:8287:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48e706c0827mr164382305e9.11.1778519108767; 
 Mon, 11 May 2026 10:05:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e5efecbsm706815e9.15.2026.05.11.10.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ABA460822;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 06/10] .agents/skills: add qemu-code-reviewer skill
Date: Mon, 11 May 2026 18:04:55 +0100
Message-ID: <20260511170500.124211-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

This provides basic instructions for how to download and apply a
patch series from the mailing list.

Currently it is only taught about checkpatch but we could consider
adding common code smells and review comments that come up frequently.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - merge checkpatch skill
  - moved later in series to leverage build and test skills
  - properly reference qemu-build and qemu-tester skills
  - mention the qemu-code-explorer skill for navigation
---
 .agents/skills/qemu-code-reviewer/SKILL.md | 93 ++++++++++++++++++++++
 AGENTS.md                                  |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md

diff --git a/.agents/skills/qemu-code-reviewer/SKILL.md b/.agents/skills/qemu-code-reviewer/SKILL.md
new file mode 100644
index 00000000000..48ec6b07520
--- /dev/null
+++ b/.agents/skills/qemu-code-reviewer/SKILL.md
@@ -0,0 +1,93 @@
+---
+name: qemu-code-reviewer
+description: Pull and apply patch series from mailing lists for review and testing in QEMU, including style and build validation.
+license: GPL-2.0-or-later
+---
+
+# QEMU Code Reviewer Skill
+
+This skill provides instructions on how to retrieve patch series submitted to the QEMU mailing list (`qemu-devel@nongnu.org`) using `b4` or manual methods.
+
+## Using b4 (Recommended)
+
+`b4` is the preferred tool for working with patch series from public-inbox instances like `lore.kernel.org`.
+
+### 1. Fetching a series
+To download a series and prepare it for `git am`:
+```bash
+b4 am <message-id-or-url>
+```
+This creates a `.mbx` file containing the entire series, properly ordered.
+
+### 2. Applying a series directly
+To apply a series directly to your current branch:
+```bash
+b4 shazam <message-id-or-url>
+```
+This is often the fastest way to get a series ready for testing.
+
+### 3. Creating a local branch for the series
+```bash
+b4 am -t <message-id-or-url>
+git am ./*.mbx
+```
+The `-t` flag (or `--trust-all`) can be useful if you know the source.
+
+## Manual mbox Retrieval (Alternative)
+
+If `b4` is unavailable, you can fetch the mbox manually from `lore.kernel.org`.
+
+### 1. Locate the thread
+Find the patch series on [lore.kernel.org/qemu-devel/](https://lore.kernel.org/qemu-devel/).
+
+### 2. Download the mbox
+Every thread on lore has an `mbox.gz` link. You can use `curl` or `wget`:
+```bash
+curl -L "https://lore.kernel.org/qemu-devel/<message-id>/raw" -o series.mbox
+```
+*Note: Appending `/raw` to the message URL usually provides the mbox format.*
+
+### 3. Apply with git am
+```bash
+git am series.mbox
+```
+
+## Post-Application Steps
+
+Once the patches are applied, you should perform initial validation:
+
+### 1. Style Check
+Run the QEMU checkpatch script to ensure the patches follow the project's coding style.
+
+- **Check applied patches**:
+  ```bash
+  ./scripts/checkpatch.pl master..HEAD
+  ```
+- **Check a specific commit**:
+  ```bash
+  ./scripts/checkpatch.pl <commit-hash>^..
+  ```
+- **Check a specific file**:
+  ```bash
+  ./scripts/checkpatch.pl -f <file-path>
+  ```
+- **Strict mode** (often required for new code or specific subsystems):
+  ```bash
+  ./scripts/checkpatch.pl --strict <commit-range>
+  ```
+
+### 2. Build and Test
+Refer to the `AGENTS.md` or the `qemu-build` and `qemu-testing` skills for build and test instructions.
+- Ensure you are in a clean build directory.
+- Run `ninja` or `make`.
+- Run relevant tests (e.g., `make check-qtest`).
+
+### 3. Reviewing Patches
+Refer to the `qemu-code-explorer` skill for navigating the code base and resolving functions and where they are called from.
+
+
+
+## Common Troubleshooting
+
+- **Applying fails**: If `git am` fails due to conflicts, you may need to use `git am --3way` or manually resolve conflicts.
+- **Missing dependencies**: Ensure your tree is up to date with the base branch the patches were intended for (usually `master`).
diff --git a/AGENTS.md b/AGENTS.md
index d9d1964d45a..fbbc3b65ed0 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -27,6 +27,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
+- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


