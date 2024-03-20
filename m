Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz00-0003AM-2T; Wed, 20 Mar 2024 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmyzy-00039d-45
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmyzs-0008PS-W2
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33fd8a2a3e6so7782f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710952859; x=1711557659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vwn2620ZK1Q6mEg5afTjjuwmtMYoDWRtnI9jg5rTnG8=;
 b=w8K6LS+wqphp6gVXVfjsalHfpiJreRYUowttN4LPyflcqTTpUfYawdzUiTj37Lkmk8
 cY0UcePFhFMUDlSKD1ALLOzuok8XhbCuSGeQeZYn8L1hMPQXplY5qmxRaHcT4am9dgbK
 F7YK+PiQi7VKawbw8d3cPjsxhSDdBKfCVAMrx+MHaJXWL/SEKdFCQkSg+kI5XaQSwhiv
 z1rgmg07I4mz/Wi+cij0nH9blIwL1GC2fZ1DaufNK3YtPuoPWVkhjvSBJAnvxyHBCqvl
 u+/hjf8Z17XhtCVj2GYF800Ls98zfg75C4+ICXzxveAWip33HMtCl/oLQcmBQAkYnWIw
 jJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710952859; x=1711557659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vwn2620ZK1Q6mEg5afTjjuwmtMYoDWRtnI9jg5rTnG8=;
 b=coL/rN+kTC7IHLe99gvd5n/jDDbgARTsI0Vh/TZhyIOyLMA3aW0p6L24R0QrULNiQx
 QngCeyGvFQjX+cQZUJ/k9e+Wf/oQu/jXwSwppiOcf5kwHfPcoTOLrlnCBNnXoN3L6PpR
 1t3II3h/uGgGiF3bWSI/pH5zecBfRp86sejBFAtLxF554w5T7ZRLXM1SkZSxPGK3pj9U
 zG49vM4EGr6ihQmlBq9NLeYhVaKfYZw54SWVJCty2e1Tl/vA5B2okJkjmP34h8xv6ae1
 iQ/opQDkNyLSJnM5WikZrsRy65h3lrZlH1PHw5HeVQSwAmCf2aIHKQ//UEJ1sV85Xx2j
 yojw==
X-Gm-Message-State: AOJu0Yxkbgp8epb9G+ITGxcq2RZcUQffmJ5ofYRhWFNSbCVUZ7GYDtZw
 RDB/vfCIp8Iv8hehg3pv4j1ADAWqVaE92WWgtqdEmEoBAFYJkwJR83zcDySGDZLrckOHOeWzMQW
 K
X-Google-Smtp-Source: AGHT+IHN0zYwitZoJPLzWetSVbuapYx7LzhO2KDzSPEW9GBff8O9jvfBQl4oWl3pTtp//0SnXQmioQ==
X-Received: by 2002:a5d:408b:0:b0:33e:745a:88f5 with SMTP id
 o11-20020a5d408b000000b0033e745a88f5mr4078798wrp.57.1710952858589; 
 Wed, 20 Mar 2024 09:40:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adfe44b000000b0033e122a9a91sm15047508wrm.105.2024.03.20.09.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Mar 2024 09:40:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/2] target/monitor: Deprecate 'info tlb/mem' in favor
 of 'info mmu'
Date: Wed, 20 Mar 2024 17:40:53 +0100
Message-ID: <20240320164055.60319-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

'info tlb' and 'info mem' commands don't scale in heterogeneous
emulation. They will be reworked after the next release, hidden
behind the 'info mmu' command. It is not too late to deprecate
commands, so add the 'info mmu' command as wrapper to the other
ones, but already deprecate them.

Philippe Mathieu-Daudé (2):
  target/monitor: Introduce 'info mmu' command
  target/monitor: Deprecate 'info tlb' and 'info mem' commands

 docs/about/deprecated.rst    | 10 ++++++++
 include/monitor/hmp-target.h |  3 +++
 monitor/hmp-cmds-target.c    | 49 ++++++++++++++++++++++++++++++++++++
 target/i386/monitor.c        |  4 +--
 target/m68k/monitor.c        |  2 +-
 target/nios2/monitor.c       |  2 +-
 target/ppc/ppc-qmp-cmds.c    |  2 +-
 target/riscv/monitor.c       |  2 +-
 target/sh4/monitor.c         |  2 +-
 target/sparc/monitor.c       |  2 +-
 target/xtensa/monitor.c      |  2 +-
 hmp-commands-info.hx         | 22 +++++++++++++---
 12 files changed, 89 insertions(+), 13 deletions(-)

-- 
2.41.0


