Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3501C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldV-0007PN-Qc; Sun, 04 Aug 2024 20:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldU-0007Oi-OF
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldS-0002IG-2q
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so3841671b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817896; x=1723422696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uKtVQvZy8UEUupr32l0zo7waH0s0+xdjQSuITp5LLeQ=;
 b=aX/TSJunZzvO72W53YnNPYJwGcLy8rporJaZr8ImXdSyB8YXKmil4GHU3syW3HGO/H
 zP5r4Q6h2I61FMNrDTZaC4xVrnC1hdSbtiS34N201GE/1Klq+RzeDIOQq4jkDoWYsKCJ
 JgKzLP6lUx0LbYRG1yeN9YrNTM6luIx7iwU+lA7ux88ehq1AvX4S+P3ehTLRjmUao4aD
 CK6/LxxdNAehszi6njBVvL+pxgz96IdJQ6vaDXo5xEOnYUdSbfSk4cIi6y3t5i9nvM0n
 clkNsp+L2o3Ufid3jA2fXSLlhX1GxujLBCYLT2VrEWiInlbXA2CnlHfywN0LpD3/KUen
 Ktaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817896; x=1723422696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKtVQvZy8UEUupr32l0zo7waH0s0+xdjQSuITp5LLeQ=;
 b=i1RGB3BF0WLmkt6BEBiWAR3GgmCoDXakXfvY2ChNXCYJXQJfX+8ifieO9cSpvuTExh
 UiozEuWHILi857wWYozTG6+3QwPE9Ys9+S7mWEYg29Us6E1oE6f/7COQAOhESzQUVgbE
 YnnLkzALsGNoGkeYTNsN5+6W6g0Ti5oOfSSqaZ/gzXI3SIXWe1PLc7hqJZE4cGLY1qNh
 P4Gjw3JlQENca7WGQ3mJ1jIz9gzVm1xMmwVm7EedpzE0uyaMblGHCoWj/7H4Ka1x91yK
 dWyink58z0HglOAddEqlxgaqVzgYNyJ0XZPKaMNt+GQ+umK08GP7T2DdgzqCPzB5qHoq
 vOSg==
X-Gm-Message-State: AOJu0Yzt2El25vnjyTTVLlkltO3SudsZUAZ/RCgDFhrvE7OB5XlHjnvc
 pbTz1m9Vt2GV76yq8t9WxekZc4IQwp2fiU9cMeF2nvDZkf5XL90l9R4eIc9At2EzpdP3zZky6wz
 7nhLTyQ==
X-Google-Smtp-Source: AGHT+IHXbS9UsEIljHszg0eT1it1UgI3eKeAiRPCzRX0ogYVdTyOgymeGlZsunoHCxw3HzKvKLUPlA==
X-Received: by 2002:a05:6a21:460c:b0:1c2:a29b:efb4 with SMTP id
 adf61e73a8af0-1c69a6db8bcmr14638917637.24.1722817896181; 
 Sun, 04 Aug 2024 17:31:36 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] misc patch queue
Date: Mon,  5 Aug 2024 10:31:22 +1000
Message-ID: <20240805003130.1421051-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:

  Merge tag 'migration-20240802-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240805

for you to fetch changes up to 9996a35c6433c0e019a1c05791299db5e63a5db7:

  net/tap: Use qemu_close_all_open_fd() (2024-08-05 08:33:36 +1000)

----------------------------------------------------------------
linux-user/elfload: Fix pr_pid values in core files
util: Add qemu_close_all_open_fd
net/tap: Use qemu_close_all_open_fd

----------------------------------------------------------------
Clément Léger (5):
      qemu/osdep: Move close_all_open_fds() to oslib-posix
      qemu/osdep: Split qemu_close_all_open_fd() and add fallback
      net/tap: Factorize fd closing after forking
      qemu/osdep: Add excluded fd parameter to qemu_close_all_open_fd()
      net/tap: Use qemu_close_all_open_fd()

Ilya Leoshkevich (1):
      linux-user/elfload: Fix pr_pid values in core files

 include/qemu/osdep.h    |  11 +++++
 linux-user/elfload.c    |   8 ++--
 net/tap.c               |  34 +++++++------
 system/async-teardown.c |  37 +--------------
 util/oslib-posix.c      | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+), 55 deletions(-)

