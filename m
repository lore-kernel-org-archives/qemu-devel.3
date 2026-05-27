Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541F5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 04:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS68i-0006EC-0T; Wed, 27 May 2026 00:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wS4uH-0000NZ-7v
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:26:09 -0400
Received: from jupiter.guys.cyano.uk ([45.63.120.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wS4uE-00085d-VK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:26:08 -0400
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
 t=1779852359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAi0r8LlJV9Gj6w0/vD0o4M4G/rwiBwXXf9Ccy4OYZE=;
 b=CgFYUODiTgmM4A+Jgx3jTzwu1S7JGRA6+8BcCLEPOPnUr/L+8hvEE5UPHCBFV8xz+PaKHz
 6jBYB9j884NhaO+oVC1RYb7RXBQnh0FWFBv5gGedvMRV1s+94c4/j1lgQ+Fsb8Gu96nrpo
 KJSVhxleptAcdBeqrFCC35s3Q5dGLZgIxNpYJEEyRkzc6tgiR07qOBPEhAEG3vBR1iuu5h
 BP02UMIelF7Kf+nc2KGhYR741pS6XhQX/+MnhMtkSGPRUWqZjSDWRUuYibXH4isPl+/4qT
 /5uTrF2zQVOTyNoiJIBKq6zz24OGjr+wZGZ9TaqFSiDXjEyqbX4cooZGcnagKw==
Authentication-Results: jupiter.guys.cyano.uk;
 auth=pass smtp.mailfrom=cyan@cyano.uk
To: qemu-devel@nognu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Mingcong Bai <jeffbai@aosc.io>,
 Xinhui Yang <cyan@cyano.uk>
Subject: [PATCH 0/2] linux-user: implement fsmount(2) series of syscalls
Date: Wed, 27 May 2026 11:23:37 +0800
Message-ID: <cover.1779850946.git.cyan@cyano.uk>
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
X-Mailman-Approved-At: Wed, 27 May 2026 00:45:05 -0400
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

The motivation of the implementation is to make the systemd-nspawn
container to boot guest OSes with systemd v259+, otherwise any systemd
service requires importing credentials will fail, including journald,
D-Bus service and getty. We used to work around this issue by patching
systemd to retry the clone() without CLONE_NEWNS, which is not and can
not be implemented in QEMU user emulation.

mount(8) from util-linux works because it will fallback to the old
mount(2) syscall if fsmount(8) series of syscalls is not available.

Tested good on an x86-64 host, with:

- an AOSC OS mips64r6el guest, which boots successfully with full systemd
  support using systemd-nspawn(1).
- a Gentoo ppc (big endian) guest, which boots successfully with full
  systemd support, using systemd-nspawn(1).

Xinhui Yang (2):
  linux-user: implement fsmount(2) series of syscalls
  linux-user/strace: add fsmount series of syscalls

 linux-user/strace.c    | 102 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  15 ++++++
 linux-user/syscall.c   |  77 +++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

-- 
2.52.0


