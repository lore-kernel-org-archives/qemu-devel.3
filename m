Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039A8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfC7-0005OX-Qa; Wed, 08 Jul 2026 23:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfC6-0005OI-BB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:12:58 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfC4-0005y8-V4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:12:58 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so414502a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783566775; x=1784171575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xrBYEFLDiXOxs2TITvTQ+HFC+bvOB+RzdxF2b60BeKY=;
 b=ImlsExhJptcl/huSlvcbonb3gmiCwlGmbWpZB1HS7b5eoS98OZJk3Gk9Z2YNpXE/iM
 WKybB4/GzforAPVdr9lqadCFnH0XzEBLwjDWupV/NeX23CmHX6y7cyq8O0d4IOXdE0dQ
 HnQk+k/C4wbt037TjcN+zaJinfGo1Y7xbejGNLAuU7VTtK7D2jiBpgaEFnz+u+i+khw4
 nhkgBKlLalg8/kI2YKYcG5hkxuD50ds81lKWciTbJovU7+KrhCAswtFwavi6PKwDSlIT
 JWU3q7ODf3SqhpOFV3N9NCWzlqX3h2+oKXuJbwoBR0lBTZVR2bx3ZZC8Wl3wQxQQ6g14
 vEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783566775; x=1784171575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xrBYEFLDiXOxs2TITvTQ+HFC+bvOB+RzdxF2b60BeKY=;
 b=SzholnefOE8a+bL5i44yOl4ul/9aSrSw2h21sE6HK1ZbcY2+MAiy0pIckniCEqpeMl
 VHesEwGmbwuVb5zAvBBD/1lmVyDsM18ClU0Rlpj0v57r8wtP4TnU87wvlUtzBgMpkHa+
 ZWXoucodiKqJXNSL5qj7C38iK9cz6eH2dXm/oH1cUjZEezBFAaN8BqEjx9zuslCraUT2
 A/cLVS6yjmOM1tVGqdB6ua38UHAZ2/G0j7sOvm02JPJh4kekdpgfS82ZVjp0EA5Tnhbx
 ezkMFciAalqfbGORZBAKjDIQe/XZ79oIQb0zZB8C9NOHBdDKtkebbkTf5r7Fy1MGHELj
 g6WA==
X-Gm-Message-State: AOJu0YwZiipLcuhq+5p6XWbL5jSy7MXtmEelLYxAFYo3xe3NtSrgAUls
 xpAhai3uXR8bL12+IwJqHsy/4vy5//Qa2YsEX+us6rsMR1J9u6gCHvHG9RLOsz7I
X-Gm-Gg: AfdE7cnM09jSXJNARlU/oXXB4/c5BidrlAoewuarffz3D0F3s4kqTc214zSy8THIkbw
 4441qzb1lJ7b0Zj9rK9QXHpVAJWqQaGVXRNIH2oKihxCQh61B+xPetoMXUpkl9jhSozRR2a450z
 zGmpQaFV5Fk6GRfTRdy4242JdoInIl7VOO4x0nV8o+CVCr1F3gOOQGt1yBG+JkrjS/We0wG0Y5k
 V2x/Cmx9pXDZ9UkgaYzy2sJCaY7/GHHifgW7yaWY44TuLk4WBEavNT03id8hVF79LhtEg/pn8k9
 TEfyGhpLPvCrWqgIkwpY8StEH0kjNEJc+8KPQLrBZO9Twxda7F3YxRHaqxUldSgIx+uLFUaswWJ
 iMVZ32Rs8iLPXKb6gbMLR/N8QOB9rlSjS05JYk5awzVjvVKIT4dnB4UrnLzREGiB3gvreGundub
 Z1cobBNgb5tnF0bhtH0NtjR0EydsBC
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3893f694da8mr5590222a91.4.1783566774870; 
 Wed, 08 Jul 2026 20:12:54 -0700 (PDT)
Received: from localhost.localdomain ([212.135.212.213])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516949asm392988a91.1.2026.07.08.20.12.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jul 2026 20:12:54 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH 0/2] *** Add k230 reset management unit support ***
Date: Thu,  9 Jul 2026 11:12:35 +0800
Message-ID: <20260709031237.21284-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jack Wang <163wangjack@gmail.com>

This series adds support for reset management unit found on k230 soc and 
successfully  wires it up to k230 machine;

The register design are implemented based on k230 trm and linux reset driver
(drivers/reset/reset-k230.c)

detailed implementations:
1. write-enable mask for control registers(strobe in the upper 16 bits)
2. hardware auto-clearing for reset and flush request bits
3. latching of Done bits and w1c logic
4. qtest coverage for register read/write behaviors and hardware state modelin

There are some checkpatch style warnings (line length, comment
formatting) that will be addressed in v2 based on reviewer feedback.

this is my first time for hardware-unit modeling so apologies for possible mistake.
I am apprecitated for any feedback

Jack Wang (2):
  hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
  hw/riscv/k230: wire up the RMU device

 docs/system/riscv/k230.rst  |   1 +
 hw/misc/Kconfig             |   3 +
 hw/misc/k230_rmu.c          | 280 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   6 +
 hw/riscv/Kconfig            |   1 +
 hw/riscv/k230.c             |  10 +-
 include/hw/misc/k230_rmu.h  |  76 ++++++++++
 include/hw/riscv/k230.h     |   2 +
 tests/qtest/k230-rmu-test.c | 125 ++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 11 files changed, 504 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/k230_rmu.c
 create mode 100644 include/hw/misc/k230_rmu.h
 create mode 100644 tests/qtest/k230-rmu-test.c

-- 
2.53.0


