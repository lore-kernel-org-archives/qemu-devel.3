Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC1AFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9A-0007xm-Vs; Tue, 05 May 2026 13:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0007wL-MU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ8w-0003SR-LG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so3897697f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000468; x=1778605268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qLWLCHwx9ItOitd3ZI8FQhHr7e9U0+nImoOwCxcB9Y=;
 b=D854VgzrdTcNdFjRPjtBFPewYGHeZI/wVcK1s94bl0PqQr10nXsYjm3L2g1UYdFu3p
 oCLtkrldtELrwXBLOD11osQMasqac481QUgZTFknZERSryIcOm5LT2nncmwz+nrpqYxU
 y/0WcEI975EKcj/0uNiAk7FC+gAYEo/x0CsYdAt6BGlu9LFi9g0IQcNnc1pzjJAHKmJB
 HGtDI0ehBsDH6jPRVlcgXriU9yK6I5PIr9CtlM3YcdTVMFoUPNKbXQQOMD8OsDpYPK+h
 oztBcdw5Y+MyD4wDs5nfQOzChPaKcGBKqM5JWUtwzqWT054415ezEBVWpv73hjGKkg8k
 xNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000468; x=1778605268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2qLWLCHwx9ItOitd3ZI8FQhHr7e9U0+nImoOwCxcB9Y=;
 b=oB2zZC6PBJss+sUdMufGn9PP8nSOXURBD8jacTUBcaSAsa7UDGON8kPszeu/1zR74z
 cg6UDR9aH4gnRGd1ODXe2u6YT3rS5r2R2KTpT62M2i/VFks5YUYsAyPjHy/0ElLH45wD
 3/8ctDpuE+YBt8xtAPGHcglc1lCDVR6PhKBvLP248h88umYpoxySju1ZozroIfNNEPFQ
 2ATISnR61/TOi2zVGlzJDnp1B2fnY1WubEMOn7k9iOxg8L3Plp+jjlQvWSGs5ARvLYL2
 6W0jhr/an+zqyDwQQjmaOzgLdoBh3oyLNwYgCQpttHKqRZFCS/z7RIcvmq9a7P2aP05A
 b49w==
X-Gm-Message-State: AOJu0YzOv0ehw5UO/OPoPoSjSG3RBS78SF0GZ6x7IkM7MoMJ1EB9Xigt
 UqsUSp1f9vQqH8PeW3j8I3JdZyt7LEgc6JiEzwszTTOC5ggfmyW0RHu4cXegmQhEm0bYwD2jDgs
 zeqmiMa4=
X-Gm-Gg: AeBDietxnLF2BQOdH3457YfrB+FWdKETeYUhqVFNu8KF7IEhpnK/EdTaoRnV7qT+1pU
 RtCd1a3DvG44cHJnKKdKRrgjyfX7oaIe8TpCpesfQ1jRgVeot/iuj0srq+qEjjCPXcMok277MGI
 c5QNrTXgZh9foKWAYq5NVyU86C0RgG8JvRJ5T1VDRjs56GtvyTLxNdf0JogLNgFdQXCOmKs/V3s
 2WRDZEzkjOE5pEmXyIzVUCt7rZQv8Vyut6icZNHzR6cVHz15wVeHGN7brr66iZm+O/Obo5VUX9J
 bX3Nm0zEVzj33gNQXMeSWzjQM85g2qGw3qJoemV7/RK9acAE52dvaxkjcD1oMeq9enbcX4GqMYr
 EyUIH0RYt6Cs408T5XGRbyUuTfLGz9a5xXsbva19UeTEaHjxpK4yVenzYi0JxO0R8FGnJD0W7Uj
 j9XDylz/nD2WPT+RfyDDhx89a0Tnqa5jHVCA==
X-Received: by 2002:a05:6000:2f83:b0:43b:8f4e:27f8 with SMTP id
 ffacd0b85a97d-44bb4817dc1mr25010341f8f.12.1778000468032; 
 Tue, 05 May 2026 10:01:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960fd6sm6287780f8f.31.2026.05.05.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31DFC5FC70;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 02/10] .agents/skills: add qemu-code-explorer skill
Date: Tue,  5 May 2026 18:00:57 +0100
Message-ID: <20260505170105.228162-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

This provides a skill detailing how to explore the QEMU code base. It
guides the agents to use the tags and git-grep by default and outlines
some of the confusions that can occur with multiple build directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-code-explorer/SKILL.md    | 66 +++++++++++++++++++
 .../qemu-code-explorer/evals/evals.json       | 25 +++++++
 AGENTS.md                                     |  1 +
 3 files changed, 92 insertions(+)
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json

diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
new file mode 100644
index 00000000000..d41b21179c1
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/SKILL.md
@@ -0,0 +1,66 @@
+---
+name: qemu-code-explorer
+description: Comprehensive guide for exploring the QEMU codebase using tagging systems (gtags, ctags, cscope), git grep, and build-directory grep for generated files. Use this skill when the user asks to find where something is defined, how it's used, or wants to understand a specific subsystem.
+---
+
+# QEMU Code Base Explorer
+
+This skill provides a systematic approach to navigating and understanding the large and complex QEMU codebase.
+
+## 1. Symbol Search with Tags (Primary)
+
+Tagging systems are the fastest and most accurate way to find global symbol definitions and references. QEMU supports `gtags`, `ctags`, `cscope`, and `TAGS` (Emacs).
+
+### GNU Global (gtags) - Recommended
+- **Best for**: Finding where a function, struct, or global variable is defined or used.
+- **Tools**: Use `gtag_find_symbol_definition` and `gtag_find_symbol_references`.
+- **Note**: This is significantly faster and more accurate than `grep` for symbols. It handles static variables and functions correctly.
+
+### Updating Tags
+If you suspect the tags are out of date:
+```bash
+make gtags  # or make ctags, make cscope, make TAGS
+```
+
+## 2. Text Search with `git grep` (Secondary)
+
+`git grep` is the preferred tool for general text searches within the source tree.
+
+- **Best for**: 
+  - Searching for local variables within a function.
+  - Searching for string literals or comments.
+  - Finding occurrences of symbols defined in system headers (e.g., `optarg`).
+  - Complex regex patterns that `gtags` doesn't support.
+- **Why**: It is fast, respects `.gitignore`, and avoids searching through build artifacts or other non-source files.
+- **Usage**: `git grep "pattern"` or use a grep-like tool with the `path` set to the repository root.
+
+## 3. Searching Generated Code
+
+Generated source files (e.g., from QAPI or trace-events) do not reside in the source tree but in the build directory.
+
+- **Best for**:
+  - Finding definitions of functions generated by QAPI (e.g., `qmp_marshal_...`).
+  - Finding trace points and their implementations (e.g., `trace_..._header`).
+  - Checking configuration fragments (`config-*.h`).
+- **Tools**: Use a normal `grep` (or similar search tool) limited to the build directory.
+- **Crucial Note**: QEMU developers often have multiple build directories (e.g., `build/`, `builds/debug/`, `builds/asan/`). Always verify which build directory is active or intended.
+- **Common Paths**:
+  - `build/qapi/`: Generated QAPI headers and C files.
+  - `build/trace/`: Generated trace points.
+  - `build/config-host.h`: Host-specific configuration.
+
+## Decision Matrix: Which tool to use?
+
+| Goal | Tool | Reason |
+|------|------|--------|
+| Find a function definition | `gtags` | Precise and fast. |
+| Find all call sites of a function | `gtags` | Comprehensive. |
+| Find a local variable usage | `git grep` | `gtags` only tracks globals. |
+| Search for a string literal | `git grep` | `gtags` doesn't index literals. |
+| Find QAPI-generated code | `grep` in `build/` | Not in source tree. |
+| Search in a specific subsystem | `git grep <path>` | Efficiently scoped. |
+
+## Workflow Tips
+1. **Scope your search**: If you know you are looking for a networking issue, search `hw/net/` or `net/` first.
+2. **Beware of Macros**: QEMU uses many macros (especially in QOM). If `gtags` fails, `git grep` might find where the macro is used to define the symbol.
+3. **Verify the Build**: Before searching generated code, ensure a build has been performed in the target directory.
diff --git a/.agents/skills/qemu-code-explorer/evals/evals.json b/.agents/skills/qemu-code-explorer/evals/evals.json
new file mode 100644
index 00000000000..dff7afa52fa
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/evals/evals.json
@@ -0,0 +1,25 @@
+{
+  "skill_name": "qemu-code-explorer",
+  "evals": [
+    {
+      "id": 0,
+      "prompt": "Where is the function 'qemu_mutex_lock' defined and where is it used in the block layer (block/)?",
+      "expected_output": "The definition should be found (likely in util/qemu-thread-posix.c or similar) and usages in block/ should be listed using gtags."
+    },
+    {
+      "id": 1,
+      "prompt": "I'm seeing a reference to 'qmp_marshal_query_status' in some docs but I can't find it in the source tree. Can you find where it is defined?",
+      "expected_output": "The agent should identify this as QAPI generated code and look in the build directory (e.g., build/qapi/qapi-commands-control.c)."
+    },
+    {
+      "id": 2,
+      "prompt": "Find all implementations of trace points for 'virtio_net' in the generated code.",
+      "expected_output": "The agent should search for 'trace_virtio_net_*' in the build directory, specifically in generated trace headers/sources."
+    },
+    {
+      "id": 3,
+      "prompt": "Find all occurrences of the string 'Could not open' in the 'hw/' directory.",
+      "expected_output": "The agent should use git grep or eca__grep scoped to hw/ to find the string literals."
+    }
+  ]
+}
diff --git a/AGENTS.md b/AGENTS.md
index 401c48da810..e4b65b06067 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -11,6 +11,7 @@ of AI-generated content.
 - **Multiple Builds**: Developers might create a `builds` directory with different configurations in subdirs (e.g. `builds/debug`, `builds/asan`).
 - **Documentation**: Developer docs live in `docs/devel`.
 - **Plan Files**: Plan files should be placed in `.plan`, they are not included in commits. Use them to track complex multi-step tasks.
+- **Agent Skills**: These can be found in `.agents/skills`
 
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
-- 
2.47.3


