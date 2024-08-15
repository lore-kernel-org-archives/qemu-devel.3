Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900DEC531DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaXC-0008Em-Nx; Thu, 15 Aug 2024 09:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaXA-0008EH-Om
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:28:56 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaX4-0003tc-AX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:28:55 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7aa7703cf08so766844a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723728528; x=1724333328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oNUupxzUt6PQF7ZYggtXA4wLU4blipzCjFbD7TBcW1k=;
 b=SSQ0XaCd6ONZWUBWDlYwnK6FC7pETlafecLBMoWcpp3K7RQ+x8ZBIvV9mTi/sl9yTC
 CwFSDS23/YYaR9s0nZrkJhUCNwg2g7rynI7KD+GcQfsN/+N8sYn7WaPMDHAlr8PG3/Wj
 vpSJjMHwdyO2zeL+8+FZdlnByP6E8iJCTTG+ydAHdC7mu6rt22Al5A0FOG6e5t8XTAfy
 L6ls4mdsQq9e+/Tx+75gK0jyUCCg26xT0+0bhnCjhwdFthnXwT7lPo12PUf6lzaBNlOk
 rMUS7vc8rkwj56y164LX+nkAgloou0oV/9/Dnfe2gM+Q4TXbJr6nN948wo7VgF3Wa/1K
 dnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723728528; x=1724333328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNUupxzUt6PQF7ZYggtXA4wLU4blipzCjFbD7TBcW1k=;
 b=FZzCANoJRsw2E4P66Wb0qaclOSk6DuRW6NefljcDf30VfKPEbkTdydSit5G83M9541
 8IQOG9NjP3G7z4FQ3gbr+ElLaKQRJTQ2iFw/S0CWNgSGvPhWquEaYA2nN35a6lXAou/v
 nEkYN1D8xkCx7J0fYWc1Qjo7w0G2UVEb1ECHYwetl5OSqIlDmeSZeme3Z5hAk6x1BCtn
 wObITyfn3ag33Pafh7sjd9nJqYSBy++9xeIvyfnB65TuKgnd+tprXL4khEt/U8f/h/hp
 uqL6VPdFxGO91MBBS9wfT1mGJCUhe50gCAEoYrhYEQwD9rwhNybLpsQPCuCljuoWIFTm
 2xxA==
X-Gm-Message-State: AOJu0Yz6PThGlJiSb9CxEswMKqimWaTcCeEolO+kjly91P98Ed5Yq83j
 +C8Z6bt0cFV1pGTUBMZWd7OUN8h6VRRTddqZmoFntxT7mdXaVvhz7JqaMCdc
X-Google-Smtp-Source: AGHT+IHGNoY/V1sSXicfDJ38EUk6luPEQBiWjYlN0uBaSwDKYc99V0EPgXo/5I+nQ2VnB/2JZS73bw==
X-Received: by 2002:a17:902:f60d:b0:202:1fe:9fdd with SMTP id
 d9443c01a7336-20201fead09mr831275ad.24.1723728527667; 
 Thu, 15 Aug 2024 06:28:47 -0700 (PDT)
Received: from wheely.local0.net (219-90-179-190.ip.adam.com.au.
 [219.90.179.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038b455sm10014055ad.214.2024.08.15.06.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:28:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 0/2] async: rework async event API for replay
Date: Thu, 15 Aug 2024 23:28:35 +1000
Message-ID: <20240815132838.615330-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Continuing the conversation from the thread about record/replay
virtio fix. Here is a sketch of how we could improve the naming
convention so users of bh don't have to know about record/replay.

Thanks,
Nick

Nicholas Piggin (2):
  async: rework async event API for replay
  async: add debugging assertions for record/replay in bh APIs

 docs/devel/replay.rst              |  7 ++--
 include/block/aio.h                | 35 +++++++++++++++--
 include/sysemu/replay.h            |  2 +-
 block.c                            |  4 +-
 block/block-backend.c              | 24 +++++++-----
 block/io.c                         |  5 ++-
 block/iscsi.c                      |  5 ++-
 block/nfs.c                        | 10 +++--
 block/null.c                       |  4 +-
 block/nvme.c                       |  8 ++--
 hw/ide/core.c                      |  7 ++--
 hw/scsi/scsi-bus.c                 |  6 +--
 monitor/monitor.c                  |  2 +-
 monitor/qmp.c                      |  5 ++-
 qapi/qmp-dispatch.c                |  4 +-
 replay/replay-events.c             | 25 ++++++------
 stubs/replay-tools.c               |  2 +-
 util/aio-wait.c                    |  2 +-
 util/async.c                       | 63 ++++++++++++++++++++++++++++--
 util/main-loop.c                   |  2 +-
 util/thread-pool.c                 |  8 ++--
 scripts/block-coroutine-wrapper.py |  2 +-
 22 files changed, 164 insertions(+), 68 deletions(-)

-- 
2.45.2


