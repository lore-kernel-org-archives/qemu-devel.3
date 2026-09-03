Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F99C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x220R-0006D8-35; Thu, 03 Sep 2026 03:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x220P-0006D0-Js
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x220N-0003PD-9m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788421021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xcm1sLKv+ipY+j82xnEgT4mxOfLmHX9WxVfwC4HRr+c=;
 b=hBQqi1icjItgpYOyPz61hN+JFQLf+JATo9BiV2UiEu6UxQuBPtRUU0BIs5Ao5Z89+AGDWp
 NelKCiPsH90xZV9GTALkiimeOL2/Y9Vbtg4TXym+M2wFPf8S1tNyptZVRtkl3A76KbnUvC
 nSeglLdK1VH36iwxwv88TF5/2YVHDfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Ye0oxH0wPg-E5X32brj7_Q-1; Thu, 03 Sep 2026 03:37:00 -0400
X-MC-Unique: Ye0oxH0wPg-E5X32brj7_Q-1
X-Mimecast-MFC-AGG-ID: Ye0oxH0wPg-E5X32brj7_Q_1788421019
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-484337a63bbso1263186f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788421019; x=1789025819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xcm1sLKv+ipY+j82xnEgT4mxOfLmHX9WxVfwC4HRr+c=;
 b=B5iOc4V9SGEj43BM5VSleL/LjvjTVxHDMj+lVoa0dBSdZnUtLZxl80cUZwXYpFS9mN
 fsh0LHnwC3fOq1cxd16Us+RPmwkN7R1FDxpQsR8rBQcEm2jrGDmoyJdn8a7K11harDRx
 qG/wq3TLhq8yr/xSlu+Xgh6nKkK4yoam2oLbPW3xFfxSHQNGwjdduma7mePnG6/DVsYf
 uYuvQM2HNVQiYUb3ZSFC0TtGwMPYwWWX8ID4gMW/7jVnijNd4xSkTjSRG+Ldr0HJforv
 OmE0jD847BXnVs3yaJkR+Usybs4fi7z05qbiQYCQ+h/ypmoJAUcWCUJs34+8eHHW/ZL+
 6q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788421019; x=1789025819;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xcm1sLKv+ipY+j82xnEgT4mxOfLmHX9WxVfwC4HRr+c=;
 b=RVD0lm4JOw4ocIg+fSHoqOeTzPx6C11oIbuUH4fBTc8al6PO5rvPQg3P/FTfMTpHZg
 iAbUwO9nNP2qApQWoirorCVBeNpxZKrBqHGIbSU2ilqF2eF1n0duVFK2UoyJmc05b9Ld
 nZAqL8hgiYu55prCJmvkyTqiN34CsWwKnNaxkzwCmvHvCifMtLpaFqJwMdj5pxBrSSBB
 jwNPHE9TU2CWG2wNZMpRtu9VKXj9LjCkkNih4yKU4vq6VxuuKCo2hyMPSGVwvs/hhD1z
 6ECPBmEIPjyUaXxg50IS+XOwo2Aonb0/nHqFl5Et3tF2zvHjAIc+61JX9Yko7WOnuhzt
 2KXQ==
X-Gm-Message-State: AFuF++m6mFzJ6FVABnrnT0YkJenkj31dQRs+mH2tcaWnT4P2k5yFv5hD
 nYvS3s2uLrkmMenDGcf6uaH6YZjq8eDSJVh+yy7qO7938x9doXX6P7yuCM3gGMa4Y12hWqwKFTf
 HmQAVweXp/wqdlEKV9tmdB2JYtikINx4GK/Vrwfc1Tw+xjgbNPN0E9twXLd8A3pOgFgP/nKAdma
 nf/3rUwigg8B37JGXVFRbRFJZqWxDuThX7/Y2t9OPy
X-Gm-Gg: AYBFou0mIP8vTKo0syVm6Q9dBGWJtjgd+/zBNiwmoExNTqZ8EJkMZQqf2ozhytyR/NM
 d8NzeuxfF+6qbsVPQYLnPNszk9fySbqbWyCWd5XQ7RRq5aHim3cjFlaUF+9f4lFQvgr6ZSBe5Sn
 kV5+pH0sJUrxKho+C3favG5Rh7i9Ad3SJq45azMfRX2zk+nb8c84lHfvZaQTy3Mc2/+hObO28A8
 zU8Gu5zK8dFZ8cyAAac15iMf9UHRNuG6sd3Rq0x+3qpDUJKhwH24HTG/x7VOsgv5q6qURU4g9tP
 DT7EnmA2Rxzzo/gfq+z4bR+whxKldbuspHK9WuFjF2jFOyU9pSdNU0bP1ANOhytcdCN/xsebrIO
 m2+kzzpGWCall2ooMIsOxziERjLFxWXVzt1C1E7SHJUqoo56MmnMiKkE/Ylg0+Hk4VDwmVtr5ql
 7bmJ0=
X-Received: by 2002:a5d:588f:0:b0:484:4153:11df with SMTP id
 ffacd0b85a97d-48488f04b19mr17149938f8f.11.1788421018951; 
 Thu, 03 Sep 2026 00:36:58 -0700 (PDT)
X-Received: by 2002:a5d:588f:0:b0:484:4153:11df with SMTP id
 ffacd0b85a97d-48488f04b19mr17149839f8f.11.1788421018359; 
 Thu, 03 Sep 2026 00:36:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3840sm12538218f8f.17.2026.09.03.00.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:36:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] agents: Add a skill for finding your way around QEMU
Date: Thu,  3 Sep 2026 09:36:56 +0200
Message-ID: <20260903073656.540570-1-pbonzini@redhat.com>
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

Some parts of this skill are based on
https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.

Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .agents/skills/qemu-codebase/SKILL.md | 93 +++++++++++++++++++++++++++
 .claude/skills                        |  1 +
 .gemini/skills                        |  1 +
 3 files changed, 95 insertions(+)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills

diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
new file mode 100644
index 00000000000..6769c6c5ea4
--- /dev/null
+++ b/.agents/skills/qemu-codebase/SKILL.md
@@ -0,0 +1,93 @@
+---
+name: qemu-codebase
+description: Orientation for QEMU — tree structure, build system, documentation pointers
+---
+
+# Useful reminders for working on QEMU
+
+## Finding things
+
+`MAINTAINERS` is the authoritative map from file patterns to subsystems
+and maintainers; use it to work out who owns code and which tree a
+change goes through. `docs/devel/codebase.rst` is a guided tour of every
+top-level directory.  Here are some important ones:
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
+Every path below that starts with `pyvenv/` is relative to the build
+directory: `configure` creates a Python venv there, and `pyvenv/bin/meson`
+is the meson that must be used.
+
+`make` at the top level forwards to `ninja` in the configured build
+directory, and any `build.ninja` target can be invoked that way.
+
+## Build & Test
+- **Build**: `ninja -C build` (from build directory) or `make -jN`
+- **Test All**: `make check`
+- **Single Test**: `./pyvenv/bin/meson test <testname>` (e.g., `meson test qtest-x86_64/boot-serial-test`)
+- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
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
+- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` and `make rustfmt` for Rust.
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


