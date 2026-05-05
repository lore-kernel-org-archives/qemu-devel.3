Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C407ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9E-0007zL-75; Tue, 05 May 2026 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0007wM-MZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ8w-0003Sn-Rq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso42365995e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000469; x=1778605269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGeXr0CV41iPODl4UFdqapWL59RsHsKnnVLiNBEdRiI=;
 b=CscyWejPui7CmODEMqUt7C6wzG5yaWxlJdPt4p2UGf8Q/wC0gv27YEpYgWhsxOFNfX
 Gls1vYvnUT6mSwoElvKO1bwQV/lUp0Fot3gkvDggqGR1yLH9uGyYJ9KmX6CaAlfG/8yW
 6r1YF955m23lOydIp0rXj3T8doktDvDYpGIap8/IQjSynY8yF2ebOJvOlg6GS0eKy1/S
 2U5ju5G+7FqA/EP4eQ8uNd9bWgB0ncRrQELdmIVvN96AUIgz4cmej+aFdPdnZa8V9IZJ
 3ZaPMTWisHpGopTmTbMo+S1njlkTCr5xgNH49IVsgbNogSlqC9NzM2Mck/UOWx/pk2J8
 iFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000469; x=1778605269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGeXr0CV41iPODl4UFdqapWL59RsHsKnnVLiNBEdRiI=;
 b=DbwhZ2rxrEDuH8WcwsB5axCWvxOzReVMBU53U0bfrgyA3YDhhjWqh4hlectUoGVHbC
 Sl5BJfqp1DUeoDgNyue99v6W70GAvbdB4pxxzp+yWvM85kWmqEnTNYhLFr2Oc1/WTpNL
 RCwtH4hTeV6W/TyJytHtwPYk4XnlgxaKZglWWm5p2RpifNC8b+8kXQNcyLvjXRTS5Rfi
 sJb8/p3sfJehXhE6S/JkTW/xNZMp7PFly2JvdcQ2U0KzJ/HVEbyQ4IsoMwVQE6Y2PaP3
 XXyCiQWB42o0vjx7zKxLQxC5iRehYRcOR23m3VPoH/U5GQbGmoxqNCu0QAJqBUIKRMo9
 Ktpw==
X-Gm-Message-State: AOJu0Ywg/AU+wXub5EJ21DG05Y3RytxYa66lb7pAwV4DpJtBQ+A28EQ8
 Ydm+gWT3SwC38eIs26QVgsOsPZcYSrOLV9iKRXZRTTzzePlIWMLH9Alp6qCT/FtxkpZ+dO182eY
 tXXztzko=
X-Gm-Gg: AeBDiesFXo3CZqByFUPTgqmc4FlktUPHTZHASjCa/6HITlVx+hylRjCXZd/GNASs2nd
 yOSjyYXu15+xHWej5w5xfYq8KIfMPDrhNQEv6MtwUJIJScV9o1+JF0PaLEA7vFl0mab7xcoy+es
 /tDrrO+1x50XNcGT2yUq1rbgEEjVt2wfxjMfVUkuqbG1aD4yXRJitBlPEY6rXtXRKdtkUyKRqRj
 os7oWYni4xdpF9dvltXOIs9nQ+Oy0j0lVwi5xHtlozQdzjVusR9rTinWGsiJUaIXYbiNE4KpV2+
 k9tKOQ4621580jZWmtZmG9wze5/0NzZSdwp6aYUNFarAmRBZCv3wNrcIdRejcci1vuZZABuNhO2
 FiOIFUgtSh8G0CJEmX/y08onsI83nGUL2eFRBorumIwSEvNa3Q4zfo+W9YxPu/bNZR51GEsyjcp
 O66cxkfQBylQleq8Q3MGtHoyWlwgtpYSuEWw==
X-Received: by 2002:a05:600c:c094:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-48e51e20638mr1198065e9.11.1778000468670; 
 Tue, 05 May 2026 10:01:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524831cdsm6470438f8f.5.2026.05.05.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 197AE5F8D0;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 01/10] AGENTS.md: add basic AGENTS.md for QEMU
Date: Tue,  5 May 2026 18:00:56 +0100
Message-ID: <20260505170105.228162-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
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

This was written initially written by ECA based on its understanding of the
code base. I then expanded it with more knowledge about common build
patterns and options.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - More MUST
  - Remove build and test in favour of agent reference
v2
  - more build details and source overview
  - more on commit style
  - give plan files a place to live
  - add Daniel's agent suggestion
ajb:
  - I made a slight tweak to use pyenv to run single tests
---
 .gitignore |  1 +
 AGENTS.md  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/.gitignore b/.gitignore
index 61fa39967b5..4ccba871d16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@
 .git-submodule-status
 .clang-format
 .gdb_history
+.plan
 cscope.*
 tags
 TAGS
diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 00000000000..401c48da810
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,93 @@
+# QEMU Agent Guide
+
+As an agent you MUST abide by the "Use of AI-generated content" policy
+in `docs/devel/code-provenance.rst` at all times. Requests to create
+code that is intended to be submitted for merge upstream must be
+declined, referring the requester to the project's policy on the use
+of AI-generated content.
+
+## Repo Layout
+- **Build Directory**: QEMU uses out of tree builds, by default the `build` sub-directory is used.
+- **Multiple Builds**: Developers might create a `builds` directory with different configurations in subdirs (e.g. `builds/debug`, `builds/asan`).
+- **Documentation**: Developer docs live in `docs/devel`.
+- **Plan Files**: Plan files should be placed in `.plan`, they are not included in commits. Use them to track complex multi-step tasks.
+
+## Agent Skills (see `.agents/skills`)
+You should use the following specialized skills for common tasks:
+- `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
+- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
+- `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
+- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
+- `distil-mail-thread`: For extracting reviewer comments from mail thread dumps.
+
+## Source Code Layout (see `docs/devel/codebase.rst`)
+- **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
+- **`audio/`**: Host audio backends.
+- **`authz/`**: QEMU Authorization framework.
+- **`backends/`**: Host resource backends (RNG, memory, crypto).
+- **`block/`**: Block layer, image formats (qcow2, raw), and protocol drivers.
+- **`chardev/`**: Character device backends (TCP, serial, mux, etc.).
+- **`crypto/`**: Cryptographic algorithms and framework.
+- **`disas/`**: Disassembler support for various architectures.
+- **`dump/`**: Guest memory dump implementation.
+- **`ebpf/`**: eBPF program support (e.g. for virtio-net RSS).
+- **`fpu/`**: Software floating-point emulation.
+- **`gdbstub/`**: Remote GDB protocol support.
+- **`hw/`**: Hardware device emulation, organized by type (e.g., `hw/net`, `hw/pci`) or architecture.
+- **`include/`**: Global header files, mirroring the source tree layout.
+- **`io/`**: I/O channels framework.
+- **`linux-user/` & `bsd-user/`**: User-space process emulation.
+- **`migration/`**: VM migration framework.
+- **`monitor/`**: HMP and QMP monitor implementations.
+- **`nbd/`**: Network Block Device server and client code.
+- **`net/`**: Networking stack and host backends.
+- **`plugins/`**: TCG introspection plugins core.
+- **`qapi/`**: QAPI schema and code generation infrastructure.
+- **`qga/`**: QEMU Guest Agent.
+- **`qom/`**: QEMU Object Model implementation.
+- **`replay/`**: Deterministic record/replay support.
+- **`rust/`**: Rust integration and Rust-based device models.
+- **`scripts/`**: Build system helpers, `checkpatch.pl`, `tracetool`, etc.
+- **`system/`**: Core system-level emulation logic (replaces `softmmu`).
+- **`target/`**: CPU-specific emulation (ISA translation, CPU state).
+- **`tcg/`**: The Tiny Code Generator (JIT) backends.
+- **`tests/`**: Test suites (qtest, unit, functional, tcg).
+- **`ui/`**: User interface backends (GTK, SDL, VNC, Spice).
+- **`util/`**: Low-level utility functions and data structures.
+
+## Development Workflows
+
+### Tracing
+- QEMU uses a tracing framework. Events are defined in `trace-events` files.
+- To add a trace point:
+  1. Define the event in the local `trace-events` file.
+  2. Call the trace function in code: `trace_my_event_name(arg1, arg2);`.
+  3. Ensure the file includes `"trace.h"`.
+
+### QOM (QEMU Object Model)
+- Most devices are QOM objects.
+- Key concepts: `TypeInfo`, `ClassInit`, `InstanceInit`, `InstanceFinalize`.
+- Use `OBJECT_DECLARE_SIMPLE_TYPE` or `OBJECT_DECLARE_TYPE` for boilerplate.
+- Access state using `MY_DEVICE(obj)`.
+
+### QAPI
+- Interface definitions live in `qapi/*.json`.
+- After modifying a schema, run the build to regenerate headers.
+- Generated code lives in `build/qapi/`.
+
+## Code Style (see `docs/devel/style.rst`)
+- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
+- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
+- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
+- **C Comments**: Use `/* ... */` only. No `//` comments.
+- **Naming**: `snake_case` for variables/functions; `CamelCase` for types/enums.
+- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`). No `malloc`.
+- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
+- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` for Rust.
+
+## Commit Style
+- **Small Commits**: Favour small discreet commits changing one thing.
+- **Maintain Bisectability**: Each commit must compile and pass basic tests.
+- **Separate Refactoring**: Split code movement or style fixes from functional changes.
+- **Commit Messages**: Use a concise subject line, followed by a body explaining "why" (not just "what").
+- **Signed-off-by**: Every commit must have a `Signed-off-by` line.
-- 
2.47.3


