Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0C9CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA5V-0006bk-7m; Thu, 19 Sep 2024 01:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1srA5S-0006ap-Un; Thu, 19 Sep 2024 01:52:18 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1srA5N-0006rY-Lb; Thu, 19 Sep 2024 01:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726725117; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=FV1GYYaExWjDqEwzyIk9D5YEF3hBCh2MV8bD/mCD9/c=;
 b=DWa6zEekvs7lyTGcHqXY+whT2K4GR3vyOkfMYHCI2EzfZVLNfHAXKsxrAW96JWms3Qtm7xYuitbCtvCjV6x3S7N2Ubi2QBbhWeFGgoHh5vRphduCFmj2bVButf5azDRNh0KJrZpvjWJlFTCOonj/NXop8X2MoLibWfx20CZcDrg=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WFGWR1z_1726725115) by smtp.aliyun-inc.com;
 Thu, 19 Sep 2024 13:51:56 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v7 0/8] target/riscv: Expose RV32 cpu to RV64 QEMU
Date: Thu, 19 Sep 2024 13:50:40 +0800
Message-Id: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
qemu-system-riscv64 can directly boot a RV32 Linux.

This patch set has been tested with 6.9.0 Linux Image.
And add an avocado tuxrun test in tests/avocado.

v7:
  Remove cpu of "any".

v6:
  Use TUXRUN test case instead of boot_linux_console
  Add any32 and max32 cpu for RV64 QEMU 

v5:
  Rebase to master and add tags  

v4:
  Drop UL completely in PATCH v3 2/7, 4/7, 5/7.
  Avocado: Add "if=none" to "-drive" option in QEMU command line

v3:
  Rebase to the master branch

v2:
  Remove the line that was inadvertently left in PATCH v1 4/6.
  Add an avocado test.

v1:
  https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html

LIU Zhiwei (2):
  target/riscv: Add max32 CPU for RV64 QEMU
  tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU

TANG Tiancheng (6):
  target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
  target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
  target/riscv: Correct SXL return value for RV32 in RV64 QEMU
  target/riscv: Detect sxl to set bit width for RV32 in RV64
  target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
  target/riscv: Enable RV32 CPU support in RV64 QEMU

 configs/targets/riscv64-softmmu.mak |  2 +-
 hw/riscv/boot.c                     | 35 +++++++++++++++++++----------
 hw/riscv/sifive_u.c                 |  3 ++-
 include/hw/riscv/boot.h             |  4 +++-
 include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++++
 target/riscv/cpu-qom.h              |  1 +
 target/riscv/cpu.c                  | 28 ++++++++++++++++-------
 target/riscv/cpu.h                  |  5 ++++-
 target/riscv/cpu_helper.c           | 25 +++++++++++++++------
 target/riscv/pmp.c                  |  2 +-
 tests/avocado/tuxrun_baselines.py   | 16 +++++++++++++
 11 files changed, 118 insertions(+), 32 deletions(-)

-- 
2.43.0


