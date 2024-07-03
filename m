Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2CFC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzDv-0001L1-R2; Wed, 03 Jul 2024 08:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOzDt-0001KP-Er; Wed, 03 Jul 2024 08:36:33 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOzDp-0001hN-P8; Wed, 03 Jul 2024 08:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720010179; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=3Is2frlWsDuFRcC2QglRcyRRQRMAfxE/CHUeUk9rdA8=;
 b=BUWyt9qSudzPUc0EUzof31LxYWApin4GkLXy/3JuTe9Koqn99SVoDsWJ0K+78MVvpY4pfB8O3FWCX76Zs4RtmFF3IjWBsvdTTmGhFyKJiqpVRhQ7nyPK1h1yg+Mlzwka0mFGlHlWTllgXRy2f8KaE8psuBtl2u1CaFzsjzqZu04=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9mSY9-_1720010176; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9mSY9-_1720010176) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 20:36:17 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
Date: Wed,  3 Jul 2024 20:34:42 +0800
Message-Id: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
And add an avocado test in tests/avocado.

v2:
  Remove the line that was inadvertently left in PATCH v1 4/6.
  Add an avocado test.

v1:
  https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html

TANG Tiancheng (7):
  target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
  target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
  target/riscv: Correct SXL return value for RV32 in RV64 QEMU
  target/riscv: Detect sxl to set bit width for RV32 in RV64
  target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
  target/riscv: Enable RV32 CPU support in RV64 QEMU
  tests/avocado: Add an avocado test for riscv64

 configs/targets/riscv64-softmmu.mak |  2 +-
 hw/riscv/boot.c                     | 35 +++++++++++++++++++----------
 hw/riscv/sifive_u.c                 |  3 ++-
 include/hw/riscv/boot.h             |  4 +++-
 include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++++
 target/riscv/cpu.c                  | 17 ++++++++++----
 target/riscv/cpu.h                  |  5 ++++-
 target/riscv/cpu_helper.c           | 25 +++++++++++++++------
 target/riscv/pmp.c                  |  2 +-
 tests/avocado/boot_linux_console.py | 35 +++++++++++++++++++++++++++++
 10 files changed, 129 insertions(+), 28 deletions(-)

-- 
2.43.0


