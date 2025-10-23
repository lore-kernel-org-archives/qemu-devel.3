Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC4CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqPw-000736-4A; Thu, 23 Oct 2025 04:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPs-0006zT-QY; Thu, 23 Oct 2025 04:11:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPp-0005jW-4t; Thu, 23 Oct 2025 04:11:24 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59N8B46x071845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 17:11:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yo1eupL/JTkCiD+PQbG1CrZ6XEh+1Un+I36TId4WHWE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1761207073; v=1;
 b=V+OWxAiov/QEYbH5TwD2PvSP6ZaYMf3SDWJqGQ1l1YA0zs+xagmmwMslY1MDvex+
 iKUCO5qmLW0B9MNdz/nZregAR0LAv9FkcgPBCZgMAPWlDgz+5KlZZm9JlGLII6b5
 XOLSDBNIHHKla25cSW4+/nZkllthT1rrb+FEW6Zu8mbzeL/pDg1d05Cp04yIpXqX
 jknKEXFP/Dl/n216p6K9ahzpw42RQXITIG3KgLPv/OCK/MXQMnMSwtsrzK3AFT/u
 WMemoPwllhQF/Tetc+XJuVU60csO7d4X/xrcGA3Q2u0XRNMkmv3zcgYoU9h3i3i0
 NjAQFnLrAOJDecrvyU4L1w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] iotests: Run iotests with sanitizers
Date: Thu, 23 Oct 2025 17:10:57 +0900
Message-Id: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABHj+WgC/yWNQQqDMBBFryKzbiBGZ0y8iriIcWxnobZJWgri3
 Rvq8j0+7x+QOAon6KsDIn8kyb4VqG8VhIff7qxkLgxGG6y1aZTsmVNOypLrGtRhcWShrJ+RF/n
 +S8N4ceTXuwTzJWHyiVXY11VyXwWLkzdz51uNhA5rIrLOOm1s+UHs3Dy1LXkYz/MHfXBSPqUAA
 AA=
X-Change-ID: 20251023-iotests-8697350cf968
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 2cc4d1c5eab1 ("tests/check-block: Skip iotests when sanitizers
are enabled") changed iotests to skip when sanitizers are enabled.
The rationale is that AddressSanitizer emits warnings and reports leaks,
which results in test breakage. Later, sanitizers that are enabled for
production environments (safe-stack and cfi-icall) were exempted.

However, this approach has a few problems.

- It requires rebuild to disable sanitizers if the existing build has
  them enabled.
- It disables other useful non-production sanitizers.
- The exemption of safe-stack and cfi-icall is not correctly
  implemented, so qemu-iotests are incorrectly enabled whenever either
  safe-stack or cfi-icall is enabled *and*, even if there is another
  sanitizer like AddressSanitizer.

To solve these problems, direct AddressSanitizer warnings to separate
files to avoid changing the test results, and selectively disable
leak detection at runtime instead of requiring to disable all
sanitizers at buildtime.

Enabling AddressSanitizer actually revealed a use-after-free so a patch
to fix it is placed before one that enables iotests with sanitizers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (2):
      qemu-img: Fix amend option parse error handling
      iotests: Run iotests with sanitizers

 qemu-img.c                       |  2 +-
 tests/qemu-iotests/meson.build   |  8 --------
 tests/qemu-iotests/testrunner.py | 12 ++++++++++++
 3 files changed, 13 insertions(+), 9 deletions(-)
---
base-commit: c85ba2d7a4056595166689890285105579db446a
change-id: 20251023-iotests-8697350cf968

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


