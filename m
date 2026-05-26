Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2B3CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpYx-0002eY-Sr; Tue, 26 May 2026 07:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-0002Xq-Up
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYh-0005uR-4t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so68333255e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793365; x=1780398165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X2hG0t4Ef/HLCmPcq12XUIvowQZ4uNmJZbN/7Tk0uUE=;
 b=vEEk6gWv0Ki8yS15wCQhiiTfNRf3OhsMSeeUZdY5sOTFIyNFvwHSAXuYe9G0yTWQ4g
 JJM8e3CiupnLWgXsjUMm2nOqsH2POgRMdQMhcN8cnuxr5Gga4lSCGNe37a61TTzGyW97
 QtJUD5FjczPLVFJ2q6UGOujtGV8zNQLEL2tdOa9In2HJEPwtNdJUOcJuk/ccjbcZd+iU
 JjkfBTR8HB5cAkKMyeIXANu5E2Ez1UpPueyiuW/ISnGMAkPkrVZXm7p7gJynEWmD8mxZ
 t4CL3hPeBg74k6zu8ZWBiEGBkdCe3n8zjpEFtGCg9YSCxbvMXRa8W9knLNB11+m4pgdI
 PRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793365; x=1780398165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2hG0t4Ef/HLCmPcq12XUIvowQZ4uNmJZbN/7Tk0uUE=;
 b=jMEhsaD5zbqzEOsTg5GurgI400Kf89Q8sAiPolzEhZy1H3GBwtlnX85G/QBjsYE5En
 lJW1Ao4sbUqFUnaBdC8XbBLNgQ7uQgUICDpELeKmiqefyBCE3bPt4/nYYBTjYlZbeRUc
 dO/YAfyBSH9MIFI8yvy7IAT9Qmc39cxWLlxt4MTvsWhD8+Jzzknauqx2fgfoHN4veMvn
 WsgttDZJeDiotwKbwN6MGfelq8COs31h//iytTVlv/DkVqnR/KkI37b0ejD9hBAoOPN9
 qfTGZIw92txXak7U/RTcwYI6u4ghzHydRQ966qSKqC44fyZ78+Ts/vMps6Y1evhKfN6I
 mDgw==
X-Gm-Message-State: AOJu0YzuK26roFUErQCVPqW4/Eo4bzPpFiUoxjRqOJ91tq83b6Cs3Uke
 kIyo9hdGMjO7kBxgEV1QIRQRvXTA9Ckwfh4SjY6VROjls8rWfli8ESis32pQtnwoYls=
X-Gm-Gg: Acq92OEb3NVy5Zx7x144O36emsF8eAvEVKec+2+L7uqIOBY1fGIEYNoDUOwSzsgyBLX
 GzXlgurtpYEa/MnjnhWdkFGAsioGKewWWKCY2h5mXj0O0fbw3kZYmRes08gJvb+DPDSV0I+Z/xH
 o7ysI0WPhkVSiS7kcrqnO3h7oyWgwc4VDE8+MQ6qH4RMMox+VTukx9/xTYHEVNED3t8s+9fzOO0
 MEH37Pefg0FQ63FGS/XYuQyhusSEXPwJbZcDcZgqH/9gU/1tgJ3DtXiu91rPJ9JwhSIhuntfBOK
 IAGAh3vH41syaPdZUYpbjuH+EW3GEa7qQQmUA+A/3WlLbW/26bfz1+RugcTWCJFALYrD0G7KaOR
 WvzgaR4r9Sv04zi+QlKdZo8m/5ym/jQa5KrIRN9GBSu7006lz1yVzi9CYcL7uz2/uELcKh4zATv
 LNKtFG8yftarLf9B2GkEKoAec=
X-Received: by 2002:a05:600c:1d19:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-4904245fe58mr256666295e9.8.1779793365189; 
 Tue, 26 May 2026 04:02:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424b5b80sm151635415e9.6.2026.05.26.04.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 870235F810;
 Tue, 26 May 2026 12:02:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 00/14] testing/next: various updates (MacOS, docker,
 gitlab) - pre-PR
Date: Tue, 26 May 2026 12:02:28 +0100
Message-ID: <20260526110243.470002-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These patches are mostly dealing with the loss of the CirrusCI MacOS
images by porting to gitlab. I've had to fight a bit with the build
system to deal with the way MacOS has signed and unsigned versions of
QEMU. In the end I couldn't get the dependencies to work for check-tcg
so I've just called the check-tcg test runners directly.

There is also a fix for getting watchpoints working so we can have the
basic TCG gdb tests.

I've also included Phil's docker series which is already reviewed.

The following still need review:

  accel/tcg: move jit thread manipulation into do_tb_phys_invalidate

I plan on rolling the PR tomorrow.

Alex.

Alex Bennée (9):
  Makefile: include tests/Makefile.include before ninja calculation
  tests/Makefile.include: fix typo in comment
  tests/Makefile.include: add binary dependency to run-tcg-tests-% rules
  accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
  ci: drop cirrus MacOS build
  gitlab: add initial MacOS 15 on gitlab runner
  gitlab: add MacOS 26 job on gitlab runner
  gitlab: update issue template for binary test cases
  MAINTAINERS: add a section for AI agents

Philippe Mathieu-Daudé (5):
  MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
  MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch
    section
  MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
  MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
  MAINTAINERS: Cover python.docker with Python library section

 MAINTAINERS                             | 12 ++++-
 Makefile                                |  4 +-
 accel/tcg/tb-maint.c                    | 43 ++++++++---------
 tests/lcitool/refresh                   | 12 ++++-
 .gitlab-ci.d/cirrus.yml                 | 14 ------
 .gitlab-ci.d/{cirrus => }/macos-14.vars |  0
 .gitlab-ci.d/macos.yml                  | 63 +++++++++++++++++++++++++
 .gitlab-ci.d/qemu-project.yml           |  1 +
 .gitlab/issue_templates/bug.md          |  4 ++
 tests/Makefile.include                  |  8 +++-
 10 files changed, 118 insertions(+), 43 deletions(-)
 rename .gitlab-ci.d/{cirrus => }/macos-14.vars (100%)
 create mode 100644 .gitlab-ci.d/macos.yml

-- 
2.47.3


