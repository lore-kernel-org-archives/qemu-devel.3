Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC86DC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Oa7-0006RE-AC; Fri, 04 Sep 2026 03:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2Oa5-0006Qo-M6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2Oa3-0002az-F4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788507801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=znzRPPWo9y5qVxS3DVO2qfE4AzvIpVp47dXrGmRMfEo=;
 b=Ld1ZWq/Bm2RlNkxUId3YEkjXP1IlUdf1kPmdjOwFyZgR4I7aPAQXxOaC7YWivxuf0JqLcZ
 p5PYKzcHwrVERg/8FzWe6UeBB+48Wy/BlAXvXSC/tIWOOT5L90SOFoy7Wm0pkZRlWKPiHu
 dVCfbz/x5JpCvgnioL6YI2fWkIVBWDE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Z1P5C3__OZSt_gjHa02MIw-1; Fri, 04 Sep 2026 03:43:19 -0400
X-MC-Unique: Z1P5C3__OZSt_gjHa02MIw-1
X-Mimecast-MFC-AGG-ID: Z1P5C3__OZSt_gjHa02MIw_1788507798
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48436db95e1so427727f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788507798; x=1789112598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=znzRPPWo9y5qVxS3DVO2qfE4AzvIpVp47dXrGmRMfEo=;
 b=g7UA80tbGGFqojtHCgcObKG8FInQJhbClaH6CBflqQdBj05X5SguCdr6H2V4Of0dmg
 i45FpiLJzMZgChl9c/MvR9GPn2vUCjdhKWYSKN1/Q4JRHlcUqZGbps/dWPnGxDbZ9RBf
 Amx8hbBAiirFdaCkmu8ZcLoCICy3KdtxfGsdORYZ1H7uOQaXTkeZekjALP2Wot+85TOR
 2TIDFopM3guO6nP+SrhPGjKF9eFrqjyNLdRLLUzYI2yJbjrG8bq5CQzZxqdRktA+LIYi
 7vV99DrRojPUhJ50JYAeUbI9l8DbDUbjVu61SV2ODeJl4hIAoMcEu5jEiY632tdsEuOr
 icyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788507798; x=1789112598;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=znzRPPWo9y5qVxS3DVO2qfE4AzvIpVp47dXrGmRMfEo=;
 b=GDhN5A5ftsu1QP4FEj8gw8h6Z0k4lQUftjuKpG7z945LwP2KdnQhzahSssXBDhCbRs
 rOBAj7FGjlri8H7fOIFBYVlwbC9b4CwHQMtfed4u7AIEbfWUAp7ewY/UNDujmvkcTPQI
 L9i7bl0/vnePBBexSAcpPvSeHvBCiWf0SRGttzyyXIPPNpSndqT5oSbbLYR6rF3JbNgm
 dyAGj6ul4Vzr0opdLoaysx3m/GiLkzUSpBfCm6NTNBo5DVKSQTezf38Z7Kdc6bvp8lkl
 iqnwTCwB10uv06Fc1dCfF5/i2eh1uFATrQFS9Cman7m5wOaBcN6emsPeVl43+DO2/5eN
 bxGg==
X-Gm-Message-State: AFuF++nUSs1ZtnDtxORIz+46auZjAF8XZ1+UzBEisnhuGN2cZQ3Qr3X+
 JcWgkQC4hzULSQRMP+oMDnQM1zz+hRJYBNaC0y8t+ZlzGA3jv3LwTjW4gT3mpZwBVQgMlt1HlT7
 BiQjZEnfYWc9t0C3Ppq/igDXttidg7VsCDoht1s4ZjYNHCHjVYbwpqdsi694wGYfX7FRUm8iUTr
 CqqPw5Uj2ZJad4f5oabNA7n5TV9SatR1W8VhXWqwhb
X-Gm-Gg: AYBFou1L/6AIAVxYzS2nGjTM4sqR4peaCUG82+0WNIWxDn/atNSOOcRiV49/3j2YuIY
 JwsQ6xi5ePTMYkpV0BBg1FkXk3QeCAKTZFa5axJXssYk5cxZfPFfsQAswnLpncWPNr9NdfkO3G9
 KBCLCCbfIzKIFSjiwcPeGQpOg/1lZe4Z98mQoJsVQci/Fd8gO3Qu0cT6f91Jk1iC7wMq2oWsR58
 63AJ4Ircz62zdsWrE9WzSoXdcP1dolquhpjvgv4g2Lwi4KraLCBNzUDNWpzxJQczIuRAQPtVb5q
 3nJky9iS5tVRGBhcNfjSlYnYig5echFZkVnwwZFp8M5SV78gdommB1NhwWaimBzgsojCfeXwZEi
 PUJ1QDwkYNogLhZBx2OWAqRH+9UQt98wwQpJnDIHIGPbBtH9Oczd8Psl8Ak25U0EOXYeJMB29z3
 PO0NU=
X-Received: by 2002:a05:6000:186b:b0:485:8c16:a35b with SMTP id
 ffacd0b85a97d-4858c16a72bmr1619732f8f.51.1788507798347; 
 Fri, 04 Sep 2026 00:43:18 -0700 (PDT)
X-Received: by 2002:a05:6000:186b:b0:485:8c16:a35b with SMTP id
 ffacd0b85a97d-4858c16a72bmr1619640f8f.51.1788507797687; 
 Fri, 04 Sep 2026 00:43:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm4349150f8f.32.2026.09.04.00.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:43:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] agents: Add a skill for finding your way around QEMU
Date: Fri,  4 Sep 2026 09:43:13 +0200
Message-ID: <20260904074314.896384-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

As a side effect, establish scaffolding for the .agents/.claude/.gemini
directories, as a base for future patches to build on.

Some parts of this skill are based on
https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.

Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: add .claude/.gitignore.  Suggest using get_maintainer.pl and ./run.
        Fix thinko around build/source directory


 .agents/skills/qemu-codebase/SKILL.md | 100 ++++++++++++++++++++++++++
 .claude/.gitignore                    |   2 +
 .claude/skills                        |   1 +
 .gemini/skills                        |   1 +
 4 files changed, 104 insertions(+)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 100644 .claude/.gitignore
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills

diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
new file mode 100644
index 00000000000..17fb55b5289
--- /dev/null
+++ b/.agents/skills/qemu-codebase/SKILL.md
@@ -0,0 +1,100 @@
+---
+name: qemu-codebase
+description: Orientation for QEMU — tree structure, build system, documentation pointers
+---
+
+# Useful reminders for working on QEMU
+
+## Finding things
+
+`MAINTAINERS` is the authoritative list of subsystems.  You can
+use it and `scripts/get_maintainer.pl --nogit` to query it, for example
+
+```
+$ scripts/get_maintainer.pl --nogit -f block/
+```
+
+`docs/devel/codebase.rst` is a guided tour of every top-level directory.
+Here are some important ones:
+
+- **target/** holds CPU models and the TCG frontends
+- **tcg/** holds the backends and the IR. See `docs/devel/tcg.rst`,
+  `docs/devel/tcg-ops.rst`.
+- **hw/** is devices and boards, categorized by type.
+- **linux-user/** and **bsd-user/** are almost entirely separate, and only
+  have parts of **hw/core/** and **accel/**'s CPU emulation infrastructure
+  in common with system emulation
+
+Other directories include the back-end subsystems, for example **`block/`**
+for the block layer.
+
+The `include/` tree mostly mirrors the top-level tree.
+
+## Build layout
+
+Build is always out-of-tree; the build directory is created by
+`configure` and a checkout can have several. Determine it from context
+(`ls */meson-info`) rather than assuming.
+
+The `run` script in the root of the build dir wraps `meson devenv` and
+should be used to execute commands in the build directory.  It activates
+the build tree's venv `pyvenv/`, adds various Python modules from
+the source tree to `PYTHONPATH`, and defines a `MESON_BUILD_ROOT`
+variable for general use.
+
+`make` at the top level forwards to `ninja` in the configured build
+directory, and any `build.ninja` target can be invoked that way.
+
+## Build & Test
+- **Build**: `ninja` or `make -jN` from build directory
+- **Test All**: `make check`
+- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
+- **Single Test**: `./run meson test <testname>` (e.g., `./run meson test qtest-x86_64/boot-serial-test`)
+- **Debug**: Append `V=1` for verbose output or `DEBUG=1` for interactive test debugging.
+
+## Code Style
+- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
+- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
+- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
+- **C Comments**: Use `/* ... */` only. No `//` comments.
+- **Naming**: `snake_case` for variables and functions; `CamelCase` for types and enums.
+- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`) APIs. No `malloc`.
+- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
+- **Lints**: Run `./scripts/checkpatch.pl`.  On top, `make clippy` and `make rustfmt` for Rust.
+
+# Documentation pointers
+
+Developer docs live in `docs/devel`.  A `kernel-doc::` directive includes
+documentation comments from source files when Sphinx builds the documentation.
+These comments be consulted just as easily in the source tree without going
+through e.g. `make html`.
+
+Here are some useful pointers.
+
+## Core abstractions
+
+- **QOM** (`qom/`, `include/qom/`) is the type/object system underneath
+  everything.  It includes class and interface hierarchies, properties, and
+  the object composition tree.  See `docs/devel/qom.rst`.
+- **qdev** builds devices on top of QOM, adding for example buses, the
+  realize/unrealize lifecycle (including hot-plug/unplug), and reset.  See
+  `docs/devel/qdev-api.rst` and `docs/devel/reset.rst`.
+- **MemoryRegion** (`system/memory.c`, `include/system/memory.h`) is the
+  guest address-space model: regions, aliases, address spaces, dirty tracking,
+  load/store and map/unmap operations, etc.  See `docs/devel/memory.rst`.
+
+## Concurrency
+
+Getting the threading model wrong is a common source of subtle bugs here.
+
+- The **BQL** (big QEMU lock) protects most device emulation; vCPU threads
+  hold it when exiting to emulation.  See `include/qemu/main-loop.h`.
+  Memory regions can (carefully) opt out of the BQL.
+- **AioContext**/iothreads: block devices and their virtio front-ends can run
+  outside the BQL.  See `docs/devel/multiple-iothreads.rst`.
+- The **block layer** is coroutine-based.  `co_` prefixes and `coroutine_fn`
+  annotations are advisory but relevant for reviewers.  Coroutines have their
+  own locking primitives.
+- **RCU** is used for hot, rarely-modified structures such as memory maps.
+  Because of the BQL, RCU is mostly used with `call_rcu()` rather than
+  `synchronize_rcu()`.  See `docs/devel/rcu.rst` and `docs/devel/atomics.rst`.
diff --git a/.claude/.gitignore b/.claude/.gitignore
new file mode 100644
index 00000000000..b0a57a19c01
--- /dev/null
+++ b/.claude/.gitignore
@@ -0,0 +1,2 @@
+# reserved for the user to add their own per-project rules
+/CLAUDE.md
diff --git a/.claude/skills b/.claude/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.claude/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
diff --git a/.gemini/skills b/.gemini/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.gemini/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
-- 
2.55.0


