Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D16CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 19:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMA6u-0006c1-S4; Thu, 20 Nov 2025 14:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6a-0005vj-1L
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:14:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMA6Q-000779-OD
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763666037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8GWkD4F3bUuv8Q1P0X31rBekH0EimGqSmOdrumSZaFU=;
 b=hnubf/OW0jOSOj1u9hzg48p3kquC2NIUlT+YnZAJsWbdk3raCoDP4fC3857W+MbfjrnoEN
 Lb9PijuVpeJ9jZcSdtcf59tDr/Za57H5ilv8BVLNTL5KxgYmQxX4FBZpp5eDQdwyASpAki
 p1rCskVw1P8CHDF9J0rpVWKW/7cgdeQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-ME6oTu6fO--Wx6qmpcJOoA-1; Thu,
 20 Nov 2025 14:13:53 -0500
X-MC-Unique: ME6oTu6fO--Wx6qmpcJOoA-1
X-Mimecast-MFC-AGG-ID: ME6oTu6fO--Wx6qmpcJOoA_1763666024
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4FD119560AD; Thu, 20 Nov 2025 19:13:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95B8C30044DC; Thu, 20 Nov 2025 19:13:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40B4921E6A27; Thu, 20 Nov 2025 20:13:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, pizhenwei@bytedance.com, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 philmd@linaro.org, alex@shazbot.org, clg@redhat.com, peterx@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, dave@treblig.org,
 jasowang@redhat.com, samuel.thibault@ens-lyon.org, michael.roth@amd.com,
 kkostiuk@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 rathc@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 marcandre.lureau@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: [PATCH 00/14] Error message improvements
Date: Thu, 20 Nov 2025 20:13:25 +0100
Message-ID: <20251120191339.756429-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster (14):
  error: Strip trailing '\n' from error string arguments (again)
  hw/usb: Use error_setg_file_open() for a better error message
  tap-solaris: Use error_setg_file_open() for better error messages
  qga: Use error_setg_file_open() for better error messages
  hw/scsi: Use error_setg_file_open() for a better error message
  hw/virtio: Use error_setg_file_open() for a better error message
  net/tap: Use error_setg_file_open() for a better error message
  blkdebug: Use error_setg_file_open() for a better error message
  error: Use error_setg_file_open() for simplicity and consistency
  net/slirp: Improve file open error message
  error: Use error_setg_errno() to improve error messages
  error: Use error_setg_errno() for simplicity and consistency
  qga/commands-win32: Use error_setg_win32() for better error messages
  block/file-win32: Improve an error message

 backends/cryptodev-lkcf.c   |  2 +-
 backends/spdm-socket.c      |  4 ++--
 backends/tpm/tpm_emulator.c | 13 +++++--------
 block/blkdebug.c            |  2 +-
 block/file-win32.c          |  2 +-
 hw/9pfs/9p-local.c          |  2 +-
 hw/9pfs/9p.c                |  3 +--
 hw/acpi/core.c              |  5 ++---
 hw/audio/es1370.c           |  2 +-
 hw/core/loader.c            |  2 +-
 hw/intc/openpic_kvm.c       |  3 +--
 hw/intc/xics_kvm.c          |  5 +++--
 hw/pci-host/xen_igd_pt.c    |  2 +-
 hw/ppc/spapr.c              |  6 +++---
 hw/remote/vfio-user-obj.c   | 18 +++++++++---------
 hw/scsi/vhost-scsi.c        |  3 +--
 hw/sensor/emc141x.c         |  4 ++--
 hw/sensor/tmp421.c          |  4 ++--
 hw/smbios/smbios.c          |  4 ++--
 hw/usb/bus.c                |  2 +-
 hw/vfio/migration-multifd.c |  5 +++--
 hw/virtio/vdpa-dev.c        |  4 ++--
 hw/virtio/vhost-vsock.c     |  3 +--
 migration/postcopy-ram.c    | 10 +++++-----
 migration/rdma.c            |  3 +--
 monitor/hmp-cmds-target.c   |  2 +-
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
 target/riscv/kvm/kvm-cpu.c  | 11 ++++++-----
 ui/gtk.c                    |  2 +-
 ui/ui-qmp-cmds.c            |  3 +--
 util/vfio-helpers.c         |  5 ++---
 43 files changed, 113 insertions(+), 120 deletions(-)

-- 
2.49.0


