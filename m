Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658EDCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSr6H-0006cU-0T; Fri, 29 May 2026 02:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSr6F-0006c5-Dc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:53:43 -0400
Received: from jupiter.guys.cyano.uk ([45.63.120.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSr6D-0005LZ-KS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:53:43 -0400
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
 t=1780037616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oqWAzJ+LaDcWgrSzT3g0KnrahAMaamZaFE775dWfvQM=;
 b=Y78cbS3ABO3s0+qoYIuIWPFG9jwQEquzMbJRj8SmTHKJKhRsJh1IINwmIEZ1vZnMhY2MNI
 sLP7Htbe1qB1V0399yFhIwPF8xDJNLRx7ORYpaEcZ/Ao2rXJW5ltMBDvdSzTYeW89SqCY+
 tUK6//dvjkOQmM9mwDaWIipLuRockFNgQRhltCtnZ/dMk2a0Uyu+ewmMTdLh4LhdjJkNjn
 LC2N6X0igvbRMf5+u9hUpDixxIXI388LEsx7fsOhEhyZC3P68ELTiUa4TPQvdR3mWUM5xc
 BYRczSBPa/j1QUhg9mbfL5PdjzwVFuDa88wJkSiBVTdGxOKey8iQ1jy+ymfPkg==
Authentication-Results: jupiter.guys.cyano.uk;
 auth=pass smtp.mailfrom=cyan@cyano.uk
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mingcong Bai <jeffbai@aosc.io>, Xinhui Yang <cyan@cyano.uk>
Subject: [PATCH v3 0/2] linux-user: implement fsmount(2) series of syscalls
Date: Fri, 29 May 2026 14:53:19 +0800
Message-ID: <cover.1780036891.git.cyan@cyano.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Received-SPF: pass client-ip=45.63.120.176; envelope-from=cyan@cyano.uk;
 helo=jupiter.guys.cyano.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The motivation of the implementation is to allow any foreign guest OSes
with systemd v259+ to boot using systemd-nspawn(1), otherwise any
systemd service requiring importing credentials will fail, including
journald, D-Bus service and getty. We used to work around this issue by
patching systemd to retry the clone() without CLONE_NEWNS, which is not
and can not be implemented in QEMU user emulation.

mount(8) from util-linux worked prior to this patch because it will
fallback to the old mount(2) syscall if fsmount(8) series of syscalls
is not available.

Tested good on an x86-64 host, with:

- an AOSC OS mips64r6el guest, which boots successfully with full systemd
  support using systemd-nspawn(1).
- a Gentoo ppc (big endian) guest, which boots successfully with full
  systemd support, using systemd-nspawn(1).

Changes from v2:

* Apply the review from Pierrick Bouvier[1], making sure that the buffer
  is unlocked before returning error in the fsconfig handler.
* Clearify some comments in syscall.c.

Changes from v1:

* Add missing guard for FSCONFIG_CMD_CREATE_EXCL in strace.c, since it is
  only available since 6.6.
* Fix some wording issues in the cover letter.

[1]: https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg07794.html

Xinhui Yang (2):
  linux-user: implement fsmount(2) series of syscalls
  linux-user/strace: add fsmount series of syscalls

 linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  15 ++++++
 linux-user/syscall.c   |  91 +++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

-- 
2.52.0


