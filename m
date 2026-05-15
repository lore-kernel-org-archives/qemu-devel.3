Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDB6CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRc-0005pi-Gj; Fri, 15 May 2026 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRL-0005dq-CA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-00027d-Eu
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488d2079582so94525165e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862662; x=1779467462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQX31A1tqiqfbm2dN9mlxX28T4V4bUJaqLs+j2vChl4=;
 b=IURAvZ87CYmineZHzuZb5xcGZEL77XurRBo9g+pSgCu8HwzRUzLFtPP9a4fvvvckLt
 BrhgpKbyB2O3uDelsytwe+QGBb8B1HUVjuZV2gfZakN+FAKqVr4z4HTGZrghz+njcGuY
 gSQNipapeMm6WNeH8zLspfee8yChWKWBLvmKGEjRh69qyXORDEAzYk9JZsN37FKAXvby
 ZMuv4fI/8NK+y2kWvjbU8KZ7eaoMq8oRPGUwppddbjek9/uoa3Rxm+dWL+ZVPIQ0B86L
 XDChdjp7wPkEr88pXVzXFlFr4n0W0eTRsmFn0nPVEW2Q3e4ob+3X8jmi+amnBk3ZvPw1
 cFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862662; x=1779467462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQX31A1tqiqfbm2dN9mlxX28T4V4bUJaqLs+j2vChl4=;
 b=T3qj3Nw/01eOFzbflhfKQ7fBWW8ATDNNBnPl+lAcxg9ycbpPWcZAKZLLud6R/TXYtL
 /Zc3KukTd+c8FekkNcxlo8dMpGJM3pr0XGQvVSHmdDJFBkIpncbJQAsumgQYkLg4jtQT
 qkvlnYheUIp2vowgyxH+z091CTkyHGgpnbAvGo17vhINFHloqNx7tuOStvFdFuKhGQ24
 3TI38arWPhXAzpodOqg9KArloPV4gtpvDAiD0uJ8e0o/frtZ3Dpvm3dP2Bo/Ujp446Mj
 NS4xp/dsG1P2OC6AEyBfrQATpP1e3vfeD8KIf/emM+OPJbPmotnlzes8lBI/34kg2dmq
 i45g==
X-Gm-Message-State: AOJu0Yy/Qp5MBetrV9+eIIhAvJKglNm9wvfnp/yRqA+gb2ZNZ5wusfHC
 ceA2ypEgmdD+yjmRRZRX328xBJuLyz+r4v6n13wfFob0w/iNsBIxYc71aQCvS7V0hyY=
X-Gm-Gg: Acq92OFlcahlfEhaZpamiU2EqzWLXurW2LwmekZhcliLHsDws8tyOy2O2RBs9wgSsmK
 qguxlNVOXo86n6IIDuYhmLt2v93mEyE7tlub3Zf8LfiZHhcmWUEFTPBl/tGhhqbnsXfp3D5dAk3
 NBNHQNLh5hsfmuwDhZALwXlUsQ3MbQzMy24+XaPOvQY2Z3/RkKTXr3tclomYTxKI1D8kThSIhpy
 br3w8T3MkEmzoQsodufFSDLO1f7vbxxlMsFt8JM+ZzHoQXF9ktmAMWia2RkT4Ni/sZd9uRFJZ2G
 t55hDvzFwbjqkWxfvpexdLsxJhOFTi29XMhG8rsYF+uTXlziKFXjhoi5o5XAEhxt5Ne8XV1sv2f
 OgL4++rX9Hycbb3MTZ2ls/AOEoqesdDQ7ClzvYIfTbGUjHaWlZ+PoUJ/85zv3gQWwFHgLCQYxnb
 Xz+b7+PLNN2SmL2C1UMiHGnOJklKpocJQ3XQ==
X-Received: by 2002:a05:600c:8b05:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-48fe632518cmr78871685e9.19.1778862662184; 
 Fri, 15 May 2026 09:31:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm68510035e9.2.2026.05.15.09.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6B5C5F8D0;
 Fri, 15 May 2026 17:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 05/11] .agents/skills: add qemu-build skill
Date: Fri, 15 May 2026 17:30:48 +0100
Message-ID: <20260515163055.1792262-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
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

This provides basic instructions for building QEMU.

Tested-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - add builds to gitignore
v2
  - drop ECA/qemu-helper-agent sub-agent language
  - mention configure --help
  - drop mention of full paths - not needed for compilation
  - moved earlier is series so code-reviewer can refer to it
---
 .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
 .gitignore                         |  1 +
 AGENTS.md                          |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 .agents/skills/qemu-build/SKILL.md

diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
new file mode 100644
index 00000000000..91819a0992a
--- /dev/null
+++ b/.agents/skills/qemu-build/SKILL.md
@@ -0,0 +1,50 @@
+---
+name: qemu-build
+description: Provides step-by-step instructions on configuring and building QEMU. You MUST trigger this skill whenever the user asks to build QEMU or debug build failures. It includes critical details on build directory reuse and spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+
+## Examining and Re-using Build Directories
+Before creating a new build directory, check if an existing one can be re-used. QEMU uses out-of-tree builds, typically in `build` or `builds/` sub-directories.
+
+1. **Check existing configs**: You can examine how an existing build directory was configured by checking its `config.log`. Run `head -n 2 builds/<dir>/config.log`. The second line typically contains the full `../configure` command line used.
+2. **Re-use and Reconfigure**: You have latitude to re-use existing directories when appropriate (e.g., `builds/debug` which is a general-purpose debug directory for whatever is currently going on). If an existing directory has the right flags (like debug/sanitizers) but the wrong target list, you can reconfigure it to keep the same config but change the `--target-list`:
+   ```bash
+   cd builds/debug
+   # Check the old config.log, then re-run configure with the new target-list
+   ../../configure <old-flags> --target-list=<new-targets>
+   ```
+
+## Launching Builds
+**Crucial**: You MUST NEVER run builds directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent.
+Pass the specific build commands, along with the required working directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
+For example: `task: "Navigate to builds/debug and run ninja. If it fails, report the exact compiler errors."`
+
+## Configuring a New Build
+If no suitable build directory exists, create a new one.
+
+1. **Create build directory**: `mkdir -p builds/test-target; cd builds/test-target`
+2. **Basic Configure**: `../../configure --target-list=[list of targets]`
+   - Common targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-softmmu`, `x86_64-linux-user`.
+3. **Common Options**:
+   - `--enable-debug-info`: Include symbols.
+   - `--enable-debug`: Enable assertions.
+4. **Sanitizers**:
+   - `--enable-asan`: Address Sanitizer.
+   - `--enable-tsan`: Thread Sanitizer.
+   - `--enable-ubsan`: Undefined Behavior Sanitizer.
+5. **Help**:
+   - `--help`: will give a comprehensive list of options
+
+## Building
+**Important**: Always re-run the build after making changes to the source code.
+
+## Reporting Results
+**Crucial**: After completing the build task, provide a concise summary of the results to the user.
+1. **Summary**: State whether the build passed or failed.
+2. **Failure Excerpts**: If the build fails, include relevant excerpts from the logs (e.g., compiler errors).
+
+## Debugging and Environment
+- **Verbose**: `V=1` for detailed output.
diff --git a/.gitignore b/.gitignore
index 4ccba871d16..83bdf3df59c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /GNUmakefile
 /build/
+/builds/
 /.cache/
 /.vscode/
 *.pyc
diff --git a/AGENTS.md b/AGENTS.md
index a34a92244e5..29a13ca01b4 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -31,6 +31,7 @@ If unsure read the linked document for guidance.
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
+- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


