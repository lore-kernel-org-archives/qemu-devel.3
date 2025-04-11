Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FCCC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39I4-00025n-DH; Fri, 11 Apr 2025 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39I2-00022w-NA
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Hz-0003po-6A
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73972a54919so1576398b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358341; x=1744963141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JufHZDRSKOnRruU/ysLGMb5UixYSQUjvK3Yxv/e4n7Y=;
 b=dB1gJpUeiIceMVGmus0fSVjdUUPJA6impGxiuaJQLYize8AyC12yABFTHJ67JmmcH8
 MqUgIt9VTK7pmaFqz3n1YthJsdjPEYeFC6U/nh9ZgPNiVDTxmKQIQR+J8pLT8vIph8gE
 exX8dKyCW6q51DhDSfsD9MNVLbeS8tHBNRAgi0VQeorCBay7KB1vWyCqwoDFPuMk8+vj
 u//P9fHEqNVSrc3H/wAzPQiR44qylnsblnlV9K16jomZYqthsFoUfb9mkuIYKysZTjEw
 Z8fDyyaiQBEnDtoSpvzJBeC0cIBvKi7/ZBblULM3dSIyGK0AonTNsSFzihKN+qMxzrri
 2hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358341; x=1744963141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JufHZDRSKOnRruU/ysLGMb5UixYSQUjvK3Yxv/e4n7Y=;
 b=Pxex/WtMNEyuCJMh0MLLSICWR1/k/HTq6pod5BhCUNr8sLzAOC/H9eRAOMkA4i+mw1
 nRsE0F4WfxeZSPGJJH+j0lpVvy2NyozqW89fA+XxnvPMZPSKJWqrYd65GRVWIz1y+O7w
 QA4WkbpD6vkZPKYQuIRwRTVd/QBo27BjpK0khcnBmGizxsq3+RPe5fs/2yc80cyT8Ai0
 Sc6588eX8dd6k09LKOy1XCKnrFJfnQAU53+loYAjKrrg8Z2hbxzc8QrHEHkJl6GkUn/V
 Xypj2A46C8HvBT60Szdw+RjQAM1EEPVlThCeJEtw3ACQ6uce8K12GiHM7eQEU2XN3lDo
 CD8A==
X-Gm-Message-State: AOJu0YyTm40LdzTdBP67O1BrP40sj9uYTDfcigVJ4bY8dWc9PlxzFeWx
 ozNZrfYp1PqHszDLVPqBi/3WeXEAxq1RaGZj8zeF0VoSzSl+YhnkaHxKlA==
X-Gm-Gg: ASbGncvCO/gfmR5UdAKJ2QIsETDrEKuJpfbVuwI8aYmaK9/IMYTOnPRP+uxIo0NDZHO
 GrDZtHxgCoWStltJNVejVIvyXo2rPJqKtJFsLigPDzG0Z04MZld4wZLPlQ5RFIHzAIsvi0+gcO3
 IOmY2tP5daYeDu7sq9K55A+hHBJizNMEpNYh8KCzUyuz3rHMhoAoXndXHAtufg/DrxOlI1SxURG
 Pu8qTUJvgtb16B9FcQ9W014f2d7SDY67/OlGqRuUxYxzh6qyaeOkJpahX3jRKXN45pqSYZKKCVC
 BG+Gq2ZWWBcWBBmZg4jP9iX/5gDsr3/dTcAT1QUjDs9c
X-Google-Smtp-Source: AGHT+IH1pyLrTQRMFe3dz3SGrSb/VOxEBJz2qZtDOP9fIBzH3jG5yDKWl2Xbmr1uEzGPeOskvEPpzA==
X-Received: by 2002:a05:6a00:390a:b0:736:fff2:9ac with SMTP id
 d2e1a72fcca58-73bd12a82dbmr2599787b3a.23.1744358339951; 
 Fri, 11 Apr 2025 00:58:59 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:58:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/8] usb/xhci: TR NOOP, TI HCD device, more qtests
Date: Fri, 11 Apr 2025 17:58:42 +1000
Message-ID: <20250411075851.206995-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
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

This series adds better support qtests support for the xhci controller,
adds support for the "TR NOOP" command used by AIX, and adds a new USB
controller model from TI that PowerVM and AIX use.

This series depends on some of the qtests changes from this one:

https://lore.kernel.org/qemu-devel/20250411044130.201724-1-npiggin@gmail.com/T/#t

Since v2:
https://lore.kernel.org/qemu-devel/20250118070853.653778-1-npiggin@gmail.com/

- Rebased to upstream. Hopefully this is ready to go for 10.1.

Thanks,
Nick

Nicholas Piggin (8):
  hw/usb/xhci: Move HCD constants to a header and add register constants
  hw/usb/xhci: Rename and move HCD register region constants to header
  tests/qtest/xhci: Add controller and device setup and ring tests
  hw/usb/xhci: Support TR NOOP commands
  tests/qtest/xhci: add a test for TR NOOP commands
  tests/qtest/xhci: test the qemu-xhci device
  hw/usb/hcd-xhci-pci: Make PCI device more configurable
  hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller model

 hw/usb/hcd-xhci-pci.h           |   9 +
 hw/usb/hcd-xhci.h               | 237 +++++++++++++
 include/hw/pci/pci_ids.h        |   1 +
 include/hw/usb/xhci.h           |   1 +
 hw/usb/hcd-xhci-pci.c           | 118 +++++--
 hw/usb/hcd-xhci-ti.c            |  88 +++++
 hw/usb/hcd-xhci.c               | 527 ++++++++++------------------
 tests/qtest/usb-hcd-xhci-test.c | 600 +++++++++++++++++++++++++++++++-
 hw/usb/Kconfig                  |   5 +
 hw/usb/meson.build              |   1 +
 10 files changed, 1214 insertions(+), 373 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-ti.c

-- 
2.47.1


