Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EB8CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEq-0002zp-Vk; Fri, 29 May 2026 06:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEp-0002ys-Us
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEn-00014j-4h
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so87516955e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049684; x=1780654484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqFcEliVLrWjG6hw+VNEfwAjIL+FibvQJbuJivKWimw=;
 b=yesDikIP2FZUgnap1z4tYDyumo1dcifBva0GLSw30FNl7CuOdSuWKf5ZhrWZ0ZJUkP
 of68hiMTCGDeyYgTwa1hD97tWs38BmiAf1DtyX7uYx4bwWIO6ATET6ECn5PWy+q402RR
 tnR4QsyJAt33mROGbZ/9zyoZsr5ASHmsHYzZcITFuIC6Ev6PhoigbPI9bLGJK1KvuQ+3
 AOmhPxajkYuFVPxyRwKXc1b2q+ftrlg7g9EuA7JoxqD1SosQyITQ8KivPscUsYx945/6
 BUv3DF6pA/+JGScoL1wso3JfoLjI48ounNhhxKeG7IRu4l43okO3NzLFJe/smiGhmsGE
 cuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049684; x=1780654484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lqFcEliVLrWjG6hw+VNEfwAjIL+FibvQJbuJivKWimw=;
 b=LmTEu7RJYGk5Sa1Gh6m1/GENOAgp4CuilFHNg22nyjsNArIGNf2k10FUVqfzWgPi0y
 J6yIvUa0seLfWAIqPWd/EHDBZh+KE9k04oeTI6LLW95+yqjqnUX9yUOHe3I7abQiqFZi
 SdcbXRkTVU4vTQVdDA5Z3iLDMIkmiw3+HjkPlLT/WinOVdrpzO8ahzocMyoM07EUmF0P
 40kJdbgknYc/fn2jDYiFiExPgVLOmh/6Ohj7RR/0qu8Eqp1WtAyK7WZtmFgo2kj/n0BR
 urzWALFlipeQkfTgDQozFSEph5kyQ8pmp1fvlB75IMvaZHWcPL1hSTXkxrFFOUYpY0Ib
 Pi+w==
X-Gm-Message-State: AOJu0YwPjOFnKrgtpB/7T2anLz4MBFNmCmN/kGK19h/M+vyLVK9xbufH
 t1XFUeJtYMugqqISW9+6ay2JnQE+vJLIISj43Sv8sqWhxryx9lG947ZzVBYt04m+9Es=
X-Gm-Gg: Acq92OHbsuXxB2Jp+KYCgtgitBcNthaBqctaYZLIGQVxlQt9YkxFRrMr3EDYTCmrLNJ
 oOzprYULOcZUpY2UjRlL00bCRp5bMnZaJMgfCQE7cS7zdLnr9ksXEvs0dsFXDJoBVrnE/naZl6o
 8IeOggk0UrCO/ezJ9NbgLM5CGvuU30EIeowZkW7RulKGhsr2H16tFRQwX/hMFDQ5llVnSvEwFij
 ByFj5JLfL/+nsFBSI5sOi37+pzIsxbPvI6z+XvrkgkEZxaZ8V2Kf1PS3g2xqN9jUJJVxvvMazYB
 UxTY2j+dHCMSKIq3JDBSOcb5D2UVNYQ1BEFPW0XEKVAXuK9cRadIgRKNcjtJfCjDq/yhF9gEbc3
 vAFxpdtqI3cTEBXA5QJpQpy1g98nsTFT3Y8u+vi/CVaZHh9SpZBTXecfqZsLomNeLNqwxUYoaqw
 lLNxvYXVfr1SKywoyZlUa/PMSKPP0GNq7f4w==
X-Received: by 2002:a05:600c:42ca:b0:490:890a:da46 with SMTP id
 5b1f17b1804b1-4909c091a2emr24575795e9.2.1780049683595; 
 Fri, 29 May 2026 03:14:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68a925sm46590565e9.2.2026.05.29.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA01F60ECD;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 10/12] .agents/skills: add qemu-issue-helper skill (caveman)
Date: Fri, 29 May 2026 11:14:35 +0100
Message-ID: <20260529101437.410181-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

This provides basic instructions for fetching issue details and
summarising details about the issue for other agents.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-issue-helper/SKILL.md | 47 +++++++++++++++++++++++
 AGENTS.md                                 |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 .agents/skills/qemu-issue-helper/SKILL.md

diff --git a/.agents/skills/qemu-issue-helper/SKILL.md b/.agents/skills/qemu-issue-helper/SKILL.md
new file mode 100644
index 00000000000..15ab983f083
--- /dev/null
+++ b/.agents/skills/qemu-issue-helper/SKILL.md
@@ -0,0 +1,47 @@
+---
+name: qemu-issue-helper
+description: Summarize QEMU issue analysis. Help sub-agents report findings (build config, CLI, tests, GitLab issue data). Trigger when analyzing QEMU bugs/GitLab issues.
+license: GPL-2.0-or-later
+---
+
+# QEMU Issue Helper
+
+Help sub-agent summarize issue analysis for main agent.
+
+## Fetch Issue Data
+
+Use `glab` for GitLab issues. Repo: `qemu-project/qemu`.
+
+### Commands
+- **View issue**: `glab issue view <ID_OR_URL> -R qemu-project/qemu`
+- **View comments**: `glab issue view <ID_OR_URL> -R qemu-project/qemu --comments`
+- **Search issues**: `glab issue list -R qemu-project/qemu --search "<KEYWORDS>"`
+
+## Report Format
+
+Sub-agent MUST use this format for GitLab issue summary:
+
+### 1. Issue Context
+- **Source**: GitLab URL/ID.
+- **Title**: Brief description.
+- **Reporter**: Username.
+- **Relevant Commits**: Related commits mentioned in issue.
+
+### 2. Build & Reproduction (from issue)
+- **Environment**: Host OS, CPU, QEMU version.
+- **Build Config**: Required `configure` flags.
+- **Reproduction CLI**: Exact QEMU command.
+
+### 3. Proposed Fixes & Series
+- **Proposed Fixes**: Suggested code snippets or logic fixes.
+- **Patch Series**: Linked patch series or MRs.
+
+### 4. Discussion Summary
+- **Consensus**: Community understanding of bug.
+- **Constraints**: Blockers, requirements, maintainer feedback.
+- **Next Steps**: Action needed to proceed.
+
+## Rules
+- **No Independent Analysis**: Summarize ONLY issue tracker data. No self-made root cause analysis.
+- **Terse**: Keep it brief and technical.
+- **Links**: Include direct links to comments or patches.
diff --git a/AGENTS.md b/AGENTS.md
index 9e373c98573..d842fc62e98 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -51,6 +51,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 - `qemu-mail-thread`: For analyzing and parsing mailing list threads.
+- `qemu-issue-helper`: For fetching and summarising issue details from the bug tracker.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


