Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E662CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRa-0005jh-6g; Fri, 15 May 2026 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRH-0005cj-6H
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRF-00026t-7C
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso82189895e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862659; x=1779467459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h764lcQMDIpcHVzPwaYwf8eJpDob14t5P2VYUwFWHas=;
 b=Q9qC5WLwiLJGvXplWE2z+RvYYy7HmIlTP37Wf9bUtf4hB0FYk8Kd3ihOq6i543Ix+0
 9UP4Hbjpns+kha4BgFI8lPfvNFacEqbeNPRW2NXNexMPILb2yROAv8qiSYBP5z0bBYXr
 /IkP7mRyqQysaCY4hLZobuphur/IMG8YlXiY/R3ySHZlyD72PNJ7laueasHvdRpi4twA
 V5PRP80Mk7StTqW56iLMTJ9zkt4KQLwdNCBwi6NG/jHmkQHUV86A3fq+E95VEkZC94Yv
 eMOLSl28JUcDliWDHQhnm6hBR8P6tGsebPK2isl6eLquB9jM7b9tIKhsVmfQhTJvse7G
 fYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862659; x=1779467459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h764lcQMDIpcHVzPwaYwf8eJpDob14t5P2VYUwFWHas=;
 b=MBpHiqehPM6Vb/6ub7n+uuEbj5DQF/lLW0ekBEBNVGR/dsOvL8Hmo3cxsuJWg96VfR
 o3H1uLWnLzODARf+VYuPCqTdOGPjKXkVN43S9/DOU+uJZRUS3vGV6JQPiuqi3x6xDniQ
 lK6nRyg6/kFPa/VgN6Ooj1mZGJL+cERMWcqKZR0+ByH5lzIEODnq1OlRg9OK4jYPHijr
 kzsaOmfTu+liE8G+P2ujDat94thUOsGh8FUhGwzBjx8QkMs9iDFv33rCDJqztVra+amd
 aw3aZmtOaGsFgsZDshjH/riStMkiVSeyREWvZ07VHA14NBZcuuIMMqAYy8TAcP47Gqkc
 RkfQ==
X-Gm-Message-State: AOJu0YxzEEM446ynHQcdVGdxf+9VaUCCc0hc34SnOBFo2uyGXLZEkjmy
 EfpgnS/+KN7ciQfHIOwPUr/4EXIag6LwBZDdX7D3c1BAsbKNdL5E49Qv3HgT3279Gm8=
X-Gm-Gg: Acq92OFek/v93vPxQcdVLNp/G0h+Zeaa2h/2FpUPik9Y4BJOSnzE24mOFFxknb9yL3J
 JfrutNhHoGVUEf5iPdqdRr4cW3OIm73DpoYBqcHojLpJcHTecHL/+ySCkaCJYGDYTncDmddegPi
 4+xjFDF3Nj9qyaCMlcDejHnkPqbk085w1njGJbyTaQjNWDM1bDOMKfkqD/hi01Ward14xpeSti+
 N97wr3nMnrveFnFQ4OLsFB3ZXUHKphfpT77H0tMJo18PHff9KGBQUz+M0GLm5q6un0EPOhKuinF
 KaRjYk0jNmz9yuoPJ0HQoQMVK4ugJjGDpA7u9nryMaqqExeZNbB+Bn7DHqqkwGOEP727dNEztJO
 JHxCe0cK6dfOpk2g5gNAs+ymV1cZWoSbzp/3Ox9pmNYVB2hFu139s0sk0DGMBzabBnUlJIxEljq
 ezhWCKoXU8i18yEWD+Oq3J4Vg=
X-Received: by 2002:a05:600c:a11c:b0:48f:a75e:c21 with SMTP id
 5b1f17b1804b1-48fe5fcdee9mr47131715e9.6.1778862658803; 
 Fri, 15 May 2026 09:30:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7da11sm16783545e9.32.2026.05.15.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FE5D5F810;
 Fri, 15 May 2026 17:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 00/11] AGENTS.md and associated skills
Date: Fri, 15 May 2026 17:30:43 +0100
Message-ID: <20260515163055.1792262-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Not withstanding the current contributor policy there are a number of
areas that AI agents could be helpful for. This series introduces an
AGENTS.md file which is the basic guide to the source tree and a
number of "skills". Skills are like scripts except far less clearly
defined. However I have found the issue triage skill quite useful for
off-loading the drudgery of going through stuff by hand. I've also
used the issue helper to automate the task of starting a debug session
by pulling in test cases from the tracker.

These originally where a set of skills for ECA (eca.dev) but I've
ported them across to the agent agnostic .agents directory. All the
references to ECA should now be removed. I have some personal tweaks
in my ~/.config/eca that make agent specific suggestions.

I'm not suggesting this is ready for up-streaming (or indeed should
ever go upstream) but I'm posting the collected set for comment and
I'd be interested how well these hold up across different agentic
systems.

v3
  - split AGENTS.md into two commits (so first can go upstream)
  - symlink GEMINI.md as it doesn't fallback to AGENTS.md
  - significantly de-scoped qemu-code-explorer
  - various other suggestions from last review

v2
  - re-organised all the skills, now prefixed qemu-FOO
  - update AGENTS.md as we add each skill
  - moved a bunch of stuff from agents to skills
  - added a new script/expand_macro.py
  - see bellow --- in each patch for details

The expand_macro is an attempt to make the code explorer more
efficient and stop it getting confused by our heavy macro use. I have
found the semcode MCP server
(https://github.com/facebookexperimental/semcode) does a pretty good
job of navigating code flows so I've de-scoped the code explorer just
to deal with the trickier aspects of navigating the QEMU code base.

The issue triage skill has so far proved to be the most useful and has
seen a fair bit of tweaking since the last version.

Alex.

Alex Bennée (11):
  AGENTS.md: introduce a very basic guide for AI agents
  AGENTS.md: expand with information on skills, layout and style
  scripts/expand-macro.py: helper script exploding macros
  .agents/skills: add qemu-code-explorer skill
  .agents/skills: add qemu-build skill
  .agents/skills: add qemu-testing skill
  .agents/skills: add qemu-code-reviewer skill
  .agents/skills: add qemu-mail-thread skill
  .agents/skills: add qemu-issue-helper skill
  .agents/skills: add qemu-issue-triage agent skill
  MAINTAINERS: add a section for AI agents

 MAINTAINERS                                   |   6 +
 .agents/skills/qemu-build/SKILL.md            |  50 ++++
 .agents/skills/qemu-code-explorer/SKILL.md    |  88 ++++++
 .../qemu-code-explorer/evals/evals.json       |  26 ++
 .agents/skills/qemu-code-reviewer/SKILL.md    |  93 ++++++
 .agents/skills/qemu-issue-helper/SKILL.md     |  47 +++
 .agents/skills/qemu-issue-triage/SKILL.md     | 112 +++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 +++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 ++
 .../scripts/update_labels.sh                  |  16 +
 .agents/skills/qemu-mail-thread/SKILL.md      |  40 +++
 .../scripts/qemu_mail_parser.py               |  98 +++++++
 .agents/skills/qemu-testing/SKILL.md          |  56 ++++
 .gitignore                                    |   2 +
 AGENTS.md                                     |  91 ++++++
 GEMINI.md                                     |   1 +
 scripts/expand-macro.py                       | 274 ++++++++++++++++++
 17 files changed, 1151 insertions(+)
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


