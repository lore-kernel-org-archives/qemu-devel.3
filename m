Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB3D5E399
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 05:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA03n-0008Gq-SY; Sun, 10 Nov 2024 00:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03k-0008FY-Fd
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:24 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03i-0000O2-Fd
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:23 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso3175470b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 21:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731214819; x=1731819619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Odt7p7Qi+cCd1UClDS1AGFS89+RUtyEULLgza9jmH6U=;
 b=SyXxefS25U8/mWAnZnHVa9NkQIYWWvZ81LOU99AEz1UmaUOAGpl43W/758HRxlGGDo
 r61O1chEx7rPg6AWX/e3wh4Sku3y9SyrTM7xC/1JvE1nQpJZpztqIP34g4djHsoisIBj
 g/NMkpiDDO/oWYkouftFjE6dmyb66BEiGg7l+UpReuxU7N+CODv4T7dz4v193sZhHNv+
 O73jqLTkgyrX5fA9gnzyFQq+QJjU9q9aqZBFfPeAZRJdsTKC9rMp63aYw9jzGrqYkqSf
 3sbBMR7ycFmjcDAIE44Z8jzIyXBq5BQhhZ3JzmbIwavwnbwZqKlAT8+gDYjpNiH02Arx
 sOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731214819; x=1731819619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Odt7p7Qi+cCd1UClDS1AGFS89+RUtyEULLgza9jmH6U=;
 b=wPFgFOoiT7gi5O7PvRIjw/3GYQcW4MOSigqSCetauB1qJFD5ZfQhNV4BVo82RNcB2U
 4MlsrvBhm3pj0HyO6MtyRd0S3RCKlJ/jDLix+K+DeFbdtlckFj/UDZYLyAAW9bWb9fJY
 Rkq9WtV1o+hpwyeRJdAerbETfvVfJxgkEbcKosJAYyK0VwtDZQVHZJLqfR1Ltn+uqYzQ
 8KUrY2UpUvMsu9fPoa+wPN+tdR4KDGR+wDJCjsgaK4kVxLMldg3cLc+MNnUcOCMK8YHS
 kxquvwLK5rp9Em/ZeuB2Fvpbjxb6jGMI6hKLpSZX+mZk/l5BubPe49T4DCkqksGVWGQN
 bvmQ==
X-Gm-Message-State: AOJu0YzyY/sYWom4s/CvtLIW26zNJVJowfbNt4Ox/IP36Z+16DXlgmfm
 GW9YnF+pIBWn66A6/jYazqJkI/5FgthDf13TZZ7NGwziV1Of/fUt43No9g==
X-Google-Smtp-Source: AGHT+IFB0uOeTYXPh/DbBDE1EwVD4KiqMTTCoEdGmw9zJWXbxdNDk+7CXCtO8rz9lfyqg+D0MAxojg==
X-Received: by 2002:a05:6a21:6d99:b0:1db:f68c:5d8 with SMTP id
 adf61e73a8af0-1dc22bab95fmr11399020637.46.1731214818765; 
 Sat, 09 Nov 2024 21:00:18 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a18d8csm6709215b3a.149.2024.11.09.21.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 21:00:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] hw/usb: Add TI TUSB73X0 XHCI controller model
Date: Sun, 10 Nov 2024 15:00:06 +1000
Message-ID: <20241110050009.389367-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

This adds a new USB XHCI model. The biggest change is really
making some XHCI PCI config dynamic and the MSIX init has some
changes to support a separate BAR (hopefully now it has better
error handling.

Thanks,
Nick

Nicholas Piggin (2):
  hw/usb: Make PCI device more configurable
  hw/usb: Add TI TUSB73X0 XHCI controller model

 hw/usb/hcd-xhci-pci.h    |  9 ++++
 include/hw/pci/pci_ids.h |  1 +
 include/hw/usb/xhci.h    |  1 +
 hw/usb/hcd-xhci-nec.c    | 10 +++++
 hw/usb/hcd-xhci-pci.c    | 69 ++++++++++++++++++++++++-----
 hw/usb/hcd-xhci-ti.c     | 94 ++++++++++++++++++++++++++++++++++++++++
 hw/usb/Kconfig           |  5 +++
 hw/usb/meson.build       |  1 +
 8 files changed, 180 insertions(+), 10 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-ti.c

-- 
2.45.2


