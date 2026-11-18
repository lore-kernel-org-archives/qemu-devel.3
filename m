Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79542606A336
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l09gUee8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYr-0008J4-Ok; Wed, 18 Nov 2026 04:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYh-0008G3-P8; Wed, 18 Nov 2026 04:02:27 -0500
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-000426-Kn; Wed, 18 Nov 2026 04:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992516; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=5L+7KYs5PRs6ZkFpBvhPkCxAHoPX7eUs+/JRgq5BAgg=;
 b=l09gUee8yaEZRkd+5aWhvTixpwGWF6I8KPfRNA4y5eGQ98u3ZoyHW/f8yZ0v0+2wjC+B1Eo2fGuCSl1DLEXxUGdd8Sdgly/XffP39LTBBF9AulRR+BvB8p1aIgdOgxQ2sEzyUVaa/oiM6vTQU8eMiBrjgSy6D2mZ937sgXmdS5A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0GqhE_1794992515; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0GqhE_1794992515 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:55 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:28 +0800
Subject: [PATCH RFC 1/8] disas/riscv: Reject incomplete instruction reads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-1-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=1474;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=8s05OktAEJZbeNItduUsHh1R/umCaTg8A4jSnWbz1iY=;
 b=fmSJozOpTdQ3ZLaZ0Dr8V88VMhqS/hakXhJYXFmeIhPamGuNX5s+JR62nTEoKXpcTANIC0UvX
 KsisNJbxXyRCdosznoxzOW7aAc9roIPW28xCxUK/PIwn+lx4mpp5BaI
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a later parcel read fails, print_insn_riscv() decodes the available
bits with the missing bits left as zero. A truncated instruction can
therefore be displayed as a complete, unrelated instruction.

Report every failed required read at its actual address and return -1.
If the first 2-byte read fails, return -1 instead of the error code from
read_memory_func(). The disassembly loops would otherwise treat the
positive error code as an instruction length.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 disas/riscv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index ca0d6e90b37321e8c2b7ec07f3ae51f0797585cc..eb4851b4cd4b14a43cc6592bd5011c6df53ec219 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3510,12 +3510,8 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
     for (n = 0; n < len; n += 2) {
         status = (*info->read_memory_func)(memaddr + n, packet, 2, info);
         if (status != 0) {
-            /* Don't fail just because we fell off the end.  */
-            if (n > 0) {
-                break;
-            }
-            (*info->memory_error_func)(status, memaddr, info);
-            return status;
+            (*info->memory_error_func)(status, memaddr + n, info);
+            return -1;
         }
         inst |= ((rv_inst) bfd_getl16(packet)) << (8 * n);
         if (n == 0) {

-- 
2.43.0


