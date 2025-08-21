Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED30FCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5JH-00010R-4Q; Thu, 21 Aug 2025 09:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3Yb-00076u-D7; Thu, 21 Aug 2025 07:34:13 -0400
Received: from forward102b.mail.yandex.net ([178.154.239.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3YP-0008Kb-Q7; Thu, 21 Aug 2025 07:34:13 -0400
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ba25:0:640:6c71:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id 88AD6C000C;
 Thu, 21 Aug 2025 14:33:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id mXRF5KIMdSw0-0ZdVt28a; 
 Thu, 21 Aug 2025 14:33:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1755776029; bh=G3ViggugQ8qomgN3xkzVgRBllh21tCe6pvb8AcFdO98=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=CuPfvIA2AYhDEDm19NAmgJj/zcr1FlJKhVj9k40qO/vPLbQoG22k+ncFwBdw4SE47
 CYCBJ3Q1DW5izS9dRnRj47QtLA5KOlIg1VG2V6tGEbo2mWetYW/xGvmKSDO0a7Qz29
 /NmAbB+wagHN6JemkUhF2MY3MQMqhn5hLgcOf6/M=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH 0/3] Add support for PowerPC e500 little-endian pages
Date: Thu, 21 Aug 2025 14:33:44 +0300
Message-ID: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.149;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward102b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Aug 2025 09:26:26 -0400
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

These changes make powerpc booke206 mmu pass TLB_BSWAP flag for pages marked as LE, and also fixes all the issues this causes.
 - added TLB_BSWAP to non-MMIO flags
 - inserted additional check for LE page when bswap-ing instructions
 - removed assert for cross-page TLB_BSWAP accesses
 - added gdbstub fix to account for TLB_BSWAP of the currently running code

BE- and LE- atomic operations (used by load-and-reserve and store-conditional instructions) were unified to support TLB_BSWAP

Some of the fixes are based on what is done in https://github.com/YetAnotherMod/qemu

Danila Zhebryakov (3):
  accel/tcg: Unify big- and little- endian atomic ops
  target/ppc: Add support for LE pages on PowerPC booke206 mmu
  target/ppc: fix GDB stub to work correctly with LE pages

 accel/tcg/atomic_common.c.inc       |  27 +--
 accel/tcg/atomic_template.h         | 246 +++++++++-------------------
 accel/tcg/cputlb.c                  |  22 ++-
 accel/tcg/tcg-runtime.h             |  36 +---
 accel/tcg/user-exec.c               |   2 +-
 include/accel/tcg/cpu-ldst-common.h |  39 ++---
 target/m68k/op_helper.c             |   4 +-
 target/ppc/cpu.h                    |   4 +
 target/ppc/gdbstub.c                |  17 +-
 target/ppc/mmu-booke.c              |   5 +
 target/ppc/mmu_helper.c             |  17 +-
 target/ppc/translate.c              |  29 +++-
 target/s390x/tcg/mem_helper.c       |   6 +-
 tcg/tcg-op-ldst.c                   |  31 ++--
 14 files changed, 204 insertions(+), 281 deletions(-)

-- 
2.47.2


