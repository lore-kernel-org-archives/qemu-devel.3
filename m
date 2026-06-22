Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E7CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmJ-0004fR-OX; Mon, 22 Jun 2026 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmI-0004es-1T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmF-000675-VC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso29943385e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142894; x=1782747694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tr4nNCMfEdYg3OpwgAYSto+OH+ELbVaaMVgUsi3GVGo=;
 b=UbMXLxhCcIPpQrlGLbjId3oqNKGGJsTpgWHbdPOoLT0X18ZSyFA+oLjpxkMiqiHozp
 5L7hVKW39azZPb/yTdsfbVUMNsUmNNmrEG3QQ+fVP4A9rwVfD6q0X6yrr3bk7RczAw55
 dMW6FYLXsS1ZoWqoU5h5QGAmns4HXbbRtT5sCnt5jwPLm363ok4M5mQsWd/rosFtDfRY
 2zVRZ9/asOp5SpKahkoQ+3j9f+U2cwBWzKJ/4cwMrPXBdynwtvoFsvrX8HWE66bkoDwE
 CaPrXJj0EL1GiLZ9sDXpMgiA4iZz+cTnC6sB2v2shSWGwbtE0oEhLE9f4RIeQvUaY0/l
 KgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142894; x=1782747694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr4nNCMfEdYg3OpwgAYSto+OH+ELbVaaMVgUsi3GVGo=;
 b=nptwBuhfLlVi+CTIO1qJu5WJkc6bW1oOIjyNXkukP5mnQs1ywOtKNTBOMqzt7J237K
 KJ84+arker4c6kf4hfzb4uNOJi4OMnUh8/46yw//2MmX1SiUVOKkWqlW5WZpLxGwR1Fr
 Z5m0BigzCvcva/ikYLevwdyY1539jTvxMVgZwXpyPft5AtUtO12yH8nS303RL0hwclqj
 bmrPQ8Kgf69dd179MfwtXajg6zquStaqJhJHaReWRKpx+AHECZsaXSoHMHqPD0Ae3q8B
 xfBEU4oSXWOS955zy/NSSnoPl893aj4DSSAKa63TAmmZEOU2N7N953yfcIgvB8I27pmJ
 7nng==
X-Gm-Message-State: AOJu0YzqD2QX0+7w16p9762pSPZS1tntzzBUjbjfgmjC9L/E6Py05Gwi
 tRhnzp6d7qhluMUqn2fYNrYZks2y4nG5zm64NmNEP/Z6DeRQb/lji9/Hga52n6dHfaQ=
X-Gm-Gg: AfdE7ckjafOzwSW7mD4d3aVZ3UV64GAdPf9zI5R3GwB8xjz2XCZ0FYGy3uTSHfBbUIq
 jpWw2n4NdUN6RhZ3KmU+rPcIXRryzAR61AMdLP9rLBKm7cTIM8CfnRmaFQcQgec1/2FMga8r4l/
 rPy5wLhohEicdvLlwWYydGJAWMjpBSYydry66+F6Hm9PNKjMm9F5nhe4iIe9wZqi0FtAilZNIRv
 iKAkOy381pTGf1awpYkqY1yPh7bjyHeQmzBJnCkxGoG6KHM2Mu2kH3H/Ry4y9wFOdFCiiKy7HPi
 CB8BlBfw8w58wXNsKUUygyKpc4UqiGwVjRUA34K1yrWy4NU7It51rk2hpkPJ6qEV2+O9qFfaUqg
 73DTMDtbJK4V0sFuF1kYizUHhWRmpYhWhz749Vrbq51+BqcvYg0My0v1+76WeLBOzF8l6eBeDJ6
 OWcRrpjXOAa9O+
X-Received: by 2002:a05:600c:c3c1:20b0:492:4948:bfce with SMTP id
 5b1f17b1804b1-4924948c088mr118500085e9.16.1782142893886; 
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496cdsm204412955e9.10.2026.06.22.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 415475F811;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/7] testing and gitlab updates
Date: Mon, 22 Jun 2026 16:41:24 +0100
Message-ID: <20260622154132.3166748-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-testing-updates-220626-1

for you to fetch changes up to 2e020310e15d8452407c438271f3c06d4fa0c416:

  gitlab: update bug template for sec issues & tool assistance (2026-06-22 13:45:37 +0100)

----------------------------------------------------------------
testing and gitlab updates:

  - present a dev friendly cmd line in functional test logs
  - tell pylint to skip c-modules
  - widen the capture of functional tests logs in gitlab
  - remove workaround for MacOS build targets
  - update the gitlab bug template for security process

----------------------------------------------------------------
Alex Bennée (5):
      python/qemu: split arg between base and harness lists
      python/qemu: split console from harness args
      python/qemu: dump a developer friendly version of cmdline to logs
      tests/functional: tell pylint not to check c-modules
      gitlab: remove build target hacks

Daniel P. Berrangé (2):
      gitlab: ensure "check-XXX' jobs capture functional test logs
      gitlab: update bug template for sec issues & tool assistance

 .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
 .gitlab-ci.d/macos.yml              |  7 ++-----
 .gitlab/issue_templates/bug.md      | 11 +++++++++--
 python/qemu/machine/machine.py      | 29 ++++++++++++++++++++++++-----
 tests/functional/pylintrc           |  1 +
 5 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.47.3


