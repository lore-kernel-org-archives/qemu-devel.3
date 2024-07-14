Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA90AC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 07:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sStyd-0004cC-HI; Sun, 14 Jul 2024 03:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyc-0004bG-EP
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:48:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStya-0007dp-CI
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:48:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fb72eb3143so23147535ad.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720943335; x=1721548135;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5FUtXIcbYuqhhbKSIbFGBgSs5sSyYULIHHQFKwoLKI=;
 b=GIWcjZf/irWhsHH4unp/UAa3p/4YeY24DXC8nRLg8EtMZQDXlDCsKxFYYukygByI8F
 8XZP0nw9gkrrLvKFerOM4YXbMV2FnyKGhKcdvU/vUsH0TFcg7mz7e3jhL2/yrQM7q+Dm
 7TRu7uBvxcjaI7KKeH25PinlSCTvqk3kxXkwXLnJmVM5BRjYfzSkZ3B8s55MghlyZRsZ
 GwrDiuIl5PrORsYmgxg90+h2Ln+iruSNtA+ENJmp0l7j76jT88W6efPxx3Y61S91rXwe
 pi7/VeOjdw5EsSTTVbV5nHZfnKHBRZQaWreuoXFm1RMA285WRIoMF9ZXltYNUbVI1NV7
 0pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943335; x=1721548135;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5FUtXIcbYuqhhbKSIbFGBgSs5sSyYULIHHQFKwoLKI=;
 b=UW7lNa/eUZwqqRw+nRlzNCIJ/OVZljaWpHGTr9NdBJU9+xH8faZLtf1pbtUEZYM6lj
 euzooPYgT58+3zXT6w7rfq8+Bda16+6Q+gt9CDFsu8wGuo+EIQWOmwrYoKmZGgQCKJf6
 Sd7yNdTCl1LrukBbGezdfvARhkTEeq2/kUp+I+g+p8nC675KN8wb2EX9E1GQXLzsEh6z
 v5qzGZvLWZHPzZUrZJKNCoCSYOuhW6YX4HcrKrlfBEbdFCRnPHUeR9hp9Iij76p28yp2
 hcqJRApcEb6qb7L9oQJaHG1APwsvbALPFJGBeBPqoB6R9N4chXbVVd7pPZzXd2ccLh4I
 c2Cg==
X-Gm-Message-State: AOJu0YzdaBYDdCNnzmTxHNtHI84L2hf2mZ/E3XqwImeidkKtRzVAwdWR
 vW69zxsHNWzd5ZcW5Zabbu/wBzDtbwDWggCf65r2YpxLZkWmyq5KelKRgNjToXI=
X-Google-Smtp-Source: AGHT+IGi0VEF7yn4DaaSdffWqNwEgAbHlL/YJGrc9scdpmZQhMtnnxgBqRjdW2lSgDUyMNP56hNR6A==
X-Received: by 2002:a17:902:fc45:b0:1fb:58e3:717d with SMTP id
 d9443c01a7336-1fc0b510e64mr54939735ad.12.1720943334918; 
 Sun, 14 Jul 2024 00:48:54 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bb9c4d8sm19933995ad.77.2024.07.14.00.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 00:48:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
Date: Sun, 14 Jul 2024 16:48:30 +0900
Message-Id: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM6Ck2YC/zXMQQqDMBCF4avIrJsyCcHarnqP4mJMxjoLTUlKU
 CR3byq4/B+Pb4fEUTjBo9khcpYkYalhLg24iZY3K/G1waCxeEOrYpgHikqTHch0d/Stg3r+RB5
 lPaBXX3uS9A1xO9ys/+tJtCeRtULVofHEoyF2+ulpW2S9ujBDX0r5AX1k9o2dAAAA
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

rom_bar is tristate but was defined as uint32_t so convert it into
OnOffAuto to clarify that. For compatibility, a uint32 value set via
QOM will be converted into OnOffAuto.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Documented in docs/about/deprecated.rst (Daniel P. Berrangé)
- Link to v1: https://lore.kernel.org/r/20240706-rombar-v1-0-802daef2aec1@daynix.com

---
Akihiko Odaki (4):
      qapi: Add visit_type_str_preserving()
      qapi: Do not consume a value when visit_type_enum() fails
      hw/pci: Convert rom_bar into OnOffAuto
      hw/qdev: Remove opts member

 docs/about/deprecated.rst         |  7 +++++
 docs/igd-assign.txt               |  2 +-
 include/hw/pci/pci_device.h       |  2 +-
 include/hw/qdev-core.h            |  4 ---
 include/qapi/visitor-impl.h       |  3 ++-
 include/qapi/visitor.h            | 25 +++++++++++++----
 hw/core/qdev.c                    |  1 -
 hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c              |  2 +-
 hw/vfio/pci.c                     | 11 ++++----
 hw/xen/xen_pt_load_rom.c          |  4 +--
 qapi/opts-visitor.c               | 12 ++++-----
 qapi/qapi-clone-visitor.c         |  2 +-
 qapi/qapi-dealloc-visitor.c       |  4 +--
 qapi/qapi-forward-visitor.c       |  4 ++-
 qapi/qapi-visit-core.c            | 21 ++++++++++++---
 qapi/qobject-input-visitor.c      | 23 ++++++++--------
 qapi/qobject-output-visitor.c     |  2 +-
 qapi/string-input-visitor.c       |  2 +-
 qapi/string-output-visitor.c      |  2 +-
 system/qdev-monitor.c             | 12 +++++----
 tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
 22 files changed, 161 insertions(+), 73 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240704-rombar-1a4ba2890d6c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


