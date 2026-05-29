Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B3CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEp-0002yr-RO; Fri, 29 May 2026 06:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEo-0002xz-8N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEl-00014Z-BT
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so4612464f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049681; x=1780654481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMMFe0yvVmEzgfmkcxW/z0D7RgLYHXLz9oPQn8R7iKk=;
 b=F9+Iur/4bnwGGtaAviTbJFPoWs1/3ds0bfS+GWoQZNR/bVEo7EJfD3tdLtsS8lNzs9
 Yt+6j/AG8hDde4uVn5CNIQ0SCm+7jeac5WiQ7xOZaKt4efXdhQKBD/ITOhCBfrFqiu6v
 2Z6il0pDFn35HROyFz/OTrsLvCiBkFkqJn2hzYDPuGP5C+dR7KRJOn0vapDPOhCBVdus
 60gMaZh/tP7t5mgvwrs6GTjVrtXmlTwlHJfG1GMj5SMjEYl6whZ1EOIe98AU6vXxCooS
 fUMBp8XYgCqFdZeKonQMgwxGtJxqlfwxHTqayJwdOeIX3xoAzYn9g/hAYvvcz+nCwtsJ
 2cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049681; x=1780654481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eMMFe0yvVmEzgfmkcxW/z0D7RgLYHXLz9oPQn8R7iKk=;
 b=o8iBlgWCRvAqGrgq72NtM2gBtv53WuHWW/gMFf9q1/HaKm4GkCAuNrLGIbiKvknAQg
 X+HMnwDEx9YK6QT+z0fG0xU+NBZJJzC1ZYTIbiy3C8OFY7Go5jdgr6o0OZ18FS+7Kh2s
 b048S6jA/yNB5ldkeIyeBEp9UvgO06j53tXR7NSQUr3AN9c+IuC5NbmfzMA1MYn1dpvt
 XkZi5E5JQy06KEZx+zylE0iyJRKg7sgapHeMrzdc4k4EQwC2bMpuBxilFiDSyCBNIw0y
 X7Xq7RQM2jw7WrGs3DLgQQQfyswxgGDt3XJb3RJVq4zqWzhBC2iRBBMyyQWdZC6fHwpP
 WNfg==
X-Gm-Message-State: AOJu0YyIoTbxZnYCbTWY7mKVZ0D1OSwxILVpfkWqy7mePCDsaHGyGB2O
 FD1WYdW2bqtS2ES74JWSkP6vN4IP/+wFbYpJVn0mkv5fr5560gQDmaRVvYI8Gd5iE8E=
X-Gm-Gg: Acq92OEI4leDMtyj49IwOSBWQdIqA3euUkuPR9ZgZNE965GOxb/na3ygFNPX3+KHffe
 oFkyFBlTVpV9L8LtV0N7aqsw0ZONiplncrTeCJg+lyvbdvVxQZSGihcVrkvrBcWdo3Oh9pruyT7
 f5ddl3JGakXrTZiN48QfOg4672Voj+2ykUUPPsA9XHgq3VfQgCgExPWF6O7ZxpKJIibdZM/Z/PT
 laBLpyHushYaMh2TQoFGZjGwu7dGiHP+AmwPgYbyBaXKvoexwXDgJcmyJo4DkmFvquO/HKLOuHa
 n9Cbc8Ccje04qaIRPtt+CUgZARUfp5EVmht1b1J8ggGDBkoWbMGo0sM3d1u9zBN/OOx2pLb4qVu
 GC9RdEdrY1lR1kTT3qs2UUEZs/dCLQ64G5YCBF6dXLp9KS5XXZ/YBt2RBw7xomVCqCKi3If+6aN
 CJAEwKfwBhjLrkny61h15sDt9ACVVpLFhOcA==
X-Received: by 2002:a05:6000:481c:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-45ef13f840fmr3855159f8f.10.1780049681293; 
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef358c07bsm2447017f8f.36.2026.05.29.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2EE3602E1;
 Fri, 29 May 2026 11:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 03/12] AGENTS.md: expand with information on skills,
 layout and style
Date: Fri, 29 May 2026 11:14:28 +0100
Message-ID: <20260529101437.410181-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

To be efficient in navigating the code base inform the agents of the
basics of the repo layout, where skills can be found and a very quick
overview of the source code, coding and commit styles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - split AGENTS.md into two commits
---
 .gitignore |  1 +
 AGENTS.md  | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index bd18ddfd8dc..8ceffde4ebb 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -37,3 +37,64 @@ are treated as security vulnerabilities. In brief these are:
 - **Common devices for Virtualization**: e.g. VirtIO and platform devices
 
 If unsure read the linked `security.rst` document for further guidance.
+
+## Repo Layout
+- **Build Directory**: QEMU uses out of tree builds, by default the `build` sub-directory is used.
+- **Multiple Builds**: Developers might create a `builds` directory with different configurations in subdirs (e.g. `builds/debug`, `builds/asan`).
+- **Documentation**: Developer docs live in `docs/devel`.
+- **Plan Files**: Plan files should be placed in `.plan`, they are not included in commits. Use them to track complex multi-step tasks.
+
+## Agent Skills (see `.agents/skills`)
+You should use the following specialized skills for common tasks:
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


