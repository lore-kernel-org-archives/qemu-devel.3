Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B272CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 07:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA156-0005fg-IF; Sat, 18 Oct 2025 03:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s76-0000Yw-IP
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:52 -0400
Received: from out-173.mta0.migadu.com ([91.218.175.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s72-0000uP-QD
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:35:52 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760736942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P1r4DoNWKlIOtYoVChyoLrmi81Lq5Mc/2Et3uPxqF1E=;
 b=TQrq6QbifzYMKxkJRLTukFPw/r3Sv2GUmYHoA9fjnZsGvTky9uupRj7FurAxZCW4wog01Z
 +ZnhRghVgd8X0+uM88Qj6i0MDwBJFO/3EuL3q0WxGf+19+qoS4AR/K7CASdHW1DiG4gzZV
 zD4xrojSMuC5gEGnpwnZ7EkpfiFsldU=
From: Sean Anderson <sean.anderson@linux.dev>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/3] semihosting: Fix a few semihosting bugs
Date: Fri, 17 Oct 2025 17:35:26 -0400
Message-Id: <20251017213529.998267-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.173;
 envelope-from=sean.anderson@linux.dev; helo=out-173.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Oct 2025 03:10:22 -0400
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

While discussing [1], it came to my attention that QEMU does not
properly truncate/error SYS_FLEN on 32-bit systems. Fix this, and some
other bugs with GDB File I/O that I found while working on this series.
That said, GDB File I/O has been substantially broken for two years now,
so it makes me wonder if anyone actually uses it! It would certainly
simplify the implementation if we didn't have to support it.

[1] https://lore.kernel.org/u-boot/20251017195322.GF6688@bill-the-cat/T/#m493c42570d3103b8c606c5f50faeb78d27719de6


Sean Anderson (3):
  gdbstub: Fix %s formatting
  semihosting: Fix GDB File-I/O FLEN
  semihosting: Check for overflow in FLEN on 32-bit systems

 gdbstub/syscalls.c            |  2 +-
 semihosting/arm-compat-semi.c | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


