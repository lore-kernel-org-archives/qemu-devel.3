Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC6606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BL6GenAw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjR-0000tU-Fs; Mon, 26 Oct 2026 06:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiW-0008Ua-CQ; Mon, 26 Oct 2026 06:14:16 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiR-0001YB-Mj; Mon, 26 Oct 2026 06:14:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6F7E60A5F;
 Mon, 26 Oct 2026 10:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69731F01828;
 Mon, 26 Oct 2026 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009646;
 bh=YP2jrpk+FEY0LPgCnf+trGUMiWEqye5ido4reWw+rr0=;
 h=From:Subject:Date:To:Cc;
 b=BL6GenAwNk1UZHauR3mq/f0bMWSNXVBXSAagw2QQ1InW0yAFWo751fz51uyJ7RdGp
 hYtqF8TWjbCzf6Cvxsa1nTcjgTykurBpy9fVxfqFHx9mqfrzR//KQFCaUapVO7zrhP
 qZIRSGlFL/jOCiKKZ43GaXP4x6FQWGPCDhBJbT6NetBpD1rnN2IpelCnbB8RzHErPq
 4YLAg9k06r45/wuQlXCuaQZc+K8OHvWo7viUMmxio43bWWbeDOLHkS1C0teu1iYiX1
 5jcMcJRdf4l0cwiwoReg7TJo9BZRZLXUxSpvrSXEyKuj4itKMOkAwTMZ17YIMCx7UR
 hH8fw1kUQt2RA==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH RESEND 0/5] Add Multiple Atomicity Mode (MAM) support
Date: Mon, 26 Oct 2026 11:13:55 +0100
Message-Id: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=2288;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=Vzv2gtFqJBcDO2/t7W35ilDoCZAsg94Vug/E2Lxl6iA=;
 b=0f1c2OXx2BCirsF+XfUaLmln2XoUAwDtInBPFIxFQan80vtXEY/MepP5AiGb4oDqP54/E7ilE
 nvKDstfA9tPD1qD+o2MrffFMoGPQUF+QrG7SybYgcD4SNBk/umHS3Qo
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Multiple Atomicity Mode (MAM) emulation support. MAM is a superset
of Single Atomicity Mode (SAM): per the NVMe spec, a write command that
crosses a Namespace Atomic Boundary is divided into LBA subranges, each
written atomically. The emulation reuses the atomic write support from
commit ebd1568fc732 ("hw/nvme: add atomic write support"): when MAM is
enabled, the size and boundary limits that decide whether a write is
atomic no longer apply, so the whole command is serialized as one atomic
write.

A namespace enables it with atomic.map=on alongside
the existing per-namespace atomicity parameters. Example:

    -device nvme,serial=foo,id=nvme0 \
    -drive file=nvme0.qcow2,if=none,format=qcow2,id=nvme0-ns0 \
    -device nvme-ns,drive=nvme0-ns0,bus=nvme0,atomic.nawun=7,\
      atomic.nawupf=7,atomic.nabsn=7,atomic.nabspf=7,atomic.mam=on

Quering the result with nvme-cli:
nvme id-ns -H /dev/nvme0n1 | head
NVME Identify Namespace 1:
nsze    : 0x500000      Total size in logical blocks
ncap    : 0x500000      Maximum size in logical blocks
nuse    : 0x500000      Current size in logical blocks
nsfeat  : 0x76
  [7:7] : 0     NPRG, NPRA and NORS are Not Supported
  [6:6] : 0x1   Multiple Atomicity Mode applies to write operations

While at it, fix endianness issues on the atomic write command path
(first patch) and update hw/nvme docs with atomic writes section.

Baseline: nvme.next branch; tree: https://gitlab.com/birkelund/qemu

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (5):
      hw/nvme: fix endianness handling in the atomic write path
      hw/nvme: add missing atomic.* fields in usage
      docs: add hw/nvme atomics section
      hw/nvme: add multiple atomicity mode support
      docs: update hw/nvme atomics with mam

 docs/system/devices/nvme.rst | 47 ++++++++++++++++++++++++++++++++++++++++++--
 hw/nvme/ctrl.c               | 40 +++++++++++++++++++++++--------------
 hw/nvme/ns.c                 | 27 ++++++++++++++++++++++++-
 hw/nvme/nvme.h               |  1 +
 4 files changed, 97 insertions(+), 18 deletions(-)
---
base-commit: 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5
change-id: 20260824-nvme-mam-3af8616d6e37

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


