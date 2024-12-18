Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ECDE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNohj-0007ix-W9; Wed, 18 Dec 2024 02:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohi-0007io-1V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:46 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohg-0006gt-Ef
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:45 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-728d1a2f180so382018b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507762; x=1735112562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YSPh7rZDaNAjIE6JrEzzDBy1TNo5gaJ44X9vvb/IVU4=;
 b=gfG0/2zgwkMHWC+6k7RfiYoGgZChHru5dS7ifeY+J4HnVRwkPNr0H24Nr9UfUrwUEK
 nRWs8+0/RYxRksLEc8tn6gTKXlmO9Qwt6metxc985hVOi78FzBSdDqj85eelbB5ZFfIR
 v9V5uxcK0ncbBPAhm6YbgyZUwWUGrMnkgoB2EY4un5ERJvHJuWMmoLG8h3QsqmmAGcKy
 HJMJDVtrmF0Hh8nqsSzyX6RuafQGU64A6rNTlxT21ZUQqoAWNsT3rVe0tlgE6t0z/Nqo
 oHAPLUF2u4kaP474iD56bhFVux73wfslpeQzRSrsM0IyuWr61ED3E9SZBhC3gqSVWUlL
 w0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507762; x=1735112562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSPh7rZDaNAjIE6JrEzzDBy1TNo5gaJ44X9vvb/IVU4=;
 b=iHujeqdv8xCyb3zqkapNCBqVCr5c0MsNwwGeSCbgbTuW5OU89CXKGyW3BSmm5vqkrw
 9HaCnRx7bWCW/k/W3o68er/+DRMDjNTNjZsOjIEA1769Ad1x5U2ALnXoImxQkPZX3VLo
 6wCxRaFAsPWA4tXzg1/ic1OjAmOdtneJozFZt4Tqex37ZAb/0zqN8EPLqiEodXmsVaPX
 +Ey0slt+7m1tkz2MB2s0G5Y0IBjDNO4UOqi7cy9Ki0WzlBEzOWzK3r6uFLmTOD7i+tPY
 JIe5vwcysPUHPgQw2BRLuwFm9NbJk+2+8qEXTUNURu39jVBn1VzV8SX/z7Wnm3Uol5Lr
 O+Yw==
X-Gm-Message-State: AOJu0Yy6C9n69yfl9//l9V6Q73GB6jrgZBhML0e45fUnmaEb0djwlnjL
 bd3CKkkKn5YlLR5nVI3i8HPeljCeIlvQ2pdhRZi3d+fpz5fpclBdLNMOEw==
X-Gm-Gg: ASbGncuqn90JTuuOzNdjbb1NWDCR8b1uoMIAfl6B/e1Ymc1Rws9yhwXVpqrvitkp1TK
 JPQfTlA2GC940QUn7eNnawHuWmXeHMvSnKsKRWRbNIUeqpWGNon6cKBTz4J/wU0iiGIOXFCYj/O
 BU0SIqHvebQ4n9L76zigbG+e3IwsN5WxpzG/dc2iFQH8shBrLTqhgSCkKJrKwuM5F87VnKk3E4h
 CaLfnYY1ceLpNrKZHgSyywSM6AKrOpbi8P0NyTxyr7uZ6/OXWj8wWfxUYtSRjNrp+2FHbw9BF7V
 CdjGTSEBEg==
X-Google-Smtp-Source: AGHT+IGu1VS8dtmVR6SNUPkZsk59iD205R3fWpomgeGVWTtyOMWWFLybF4juw/uRMHkIC81Dxg/S8A==
X-Received: by 2002:aa7:88c2:0:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-72a8f86ee62mr2609839b3a.5.1734507762137; 
 Tue, 17 Dec 2024 23:42:42 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:42:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] qtest: pci and e1000e/igb msix fixes
Date: Wed, 18 Dec 2024 17:42:26 +1000
Message-ID: <20241218074232.1784427-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Hi,

This series is split out from a larger one that added some more
XHCI functionality and tests here. Just wanted to get more focus
on the PCI issues first.

https://lore.kernel.org/qemu-devel/20241212083502.1439033-1-npiggin@gmail.com/T/#t

It is quite reworked after feedback about the incorrect PBA write
implementation. This one solves the e1000e/igb multiple-intrrupt problem
by enabling the msix vector which delivers the interrupt and lowers the
PBA pending bit.

I'm still curious about PCI spec note that masked pending interrupt
must have PBA bit cleared if the interrupt condition in the function
clears, which no device seems to implement... but at least for now,
unmasking and delivering seems to be the reliable way to clear the
interrupt.

Thanks,
Nick


Nicholas Piggin (5):
  qtest/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Do not write to PBA memory
  qtest/e1000e|igb: Clear interrupt-cause bits after irq
  qtest/e1000e|igb: Fix msix to re-trigger interrupts

 tests/qtest/libqos/ahci.h       |   1 +
 tests/qtest/libqos/e1000e.h     |   8 +++
 tests/qtest/libqos/pci.h        |   3 +
 tests/qtest/libqos/virtio-pci.h |   1 +
 tests/qtest/ahci-test.c         |   2 +
 tests/qtest/e1000e-test.c       |  10 ++-
 tests/qtest/igb-test.c          |  10 ++-
 tests/qtest/libqos/ahci.c       |   6 ++
 tests/qtest/libqos/e1000e.c     | 113 +++++++++++++++++++++++++++++++-
 tests/qtest/libqos/pci.c        |  74 ++++++++++++++++++---
 tests/qtest/libqos/virtio-pci.c |   6 +-
 11 files changed, 217 insertions(+), 17 deletions(-)

-- 
2.45.2


