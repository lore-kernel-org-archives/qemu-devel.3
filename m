Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A6FCD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEu-00031q-Rf; Fri, 29 May 2026 06:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEr-00030F-Qs
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEo-00016s-VL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso2635887f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049685; x=1780654485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igO2dMJx6H27AdxL4kiaNIOERV5w0/K2gQO7LMq6ZgU=;
 b=H1ezXYpbRtr0P/FEjepiV/xEvoovd6GDv2RKQ+0GdY3svBV30vHvTcZtb8oeII7O2I
 oMJV/i0ZaFJfCKnRgFroei6kaZu6zKJeCZm4kHpvwDHCMPZSp7NLqXm5do4Mr+rkkifN
 4FUCAjjul+z5KVXeKy/Yc5RKG8+kt6s7U6lccd5JUqojyqPpVZQB3xyKL/rgju6sUO9S
 6n10C77sXt6fyRE6T1cb+o9NzeCYpO6+v4pKaZhxSA+YjPuy7deItW58deL96M/s7K2r
 Igf8JuETFIiCwKlayYQSCfOb0nL3bhGxt91yy5Av8CtmhXWr8vz+oM1JR72U0eRvO45V
 yFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049685; x=1780654485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igO2dMJx6H27AdxL4kiaNIOERV5w0/K2gQO7LMq6ZgU=;
 b=VuVjIFTDw7uLTjfkJHwiBbkLyROXl16Lb14WTrASoVTwj0wnVYC/5xgFQUFvvg7e/x
 XXwybfdR6rw/d4/jVqArg9+OzK9XE315SyZ3f/zvSL4zh+sncZ2Iy71Jr2ASnlMuBwk0
 IYCfp5139YLMU3+xzXhRJa3Fsc30T5ueCU67kl6yjPxQGu/Q06plRPMoG7GXr2V2CrbZ
 IDpraqUnvLOaEc9/+dW5Xclk0Ez+Ech924ac+xfOIzw/4UBBdMqZb6uI++dMrO3ybfCo
 VO7eULUE2inRfjX51Jtlvf4q7nUPzUF9eKtpMR7TLbaeaWr0hjtwkaflDJ9H6/Avht47
 xOYw==
X-Gm-Message-State: AOJu0Yx1V/3ULHPJdG6YRAA8C/rdf3f1xFY9dzPNyvjPwnr/mb4dWmJn
 lFFvA6t/epi6V7Hcs4rZu1PZfxtjiZzYuSjaEERSXNbYkpwPWHDLgsxDob0WKnmkZOkeK6TNwin
 NMFck
X-Gm-Gg: Acq92OEkvppnS/QyHKNZUbiTG01igHKUviimNNrN0Nz/29PhSKHsn1DnHbLLZll9jew
 9omOKL8KzEnXuQQGe7oEPO+l4E4fkfG3DrDX5AgyKndIYjUfU2jcebUGerem2L7t0V/AKyc472i
 mr3tF7iS9B8itAw/MJMs5LWMbcOjQqkwdErYuuPutmdjyTTSjOcmvvWYsFnjLom52rMi9pypJxI
 X1xuUdXoQsBW9tvL2iuTGU1GsTaMCM3CrTwAU3udHYRaGlxg3/XgsDFmzGh6PNPgO04viQ+oWgt
 sZVibcQ0UEW516fxYlmEBDRxoCfCj+WFs7IqRwVp8MtNFS8cWnfw2s0NYVypP/JLJZP/IoMjGgm
 zyJNeGPHg2e2s1xGK/v0fsquqv5CZTwOq5cxezSJkJroeqfPlJ3LOGx9qMZo9Z+ApKby9BYdkpD
 kxvjsguuuMFW2aOc9a8DY7CxaFo45QfnaNLA==
X-Received: by 2002:a05:6000:491d:b0:448:7049:a6c9 with SMTP id
 ffacd0b85a97d-45ef14197f7mr4083914f8f.5.1780049685359; 
 Fri, 29 May 2026 03:14:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2485269f8f.17.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78DDA60E34;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 08/12] .agents/skills: add qemu-code-reviewer skill
 (caveman)
Date: Fri, 29 May 2026 11:14:33 +0100
Message-ID: <20260529101437.410181-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
v3
  - add section on dependencies
v2
  - merge checkpatch skill
  - moved later in series to leverage build and test skills
  - properly reference qemu-build and qemu-tester skills
  - mention the qemu-code-explorer skill for navigation
---
 .agents/skills/qemu-code-reviewer/SKILL.md | 98 ++++++++++++++++++++++
 AGENTS.md                                  |  1 +
 2 files changed, 99 insertions(+)
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md

diff --git a/.agents/skills/qemu-code-reviewer/SKILL.md b/.agents/skills/qemu-code-reviewer/SKILL.md
new file mode 100644
index 00000000000..8cda259408e
--- /dev/null
+++ b/.agents/skills/qemu-code-reviewer/SKILL.md
@@ -0,0 +1,98 @@
+---
+name: qemu-code-reviewer
+description: Pull and apply patch series from mailing lists for review and testing in QEMU, including style and build validation.
+license: GPL-2.0-or-later
+---
+
+# QEMU Code Reviewer Skill
+
+Get patch series from QEMU mailing list (`qemu-devel@nongnu.org`) using `b4` or manual mbox.
+
+## Pre-Application & Dependency Validation (CRITICAL)
+
+Check prerequisites/dependencies before applying patches to avoid build fails or merge conflicts:
+
+1. **Get Cover Letter First**:
+   - `b4 am <message-id-or-url>` auto-generates `.cover` file or prints it.
+   - Or fetch raw cover letter email (suffix `-0-` or `-00-`) from lore.kernel.org.
+2. **Scan for "Based-on" / Prerequisite Headers**:
+   - Parse cover letter for `Based-on: <message-id>`, `Prerequisites:`, or "depends on" text.
+3. **Handle Dependencies**:
+   - If dependency commits missing from branch, fetch and apply prerequisite series first.
+   - **CRITICAL**: Ask user permission (using `eca__ask_user`) before changing branches or resetting git tree.
+
+## Use b4 (Recommended)
+
+`b4` is best tool for public-inbox (`lore.kernel.org`).
+
+### 1. Fetch series
+Download series for `git am`:
+```bash
+b4 am <message-id-or-url>
+```
+Saves as `.mbx` file.
+
+### 2. Apply series directly
+Apply to current branch:
+```bash
+b4 shazam <message-id-or-url>
+```
+
+### 3. Apply with trust
+```bash
+b4 am -t <message-id-or-url>
+git am ./*.mbx
+```
+
+## Manual mbox Retrieval (Alternative)
+
+If `b4` missing, get mbox from lore.kernel.org.
+
+### 1. Find thread
+Go to [lore.kernel.org/qemu-devel/](https://lore.kernel.org/qemu-devel/).
+
+### 2. Download mbox
+```bash
+curl -L "https://lore.kernel.org/qemu-devel/<message-id>/raw" -o series.mbox
+```
+
+### 3. Apply
+```bash
+git am series.mbox
+```
+
+## Post-Application Validation
+
+### 1. Style Check
+Run QEMU checkpatch script.
+
+- **Applied patches**:
+  ```bash
+  ./scripts/checkpatch.pl master..HEAD
+  ```
+- **Specific commit**:
+  ```bash
+  ./scripts/checkpatch.pl <commit-hash>^..
+  ```
+- **Specific file**:
+  ```bash
+  ./scripts/checkpatch.pl -f <file-path>
+  ```
+- **Strict mode**:
+  ```bash
+  ./scripts/checkpatch.pl --strict <commit-range>
+  ```
+
+### 2. Build and Test
+See `qemu-build` and `qemu-testing` skills.
+- Use clean build dir.
+- Run `ninja` or `make` via sub-agent.
+- Run tests (`make check-qtest`).
+
+### 3. Review Code
+See `qemu-code-explorer` to trace functions.
+
+## Troubleshooting
+
+- **Apply fails**: Try `git am --3way` or resolve conflicts manually.
+- **Missing deps**: Update base branch to latest `master`.
diff --git a/AGENTS.md b/AGENTS.md
index 0bbed8e5adb..9fb9515871f 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -49,6 +49,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
+- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


