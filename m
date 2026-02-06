Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12098EE6B4F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voSMf-0005WU-QI; Fri, 06 Feb 2026 15:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voSMa-0005Ve-7M
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:23:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voSMY-000460-FV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:23:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a76f90872cso5651755ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770409412; x=1771014212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=65UttJqiJZIaC5s6JcVVuZPb/oP8blLy0nixSPNedPw=;
 b=xoUMNxJix6Dza6WJLRII2stTbgXfP5V8piVn33TH30bme8KbjW7Ulu4YjJiagQSO58
 oG8SuzzELvMgqDi8smJZG3F53nMQBh5KChJZeDb0J52nuXrkdkKg1TCrn/fP0ozrhJsA
 g+Xi99rz+A9KzIUmtIxVmKPy0VAW3BDGMBo5HGaTtqbjWGfgqI7NfrS62vYoO4QLcbAB
 +YWKAdzHHnvALc0poOX9YR8jLKimb8bysUhaxP1EgiG1oPTGi6hlcUhzS2OnIefP0A6m
 psaRKvDhfapzXLNBhGaicxnznPyiagJroOfljIw6y9P22M5E8ud+ac7KQpN27M7Gr2eQ
 MPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770409412; x=1771014212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65UttJqiJZIaC5s6JcVVuZPb/oP8blLy0nixSPNedPw=;
 b=Uu3xEtKQ+mCMXb2/V6M5tDau4OmUdsr2flNeC6T8ZOWlrAnaEuyfmkLJVykLJXpBcr
 OZIajnQbdBbxPcfnvZ3PNt55V50vi2eCk6HcBW249mlYHdYmaN/KleBBMzUW0upvSijd
 zatxPy6p+IYf53CVg4T1KIWRz1k7n0UEEKyJbEJXW5djQpjwp04kxJSQyO09Y7FzHgIr
 FgNruYXFRqF2SZcqHzJyg9Pt5OOHgyRE8gpqg8az/6TwtWY+EGc+M6WlTysIxUkkkBjB
 kM8hgpPMkOZjNsxEE5WjoZuptUP7WnaJtCMAcVfi7jotuhuhE1EATnvFPl/G3fNMaNbk
 rLkw==
X-Gm-Message-State: AOJu0YxwiaGqHKgTh3g5vDf0batB4VU32kyk7/VntGk98kwlwLPqVkto
 ceB0QBtJIHvBRN4meQzSbfRtn/BBqRvEcIrh0x/1TuP1d4an170qzfK89M1RlJPBDoWY2uKhBHm
 MMtNmvwBcJQ==
X-Gm-Gg: AZuq6aIoUoqqN07AzvrkNJ1ZaUGUZ6158WNeCQR9orkRKtR9uPaUhsWICoEtshM77Lz
 Yc9naX3SOC8HvtGjAlXIudQiXcJ7vAoWmGDSYUIJ1rG14BpwBoO2RJTqoSYtHKkLL/s5gS7kucW
 y0TH1NiWUSQ/7pAJgKfgfzifwDVZT+pVE6f0UuMyYG0FiyaEmW6rssvrqsAEbuilBGQTcIcf/o1
 qh7B+b5lLXPJgOzJOMj965h34qSsTMr3bPOZ0dtJDKdoLOO3OFPDEBP+EjR8UYZsNTbGz5slZzW
 r/UNqp4lQUf9FDtfy3Qb/9+f2trFPuwU9GVltBHGRUv3Nz94+MkSuQTH1UDTRAHDT/RSGB7/Fgd
 KBqaINT+dCQt0MNqHYLEYaxZL8ATvsD1Dhu1EhflR9In0+mz7EJZOjz9a/DSe7kYDU8zbHLVi4H
 PFU0Oln17aZ+Y2EsgODEx/02GkI7hgShijFY5BZ07Oe0XvhNMPjecrbYfS1x1/IddI5eYweXkwt
 Q==
X-Received: by 2002:a17:903:2408:b0:2a9:5c0b:e5dd with SMTP id
 d9443c01a7336-2a95c1b2e70mr17047735ad.31.1770409411252; 
 Fri, 06 Feb 2026 12:23:31 -0800 (PST)
Received: from stoup.. (bg30dj0bk2kt6p5db5yp.ip6.superloop.au.
 [2401:d002:dc0f:2100:f937:3877:4a89:45f1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951ca59f4sm29214275ad.43.2026.02.06.12.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 12:23:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/5] tcg + linux patch queue
Date: Sat,  7 Feb 2026 06:23:20 +1000
Message-ID: <20260206202320.5546-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260206

for you to fetch changes up to 973b0b0e3a5e4c4816cddcb367dfff5dd16be611:

  accel/tcg: Remove a redundant argument attrs in io_prepare() (2026-02-06 16:51:09 +1000)

----------------------------------------------------------------
linux-user/syscall.c: Prevent acquiring clone_lock while fork()
accel/tcg: Remove a redundant argument attrs in io_prepare()
accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp
Revert "tcg/user: do not set exit_request gratuitously"

----------------------------------------------------------------
Aleksandr Sergeev (1):
      linux-user/syscall.c: Prevent acquiring clone_lock while fork()

Jim Shu (1):
      accel/tcg: Remove a redundant argument attrs in io_prepare()

Paolo Bonzini (1):
      Revert "tcg/user: do not set exit_request gratuitously"

Richard Henderson (2):
      accel/tcg: Don't pass NULL to get_page_addr_code_hostp
      accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp

 accel/tcg/internal-common.h |  5 +++--
 linux-user/user-internals.h |  2 ++
 accel/tcg/cpu-exec.c        |  2 --
 accel/tcg/cputlb.c          | 26 +++++++++-----------------
 accel/tcg/user-exec.c       |  4 +---
 linux-user/main.c           |  2 ++
 linux-user/syscall.c        | 14 ++++++++++++++
 7 files changed, 31 insertions(+), 24 deletions(-)

