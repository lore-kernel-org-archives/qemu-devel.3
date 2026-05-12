Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE39BCD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcox-0000aD-Md; Mon, 11 May 2026 22:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wMcov-0000Vn-Dv; Mon, 11 May 2026 22:26:05 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wMcoq-0007bB-Ae; Mon, 11 May 2026 22:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6a
 2VOfjXuwjEu1vbo0CJEX53WNfuGh6UXfB7VOXx5jw=; b=ZSptSgO3G2yHMogfgi
 CXiweH6EDX1Tz5VRb3ba9IJFa1hO5hpVEl7kuewYmIGRIQmdXiFliTxPUrgCN51a
 Fw0i5SWvMm1BMqmQR5furquoohzd5IjFNuO+AgjttW66NrctG55YcdubvLYCmKfD
 s+3Mv+EAdMvtElb14aWuTti3o=
Received: from thinkpadx13gen2i.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wCntZKfjwJqqjd+Aw--.60433S2; 
 Tue, 12 May 2026 10:25:36 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH 0/2] Add KVM support for Zicbop and BFloat16 extensions
Date: Tue, 12 May 2026 10:25:18 +0800
Message-Id: <cover.1778551633.git.zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCntZKfjwJqqjd+Aw--.60433S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzpnQDUUUU
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0gAn0moCj6Du0QAA3f
Received-SPF: pass client-ip=220.197.31.5; envelope-from=min_halo@163.com;
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

Zongmin Zhou (2):
  target/riscv/kvm: add KVM support for Zicbop extension
  target/riscv/kvm: Add BFloat16 extensions support

 target/riscv/kvm/kvm-cpu.c | 41 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

-- 
2.43.0


