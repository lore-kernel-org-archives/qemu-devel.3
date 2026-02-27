Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436C1FEFB6A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Sy-0004OQ-8R; Fri, 27 Feb 2026 12:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw109-0004BW-BJ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:41 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw107-0004ON-Pi
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:41 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 8D00F1C00C2;
 Fri, 27 Feb 2026 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772210847; bh=xC4Sr1dNunbqSjkBIVUx1MbIhsovXY5hEIEGCj9FXR0=;
 h=From:Subject:Date:To:Cc:From;
 b=XHs3KOennaCRjzu/5Xi9KDDvr02O6UEM2Z345TRJCXLMFrX+Vy995Ku6Nzdnnf44l
 Xo0YslERkPwTQvthzW3rj3LoE3jn44qBWEa+j9zJHSs07dK2N/md9kwD7b1b5H9j6L
 jlOntrN605Z4ZBzv4YYdCyd6VuhAcpKE+zmY7U43CvBa//chvVrtULspCRMmluJmqa
 8gtAp+hLpinl4IEvJo6+Sm0Csi/b3mbq5WkhtEXtMNOewHXBMLwCUci6VNZ9hyUIXX
 WUulz0q680PnhM9zLMQd+u891M0rvVc30Oz7ubFC36zHg7Q/wsMIoqd0BSATZxhPab
 wPIXuBvjiumLKQbikw2eTDFzK4EDyj5g9VfDYyYaStY5mTdk1OiQUP1Y11nZRrUIgO
 guYu46l29SpCkuM1ecUlRAucTmPI482nxUiRJJAjWtVlRgDHwtcbyEwrV9b0dkVa8n
 gEPYWsIwZtSCcRq4QGFNVXXG4y3EJ3fdkeA7G+/3ANdyhWuLFisuMpx0ODIPiM4CbI
 mTHfBfn637o7BQyHziB0BcrzkFib0x62ssVnZ5/+T3sc0n8Wk7uHZDFMeDiN1kFjVw
 EFxC4PiB9quiJeJZeuCxnQtf0cjeYwH7IBTPz4Nrr8weCYH2Enn19Im+2XAWXYUZrV
 kM4uyDTj6ueNW4KuyHxf8C7A=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Aa1e0O-sXS8j; Fri, 27 Feb 2026 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Fri, 27 Feb 2026 16:47:18 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Subject: [PATCH 0/4] Fixes for unfixed mmap beyond reserved_va
Date: Sat, 28 Feb 2026 00:46:29 +0800
Message-Id: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAyA4VeRnA10OUy3V5Ed0i66wFqlEVGK7
 27x+B++v4BJVjF4NwWybGo6pxqPtoHw4zQJ6rc2kKOnI+qQ/WGGMfKCWf5z4LUKDMEzse9fjjx
 Uu2QZdb+/w+c8L4Uavt5nAAAA
X-Change-ID: 20260227-abyss-mmap-relocation-ccba2ab8902b
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=xtex@astrafall.org;
 h=from:subject:message-id; bh=GultX8RF4cywkU/8PVwklfSArfJmeBhJRSyeCpujixo=;
 b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDJkLT03smK/3IOdtSdXJerU8K5U3z3fbRf078XTm/BXiK
 UJs8tsud0xkYRDjYrAUU2QpMmzwZtVJ5xddVi4LM4eVCWSItEgDAwMDAwsDX25iXqmRjpGeqbah
 nqGhjpGOEQMXpwBMtVYzw//arNj5117viD9dKre9rO/1z215V9/pr5ycvm7iex72Y/sKGBnee4V
 JPHQtLBSv3X/hxJ3vjvXiPkvVZ9QacS4vObv9bjw/AA==
X-Developer-Key: i=xtex@astrafall.org; a=openpgp;
 fpr=7231804B052C670F15A6771DB918086ED8045B91
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 12:17:25 -0500
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

For reserved_va & ~MAP_FIXED mmap, linux-user and bsd-user translates it
into a fixed mmap within [mmap_min_addr, reserved_va]. However, the
previous implementation didn't care about where the address hint
provided by user is greater than reserved_va and will run into
an assertion failure.

This series fixed it for linux-user and bsd-user and added test
coverage. For start > reserved_va, skip [start, reserved_va] and just
search within [min_addr, reserved_va].

I actually thought that I am adding too many CC's and causing
unnecessary noise but b4 is asking me to run auto-to-cc (:

Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
---
Bingwu Zhang (4):
      linux-user: Deal with mmap where start > reserved_va
      bsd-user: Deal with mmap where start > reserved_va
      tests/tcg/multiarch/test-mmap: Print more details
      tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va

 bsd-user/mmap.c                 |  8 +++++---
 linux-user/mmap.c               |  9 ++++++---
 tests/tcg/multiarch/test-mmap.c | 27 ++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 9 deletions(-)
---
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20260227-abyss-mmap-relocation-ccba2ab8902b

Best regards,
-- 
Bingwu Zhang <xtex@astrafall.org>


