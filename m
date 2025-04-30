Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E3DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8OF-0001De-Hm; Wed, 30 Apr 2025 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8OB-0001DM-Mc
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:20 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8O9-00075U-3O
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:19 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6e8f06e13a4so13148356d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023173; x=1746627973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tzMDDiyUaKxnaWlTu03OGhT80F0QWlim+dN76ezTQdo=;
 b=XJ/BD7JNfbwqBJT4HBtWVGqQenOIhSkX9ldBMk3GCEEoVHNigWfdjHU2isMKfL8LSu
 jqed5pR3oGVurAA63KzRhdd1A013YvjW7p2vbMPvF/xKumRFZpBA4T4/ALWq0ijh8hq7
 rJOiLz/ucHBivAOUmMu1y3PsXwZ4G+w3SeHojgVPdYJcbmh0Qr+XA5Dj1RQ47WGW8pUG
 l8v/jpw/Ig3EwjW48JlFB9EXDLiMWaB/x33uJqX3FdlqeqJfyD1JqKD2k0C9vyp4wm9e
 2u8nBZxAwSHdKB9sLhDQ3zTIs0qEOHg151L9nnUXiW8tar1ZWv9fRry8wR5aEn6C9GUt
 dlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023173; x=1746627973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzMDDiyUaKxnaWlTu03OGhT80F0QWlim+dN76ezTQdo=;
 b=reF5MGxcobOU6Jid+kD/IDZmlQ/aZLzIXacGDrxVezvTY+usouNeuxVvbcM0e/VYzz
 +pe4bmxVworqoYj63wEHDfhYk+Zj3FWeqnQvWOeCN2J6M0mXtcWZl1JZ4DlUUGs0+VGC
 ghx2E/9IuE2cN8kdz7Ymk5kPAgqzjMe2fIERoaJ5B5bKduf3IzTXkopPqyki6svSWi52
 eNy27jLpqnPAlrq7LrjBy8vbfK+0rAv+3EclMFM879swZB437e9MF8362qCjgFjmgbdI
 2NCHyttQ/COOkcnIKHAMrTQbOpEZf+d0kvMDBVs6vkr95sDoaEHqLUFAVNQ9VuNi2BzX
 rsGA==
X-Gm-Message-State: AOJu0Yzl9KkohmP/1cLV5g5C5MF+l/GclRCHLQxSekBg6/IUSrjNOft0
 KcHmgY0GF7SyY8d5pPq0BfbTXVwXBjY2woCoIPODp0foZlrv1tmoWhClUDWhH29B4WffIPrdKrH
 A
X-Gm-Gg: ASbGncvoQi7CNIHdg+EkwPymSUMcRedWiZqyEzLDRzpa8mbWG5ZWMz5xoJmrdUGWhrq
 C04VtSM/ejqcpTGKRh068lvmKG/BKwKSgsnHUwHk0CpP0NkKQUDHMdXdh12hqZqPBHZYebyIMWf
 QVIu9FslQ51XG67U8xmHO21gvB+2VJL+mJqp7tCQT4xbfU2Qm7udS54cSvZy8SP+8pZFMF9xJ4p
 lrUTvJ4x4LLWrV5sD28XkWSoq658SVBPUU2eJcdQJCvg9mHODiNXcDfBpHBw2tNrFWdO/Rup7nu
 UHSvrB2fRxokq+QN8Ume3YwUOP8GggZVzJ7HkXp61btlSz+Qb/ZKxLnL0yG3xfaiGmjMPfkvMAt
 bWKaoHitKAT2cWUw=
X-Google-Smtp-Source: AGHT+IHEEWrR6SMkTZmhpZ+pCo7PagWeqbbThHowfP+kOZGN3LVPmpbpiJdrxnBnauBk20YPhDlgzw==
X-Received: by 2002:a05:6214:1301:b0:6e4:5971:135d with SMTP id
 6a1803df08f44-6f4fdd513demr48406956d6.18.1746023173605; 
 Wed, 30 Apr 2025 07:26:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe85f080sm8646036d6.117.2025.04.30.07.26.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Wed, 30 Apr 2025 16:26:04 +0200
Message-ID: <20250430142609.84134-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf33.google.com
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

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.6 and 2.7 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

Based-on: <20250429140825.25964-1-philmd@linaro.org>

Philippe Mathieu-Daudé (5):
  hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
  hw/intc/ioapic: Remove IOAPICCommonState::version field
  hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
    field
  hw/char/virtio-serial: Do not expose the 'emergency-write' property
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition

 hw/intc/ioapic_internal.h      |  3 +--
 include/hw/i386/intel_iommu.h  |  1 -
 include/hw/virtio/virtio-pci.h |  2 --
 hw/char/virtio-serial-bus.c    | 10 ++++++++--
 hw/display/virtio-vga.c        | 10 ----------
 hw/i386/intel_iommu.c          |  5 ++---
 hw/intc/ioapic.c               | 18 ++----------------
 hw/intc/ioapic_common.c        |  2 +-
 hw/virtio/virtio-pci.c         | 12 ++----------
 9 files changed, 16 insertions(+), 47 deletions(-)

-- 
2.47.1


