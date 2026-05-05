Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C5CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9C-0007yk-9R; Tue, 05 May 2026 13:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ96-0007xB-Fv
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0003TL-DX
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so53515125e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000471; x=1778605271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JD3YO6kL2cJ5U6rd4ov7BMMOq4YRoEaGP/uPsPkdEWA=;
 b=wpZIysz1Ig2sTeZpkksPGvSNjHTEcw3nbeaGybGBXe9OB9nM8CXJoLLcK0/qfOmwyZ
 Ds91SUWW7cHp/ya5hg/jbWBNyYOz8atF38Wcs/ZoOqjs/3orEaVbnE37GX1LAWU7YlSl
 DiM+TM8v/XUQfDIw1DS9/sNnk7p0LdgVic3XPOD8Dl756xK20mtxOcHeTfIGev57wqMk
 zxSavASZXgaJ1LbgtJoIetyl6m7io5eZdtndA3FpNWR9taNgvjSyaLnfaSI+Mt1YR2Av
 plp6uxSMoU3tUwBbiJpsWE/nJGVmake3u5tYB9wmxlFf1aPLX4OzUSdgIZ9IxtxZ5FWd
 pblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000471; x=1778605271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JD3YO6kL2cJ5U6rd4ov7BMMOq4YRoEaGP/uPsPkdEWA=;
 b=RwD/4AbM0TXxS2tU0ZZEpBqrBGUZ1IpLzA7jMjzEhnm/hxf5D6Ii0k/4sqj/zSXk/T
 rayRTEZ0P/IXzH5h8DgHV9j5mreWjtKSU+K6aqFEzFWYXrgI+h4DaJGBSPZ3G1eNXEhD
 5wPu1MkvvPOVuJrZAF0SkEHB3qK+7vAi5rmSGaUghbhLAQNM9bU1RigL58ONQw/U55Eb
 45mY4vRNpnjCOi7dFUzCvHssN7eufVjtq7tyhPF5eVilTzOZKP7HU8xwBkYmM7pkl3rw
 xOBkPp3GSkXsEpEa5pVJL6Zhhgb0YlNuS6Ka/87WGhYXb9WoQFhMyqzUVz2rq3NvuReb
 pPyA==
X-Gm-Message-State: AOJu0YygNh/rZXP+AKfaIycECehKPDc0GAe7H+c4GBcH9g+BwhYLmiA2
 MoKKYtvGVbmgJAC5O0ExfMYNCm6+GpsbWxhQpX3gsX0tFigR/LUfKMTnHexdOnUPVisB2RLBkSY
 DV389YdQ=
X-Gm-Gg: AeBDievYAa/cmFneDF347r9zka7chg3/n0URjAXyiG1li+mYkfPW5gQa62/L4oCxY8g
 8g1SW+T/QolaVCBnRJPMRw6JNlTKg+dsY8HtSUcVnncJcAaHFv4+ZCIsMGKMykIjjSiczT1l3h/
 wbLnBH3PrftmeqnHq7Ef9x8zpVZKLCQzbrgXnBo8Ltfg/rm38QXoDaTEZzmzFhlA8GxGmiZXKO6
 ObOg3ZuhMw+lm5+7kBu1NFe28zwKpj85WUYkBwWu+AE7lrxUo2ZkGNAIrRHzJgn0rsq8yjpOjBj
 ML3/XGZKHBmICYy1kMT22l5FeinN5Nde9kcgrzERAP6wDJjVy3/uYWNMtj5L99KqSqLI8tqKG8h
 DuTZAJbC70WUACTDjvW7Q2Hk9ijdLtVWHbtgrCrLgJb95oNU5SONnAHdKbDPk24DduWN8HysMdi
 5qyvW9ffXzXNczrnwjcTu99iPAzbLuaXGXDg==
X-Received: by 2002:a05:600c:4449:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48e51f2e67fmr1143785e9.11.1778000471044; 
 Tue, 05 May 2026 10:01:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301ad1sm651690355e9.9.2026.05.05.10.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72ABA60223;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 05/10] .agents/skills: add qemu-build skill
Date: Tue,  5 May 2026 18:01:00 +0100
Message-ID: <20260505170105.228162-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 .agents/skills/qemu-build/SKILL.md

diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
new file mode 100644
index 00000000000..a78678ff632
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
+**Crucial**: You MUST NEVER run builds directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent using the `eca__spawn_agent` tool.
+Always use the `qemu-helper-agent` for these tasks.
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
+
+## Building
+**Important**: Always re-run the build after making changes to the source code.
+
+## Reporting Results
+**Crucial**: After completing the build task, provide a concise summary of the results to the calling agent.
+1. **Summary**: State whether the build passed or failed.
+2. **Failure Excerpts**: If the build fails, include relevant excerpts from the logs (e.g., compiler errors).
+3. **Full Paths**: Always provide the **absolute file paths** to the full logs for further inspection.
+
+## Debugging and Environment
+- **Verbose**: `V=1` for detailed output.
-- 
2.47.3


