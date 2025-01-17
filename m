Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6E1C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq3k-0007U2-14; Fri, 17 Jan 2025 12:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3b-0007Sl-Ll; Fri, 17 Jan 2025 12:22:56 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3a-0005yz-9W; Fri, 17 Jan 2025 12:22:55 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2165cb60719so45194425ad.0; 
 Fri, 17 Jan 2025 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134572; x=1737739372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jXi5/TFdQZ9HxwXW6yVjV5BnfkV0AA1stIXb0277bI8=;
 b=QJ9E0n9M4CKRmJ0tQSeBc+REfcEdU54t3D4v57rWuT/6eZQvBVDnLtv5wmlasxYIxX
 mzgdymnV77MvmjYaBI7BwVVKVCGQ4Hvco4CRzKJwAvjCeVtU7OmZbb3VCFVBmgSfr0st
 ZJrm0lJJkNbwBup4AKUmbrnknKTSoZXBiD1P7M0dZEiMp9JFs1XJzAM3BY3NZO/H/I8z
 rwil6WCTutim8sGQnqobhItjYb6gN+8FHRngHk9oGGKPnH3Yigj6UYFcbiq9qLrObDbA
 HU8+irKZI+Armuj/Lfk7r/FJxSoQTR98DgJMAbQFD48jh+MuY+ZSvEm1fPlPXzjiDs2I
 lLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134572; x=1737739372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXi5/TFdQZ9HxwXW6yVjV5BnfkV0AA1stIXb0277bI8=;
 b=InC1x/1lCYuhsrGd5qR2CpOmloQ+D64cfHVq9cHhsOE4UZDiarCSqyrgqBtPhWIfkK
 gkrJiIZyznUjCOEZ5jj6oWJ0lGVWWyqBmcEurA+EPsqgbwTpAcaXVpR4oIhHVqzay0z8
 eaY3CoBJ0G0drmYGnIJKe3IqzzzgrZc9o8weKs77eWLJdOrvbYwueyU1nwDMJ0Hhcdjd
 5PA7iPZuIuize4kfxAG+F4aPscaoII8qTZDvKv36fjUVm2QSYCwYEYccWU2TvOmyjeHD
 mngpoSeonSSf6ciRc6z6av0RKgvg4bI/e7Vz5TL1wdW2HRuu+IfL36GJQS8nJ/fsRSeu
 eiGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbusDVe9yi0sIw7n2w9e9QwcGjT3+GWZQlWUFU8Lq+zYqTOJDJWCtml8/wMuNkGKwIin5RhWO0HTgrDA==@nongnu.org,
 AJvYcCVoYMznr6GasPcJZBFwfxr0RuyfoRo1UfMeO8ZFsunOakYhAN9Zg0LzE4pR8Icx4cQrEJ9CCpYlXe+c@nongnu.org
X-Gm-Message-State: AOJu0Yz9RruEClADbu83SnP7krz4WYZEYUzkHt4UD/yoxtC00A85SVct
 Cqqw49TxLRhUPY91hy1j0V0vi7O5T2vm+NJD+eJASAqXMTZIjfno
X-Gm-Gg: ASbGncsUoaPHU0Nv8EZUQMoolwhKO5M0eDBjF5fT6OodzdgwzAk1nEW97ToJWhzLzKP
 YGWYtxLTYO81bXymSMM0EMCmkMuxs2YjWEDrNbNdq8VsPhR18rJ1Pf6Jty3MnUZLHZask+jPfBe
 k6AH92BXOGvgZ3QQXBxp2wgg40wt8SWQfnngqmxKJiCQJA/aZqEoMVnYpyY/3cqeglljLhKyEZ9
 A53R8UvBDsUJSwpKtI1JuYd3X/6CIyN3KjjEstF5SMmAg3YDBIB9v05nbFOZaJ3O1wVnuQ64Hd6
 XA6M1kqF+ctjgoQ=
X-Google-Smtp-Source: AGHT+IGu/IIRqFgzBy/byHJPbSzHV98fxCD6us2piN0+DUKLVUz/7Zd/TS4B3Ji6lG0gGNCsq9wN9A==
X-Received: by 2002:a05:6a00:6c99:b0:725:f097:ed21 with SMTP id
 d2e1a72fcca58-72dafb55a4dmr4669197b3a.15.1737134572356; 
 Fri, 17 Jan 2025 09:22:52 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba511a4sm2235950b3a.140.2025.01.17.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:22:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] qtest/libqos/pci: pci and msix fixes
Date: Sat, 18 Jan 2025 03:22:39 +1000
Message-ID: <20250117172244.406206-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

Since v2:

The e1000e|igb series got decoupled from this one and split into
its own series.

Patch 4 was added.

Thanks,
Nick

Nicholas Piggin (4):
  qtest/libqos/pci: Do not write to PBA memory
  qtest/libqos/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Factor msix entry helpers into pci common code

 tests/qtest/libqos/ahci.h       |   1 +
 tests/qtest/libqos/pci.h        |   6 ++
 tests/qtest/libqos/virtio-pci.h |   1 +
 tests/qtest/ahci-test.c         |   2 +
 tests/qtest/libqos/ahci.c       |   6 ++
 tests/qtest/libqos/pci.c        | 127 +++++++++++++++++++++++++++++---
 tests/qtest/libqos/virtio-pci.c |  54 +++-----------
 7 files changed, 144 insertions(+), 53 deletions(-)

-- 
2.45.2


