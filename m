Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E45CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9G-00080F-Ro; Tue, 05 May 2026 13:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ94-0007ww-Ks
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ90-0003TF-UB
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so1416726f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000471; x=1778605271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Isl8JoOFL9hjxCtszajUoeGsLUfaDIk2xEQacXFMD8=;
 b=zHtLSw212pyv2lbhwbvXO1nhixSU+md07Box/MwilF7TqPadXoidiQDmnTFc5b6DmY
 ImV5Z5tuWG+JtTiD5Gloaszb7br6c22oA9HL2Q1j8P4c5rKvBAV2nijSA5P5rZVRM5IP
 iSgqBb9Ze4QYacz41sA3asGmnilu5b4k99Q9PEk4XEoL3SswMgRgGYjIQUTp9srxZhWt
 kReiThaVVyInLcmp7PDGv1zo3kNR9DG6yKATWrTM1vRS9RJjil+POVViXPrV41gqNvtm
 LQut7rB9Vm976WWUJvpMTshloaql7CANoKFxnfPR8qcVu21Rm7o9SpHx7LLF73XzxF22
 HY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000471; x=1778605271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Isl8JoOFL9hjxCtszajUoeGsLUfaDIk2xEQacXFMD8=;
 b=bCo1azGWk43GXFmMHZAI6zGLnDuwRnvDi9VMGHsKPjb2KQC7Y2B0gpcuAYD6PzMxsx
 ojZQ9x33BhP/pvCGZPCVb1GeaLEHvfsYOEsfIs+8n8Vz/ZvOzQjkoSnRGHhdSpLjU+rO
 EmAqRQ5hnIxrGSFAdRPNICJVwLGJ6RBMRrpkM+kmFRdloZqliZyigEPzMiBCemM+0zoT
 qMC/1qylaPT1Oq/lur5A3lIGB8qoj3GoPqYlGjwoUXsLDtuMjN+hxr0FyCsJ5Hv3NBHV
 2vDiHBs9rlRr5dKCsT/IcDIOMQXof19wEZqSOz+KWb/yWIusU3JUBENOAra8c/j4RoLh
 QkOw==
X-Gm-Message-State: AOJu0YyG1n/kPRFXBCpZIHE4dyQ0Yxj7upylikCkegEasvzLju6ZMwkD
 ZpXgdsZtigdookRVfiSYM3lzBF8A63rE0gx2U0hDv6VW4y3n2ALeIVabfJj1fWdOUTuZ5iuVKbh
 VbYIi0XU=
X-Gm-Gg: AeBDievnh98HVqOlj1H0XKWaHJ53LZE9bZWG9LqCex2JpDxTWxbFRuXumbF63d99aUN
 g/YZa+A1hsoquvBeo+QOLCuRZM+MTczIlunlhp1FDtudtqah79tyPvgQ2CRPgnWYtOe+GIYmffD
 e3yOwuEGPBVl14wo9czG2rEmz7rUDUGLSoXomWwsg9B/4rM3yPWcTzSMwLY3SXvQ0CQmzTd2/4P
 TwAdxfvINe/fX0rqife/GmpV7ASu1+QIXZRDdE/PoQXfXlCBJEbPEHr6ZrmWgUgM0Hd7Pcp/O6I
 mTfuGpLPmlo90vzKnnAxFMOIMpHmqhjQ7YlZzOX8gh8bQRCmN2PM+npSuCGlsy8OXi/bwa1ZM7z
 jO+GKONXkEj9xLZsp17VLkVyMz9iDOWiB04M60Iou8j0O3RPM4ITcCgFwYgt+n0xwiRta28IYuI
 mz4Q3or5t7VVfQMF/rCbNHEbkm+Vdc9OOdEg==
X-Received: by 2002:a05:6000:2dc6:b0:43e:a81d:c475 with SMTP id
 ffacd0b85a97d-44bb2f28211mr25741916f8f.6.1778000470544; 
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03d4csm6270484f8f.22.2026.05.05.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E90A6016A;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 04/10] .agents/skills: add qemu-issue-helper skill
Date: Tue,  5 May 2026 18:00:59 +0100
Message-ID: <20260505170105.228162-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
 1 file changed, 47 insertions(+)
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
-- 
2.47.3


