Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306EACD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqD-0004rf-75; Mon, 04 May 2026 10:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqB-0004o7-5K
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtq7-00026r-MJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:06 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fTOW250336; Mon, 4 May 2026 13:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=QqN0WNcKbZMOxMhX
 aOBmt71xxygK0iG0/6GlsG6yYUI=; b=aDmJ5twMAdfc7K0ARSu/EVHz+oVgtrcm
 LkpuILyU3sAnCAr565BtXLnTr+yMfH7qDTdM7iG//e9iV3OplENWYjjMXAKPajVT
 sEBjzVUSllP5EPNdPmoBb5XR/lD9ijjYQDBPZBxPsMJp9zGv1o0OF25h0YqosmAF
 HyAhVC8Hsso0LLf05Sc9N4t5SetFt/kPA1fcZ/DKcbFXiY739ExCBT8smHW2I+ED
 ILRBJoJtO3dRii7D7taV7azAFmLE37Ej9xh6BpTs9xHvdtKz53T/pIvJSPnEkc4L
 w5XPnXgEPgJLPj9Nn/V2oxGD8kZcVXWEvcd7tpxT1tmv6cecxrfn4A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e1apyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 13:59:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuRZQ013796; Mon, 4 May 2026 13:59:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk95h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 13:59:58 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvoc027094;
 Mon, 4 May 2026 13:59:57 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-1; Mon, 04 May 2026 13:59:57 +0000 (GMT)
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: [PATCH 0/5] virtio-scsi: Add max_target and max_lun knobs
Date: Mon,  4 May 2026 13:59:39 +0000
Message-ID: <cover.1777890280.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040145
X-Proofpoint-ORIG-GUID: _ljKkIc8JUsZ2sKeZgKmC7yJKUfi-diM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfX/fLXiN2ESSx8
 BppHEkSsYrr191xYv58Ef2ey9qLcWBO0Etc4eiHHAK5i1Ev86rceMm/fvml/WudxD/lqk9vkqBB
 OPItMZWrizZVA/G7q5KPaXXYbTufFCbEp13J2Ez8K9fPt53PlOlXh0fMHERdU+gTHPBd2LXXQPP
 45R6d1e2QrzQ/S99WUcPcFxKgVHt7qJ81rDvZuJBMl1maL+iHLya8miRtjmw+2HgzGSW3hWHPYt
 AzLSBTCyvrFHFn8YGa9G2jlXq7qYhEQHthb3av1D16XW+L5oFCAjFhuYX3ke5mXyAG3FAvdKh3p
 VoB6QnCjdMm4WPf9zxICCnX9AhPkd/asuVQHJk+YnnUHQQUU5rV6i7lLongSIK/3ftJWUoS1YkU
 TirN7JOxfIFYOC8fcO9lf1P1CUS5DeD2sc2ohtyWBM9zNHfpe6Ma9o4LOgDyg6tzoa2KkX4r/uW
 5bsnRL/oaZlvCeWxIEQUjeQyJwp5043Xs/c+0Pb0=
X-Proofpoint-GUID: _ljKkIc8JUsZ2sKeZgKmC7yJKUfi-diM
X-Authority-Analysis: v=2.4 cv=OPAXGyaB c=1 sm=1 tr=0 ts=69f8a65e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=bYP4fnOceGjtUWzuVX4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12306
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series introduces an option to override the maximum number of
targets and LUNs, now set to VIRTIO_SCSI_MAX_TARGET and
VIRTIO_SCSI_MAX_LUN respectively, via max_target and max_lun
properties in virtio-scsi and vhost-scsi devices.

When probing a device, the driver walks through all possible targets
to discover what is available on the bus. In the process, it sends
INQUIRY commands, including to devices that do not exist. The issue
can be observed in a guest with a single scsi-hd device, with verbose
SCSI logging enabled:

scsi 0:0:0:0: scsi scan: REPORT LUN scan
scsi 0:0:0:0: scsi scan: device exists on 0:0:0:0
scsi 0:0:1:0: scsi scan: INQUIRY pass 1 length 36
scsi 0:0:1:0: scsi scan: INQUIRY failed with code 0x40000
(...)
scsi 0:0:255:0: scsi scan: INQUIRY pass 1 length 36
scsi 0:0:255:0: scsi scan: INQUIRY failed with code 0x40000

The issue is more noticeable with the vhost-scsi backend.
On hypervisors without the patch [2], each INQUIRY queued up
for a non-existent target triggers vq_error(), registered by
vhost_virtqueue_error_notifier(), resulting in a flood of
"vhost vring error in virtqueue X" messages when booting a VM.

Even with [2] applied, we still send commands to phantom targets
and have no way to stop the scan earlier, spending more time
in virtscsi_probe() than necessary.

The fourth patch in the series addresses this issue by introducing
the "max_target" property for virtio-scsi, vhost-scsi and vhost-user-scsi
devices. This provides an option to specify how many targets are used
by the guest, and to stop scanning before hitting VIRTIO_SCSI_MAX_TARGET.

A similar issue can be seen when scanning LUNs on existing targets.
For example, the OVMF VirtioScsiDxe driver queues up INQUIRY for each
0..7 LUN, even if only LUN 0 is available. This can be easily observed
when using a vhost-scsi backend, as such messages appear in the hypervisor
dmesg when booting up a guest:

TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000001 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000002 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000003 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000004 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000005 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000006 from
naa.5001405277e02c68
TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000007 from
naa.5001405277e02c68

The last patch of the series provides a way to specify how many LUNs
are actually present by setting the "max_lun" property in virtio-scsi,
vhost-scsi and vhost-user-scsi devices.

If neither property is specified, max_target and max_lun are set to
their default values.

The series overview:

- Patches 1-2 - refactoring of SCSIBusInfo suggested by Alex Bennée
                in [1] that splits the struct into two: one for bus
                callbacks, SCSIBusOps, the other for bus configuration,
                SCSIBusConfig
- Patch 3     - use errp in virtio_scsi_device_realize() instead of
                a local error variable
- Patch 4     - introduction of the max_target parameter
- Patch 5     - introduction of the max_lun parameter

This is a complete rewrite of the [3] series, so I decided to submit
it as a new patchset, instead of labeling it v2.

Testing: In addition to running make check, I ran a guest with multiple
         virtio-scsi-pci and vhost-scsi controllers using different
         max_target values, verified that the properties are set, and
         tried hotplugging virtio-scsi devices to see if the custom
         max_target setting is respected.

----
[1] - https://lore.kernel.org/all/87h5u1hye5.fsf@draig.linaro.org/
[2] -
https://lore.kernel.org/virtualization/20250607171815.111030-1-michael.christie@oracle.com/T/#u
[3] -
https://lore.kernel.org/all/cover.1763999544.git.karolina.stolarek@oracle.com

Karolina Stolarek (5):
  scsi: Split SCSIBusInfo struct
  scsi: Rename SCSIBusInfo to SCSIBusOps
  virtio-scsi: Use errp in virtio_scsi_device_realize
  virtio-scsi: Make max_target parameter configurable
  virtio-scsi: Make max_lun parameter configurable

 hw/scsi/esp-pci.c               |  7 ++--
 hw/scsi/esp.c                   |  7 ++--
 hw/scsi/lasi_ncr710.c           |  6 ++--
 hw/scsi/lsi53c895a.c            |  6 ++--
 hw/scsi/megasas.c               |  7 ++--
 hw/scsi/mptsas.c                |  9 +++--
 hw/scsi/ncr53c710.c             |  6 ++--
 hw/scsi/scsi-bus.c              | 64 +++++++++++++++++----------------
 hw/scsi/scsi-disk.c             |  2 +-
 hw/scsi/spapr_vscsi.c           |  7 ++--
 hw/scsi/vhost-scsi.c            |  4 +++
 hw/scsi/vhost-user-scsi.c       |  4 +++
 hw/scsi/virtio-scsi.c           | 51 ++++++++++++++++++--------
 hw/scsi/vmw_pvscsi.c            |  7 ++--
 hw/ufs/lu.c                     |  8 +++--
 hw/usb/dev-storage-bot.c        |  7 ++--
 hw/usb/dev-storage-classic.c    |  6 ++--
 hw/usb/dev-uas.c                |  7 ++--
 include/hw/scsi/scsi.h          | 22 ++++++++----
 include/hw/virtio/virtio-scsi.h |  4 +++
 scripts/checkpatch.pl           |  2 +-
 21 files changed, 161 insertions(+), 82 deletions(-)

-- 
2.47.1


