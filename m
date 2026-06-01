Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56D9CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5M1-0007mk-7d; Mon, 01 Jun 2026 12:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5Lz-0007jT-Re
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5Ly-0002R1-3q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490afc47455so2029035e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780330740; x=1780935540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Rs6x//lJnmgkzT/fkzT/8gvwllZI5nOamQ9odIMnSc=;
 b=u8fF0xpSJTaHAgfo00Ck51x3DtmCoqchxfVdNUOs3nFXWliRR6q3yMW3uonIVcoj3N
 +r/HJitXP3H9vy7WmNNAuStyftX7Niby86mgvD3BUdkNQPv9AjSYfyrOAXJ/x3XInYWI
 iQv6fSigIcU5mt0DTN2l7nWfJVlg5r75uJaTpfiaqyhOi9KCH9cwocOjVWkU5fxIqaqK
 iAbAj27evan/WQ67YKgZKfcQvVF9eg92uuPHoaSrnL8hY6/lc0TlXLjr8KZpKH1wiK6y
 rUBmHjEy68GhUalED605JO+DC3nnnig+po8yA6SS/8yHF5yKmR5e3kAYrbZJr3G2Zsa+
 zM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330740; x=1780935540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Rs6x//lJnmgkzT/fkzT/8gvwllZI5nOamQ9odIMnSc=;
 b=hDUsxGnVF0KfESTVMxzGYdZGGWojAdQRkw86pGcinUTo1XKC9AQSOyWPCwDotXA3WD
 IVou0PtHpbelwxYn+ds+Ev9KrQJTkhOJK1L70oKxSBP4D4SlwYGpq23xvJCmV1pCD3tN
 KbAqYpvMpKMtXKfh8QixDm5ewjb0Esdsz5hFlpkb+y8Y9Tz0S68T37YIWzR3OHoSmMC7
 jWR4v9ooHIxyfXQIH/FH2I6ufERtPirgsaFphm2iIPMGSNFIOrwpNfv4NhfW6IY0sqKY
 lQezfgqvhPo5ivwryAsoc8V0EzGEH4ux8vHh6htHph0cfOsksxBcsnDROWIM++AezV9j
 2JjQ==
X-Gm-Message-State: AOJu0YxqDJeZ3aS8vZ3z3oNndLk2GoQ5ZtTEstYPZR0ERfLkvKDDbSi3
 t9vB0U95YXlUatgkgLqJO1zPaZC5Pt/TfkeuMos2u7StmY2W313FyeCgRAEjeEF42etnANmJxDZ
 oCaIY
X-Gm-Gg: Acq92OHy6CPpqRmdN75DC7mng2sfl3YzuwV+SMMzm5peYTxxldV7SJfVyO1yWAE93le
 8q/gqhF32HI1Hs6SDmU3sLgPXmZXM+p2+cXumZMu0d1eOcZoC+W17UA8dikHGcnEPVdwjkqyIH4
 C/w2j8Om2ToE1vpWOcKGITYoOGKe7OvvhkWEWDwyAzGRbUFZybPNbigO952f8UXg4heecA02mIa
 k42SQP2N9JrBK9QXFdJUYS27kost1GWoTd02P/IgWeqv5oxlNtC7DBLCk8/PWTS/ea3AqBcAhex
 PJd/NH5myPIv2vl8HKt2E5r7zSJrbkDdOjY6J5gagWa/E7D7G6210dW0Vfp5VvSPoMXyP3UPZX+
 YcUmRbJq7l7JtvTbHNu+o2EqJkIWiwPnZW79qyA2vUv3e1TcADLq0N9hFyR9RQEQj+U3zmJfGAe
 WTh7z7ZPK5f5NhFTPvhbdBBogJLqKup119sw==
X-Received: by 2002:a05:600d:8494:10b0:490:47e3:929a with SMTP id
 5b1f17b1804b1-490a29122ffmr159685605e9.6.1780330740150; 
 Mon, 01 Jun 2026 09:19:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e239f4sm3859355e9.7.2026.06.01.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:18:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6936D5F7C7;
 Mon, 01 Jun 2026 17:18:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/3] testing hotfixes (Makefile, gitlab, docker)
Date: Mon,  1 Jun 2026 17:18:55 +0100
Message-ID: <20260601161858.182286-1-alex.bennee@linaro.org>
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

The following changes since commit 5611a9268dae7b7ff99d478ed134052a9fc7e9f7:

  Merge tag 'pull-9p-20260601' of https://github.com/cschoenebeck/qemu into staging (2026-06-01 08:43:53 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-testing-hotfix-010626-1

for you to fetch changes up to 872d0ee33746aa02724051519ff03aa57278d7c3:

  configure: use debian-all-test-cross for mipsel tcg tests (2026-06-01 17:16:28 +0100)

----------------------------------------------------------------
testing updates:

  - revert test/Makefile.include move due to regression
  - work-around move with explicit targets for MacOS gitlab
  - use debian-all-test-cross for MIPS TCG tests

----------------------------------------------------------------
Alex Bennée (3):
      Revert "Makefile: include tests/Makefile.include before ninja calculation"
      gitlab: work around the inability to build targets for MacOS
      configure: use debian-all-test-cross for mipsel tcg tests

 configure              | 2 +-
 Makefile               | 4 ++--
 .gitlab-ci.d/macos.yml | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.3


