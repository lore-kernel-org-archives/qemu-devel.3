Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA50BC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhLqu-0000dJ-V1; Thu, 31 Jul 2025 01:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpn-0007Ou-5y
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:07 -0400
Received: from p-east3-cluster7-host1-snip4-3.eps.apple.com ([57.103.84.134]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpk-0005kR-SI
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:06 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 1985018000A6; Thu, 31 Jul 2025 05:27:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lJ2HIAjAfFSWns5vk8p8nzsDGZA2gny3PkMnoQy55F4=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=g3gxwxfY72m2+x9uBqq4kUYrKef98B4s9xix+ukTgXRGielbEnRHvsTyK4bfBCdGvZHxLdQnZiIQvFfPbzAviEdkLlVsHmG5M+o6C/CZgfVdR4ECINI0p33kCHJfNaZSdC6jPeptKoCfY/ZDelAANr62FFaV7icvVCyLVE5a4VK5TnFesPDHssIybzaAD9h/UbduwSeLCoLYRePxfIfKyMGe9zcy3wBmoe8BLuC5IiDfIWTvSnrxo27oUaakeY91ev8mSIaiDKjf8m02DWvL6AWH00KrCE/XXq4P/A5ee8tJEURtfuXfu2vBmc46KoceM0Bk37Ktio77wBSe+b7rhQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 CEBD71800122; Thu, 31 Jul 2025 05:27:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 0/9] WHPX support for Arm
Date: Thu, 31 Jul 2025 07:27:44 +0200
Message-Id: <20250731052753.93255-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CDzjr3HxPSoPYZ1ElqwdU9oopTLWQy2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNSBTYWx0ZWRfXxKsO7TIGw2Cp
 fWUxFb3qqz1nBs5JS6KnkodRrNGlu9C46VOuChWkH6ETuQAjIyPoboh9XLUrO6nEPl3mL/MMT+l
 uyZ4slkspSYdy+ulRWMGLFOcikTolqwTWNUuCJOZgNX7ebmGiD64uorx8uu+Hd+2F2E4e+AXkGs
 BepX5vH636I2KiZuYUafgOCUKD1E7koID59QY1bQsUNaOaVC3Yv2NBmg6iio8IwrlrASn6eXLi3
 OY1/b0tnZeAK+ZsCu4e9teI2Ck+4brlVE9v3dpPngN9tEuTpTlCbtADdu47MqsUiBWtk6AKjY=
X-Proofpoint-ORIG-GUID: CDzjr3HxPSoPYZ1ElqwdU9oopTLWQy2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=877
 phishscore=0 clxscore=1030 spamscore=0 bulkscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507310035
Received-SPF: pass client-ip=57.103.84.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This one took way longer for me to publish than I should have.

There are a number of lingering bugs in this one including u-boot not working.

Interrupt controller save/restore is entirely missing in this RFC, and some other state
bits are likely still missing too.

ITS not blocked by default yet, remember to use its=off when testing this series.
You might also want the GICv3 + GICv2m support patch as part of the HVF vGIC patch series, which
is not duplicated here.

PS: on both this and HVF, interrupt controller initialisation needs to be done early so I ended
up with hardcoded addresses. Wonder if the right way to go might be to defer virt and vCPU initialisation
until late in the process post-gic_realize...

Other than that, this boots both EDK2 and Linux in SMP, when using devicetree or ACPI.

Mohamed Mediouni (9):
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: common: use whpx_cpu_instance_init on x86 only
  whpx: interrupt controller support
  hw/virt: make Qemu aware that WHPX has a vGICv3
  hw: intc: arm_gicv3_common: add whpx
  whpx: add arm64 support
  whpx: copy over memory tracking logic from hvf
  target/arm: cpu: mark WHPX as supporting PSCI 1.1

 accel/meson.build                             |   1 +
 accel/whpx/meson.build                        |   7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |   8 +-
 accel/whpx/whpx-common.c                      | 670 ++++++++++++++++
 hw/arm/virt.c                                 |   3 +
 hw/intc/arm_gicv3_common.c                    |   3 +
 hw/intc/arm_gicv3_whpx.c                      | 285 +++++++
 hw/intc/meson.build                           |   1 +
 .../whpx => include/system}/whpx-accel-ops.h  |   4 +-
 include/system/whpx-all.h                     |  12 +
 include/system/whpx-common.h                  |  22 +
 .../whpx => include/system}/whpx-internal.h   |  11 +-
 meson.build                                   |   5 +-
 target/arm/cpu.c                              |   3 +-
 target/arm/meson.build                        |   1 +
 target/arm/whpx/meson.build                   |   3 +
 target/arm/whpx/whpx-all.c                    | 744 ++++++++++++++++++
 target/i386/whpx/meson.build                  |   1 -
 target/i386/whpx/whpx-all.c                   | 524 +-----------
 target/i386/whpx/whpx-apic.c                  |   2 +-
 20 files changed, 1780 insertions(+), 530 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (97%)
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c

-- 
2.39.5 (Apple Git-154)


