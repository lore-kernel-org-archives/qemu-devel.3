Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2498CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENpo-0001Gd-0M; Wed, 07 Oct 2026 05:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEMZu-0004LL-Lb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:00:50 -0400
Received: from out-49.mta1.migadu.com ([2001:41d0:203:375::31]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEMZs-0002z3-DA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:00:42 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=2/kaVNSd+1MEGlI5kPoIW6AEPjZTNC998YwNqq37mSk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791360038; v=1; x=1791964838;
 b=oNZtDks0OCIkh+LTbSVRTUPD9CkYl3uV4/iFynbZxWJ3g8zID1uYuiZ9zsCm+yfP7EBCdE+i
 nT90rTMcrtbWbiq0gtBhFubNlx/OvhYpoNLUzEqFRaRISJue14NVoYbCld+Ck3nU/mnBXYr7f5w
 B5rSiwWBvN6cEqJ+7AZ/AIbo=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id e79c6b7ef898ed58;
 Wed, 07 Oct 2026 08:00:24 +0000
X-Mizu-Trace-ID: e79c6b7ef898ed58
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 0/3] target/arm: Fix the TTBR table base address in its
 52-bit layout
Date: Wed,  7 Oct 2026 09:00:16 +0100
Message-Id: <20261007080019.350315-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::31;
 envelope-from=fuad.tabba@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes since v1 [1]:
  - Moved the test into its own patch, after the two fixes. (Gustavo)
  - Various fixes. (Peter, Gustavo)

Two fixes to how get_phys_addr_lpae() forms the initial table base
address when TTBR uses its 52-bit layout, then a TCG test for both.

The first stops TTBR[5:4] leaking into the base address of a table
smaller than 64 bytes. KVM's page_fault_test hangs on it under TCG in
its 16KB, 52-bit PA guest mode. Itaru reported the 16KB hang on kvmarm
last year [2].

The second uses the 52-bit layout whenever TCR.DS is set, as the
architecture does, not only with a 52-bit OA. With a smaller OA a
non-zero TTBR[5:2] is then an Address size fault.

Based on QEMU master (f7ada39eda).

Cheers,
/fuad

[1] https://msgid.link/20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev
[2] https://msgid.link/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev

Fuad Tabba (3):
  target/arm: Clear TTBR[5:0] from a 52-bit table base address
  target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
  tests/tcg/aarch64: Add a test for the 52-bit TTBR base address layout

 target/arm/ptw.c                      |  18 ++-
 tests/tcg/aarch64/system/meson.build  |   6 +
 tests/tcg/aarch64/system/ttbr-baddr.c | 197 ++++++++++++++++++++++++++
 3 files changed, 215 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c

-- 
2.39.5


