Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FBCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRb-0005n9-5S; Fri, 15 May 2026 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRL-0005dr-D1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-00027r-Ev
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso6015e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862663; x=1779467463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZ2iWX33HeoG0R/fQ++7Hb1Satx2YRpoKwe+JWxXPCk=;
 b=nBcI+K37ZXDQ1ayVX2NANdsQAHIcMj/wsNU7fR/suUBIK0QDX6FBNOJxUgv7GgOL4j
 7i+rbUMVMevcm1wgpObsuLF2mjw2mHsXBADdl3GRgU4n60LSDpFtkVLgzah1rEyIt1cp
 Pfm0wf7pw+q4rkj5oOLtuiFN7Mp6HMlzI57Rm2HJgwakknhbISHHKGJ838JkRSfIS7Eo
 fCPJIXesGh4f4c0ibCr1xDcYPals/WmezR671mxptDIFNhx+s3udZ6KabJ0CGpG//PbG
 zDZwcSv4pZkKv6HEek09cJNfahZA3al1NKWXD2XfkGQNSX1+S1536A8D3BBrklYlmv0w
 1u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862663; x=1779467463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZ2iWX33HeoG0R/fQ++7Hb1Satx2YRpoKwe+JWxXPCk=;
 b=F/uwQ+ZX8lk6Wq/OtTIuTK4dCyKscqZlN9agecwdArq0NbhyrC2Nt+9UYf0kY1vyOP
 5oDerTxMPMnZMd6WnRq3wESZCXgCgEeebkeektwu8VGE8W5KhpcD8JefUeoF2sMrr2Vk
 AMYMWc1Uh5P3bFyuAlNQlZmNeqgGHotyBfpRmFljGWuyYWScRifhSk9DcQEw9JyB9Rw2
 wM/QoD/vkytAEzvZO/rrnkGIWb2EcsRYOVzOUr40nb8LTm5LQ2PAicRQ2AP4fuZM68rN
 5eBC/C0+0PKgKb2kdlfyfgJ0D0SUJ3b/aiTPAPsS8UMGRhKdP/pR2Al5la+Yu0Xvbc9z
 sP/g==
X-Gm-Message-State: AOJu0YyQFe/88c2Dk8qCoL+ZAVXroe237RhjKKPJo30i/+LalHhNG70C
 +sKhzXeHyzxGVt24PiNgbU/+VV3S8QHNBDCdux8oDox1KPRGOmqR7bdhSepHh4raSlM=
X-Gm-Gg: Acq92OEukLRF7fOePsOp6E5logFZxsRM96+G0MwC/31NJ84Skb1G8vl+C4XUcbNbnFU
 Jeb91RyxN4KDv9ZMTymt1SNB4y0Byo8EV0d70WoIWnOKo1Fplwn3M+UROaKW+jZBNVsnI9wmwfY
 wkdDM39fDkTXQQinUAu0r9a6n7Zq2aehhq1/efQhIttkYfrYn8yQNptJpJBoFpDGAqTOWtG/ti1
 6CZ2Nu9YgRdzmaWm0n+O4REAfi4DUd/wFB+sgcz6wkxMYDc8b0UmB8P4B95xCWdFmcNYNM1Rgeu
 uPoK7NzS00zrM/jN9nR/NpCaEWTNaStoN40Oq1K2B3fQV6nmMS0w3htSEZiLWLqOQxFKFgLUvVA
 E+n2lPiS1JOCyJxYkr/peffMBHs4swlCWZ5hhE2ZIlKi0EBw5C/w21hHrehpMBhf5sWuWCAX9U9
 Hmor+PAzZuzNLcuajPW+DhI4U=
X-Received: by 2002:a05:600c:8b6e:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48fe60ecc24mr74608155e9.8.1778862662802; 
 Fri, 15 May 2026 09:31:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab818sm73873195e9.14.2026.05.15.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 249585F954;
 Fri, 15 May 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 07/11] .agents/skills: add qemu-code-reviewer skill
Date: Fri, 15 May 2026 17:30:50 +0100
Message-ID: <20260515163055.1792262-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
index f5439282967..fe50057cef7 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -33,6 +33,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
+- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


