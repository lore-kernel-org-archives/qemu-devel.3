Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A184DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4hw-0002qg-P0; Thu, 07 May 2026 15:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hI-0002le-V2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:47:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4h5-000684-AH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:47:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso11781165e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183250; x=1778788050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x7QcIv9mPbYZ5I0wIG6iF/4vSbCk6U200D9ymfA5eZY=;
 b=ZHLPDDfIfUjL8wIeqqrWu6I7D0SJzlI5gGYNNP0k/rrRKehVuOWK9NVJz14LppNJqM
 urkaowK+Oc1j1rGb6+UZtHQqqhDeWk7gNExLbUUf1ssd31Ay8uug6dXLpJY904ZpSHPO
 h8vD8Bpg/GyUrp1lHctZ5JPPA2RuHpVmpkgf6M9eXW4DuDhq0H3RuEjFI1QL7nq8RA9p
 sNx0RoGKf2vUyvkhBh2EFU7B8UCixzlQ2MaeYiFQzBicoQ8duT0Ha0De/TlGRuaJEiGk
 SZJLQcTFYjBXIw6deyvRCBVA9q7VRaCVnOqgRxZpMPknssZ8gggWSBbYmIgMcQCtrQNR
 I/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183250; x=1778788050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7QcIv9mPbYZ5I0wIG6iF/4vSbCk6U200D9ymfA5eZY=;
 b=cW5EBKtV1+Wh4ShM1GW4u/0uNFpNwP91C2ZT4y5VXbB7hX7/VNurpfAwdkuMgFr50P
 vrZkS/80QzHWVvsfHjrke5FxhPcgPe3NCJ0/dTp5SBtqdOQtaIrtVD3Mkz5LyqVnQRjo
 yAV60K4PHnKUw2ZkaZzMN7SH7cGE3Ekgt9Ulifhw66+a4bXxfJHrey5/KR/wRGPsP/nj
 f+c8Bx8CCyh3tndDKSTNAyi9xaKga+uETGlvd2SIEuVUapH9UlaPUGfDF9HrqhhBFYlY
 GnatVqmAUr8NDjeDjKebpuLbWTa55cHyvV0SDjxj58zqWfqqAqWsCJ+BPrQiU1ZUfgKQ
 /Xkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FtOo9XJIUvdcf6nMLC34+JnuLyuspaPXeGj2kLRrRAWIgy8rCYMlwboBNh8EiYvS6rWLnAtJ3Gw+D@nongnu.org
X-Gm-Message-State: AOJu0YyR9Qgcc+mMjysI+aCCv0wENi+7q8EnpuRXTBpbSFkfejFbhoar
 o89neQVZm+hiPa537F4nTuuXeI7vjjo6zncwac8marFGIIjIfenUHHbirXTZkZK1DJM=
X-Gm-Gg: AeBDieumzeDUZKvY8Bb8cxC2eCMOYgFKnzRm2TldInqCs4HuLdqpkO/PudRa2KQebTr
 j4x0xDUaDI8UvP1uIW3DOfHpf2PcH/mDwmsD/euCf+XKna+c+Hq/u6p+gVL4fj8LXzcLWTkrYYY
 VrMWmMo3n5qqAsahIfS4B0ISBIfvMQIQT+qybh/ps1jLf/ZBlp0hFNwA4jmhBSGSYhhF4wToGGK
 3cJGdeqpQWFcgTwn525TmZtVdKy30cn7fxLYfxcIVcS+vOqe8nfanu90JuQVEEi6418eswXffNd
 WAi1IR++hlwelPjuF7Gc9MuyekwG0NCUedVWEAQygMs++ASKblxo5RZMiTH4rUqu/lYjacNxXNx
 W6TPkXJA6hvDTPN5TJeOegc4lKjAmorIZGLoP1pVmgGBBiu+uRRgTNdTruMu01pppX2hhPqkqHN
 AZM0LWu4vUFdtDS6WZQw1hS45mllG45volR+Meh8lrsOwtD0HEKzDWPQfRY599YJHQbIUOhzub3
 SCx33IRQE0PRdoiugU0HMjv5I07cbg3XwWxFhVeKQ==
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48e51e0a620mr158685105e9.3.1778183250328; 
 Thu, 07 May 2026 12:47:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c145aasm958375e9.25.2026.05.07.12.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:47:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/6] target/arm: Fix functional test failures in KVM-only
 builds
Date: Thu,  7 May 2026 20:47:22 +0100
Message-ID: <20260507194728.2034696-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If you build QEMU with --disable-tcg on an AArch64 system, some of the
"make check-functional" tests fail. This patchset fixes them.

The first patch fixes a bug in QEMU proper, where we broke the
"x-remote" machine because we forgot to mark it up as being
OK to expose in the qemu-system-arm and qemu-system-aarch64
binaries, the way we do for "none" and for all the actual Arm
machine types.

The rest are tweaks to the tests:
 * tests that run '-machine virt,virtualization=on' need to
   check for failure because the machine reports that the hypervisor
   can't support nested virt
 * tests that use a specific CPU type need to either be
   restricted to TCG-only, or else changed to use 'max' instead
   (since that's the only CPU that will work on both TCG and KVM)

thanks
-- PMM

Peter Maydell (6):
  hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and
    AArch32
  tests/functional/test_virt_vbsa: Skip UEFI test if virtualization not
    supported
  tests/functional/test_kvm.py: Use -cpu max, not cortex-a72
  tests/functional/test_kvm.py: Skip if virtualization not supported
  tests/functional/test_hotplug_pci.py: Require TCG
  tests/functional/test_tuxrun: Restrict to TCG

 hw/remote/machine.c                          |  3 +++
 tests/functional/aarch64/test_hotplug_pci.py |  1 +
 tests/functional/aarch64/test_kvm.py         | 12 ++++++++++--
 tests/functional/aarch64/test_tuxrun.py      |  2 ++
 tests/functional/aarch64/test_virt_vbsa.py   | 10 +++++++++-
 5 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.43.0


