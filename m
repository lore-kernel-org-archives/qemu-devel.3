Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F047ECEFC3F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJR-0007Qh-03; Tue, 08 Oct 2024 14:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJM-0007QM-5G
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:56 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJJ-0002Ry-Tq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:55 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea03ecf191so2312313a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413503; x=1729018303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0r34YH/mokkCrpkMkmNPCTEaSZRmckSr1gIGHxh8kqw=;
 b=ZLRGR9sJeb5/oa5ouR/btkQMQLFQzPe8D7evMBr0i629Zdv4zBs0RlAsCX21g3w4P3
 1kzxoUypgCOSN9nYzeIs4HppQR899FfxIg2+qKDFCg7zcG6OI4yaSOLmEdUAm1EkM6US
 F9+UEsUC2X7jeahotHC7XRqZ+gD/+DxQWTGzcWNifCSIVE72shy7sSch5KFeG9uXOx3a
 5Qdv2DbOxpAAhC6HB0godxRww8vIwtZUr3poq18KtRGDu2JEqk04wMRm8Ng8eRI8RpEp
 iKwE/xENLsf+jnSqq/MMXvScq1rdUiojWGiVybqkW2VzaV4ho6vJoW8XeMsaV3UDb5rv
 wc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413503; x=1729018303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0r34YH/mokkCrpkMkmNPCTEaSZRmckSr1gIGHxh8kqw=;
 b=XbnxaESvkeVWjHNI/Mrnz+fp/xvr+sY2gdVhYT3zBMw2Dz4xh9KsJZ79/Bz/2HJf8+
 rRjNhf0KJwYPWAKZ50UsBL3USGcUSxi34QYKoWmJ6LNS6VmxHqmjNdTMqB0O+H2DLqVb
 jZ7GNmrE1V94Oo1FpYSOOLpX5kYZPKlUhxGcw/7jxFi7T1ITKGr1GtcwjA82PKdQGEwY
 b5mxyruMmu7Psj6llMPUJPRgUu2BrcfmKMirmPNLTcusugiJHSZOjciaPczoXi7jzCdP
 dv1ToJm1BTelo1xO4qpDqhBlLlkdW3bdoejWBVt8v/0DrHtWeE2pSlvV5JONAVrSv0Pc
 tLqQ==
X-Gm-Message-State: AOJu0Yx2UNz/VRY/cTpfQ370idQCc8jLuU3KXcRhd8DuXJ6jwjXqToZn
 6xSajbWpC+46dXltWvFlgEviBr1RuaUk6V03GU41vRdQ82Rz+k3SG1+JQAGeGuuMdjVQZjLDjdO
 k
X-Google-Smtp-Source: AGHT+IH4fHjPUgB4P0SyWWKrXbJKyp14R6CRnM7B8PypNIA3tArjgliR5CNLOmsg+ei52nI2n56LNw==
X-Received: by 2002:a05:6a21:3983:b0:1d6:236d:ea29 with SMTP id
 adf61e73a8af0-1d6df727d0fmr26394474637.0.1728413503328; 
 Tue, 08 Oct 2024 11:51:43 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/14] tcg + linux-user patch queue
Date: Tue,  8 Oct 2024 11:51:27 -0700
Message-ID: <20241008185141.20057-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

The following changes since commit 2af37e791906cfda42cb9604a16d218e56994bb1:

  Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu into staging (2024-10-07 12:55:02 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241008

for you to fetch changes up to 25f4e71722417db1f7d5140847849197053b23dd:

  accel/tcg: Make page_set_flags() documentation public (2024-10-08 06:40:31 -0700)

----------------------------------------------------------------
linux-user: Fix parse_elf_properties GNU0_MAGIC check
linux-user: Various improvements to strace
linux-user: Add openat2 support
linux-user/flatload: Take mmap_lock in load_flt_binary()
accel/tcg: Make page_set_flags() documentation public
tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
target/m68k: Always return a temporary from gen_lea_mode

----------------------------------------------------------------
Ilya Leoshkevich (1):
      linux-user: Trace wait4()'s and waitpid()'s wstatus

Michael Vogt (2):
      linux-user: add openat2 support in linux-user
      linux-user: add strace support for openat2

Philippe Mathieu-Daudé (7):
      linux-user/flatload: Take mmap_lock in load_flt_binary()
      linux-user: Correct print_sockaddr() format
      linux-user: Display sockaddr buffer as pointer
      linux-user: Factor print_buf_len() out
      linux-user: Add strace for sendto()
      linux-user: Add strace for recvfrom()
      accel/tcg: Make page_set_flags() documentation public

Richard Henderson (4):
      linux-user: Fix parse_elf_properties GNU0_MAGIC check
      tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
      tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
      target/m68k: Always return a temporary from gen_lea_mode

 include/exec/cpu-all.h    |  13 ++++
 linux-user/qemu.h         |   9 +++
 linux-user/syscall_defs.h |  18 +++++
 accel/tcg/user-exec.c     |   5 --
 linux-user/elfload.c      |  12 ++--
 linux-user/flatload.c     |   3 +
 linux-user/strace.c       | 163 ++++++++++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c      |  99 +++++++++++++++++++++++++++-
 target/m68k/translate.c   |  13 ++--
 linux-user/strace.list    |  13 ++--
 meson.build               |   1 +
 tcg/ppc/tcg-target.c.inc  |   8 +--
 12 files changed, 321 insertions(+), 36 deletions(-)

