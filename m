Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0BE9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFd-0005dw-7z; Tue, 24 Feb 2026 07:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF8-0005XK-IW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF5-0005s6-7L
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:21 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65807298140so8089467a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935017; x=1772539817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dy+/3k/+giCiVkrl7wREedy6JTUvCtf6hW0/UGpetdM=;
 b=oQQXexsXVx6wRCeUSoNOYZfC22dBcP5dCRIjdGPD4BvDgJzAuJJ6881FYOHGFm+cyd
 e3eA82I2t5bzN+EgVe1cAlUnX4ITGldfUdoxlmbBQHWPvI5yp7brmKO4MDsdD4QYe45S
 Noviqagx1IuIeDMzh+qQcUFvj6TTZhERxDE0JE6C6hKlzuPfWy9dJ7qGjMJTAi56d+Zc
 arHzCiZq7REh98KEXp4izXaUSj2MW3glieKqB+VyFMl54G80w+DNZfYKs8WW9l7LvUc6
 1N3PZbP+7Bm73gVs9C9WgadX88+scpWhvHiKHx1jC0O8S9rUxA/egVW8WuLOiJbaG+1O
 r0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935017; x=1772539817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dy+/3k/+giCiVkrl7wREedy6JTUvCtf6hW0/UGpetdM=;
 b=MLvjzlz1BUGOqq3p5qAIrM1iHC538555ed/DCsv2mynMWgt7VsWMk0vBcvNOWlhBqr
 0tAAyMqpkycOMZAVSoivAkHopEos6bCIYK2lmnjj0CveoDiP6ZlVnUuRSVHukTBT7uGQ
 0tnS9O1PrZVh+XGTjlkqr6fDgRP4m8dhp1QZlA2H3GMYp8vV9dJoYXWn/tTwcGoJpgaL
 irUznhQEx0sgDW/dgsTWFl/WYaph+OUDvZCDHexyDXNLrlA7pBbiVB4311fDFN05LIiZ
 Y/oClVlHrc8220/XUj8wfBxwj5FBjAO0lcLyZQjxdTJ6tWv/I6EcB9Ae0UKVBOHGgstg
 KkWA==
X-Gm-Message-State: AOJu0Yzqqe1xCZ3QYBv1Tyy8LO/VOfG+SjiZnBsuWvzvncnnBEkXE5vf
 VyqI1oUmOcqv6xauRe/A9LkfJzVUzRzqTs7G9pXSLu7EbyyxsYiHUXBqKSLip6dFWFs=
X-Gm-Gg: ATEYQzwwS/+3vqMnfMkWjO1AzCljjw4vSl9cqEN0S9waOo/evQWtLh9csPPzuESkm7P
 YSIN/ewTp1EY0NakYGvV1sg7aptioFBrXd60ovmt3JJTh6bUhNT9xfsJgd4IFyc5qoFn4skzmay
 Hz150Wb0h69TsDgX+ohpRnMCKj/1AbKsuCRYCrqiaBJl7rw9Po3QPmzl7VzVzwcduexlT2JViHe
 60md179QK8vu7QYbn1BxPIkLdRje+DjrPMq5egO8B64sysn1fGfCifhAEACIZvp4y2HQvZ3qbhK
 jvyRmwI8GWZCJ3y9jemrR29dgMZeQovx91KJHlJjaneVJwVd516NniE7bfXdY9ufUYwMrIrv9b/
 PQiqnH31iVvMTmJztPlwbZOciv1AzrVxEhtdpMX+QK/jlWHYu0chANwwm9jZm8/rTjBTGvUUbTJ
 /IWd/FUp68XmveygR1hNiAWbdwTaU5xa+onw==
X-Received: by 2002:a17:907:25cd:b0:b8d:bcea:438 with SMTP id
 a640c23a62f3a-b9081b9b91bmr826781966b.44.1771935017346; 
 Tue, 24 Feb 2026 04:10:17 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e4bf43sm419441066b.42.2026.02.24.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3C315F8C1;
 Tue, 24 Feb 2026 12:10:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/8] AGENTS.md: add basic AGENTS.md for QEMU
Date: Tue, 24 Feb 2026 12:10:09 +0000
Message-ID: <20260224121014.279248-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

This was written by ECA based on it's initial understanding of the
code base. It's mostly quick facts and pointers to common tasks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
ajb:
  - I made a slight tweak to use pyenv to run single tests
---
 AGENTS.md | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 00000000000..5b54763f4b1
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,18 @@
+# QEMU Agent Guide
+
+## Build & Test
+- **Build**: `ninja -C build` (from build directory) or `make`
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
-- 
2.47.3


