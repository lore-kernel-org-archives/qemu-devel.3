Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDAC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rLO-0000VK-AF; Tue, 29 Apr 2025 16:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLG-0000TJ-MR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:10 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLC-0001HO-Lw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:09 -0400
DKIM-Signature: a=rsa-sha256; bh=UjSjIZeymq85Imt/DjfAvUpYiQ3+UG3L+YuJPm/bnZE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1745957643; v=1;
 b=P6n0nHAXG7uSLg6uxJl3rpH0D2ENwkML1PA/l42JOWhsM4ALt4Uj8iwF/2XLP9w0GAtdNJjm
 mvsBLEjtQndKCiBKX1Mns+fBe3qFEaTQtiN8J+QGAgPdMVoxJNL2XGLJOknD+0CYvShsVqA/gSB
 5sz42t+TZzj/qyex6vhPALydLkTe9f6T5Zv1Zf8sANo4aFg1c0R8YRsAGtxU1rjEZpBbdvzQNx2
 9k3kjYkXFwVhVRUJQGsC8jQqJM0uBKwTCLgcNtOXzT9NFWBNRsrwobRyrSCskdmLhbT3jQlsBsP
 Mhxs6Rs+vtq8PUZMLFWv7WlYxQfrMwodsdDjV/B1JukUQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 101F421567;
 Tue, 29 Apr 2025 20:14:03 +0000 (UTC)
From: ~percival_foss <percival_foss@git.sr.ht>
Date: Tue, 29 Apr 2025 20:14:02 +0000
Subject: [PATCH qemu v2 0/2] Bugfix: TCG cross-page overflow for 32 bit guest
MIME-Version: 1.0
Message-ID: <174595764300.3422.13156465553505851834-0@git.sr.ht>
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~percival_foss <foss@percivaleng.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since v1:
-Updated git commits to have proper signed off by tags/messages

Our company found and fixed a bug in TCG that caused 32 bit guests
running on 64 bit hosts to crash. If a 32 bit host has a page
translation that crosses beyond the last page. This causes a invalid
translation to be added to the translation table causing a crash.

Since this is our first patch we tried following the wiki guidelines and
broke the patch into a fix and test. More info about each is given in
their respective commits. Any feedback is appreciated!

Signed off by: Percival Engineering <foss@percivaleng.com>

Percival Foss (2):
  accel/tcg: Fixed cross-page overflow for 32 bit guest
  tests/functional: Added cross page overflow test

 accel/tcg/cputlb.c                    |  7 +++
 tests/functional/meson.build          |  1 +
 tests/functional/test_ppc_pegasos2.py | 69 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100755 tests/functional/test_ppc_pegasos2.py

-- 
2.45.3

