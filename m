Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B79C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8d8A-0003l6-Fp; Mon, 21 Sep 2026 08:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yhu-0006aq-Na
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:44:58 -0400
Received: from out-53.mta1.migadu.com ([95.215.58.53] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yhs-00065g-KP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:44:58 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=HPrcY/81vbNRkJxRpf4sM4FPQJUpqNi/n2xWmr9Iu8c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789976691; v=1; x=1790581491;
 b=D1N0aGpt9qYCNumjYbnziGwoup6KYgtobbI/zcUgALBIcHMJ/3u3HlzFXihql1LzRZG75F2S
 rRi+ssG5vAqFGrAg4KGli6z9PYiVi2nunrSzqxV8y5Q3mEl8jLKDnVpsfl0FdI9uY6H+LbkWWLR
 lVvwqVPHAgvGkf521gqFWpZg=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 58338df02f784dc0;
 Mon, 21 Sep 2026 07:44:51 +0000
X-Mizu-Trace-ID: 58338df02f784dc0
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: [PATCH 0/2] target/arm: Fix timer deadlines when the offset puts the
 count ahead
Date: Mon, 21 Sep 2026 08:44:49 +0100
Message-Id: <20260921074451.3158645-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.53; envelope-from=fuad.tabba@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:27:51 -0400
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

Two fixes for the same bug in three places: the next-tick calculation
for the generic timers, WFIT and WFET each treat a 64-bit overflow of
cval + offset (or timeout + offset) as a deadline beyond the counter's
wrap. Once CNTVOFF_EL2 (or CNTPOFF_EL2 for the physical timer) puts
the timer's view of the counter ahead of the physical count, that sum
overflows for every deadline still in the future and QEMU arms the
timer at INT64_MAX. The first site regressed in 8.2 (8d37a1425b99).
The WFxT sites have the same overflow test.

The KVM arch_timer_edge_cases selftest, which sets the guest counter
to 2^59 - 1, hangs in every host mode on QEMU 11.0.0 and passes on
hardware under an nVHE host. With patch 1 it completes under nVHE and
pKVM hosts. Under a VHE host its physical-timer half still stops, on a
KVM bug in the same arithmetic (KVM programs cval + offset where the
timer compares unsigned). That fix goes to kvmarm separately.

Each patch adds a tcg system test that fails before it and passes
after.

Based on master (3b5d71cc36).

Cheers,
/fuad

Fuad Tabba (2):
  target/arm: Fix next timer tick when the offset puts the count ahead
  target/arm: Fix WFxT timeouts when the offset puts the count ahead

 target/arm/helper.c                  |   9 +-
 target/arm/tcg/op_helper.c           |   6 +-
 tests/tcg/aarch64/system/meson.build |   7 ++
 tests/tcg/aarch64/system/vtimer.c    |  28 +++++++
 tests/tcg/aarch64/system/wfxt.c      | 118 +++++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/wfxt.c

-- 
2.39.5


