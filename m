Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BAECD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEDp-0001YJ-BV; Wed, 27 May 2026 09:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSBEu-0008OZ-IK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:11:52 -0400
Received: from jupiter.guys.cyano.uk ([45.63.120.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSBEs-0002IY-AA
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:11:51 -0400
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
 t=1779876705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JdtwzvdIZv2SKvpE2147MqXD/oHDfCFmpZx2eVaTbL8=;
 b=jw5JpGh/vHeZRVzdar5WnWy0ZLPT/BRC9EkzhylGoQtDy8Qbbl+0O7tTkLlyNk7ysMnhMO
 agJIWZjhorI/gP1Tro83aftOcRNk8bsbwbXdJVSDK8T+JX5bkN+3PV89boKWCfnDNR0jmi
 WOJEKvbPvc/sJlsh5t+L4ehS1KVEivYsB0TpFniCHClIcA/H4T9tp52TfTecUl4IMOhZqj
 Cc8km0NRMXVy5B0a36zE/CaPB93iJQn6lSp6NOYGOISLIQ00Ck9WrkI/6O2Q5Uhxqeve/j
 VGrF/HmlDFdVutCZ58r5N0C0HP+znH1gipkWnjMrmFUHk3O59dH4vXygznU/TA==
Authentication-Results: jupiter.guys.cyano.uk;
 auth=pass smtp.mailfrom=cyan@cyano.uk
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mingcong Bai <jeffbai@aosc.io>, Xinhui Yang <cyan@cyano.uk>
Subject: [PATCH v2 0/2] linux-user: implement fsmount(2) series of syscalls
Date: Wed, 27 May 2026 18:11:26 +0800
Message-ID: <cover.1779876076.git.cyan@cyano.uk>
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
X-Mailman-Approved-At: Wed, 27 May 2026 09:22:46 -0400
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

Changes from v1:

* Add missing guard for FSCONFIG_CMD_CREATE_EXCL in strace.c, since it is
  only available since 6.6.
* Fix some wording issues in the cover letter.

Xinhui Yang (2):
  linux-user: implement fsmount(2) series of syscalls
  linux-user/strace: add fsmount series of syscalls

 linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  15 ++++++
 linux-user/syscall.c   |  81 +++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

-- 
2.52.0


