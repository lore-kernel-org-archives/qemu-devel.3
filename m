Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A524CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9B-0007xn-2u; Tue, 05 May 2026 13:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ94-0007ws-KY
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ8z-0003TC-NL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso2372349f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000470; x=1778605270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jvc2PGTEz9rVEoAiSxMM6GT3z58PvEK27HCUa8g8+jE=;
 b=s76VmUb211UfhLOekv5Rw7E3x1g+H1uIt226NnyGJcdZKj8R48b/4+4DoMrLSA0jv6
 SgY59AIpMfLsUe/lqVMpQBhm/lnXKuSIcN1Iin/heHghgB9prW9RJh8UllUnjDSqVfiT
 rG9caimIoyaH8E8vPU+umLLQBX7zfEcyfExqu90FFiiqrfLlgCl7VLPuR4ofR7lt3BiT
 6yfosWJatLhhhgWzauPoKGI7H6OdZMuRzfB1QJxHLkRxlhEncP2O7/DgRlyMYQpYzOgn
 knMH5VlMtA+hmNOOdx+6u7pYdQ20xLDJJ9d6plAVgXe1dhhw7bs5nAwH9aSmlIugvsxz
 ADRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000470; x=1778605270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jvc2PGTEz9rVEoAiSxMM6GT3z58PvEK27HCUa8g8+jE=;
 b=rQvkvZkjks846BwKpO5i5ZUBGLsmHmWQZLfv20bmMdRJdOdlQyQ7QW1go8vgK/I1+A
 n2vLQemleVCxQVOJJOu9nDONKNBmhkLeyzvE22ew5XP4pYIM4I5cAj3RVwfEdu7uxDib
 0ajzgf2HDzmHZwdllTldfWofi19WEwAKEw7opVbV/VWJ7hnpC04bdxDwKf2XozXckW82
 1ziioKkEzCKLhnaU9lZ3a3TyNAWWLT//izB5kmvOu75WNWeE+ADHTMlS68DYCpbmHSAX
 5/ARw8NPUrK9caYTK53Pf5xtMuSBy7dWZEcYOUAI40ssenXGSvnNAX4cLx+Af3Hm+kYy
 p+SA==
X-Gm-Message-State: AOJu0Yz48IImT0Org8aiiXi/oTOhj77KZ4zc3RfQSx1YEmXulgpMdrXE
 vCE5rUQ8OEC4d+efWukXv9kYBVDgH2pM4kesyCX3mZeCfh+YxRYnfHs5lSdee/OD0QPnwqWvhSf
 OHeSE0+Y=
X-Gm-Gg: AeBDies5kEsKyOXu8LuSrOd7Iq0ArDj/CksFygy0K7tt/ZZhr/FEFZlrPlftq2kUbi6
 Ac1ToGD2yiEBNlDhafHnbjx4lesX3DUS9+nuK29f0U76gqWZG2WA4X+zXzH8NP+SbmCfqqlIJ5H
 Rir/mg+Uk9dI+lOxs54Q04dC+GUe0yNMaHt7fKuPjQNTlw6civnKuXI2WknAPe/44Y/LBFtQi9d
 YpYt+8yDJYYljLB/PiZXnoIXGwlxZMPtD1pP0Y4qnhA4R/KVIriDNGvl7Dp1I4eBekCa0b9/nLe
 sD2mI1MDbUHgNEdaYZZLd6TMqOYIvd/tQpm+oxWKDdwQ8yMsBOodkH+/jm6AIx6CWBwl+mAT1/7
 xVTmN6j/qHwU73rjvCRZLY5eADkrr2CN8KDactq1IaDmIaGHmZVQqEPCdYZzXssx6ih5N1+rzmm
 tV83T//LNaEK7zm1vEObzV6I/kaXDzZ0C1EA==
X-Received: by 2002:a05:6000:2088:b0:441:239e:2bb8 with SMTP id
 ffacd0b85a97d-44bb2f282d3mr25321673f8f.7.1778000469980; 
 Tue, 05 May 2026 10:01:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055e2d3d0sm5676376f8f.34.2026.05.05.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48B285FC94;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 03/10] .agents/skills: add qemu-code-reviewer skill
Date: Tue,  5 May 2026 18:00:58 +0100
Message-ID: <20260505170105.228162-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
patch series from the mailing list. It currently doesn't outline any
details about how to do the review.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-code-explorer/SKILL.md    |  3 +-
 .../qemu-code-explorer/evals/evals.json       |  1 +
 .agents/skills/qemu-code-reviewer/SKILL.md    | 74 +++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md

diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
index d41b21179c1..13cb71dd55c 100644
--- a/.agents/skills/qemu-code-explorer/SKILL.md
+++ b/.agents/skills/qemu-code-explorer/SKILL.md
@@ -1,6 +1,7 @@
 ---
 name: qemu-code-explorer
 description: Comprehensive guide for exploring the QEMU codebase using tagging systems (gtags, ctags, cscope), git grep, and build-directory grep for generated files. Use this skill when the user asks to find where something is defined, how it's used, or wants to understand a specific subsystem.
+license: GPL-2.0-or-later
 ---
 
 # QEMU Code Base Explorer
@@ -26,7 +27,7 @@ make gtags  # or make ctags, make cscope, make TAGS
 
 `git grep` is the preferred tool for general text searches within the source tree.
 
-- **Best for**: 
+- **Best for**:
   - Searching for local variables within a function.
   - Searching for string literals or comments.
   - Finding occurrences of symbols defined in system headers (e.g., `optarg`).
diff --git a/.agents/skills/qemu-code-explorer/evals/evals.json b/.agents/skills/qemu-code-explorer/evals/evals.json
index dff7afa52fa..131cf46e1cc 100644
--- a/.agents/skills/qemu-code-explorer/evals/evals.json
+++ b/.agents/skills/qemu-code-explorer/evals/evals.json
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 {
   "skill_name": "qemu-code-explorer",
   "evals": [
diff --git a/.agents/skills/qemu-code-reviewer/SKILL.md b/.agents/skills/qemu-code-reviewer/SKILL.md
new file mode 100644
index 00000000000..0c088fdda04
--- /dev/null
+++ b/.agents/skills/qemu-code-reviewer/SKILL.md
@@ -0,0 +1,74 @@
+---
+name: qemu-code-reviewer
+description: Pull and apply patch series from mailing lists for review and testing in QEMU.
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
+Run the QEMU checkpatch script:
+```bash
+./scripts/checkpatch.pl master..HEAD
+```
+
+### 2. Build and Test
+Refer to the `AGENTS.md` or the `qemu-code-explorer` skill for build and test instructions.
+- Ensure you are in a clean build directory.
+- Run `ninja` or `make`.
+- Run relevant tests (e.g., `make check-qtest`).
+
+## Common Troubleshooting
+
+- **Applying fails**: If `git am` fails due to conflicts, you may need to use `git am --3way` or manually resolve conflicts.
+- **Missing dependencies**: Ensure your tree is up to date with the base branch the patches were intended for (usually `master`).
-- 
2.47.3


