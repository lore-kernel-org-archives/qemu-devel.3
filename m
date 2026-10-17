Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C63CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5a2-0002ev-4h; Sat, 17 Oct 2026 10:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5a0-0002dH-Af; Sat, 17 Oct 2026 10:40:12 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5Zx-0005Y0-Lx; Sat, 17 Oct 2026 10:40:12 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-05 (Coremail) with SMTP id zQCowAAnV0GxiNNqbs+wCw--.2747S2;
 Sat, 17 Oct 2026 22:39:55 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2 0/2] hw/riscv/riscv-iommu: reclaim invalidated IOATC entries
Date: Sat, 17 Oct 2026 22:39:41 +0800
Message-ID: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnV0GxiNNqbs+wCw--.2747S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW5trWfuF18uryrKr18AFb_yoWDurc_uF
 Z3ta429r4UJayUCF9rKF4rAryYyayUur1UtFykJr47uw17JFs8Aw4DKrsxXr18u3WfAFna
 yFykA3y8Ar12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
 4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
 W8JbIYCTnIWIevJa73UjIFyTuYvjfUrwIDUUUUU
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series changes selective IOTINVAL handling to remove matching entries
from the IOATC instead of leaving them in the hash table with IOMMU_NONE.

Patch 1 adds explicit serialization for IOATC accesses, providing the
entry lifetime protection needed before entries can be removed.

Patch 2 changes selective invalidation to remove matching entries. This
avoids repeatedly scanning invalid entries and prevents them from
contributing to the IOATC size limit.

The performance measurements are included in patch 2.

v2:
- Split the IOATC locking and invalidation changes into separate patches.
- Reduce the scope of iot_lock in the translation path.

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01606.html

Tan Chi (2):
  hw/riscv/riscv-iommu: serialize IOATC accesses
  hw/riscv/riscv-iommu: reclaim invalidated IOATC entries

 hw/riscv/riscv-iommu.c | 173 ++++++++++++++++++++---------------------
 hw/riscv/riscv-iommu.h |   1 +
 2 files changed, 87 insertions(+), 87 deletions(-)

-- 
2.53.0


