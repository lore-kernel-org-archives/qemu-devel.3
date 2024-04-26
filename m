Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B5DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0GlQ-0006E0-2b; Fri, 26 Apr 2024 04:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s0GlO-0006DO-8D
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:16:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s0GlI-0004tY-IK
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:16:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q82IBp002150; Fri, 26 Apr 2024 08:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Shn8RqJA4fruhnfi3P+gV4VusOzkRvyaxPZTzy5UECc=;
 b=Sp4yYs/SoGeW3J76bQaHrRHWyhdpwBvVx5mOTZVdyTiPp8+7VBsqL7g98YQuMmmqMEts
 bjzsx/HaPT+665cPFnZXAAfSoCQXi1F5xyfJoT6ekBn9tCpODcqYgxztdX3hCdTP5fQw
 Tk7BqYFlUFRQNCNdtQORlslQJ+M4K64RVV4tjar+oEw2lnrZ8Hzv1hm+3jkcSPIL/gha
 6ami3GBliNDoqCYX3eIfSbAvICcUhASVhkIEls/aRthTlFwZV0LUhhc/U0lgWDQhSn30
 uD1qafilAartxeRnDuUujS7a1blymPfCyt5SL7ZqLYVfgCxOT6rxGmf6XWlwKtz9nFpF vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr8dcg1ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 08:16:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q8Gcm4024906;
 Fri, 26 Apr 2024 08:16:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr8dcg1ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 08:16:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q4nTZl029929; Fri, 26 Apr 2024 08:16:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1txv36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 08:16:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43Q8GeOk29425996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 08:16:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD3C320043;
 Fri, 26 Apr 2024 08:16:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 026652004B;
 Fri, 26 Apr 2024 08:16:40 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.40.41]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 08:16:39 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 mlevitsk@redhat.com, vsementsov@yandex-team.ru, ds-gavr@yandex-team.ru,
 yc-core@yandex-team.ru, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Date: Fri, 26 Apr 2024 10:16:39 +0200
Message-ID: <8734r8k07s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E9EZ_ccb2EWo593FZFS3Y5LwgmLZZqSD
X-Proofpoint-ORIG-GUID: t_5BeIxqSGmunndVr4Js6yxnBRSQ52_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260052
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 03, 2023 at 01:56 PM +0300, Dmitrii Gavrilov <ds-gavr@yandex-te=
am.ru> wrote:
> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
> the failure case of qdev_device_add. It seems call of drain_call_rcu was
> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callba=
cks
> under happy path too. What led to overall performance degradation of
> qmp_device_add.
>
> In this patch call of drain_call_rcu moved under handling of failure of
> qdev_device_add.
>
> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>

I don't know the exact reason, but this commit caused udev events to
show up much slower than before (~3s vs. ~23s) when a virtio-scsi device
is hotplugged (I=E2=80=99ve tested this only on s390x). Importantly, this o=
nly
happens when asynchronous SCSI scanning is disabled in the *guest*
kernel (scsi_mod.scan=3Dsync or CONFIG_SCSI_SCAN_ASYNC=3Dn).

The `udevadm monitor` output captured while hotplugging the device
(using QEMU 012b170173bc ("system/qdev-monitor: move drain_call_rcu call
under if (!dev) in qmp_device_add()")):

=E2=80=A6
KERNEL[2.166575] add      /devices/css0/0.0.0002/0.0.0002 (ccw)
KERNEL[2.166594] bind     /devices/css0/0.0.0002/0.0.0002 (ccw)
KERNEL[2.166826] add      /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
UDEV  [2.166846] add      /devices/css0/0.0.0002/0.0.0002 (ccw)
UDEV  [2.167013] bind     /devices/css0/0.0.0002/0.0.0002 (ccw)
KERNEL[2.167560] add      /devices/virtual/workqueue/scsi_tmf_0 (workqueue)
UDEV  [2.167977] add      /devices/virtual/workqueue/scsi_tmf_0 (workqueue)
KERNEL[2.167987] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0 (sc=
si)
KERNEL[2.167996] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/scs=
i_host/host0 (scsi_host)
KERNEL[2.169113] change   /0:0:0:0 (scsi)
UDEV  [2.169212] change   /0:0:0:0 (scsi)
KERNEL[2.199500] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0 (scsi)
KERNEL[2.199513] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)
KERNEL[2.199523] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
KERNEL[2.199532] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
KERNEL[2.199564] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
KERNEL[2.199586] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
KERNEL[2.280482] add      /devices/virtual/bdi/8:0 (bdi)
UDEV  [2.280634] add      /devices/virtual/bdi/8:0 (bdi)
KERNEL[3.060145] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/block/sda (block)
KERNEL[3.060160] bind     /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)
KERNEL[22.160147] bind     /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
KERNEL[22.160161] add      /bus/virtio/drivers/virtio_scsi (drivers)
KERNEL[22.160169] add      /module/virtio_scsi (module)
UDEV  [22.161078] add      /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
UDEV  [22.161339] add      /bus/virtio/drivers/virtio_scsi (drivers)
UDEV  [22.161860] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0 (s=
csi)
UDEV  [22.161869] add      /module/virtio_scsi (module)
UDEV  [22.161880] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0 (scsi)
UDEV  [22.161890] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/sc=
si_host/host0 (scsi_host)
UDEV  [22.161901] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0 (scsi)
UDEV  [22.161911] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
UDEV  [22.161924] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
UDEV  [22.161937] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
UDEV  [22.162123] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
UDEV  [22.468924] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0/block/sda (block)
UDEV  [22.473955] bind     /devices/css0/0.0.0002/0.0.0002/virtio2/host0/ta=
rget0:0:0/0:0:0:0 (scsi)
UDEV  [22.473970] bind     /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)


The `udevadm monitor` output without this commit (QEMU 9876359990dd ("hw/sc=
si/lsi53c895a: add timer to scripts processing")):

=E2=80=A6
KERNEL[2.091114] add      /devices/virtual/workqueue/scsi_tmf_0 (workqueue)
UDEV  [2.091218] add      /devices/virtual/workqueue/scsi_tmf_0 (workqueue)
KERNEL[2.091408] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0 (sc=
si)
KERNEL[2.091418] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/scs=
i_host/host0 (scsi_host)
KERNEL[2.200461] bind     /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
KERNEL[2.200473] add      /bus/virtio/drivers/virtio_scsi (drivers)
KERNEL[2.200481] add      /module/virtio_scsi (module)
UDEV  [2.200634] add      /module/virtio_scsi (module)
UDEV  [2.200678] add      /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
UDEV  [2.200746] add      /bus/virtio/drivers/virtio_scsi (drivers)
UDEV  [2.200830] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0 (sc=
si)
UDEV  [2.200972] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/scs=
i_host/host0 (scsi_host)
UDEV  [2.201148] bind     /devices/css0/0.0.0002/0.0.0002/virtio2 (virtio)
KERNEL[2.201699] change   /0:0:0:0 (scsi)
KERNEL[2.201734] change   /0:0:0:0 (scsi)
UDEV  [2.201815] change   /0:0:0:0 (scsi)
UDEV  [2.201888] change   /0:0:0:0 (scsi)
KERNEL[2.222062] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0 (scsi)
KERNEL[2.222074] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)
KERNEL[2.222083] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
KERNEL[2.222092] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
KERNEL[2.222104] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
KERNEL[2.222127] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
UDEV  [2.222241] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0 (scsi)
UDEV  [2.222486] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)
UDEV  [2.222667] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
UDEV  [2.222715] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
UDEV  [2.222877] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
UDEV  [2.223116] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
KERNEL[2.303063] add      /devices/virtual/bdi/8:0 (bdi)
UDEV  [2.303197] add      /devices/virtual/bdi/8:0 (bdi)
KERNEL[2.394175] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/block/sda (block)
KERNEL[2.394186] bind     /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)
UDEV  [2.706054] add      /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0/block/sda (block)
UDEV  [2.706075] bind     /devices/css0/0.0.0002/0.0.0002/virtio2/host0/tar=
get0:0:0/0:0:0:0 (scsi)

I=E2=80=99ve used as host kernel 6.7.0-rc3-00033-ge72f947b4f0d and guest ke=
rnel
v6.5.0.

QEMU 'info qtree' output when the device was hotplugged:

bus: main-system-bus
  type System
  dev: s390-pcihost, id ""
    x-config-reg-migration-enabled =3D true
    bypass-iommu =3D false
    bus: s390-pcibus.0
      type s390-pcibus
    bus: pci.0
      type PCI
  dev: virtual-css-bridge, id ""
    css_dev_path =3D true
    bus: virtual-css
      type virtual-css-bus
      dev: virtio-scsi-ccw, id "scsi0"
        ioeventfd =3D true
        max_revision =3D 2 (0x2)
        devno =3D "fe.0.0002"
        dev_id =3D "fe.0.0002"
        subch_id =3D "fe.0.0002"
        bus: virtio-bus
          type virtio-ccw-bus
          dev: virtio-scsi-device, id ""
            num_queues =3D 1 (0x1)
            virtqueue_size =3D 256 (0x100)
            seg_max_adjust =3D true
            max_sectors =3D 65535 (0xffff)
            cmd_per_lun =3D 128 (0x80)
            hotplug =3D true
            param_change =3D true
            indirect_desc =3D true
            event_idx =3D true
            notify_on_empty =3D true
            any_layout =3D true
            iommu_platform =3D false
            packed =3D false
            queue_reset =3D true
            use-started =3D true
            use-disabled-flag =3D true
            x-disable-legacy-check =3D false
            bus: scsi0.0
              type SCSI
              dev: scsi-generic, id "hostdev0"
                drive =3D "libvirt-1-backend"
                share-rw =3D false
                io_timeout =3D 30 (0x1e)
                channel =3D 0 (0x0)
                scsi-id =3D 0 (0x0)
                lun =3D 0 (0x0)
=E2=80=A6

Any ideas?

Thanks in advance.

Kind regards,
 Marc

