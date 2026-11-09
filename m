Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0C606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ibr.cs.tu-bs.de header.i=@ibr.cs.tu-bs.de header.a=rsa-sha256 header.s=key2 header.b=QWdIcP16
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1F-0003bo-FT; Mon, 09 Nov 2026 15:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRio-000323-Nu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:55:50 -0500
Received: from mail.ibr.cs.tu-bs.de ([134.169.34.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRim-0004bx-Jg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ibr.cs.tu-bs.de;
 s=key2; t=1794239738;
 bh=1zRE/0PdzsBrAnJmMtFjauA8GjuKWAmYpMCgbyuQXF8=;
 h=From:To:Cc:Subject:Date:From;
 b=QWdIcP16EaMj3Hx3+jB2Vz98nkZU8qY9iW930RBc5ka1jD4g4BIDaITkIgRZfR2cN
 3sq8HVmHD0Un0RWRzg+upu0lnC+Oes9Yyt6l2lMfTrJsFo8FORes/R6F/HVDhNCdX/
 MuJZCF0aeG9qePCnZPKvh1D79Sqm8gAItmU1pkSc=
X-Virus-Scanned: Debian amavisd-new at ibr.cs.tu-bs.de
Received: from work (unknown [IPv6:2001:638:602:d023:bb5a:b7cc:7fd8:120f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: gollenst)
 by mail.ibr.cs.tu-bs.de (Postfix) with ESMTPSA id 324277CBF186;
 Mon,  9 Nov 2026 16:55:38 +0100 (CET)
From: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
Subject: [PATCH 0/2] 9pfs/local: allow exporting traversable but non-readable
 directories
Date: Mon,  9 Nov 2026 16:55:01 +0100
Message-ID: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.169.34.14;
 envelope-from=gollenstede@ibr.cs.tu-bs.de; helo=mail.ibr.cs.tu-bs.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:03 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I often use (NixOS) qemu VMs with the hosts `/nix/store` mounted as `9p` share from the host.
This generally works fine, but stops working when the read permission on the `/nix/store` dir itself is not granted to the user running qemu.
Almost no application should have a reason to read the `/nix/store` directory itself, and since both a direct and especially a recursive listing can be huge, some programs misbehave if they can read it.
Nix itself recently gained support for having `/nix/store` with mode `1771`.

The solution seems pretty straightforward: open a few root-directory file descriptors with `O_PATH` instead of `O_RDONLY`, as they are only used to `*at` child FDs. Reads, if attempted, should then fail in the client/guest.

This is a problem for real users, and I knew/suspected that changing a few open flags to `O_PATH` would probably fix it (and I did a quick attempt at this myself).
But since it is much faster and honestly also more reliable ...
AI disclosure:
I had Claude analyse the problem, find the necessary sites to change, and write a test that shows the problem and the fix.
The (100% AI generated) test is included in a separate commit, so that it can hopefully be accepted or rejected independently of the actual fix.
This and the first commit's message I wrote myself.

Claude (1):
  tests/qtest/virtio-9p: test non-readable but traversable directories

Niklas Gollenstede (1):
  9pfs/local: allow exporting traversable but non-readable directories

 hw/9pfs/9p-local.c                       |   9 +-
 tests/qtest/libqos/virtio-9p.c           |   4 +-
 tests/qtest/virtio-9p-test.c             | 134 +++++++++++++++++++++++
 5 files changed, 142 insertions(+), 5 deletions(-)

--
2.54.0


