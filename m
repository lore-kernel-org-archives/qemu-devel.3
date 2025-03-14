Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CCFC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0cT-0002JI-I8; Fri, 14 Mar 2025 04:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tt0cR-0002IC-JO
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:42:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tt0cM-0007HF-2g
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:42:15 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxlnDZ69NnqTyWAA--.58422S3;
 Fri, 14 Mar 2025 16:42:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxb8fZ69NnIYlKAA--.13771S2;
 Fri, 14 Mar 2025 16:42:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/3] target/loongarch: Solve some issues reported from
 coccinelle
Date: Fri, 14 Mar 2025 16:41:58 +0800
Message-Id: <20250314084201.4182054-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fZ69NnIYlKAA--.13771S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch set solves errors reported by coccinelle tool with commands:
  spatch --sp-file scripts/coccinelle/*.cocci --dir target/loongarch/
  spatch --sp-file scripts/coccinelle/*.cocci --dir hw/loongarch/

The main problem is that qemu should fail to run when feature is forced
to enabled however KVM does not support it, rather than report error and
continue to run.

---
  v1 ... v2:
    1. Add fixes tag and change title with fix prefix in patch 1.
    2. Replace error_propagate() with error_setg(), and return directly
       for any error.
---
Bibo Mao (3):
  target/loongarch: Fix error handling of KVM feature checks
  hw/loongarch/virt: Remove unnecessary NULL pointer checking
  target/loongarch: Remove unnecessary temporary variable assignment

 hw/loongarch/virt.c               | 25 +++++++++++--------------
 target/loongarch/kvm/kvm.c        |  8 ++++++--
 target/loongarch/tcg/tlb_helper.c |  5 ++---
 3 files changed, 19 insertions(+), 19 deletions(-)


base-commit: 4c33c097f3a8a8093bcbaf097c3a178051e51b3e
-- 
2.39.3


