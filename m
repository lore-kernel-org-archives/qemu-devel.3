Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625DCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRe-0005uY-I2; Fri, 15 May 2026 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-0005dl-Nq
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRG-000277-2G
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso217805e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862660; x=1779467460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8toGhl6HNFSdtVND/yM1sQU/Jwuqjo1Ew04f+H6Atk=;
 b=dwrK5A7T2Qptp3R4UxPEktb06V+mxmUHb+qHyCONj1zqLt/mr1vwaa7ypOLcwICzlW
 wBWOli3dVrmdwBEMzRh4CCqa9wA+2+8Xqak6rXYbwQNBuCnOHqKGoBz8hXT5adE0TpZ8
 XQbqgDhYYD/+W6BatT2hqFKo5PptULy10pxRPpnXFVRW24NuTDr5ziTMG20+rvWv3k5G
 Ij6yHZw25ObsKvB8Z6PENGv+7PRHCN0qKaDUAHCLPrqp+3WXRU8oOp15gi5apURROXwk
 uCoBIPf1P3QKgSRWxK9MMyYr/D97oq81h4+A+A0Zr9EDp4/gwlv33lfhklrId9N/xxRu
 oEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862660; x=1779467460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8toGhl6HNFSdtVND/yM1sQU/Jwuqjo1Ew04f+H6Atk=;
 b=kYP0LyR3MIoWDXrrJIohSj+9l90cihbb9Ncia8iFvah4cTn4fk3wDT4Fi1ra9gC+38
 4kLAq6lNERRPFyCak8TNtp63QaZEYRRs/nWm9FD89o+2voKsBP6ut7JtdXmX0Uh1Wm9G
 vjcFYQk2zGCSQAHEn547CkScl2lZXGoOXiOUDiMM6FnHbn2N8NZadVgzW9TuxX3aFrKP
 PwwAOr9gXiW3Ht4gM22YtoGWlxBsf+ePBkrszGwxS6/sp7c0s1xspAQNiiKpsAekTxsI
 uuQP117k3ZkPpQrHPlfT114ClCoWxVu0Gb69AhYdmrpm1RAnpQZH2PpZzJD1REgFFUJA
 K3PQ==
X-Gm-Message-State: AOJu0YxzaAYDZEuMcGfxndrnP9rQI/Mb5KX6Sh/L64MIA2n14+Q7FiDX
 WbQ++6TDl6PVqSFw3AN247BceZuwkhOaJLjc3LhVDJ8HZ65K41yWeYt77SxTSpME1K7w87xKG40
 7iOtnDOs=
X-Gm-Gg: Acq92OFNhJyJ9/+DQ6nxS1sblZa/7dW7lp+mgtNfket473Z9eNSchJwKKD8xTxAg6Qk
 SmwOGHZn2D8w0FGbrNuwq2F68GsfuC1yvtn5bmTWSu1BIJ4g1o2fRMnrfLOjansUOCD3lzN0WmV
 ylrQIJEiy+b2YujztluXbPsghEsK8BBCCRLUWCC40k96xOvhHfsZLMJoe15ChjHoz8vqMaDcq59
 C40RJElwi1zvDVAf8N0WVxFoELLsaKWbXAXaGxiOhJedVDcyG1jOO+mVyO3O7i/9lwm0N0f5oAD
 xjMhdt5MptOn8sOGptvZ9U0AzJgUyEUGjWVbyiU+YaXj/8hjmR4URfLdii7gme7r6ncNQG5pLXH
 OgRqY4undSot3fHLDtelLmAm0EAIUh7ywfDcwLVzQo8DxwAIF0HKVIcPU5ecnBqwomMH7Dr6CN4
 LMaZGy+9Mq1OjiU5tEmpi+8LU=
X-Received: by 2002:a05:600c:48a8:b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-48fe651e11cmr40956605e9.31.1778862660456; 
 Fri, 15 May 2026 09:31:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2a878sm30983345e9.1.2026.05.15.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 54C2D5FA65;
 Fri, 15 May 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 09/11] .agents/skills: add qemu-issue-helper skill
Date: Fri, 15 May 2026 17:30:52 +0100
Message-ID: <20260515163055.1792262-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
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
index 00000000000..725097bac36
--- /dev/null
+++ b/.agents/skills/qemu-issue-helper/SKILL.md
@@ -0,0 +1,47 @@
+---
+name: qemu-issue-helper
+description: Summarize QEMU issue analysis for main agent. Helps sub-agents report findings including build config, CLI, tests, and GitLab issue data. Trigger when analyzing QEMU bugs or issues reported on GitLab.
+license: GPL-2.0-or-later
+---
+
+# QEMU Issue Helper
+
+Assist sub-agent in summarizing issue analysis for main agent.
+
+## Fetching Issue Data
+
+Use `glab` to retrieve issue details from GitLab. QEMU primary repo: `qemu-project/qemu`.
+
+### Commands
+- **View issue**: `glab issue view <ID_OR_URL> -R qemu-project/qemu`
+- **View comments**: `glab issue view <ID_OR_URL> -R qemu-project/qemu --comments`
+- **Search issues**: `glab issue list -R qemu-project/qemu --search "<KEYWORDS>"`
+
+## Report Format
+
+Sub-agent MUST provide a summary of the GitLab issue discussion and findings in this format:
+
+### 1. Issue Context
+- **Source**: GitLab URL/ID.
+- **Title**: Short issue description.
+- **Reporter**: User who found it.
+- **Relevant Commits**: List any commits mentioned in the issue that are related to the bug or previous attempts to fix it.
+
+### 2. Build & Reproduction (from issue)
+- **Reported Environment**: Host OS, CPU, QEMU version.
+- **Build Configuration**: Required `configure` flags mentioned in the issue.
+- **Reproduction CLI**: Exact QEMU command used to reproduce.
+
+### 3. Proposed Fixes & Series
+- **Proposed Fixes**: Flag any specific code snippets or logic fixes suggested in the comments.
+- **Patch Series**: Note if any patch series or Merge Requests have been linked.
+
+### 4. Discussion Summary
+- **Current Consensus**: What is the community's current understanding of the bug?
+- **Key Constraints**: Note any blockers, requirements, or specific feedback from maintainers.
+- **Next Steps**: What is needed to move the issue forward?
+
+## Rules
+- **No Independent Analysis**: Do not perform your own root cause analysis. Summarize ONLY what is present in the issue tracker.
+- **Terse**: Use brief technical English.
+- **Links**: Provide direct links to relevant comments or patches if available.
diff --git a/AGENTS.md b/AGENTS.md
index 26a9c93007b..6a91c39638e 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -35,6 +35,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 - `qemu-mail-thread`: For analyzing and parsing mailing list threads.
+- `qemu-issue-helper`: For fetching and summarising issue details from the bug tracker.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


