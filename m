Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ACBCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEo-0002xx-2S; Fri, 29 May 2026 06:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEm-0002xh-Gg
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEj-00014A-Qg
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso861407f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049679; x=1780654479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cXWUnj7JhVm9duGkIifA16vq3wjJzT16qdkdkaEIjM=;
 b=grAG5DFTLRJJTioW4jvJvyDQKyrWCxD46kxx+g/o/SywUIuY0Jd7YGuHULlOKglJOq
 xlE45bbJNLUBsj4IGexl6qcyS5NuwIz3t9CBiNyvghFFejzCEhi7t1vuBGvqZbguusTr
 LzYVORaA9CRcYJZ3BJd2kMlylrOIDIw1EXWP4TUW7780aQBG7AoyvoU27f1rsLylPesM
 iBonucznA/xlS+aNnkWhWGxUCKlTEYEF9bPovB5l176rMJYw2WhGCbLv8xeTJcEMqmqY
 uaa4Cut82eopZOAS5hljlu72aV0ycRPrJXQjrWaT9lOmkhmBmR9xBxy+RzDwARBd34d2
 D8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049679; x=1780654479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cXWUnj7JhVm9duGkIifA16vq3wjJzT16qdkdkaEIjM=;
 b=g1yimYkyXJDHNeArR/K8AJZcXNdsGlt97/n+YiuwA/n1le2oViCU3LaXWhP+BsHwMw
 0lSZCFTvSRZvZgZ3lAB/QBG6bl0IA+Xex8orXwi0wkJFQunuob4ojIhT0nUnH0IQAbm+
 4ZaH6BEuFh72jFiTpGltSkXXZBBjxq+fVetKnDBEsSI7kMuzsfNuk1gPGxexmlst3o67
 HeH3v+23TR3rnHwgFoJkHWOc+uPJoayWUktVQIbuat3XGeFh4WFiEmtVYSkxiXQMbEZj
 KQzhJtsRj5TxZrxRBo3GMoZjh4hSsqRPJaxKg+sCYb8K126M6LVL0FBae5YH3jv+Tjzp
 yeiQ==
X-Gm-Message-State: AOJu0YxE8NdmjyThz5hXIDQVb5S1rjcAsGksKMgoBjxEYcY3lXqYauja
 sX9v5fJn515PjQPU5AU/2oZE/M1pANnI95Fbi2zxZTsNdCEP40H0rEhBcXCf7hyn5w4=
X-Gm-Gg: Acq92OFwEfRCFi9PxKAJKtJEdlIyrvg60JkY8shXTcUojsxmdj0xJx8XHIotCc3s2Ay
 3xd6vPO5P15klnvc0+syPV4/RSsleHViak7sKfgzR3we4IIryHm4K6q2kJIImNmcrzGRHQY9lRa
 JEmMRQGSZ8AX+gUyuPYKVCQBf3T41KyQbAQ2MvCPzhnzGpygIK1HI04wy2Xk0WlF4ni6arHy+aW
 g1Mw5uHj/pwgBQKg+9wn5nQpcqVuClYRrlcJmbZAJ5mxnyzfs7jEEhy/1shUXMcUirYxAIe5kGa
 pLcW6oQ6A6GaGnlAUUrtJ362QAzX/aDOl0+eC1dPRlhZlo7jXOIqwSlXnJhbWoSFOZ90IwhFWAg
 +mb8QTynNQCf5AYcbg/qKgA1kmyI5AF47Cc+8waXrZBa/plwMh6Z7au8547CGmT+pGgiCdgwIdC
 HFavHx1R9kZLt9ifwS+CxiNc/2cfpBgZk4xQ==
X-Received: by 2002:a05:6000:4604:b0:45e:f381:cd8c with SMTP id
 ffacd0b85a97d-45ef381cf66mr2577214f8f.30.1780049679380; 
 Fri, 29 May 2026 03:14:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35874b7sm2366247f8f.35.2026.05.29.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB5555FA53;
 Fri, 29 May 2026 11:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 00/12] AI policy update, AGENTS.md and associated skills
Date: Fri, 29 May 2026 11:14:25 +0100
Message-ID: <20260529101437.410181-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

As we are discussing updating QEMU's AI policy I took the opportunity
to grab Paolo's RFC from:

  Message-ID: <20260528073412.551117-1-pbonzini@redhat.com>
  Date: Thu, 28 May 2026 09:34:12 +0200
  Subject: [PATCH] docs/devel: relax policy on AI-generated contributions
  From: Paolo Bonzini <pbonzini@redhat.com>

And make some updates from the initial review. You can also read the
original (long) thread:

  Message-ID: <20260524083329-mutt-send-email-mst@kernel.org>
  Subject: on ai generated and code provenance
  From: "Michael S. Tsirkin" <mst@redhat.com>
  Date: Sun, 24 May 2026 08:42:39 -0400

for more background on the discussion.

The AGENTS.md is now updated to reflect the proposed policy changes
although it still refers to the current but likely soon to be changed
security policy.

The skills have had the "caveman" treatment:

  https://github.com/juliusbrussee/caveman

in an effort to reduce the overall token cost of the skills. This is
becoming more relevant as the true cost of inference is starting to be
felt. The recent update to Gemini Flash saw a big increase in
capabilities but I also saw a big jump in API costs to go with it.

I still have the original skills but so far the caveman versions seem
just as capable. I've made a few updates to the triage skill but
otherwise they are just terser versions of the last set of skills I
posted.

Previous discussions suggested that maybe the base AGENTS.md and the
triage skill could be up-streamed but if we are proposing the relax
the policy maybe including the rest of the skills is now useful?

Depending on the response we can split off patches for pull requests
as needed.

Changes since v3:

  - roll-up policy update patch with review feedback
  - caveman all the skills
  - teach triage about versions
  - various tags

Alex.

Alex Bennée (11):
  AGENTS.md: introduce a very basic guide for AI agents
  AGENTS.md: expand with information on skills, layout and style
  scripts/expand-macro.py: helper script exploding macros
  .agents/skills: add qemu-code-explorer skill (caveman)
  .agents/skills: add qemu-build skill (caveman)
  .agents/skills: add qemu-testing skill (caveman)
  .agents/skills: add qemu-code-reviewer skill (caveman)
  .agents/skills: add qemu-mail-thread skill (caveman)
  .agents/skills: add qemu-issue-helper skill (caveman)
  .agents/skills: add qemu-issue-triage agent skill (caveman)
  MAINTAINERS: add a section for AI agents

Paolo Bonzini (1):
  docs/devel: relax policy on AI-generated contributions

 MAINTAINERS                                   |   6 +
 docs/devel/code-provenance.rst                | 172 +++++++----
 .agents/skills/qemu-build/SKILL.md            |  49 ++++
 .agents/skills/qemu-code-explorer/SKILL.md    |  84 ++++++
 .../qemu-code-explorer/evals/evals.json       |  26 ++
 .agents/skills/qemu-code-reviewer/SKILL.md    |  98 +++++++
 .agents/skills/qemu-issue-helper/SKILL.md     |  47 +++
 .agents/skills/qemu-issue-triage/SKILL.md     | 100 +++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 +++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 ++
 .../scripts/update_labels.sh                  |  16 +
 .agents/skills/qemu-mail-thread/SKILL.md      |  37 +++
 .../scripts/qemu_mail_parser.py               |  98 +++++++
 .agents/skills/qemu-testing/SKILL.md          |  70 +++++
 .gitignore                                    |   2 +
 AGENTS.md                                     | 107 +++++++
 GEMINI.md                                     |   1 +
 scripts/expand-macro.py                       | 274 ++++++++++++++++++
 18 files changed, 1277 insertions(+), 61 deletions(-)
 create mode 100644 .agents/skills/qemu-build/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-helper/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/assets/labels.txt
 create mode 100644 .agents/skills/qemu-issue-triage/evals/evals.json
 create mode 100755 .agents/skills/qemu-issue-triage/scripts/update_labels.sh
 create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
 create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
 create mode 100644 .agents/skills/qemu-testing/SKILL.md
 create mode 100644 AGENTS.md
 create mode 120000 GEMINI.md
 create mode 100755 scripts/expand-macro.py

-- 
2.47.3


