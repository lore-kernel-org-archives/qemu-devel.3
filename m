Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC1D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6W-0006xy-3z; Thu, 08 Jan 2026 02:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6Q-0006lf-AA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6N-0006bA-1q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8JsY866Pb+9tIqIaOZ77IpLIP6xAG9H8WaDiodx4nZQ=;
 b=RGIaPLdODzitrMPjxDt88YY9NrM+k1RoyOL5IdmJBjdA35b+Zchy5x9n60VFNTtTLrM8f+
 CXSlqo5yERQm8p8DrWzordUY0kDgdqR67R9Q0u2/CvOVDj05TncRuGq1x9zUM1Wmbq5OO0
 EpZBIwUh8PEWwG/lSdeR85Fm+M4gte0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-HFm0t5_oP7-S7xY5ubLpCw-1; Thu,
 08 Jan 2026 02:06:29 -0500
X-MC-Unique: HFm0t5_oP7-S7xY5ubLpCw-1
X-Mimecast-MFC-AGG-ID: HFm0t5_oP7-S7xY5ubLpCw_1767855988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7232195608D; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 471C01956048; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E62FC21E6937; Thu, 08 Jan 2026 08:06:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 00/17] Error reporting patches for 2026-01-07
Date: Thu,  8 Jan 2026 08:06:08 +0100
Message-ID: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:

  Merge tag 'pull-aspeed-20260105' of https://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2026-01-07-v2

for you to fetch changes up to 1f674a2b7aabb49d5a8308ef3949b2bb2fd70281:

  block/file-win32: Improve an error message (2026-01-08 07:50:32 +0100)

----------------------------------------------------------------
Error reporting patches for 2026-01-07

----------------------------------------------------------------
Markus Armbruster (17):
      hw/core/loader: Make load_elf_hdr() return bool, simplify caller
      hw/nvram/xlnx-bbram: More idiomatic and simpler error reporting
      nbd/client-connection: Replace error_propagate() by assignment
      error: error_free(NULL) is safe, drop unnecessary conditionals
      error: Consistently name Error * objects err, and not errp
      error: Strip trailing '\n' from error string arguments (again)
      ui: Convert to qemu_create() for simplicity and consistency
      tap-solaris: Use error_setg_file_open() for better error messages
      qga: Use error_setg_file_open() for better error messages
      net/tap: Use error_setg_file_open() for a better error message
      blkdebug: Use error_setg_file_open() for a better error message
      error: Use error_setg_file_open() for simplicity and consistency
      net/slirp: Improve file open error message
      error: Use error_setg_errno() to improve error messages
      error: Use error_setg_errno() for simplicity and consistency
      qga/commands-win32: Use error_setg_win32() for better error messages
      block/file-win32: Improve an error message

 include/hw/core/loader.h    |  4 +++-
 backends/cryptodev-lkcf.c   |  2 +-
 backends/spdm-socket.c      |  4 ++--
 backends/tpm/tpm_emulator.c | 13 +++++--------
 block/blkdebug.c            |  2 +-
 block/crypto.c              |  8 ++++----
 block/file-win32.c          |  2 +-
 hw/9pfs/9p-local.c          |  2 +-
 hw/9pfs/9p.c                |  3 +--
 hw/acpi/core.c              |  5 ++---
 hw/acpi/ghes.c              |  8 ++++----
 hw/acpi/pcihp.c             |  4 +---
 hw/arm/boot.c               |  6 +-----
 hw/audio/es1370.c           |  2 +-
 hw/core/loader.c            | 10 +++++++---
 hw/intc/openpic_kvm.c       |  3 +--
 hw/intc/xics_kvm.c          |  5 +++--
 hw/nvram/xlnx-bbram.c       | 18 ++++--------------
 hw/pci-host/xen_igd_pt.c    |  2 +-
 hw/ppc/spapr.c              | 22 +++++++++++-----------
 hw/remote/vfio-user-obj.c   | 18 +++++++++---------
 hw/riscv/spike.c            | 10 +---------
 hw/sensor/emc141x.c         |  4 ++--
 hw/sensor/tmp421.c          |  4 ++--
 hw/smbios/smbios.c          |  4 ++--
 hw/vfio/migration-multifd.c |  5 +++--
 hw/virtio/vdpa-dev.c        |  4 ++--
 hw/xen/xen-pvh-common.c     | 13 ++++++++++---
 io/channel-websock.c        |  4 +---
 io/task.c                   |  4 +---
 migration/migration.c       |  6 ++----
 migration/postcopy-ram.c    | 10 +++++-----
 migration/rdma.c            |  3 +--
 monitor/hmp-cmds.c          |  2 +-
 nbd/client-connection.c     |  3 +--
 nbd/common.c                |  6 +++---
 net/dump.c                  |  2 +-
 net/l2tpv3.c                |  6 ++----
 net/slirp.c                 |  9 ++++++---
 net/tap-bsd.c               |  6 +++---
 net/tap-linux.c             |  2 +-
 net/tap-solaris.c           |  6 +++---
 net/tap.c                   |  3 +--
 qga/commands-linux.c        | 11 ++++++-----
 qga/commands-posix-ssh.c    | 23 +++++++++++++----------
 qga/commands-win32.c        | 16 ++++++++--------
 system/vl.c                 |  2 +-
 target/i386/sev.c           |  6 ++----
 target/ppc/kvm.c            |  5 ++---
 target/riscv/kvm/kvm-cpu.c  | 10 +++++-----
 tests/unit/test-smp-parse.c |  5 +----
 ui/gtk.c                    |  2 +-
 ui/ui-qmp-cmds.c            |  4 +---
 util/vfio-helpers.c         |  5 ++---
 54 files changed, 160 insertions(+), 188 deletions(-)

-- 
2.52.0


