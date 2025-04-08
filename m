Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E4C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E6t-0004Vw-Ey; Tue, 08 Apr 2025 14:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E6r-0004Vg-Bi
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E6o-0004CP-Lx
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4245643f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138540; x=1744743340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dnabJzaRHQGKKH4TbKJr+1PyURPIpZ9pSnZbB5bnzi4=;
 b=XaEBxuwyFxYsEYFBqai/sDLZBNM2pLa6xLxaoZH6RtpLkidckEIS5p99BXMdX7qeLq
 C9rPXutk++hOmbSQSDofnFmQ2lJ4bJ4A/hXCdPlnuU+LQ71zOQnMaXSCPb0lrSwQTAdf
 qJG20y2U30MNnI33j8uCH+90iyM/jWvmPeWMv/BYZJ1By0PQhoxHekphd+jGaigZCB+u
 0vq9e4PwX4K4bYjhQIFdFAoofdxe4LG00ZrORjeV7PHADtE7vI4iwaIwYtf/eD5ExklD
 On04ThfirQcU+KiQie4BEqUQwYuBINIzMBi1DleUpH5knkLirfJHV6eRWmYaXGzE9hKx
 GIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138540; x=1744743340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dnabJzaRHQGKKH4TbKJr+1PyURPIpZ9pSnZbB5bnzi4=;
 b=TENsUMoY6OfQKJ9pHRmBSSbjY98ESlOMm+g5Ks8xYeJTY2F5IwG8seOk/vOvHhGBwj
 nRIwKYYEomteJJYRAJYVc5npGgs3pAS3mxwQw4AV9UfOuMYU+DLizjt8rcpTI66dHhVK
 2xa9P/+MQggA+EAx6emD0PSk1taIoEKdluV5Bc12liYDCffWQkAR9p40Fjw2uaFh4vxX
 5itkyplIxSa2VV0Cf8Fd0mN+nYOymDBEoccmeprJ63jGElH0SBSETV8g5dLFIJxUcbq3
 hHst8RrYh+wLHoaWHwuzKWPD6oWa832x1u8rvX5OgCfbisg0TiUK5yQodai8OPkBkA/L
 xd4A==
X-Gm-Message-State: AOJu0YwRRkCDu4TBwV2PrfMmjijuFVNxX+j2UISBJSSt7xSz25tZEnh7
 J1TS9uP5m5qPWeGZ96OYjMJtCjwRKaohEs1m3pIlMACLR7/egZaOw4HXAau/AG7io6EZsQTlWk+
 S8OY=
X-Gm-Gg: ASbGnct3fQso2K/i545auLg+TbkpZCw+jlYtllbb+4neB9E2y688u2GwKo5ihnl/Uhv
 RicgcvRgBFJiFiYnjqnQjXyYNO6UUHDdAfeFjRJfF2WN+EHllHQ4xF6NAehGLjm3T54HiSZoFbn
 zs9cJtY0nBwRtkJ/dMSiku6wc+pTwPljwe5rn4pr0DSkEInj9NbgFcvhzDFRshm8JeAEQy1n1fy
 VG2pA6LuJELGa0wXG79aD5M9pyW7OuxzjT7ir/HhBF8O1PSDpZLU8sxwN0FHlvKmxqdYgqBeVfg
 IdAQigCLYm1UI2bsmDErg+BMsBhpkV7/l+YQGJPJrWy0EIOOdiQ5Viftqt+En2K+oF06ZEa+ZCx
 8OkjYsKjLJAkt4jYrRmY=
X-Google-Smtp-Source: AGHT+IEy8J1JKw9SQZlR6IxrOlScVpM3uZNxuka0ASKVPJ20rKWQzJcprN4Arrmqed27uKOrHv4MYQ==
X-Received: by 2002:a5d:5984:0:b0:391:3207:2e6f with SMTP id
 ffacd0b85a97d-39d87cd3406mr242843f8f.42.1744138540120; 
 Tue, 08 Apr 2025 11:55:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0a38sm171564215e9.34.2025.04.08.11.55.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:55:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/8] Misc HW patches for 2025-04-08
Date: Tue,  8 Apr 2025 20:55:30 +0200
Message-ID: <20250408185538.85538-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The following changes since commit dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed:

  Merge tag 'pull-riscv-to-apply-20250407-1' of https://github.com/alistair23/qemu into staging (2025-04-07 09:18:33 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250408

for you to fetch changes up to ae81527b431e235b7f81a400b9a6a27b798c40b3:

  scripts/checkpatch: Fix typo in SPDX-License-Identifier keyword (2025-04-08 20:46:10 +0200)

----------------------------------------------------------------
Misc HW patches

- Fix overrun when parsing SMBIOS OEM string (Daan)
- Correctly call handle_machine_dumpdtb() callback (Joel)
- List HVF as supported for virt machine (Zhang)
- Correct UFS segment/alloc size comments (Keoseong)
- Do not expose unimplemented devices in i.MX8mp DTB (Guenter & Bernhard)
- Attach NVMe private namespaces to proper controller (Klaus)
- Fix typo in SDPX license checker script (Zhao)

----------------------------------------------------------------

Daan De Meyer (1):
  smbios: Fix buffer overrun when using path= option

Guenter Roeck (2):
  hw/arm/imx8mp-evk: Remove unimplemented cpu-idle-states properties
    from devicetree
  hw/arm/imx8mp-evk: Temporarily remove unimplemented imx8mp-fspi node
    from devicetree

Joel Stanley (1):
  hw/core/machine: Fix -machine dumpdtb=file.dtb

Keoseong Park (1):
  hw/ufs: Fix incorrect comment for segment_size and
    allocation_unit_size

Klaus Jensen (1):
  hw/nvme: fix attachment of private namespaces

Zhang Chen (1):
  docs/arm: Add apple HVF host for supported guest CPU type

Zhao Liu (1):
  scripts/checkpatch: Fix typo in SPDX-License-Identifier keyword

 docs/system/arm/imx8mp-evk.rst | 12 ++----------
 docs/system/arm/virt.rst       |  4 ++--
 hw/nvme/nvme.h                 |  3 +++
 hw/arm/imx8mp-evk.c            | 29 +++++++++++++++++++++++++++++
 hw/core/machine.c              | 12 ++++++------
 hw/nvme/ctrl.c                 |  7 ++++++-
 hw/nvme/ns.c                   |  4 ++++
 hw/nvme/subsys.c               |  9 +--------
 hw/smbios/smbios.c             |  3 +++
 hw/ufs/ufs.c                   |  4 ++--
 scripts/checkpatch.pl          |  4 ++--
 11 files changed, 60 insertions(+), 31 deletions(-)

-- 
2.47.1


