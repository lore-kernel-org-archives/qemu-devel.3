Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F30C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBDj-0008Rx-Sj; Mon, 19 Aug 2024 18:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDh-0008Pj-Vh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:25 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDf-0000fN-4g
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-371a6fcd863so1711983f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107878; x=1724712678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LTxzfu4OzZbTIB6pGjbGlQ0NpMxgXsa11tKEn0g5Iic=;
 b=AUOTZ5M+grP4FNfGDG0ajCdQWE5PNKSpwmWZLUZz3Aw9C8eonWM8XIDEiuTbbivkbo
 oZBda2772QYw2b0b4qnoqhzKR5OMlXBw9OyjteN9f1C8JqOsp1WAg1EQ7WN3i0E9v+BI
 cGwvTYsireci2qsZAmidM0T9Eb+qzF2yD7Q5iKJLJ+sy+hYLKVrvjEnOd+H0THqk2FzO
 qLN5s2m0Fwfedtb7FaATVsMD9ig0VjXcG3sCx2c4lwY73a1ipF9XadUn0PfAaLcoCOS7
 nj/73D1vh7JpFR8vRmekGiGsRoybpKkJ52sCJIw4cKk2kA/4SrCqOeoZKz8DEpJin/19
 wgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107878; x=1724712678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTxzfu4OzZbTIB6pGjbGlQ0NpMxgXsa11tKEn0g5Iic=;
 b=t/YfOaBpfLwMxZ56PjnqYLVpCWMh3nS+hc71CXr465x4BoUwg2Wbw84BmSULHYH+fP
 DjFB0NOgF9PicW9o4Wm5n4ZCjlxluqF1auwI8pjwVArQX6Wn03Bofv/xiheyY7a87erb
 FbghjXDUX2k69MYOwmDN2ykHlRXINrhTEhU3BsuH0BEN1HvlCxrN9rUdmtVUUcbjyVVN
 AwpwrcuuxgPHB9yNHn5Nms7LBmscgSAR1DrqxMjZ+nvpkGsFLkRlPBzNomqxdUCJ18rO
 PHgB35GdDBeDvkcRHyWLsRFFvPY4doQCgqu1OZbh8QpQEvv5YOhbeHACrv0h9NiWazP8
 ZHvg==
X-Gm-Message-State: AOJu0YzDdoWnoSTpcVF667BkNCO/VNXjaD3itA+WbcQ2d4Er4+TkeO4l
 A/OFCCbU2pdJ01QpAcNExUhWkse2lyOlYWRbdyVuTzkn11OABnrp2cdIlMNhDhQJfB2o6pctroh
 xncI=
X-Google-Smtp-Source: AGHT+IHUYDRbPupBiCPyijNQShdDrpcYYKpLgvOUpme46z+7ICLncmlrwFlhOQ9aUu+qRnJ3/sKc7A==
X-Received: by 2002:adf:fc8a:0:b0:367:f104:d9e8 with SMTP id
 ffacd0b85a97d-371946a9afbmr7143089f8f.47.1724107878448; 
 Mon, 19 Aug 2024 15:51:18 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aada4sm11491670f8f.94.2024.08.19.15.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/20] Misc fixes for 2024-08-20
Date: Tue, 20 Aug 2024 00:50:56 +0200
Message-ID: <20240819225116.17928-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ecdfa31beb1f7616091bedba79dfdf9ee525ed9d:

  Merge tag 'pull-request-2024-08-16' of https://gitlab.com/thuth/qemu into staging (2024-08-16 18:18:27 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240820

for you to fetch changes up to 87e012f29f2e47dcd8c385ff8bb8188f9e06d4ea:

  crypto/tlscredspsk: Free username on finalize (2024-08-20 00:49:14 +0200)

Ignored checkpatch warning:

  WARNING: line over 80 characters
  #115: FILE: target/mips/tcg/sysemu/tlb_helper.c:713:
  +    MemOp native_op = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? MO_32 : MO_64;

----------------------------------------------------------------
Various fixes

- Null pointer dereference in IPI IOCSR (Jiaxun)
- Correct '-smbios type=4' in man page (Heinrich)
- Use correct MMU index in MIPS get_pte (Phil)
- Reset MPQEMU remote message using device_cold_reset (Peter)
- Update linux-user MIPS CPU list (Phil)
- Do not let exec_command read console if no pattern to wait for (Nick)
- Remove shadowed declaration warning (Pierrick)
- Restrict STQF opcode to SPARC V9 (Richard)
- Add missing Kconfig dependency for POWERNV ISA serial port (Bernhard)
- Do not allow vmport device without i8042 PS/2 controller (Kamil)
- Fix QCryptoTLSCredsPSK leak (Peter)

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/ppc/Kconfig: Add missing SERIAL_ISA dependency to POWERNV machine

Heinrich Schuchardt (1):
  qemu-options.hx: correct formatting -smbios type=4

Jiaxun Yang (2):
  hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
  hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection

Kamil Szczęk (2):
  hw/i386/pc: Unify vmport=auto handling
  hw/i386/pc: Ensure vmport prerequisites are fulfilled

Nicholas Piggin (2):
  tests/avocado: exec_command should not consume console output
  tests/avocado: Mark ppc_hv_tests.py as non-flaky after fixed console
    interaction

Peter Maydell (3):
  hw/dma/xilinx_axidma: Use semicolon at end of statement, not comma
  hw/remote/message.c: Don't directly invoke DeviceClass:reset
  crypto/tlscredspsk: Free username on finalize

Philippe Mathieu-Daudé (7):
  target/mips: Pass page table entry size as MemOp to get_pte()
  target/mips: Use correct MMU index in get_pte()
  target/mips: Load PTE as DATA
  linux-user/mips: Do not try to use removed R5900 CPU
  linux-user/mips: Select Octeon68XX CPU for Octeon binaries
  linux-user/mips: Select MIPS64R2-generic for Rel2 binaries
  linux-user/mips: Select Loongson CPU for Loongson binaries

Pierrick Bouvier (1):
  contrib/plugins/execlog: Fix shadowed declaration warning

Richard Henderson (1):
  target/sparc: Restrict STQF to sparcv9

 linux-user/mips/target_elf.h           |  3 --
 linux-user/mips64/target_elf.h         | 24 +++++++--
 target/sparc/insns.decode              |  2 +-
 contrib/plugins/execlog.c              |  4 +-
 crypto/tlscredspsk.c                   |  1 +
 hw/dma/xilinx_axidma.c                 |  2 +-
 hw/i386/pc.c                           | 14 +++++-
 hw/i386/pc_piix.c                      |  5 --
 hw/i386/pc_q35.c                       |  5 --
 hw/mips/loongson3_virt.c               |  5 +-
 hw/remote/message.c                    |  5 +-
 target/mips/tcg/sysemu/tlb_helper.c    | 69 +++++++++++++-------------
 target/sparc/translate.c               |  2 +-
 hw/ppc/Kconfig                         |  1 +
 qemu-options.hx                        |  6 +--
 tests/avocado/avocado_qemu/__init__.py |  7 +++
 tests/avocado/ppc_hv_tests.py          |  1 -
 17 files changed, 89 insertions(+), 67 deletions(-)

-- 
2.45.2


