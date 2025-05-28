Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1932C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKN5G-0001lK-H8; Wed, 28 May 2025 16:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKN5D-0001jS-Kt
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:09:03 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKN54-0006K2-VU
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:09:02 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7c55500d08cso14592185a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748462933; x=1749067733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=92UfK6LGb3e655cwJB8Y8Grjmr6zbigcWGXqhl/iC2E=;
 b=gK+5d1arufb8sLLUHTtkpG8ruHgJCLPkjJttHkAgrPsEXo86Tslah9x89ruUXH1xTA
 0Zl1FeZAwHFtxVq8jpxZj/VGXu81FymtcJ1kR5caK318cN+daJrs44Fkg4oA1dnzqRQc
 AKlLWWMRiQTEDdgkXk9HdXkddDcMwkYF+V2420Sci2umVvK4GtQJaJhndmt1x+w7P6XA
 7/jKUA14MgfNFWywUremfPw7EmFPh3txNPKcnLqfC+aabAuOeQ4GX4LiBVSjj/04bK/z
 rgNWeTmA/+PXkYCZd4UA0b9CTbRWwhzKI5GiUnlTXfNm49Sb7J7ZXDVgXSNcv3Zkbr1N
 fwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748462933; x=1749067733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92UfK6LGb3e655cwJB8Y8Grjmr6zbigcWGXqhl/iC2E=;
 b=awaBKqN7JgdYbWLIkDimP51TcKdUJHKoqoZMmnvKajfxLOO3CECSAAHIjvRehbT8Do
 rc5F/PJq6FqnJXcX05CjRxvOnQb9gFV1bJckUS4ru8riXKbEy9NDuEMnccDUGDMK4xLr
 Dvh30SwlUtZp9kvOpEtFmiOSB97NUb1ke2vw43wucafIg5Xt0jwn1oTBYCJeTjbvYm1J
 m9SATACnTaMXGKhnk4x+R3zhkAfZLvv0gVcssNWjb/2k650m9bs2gyHHAhwsInKWxtL3
 cy9J6hr9BBvonfK/RI+EyRJGuefBxXsFaPmAaBymxq1HYgXoa/QEYkcvK0u9uNvUGc7o
 +xKA==
X-Gm-Message-State: AOJu0Yzd2HWoJKFICwlHSVfyB8wwFA1Cc04jvPK707eGRo7uWTLmGP2V
 m18X9ZpFVr5ve/XtuMIKs0Jlk4SWuUWc08jVgOlXmYJIbIO1gRWF7NSgUpVSnenlKz47xEp0wBP
 fNlXy
X-Gm-Gg: ASbGncsL1u8AS5L0OHFJxrJAt0zz9+fcSDTdaQe07jV69ghe2zQ825JmNrbbmfFVPyW
 Rzqq9Sm55M0kqnUdUpia2kek/LSWFAm0DNSWtgy+1L2IDdFxSSrSn71/GYFPu1KivUXHNzlPtMY
 yRIUoT9nfxcIH1QOEShyWAtFG23BLd0KzFKtXbdXhY1gO6vIbSvNex1blhA5YXHMUH2bz0/HYiN
 JPq7dFk1A/WP/dMYTUXT6JZuhS0Hg8kw6nUv8p+LkyvY9s/ounMhncdxzh2JKKPtoB6UzPj9rU3
 4WxzaoMLSihbXzoYn6jrbhmLnKw7xgDXGbQdRlquC/+9nxKk5WTibjoW2vexXlojvzSEWUwxhL2
 lTCc=
X-Google-Smtp-Source: AGHT+IEtxgMee3F8cEwS588/Oq+FsB429d091JlwGdPDXrh8xMU/PSNcrI8Jjf7H6Gjvny+Zdq5vOA==
X-Received: by 2002:a05:6102:c07:b0:4e5:a309:85e8 with SMTP id
 ada2fe7eead31-4e5a309874cmr3339660137.7.1748462503816; 
 Wed, 28 May 2025 13:01:43 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e59fc11a95sm1393736137.3.2025.05.28.13.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 13:01:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/4] hw/riscv: Add Server Platform Reference Board
Date: Wed, 28 May 2025 17:01:25 -0300
Message-ID: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi,

This is my attempt to ressurect the Server SoC Platform reference work
that has been buried for an year. The last posting was made an year ago
[1]. 

Most of the changes were made due to upstream differences from one year
ago. Patch 1 is an example of that.

In patch 2 (former 1), the main difference is the new CPU is rva23s64
compliant. This wasn't possible in May 2024 because we didn't have this
support back then.

Patch 3 consists mostly of code base changes rather than functional
changes. There was a discussion about whether we should supply fdts in
this machine back in the v2 review [2]. The answer is yes: machine mode
requires fdt to work, and we want to be flexible enough to generate our
own fdt instead of relying on EDK2 to supply them. Note that we can also
supply an EDK2-generated fdt via command line, bypassing the fdt created
by QEMU, if desired.

Patch 4 adds a riscv-iommu-sys device to the board. This wasn't possible
back then because we didn't have the required upstream support for it.

Patches based on alistair/riscv-to-apply.next.


Changes from v2:
- patch 1 (new):
  - allow CPUs other than 'bare' to assign profiles
- patch 2 (former 1):
  - added RVA23 profile support in the rvsp-ref CPU
- patch 3 (former 2):
  - hw/riscv/Kconfig changes:
    * added 'default y' in hw/riscv/Kconfig to build the board by default
    * added 'depends on RISCV64' to prevent the board to be built for qemu-system-riscv32

  - HMP qtest fixes:
    * added rvsp_aclint_allowed(). Use it instead of (!tcg_enabled()) when checking aclint support

  - changes in rvsp_ref_machine_done():
    * added 'RISCVBootInfo boot_info' struct
    * changed riscv_find_and_load_firmware(), riscv_calc_kernel_start_addr(),
      riscv_load_kernel() and riscv_compute_fdt_addr() to use boot_info

  - added "hw/char/serial-mm.h" include
  - changed 'addr' mem variables to 'hwaddr'
  - use HWADDR_PRIx format with 'addr' variables
  - changed GPEX_NUM_IRQS to PCI_NUM_PINS

- patch 4 (new):
  - add riscv-iommu-sys platform device
- v2 link: https://lore.kernel.org/qemu-riscv/20240312135222.3187945-1-fei2.wu@intel.com/


[1] https://lore.kernel.org/qemu-riscv/20240312135222.3187945-1-fei2.wu@intel.com/
[2] https://lore.kernel.org/qemu-riscv/CAHBxVyG186Zo7nAm7o8=vhBtzU+x8ry4_mWwHxuaZ8BasnDyPg@mail.gmail.com/

Daniel Henrique Barboza (2):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  hw/riscv/server_platform_ref.c: add riscv-iommu-sys

Fei Wu (2):
  target/riscv: Add server platform reference cpu
  hw/riscv: Add server platform reference machine

 configs/devices/riscv64-softmmu/default.mak |    1 +
 hw/riscv/Kconfig                            |   15 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1346 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   12 +-
 6 files changed, 1375 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/server_platform_ref.c

-- 
2.49.0


