Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8535C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7Yw-0004kQ-J7; Fri, 28 Jun 2024 05:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sN7Yu-0004ip-G0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:06:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sN7Yq-0005k2-VV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:06:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W9Tyj2zc4z6K8wN;
 Fri, 28 Jun 2024 17:04:29 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 2130D1400CA;
 Fri, 28 Jun 2024 17:06:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.147.160) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:06:13 +0100
To: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <linux-edac@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
 <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/3 qemu] arm/acpi: ACPI based FW First error injection
Date: Fri, 28 Jun 2024 10:06:01 +0100
Message-ID: <20240628090605.529-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.147.160]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Series adds,
1. ACPI based FW First error injection and
2. Support for injecting ARM processor errors.

This qemu based error injection mechanism found very useful for testing and
upstream the RAS FW-first related changes in the kernel
as well as in the user space tools when hardware is not available. 

What is this?
- ACPI + UEFI specs define a means of notifying the OS of errors that
  firmware has handled (gathered up data etc, reset the relevant error tracking
  units etc) in a set of standard formats (UEFI spec appendix N).
- ARM virt already supports standard HEST ACPI table description of Synchronous
  External Abort (SEA) for memory errors. This series builds on this to
  add a GHESv2 / Generic Error Device / GPIO interrupt path for asynchronous
  error reporting.

- The OS normally negotiates for control of error registers via _OSC.
  Previously QEMU unconditionally granted control of these registers.
  This series includes a machine parameter to allow the 'FW' to not let the
  OS take control and tracks whether the OS has asked for control or not.
  Note this code relies on the standard handshake - it's not remotely
  correct if the OS does follow that flow - this can be hardened with some
  more AML magic.

Alternatives:
- In theory we could emulate a management controller running appropriate firmware
  and have that actually handle the errors. It's much easier to instead intercept
  them before the error reporting messages are sent and result logged in the root
  ports error registers. As far as the guest is concerned it doesn't matter if
  these registers are handled via the firmware or never got written in the first
  place (the guest isn't allowed to touch these registers anyway!)
  This is sort of same argument for why we build ACPI tables in general in QEMU
  rather than making that an EDK2 problem.

Why?
- The kernel supports both firmware first and native RAS.
  As only some vendors have adopted a FW first model and hardware
  availability is limited this code has proven challenging to test.

Why an RFC?
- Assuming adding this support to QEMU will be controversial.
- Probably figure out how to do this for x86 as apparently people
  also want to use that architecture.

Reference to the previous series.
https://patchew.org/QEMU/20240205141940.31111-1-Jonathan.Cameron@huawei.com/

Mauro Carvalho had added instructions in wiki about how to inject ARM
procssor errors:
https://github.com/mchehab/rasdaemon/wiki/error-injection

Series is avaiable here:
https://gitlab.com/shiju.jose/qemu/-/commits/arm-error-inject

Jonathan Cameron (3):
  arm/virt: Wire up GPIO error source for ACPI / GHES
  acpi/ghes: Support GPIO error source.
  acpi/ghes: Add a logic to handle block addresses and FW first ARM
    processor error injection

 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 266 ++++++++++++++++++++++++++--
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           |  35 ++++
 hw/arm/arm_error_inject_stubs.c     |  18 ++
 hw/arm/meson.build                  |   3 +
 hw/arm/virt-acpi-build.c            |  29 ++-
 hw/arm/virt.c                       |  12 +-
 include/hw/acpi/ghes.h              |   3 +
 include/hw/boards.h                 |   1 +
 qapi/arm-error-inject.json          |  49 +++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 13 files changed, 405 insertions(+), 18 deletions(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

-- 
2.34.1


