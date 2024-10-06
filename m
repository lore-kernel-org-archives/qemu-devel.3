Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A47CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 16:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxURg-0005zr-VI; Sun, 06 Oct 2024 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURe-0005zT-UW
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURc-0008Ap-Dh
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5BAC94E6013;
 Sun, 06 Oct 2024 18:49:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Dwi0N41WvtK9; Sun,  6 Oct 2024 18:49:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A3594E6001; Sun, 06 Oct 2024 18:49:12 +0200 (CEST)
Message-Id: <cover.1728232526.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/2] Separate memory access logs from guest_errors
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sun, 06 Oct 2024 18:49:12 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Originally memory access logs were a debug define that then were
converted to log messages but were classified as guest_errors which
already logs misc errors. As invalid memory access logs can come from
accessing not emulated peripherals or memory areas, these often
generate a lot of messages that are better be controlled separately
from other errors to avoid obscuring those. As an example try
'qemu-system-ppc -d guest_errors' to see the problem. After this
series the actual guest error logs are easier to spot. I've tried to
submit this before but there were some people who liked the current
behaviour so now this series has another patch that preserves the old
optino printing a warning to allow time to get used to the new
behaviour (which actually brings back the old behaviour when mem
access logs were a debug define).

Regards,
BALATON Zoltan

BALATON Zoltan (2):
  log: Add separate debug option for logging invalid memory accesses
  log: Suggest using -d guest_error,memaccess instead of guest_errors

 docs/devel/secure-coding-practices.rst | 2 +-
 include/qemu/log.h                     | 1 +
 system/memory.c                        | 6 +++---
 system/physmem.c                       | 2 +-
 tests/avocado/smmu.py                  | 2 +-
 tests/qtest/pnv-host-i2c-test.c        | 2 +-
 util/log.c                             | 8 +++++++-
 7 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.30.9


