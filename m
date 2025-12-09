Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2596D3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3xx-0000op-54; Tue, 09 Dec 2025 15:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3xu-0000oT-VW
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3xt-0001H3-43
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:42 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2d5e119fso2560324f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310739; x=1765915539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xezfzl7F4cXOA+1euehvlBoACOHQVgv+Trponi1peWU=;
 b=olh4HQXmsxMmqZRJyTXnmapsGTeF8/EHtAM+F50gNqzDxnvdI/4HV0vVTR8wy6ye5O
 YuLJpzma12W1fqnvjv9AofKCocN5m0jxviswuQ1g6/EUNngPwgLm7ZtzVh+85dbjX0Pk
 LktH+Cbpvaqxc/+K2vFl74bKam+hQl4oLAE/++PW/rb6JDi2KihqARnqGwHPqatWMPP3
 GbHkKVLlPYylvlYWhhTZLguo4gwQqki6QiEhhahDMKHFu3D7LrlWepbYkllGP5Q08kTB
 4cxJdO49n4uEFMlrrmdFEfkXO9kgmfRCG9kCdci4qfNHcZiWDr32Ie3RimY2gOYaI5NJ
 OxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310739; x=1765915539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xezfzl7F4cXOA+1euehvlBoACOHQVgv+Trponi1peWU=;
 b=R4nE16zKXfdR6yApg+Dj3YRLxylyvUSuuI9CCAViYy4mDTNMDZwiUK4pz54R3D5LnP
 3nxcXprcpTEbqFOAkSv+j89nTVKqtbkyvOj1Ga9tA1UROQVNVALoFt4J1hrAGYXAsNBx
 wqyM27PDYxfQ/HjkKAJF1Dfrun5vJ47d7NfRwnrthL6ZTjgFIVV2d+HpVXH8H/orXrxX
 JO3//S2HCNQis0t6ZQWpXYdO6pXdSDoeuVSapXi6eR4S4SsYmnZJcZaUm2Q8jkOKufk1
 XjWASfT/YfImJu9T2n2++9RCvxYbonxenOei5dv/K54VmIm+mmJJ/a/wvPn0Coip+OvO
 jLRA==
X-Gm-Message-State: AOJu0Yy1eWfTOCvyzF6ek04pHywo24G6W9+ML1ZRJH2yfjJxrxQ9ohKz
 AZVPEYMB60wI+iJfMWs0P9O4HGfmEugBTipKvAblxhBYdTkpZ3JbsWUWzag1msFwT5Ht4lg5r2S
 4lvPi0pE=
X-Gm-Gg: AY/fxX7zvGxSBt2rA5547a45u61JxYcV2U+1YMa5mPdL4iG4EF4tHrUSbsYm0gCOqrH
 9OZ0uljLIXmSVmYEVH0eaCp2SNuKUya9gV4MMVfqgJoNAHZZG4Bo3b1QMM54xUZlRnuNrZ6wvvI
 FJIxvqW+tHA/1H5nWsArPUFSaM5yUE+XDVGqC+bIqm1jwV987mBJZAbZTW/vBR8XKUEy5YsdkcQ
 6rSMT5H2ua/mJ1oA46jWsLDht8mKRpbZxa4QqkiI5G6bFtWXjZ+gBw7/zn1o+GmWSXr7eojDlcd
 HIGXzu36hBdvNM6rsAjCNEXgM2eUVC8L5isVKRX4t3s2YyiAaoZ2EkWQK3fu9rnhGynI9dsEVsi
 M3U8NMuVYY9cKj/QwaEV3J39v9d8QQdIvHVWZkQbHj9OGu5wfC6Kl71dXgCfNmHrcX84NVLNbmr
 zrTunDlM/1PnzP6T7YajROdu/x17Q8ITA0BARZc2+vp3SA3pvF7+fSAgRBB7D3
X-Google-Smtp-Source: AGHT+IGh6S/Q+Eelt76oE4AkIIFrZR78t4m4/tfK30DrPK9gHVlGDSMc6e7H1dhCCgw23Dl9wUWPOA==
X-Received: by 2002:a5d:6584:0:b0:42b:2f79:755e with SMTP id
 ffacd0b85a97d-42f89f09f0dmr10202946f8f.3.1765310738680; 
 Tue, 09 Dec 2025 12:05:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90f0sm33702165f8f.9.2025.12.09.12.05.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:05:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Misc HW patches for 2025-12-09
Date: Tue,  9 Dec 2025 21:05:27 +0100
Message-ID: <20251209200537.84097-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The following changes since commit 2257f52a97f28ce3be4366817ea8817ad866562b:

  Merge tag 'pull-10.2-final-fixes-051225-2' of https://gitlab.com/stsquad/qemu into staging (2025-12-05 12:38:37 -0600)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251209

for you to fetch changes up to efd6b3d1768d04d5491b62ad7385f623fb12f627:

  Revert "hw/net/virtio-net: make VirtIONet.vlans an array instead of a pointer" (2025-12-09 21:00:15 +0100)

----------------------------------------------------------------
Misc HW / migration / typo fixes
----------------------------------------------------------------

Alano Song (1):
  hw/9pfs: Correct typo

Cédric Le Goater (1):
  Fix const qualifier build errors with recent glibc

Denis V. Lunev (1):
  scripts: fix broken error path in modinfo-collect.py

Hanna Czenczek (1):
  vhost: Always initialize cached vring data

Philippe Mathieu-Daudé (3):
  osdep: Undefine FSCALE definition to fix Solaris builds
  Revert "migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE macro"
  Revert "hw/net/virtio-net: make VirtIONet.vlans an array instead of a
    pointer"

Stefan Weil (3):
  migration: Fix order of function arguments
  hw/pci: Fix typo in documentation
  scripts/nsis.py: Tell makensis that WoA is 64 bit

 include/hw/pci/pci.h           |  2 +-
 include/hw/virtio/virtio-net.h |  2 +-
 include/migration/vmstate.h    |  9 ++++++++
 include/qemu/osdep.h           |  6 ++++++
 backends/tpm/tpm_passthrough.c |  2 +-
 block/vmdk.c                   |  2 +-
 block/vvfat.c                  |  2 +-
 gdbstub/gdbstub.c              |  2 +-
 hw/9pfs/xen-9p-backend.c       |  2 +-
 hw/net/virtio-net.c            |  9 ++++----
 hw/virtio/vhost.c              | 38 ++++++++++++++++++++--------------
 migration/postcopy-ram.c       |  5 +++--
 qga/commands-linux.c           |  7 ++++---
 ui/ui-hmp-cmds.c               |  2 +-
 util/log.c                     |  2 +-
 scripts/modinfo-collect.py     |  2 +-
 scripts/nsis.py                |  2 +-
 17 files changed, 61 insertions(+), 35 deletions(-)

-- 
2.51.0


