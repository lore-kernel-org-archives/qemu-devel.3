Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABED74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInE-0006zE-MZ; Fri, 23 Jan 2026 10:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInB-0006x7-NV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:45 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInA-0002wr-4H
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2139660130;
 Fri, 23 Jan 2026 15:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1129C4CEF1;
 Fri, 23 Jan 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769180975;
 bh=pAHoaT+pJCrvSlS26oG8Zdvkqf7SHjoqJ6trkQLglz8=;
 h=From:To:Cc:Subject:Date:From;
 b=Mq/9JD08YYpNx3hPhT9xud5qp/eZ6+fp62DwSqpUlbM2Go+ZSH7nlE+cRS++AohHU
 yfonRYtIrECnjfFZKVg277DM3eG4Zw+GVzcJj5sroWNditF0KGAV2hnkRzIwz5vgBX
 d3LNXDlDomJjqTPpseFLjUql9nXxKvn7EhYMgH83rYkFahgYuQ/9cqWekzqEYR2CLk
 5+iC42VGYIzcbDBE+fdQDuxeSntVlNTOL8sMIUhHeLZve5RyrAXKAydSlQ6q0meOB9
 aEAE6Xr+LiVmyiIdbtGLhmEQlHchqaAQJazwdur1S8u2XKSiSep63ftL9sBe+jizyS
 /z160uAdXBRtQ==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/3] linux-user futex() and madvise() fixes
Date: Fri, 23 Jan 2026 16:07:57 +0100
Message-ID: <20260123150921.17891-1-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Three small linux-user patches. Please review.

Helge Deller (3):
  linux-user: strace: Fix 5th argument of futex syscall
  linux-user: val3 parameter of futex() syscall needs endianess swapping
  linux-user: Fix MADV_XXX constants on hppa target

 linux-user/strace.c  |  7 ++++++-
 linux-user/syscall.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.52.0


