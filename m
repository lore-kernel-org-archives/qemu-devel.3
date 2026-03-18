Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331E310775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzo-00021F-1U; Wed, 18 Mar 2026 13:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uze-0001ye-7Q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:43 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzc-0005np-AH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:41 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso55607a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856058; x=1774460858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SSoI7ksp7jNSActDwI6wZUFzzcSWWLOGBMJIw+S5lUM=;
 b=hekWzcL81C/2siBNyl1xr4pJD5TFiZJ/hiC3WG5/59F67higGVVyfll2LdeO8xU7oI
 3h20s7/252PbiSLherM0ZXb7/H8K7iKVBmLhMjlAsgPbs3Ou7digyRpicFLY5Tenixzi
 /Xg+WL0bdSQj0H+8IpxX/3Il2XdPxWn1nzDwhxGspf+ILaVfDb3RM0B24K5oNtGfCcn7
 SzpchJ8h5IoHUI6AHiegqM8RSE8YtX+pMpp2jCm0iHPXLYfP1otd+GbmY/sBuzKOdjlH
 U4Ed9G/LrXe3yEWpzg06shvyPNzAYe7HI1wk3WMT8B4cNpGajxXldbcCZ7Wc1oIdqVW4
 mjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856058; x=1774460858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSoI7ksp7jNSActDwI6wZUFzzcSWWLOGBMJIw+S5lUM=;
 b=SBbDEl//8AtBHxWW/MG2KiDC+HPW9LomXpCMOlb1KQb79pjNp55BZ0OIqQc0KS++7F
 0oT3P47cAuQAMeoTXhVoUpUNObfJ9NE09UVPaRQzVYWzZQAvDbvGyN0d+7IMRUm0qC5q
 ZOUUtJZGi+w60773eD0LuTp8ccGS4AAM6SMgiS7aC/VxPsdvQvFkvnF5Yf2oefIoZ0XW
 Kr89CluIn+ABHQ7re+gtTBA8xTI0bQ7A/MCdMpWnCajA5twJLdVM4VR53mJdwYk20hfp
 X4mYcOwwF1uic7tbhCNlO6F8EniMU9jAz+yf/g30o+HHaAzNpBSbnCIbYW2+blqsO7xU
 u3+A==
X-Gm-Message-State: AOJu0YygIxEv0QFt7VoRZ6xX8JiiH0kbQatjAQ0M2WWjl0+Te1rLnuHz
 ATJ1mAVW6bDA+oj1g8uD8ItHpgNlCxj+c0vNwJ7BlfRlCzqkwhDdkg7qv7JQPqlx1yav89d4Xu8
 H7GNeHG8=
X-Gm-Gg: ATEYQzwc6B8x5n3eozem0dn5bPqm9hl+v/uWNl/P9bo7oZI5PrsNyjuiTpL4xUtxkro
 iY+BzgyXhZucMWvqMtnkMCayuRpH+M7uOtTVIjv/HGTMudcoBNdr4pqiAUAD/iAqU2FeigLm7Rq
 DHgS7WpXm4kGHfMRBTfkVWC9k8VCDGMG43QqLhCg7D6MbAUC6tUDyMd5gAwjjcjblNb27QgGh2r
 FiFR3pMuOazt3ur/jAN5bcZgx7gwKMAtzta1R7tQ1pXpAAitwNSTWeN+Xb1gETjqWoyA9xh2Au+
 By9uGV8kEwXJ8ndKDkymjDnSFkKaeIvh4B4tSLptRI+5hcuaVfhoDoa2vnxBN1ZQU9aNXOAh0FD
 oIDbJJMco/5rNTfuGkAwkfMDVAtfHLtJfMU9+WsGNFmleTzBtmRx0Thy2Fkd/pt1cD3GN1wu9zu
 /TBix4ZbveKMaa0nWMW/eEfJ2Bm+jISceAuzmMJp2icvbdz6gdoo9I2IMsny1JByH2I79YWi8e2
 xbS
X-Received: by 2002:a17:903:11cf:b0:2aa:d671:e613 with SMTP id
 d9443c01a7336-2b06e3cfaf6mr43765535ad.38.1773856058120; 
 Wed, 18 Mar 2026 10:47:38 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 0/8] hw/vfio: single-binary
Date: Wed, 18 Mar 2026 10:47:25 -0700
Message-ID: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

This series makes changes to hw/vfio to compile files only once.
Changes are pretty straightforward and are mostly extraction of kvm/other config
specific functions to proper files.
This is the last hw/* subsystem that needs to be changed for single-binary.

v5
--

- Fix extra SoB in "hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD"
- Rebase on top of master and remove pixman/opengl details in commit description
  since it's now already merged.

v4
--

- rewrite commit description for "hw/vfio: eradicate CONFIG_IOMMU from sources"

v2 (sent as v3)
---------------

- use global stub_ss (fix some missing dependencies in this case)
- move kvm_enabled() guard check on function calls
- s/Vfio spapr kvm/VFIO sPAPR KVM/

Pierrick Bouvier (8):
  hw/vfio/listener.c: remove CONFIG_KVM
  hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
  hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
  hw/vfio: eradicate CONFIG_IOMMU from sources
  hw/vfio/pci.c: eradicate CONFIG_KVM
  hw/vfio/ap.c: use full path for target specific header
  hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
    hw/vfio/kvm-spapr.c
  hw/vfio: all vfio files can now be common files

 hw/vfio/kvm-spapr.h          |  12 +++
 hw/vfio/pci.h                |   2 +
 target/s390x/kvm/kvm_s390x.h |   2 +-
 hw/vfio/ap.c                 |  11 +-
 hw/vfio/ccw.c                |   9 --
 hw/vfio/helpers.c            | 172 -------------------------------
 hw/vfio/igd-stubs.c          |  20 ++++
 hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-spapr.c          |  47 +++++++++
 hw/vfio/kvm-stubs.c          |  34 +++++++
 hw/vfio/listener.c           |   4 -
 hw/vfio/pci-quirks.c         |   5 -
 hw/vfio/pci.c                |  39 ++-----
 hw/vfio/spapr.c              |  30 +-----
 hw/vfio/meson.build          |   6 +-
 15 files changed, 328 insertions(+), 257 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/igd-stubs.c
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-spapr.c
 create mode 100644 hw/vfio/kvm-stubs.c

-- 
2.47.3


