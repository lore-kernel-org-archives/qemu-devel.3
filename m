Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B6C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2x9-0003Bs-Pt; Sat, 18 Jan 2025 02:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2x8-0003BV-Fo
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:06 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2x6-0007nA-SB
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:06 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so4983163a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184142; x=1737788942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1dbJCgecPcjxr7HKuTH2BPOOBvVre3kof08Lh4NTx9A=;
 b=EMe6UM3v9yAJOZ5KUpjhyMdJ53xEJsvfEd0YmzvOp1Xhh+ljhEomHhpjF8l6gN1E7X
 zui2nUeN9/oNwokFH21CIvTWry1Poh5ZHg6ETlAE5fSX+77NZqKehiRNEpXvJLsMQkQ1
 MJqogJZ2MbxcmgqMw5tQdFqG88AlDfZPbrd1fdP+DTHUYAgCV2YCV8epEi0cq2DR2wZ+
 sY7TBAe2K9ixyG+a3FTZGhVn6nnMMidk0NdrNHgV2rvJU+l94rXJ0Q20uJh+PisNx4tk
 yiYlBQR3cTsOaqC/KzaREGB5xrlTBa894WJf5TP01QoFXl1vTRHHXR0BIEOHb+nyI3uc
 5bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184142; x=1737788942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dbJCgecPcjxr7HKuTH2BPOOBvVre3kof08Lh4NTx9A=;
 b=Rpv0Lt+QPqzqJdIHFpLr4tHKqBrCaJMJC0Qb6OHAqBuukDknIZzILIejR41Iinaa0Y
 E7AjU51DnRIPhJpKUcHZqQ4oxPqaacyfMKaNzMPRCYtzPdlRNrJ9dboGchllCH0Pcu3k
 8IsDticVCtnGIzVvgmku4bXQteDBxnaG92+LcmCNYUUqEGg0Vvyrz93aFZatEyanAhO0
 GQh4SVaYOc6d8R+1kDNgPbLM25Z8ANQW0LszcXMnClH5aloOCqdEyc7Eme4rKpPg5oEx
 Jo+uh0J8c+MVNCkjHRXBN2APDcYnsMZaFLkW77gsMj9IGH83hXePfeHt+eIx3FE0mDsc
 D7oA==
X-Gm-Message-State: AOJu0YzcX1QiZB9QTFDPr1F7Ty5WwF+xQG0p89jmPFRZ6y4kElPtj+l1
 dwl47iSXFwZf3wbYvnGTTTb5rGSzQJC3HzeoNfBauBVGv24VPZtPCkRliQ==
X-Gm-Gg: ASbGncsxpXKq7YdXf20nB1o0z43/laEGZsTVj9uKhbjgL2NQEoZ8HRR4Ii9chCMdmcf
 w59gMF2enbeph2q0ZN9OZOYAUbNNM3JhcQ7d6Al5TGxM4V3NjxYePBI0A68Rl8rYbhq7i03czjY
 jyuNNxEZ+89JHwdiEgBk0KPVUEK312aO5YQa2K5B0gsUk/VJqT2dyNncslM6ZqliCg2jCfLK2f6
 h93xGDzhdQjfjwB3sWxCb6b8CScJMkPLPF4JBpBvlmrkuBhs9HohO4Zveyax6//j7cRxaewxwsU
 ACjnY26iyMD3iTtRdBCc+Eoyyl12
X-Google-Smtp-Source: AGHT+IEZFF/sVu5ikQOWNQQUScL3TXuP5Je0f/qiGD9/JQb5+TWVu4QDwj4mzrR6mfA1UrO/5F/nIg==
X-Received: by 2002:a05:6a00:a883:b0:725:ab14:6249 with SMTP id
 d2e1a72fcca58-72daf9beb73mr8927419b3a.2.1737184142030; 
 Fri, 17 Jan 2025 23:09:02 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 0/8] usb/xhci: TR NOOP, TI HCD device, more qtests
Date: Sat, 18 Jan 2025 17:08:45 +1000
Message-ID: <20250118070853.653778-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

Since last posting, I accounted for feedback from Phil and
others.

- Improved the names of the XHCI register constants
  when moving them to the header file.
- Leaving the symbolic cases for unimplemented registers
  in the handlers.
- Fixed a bug introduced in a register field calculation
  when moving code.
- Moved more constants and added more missing ones to the
  header file.
- Added qtests for the qemu-xhci device.

The qtests for the TI device added in patch 8 still have a
small dependency on libqos pci code bug fix which I submitted
separately, so that may crash if you try to test it.

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
 hw/usb/hcd-xhci-pci.c           |  87 ++++-
 hw/usb/hcd-xhci-ti.c            |  88 +++++
 hw/usb/hcd-xhci.c               | 527 ++++++++++------------------
 tests/qtest/usb-hcd-xhci-test.c | 600 +++++++++++++++++++++++++++++++-
 hw/usb/Kconfig                  |   5 +
 hw/usb/meson.build              |   1 +
 10 files changed, 1196 insertions(+), 360 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-ti.c

-- 
2.45.2


