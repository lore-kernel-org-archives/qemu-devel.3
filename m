Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5325BCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4E-00015M-Mk; Mon, 11 May 2026 13:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU46-0000tN-FP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU43-0007nu-Ko
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2807996f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519105; x=1779123905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKodQmYNNWaAk1teiRNN0+JW1aqt9sbMYp1HKpx3s6A=;
 b=yYpbILam2SGaDpsfl6H2vW2T6pFiCRiAsD7DBAsnv37BSCg0F528dBo/spe1tSpXRD
 KAG7rxa4nDRobUrzTDWb30W4Rur7jbuDRcBlxz2mucZngH/Tm/YuBvt3GJP952O5YYns
 sexJikXO+pJILi9IT12PYxPU/7J6BmtokOMqlh2XWui1Z/A2auguCdKWsUrAL3RwRGSU
 GoioR91M9YctZfJME2cpY6jTi6jJKe89yQDBG41jQOQ/6nrScwTH1Cdy4T5rc171pZ7h
 5o7v6KCLj+l24KpGHgfnt4Dhub4SUdUA3uUfxs6rQMk4UToEzNL1rc4r7ZxFqWTW2qZE
 PW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519105; x=1779123905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKodQmYNNWaAk1teiRNN0+JW1aqt9sbMYp1HKpx3s6A=;
 b=Wo9WXd7YTopQJfN1Lzj3YFc63DcveBpuKwyeSKtPb44A7bw8ELHClmCgrV603WwsXx
 mm44Th+qwk0htwl3gu1uRS/wEsXwDQFBpU831QdrJd4Z0Wr5FmJ1v8PGECWA554BrTSM
 U3ustTYt120j4LUzmdpJor9zw0tf3f/284UcdEP1ndfRRdW0HZabb9XSpH9nwgM53OEg
 bj65XkkJUaZDzrM4oFHSvdk+1HsY0KZp5Illy1pMj8dWP0Gf75r+NYTiawZ406IWu6WE
 A3JQxTRPKTbzm8Lkc2vGPun4hOdPplqLXXLDF+9fTsnOy6Ugufm6jYg23o76CjJH2CQu
 EdCg==
X-Gm-Message-State: AOJu0YxmVvBKkSoY2G/Mg4GdPyAtbDdLT1+q2Pn8xzAV7emNCZ2KkU6r
 5yEao3pGnsNhN61kSJQ7KPVCPmdrkRJhrps5kcOpYoNYLgVeY4hLD+vPB9JFoVzKq74=
X-Gm-Gg: Acq92OHN+lvZxHJowUAOIIE33TIBt3afZ9o3eBacs3BvIk02M7xCCIuSQayGtCV9r9u
 O1er3nm9UdQ9XP26KSGgwLeL8BGFIlrkl4itgbpfcQFNU8oJt1Pg7JGynKoXg6zhAS5FPwyZB7K
 vZxsACzhWjedp8VRMWKgANpR/awSwtsDkuwEvOvpMQhyFPKEbX+MgFavTWdcugXNzSpUS8QTPxk
 meVCG4rXdC8Y7MOZGOzr68+vdOsm5Ipxv4SkazHs8laHaylVC/0YI4RrVOZ/7IAZlFt7tkZJ1vF
 gMs63RUgI3wclXinOOXJe/Jp8n5IHMwzIUV3tW2Df1u6EE4iGzogpf9ulLw8f1qM3Umb4nH0uR/
 J/pZyYWqMk94J755zoaTH+UGp5vpNMsCn/8leDls1fsxt5yvRm5HhCiIlVXWtco7AriqwYRwR/p
 eSQ/p5WPHsMqSJ/ekyQo+J30c=
X-Received: by 2002:a5d:5f53:0:b0:45a:cea8:e4b2 with SMTP id
 ffacd0b85a97d-45acea8e4f1mr248012f8f.29.1778519105432; 
 Mon, 11 May 2026 10:05:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45492271510sm32228022f8f.37.2026.05.11.10.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 022DC60814;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 05/10] .agents/skills: add qemu-testing skill
Date: Mon, 11 May 2026 18:04:54 +0100
Message-ID: <20260511170500.124211-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
 .agents/skills/qemu-testing/SKILL.md | 56 ++++++++++++++++++++++++++++
 AGENTS.md                            |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 .agents/skills/qemu-testing/SKILL.md

diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-testing/SKILL.md
new file mode 100644
index 00000000000..e5979dfc1c5
--- /dev/null
+++ b/.agents/skills/qemu-testing/SKILL.md
@@ -0,0 +1,56 @@
+---
+name: qemu-testing
+description: Provides instructions on how to find, list, and run individual tests for QEMU (Unit, QTest, Functional, TCG). You MUST use this skill whenever the user asks about tests, wants to list available tests, or wants to run any test in a build directory, even for simple exploratory queries like "what tests can I run". It includes details about spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+To run QEMU tests, you can use several different suites depending on what you are testing. **Note**: Ensure you have a recent build of QEMU before running tests. Use the `qemu-build` skill if you need to configure or run a build.
+
+For exhaustive details on the testing infrastructure, architectures, and specific test requirements, you MUST refer to the official documentation in:
+- `docs/devel/testing/` (specifically `main.rst`)
+
+## General Test Suites
+- **Unit Tests**: `make check-unit`
+- **QTest (Device emulation)**: `make check-qtest`
+- **Functional Tests (Python based)**: `make check-functional`
+- **TCG Tests (CPU instruction tests)**: `make check-tcg`
+
+## Launching Tests
+**Crucial**: You MUST NEVER run a test suites directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent. Pass the specific build or test commands, along with the required build directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
+For example: `task: "Navigate to builds/debug and check what meson tests touch replay and report back."` or `task: "Run make check-tcg in builds/arm and summarize any failing tests."`
+
+### From the Build Directory
+Most individual tests from within a build directory. Most (unit, qtest, block, functional) can be individually selected and run via meson.
+
+As QEMU often needs a newer meson than the build host you should use the build `pyenv` to launch it:
+- **Example**: `./pyvenv/bin/meson test --suite thorough --list` to see what tests are in the thorough test suite
+
+## Running Individual Tests
+
+### Meson Test Runner (Unit, QTest, Functional, softfloat etc)
+To run a single test, you can use the meson test runner from within your pyvenv:
+`./pyvenv/bin/meson test [testname]`
+Example: `./pyvenv/bin/meson test qtest-x86_64/boot-serial-test`
+
+### TCG Tests
+To run individual TCG tests for a specific architecture:
+1. Navigate to the relevant build directory, e.g.: `cd tests/tcg/aarch64-softmmu`
+2. Run a specific test with make: `make run-[testname]`
+   Example: `make run-memory-sve`
+3. Use `make help` within the architecture directory to see the full list of available tests.
+
+### Functional Tests
+Individual functional tests can be run directly using the run script although from the source directory:
+- **Example**: `./builds/all/run tests/functional/aarch64/test_virt_vbsa.py`
+
+### Environment Variables
+- `V=1` for verbose output from tests.
+- `SPEED=slow` to run slower tests that are normally skipped.
+
+## Reporting Results
+**Crucial**: After completing the build and test tasks, provide a concise summary of the results to the calling agent.
+1. **Summary**: State whether the build and tests passed or failed.
+2. **Failure Excerpts**: If any task fails, include relevant excerpts from the logs (e.g., compiler errors, test failures).
+3. **Full Paths**: Always provide the **absolute file paths** to the full logs and result sets for further inspection.
+
diff --git a/AGENTS.md b/AGENTS.md
index 08bfe13ebd2..d9d1964d45a 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -26,6 +26,7 @@ security stance. In brief:
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
+- `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


