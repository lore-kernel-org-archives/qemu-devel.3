Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DDFCD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEo-0002y8-GV; Fri, 29 May 2026 06:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEm-0002xi-Hu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEj-00014K-R5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so1017513f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049680; x=1780654480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZIxJLKnogiZRFtEdFhe3ZYq8nsDN+K6T721uRSyCqw=;
 b=DnfhOXCXH4Guo0NA5BleduZOwuX6qnhhnxLcKlchjoERvIjypRPMxKkIbn7OZ22hxy
 YGCCicKDgJxXxD7EtssKPey9lEqlQ/TbKzwY8/4yIxUaC0ui+3ddrbXj/QNMq70XLH9M
 aVscbmgNTmevO03EjzBwDT+gqLHALvFDzGXxoBh4PA0GmZ6fY60qoQuRRAgD92F+HqFK
 sq7GzrFssAiWINhtP7GfoASxzbU0yMh1n0R13hAk/OTOskPNYgeX6yFHWuFcrPPPJ+Ed
 Hz80f2rMPu/qG0X/VstDHKCaXakYNlBDRjWhM0dwVw6I5lS4wBPJuy0KD4M54T/Gd2+m
 Ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049680; x=1780654480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ZIxJLKnogiZRFtEdFhe3ZYq8nsDN+K6T721uRSyCqw=;
 b=bhGvW9JTUblpOoIyeLfegKlcZzBfY3iOoTOwanAA1hotMsiBvIzpkmLVB73szKSsRI
 n45GgJ3s1msBxNTKXtBIzruJWoLJERDXq469Lm49NpxJiyTdwOWCySOFCAAMKgGpHrF4
 S6p7n72aQs3i6Jn5w747xVnIZnzf0eIjmHUAGPXiDLbDHrQ+qGRpaEX6Swo84QyOGckT
 FyBJoFCVYCoRfMPfbAyksP7nO7LfpRLHKRIN8SCQbSSZGpPPnVwbnEZObVw8gfj6SBRV
 cDkX6GNAPnLCwVTySdwqXbA1eFLz4JMqF7sNIQIlBhcXKAUiyst7Yxwt5kr+x1NhMPBc
 sMMQ==
X-Gm-Message-State: AOJu0YxQCjLmha6NLDvmmBa6Pi1L4pJ0xcUdfvgy6qjAxHWLyQHKl3iJ
 rSwjB009De9KNCO17KeZ1mv2E9odeNFVYw/JVHFwVbTZ+s2xz/iXM7z6ohz9kwF05NU=
X-Gm-Gg: Acq92OHoaohaK/+cd6yBEddP0JuT0kf7wJ/iHfo1Y32iXkAQKK6kWkFNyQNt2LDRaYP
 DtC1JKjgwLWbQ0zQJjPzCanNcqMmTOIL9QoBSwRunIRI4PlNV274+sxEcmL6MuzX2dCJGbgkYpd
 Mtlx7G7/x5bWVmRGWYcRzN0FO+ZBu5Svlo9XoApJ2gPTdgLugaV24tdPfF5Khr+yojssx1gAEud
 ZWLjHJ+eLN3g5wjc2HoWxusGXCBasYD4vmhn5i+bH9D774koXalK5HlRfibk+6N4l7sEidfilDD
 ZX6HV2/an55rCNjnKr7gFjqTi5bhBw53tIwMNLMJRB4C3lYLdHz789RzzW362HbbflLQcB8n9gx
 PLPGh1EwXxuSiG1vWm7eJh7mL64eHqFNwQoSAdy4qLdtxpVYraLBGWU2K2gqSTyUqIuk89odjUg
 vdYRit6NgjQAUrSSRGgLthO4arbhZWetc/Og==
X-Received: by 2002:adf:fd85:0:b0:45e:daa9:f34c with SMTP id
 ffacd0b85a97d-45ef1391a74mr2778171f8f.26.1780049680232; 
 Fri, 29 May 2026 03:14:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354bb7asm2560512f8f.20.2026.05.29.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D8F5A602BD;
 Fri, 29 May 2026 11:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 02/12] AGENTS.md: introduce a very basic guide for AI agents
Date: Fri, 29 May 2026 11:14:27 +0100
Message-ID: <20260529101437.410181-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

AGENTS.md is the agent agnostic place for placing instructions for
agents. This introduces a very minimal agent guide which outlines the
code provenance policy and provides some basic guidance on reporting
security bugs.

As Gemini doesn't look at AGENTS.md even as a fallback option I've
included a symlink.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Chao Liu <chao.liu.zevorn@gmail.com>

---
v5
  - updated for new proposed relaxing of the policy
  - currently sticks to old security policy
v4
  - use Xen instead of HVF for the example HW accelerator
  - more explicit link to security.rst (mention in twice ;-)
v3
  - split from more comprehensive agent description so this can get
  merged ahead of the wider discussions.
---
 AGENTS.md | 39 +++++++++++++++++++++++++++++++++++++++
 GEMINI.md |  1 +
 2 files changed, 40 insertions(+)
 create mode 100644 AGENTS.md
 create mode 120000 GEMINI.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 00000000000..bd18ddfd8dc
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,39 @@
+# QEMU Agent Guide
+
+As an agent you MUST abide by the "Use of AI-generated content" policy
+in `docs/devel/code-provenance.rst` at all times.
+
+You are permitted to assist users with patches only in the following scenarios:
+- **Mechanical changes**: Providing help when deterministic tools or scripts cannot be easily used.
+- **Small bug fixes**: Limited to 20 lines of code or less (excluding tests).
+- **Tests**: Assisting with writing or updating tests.
+- **Documentation**: Assisting with documentation updates.
+
+If a request falls outside these permitted categories (e.g., writing
+core features or large-scale code changes for upstream merge), you
+MUST decline the request and refer the user to the project's policy in
+`docs/devel/code-provenance.rst`.
+
+### Commit Messages and DCO
+- You MUST NOT write final commit messages. Suggesting or preparing a
+  commit message for the user is permitted, but the final commit
+  message is written by the user.
+- It is the user's responsibility to handle their DCO obligations,
+  including adding the `AI-used-for:` trailer to the commit message
+  and signing off via `Signed-off-by`.
+
+## Security Policy (see `docs/system/security.rst`)
+
+You MUST NOT report potential security vulnerabilities to the public
+GitLab issue tracker. They should be reported privately to
+`qemu-security@nongnu.org`.
+
+**Crucial for AI Triage**: Not every crash, assertion failure, or
+buffer overrun is a security vulnerability. Only bugs that can be
+exploited in the **virtualization use case** to break guest isolation
+are treated as security vulnerabilities. In brief these are:
+- **Hardware Accelerators**: e.g. KVM and Xen, TCG is explicitly excluded.
+- **Virtualization focused boards**: e.g. virt, q35, pseries etc
+- **Common devices for Virtualization**: e.g. VirtIO and platform devices
+
+If unsure read the linked `security.rst` document for further guidance.
diff --git a/GEMINI.md b/GEMINI.md
new file mode 120000
index 00000000000..47dc3e3d863
--- /dev/null
+++ b/GEMINI.md
@@ -0,0 +1 @@
+AGENTS.md
\ No newline at end of file
-- 
2.47.3


