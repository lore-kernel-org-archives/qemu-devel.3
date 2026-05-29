Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5DCCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpx8-00022Y-Hs; Fri, 29 May 2026 01:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwY-0001qX-FN
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwW-00023P-N4
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so95881105e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033174; x=1780637974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjzoBuXkDgH9fOvxFOeIvAK5Ym88vm2t5qc6lPvvoAE=;
 b=WSGVYrdteOFkY5ZCtQirBfraHIPT9iSCe3u6V6F9giYXBX6BbgZgx7fCMMlTdHlqsf
 vEu9wA1ycqzV22LqlU2axhB/WtKh9i2vTPgLCoL/RDh04nQVSsAM7CUZDtoidVryxQXx
 //235U9iYtw1+XW9Des+9g2gdLcSKzcgQPFQSNEfJXiJMz+IEsfyu/YzhumEgZa0/H4V
 y7zwHpDtBmV2tQ2IJObLA2mEaRHvQpseIxSSLQzQ/PGPY2HhJl+3VFzGCKMeM3WdrT9d
 bNkN8hRxWEmkknjbWmgTkDPx4akCQNF4FfGddLmzpUA1wfs+fouaOkT00QJtYpODsEXT
 BMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033174; x=1780637974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjzoBuXkDgH9fOvxFOeIvAK5Ym88vm2t5qc6lPvvoAE=;
 b=US9a43yO1ffSyZME/eZXeY2Let1HM+EwexhiJM7xVeuCUJGCA1kvl7Mug/hl3bpKVy
 U5f9CCXGy2FaGwFUGUA0WF8A7jWnOr87e+FlC19c7tJcai6nCw5nskKq78DQlVWW5Q5Y
 8mXBySnbb9QN3ipRgcyce57REXUUbfiHE+lHOkYmroKaUGcwUGWFNIqw8U5C2WrqMO07
 FOI8wX3QZKMAzliZJtpi6SPPVl9AQFuHPauzC0M1rUaLxDXVYRAyOlBOJxbDc5eFEHPd
 tlu60pz9DHrv4euVdJNEVIHK4Zf64h07lD8XXSAfarT1UkKP75GD/22LBIVuv4QXfnQ+
 VdvA==
X-Gm-Message-State: AOJu0Yx+SnSWC9+0iLehOkuGz8L2tJUom5zG40CbBmKVotg7T0p8B52f
 +9XOhkCmBCzlDfGWVmeevirqVWeBhIMq6rqZYcv+7CmIIBqrnBR9AifiCyleb/PpUWk=
X-Gm-Gg: Acq92OEyV4iVLJMVNb+6K29V0xSQBNwFrPal215syN04AVCKLkFvo+jj0cJYFvpUH2T
 fkgfsjKQO+EfXT5qo/b/rhorhQ6PR0tv7lHgCzYcdZNep3bfdGzzI/YIKvSmmQbqJgIlgBrBr+J
 LKpN9+kGfzfxdvfT/yYkuh+ZTf8kI9dJKqOvwzeWsKOktyT1EW7H39vhbMuv3skwfSVIqQiGWqE
 xxrzVGXVcgY4LJnuhqcQbL/+SbphOuMvge+ogTXcOfZdKx0Z0hyzA/qHpoG4uN0x4oE4tBtB5Nz
 JKRCnttKKPZ4BvGrPe88UCwyB2rFVPYg9U1VCge8VU9xL3KMf5cAGMccvJRwimTTa7OL3N2Iu6a
 WROAurYktOwa0CW1f4TYOQHc9ByWJDobCWwFJDPUXim5nkjU+rCHo0mEkQrm0pyVVcNzC8MHCyr
 IN+IUcozufLIa4bD0b3tUgfP2HsyvqhKkW0A==
X-Received: by 2002:a05:600c:3104:b0:490:9d1b:f07e with SMTP id
 5b1f17b1804b1-4909d1bf187mr16045835e9.13.1780033174019; 
 Thu, 28 May 2026 22:39:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68a925sm22290465e9.2.2026.05.28.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB0965F8C3;
 Fri, 29 May 2026 06:39:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/13] testing updates (gitlab, MacOS, MAINTAINERS)
Date: Fri, 29 May 2026 06:39:18 +0100
Message-ID: <20260529053931.283970-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 2db91528542672cf0db78b3f2cc0e22b36302b38:

  Merge tag 'pull-vfio-20260527' of https://github.com/legoater/qemu into staging (2026-05-27 14:45:58 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-testing-macos-and-misc-280526-1

for you to fetch changes up to 54b78a130be9abd5792c81726c5ebbeb5a68cad2:

  MAINTAINERS: Cover python.docker with Python library section (2026-05-28 21:33:46 +0100)

----------------------------------------------------------------
testing updates (gitlab, MacOS, MAINTAINERS)

  - move tests/Makefile.include earlier in order
  - add binary deps to .ninja-goals.run-tcg-tests-FOO
  - clean-up jit locking around do_tb_phys_invalidate
  - drop deprecated cirrus MacOS builds
  - add gitlab MacOS builds
  - update the gitlab issue template around binary test cases
  - fix-up MAINTAINERS for dockerfiles

----------------------------------------------------------------
Alex Bennée (8):
      Makefile: include tests/Makefile.include before ninja calculation
      tests/Makefile.include: fix typo in comment
      tests/Makefile.include: add binary dependency to run-tcg-tests-% rules
      accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
      ci: drop cirrus MacOS build
      gitlab: add initial MacOS 15 on gitlab runner
      gitlab: add MacOS 26 job on gitlab runner
      gitlab: update issue template for binary test cases

Philippe Mathieu-Daudé (5):
      MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
      MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
      MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
      MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
      MAINTAINERS: Cover python.docker with Python library section

 MAINTAINERS                             |  6 +++-
 Makefile                                |  4 +--
 accel/tcg/tb-maint.c                    | 43 ++++++++++------------
 tests/lcitool/refresh                   | 12 ++++++-
 .gitlab-ci.d/cirrus.yml                 | 14 --------
 .gitlab-ci.d/{cirrus => }/macos-14.vars |  0
 .gitlab-ci.d/macos.yml                  | 63 +++++++++++++++++++++++++++++++++
 .gitlab-ci.d/qemu-project.yml           |  1 +
 .gitlab/issue_templates/bug.md          |  4 +++
 tests/Makefile.include                  |  8 ++++-
 10 files changed, 112 insertions(+), 43 deletions(-)
 rename .gitlab-ci.d/{cirrus => }/macos-14.vars (100%)
 create mode 100644 .gitlab-ci.d/macos.yml

-- 
2.47.3


