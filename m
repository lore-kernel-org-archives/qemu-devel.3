Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D6C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVG1G-0005KJ-QL; Fri, 27 Jun 2025 16:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1E-0005Je-SY
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:49:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1D-0005Gr-1X
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:49:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-74924255af4so462015b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751057393; x=1751662193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=55pIi7kf6Zis72VmkGKSzNIxzpZaUxSaUCgdQZi2+Sc=;
 b=HgGGMDGjvT1/V9GK9KJ9wxY+8uNlTxKs+VChnQAXu3Cr08cb697O1lVLc9oi1Q+duy
 Hp7hNUQH2SykXzIZO1u0SN93s8Bq1gNpKRcyDFPTY3PvjInLHJzrfNgW5tDLuaVj9qd9
 7ERnepiKeGMwbYxNbDyQBCRmE61GCZ4mjv4NZNZjolSCz8ytLsfv/y7B5k2pxlgLQaY8
 6LDH8RM5DzJHVjkuBi5nJVThb5G6UFYmFUiUwfwXoerAlSUiYlhm/h7qYL8YeVQgDCAc
 Ou25ucxx9mHQ5hJc6D+m72vk42ox08j8XQYmZiULVNuAVxYOZGfbuGCkYY3FSbYDQfvD
 2tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751057393; x=1751662193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55pIi7kf6Zis72VmkGKSzNIxzpZaUxSaUCgdQZi2+Sc=;
 b=ri1ooWjsSjUThQZ2f3jqnzKVMTk9jOsh8PMJ/9gSjsWzTBHXACKFyETqdXdHdKW8+Y
 pcoUJdJknDUxeVPqSyqH/h0NX6lueTmesAl6EvSNSSUCW1Q+YDCg0oHv+P8DPyvPVLHx
 mLBUGe0prlU0HVpHsBhChdAnBk/w7uWaXjMzBlWDH4kp3stCboutW7TpoP0ngr/v7fH1
 ma/U2Ro3vxazKhPv7cnYChWALjG8ZjPkt6SiudagbBH2CfD44BIY8515Gfm+zWEmskdA
 8ZufOOraozu2DG5FVmScC+vufIjm7lkFs/8na9j1O2L+HCadQ+Z1b0ccdeiFEa5pY6l0
 72Fg==
X-Gm-Message-State: AOJu0YyGGdcqQIx0H4N5NwpwW3oLA0NX4OFfSBI5OwJ+yRBI00Gu9fLn
 fYWNRytbVrzD19Drobq8fAFU91CjwiPR0QJh1G5Fu8lAv1MCROmNkIzAnf4U94XK
X-Gm-Gg: ASbGncu1NQXrG1Lanhi9yqOUiVDxOuIvPNxR1k1RZ+LlFD1AWGgWBqDWMEt3ceJjAdx
 WauVZgR3NOugxdi8xS2aEDZFFcHoqxRZeVUyFAwlkmTdQOz2LK/Rl/Grhi1zDeS2y+22cbCwYza
 GbMscFtJKdjmQ2/B5Gp0BUPUHYl5l16dq35MFpOD7jsRPvxbKYDAwfDjGZfu4vCHYzCl0cRfx7K
 TOrCSVvk4AvlmScr8UEThTbQLBeiFC6J+5FmNVE2cwZodnWCFeIVZ6mziQjtXM2leLpqC20UEJH
 i1kOkiuw3m37KpWvQscDuUag1wthG152XtIrDfPIQe2bhc591HsUCm7Lew==
X-Google-Smtp-Source: AGHT+IEQQrPxXOxR7o0tJixk+SjDUuiHtNynIthBiDnl2HROtL7iVc9FMtsqqbxa76oxQRfh7aUM0w==
X-Received: by 2002:a05:6a20:a11c:b0:218:59b:b2f4 with SMTP id
 adf61e73a8af0-220a17f7369mr6142906637.42.1751057393373; 
 Fri, 27 Jun 2025 13:49:53 -0700 (PDT)
Received: from darlin ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af557b3bcsm2977538b3a.101.2025.06.27.13.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 13:49:52 -0700 (PDT)
From: Yodel Eldar <yodel.eldar@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH 0/2] target/alpha: Add TCG plugin register tracking support
Date: Fri, 27 Jun 2025 15:47:57 -0500
Message-ID: <20250627204817.47595-1-yodel.eldar@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch adds TCG plugin register tracking support for the Alpha
target and resolves gitlab issue #2569:

  https://gitlab.com/qemu-project/qemu/-/issues/2569

As mentioned in the bug report by Alex Bennée, the register list is
built using the target's corresponding GDB XML feature file, but the
Alpha target does not have one. The second patch introduces the missing
feature file and the necessary plumbing for it.

While testing the second patch, I noticed the following error:

  qemu-alpha: GLib: g_strrstr: assertion 'haystack != NULL' failed

when running:

  ./qemu-alpha -d plugin \
  -plugin ./contrib/plugins/libexeclog.so,reg=*,rdisas=on \
  ./tests/tcg/alpha-linux-user/linux-test

and discovered an issue with execlog.c that the first patch resolves:
a missing null check after execlog searches a disassembled instruction
for a space separator between the mnemonic and the operands. Execlog
assumes that disassembled instructions will contain a space, but some
disassemblers use tabs (like Alpha).

Besides adding the null check, the execlog patch also adds tab to the
separator search by replacing the g_strstr_len call with a call to
strpbrk, so that the plugin would operate as intended for Alpha.

Two pointers in the immediate area of the changed code were converted to
const pointers in keeping with the QEMU Coding Style. Also, as a trivial
optimization, I took the liberty of adding a break statement to the
register search loop that immediately follows the separator search, so
that it breaks out of the loop as soon as a relevant register is found
in the instruction; please let me know if either of these minor changes
should be moved to a separate patch file.

Lastly, this is my first submission to QEMU, and I want to thank
every past, present, and future contributor to this project that has
kept my system secure as I tinker with weird machines in the ultimate
sandbox. QEMU is truly mind-blowing technology, and I have all of
you to thank for it: Thanks!

Yodel Eldar (2):
  contrib/plugins/execlog: Add tab to the separator search of insn_disas
  target/alpha: Add GDB XML feature file

 configs/targets/alpha-linux-user.mak |   1 +
 configs/targets/alpha-softmmu.mak    |   1 +
 contrib/plugins/execlog.c            |  15 +--
 gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
 target/alpha/cpu.c                   |   1 +
 5 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/alpha-core.xml

-- 
2.50.0


