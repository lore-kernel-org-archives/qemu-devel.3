Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA929CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 03:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcx6m-0005V2-NI; Thu, 25 Jun 2026 23:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wcx6L-0005TO-6T; Thu, 25 Jun 2026 23:19:34 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wcx6H-0000wm-4f; Thu, 25 Jun 2026 23:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782443952; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=d6bdfkYHw18MNE5AEJW/5Zb8GlA89KYnZMTopAkUvq4=;
 b=u6Rn5rsRSjO85L1TG4K2AjdgDJWN0u7N/OlFkyGbFlNi+KHof2/oREqH05gnWgnxSVAG3muxcodA3tNtf1CfrcgpskTv0YblhTqqKU7qJU/KNEL877vFR3nbAJyeNd5jdBKLnhDpqz7JIWTNIwbYmCQSFm0JU5IdOywZsq7IQzU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X5dK-aa_1782443635; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X5dK-aa_1782443635 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 11:13:58 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH 0/2] disas/riscv: Fix XThead immediate disassembly
Date: Fri, 26 Jun 2026 11:13:21 +0800
Message-Id: <20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLuPWoC/x2NQQqEMAwAvyI5G6jdpaBfEQ+xiWsuVRqRQvHvl
 j0ODDMVTLKKwdRVyHKr6ZEaDH0Hcaf0E1RuDN754IL/4PpFViPDcu1CjJsWzGrxxiTlwhhoC+R
 G9hyhRc4szfgP5uV5XmWVW6NwAAAA
X-Change-ID: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782443638; l=945;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=M4UM2nY7BK3k57aNhxsDEQU/c3Ef1TUWDpY282mdkZA=;
 b=n8dm6QUgPXTg81x4LV7IEcEoQiJJUa64hj7Er+7Yq+zjzLvOpId93w/WDI1bj8UGz5yc2/V0/
 oja5M0loioDD0b7QTQv91ezb7cCgj7E3meHnv/NN7rYZLBj14D3Xdj1
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Fix two XThead immediate decoding issues in the RISC-V disassembler.

The first patch aligns th.srri decoding with target/riscv/xthead.decode:
th_srri uses bits 31:26 as 000100 and bit 25 as shamt[5], while the
disassembler switches on bits 31:25.

The second patch extracts the full 6-bit immediate field for
rv_codec_r2_imm6, which fixes the immediate printed for th.srri and
th.tst.

This series is based on Alistair's riscv-to-apply.next branch:
05f8cb49b0f0 ("hw/riscv: add create_fdt_plic() helper")

---
TANG Tiancheng (2):
      disas/riscv: Fix th.srri decoding
      disas/riscv: Fix 6-bit immediate extraction

 disas/riscv-xthead.c | 6 ++++--
 disas/riscv.c        | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)
---
base-commit: 05f8cb49b0f02312abd34a019ff38b2c7c466a40
change-id: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


