Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5585CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3cj-0004nw-ND; Wed, 13 May 2026 03:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wN3ch-0004mX-5y; Wed, 13 May 2026 03:03:15 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wN3ca-0006l3-7H; Wed, 13 May 2026 03:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hd
 0UQ5/B5eREGHAPZ+t1WssmOKcS5aSWLfnCcSDoRmk=; b=cLsV1r1fsHkBlxXw0G
 +dPMJCXTd7clVsYaBsNKnScPeUbVg59XSQKF0uiF876N5Lg50xR3RqLWwIb4cpm1
 NeD8PIMHROBkY0CPzZp2eESushYzGFTsJYK7mhLNZo5GD5MUe7IQ6SaowIkAnhAc
 nMCZ9AnaxS04GYe4eT8cSYaQU=
Received: from thinkpadx13gen2i.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDXD0f+IQRqW951BA--.20095S2; 
 Wed, 13 May 2026 15:02:22 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: daniel.barboza@oss.qualcomm.com, alistair.francis@wdc.com,
 chao.liu.zevorn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH v2 0/2] Add KVM support for Zicbop and BFloat16 extensions
Date: Wed, 13 May 2026 15:02:09 +0800
Message-Id: <cover.1778653159.git.zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <88318c83-e8be-4b0e-8499-039203d1bf79@oss.qualcomm.com>
References: <88318c83-e8be-4b0e-8499-039203d1bf79@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXD0f+IQRqW951BA--.20095S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWF47KrW5Zr4kZr1DJryUAwb_yoWxWFX_Ca
 yFgrWkJ34jqa4jgayUta15Gr93GrZY9F4Ut3ZrtF4UJFy3WryrJwn8J3yUJr4j9FW8WrnY
 ywnrXFnakFy2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjMGQPUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC9B4jzmoEIf7VgAAA3j
Received-SPF: pass client-ip=117.135.210.5; envelope-from=min_halo@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

This series adds KVM support for the following RISC-V ISA extensions:
- Zicbop: Cache-Block Prefetch Operations
- Zfbfmin, Zvfbfmin, Zvfbfwma: BFloat16 extensions

Changes in v2:
- Patch 1: Removed Zicbop from legacy KVM extension reading path since
  the extension did not exist in older kernels. (Daniel Henrique Barboza)

Zongmin Zhou (2):
  target/riscv/kvm: add KVM support for Zicbop extension
  target/riscv/kvm: Add BFloat16 extensions support

 target/riscv/kvm/kvm-cpu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

-- 
2.43.0


