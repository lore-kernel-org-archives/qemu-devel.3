Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D5DCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEr-0002zs-9j; Fri, 29 May 2026 06:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEq-0002yw-3v
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEm-00014g-Iu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so8655410f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049683; x=1780654483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNYkpGUE28h/oVjSL8IZeaKshlQLE3nGLpzXET3DfcM=;
 b=U3BQ3NfSR82UOKYx4+osrgcOrAUzcj3FYla5UIVIRckqIuL8pc/V2fmFchS/MDEuvE
 w2tZdANAGkCCEBAueNFsAFhqZNJFuQjAHwzgl/Bx8ZPSzau3rXuA4cwU1oyEqrNfCc28
 Rdot4gI+yQmWFcJvsQshfw2+wRsZlxNJdjlGiFquz6CxwxeE86H5mPMqDCZvR5wpwCFf
 iQe6/aSlWeFGcljU+pCoSI5BVu29YH2Y8N7g9bE1noHB8AKdKnRxKbJFx3ou0xxM6Slh
 RK3lEVlpEzoJX/c2GUl3jvpsW2F3cex7XFad6lNlay0wX2Azo6byx88rWAcujhkWSPNc
 FdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049683; x=1780654483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNYkpGUE28h/oVjSL8IZeaKshlQLE3nGLpzXET3DfcM=;
 b=RBdrrvOsel20g2gU+tlnzMJX8vXEeiDFFaW23gGdYThYXlJvhUKP9976jyzYXoGjit
 EDGWxZsy47JHpik0bduJPPDS5J/b8fidfQ1TWO15CeX3n+u0ouy4/Begt/EAyEnRilRn
 uYZmSNLsleH7ogpvI1izLXdOiJOrZRkvrubO4kP1OYrIQetFAGoE02UX6YLo+AU+G755
 WA9zM8MpVmRoV71Wn9L0P2C44IzDfMVdrDNJ3BBEZQrG/miIlNgno7i2CBOv5odvB/z5
 Qk16XOedx8bhZOcPATzApwBUzqR0Rxz3Cy26g6YD1vjFfckTvKKpSPcGGTJ818QJe1rZ
 sV6Q==
X-Gm-Message-State: AOJu0YxMqQpUum/FYcg39x5683FlDSOcGyH8cRobBEgfNTqBd6lciaJu
 h8mazXSC7gD889yVjgqwD3hVfZ/sOYB6JpY/K+ZbRQ1zfrJ4dw7Ky68/wxmz/7ebgtg=
X-Gm-Gg: Acq92OH8hqyujILUaIl2BwCTIuDJXaqk2n6NSpCT1ESrYEqNw0vWO1y5ws4cc2y+bbo
 8AQJ/gEB4BmbDFSM16c4J4Tq4IinhMs1D/4LL8fBu4GCD7kmzkCJxpYCdz+QRVqrzi/AeZaXCXO
 0gM/VVWjcn8ZaYAXxvWUmKTLbnRTHIiji+fsldo/iW9xbgJXrH5mSAAYgKl5s9VA4yd3TpBatXz
 WYBdwSa4r4juOHWU5UdWWskrXoN1M/t6lVBAEV39so8iuGX2UPmsr5xqFRpjS6JRv6PNrZR8lOv
 Jc48d70eqti0gKUYTgaHU2QvOaEpFruKVwZ0XwYsdqQ0LBS/iQmxmArDhddMiIv6BVSAgiQCLSI
 10qJ8yfYKdG6U/hUQ2j6WGM2yoCSPNSOvZHJmXfknRRSCpW01DWyaoturNydmH7z0syzHJJIdSU
 FoekWVfnDCc/yolVf94whMBLlrWNh39j987lMXHqYGhDUH
X-Received: by 2002:a05:6000:4690:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-45ef144a66amr2682312f8f.23.1780049682675; 
 Fri, 29 May 2026 03:14:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a0374sm2218905f8f.2.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EB926036E;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 05/12] .agents/skills: add qemu-code-explorer skill
 (caveman)
Date: Fri, 29 May 2026 11:14:30 +0100
Message-ID: <20260529101437.410181-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
caveman
  - caveman reduction
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
 .agents/skills/qemu-code-explorer/SKILL.md    | 84 +++++++++++++++++++
 .../qemu-code-explorer/evals/evals.json       | 26 ++++++
 AGENTS.md                                     |  1 +
 3 files changed, 111 insertions(+)
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json

diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
new file mode 100644
index 00000000000..fa8df2b0f94
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/SKILL.md
@@ -0,0 +1,84 @@
+---
+name: qemu-code-explorer
+description: Advanced QEMU code search (generated code, complex macros, QOM) when standard search fails. Fallback for build artifacts and hidden symbols.
+license: GPL-2.0-or-later
+---
+
+# QEMU Advanced Code Explorer
+
+If standard search fails, symbol is likely generated at build time or hidden by macros. Use these strategies.
+
+## 1. Search Generated Code
+Generated files exist in build dir, not source tree.
+
+### QAPI (QEMU Interface)
+- **Source**: `qapi/*.json`
+- **Generated**: `build/qapi/` (headers, C files)
+- **Patterns**:
+  - `qmp_marshal_...`: Command marshallers.
+  - `qapi_free_...`: Type cleanup functions.
+  - `visit_type_...`: Visitor functions.
+- **Action**: Search `build/` text.
+
+### Tracing
+- **Source**: `trace-events` files.
+- **Generated**: `build/trace/` (e.g., `trace/trace-hw_block.h`)
+- **Patterns**: `trace_...` functions.
+- **Action**: Search build dir/generated headers.
+
+### Decodetree (Instruction Decoding)
+- **Source**: `target/.../*.decode`
+- **Generated**: Included as `.c.inc` in build tree.
+- **Patterns**: `trans_...` handwritten, decoder calling them generated.
+
+### Configuration
+- `build/config-host.h`: Global host config.
+- `build/config-target.h`: Target-specific config (e.g., `TARGET_X86_64`).
+
+## 2. Expand Complex Macros
+QEMU uses deep macro nesting (TCG, softfloat).
+
+### `scripts/expand-macro.py`
+Get C code after preprocessing for specific line range.
+
+- **Usage**:
+  ```bash
+  python3 ./scripts/expand-macro.py FILE --context CONTEXT_FILE --range START_LINE-END_LINE
+  ```
+- **Example** (TCG helpers, softfloat):
+  ```bash
+  python3 ./scripts/expand-macro.py fpu/softfloat-parts.c.inc --context fpu/softfloat.c --range 191-264
+  ```
+
+## 3. QEMU Symbol Patterns
+Hidden by boilerplate-reducing macros.
+
+### QOM (QEMU Object Model)
+`OBJECT_DECLARE_SIMPLE_TYPE` or `OBJECT_DECLARE_TYPE` expand to multiple functions/casts.
+- `MY_DEVICE(obj)` likely defined via `OBJECT_DECLARE_TYPE(...)`.
+- Search type name string (e.g., `"my-device"`) to find `TypeInfo` structure.
+
+### TCG Helpers
+- **Pattern**: `HELPER(foo)`
+- Defined in `helper.h`, implemented as `helper_foo`.
+- Search `HELPER(foo)` pattern if `helper_foo` not found.
+
+### Error Handling
+- `ERRP_GUARD()`: Starts functions for `error_propagate`.
+- `error_setg(errp, ...)`: Reports errors.
+
+## Decision Matrix
+
+| Scenario | Strategy |
+|------|--------|
+| Standard function/struct | Use standard search tools. |
+| Symbol not found in source | Search `build/` for generated code. |
+| Macro expansion opaque | Use `scripts/expand-macro.py`. |
+| QOM cast macro (`TYPE_...`) | Search `TypeInfo` or `OBJECT_DECLARE_...` usage. |
+| TCG helper missing | Search `HELPER(name)`. |
+| Instruction decoding | Search `.decode` and `trans_...` functions. |
+
+## Workflow Tips
+1. **Find Build Dir**: Check `build/` or other build subdirs.
+2. **Combine Tools**: Try standard search first, then search build dir.
+3. **Check Context**: For `.c.inc` files, find the parent `.c` file that includes it.
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
index 8ceffde4ebb..c751652babf 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -46,6 +46,7 @@ If unsure read the linked `security.rst` document for further guidance.
 
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
+- `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


