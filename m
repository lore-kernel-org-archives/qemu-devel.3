Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB416FD4F0B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00ZL-0008B0-W4; Tue, 10 Mar 2026 13:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZF-00082D-Jj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZC-0002C9-4y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9XtZr2910641; Tue, 10 Mar 2026 17:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=ShhOehHvYzbbazvYqBrPBeVL7m9o6
 MUQm+oiGwBjSbo=; b=rgSfkn+ag6NkmXTVppjFqTXfFJzMvAE46j0iBWJmBHiIx
 TZ5GrfG+fveTzJwmlXuNn5tKGUSqxDujvEej/Uf7HcbJ0edNAFEizeJtZ1wgYomH
 q7bMjXixmj4VPNIIGtNiGAFSlWnHIAL7/KX4smNLXlZT3MaGR50iRBrCx0n2a4Dj
 fQD6S8TR9DlLczuICk5tLLjPNBIJsRiHizWyUCZ0HxxDpnNTnn9/cQfH75tgw9Ox
 b2G/FJHdjXdscuI0MiZtWWi/NEaQz1gGWKJWX1QFOhQBn0BSNBfW0vlt4MRSMmAX
 9/bR9RGpkxIoIvMiB+obJ1r0CR9XWQ+rKAcAk0GyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cskua3a2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62AG0Bkf014970; Tue, 10 Mar 2026 17:08:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafengvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AH6kiI015679;
 Tue, 10 Mar 2026 17:08:17 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4crafenguc-1; Tue, 10 Mar 2026 17:08:17 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 joe.jin@oracle.com
Subject: [PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS
 bootup failure 
Date: Tue, 10 Mar 2026 10:06:15 -0700
Message-ID: <20260310170712.46336-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100148
X-Authority-Analysis: v=2.4 cv=Methep/f c=1 sm=1 tr=0 ts=69b05002 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=y3BRUD-lpVNtIR_uvvAA:9 cc=ntf awl=host:12273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0OCBTYWx0ZWRfXyPQVSD47V9it
 SDFwfQyV98JKBIlTzGlpNh5w0B0ebtd2x/rC2to0+HrZRjTbiKykCH/SAZcNGkBaw4xbwGxScQI
 4bMhBlc6RicVXI3/UwoZC961rKuhD7R8yDEvd0TToGmgS4RtdLnlb7B4Mbd+koclNfhzgC+hhiw
 e7w3vEVIn9ZRIqikp6ONaYAleRYYeDoa6c962LM8gYAXzn4qGz8643coRQ7vllCpWiYuki3yJKH
 8drCYy3txRG+na6/Obq54qf3v/i6ZW68Ksdx8sYfrmac82UWAeM1ZfAP5GN5/Y6Qb5AFlr0jHsb
 0iO9oH+ov06w5udDd4SvK7KsT9h3q0fnv1XJSTWtAqzwtiDh4cvwAJKnKYBkMsktUrBosJIvtkC
 zNnaI/ltu4x49daHrhZnm/jlcuQ0CobS6CbhHVapllCb7p4r4LyXCYjCrOGIASv5iS831KWLCnn
 Vzqi4wYRIIFspoNtv/qTdjU+KovW4gDZWb0c/3Pk=
X-Proofpoint-ORIG-GUID: 6EdUR5d7C-HIvooe5bVLoj-mC-32rTSO
X-Proofpoint-GUID: 6EdUR5d7C-HIvooe5bVLoj-mC-32rTSO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

During system reset, and only during system reset, QEMU updates the
"bootorder" and "bios-geometry" entries in fw_cfg based on the contents of
"fw_boot_order" and "fw_lchs". After the guest VM boots, the firmware
(e.g., SeaBIOS) can read the boot order from fw_cfg and boot from the disk
at the top of the list.

The reset handler fw_cfg_machine_reset() is invoked either implicitly
during instance creation or explicitly by the user via HMP/QMP.

However, users may attach or detach disks while the VM is in the prelaunch
state. Because there is no implicit reset when transitioning from prelaunch
to running, the "bootorder" and "bios-geometry" data in fw_cfg can become
stale. As a result, the firmware may be unable to locate the correct disk
to boot from.

Here is an example that demonstrates the bug.

1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
prelaunch state. Use SeaBIOS rather than UEFI.

-device virtio-scsi-pci,id=scsi0,num_queues=4 \
-S \

2. First, attach the boot disk, then attach the secondary disk.

(qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
(qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
(qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
(qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1

3. Start the VM from the prelaunch state. Because the "bootorder" and
"bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
secondary disk only once and then stops. As a result, the VM fails to boot.

One possible workaround is to require QEMU users to explicitly issue a
system_reset before starting a guest VM from the prelaunch state, if any
disks have been attached or detached.

Another option is to address the issue in SeaBIOS. Nowadays, SeaBIOS
attempts to boot from only a single disk. We could enhance SeaBIOS to try
multiple disks in order until boot succeeds.

Another option is to update "bootorder" and "bios-geometry" everywhere
disks are attached or detached. This may require identifying the relevant
functions across multiple device types, such as SCSI, NVMe, virtio-blk, and
IDE.

This commit fixes the issue in QEMU by ensuring that "bootorder" and
"bios-geometry" are always updated when QEMU transitions from the prelaunch
state to running.

According to runstate_transitions_def[], RUN_STATE_PRELAUNCH is allowed to
transition to four states. Only the transition to RUN_STATE_RUNNING
requires updating "bootorder" and "bios-geometry".

v1: https://lore.kernel.org/qemu-devel/20260225220556.11049-1-dongli.zhang@oracle.com

v1 -> v2:
  - Add new runstate tranisition notifier to track transition from
    prelaunch to running.


Dongli Zhang (2)
  system/runstate: add runstate transition notifier
  hw/nvram/fw_cfg: update bootorder and bios-geometry before launching

 hw/nvram/fw_cfg.c         | 31 +++++++++++++++++++++++++++++--
 include/hw/nvram/fw_cfg.h |  1 +
 include/system/runstate.h |  8 ++++++++
 system/runstate.c         | 25 +++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

Thank you very much!

Dongli Zhang


