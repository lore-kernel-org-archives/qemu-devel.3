Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEEACD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEs-00030a-Qe; Fri, 29 May 2026 06:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEq-0002zc-JV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEo-000157-1H
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso88685685e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049684; x=1780654484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJbmDwD7QY2sbhCAix0thNW2SHXGqsh5Qn1ZgDCmTzU=;
 b=WfyRO/CUxhQ7t5sIHwm9y7WqF15+noqfljLyeZPNXwi2dpd2Ql/Amsnn+0EftdUEt/
 s+rGUEb6aCAN56i/SYPomgZiifZQBBCyTzlb9F1NfYT2fckibTrCC6JsnzlE0ofoybgw
 PDotpBjl31+Y4SQac8JYG3KjpAip7ltkhWUHtp9iJLTQzAK2oVjghia6zFTah1/oZc4J
 sSWIvn0Z4vtjgi9+z1z+8RvtJ0kR2hnr+QfXy1cJQ5GvITdz5sPG91arB2uTPA10Zv6c
 kjN1+2p2PvpAjMOtGAhkwBbXHeDq88tuHLYpHxxAGloleLvR4AjpN8YRc69XLOnuaWo6
 n+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049684; x=1780654484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dJbmDwD7QY2sbhCAix0thNW2SHXGqsh5Qn1ZgDCmTzU=;
 b=rizHyWi8Q4+4I1EHsqHgR4RC3+9ScnHAvFkSe6V3liepWEdlbcgq/HYdOFIBNf9yMd
 Nm01smQpDB20b6c7u688kXKGa4s2uceTeIvT6flmrjqaw0Cq7k8wKqwlmwrMM8NoyfTu
 Xg3IlotC6yhl5hf4njFT9W5n29OSAtfSOV9vgseq+z4HibV0/Bqyf/yKrOFKPtYE64bC
 xa0utgn6DUEg1+qfgSlUSvdud9jZ9qWPxyxHOqbGSVfkWVadGLhoSFOPs50V4pFfPQr2
 cXX0fAw3hFBqF27EIn7qS+YnO/ZRhdlSMzuYazfkzvJSVTS3bSjc/HPFljN8iRVai6TT
 TkGA==
X-Gm-Message-State: AOJu0YyFJ9oDxIcEw0NIC0qejcw8CBS+sfvddkzKgED6G0JdTMa4l4o5
 NQ7vw2vU0BEDQe30cBIDofNR8moSg0ztgQCG+zKyyG7rzLrYFEuUFgwhrshHMRiiZek=
X-Gm-Gg: Acq92OE3yFoBA5z9dW4fyJtlO4dniLVi3eGg6z0SiO/U91s5ZfmQ4JUD0SVsnA7ldOk
 1Htd1PkkCVrxrgLQyC99urUZ+5Ig4rj5uEtnytOiAPv71bzee7rZe/8A5sSelmlBABzNQE3OfUk
 OQqzQN9SGk0qmCdOX4Enm9IEj0TZDrCjRy30wC+Yh97U2Lf1Kq38uJfy06zoq0nGHS1HTfDnDRc
 J+HoYoNNBlvYGbU/uGGWwyLBfz5atMJm5fwlfObdo1pbgGlj0qODE3bFpsXOOSUzuZhbCLpMWT9
 doo7GaL4qmaSzr5Wnh11PwamUS13hVLuDv7TEbDEzdt4hsp6Az38i3bg8GNPWzjSejn2cJGGztB
 /Bmlgg69xGpmwH7SKDAQ5OBkQpo+I7P4iJm0TMivMgg6Sx0//Rn2elLPJm+EcjdFD/xgr06OTfg
 h1SnAfHRAwaYvN95lu5l+P5BGCUqdGWaSYiQ==
X-Received: by 2002:a05:600c:3212:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-4909c078fd4mr25092935e9.1.1780049684008; 
 Fri, 29 May 2026 03:14:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0ad269sm11787915e9.11.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 470EB604BD;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 06/12] .agents/skills: add qemu-build skill (caveman)
Date: Fri, 29 May 2026 11:14:31 +0100
Message-ID: <20260529101437.410181-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
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

This provides basic instructions for building QEMU.

Tested-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
caveman
  - cavemanned
v3
  - add builds to gitignore
v2
  - drop ECA/qemu-helper-agent sub-agent language
  - mention configure --help
  - drop mention of full paths - not needed for compilation
  - moved earlier is series so code-reviewer can refer to it
---
 .agents/skills/qemu-build/SKILL.md | 49 ++++++++++++++++++++++++++++++
 .gitignore                         |  1 +
 AGENTS.md                          |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 .agents/skills/qemu-build/SKILL.md

diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
new file mode 100644
index 00000000000..a19010d70c2
--- /dev/null
+++ b/.agents/skills/qemu-build/SKILL.md
@@ -0,0 +1,49 @@
+---
+name: qemu-build
+description: Step-by-step configure and build QEMU. Trigger when user asks build QEMU or debug build failures. Includes build dir reuse and spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+
+## Check and Reuse Build Dirs
+Check if existing build dir reusable before new one. QEMU uses out-of-tree builds (often `build` or `builds/`).
+
+1. **Check configs**: Read `config.log` in existing build dir. Run `head -n 2 builds/<dir>/config.log` to get full configure command.
+2. **Reuse and Reconfigure**: Reuse general-purpose dirs (like `builds/debug`). Reconfigure same flags with new `--target-list` if needed:
+   ```bash
+   cd builds/debug
+   ../../configure <old-flags> --target-list=<new-targets>
+   ```
+
+## Launch Builds via Sub-Agent
+**CRITICAL**: NEVER build in main agent context. ALWAYS spawn sub-agent.
+Pass exact build commands and directory in sub-agent `task` argument. Instruct sub-agent what to verify and report.
+Example: `task: "Go to builds/debug, run ninja. If fail, report exact compiler errors."`
+
+## Configure New Build
+If no good dir exists, make new.
+
+1. **Make dir**: `mkdir -p builds/test-target; cd builds/test-target`
+2. **Configure**: `../../configure --target-list=[targets]`
+   - Targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-softmmu`, `x86_64-linux-user`.
+3. **Common flags**:
+   - `--enable-debug-info`: Symbols.
+   - `--enable-debug`: Assertions.
+4. **Sanitizers**:
+   - `--enable-asan`: Address Sanitizer.
+   - `--enable-tsan`: Thread Sanitizer.
+   - `--enable-ubsan`: Undefined Behavior Sanitizer.
+5. **Help**:
+   - `--help`: All options.
+
+## Build
+**Important**: Re-build after modifying source code.
+
+## Report Results
+**CRITICAL**: Provide concise build summary to user.
+1. **Summary**: Success or failure.
+2. **Failures**: Include exact compiler/linker error log excerpt if fail.
+
+## Debug
+- **Verbose**: `V=1` for full output.
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
index c751652babf..207a0075ed8 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -47,6 +47,7 @@ If unsure read the linked `security.rst` document for further guidance.
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
+- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


