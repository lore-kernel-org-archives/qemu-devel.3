Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1018ED5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8E-0002Az-In; Fri, 08 Nov 2024 10:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8D-0002Aq-HG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:41 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8C-0005DS-1D
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:41 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so2055077b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080558; x=1731685358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=biGDhBmGK55tF+cZ37cJs3bTmgP/oOfYxgwHavYr8PU=;
 b=LhLwkBqL1vSY16UFKJWVg1h5PyK6TmsRFFLJybhQ/axefMkzZsgmvZl5W7qV3Nwc4o
 /+LTzPzCGyFsQo+PpDhV/zTspTMruVBrZYTsmXyNkxsrzN+k+/EJWjYPje6cWpRwvRwm
 HlmLcvVgnXLDk6r7+lkf2PLZIl8MJll1lJ2Fs3rx7MhX/U89XNDZQsAw8PhhydAhNxVF
 qVJPv7fOcMStQHGsoLSlFaia6cWKmYTHVqYER3MNH8AhgT4+vUn/Xp0ladptEuK6JBKl
 Gy85uKSir1BKeVdQjnBiBbSZrnfIsB8IMBNigEDBrVilcE6uX0v+JNcmZwUbmDfcxckz
 wWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080558; x=1731685358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biGDhBmGK55tF+cZ37cJs3bTmgP/oOfYxgwHavYr8PU=;
 b=s5wZIzsx2tUvyI4kUeBGHYTIwX71Rcm/HMr3BxFdGzLEsjhHgOR7kU+TB+izKxgtY6
 VugOvfbiGB4aQxAZIY5shlnCI6ZPJ+/r5AefrnvZ/Sc/wPS7Acwu/qh4jYXkQliIBCcr
 g7gO30i6izcvXIiK/BJy76aVtOdRGc6ZYsagD77vUcm5V/3aPA5gOI0DuWMN3PsF+yX5
 T87VJKWj5u+wnQuLKK4LXtcoFuqOzyT9KRTZtP+vzvGjNrbgmfd3OzhMk1t8nqhYOJ+R
 gwz3lEgnr9+bL7Wyn9pdZ4h0ov9ydgZvp/RXD5N2mYAGZs/oHkUihCtguKgjsl/NGC5G
 4drw==
X-Gm-Message-State: AOJu0YytsNWXIss/dCzETfO876vVH6uSDnr4aw6KsSmdRHUW/aKffrIy
 i88wH8RQkaLiVzM/iWV7FjqFb3lf6C48Tgzqyy2+ZiFf72AyRaqIJgZ6uA==
X-Google-Smtp-Source: AGHT+IEeh1bu33Xy31A9tSkHLufzU6fX0YCasVaNF48obNly1YIRKYfImjjSPxTle/N7qorQLrCTiw==
X-Received: by 2002:a05:6a20:3943:b0:1db:eecb:f7a1 with SMTP id
 adf61e73a8af0-1dc229c96bcmr4130504637.17.1731080557836; 
 Fri, 08 Nov 2024 07:42:37 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 0/5] Add XHCI TR NOOP support, plus PCI, MSIX changes
Date: Sat,  9 Nov 2024 01:42:23 +1000
Message-ID: <20241108154229.263097-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

This RFC is wide-ranging for such a simple addition of XHCI TR NOOP
command, because adding qtests for it caught up some PCI/MSIX issues.

Firstly, the XHCI host shares a BAR between device registers and MSIX
space, which is not handled by qtest/pci. Keeping track of BAR mappings
in qtest and allowing MSIX to use an existing mapping seems to work.

For XHCI qtest, I added a MSIX check to ensure interrupts are working
correctly. As part of that I need to dequeue masked interrupts which
seems to require PBA writes to clear them, but I could be way off
base here. Adding that does cause e1000e qtest to break, because it
doesn't like clear pending via PBA.

The XHCI model change gets AIX's XHCI driver working, so that's another
data point beyond the simple qtest for it added here. Unfortunately it
is not so easy to independently test.

Any guidance or input would be welcome.

Thanks,
Nick

Nicholas Piggin (5):
  qtest/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix msix_enable sharing bar0
  pci/msix: Implement PBA writes
  qtest/xhci: Add controller and device setup and ring tests
  hw/usb: Support XHCI TR NOOP commands

 tests/qtest/libqos/ahci.h       |   1 +
 tests/qtest/libqos/pci.h        |   4 +
 tests/qtest/libqos/virtio-pci.h |   1 +
 tests/qtest/usb-hcd-xhci-test.h | 232 ++++++++++++++
 hw/pci/msix.c                   |  16 +
 hw/usb/hcd-xhci.c               |  28 +-
 tests/qtest/ahci-test.c         |   2 +
 tests/qtest/libqos/ahci.c       |   6 +
 tests/qtest/libqos/pci.c        |  75 ++++-
 tests/qtest/libqos/virtio-pci.c |   6 +-
 tests/qtest/usb-hcd-xhci-test.c | 540 +++++++++++++++++++++++++++++++-
 11 files changed, 893 insertions(+), 18 deletions(-)
 create mode 100644 tests/qtest/usb-hcd-xhci-test.h

-- 
2.45.2


