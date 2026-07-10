Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9868DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4Qv-00018i-Fl; Fri, 10 Jul 2026 02:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4QW-00011y-AU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4QU-0001sS-R7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so5411045ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663769; x=1784268569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wB9IkbLd+/9g26Wp85Xdso+vR8MxlYjkBJN19PJbQeo=;
 b=KSkJmehoADmEhvkjWM6gQLTWWQlJfwxvAvy9hwjLgAA/9wYK9W0hBD7fjhVgH0NzLT
 qB39aohggusuLMC98V7gX/K+gaK6IZLqFcVtymLIXNdPIZ1XSItGkdzb26qOpG/Zyh+k
 l8sGjrJXXTrIIR7/1Ut5WGXyhDszeqWhaIT5lgHmM3ai/WTAK1eK+ZH9uQnGX2b9A6qj
 Opv5gHBEpK3zjlETkIhE3xUBIN0rwhAmzHMWa3j5R3HiRIoxwDe8ad74qtqfGzTA8KFx
 95JMeCBW+4AvSL4C9tFJdW3Ks+psbPsrGdnKSWUmkHsO+ET+QG/IAeb+ZdiWwJo0w3F1
 M6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663769; x=1784268569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wB9IkbLd+/9g26Wp85Xdso+vR8MxlYjkBJN19PJbQeo=;
 b=dk/AeUoaL+NxfVOnGKvipNeJ0FCDS2vWaxFFyiZ27R5zRJktiZO/bPRKCkL/tBrhp9
 WnGyvgvcMJQkT9BpHpMNyKnLwU2kOKWm17qGMeTjErZ2aa7dJ0T1lPiaNo9o02b4tQJ7
 WRyks8VIfGXPyYGAXr/iQF5akNKJTX3ngMtSZklHrQchJWCTbeLOA18wCSbre1mzjvD4
 5nj+rjie8hY9pvUW9W0jsRHNzE8RDmGiSm+pQUILh81IoEF1/xRHRXDlkeUq3uYJbt6X
 KToj3DZFQ1MeMDqzVfg2Sok0b86N6KTiXJHDXw8u9k+o5qleiNFHV7Z6QIsrGBHXJj/g
 e7/Q==
X-Gm-Message-State: AOJu0YyVLcEecyDw2aYWmVtsZ/fI5XnF7H4cgJ1a2azg67XWkRZqFwU/
 yu45cEd6Rrt3rfAnR0RVLYfjLsFh8gX7rMx5SXKjSfID/evcTu44yQymUJtVWR88/t5FW+OLzJ6
 Y9DvgCgEnpDqMWN6jg6Pe8D5pqC1ec6q704OioBPjEhrt2mWfacC0PtpjQE98LcG8/7nXf4Enu8
 QPgYZlDD+sLFha1AzKhplM8kZd18ydVA4H/YRsZwZdb7KEZ+tR
X-Gm-Gg: AfdE7cnMGDRtXGAuYKv27qov3Eb38B93Qpqou6vIjdqykDaR3UgSUq2y0pjs/2+loM9
 E+B8d2JoOluAKiU0MIO6z3+exsmR/qFFkm0KeqhsD3ooVlrTd+mrzMBoQ+9/3GP4QWlc2DP/3FK
 h+N3oSmlPGdt7HjXQkDpcpZFN3NR+aMDrX3h+YJeFsZTRPaW/d7JY9RefdxZF5ud8NgI11pSEw8
 wKbQ+4HjC6adZLhFUy5ms1miKuhoEaQ8muIcFDuoxefBO11NQMBvou+GDJds0XddAqKpEngc6/G
 1WUc9w3z/QlhOWoreEpjWMpblteEiUmnbDF5bBSUNj30HnWakY6fIkeC35hG2z6va2tG0dro20k
 DN1NhwUZiuS6Rvr02LKHoO/ZnWRt87/h+ddq+z3xSvguxVCGGrIXwaal4Oqn8S97FGRY78oeim4
 Vi55ViKPMgbtGl2GQZ0Q3sJCv6HqsGzjIy5WqyaESncyIb7HIZRg==
X-Received: by 2002:a17:902:e744:b0:2cc:f4d4:29a9 with SMTP id
 d9443c01a7336-2ccf4d46beamr95380495ad.23.1783663769020; 
 Thu, 09 Jul 2026 23:09:29 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 0/7] target/riscv: Support the true Zicclsm extension
Date: Fri, 10 Jul 2026 14:09:07 +0800
Message-ID: <20260710060914.1227027-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x633.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Support the true Zicclsm extension so that we can trap misaligned accesses
when Zicclsm is disabled.

To enable/disable Zicclsm, simply set zicclsm=[true|false], e.g.:
  -cpu rv64,zicclsm=[true|false]

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions if Zicclsm is disabled.

Changelog:
  v5:
    * Add Zicclsm to RVA22U64 profile explicitly.
    * Rebase to the latest riscv-to-apply.next.
  v4:
    * Align ROM reset vector data at 8-byte aligned offsets.
  v3:
    * Enable Zicclsm for the compatible CPUs.
    * Rebase to the latest riscv-to-apply.next.
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (7):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Enable Zicclsm for the compatible CPUs
  hw/riscv: sifive_u: Align ROM reset vector data
  target/riscv: Update Zicclsm ISA string and expose it as a CPU
    property
  target/riscv: Enable Zicclsm for RVA22U64 profile

 hw/riscv/sifive_u.c                         | 11 ++--
 target/riscv/cpu.c                          | 10 +++-
 target/riscv/cpu_cfg_fields.h.inc           |  2 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc |  6 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 18 +++++-
 target/riscv/tcg/vector_helper.c            | 65 ++++++++++++++++-----
 6 files changed, 88 insertions(+), 24 deletions(-)

--
2.43.0


