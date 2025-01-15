Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F352C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4tq-0004Gp-St; Wed, 15 Jan 2025 10:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4to-0004GG-Lz; Wed, 15 Jan 2025 10:01:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tn-0002uu-47; Wed, 15 Jan 2025 10:01:40 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21644aca3a0so152231395ad.3; 
 Wed, 15 Jan 2025 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736953297; x=1737558097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhQYxkte1TR03Kv00xe+YPvtM5yD9Xcv9xhHtnyiN9Q=;
 b=TxlI5p2QMoXCS8KWIjGtOMVeMEZe+WfSwcdkNrDICAVUnjNL4HcPcs3cBngVjZBDcP
 71WVvZw9rd9Nolt7M66Z8Rf+QCMW5qY89LymaqTqF3GVzUrOQGucEO+vQL5tZsQNuqBb
 xvdeufb28QzBql6Irw2TL+ASPCyG5IC69Q4myQPwg53t83MfZutJ8cH2plk8MjQFq8uj
 Mhuct1EQSskb+M78aNg9t8jyW0N/boA3y965DJnTUoywzZrO9+8zBlWF0BmXMSTehNhp
 re4ktZPTnN3GtAjPNajmRfsFfiAGI1FRYGc7/6/8e4n6UXZj16W+5Nx31+T6SH5mRGKK
 rMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953297; x=1737558097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhQYxkte1TR03Kv00xe+YPvtM5yD9Xcv9xhHtnyiN9Q=;
 b=Ibe2AGcmWv/0MHSx4VPA0BbVYhaZVMLHBnOKj15RinCEbaReVtNr6b/Rw5dMFkS/5X
 P5gQLsfEFtkQ6+Ta52nWM4qywCKXAGCgCWwWSF+AtyTW0JunhpVZR0cPB8bBFr1cg3ml
 DELKoXuVttvpQJneo1siDOv1uDZAn20CLKU4JNVaTp1xSpRG4Jn6R819PU8NgnPJLkgY
 TV2EVNxSfHRx8kCflTa5aVMIXEZuPvjdAKcBkh/gwiHCff7le+z356hdqn/8aOr/qpm+
 VSjPJLeu1GaWTSWzS6Plzr/Ax6meCsI7Pw1ESila8dtCCg10vo9vuLKdFJAgm9f813Lv
 2lCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsKlqgR0IChyDkn5p5ILdtwckgHcaCktatcAsQh+NgDfMZdNe+z5t5RHwOS5BCulwDhJreFse4NkJT@nongnu.org
X-Gm-Message-State: AOJu0Yxj+JP9f8NmpdOKqRBkpRuwGEN6fMvGpsyv25VcxvYKUgUEZkGH
 8CsUInVmF66TCCYeEnLacB5Ss83GMtWC4q9zqZNtpuYseCyom/d3FhFHoA==
X-Gm-Gg: ASbGnct8LzhNd1RbvzanvU05P29iLJINF/kOIRQFSDVcu56pbbnwFTRSOsbqIZxmwCm
 U4sT2QqbDiYVE0BvtsGAfWa5TfFXZGf6ZTo/WCch4gCQT7lgzFk1E1dUIYlfv4e8Ioosb4XeDHi
 rliFeg0/TS8L+kTJCu4oWX5ZRuLy9bNRvS6PTJojiR+jw5DbkbGRn85U2ffJzGSQQB7Y1tTDuJl
 DGQbQff1bMU2kiU13ohIYXcReg9WseTZfHQIxnZJ7zYAiCVxf0X0q60dQRAIg==
X-Google-Smtp-Source: AGHT+IGinQGv5Bp2toKtZBhGVwp2SkkBmyPIea5EtoB8LFvficmge50GnB6ywsZyacHdJN/pjDuc+g==
X-Received: by 2002:a05:6a00:9a0:b0:725:cfd0:dffa with SMTP id
 d2e1a72fcca58-72d21f453e4mr40122714b3a.5.1736953297019; 
 Wed, 15 Jan 2025 07:01:37 -0800 (PST)
Received: from wheely.local0.net ([118.210.104.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658a7esm9519592b3a.106.2025.01.15.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:01:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
Subject: [PATCH v2 3/5] qtest/libqos/pci: Do not write to PBA memory
Date: Thu, 16 Jan 2025 01:01:09 +1000
Message-ID: <20250115150112.346497-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115150112.346497-1-npiggin@gmail.com>
References: <20250115150112.346497-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The PCI Local Bus Specification says the result of writes to MSI-X
PBA memory is undefined. QEMU implements them as no-ops, so remove
the pointless write from qpci_msix_pending().

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 023c1617680..a187349d30a 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -361,8 +361,6 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
     return (pba_entry & (1 << bit_n)) != 0;
 }
 
-- 
2.45.2


