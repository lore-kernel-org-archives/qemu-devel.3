Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C384CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEv-00032S-SF; Fri, 29 May 2026 06:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEu-00031I-20
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEs-00018k-2s
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso118764135e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049688; x=1780654488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8iZH5wMMYl2YpYU56gG8hyoUx+zCH4S+K5TbYl9f6s=;
 b=J6WlDwlfcsfEs9+EjmU8fl5njNZiOCTehWtJBwUGBWndqTvTI5COTi+BKQ65Ckd/1G
 gJfI+zP+sKsv4wYLXAnxRbt6MkUxvi/X7MZElXuGqctfNVRVeSolnvqtj2cxXEgsnawX
 CXe7/lXBqgDTtE88vZdqEhWAMYWAWcMxvMYprO8ZpPH+435757avXwFEt+tXwR5e//c9
 YupNjLijaGoCfwDG4vvfwAnu5HbXrXPvtEUwBRlgNGgA4NpznFJakX4kV7m0LmGGLoHp
 ayUSj61KQnkGs0yN8SORodZ4vwtlsUGZDfOUm0hRbHtx9VIS8fJsGcxiCmRBi67E/nWv
 3K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049688; x=1780654488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j8iZH5wMMYl2YpYU56gG8hyoUx+zCH4S+K5TbYl9f6s=;
 b=HUQWqo/NbMZiiMziIFHc49I+5XoM5dmRaQndJY/AYT9z03DMuA1uTv/dbV94TAHySi
 rQXueyDcgLGVRyS9YhKwfsT+ofnhdGVTljpfyHPtyG0WHko4c0A3GC5ZSltyaxcYf++E
 O6jDrERaZnzqfSUDEle2yQkTzugQhwPu+sUYxseBIj0Un+Y5zWB0vR2opKWvt1S9/AuR
 T0TrnB8KEVMxDq176AskO6Lxj3EjKChQ/NO0soiJtrwlK5dBPJDcIVkQbxn8rsdHf6ry
 oRmhVoUSuqKhg2MPrzg8+znVeVL1N61uTBSU30PtsHNOEvtbWcDhbMYDBairu9w8w2oc
 EviQ==
X-Gm-Message-State: AOJu0Yyl3KepLkCcG42K+1bMV/WrWO452mFz3T7cK7foI3mV1tcreS8c
 VZ+29SdWQ7gu6xyXvdR5KK8KlspZhT0UcUr+Ysk7zb7vKSYIRwUDg+RyQGIqtwLyiCA=
X-Gm-Gg: Acq92OGQX1UJaJgCfDn35oFHk8mBGJGzsmt4hlJWIs2DlFLonOkDnTJcOzBJsSPLN8o
 kOS9hBunM8/FGE4yEUN1dU1S6PZSKv6JhEGkgBOPqGsKhuLJJRuu2AS5Pe8N0kM/hrLUB4QnmX2
 y5k2R6rzQYOnPlFxTVzta5q9fzNXbtvgeIfc73W/Tgl4YCu9PsFsq/d5UypFeP/GCkQ/bm2Vhiy
 H3h41UIui1PHI/oY9/IXJtOJXtzuWYl3zjiNCwRyAHd3Sasc4fdO2Lyg1KQLQA4fIaV9SmBb2Hk
 yHs5AdTXcUHdk3lCf0Tm7JIutAq/Jab4ZOhCQANAVp61NrYHPLBUkG3kE/OVrs7zw/li1zIIkzh
 niZpnwxGUYvGsTQQ479aW9XMPNtDuiCyye0DKWltTjTe8p8jW+MNe8Y3AATV0n9jJv8TSubSUGO
 tzc3Dw/pJDw+aVSWb4h7zks3aKQMRzbb+moQ==
X-Received: by 2002:a05:600c:5844:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-4909c0ba8a6mr26684995e9.18.1780049688354; 
 Fri, 29 May 2026 03:14:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0f74fasm15172015e9.4.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 609EB60E17;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 07/12] .agents/skills: add qemu-testing skill (caveman)
Date: Fri, 29 May 2026 11:14:32 +0100
Message-ID: <20260529101437.410181-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

This provides basic instructions for running tests but doesn't try to
exhaustively describe the whole setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add link to testing docs.
---
 .agents/skills/qemu-testing/SKILL.md | 70 ++++++++++++++++++++++++++++
 AGENTS.md                            |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 .agents/skills/qemu-testing/SKILL.md

diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-testing/SKILL.md
new file mode 100644
index 00000000000..770aa7a457e
--- /dev/null
+++ b/.agents/skills/qemu-testing/SKILL.md
@@ -0,0 +1,70 @@
+---
+name: qemu-testing
+description: Find, list, and run QEMU tests (Unit, QTest, Functional, TCG). Trigger when user asks about tests, lists available tests, or runs tests in build dir. Includes sub-agent spawning.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+Need recent QEMU build before testing. See `qemu-build` skill.
+Official testing docs: `docs/devel/testing/` (specifically `main.rst`).
+
+## Test Suite Classification Guide
+
+Avoid running invalid/incompatible tests. Know the suites:
+
+### 1. QTest (`make check-qtest` or `meson test --suite qtest`)
+- **Scope**: **System Emulation Only** (needs `qemu-system-*` binary).
+- **Nature**: Exercises virtual devices, registers, buses, boards. Host-side test communicating with guest over custom protocol. No real guest OS/BIOS booted.
+- **When to run**: Modifying virtual devices (`hw/`), PCI/USB/ISA buses, interrupt controllers (`intc/`), machine/board definitions.
+
+### 2. Functional Tests (`make check-functional` or run specific `test_*.py`)
+- **Scope**: **System Emulation Only** (needs system binary).
+- **Nature**: Python system integration tests. Boots real guest kernels, tests OS images, migration, end-to-end setups.
+- **When to run**: Validating board features, system-level CPU features, full machine boot.
+
+### 3. TCG Tests (`make check-tcg`)
+- **Scope**: **Mostly User Mode** (needs guest user-space translation, e.g., `qemu-aarch64`), some system tests.
+- **Nature**: Compiles/runs real guest programs (e.g., SVE vector math, float tests) inside emulated CPU. Verifies translation, GDB stub, plugins.
+- **When to run**: Modifying CPU ISA translation (`target/`), emulation helpers (`target/*/tcg/`), software float (`fpu/`), TCG JIT compiler (`tcg/`).
+
+### 4. Unit Tests (`make check-unit` or `meson test --suite unit`)
+- **Scope**: **Independent/Global** (architecture/target agnostic).
+- **Nature**: Standalone C unit tests for core parts (glib, QDict/QList, crypto, standalone float math).
+- **When to run**: Modifying core utilities (`util/`), data formats (`qobject/`), crypto (`crypto/`), or floating-point math (`fpu/`).
+
+## Launch Tests via Sub-Agent
+**CRITICAL**: NEVER run tests in main agent context. ALWAYS spawn sub-agent.
+Pass build/test commands and build directory in sub-agent `task` argument. Direct sub-agent what to verify and report.
+Example: `task: "Go to builds/debug, run meson tests touching replay, report results."` or `task: "Run make check-tcg in builds/arm, summarize fails."`
+
+### Meson from Build Directory
+Use build `pyenv` for correct meson version:
+- **Example**: `./pyvenv/bin/meson test --suite thorough --list` (lists thorough suite tests).
+
+## Run Individual Tests
+
+### Meson Test Runner (Unit, QTest, Functional, softfloat)
+Run single test from within pyenv in build dir:
+`./pyvenv/bin/meson test [testname]`
+Example: `./pyvenv/bin/meson test qtest-x86_64/boot-serial-test`
+
+### TCG Tests
+Run single test for specific target:
+1. Go to target test build dir: `cd tests/tcg/aarch64-softmmu`
+2. Run test: `make run-[testname]`
+   Example: `make run-memory-sve`
+3. Check all tests: `make help` in that dir.
+
+### Functional Tests
+Run individual tests from source dir:
+- **Example**: `./builds/all/run tests/functional/aarch64/test_virt_vbsa.py`
+
+### Env Variables
+- `V=1`: Verbose test output.
+- `SPEED=slow`: Run slow tests normally skipped.
+
+## Report Results
+**CRITICAL**: Summarize results to caller.
+1. **Summary**: Success or failure.
+2. **Failures**: Excerpt exact logs (compiler errors, test fails).
+3. **Full Paths**: Provide **absolute file paths** to logs/results for inspection.
diff --git a/AGENTS.md b/AGENTS.md
index 207a0075ed8..0bbed8e5adb 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -48,6 +48,7 @@ If unsure read the linked `security.rst` document for further guidance.
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
+- `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


