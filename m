Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC94CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu1-0005e8-4o; Mon, 12 Oct 2026 19:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtx-0005cZ-Q2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtv-0006ET-1T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:53 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgScq334361; Mon, 12 Oct 2026 23:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=0w9lpz+Rn3OIouaA9U4uy5mNDhLQg
 O5kx0EUAyAVgT8=; b=pFZaNPrFnbPMeUafxa9jyo2zwZA4EahaJcgO/THELy5S6
 8b/qaVcv97RIoZenAocM2XBUC7JI7mxkVqfiOPHzhIEwzt/Is+X//g36AvYSK8gh
 0hvEHtrHBxcco/qxIF9JWAGEnqfOrI00L67hjv+EJftBEEwDrAvIdx36wBrghtGn
 PfuhbgfpvTrqP+tjHJCrgzNOvyT37yafjYoCLqhnQWDwaylXrxuPZaAlzdIei2Zr
 YVcRGdUETaANZqSi1XRNNvJTJmYI3gfINtKuIcIiwJpzYG1HAGagXZU3bN3budhJ
 /3YYi8M16Q/qwgYhSewrceMBQ/o6iDyS6lXSsSf6A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dddu7t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpimr015375; Mon, 12 Oct 2026 23:57:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:42 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfH7025328;
 Mon, 12 Oct 2026 23:57:42 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-1; Mon, 12 Oct 2026 23:57:41 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support KHO/LUO
Date: Mon, 12 Oct 2026 23:55:56 +0000
Message-ID: <20261012235727.398133-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Proofpoint-GUID: dWIXUWXQ1fiXHz1bw1din-TpWTvK0gk8
X-Proofpoint-ORIG-GUID: dWIXUWXQ1fiXHz1bw1din-TpWTvK0gk8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX1fibiE/4LEyL
 FGrYozmOirRNR7fKU4VipyNZ1U1LNsUMpI1GC8feIh9fn+WCCaXnfUh5+xYCEvnaZm7U6dzmWnH
 sc38J0BLDkHOzd7iv7ntGP86ve5VfxZPRiOtKQhjedxKzCo4NbYN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXxwwvsY+ezLd1
 Ptgbwk8wR2dKW48aPN+EavwLceFPfICZ/p1p8yV3h2E8ZMzzOuFF5uY+YC8k0jV2tSEePssvP7+
 qUH8mKsaqenUSHo+gGlyrQCeN9/GuI8IGnCfJoCGQvpwebyEBHFT0YF/VH7KymImc27Fr2ILGjb
 AoxD8Vxb98zk9867EzSfympFnVuAMh39Wdh+BECJpPss/f0s7k6rmIb77MFYUkxyguzrqCILc3r
 h9SmNRHaYuA62iJW+ay+MymBkyrJQgTY/p7ZklyrovNp/10IIRu+fqGWF0XrKMQp33qXpTTW5KB
 PdU1bSvl1ivNOZ48M70Vu3XJ1uTimO9oNOX9lVtK0fzm8x82LxexdPlrb3pzMiYDAqDhZrSmX3M
 TimHJ81Ln3FqURyhvFPNo2dwRXGKvJQBW2PMUPBFIJBK9IXlNb1a0lk44DOQGW4ViOCmxRDy/4v
 AkYrEOc7c2Iwb4QbRUTz7TaCBw32QxPFgxeLgQUc=
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6acd73f7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=TYBLyS7eAAAA:8
 a=OtX6MG2v1n8ZmfsIG88A:9 a=zvYvwCWiE4KgVXXeO06c:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series introduces cpr-luo, a CPR migration mode that uses the Linux
Live Update Orchestrator (LUO) and Kexec Handover (KHO) to support KVM host
kernel updates through kexec.

On the outgoing side, QEMU saves CPR state in a memfd and preserves that fd
together with the RAMBlock backing fds in LUO. KHO carries the preserved LUO
state into the new kernel. The incoming QEMU retrieves the CPR state and
RAMBlock backing fds from LUO after kexec.

The regular migration stream carries device vmstate.

Although VFIO is currently blocked, I have an offline implementation that
skips cpr-luo mode in cpr_is_incoming(), skips precopy, and carefully handles
monitor_fd_param() although I never use it, so that VFIO is always
reconstructed. It works with both iommufd and legacy for mlx5_vfio_pci by
saving the VFIO and vendor specific state in vmstate as well.

The result is that guest RAM remains available across a kexec-based host
kernel update without copying its contents through the migration stream.

Here is the main idea of the patchset:

1. Introduce the new cpr-luo mode.
2. Use a UUID to identify a LUO session.
3. Introduce APIs to create, preserve, and retrieve sessions and fds.
4. As LUO uses the name, id, and token instead of an fd, create an
independent VMStateDescription rather than reuse the one for cpr-exec and
cpr-transfer.
5. Compute the token when transforming entries from the hash table into the
list.
6. Preserve fds on the source. Follow the approach used in cpr-exec and
cpr-transfer.
7. Retrieve fds on the target. Follow the approach used in cpr-exec and
cpr-transfer. The tricky part is where to set the cpr incoming mode.
8. There is no need to modify save_fd() or load_fd(), as we only need to
migrate the corresponding name and token, not the fds.
9. Handle corner-case errors.
10. Block VFIO.

I may need to rebase the current patchset on top of the patches below,
from which I learned quite a lot in each iteration. While working on this
patchset, I identified some cleanup and code issues in cpr-exec and
cpr-transfer. I may send fixes for them separately.

[PATCH v16 00/22] migration/cpr: support vhost-vsock devices
https://lore.kernel.org/all/20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com/

Example:

Add "kho=on liveupdate=on" to host kernel cmdline.

Create QEMU instance with memfd.

qemu-system-x86_64 \
-uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
-machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
-accel kvm -cpu host \
-name debug-threads=on \
-m 8G -smp 4 \
-object memory-backend-memfd,id=ram0,size=8G,share=on \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
-drive file=boot.qcow2,if=none,id=drive0 \
-netdev user,id=net0,hostfwd=tcp::5028-:22 \
-device virtio-net-pci,netdev=net0 \
-vnc :8 -monitor stdio

Don't terminate QEMU process after cpr-luo migration.

(qemu) migrate_set_parameter mode cpr-luo
(qemu) migrate -d file:cpr-luo.state
(qemu) info status
VM status: paused (postmigrate)

Use kexec to reboot the KVM host.

host# kexec -s -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --reuse-cmdline
host# sync
host# kexec -e

Resume QEMU instance after kexec reboot.

qemu-system-x86_64 \
-uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
-machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
-accel kvm -cpu host \
-name debug-threads=on \
-m 8G -smp 4 \
-object memory-backend-memfd,id=ram0,size=8G,share=on \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
-drive file=boot.qcow2,if=none,id=drive0 \
-netdev user,id=net0,hostfwd=tcp::5028-:22 \
-device virtio-net-pci,netdev=net0 \
-vnc :8 -monitor stdio \
-incoming cpr-luo:defer

(qemu) migrate_incoming file:cpr-luo.state
(qemu) info status
VM status: running


Dongli Zhang (21):
  qapi/migration: add cpr-luo migration mode
  migration/cpr: move CprFd definition to header file
  scripts/update-linux-headers: Add liveupdate.h
  linux-headers: import liveupdate UAPI header
  migration/cpr-luo: require a non-null machine UUID
  migration/cpr-luo: add LUO session management
  migration/cpr-luo: add LUO fd management helpers
  migration/cpr-luo: track LUO fds
  migration/cpr-luo: add LUO fd VMStateDescription
  migration/cpr-luo: add tokens for LUO fds
  migration/cpr: move QEMUFile fd helpers to common code
  migration/cpr-luo: add state fd helpers
  migration/cpr: add more arguments for cpr_walk_fd()
  migration/cpr-luo: add helpers to preserve and retrieve all LUO fds
  migration/cpr-luo: enable cpr-luo mode for source side preservation
  migration/cpr-luo: enable cpr-luo mode for target side retrieval
  migration/cpr-luo: abort session when migration fails
  system/physmem: add cpr-luo blocker
  monitor/qmp: close LUO session when resuming source QEMU
  vfio: block cpr-luo migration
  migration: cpr-luo documentation

 backends/hostmem-memfd.c         |   1 +
 backends/hostmem-shm.c           |   1 +
 docs/devel/migration/CPR.rst     |  64 +++++++
 hw/vfio/cpr-iommufd.c            |  17 +-
 hw/vfio/cpr-legacy.c             |   8 +
 include/hw/vfio/vfio-cpr.h       |   1 +
 include/migration/cpr.h          |  37 +++-
 include/system/iommufd.h         |   1 +
 include/system/system.h          |   2 +
 linux-headers/linux/liveupdate.h | 239 +++++++++++++++++++++++++
 migration/cpr-exec.c             |  32 +---
 migration/cpr-luo-stub.c         |  78 ++++++++
 migration/cpr-luo.c              | 328 ++++++++++++++++++++++++++++++++++
 migration/cpr.c                  | 126 +++++++++++--
 migration/meson.build            |   6 +
 migration/migration.c            |  12 +-
 migration/options.c              |   6 +
 migration/ram.c                  |   1 +
 monitor/qmp-cmds.c               |   7 +
 qapi/migration.json              |  11 +-
 scripts/update-linux-headers.sh  |   2 +-
 system/globals.c                 |   5 +
 system/physmem.c                 |   9 +-
 system/vl.c                      |   9 +
 24 files changed, 950 insertions(+), 53 deletions(-)

base-commit: 3377670ee96b5a68361016680a95b9013709d4b7

Thank you very much!

Dongli Zhang


