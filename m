Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED208CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9EJ-0004hj-OS; Fri, 09 Oct 2026 07:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EF-0004fA-MB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:35 -0400
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EC-0001V1-3A
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:35 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=PN0MwabTWdHDK05npWgcgVp7NlQKE7gBOn9MMfY0TpU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791547048; v=1; x=1792151848;
 b=CMwns47XeBA/UhSBNk/CNXgz+HTx6DcPft4KYFnQfMsavQ2pfJmbwv1VqfoAvPWi0mtWA4QS
 p5yy+DhBA2ZkJlF7/2+EXeerKTyBuea12HG7yXuCwuKZ6q6yQ0U1rK1ASKz59qobVjJbyYk/xMR
 op8CDB1bB9S9S665D0KEiG5E=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 16d55751bf6ed352;
 Fri, 09 Oct 2026 11:57:28 +0000
X-Mizu-Trace-ID: 16d55751bf6ed352
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 0/4] target/arm: Fix the TTBR table base address in its
 52-bit layout
Date: Fri,  9 Oct 2026 12:57:24 +0100
Message-Id: <20261009115728.1299384-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::b0;
 envelope-from=fuad.tabba@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi folks,

Changes since v2 [1]:
  - Each fix is now followed by its own test, and the test description
    moved from the commit message into the file header. (Gustavo)
  - Clarified the stage 2 comment in the test. (Gustavo)
  - Noted that RAM_BASE matches the address kernel.ld links the test
    at. (Gustavo)
  - Collected Reviewed-by from Gustavo on all patches. (thanks!)

Two fixes to how get_phys_addr_lpae() forms the initial table base
address when TTBR uses its 52-bit layout, each followed by a TCG test.

The first stops TTBR[5:4] leaking into the base address of a table
smaller than 64 bytes. KVM's page_fault_test hangs on it under TCG in
its 16KB, 52-bit PA guest mode. Itaru reported the 16KB hang on kvmarm
last year [2].

The second uses the 52-bit layout whenever TCR.DS is set, as the
architecture does, where QEMU used it only with a 52-bit OA. With a
smaller OA a non-zero TTBR[5:2] is then an Address size fault.

Based on QEMU master (f7ada39eda).

Cheers,
/fuad

[1] https://lore.kernel.org/r/20261007080019.350315-1-fuad.tabba@linux.dev
[2] https://lore.kernel.org/r/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev

Fuad Tabba (4):
  target/arm: Clear TTBR[5:0] from a 52-bit table base address
  tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
  target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
  tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA

 target/arm/ptw.c                      |  18 ++-
 tests/tcg/aarch64/system/meson.build  |   6 +
 tests/tcg/aarch64/system/ttbr-baddr.c | 208 ++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c


base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
-- 
2.39.5


