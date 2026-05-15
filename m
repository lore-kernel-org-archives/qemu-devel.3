Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913FACD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRd-0005r9-6V; Fri, 15 May 2026 12:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-0005dj-NJ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRF-00026x-CA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso217625e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862659; x=1779467459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEZBaEcyE1n/8bEIs4nZm/53UNkYauFmpvGiRK8l7YM=;
 b=xqkMN3XsAIDo3FaDwV0fQ/y2r3RTs18V9Kmf330fUD4ianHfnySgz47ZAs+A8HlzJg
 4rrHzxnOEN5cdcINlB/nzsJ9D7nCLiRskvdsyiEmxmDBGojO8KGg3Au5I9oPDBbK6LM7
 5F3JgBYbOcbr286JASf7dPSDmiswq8HR199C050qwFfTHbJ5BL15nGvu6bGxaH895zJO
 IhYdKs+xJoNR2ujmnY3rM03i+UzOoNN2qWLw1qyUJMj/H4wYiuXFcjQzHyCuxSh/+EBC
 xJDgsM5wDSPVHeN0HCdJZ09KjZ7uYLpOOMnxBdUu8poioMGnCFi+4Gc0idyASzaHywIB
 6MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862659; x=1779467459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XEZBaEcyE1n/8bEIs4nZm/53UNkYauFmpvGiRK8l7YM=;
 b=K8cP9ctA2xEh6Ke+G0JmEPSywTUGdhgJcOltW9pMwbdkXVULII+8Qfkb7ZyMlCGRUK
 ifN0UOwZjCkPZG+vvR7PWW64sSlE2c4u+bKHon5gG31U8NRsB68CiNo/N/R4bt+j5yxT
 SMxbaHZHzEigz8ZJh4XpudldGIPAebHEoETuLHCAIWgGIi3jg+o+5ZAoXquEmiNGu2KW
 uvrNhACBnCK4zKf01qdgoMgohk5HwYQyxCj7cYu4WE9qqadn/AwsncQQZbbjHKye0y2b
 +kdauf8MZFx4WyNmgmAwO+6lMkbpBfcpCopXvEvKtLdfyrzbSU5ml1DTBCfYfzdHW35T
 MFSQ==
X-Gm-Message-State: AOJu0YyDwlZW6Gk0Eqy9F9V4IBzIKV67gIB3TaP9bV3O6IexDVHDcF9I
 2jefHLx9wwMYXBtJ1/celIor20BZGjtkvm4oLS5r0MS7wxLbLT/xmdQtx6DC1odho2E=
X-Gm-Gg: Acq92OGreznkhCZpD4OkGn6oMSu7K1kSuYnhvgks4oNSGTYRF+Gk1WgAWSXunLO1kPB
 0WLNj2ul/J2oEJI6PNJqRNM6iykWvccsIDAhw7+hEhUTZmgvtm2A6buNtxr2hz9RJN1xGGQA+pf
 FIPeRK3g4bYCIgmNt6BxYGFxdFtJpSH3ZbDtaj+uIWLdgFiNf6pRAHqgMwgvsExpd+NQn5SQpg6
 McfG1YDqY+HzCaecp0tFdHwOdmN3A0FbByIhzPV5Uil4q6/BGgVMzt91ZaAqCUYvGE7LDJeI1lx
 us1vbYgcfdiIsQP6jJA+mY2d1/D+UiMEODbBjG/euVey9/dFcLZdGI+UdbZEyhJ9nqcQkGaE1gL
 6fFDEHXxQJ5mw/OJBiCub+XOmS5Y5ZAqbTmwTHXsDaE/sKkdqNgJzzzleGUIOjtEKPst2LcXeZL
 2GlgGvX2klfkVE9wm8UkGuiqWHGx4pNaGfeg==
X-Received: by 2002:a05:600c:4fc9:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48fe60e4794mr65709335e9.3.1778862659416; 
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe67688sm21716675e9.5.2026.05.15.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF2B05F8C1;
 Fri, 15 May 2026 17:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 04/11] .agents/skills: add qemu-code-explorer skill
Date: Fri, 15 May 2026 17:30:47 +0100
Message-ID: <20260515163055.1792262-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

This provides a skill detailing how to deal with some of QEMU's more
idiosyncratic coding conventions. Originally I had given instructions
on using tags and git grep but once I'd installed the semcode
MCP (https://github.com/facebookexperimental/semcode) it
was able to handle most code navigation pretty efficiently. So now
this skill just focuses on the things that are tricky for indexers to
handle, namely generated code and fancy macros.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - rewrote with a focus on generated code and macros for when code
  search MCPs run into trouble.
v2
  - remove personal gtag skill references, add global stanzas directly
  - moved macro information from AGENTS.md into code explorer
  - more imperative language to trigger its use
  - add section on using scripts/expand_macro.py
  - remove eca reference from evals.json (maybe we should just drop this)
---
 .agents/skills/qemu-code-explorer/SKILL.md    | 88 +++++++++++++++++++
 .../qemu-code-explorer/evals/evals.json       | 26 ++++++
 AGENTS.md                                     |  1 +
 3 files changed, 115 insertions(+)
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json

diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
new file mode 100644
index 00000000000..7bca389b37d
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/SKILL.md
@@ -0,0 +1,88 @@
+---
+name: qemu-code-explorer
+description: Advanced QEMU code exploration for special cases (generated code, complex macros, QOM) that are not easily handled by standard code exploration tools. Use this as a fallback strategy for build-time artifacts or hidden symbols.
+license: GPL-2.0-or-later
+---
+
+# QEMU Advanced Code Explorer
+
+When standard code navigation tools fail to find a symbol, it is often because the code is generated at build time or hidden behind complex macros. This skill covers how to find and understand those special cases.
+
+## 1. Searching Generated Code
+
+Generated source files do not reside in the source tree but in the build directory. If a primary symbol search fails, the symbol is likely generated.
+
+### QAPI (QEMU Interface)
+- **Source**: `qapi/*.json`
+- **Generated**: `build/qapi/` (headers and C files)
+- **Patterns**:
+  - `qmp_marshal_...`: Command marshallers.
+  - `qapi_free_...`: Type cleanup functions.
+  - `visit_type_...`: Visitor functions.
+- **Search**: Search the `build/` directory using standard text search tools.
+
+### Tracing
+- **Source**: `trace-events` files throughout the tree.
+- **Generated**: `build/trace/` (e.g., `trace/trace-hw_block.h`)
+- **Patterns**: `trace_...` functions.
+- **Search**: Check the build directory or the generated headers.
+
+### Decodetree (Instruction Decoding)
+- **Source**: `target/.../*.decode` files.
+- **Generated**: Usually included into source files as `.c.inc` artifacts in the build tree.
+- **Patterns**: `trans_...` functions are handwritten, but the decoder that calls them is generated.
+
+### Configuration
+- `build/config-host.h`: Global host configuration.
+- `build/config-target.h`: Target-specific configuration (e.g., `TARGET_X86_64`).
+
+## 2. Expanding Complex Macros
+
+QEMU uses deep macro nesting (especially in TCG and softfloat) which can be opaque to static analysis.
+
+### `scripts/expand-macro.py`
+Use this tool to see the exact C code after preprocessing for a specific range in a file.
+
+- **Usage**:
+  ```bash
+  python3 ./scripts/expand-macro.py FILE --context CONTEXT_FILE --range START_LINE-END_LINE
+  ```
+- **Example**:
+  To see how TCG helpers or softfloat parts expand:
+  ```bash
+  python3 ./scripts/expand-macro.py fpu/softfloat-parts.c.inc --context fpu/softfloat.c --range 191-264
+  ```
+
+## 3. QEMU-Specific Symbol Patterns
+
+Some symbols are "hidden" from simple search tools because of boilerplate-reducing macros.
+
+### QOM (QEMU Object Model)
+Macros like `OBJECT_DECLARE_SIMPLE_TYPE` or `OBJECT_DECLARE_TYPE` expand to multiple function declarations and casting macros.
+- If you see `MY_DEVICE(obj)`, it is likely defined via `OBJECT_DECLARE_TYPE(...)`.
+- Search for the type name string (e.g., `"my-device"`) to find the `TypeInfo` structure, which links everything together.
+
+### TCG Helpers
+- **Pattern**: `HELPER(foo)`
+- Defined in `helper.h` or similar, implemented as `helper_foo`.
+- If searching for `helper_foo` fails, search for the `HELPER(foo)` pattern in the source.
+
+### Error Handling
+- `ERRP_GUARD()`: Used at the start of functions to handle `error_propagate`.
+- `error_setg(errp, ...)`: Common pattern for reporting errors.
+
+## Decision Matrix
+
+| Scenario | Strategy |
+|------|--------|
+| Standard function/struct | Use primary code navigation tools. |
+| Symbol not found in source | Search `build/` directory for generated code. |
+| Macro expansion looks wrong | Use `scripts/expand-macro.py`. |
+| QOM casting macro (`TYPE_...`) | Search for the `TypeInfo` or `OBJECT_DECLARE_...` usage. |
+| TCG helper missing | Search for `HELPER(name)` pattern. |
+| Instruction decoding | Check `.decode` files and corresponding `trans_...` functions. |
+
+## Workflow Tips
+1. **Locate the Build Directory**: QEMU developers often use `build/` but it could be named differently. Always check.
+2. **Combine Tools**: Use primary tools first. If they fail, search the `build/` directory.
+3. **Check the Context**: If a `.c.inc` file is confusing, find the `.c` file that includes it to understand the macro context.
diff --git a/.agents/skills/qemu-code-explorer/evals/evals.json b/.agents/skills/qemu-code-explorer/evals/evals.json
new file mode 100644
index 00000000000..8eaa45b28b3
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/evals/evals.json
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+      "expected_output": "The agent should use git grep scoped to hw/ to find the string literals."
+    }
+  ]
+}
diff --git a/AGENTS.md b/AGENTS.md
index 3fd56fe3309..a34a92244e5 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -30,6 +30,7 @@ If unsure read the linked document for guidance.
 
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
+- `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


