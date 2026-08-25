Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF220C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxSV-0002Cf-1l; Tue, 25 Aug 2026 16:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSQ-00024d-OK; Tue, 25 Aug 2026 16:09:18 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSO-0003LO-VR; Tue, 25 Aug 2026 16:09:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 334C34135B;
 Tue, 25 Aug 2026 20:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715E41F00A3A;
 Tue, 25 Aug 2026 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787688547;
 bh=YP2jrpk+FEY0LPgCnf+trGUMiWEqye5ido4reWw+rr0=;
 h=From:Subject:Date:To:Cc;
 b=L9S9Em76887Fp9LAsB3cjxHrNNm/QHIWavmDzSI75XlDxnWIrAuIFMvFLBtRdBHUx
 F/d6T8hKdkny75OxKClRsDzdKcuvxzM3pxSzaSu5dDTIDeskEz1pwcwBEWxYQRAkZC
 nfvd0Q6XUB8JiXe8SzYNXSBlCcLyauku6l0MYkaUk8VPD8iiQyQmRvCAuHYa1SAVu1
 3kP9XkG2koG+xTQ4U1SIfjwN7/QEaKnsxWT0HFSP+WL7sV/CKqDCjbSLwBRD5wzxfx
 yDLWkNm4yLrJls6uQseKE7Beb+/J7OCuSVJGEk2ZrnqqpqrkqV10zjA7u6EgFWVZWY
 7unhcLZh5vA7A==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH 0/5] Add Multiple Atomicity Mode (MAM) support
Date: Tue, 25 Aug 2026 22:08:00 +0200
Message-Id: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBNMw6KrRAurqSbQQkuC8O5ZL
 T/437vBoyP00GQ3OAzkabMJRZ7BsGg7I6MxGQQXiteiZDYYZEYbJvVUq0KNCmUFKd8dTnR9V23
 325/9isPx7iHGB3ACBA5sAAAA
X-Change-ID: 20260824-nvme-mam-3af8616d6e37
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787688545; l=2289;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=+draTkcfT4Rd2NIzzJ8xj1Jf7rdX22OeRM10RJaMp8c=;
 b=i/NjO8rSKAguCIVzdqXxpmi4I0pI3drNyYrh8ewvkguEzc3KpgE/tHvGX7T8QBUx4rCoBgarr
 Bu19d3VB7ILCTUDQeJfwd+tw5vcPOB37Ecx53F+pvV1KLn9P+GOSn7i
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


