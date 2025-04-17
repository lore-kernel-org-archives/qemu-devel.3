Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5893C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TDz-0003RH-7t; Thu, 17 Apr 2025 13:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u5T8J-00052B-HT
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:40 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u5T8G-0001oI-Ss
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:39 -0400
DKIM-Signature: a=rsa-sha256; bh=1alVMVzEHLAhq5deO0v4DqIGavUQZMrifIxIYlWXXqs=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1744911270; v=1;
 b=NauaODuPdQTv9GbyddDesNzoV0OV8OCl0axVyTc77dJm/AbxiofkXks30nKKorR+oIh/wdiA
 n+8EMumGiiEOk1DNktdrnAVT/fvhzZHbnZ4TqQo0KjHPIuz2rJaJyy7eOx1JG3/2x4bdLH2O+Kg
 7Wqn1jjbk0n66vNqs6LI5tKrDPYgweNXrUcP5Mc6Z0cboP4U6XXVCQ2TS6W0iAuAQ+w6c2lnTon
 JUCnx1pewFPsGNnurg0k0NprKSz+RNePHthz9Sa81h/LtBGuSBLjJNBhKTFYYx2amhYXeEOQvsC
 k7vk+yj81Zxmit+g9JP7mGBrJoX4Cu5ySVLWH6VX7KpSg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 12AF821209;
 Thu, 17 Apr 2025 17:34:30 +0000 (UTC)
From: ~percival_foss <percival_foss@git.sr.ht>
Date: Thu, 17 Apr 2025 17:34:30 +0000
Subject: [PATCH qemu 0/2] Bugfix: TCG cross-page overflow for 32 bit guest
MIME-Version: 1.0
Message-ID: <174491127002.20547.8069526486864738611-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Apr 2025 13:39:18 -0400
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
Reply-To: ~percival_foss <foss@percivaleng.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The bug being resolved is that the current code in mmu_lookup() assumes
a valid 64-bit address space. If a guest has a 32-bit address space, a
page translation that crosses beyond the last page in the address space
will overflow out of the allocated guest virtual memory space in the
QEMU application and cause it to crash. In this case the first page will
be the last of the 32-bit address space (for example 0xFFFFF000 for 4K
page sizes) and the second page will overflow to a page beyond the
32-bit address space (0x100000000 in the very same example). An invalid
translation will be added to the cpu translation table from the second
page. Thought the translation will be for page address 0x100000000,
checks in other parts of the codebase actually enforce using only 32
bits, and will match this translation. Part of the stored translation is
the effective address, and another part is the addend to be used to
offset into the QEMU process's virtual memory space. The addend will
incorporate the 0x100000000 and offset into likely invalid virtual
address space.

The fix in the diff checks if the target is 32 bits and wraps the second
page address to the beginning of the memory space. Along with this we
have submitted a test to show this using Pegasos2

Singed off by: Percival Engineering <foss@percivalemg.com>

foss@percivaleng.com (2):
  Fix: TCG cross-page overflow for 32 bit guest
  Added TCG cross-page overflow test

 accel/tcg/cputlb.c                    |  7 +++
 tests/functional/meson.build          |  1 +
 tests/functional/test_ppc_pegasos2.py | 69 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100755 tests/functional/test_ppc_pegasos2.py

-- 
2.45.3

