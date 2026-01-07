Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1B6CFD641
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdUVj-0001uc-Ka; Wed, 07 Jan 2026 09:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdUVU-0001kw-4J; Wed, 07 Jan 2026 09:27:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdUVN-00040J-FT; Wed, 07 Jan 2026 09:27:24 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6078SIRG001294;
 Wed, 7 Jan 2026 14:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jXnjbV
 tniJbrI50RhRvGGSQGoWgsYKMFHzMad5+qVjo=; b=oPYhx+pVdNZOI1aoDnZE8O
 5893G3t8RfXjD7mIDcNP84vTgmjQfBIkD2CvmRXJnHMMcgyEJoxSixsZSAtI1yzY
 ZU1uhpn+4UtwfrT1QRPcXdUBGF8zIohppCfSHK2QS1DYhqfeg/NsC7+oSfiy/lFW
 Sr4k0P+2ziOP1t7REIcS3uZbJFUaFovMM5x0CjPd1DSoPO+QRATkvgg/SC20GTOF
 PNjev4ZzA9Sn0lXeVScBYgcodYZzXTWblRsFc12IAyldfJJVq6AqxVfA5G1eKLQO
 5A+qoBLbtCxXJ6UTqldl9lItQyGuRwUkYB1Lx2CLgJL8modvon6fBWJhfIbdY8lA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtr6y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 14:27:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607BYQXZ014667;
 Wed, 7 Jan 2026 14:27:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeen1g68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 14:27:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607ERHWq57540896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 14:27:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21E1858043;
 Wed,  7 Jan 2026 14:27:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4551258055;
 Wed,  7 Jan 2026 14:27:16 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.176]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Jan 2026 14:27:16 +0000 (GMT)
Message-ID: <d32048349d6ae50536e5506fae21d9fa916cfa70.camel@linux.ibm.com>
Subject: Re: [PATCH 03/10] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Wed, 07 Jan 2026 09:27:15 -0500
In-Reply-To: <20251210205449.2783111-4-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695e6d47 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8 a=y1jdFm0wGYBZJX2_PvoA:9 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-GUID: HncXSk4UojTr0fdoDMBC3dMFBgaih8t5
X-Proofpoint-ORIG-GUID: HncXSk4UojTr0fdoDMBC3dMFBgaih8t5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDExMCBTYWx0ZWRfXwuxyl80IE9Pi
 H8uJuP1nCJ8bAb1kESMoqMog06tU+E0rlPaepu7i+hdU77QJmkNO5Kbs4sFwKNK7Oiw229zMbZ+
 e0yveoR3+3mgLvQCluDUcxgYHhA6iGp5k29TK3yJG2RCZL79Q9BeQGeCDGbN69fk1n1fS4zA0Jo
 m5kDM809wc1FVKcNAUf7CZ7eWGqkgtZu/HqafVaYS3EhaQ+I4ge6GdlNEcvOnU7nE37wkA56mlp
 KBSrLOVX7PuBugfEGx40bXRINCjrDF+HHS7ZPPL9eqAdmHC7goJal5hOiKlQ9np/MAnXGGa+MjR
 mxSkwg16VPk2bJ7VGh7PolWK1eo8WOTHgEj1las7E0cWcVRC+UZejSyaApupOgKAkWz39iU8BlP
 HQEfXG3F/JmCyOkWngN3foiSKNgNQ7QFk8pOxQPQh+3XDBu84xMyPxuc+RBVWs2IIk8874FYxtK
 m1rk7PWohHPGTdVPveg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2025-12-10 at 15:54 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Separate the CCW specific virtio routines and create generic wrappers for=
 easier
> reuse of existing virtio functions with non-CCW devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h      |   3 -
>  pc-bios/s390-ccw/virtio-ccw.h    |  24 +++
>  pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
>  pc-bios/s390-ccw/virtio.h        |   7 +-
>  pc-bios/s390-ccw/main.c          |  10 +-
>  pc-bios/s390-ccw/netmain.c       |   2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c |  15 +-
>  pc-bios/s390-ccw/virtio-ccw.c    | 242 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c    |   5 +-
>  pc-bios/s390-ccw/virtio-scsi.c   |   6 +-
>  pc-bios/s390-ccw/virtio.c        | 237 +++++-------------------------
>  pc-bios/s390-ccw/Makefile        |   3 +-
>  12 files changed, 334 insertions(+), 222 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
>  create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
>=20
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 47ea66bd4d..ccd68ff0a4 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -66,9 +66,6 @@ void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
>  int sclp_read(char *str, size_t count);
> =20
> -/* virtio.c */
> -bool virtio_is_supported(SubChannelId schid);
> -
>  /* bootmap.c */
>  void zipl_load(void);
> =20
> diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.=
h
> new file mode 100644
> index 0000000000..cdf6a55dc8
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-ccw.h
> @@ -0,0 +1,24 @@
> +/*
> + * Virtio definitions for CCW devices
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIO_CCW_H
> +#define VIRTIO_CCW_H
> +
> +/* main.c */
> +extern SubChannelId blk_schid;
> +
> +/* virtio-ccw.c */
> +int drain_irqs_ccw(SubChannelId schid);
> +bool virtio_ccw_is_supported(SubChannelId schid);
> +int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
> +long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
> +int virtio_ccw_setup(VDev *vdev);
> +int virtio_ccw_reset(VDev *vdev);
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scs=
i.h
> index c5612e16a2..7a37f8b45a 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.h
> +++ b/pc-bios/s390-ccw/virtio-scsi.h
> @@ -69,6 +69,6 @@ static inline bool virtio_scsi_response_ok(const Virtio=
ScsiCmdResp *r)
> =20
>  int virtio_scsi_read_many(VDev *vdev,
>                            unsigned long sector, void *load_addr, int sec=
_num);
> -int virtio_scsi_setup_device(SubChannelId schid);
> +int virtio_scsi_setup_device(void);
> =20
>  #endif /* VIRTIO_SCSI_H */
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index d557a4a90e..e747891a2c 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -109,6 +109,7 @@ struct VRing {
>  };
>  typedef struct VRing VRing;
> =20
> +char *virtio_get_ring_area(void);
> =20
>  /***********************************************
>   *               Virtio block                  *
> @@ -270,8 +271,10 @@ struct VirtioCmd {
>  };
>  typedef struct VirtioCmd VirtioCmd;
> =20
> +void vring_init(VRing *vr, VqInfo *info);
> +bool virtio_is_supported(VDev *vdev);
>  bool vring_notify(VRing *vr);
> -int drain_irqs(SubChannelId schid);
> +int drain_irqs(VRing *vr);
>  void vring_send_buf(VRing *vr, void *p, int len, int flags);
>  int vr_poll(VRing *vr);
>  int vring_wait_reply(void);
> @@ -284,7 +287,7 @@ int virtio_net_init(void *mac_addr);
>  void virtio_net_deinit(void);
> =20
>  /* virtio-blkdev.c */
> -int virtio_blk_setup_device(SubChannelId schid);
> +int virtio_blk_setup_device(void);
>  int virtio_read(unsigned long sector, void *load_addr);
>  unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
>                                   void *load_addr);
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index fef192c934..e82d60bbb7 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -72,6 +72,7 @@ static int is_dev_possibly_bootable(int dev_no, int sch=
_no)
>      Schib schib;
>      int r;
> =20
> +    VDev *vdev =3D virtio_get_device();

Newline would need to be after this, but I'm not sure you need the vdev def=
inition here.

>      blk_schid.sch_no =3D sch_no;
>      r =3D stsch_err(blk_schid, &schib);
>      if (r =3D=3D 3 || r =3D=3D -EIO) {
> @@ -91,7 +92,8 @@ static int is_dev_possibly_bootable(int dev_no, int sch=
_no)
>       * Note: we always have to run virtio_is_supported() here to make
>       * sure that the vdev.senseid data gets pre-initialized correctly
>       */
> -    is_virtio =3D virtio_is_supported(blk_schid);
> +    vdev->schid =3D blk_schid;

You save this in four different places (here, [2a], [2b], and [3])... But m=
aybe only need one? In
the ccw path ([3]?) ?

> +    is_virtio =3D virtio_is_supported(vdev);
> =20
>      /* No specific devno given, just return whether the device is possib=
ly bootable */
>      if (dev_no < 0) {
> @@ -254,10 +256,12 @@ static int virtio_setup(void)
>          puts("Network boot device detected");
>          return 0;
>      case VIRTIO_ID_BLOCK:
> -        ret =3D virtio_blk_setup_device(blk_schid);
> +        vdev->schid =3D blk_schid;

[2a]

> +        ret =3D virtio_blk_setup_device();
>          break;
>      case VIRTIO_ID_SCSI:
> -        ret =3D virtio_scsi_setup_device(blk_schid);
> +        vdev->schid =3D blk_schid;

[2b]

> +        ret =3D virtio_scsi_setup_device();
>          break;
>      default:
>          puts("\n! No IPL device available !\n");
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index a9521dff41..651cedf6ef 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -500,7 +500,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
>              continue;
>          }
>          enable_subchannel(net_schid);
> -        if (!virtio_is_supported(net_schid)) {
> +        if (!virtio_is_supported(virtio_get_device())) {
>              continue;
>          }
>          if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-b=
lkdev.c
> index f40a9407c2..87ab9a9513 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -12,6 +12,7 @@
>  #include "s390-ccw.h"
>  #include "virtio.h"
>  #include "virtio-scsi.h"
> +#include "virtio-ccw.h"
> =20
>  #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
>  #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
> @@ -42,7 +43,7 @@ static int virtio_blk_read_many(VDev *vdev, unsigned lo=
ng sector, void *load_add
>      /* Now we can tell the host to read */
>      vring_wait_reply();
> =20
> -    if (drain_irqs(vr->schid)) {
> +    if (drain_irqs(vr)) {
>=20
>          /* Well, whatever status is supposed to contain... */
>          status =3D 1;
>      }
> @@ -229,15 +230,19 @@ uint64_t virtio_get_blocks(void)
>      }
>  }
> =20
> -int virtio_blk_setup_device(SubChannelId schid)
> +int virtio_blk_setup_device(void)
>  {
>      VDev *vdev =3D virtio_get_device();
> =20
>      vdev->guest_features[0] =3D VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK=
_SIZE;
> -    vdev->schid =3D schid;
> -    virtio_setup_ccw(vdev);
> =20
>      puts("Using virtio-blk.");
> =20
> -    return 0;
> +    switch (virtio_get_device()->ipl_type) {

vdev->ipl_type

> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_setup(vdev);

default:
    return 1;

...instead of...

> +    }
> +
> +    return 1;

...this?

>  }
> diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.=
c
> new file mode 100644
> index 0000000000..e121826625
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-ccw.c
> @@ -0,0 +1,242 @@
> +/*
> + * Virtio functionality for CCW devices
> + *
> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com=
>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <string.h>
> +#include "s390-ccw.h"
> +#include "cio.h"
> +#include "virtio.h"
> +#include "virtio-ccw.h"
> +#include "virtio-scsi.h"
> +#include "bswap.h"
> +#include "helper.h"
> +#include "s390-time.h"
> +
> +/* virtio spec v1.0 para 4.3.3.2 */
> +static long kvm_hypercall(unsigned long nr, unsigned long param1,
> +                          unsigned long param2, unsigned long param3)
> +{
> +    register unsigned long r_nr asm("1") =3D nr;
> +    register unsigned long r_param1 asm("2") =3D param1;
> +    register unsigned long r_param2 asm("3") =3D param2;
> +    register unsigned long r_param3 asm("4") =3D param3;
> +    register long retval asm("2");
> +
> +    asm volatile ("diag %%r2,%%r4,0x500"
> +                  : "=3Dd" (retval)
> +                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), "d"(r_par=
am3)
> +                  : "memory", "cc");
> +
> +    return retval;
> +}
> +
> +static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
> +{
> +    Ccw1 ccw =3D {};
> +
> +    ccw.cmd_code =3D cmd;
> +    ccw.cda =3D (long)ptr;
> +    ccw.count =3D len;
> +
> +    if (sli) {
> +        ccw.flags |=3D CCW_FLAG_SLI;
> +    }
> +
> +    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW=
_FMT1);

The previous patch changed vdev->senseid.cu_type to vdev->dev_type, and her=
e you're switching it
back. Probably because dev_type is assigned from cu_model, which... Wait do=
es that mean the previous
patch would break IPL? (Sorry if I missed that yesterday.)

> +}
> +
> +bool virtio_ccw_is_supported(SubChannelId schid)
> +{
> +    VDev *vdev =3D virtio_get_device();
> +    vdev->schid =3D schid;

[3]

> +    memset(&vdev->senseid, 0, sizeof(vdev->senseid));
> +
> +    /*
> +     * Run sense id command.
> +     * The size of the senseid data differs between devices (notably,
> +     * between virtio devices and dasds), so specify the largest possibl=
e
> +     * size and suppress the incorrect length indication for smaller siz=
es.
> +     */
> +    if (run_ccw(vdev, CCW_CMD_SENSE_ID, &vdev->senseid, sizeof(vdev->sen=
seid),
> +                true)) {
> +        return false;
> +    }
> +
> +    vdev->dev_type =3D vdev->senseid.cu_model;
> +
> +    if (vdev->senseid.cu_type =3D=3D 0x3832) {
> +        switch (vdev->dev_type) {
> +        case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_SCSI:
> +        case VIRTIO_ID_NET:
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +    return false;
> +}
> +
> +int drain_irqs_ccw(SubChannelId schid)
> +{
> +    Irb irb =3D {};
> +    int r =3D 0;
> +
> +    while (1) {
> +        /* FIXME: make use of TPI, for that enable subchannel and isc */
> +        if (tsch(schid, &irb)) {
> +            /* Might want to differentiate error codes later on. */
> +            if (irb.scsw.cstat) {
> +                r =3D -EIO;
> +            } else if (irb.scsw.dstat !=3D 0xc) {
> +                r =3D -EIO;
> +            }
> +            return r;
> +        }
> +    }
> +}
> +
> +long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie)
> +{
> +    return kvm_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY, *(u32 *)&schid,
> +                         vq_idx, cookie);
> +}
> +
> +int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd)
> +{
> +    VRing *vr =3D &vdev->vrings[vqid];
> +    int i =3D 0;
> +
> +    do {
> +        vring_send_buf(vr, cmd[i].data, cmd[i].size,
> +                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
> +    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
> +
> +    vring_wait_reply();
> +    if (drain_irqs(vr)) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int virtio_ccw_reset(VDev *vdev)
> +{
> +    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
> +}
> +
> +int virtio_ccw_setup(VDev *vdev)
> +{
> +    int i, cfg_size =3D 0;
> +    uint8_t status;
> +    struct VirtioFeatureDesc {
> +        uint32_t features;
> +        uint8_t index;
> +    } __attribute__((packed)) feats;
> +
> +    if (!virtio_ccw_is_supported(vdev->schid)) {
> +        puts("Virtio unsupported for this device ID");
> +        return -ENODEV;
> +    }
> +    /* device ID has been established now */
> +
> +    vdev->config.blk.blk_size =3D 0; /* mark "illegal" - setup started..=
. */
> +    vdev->guessed_disk_nature =3D VIRTIO_GDN_NONE;
> +
> +    virtio_reset(vdev);
> +
> +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> +        puts("Could not write ACKNOWLEDGE status to host");
> +        return -EIO;
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs =3D 2;
> +        vdev->cmd_vr_idx =3D 0;
> +        cfg_size =3D sizeof(vdev->config.net);
> +        break;
> +    case VIRTIO_ID_BLOCK:
> +        vdev->nr_vqs =3D 1;
> +        vdev->cmd_vr_idx =3D 0;
> +        cfg_size =3D sizeof(vdev->config.blk);
> +        break;
> +    case VIRTIO_ID_SCSI:
> +        vdev->nr_vqs =3D 3;
> +        vdev->cmd_vr_idx =3D VR_REQUEST;
> +        cfg_size =3D sizeof(vdev->config.scsi);
> +        break;
> +    default:
> +        puts("Unsupported virtio device");
> +        return -ENODEV;
> +    }
> +
> +    status |=3D VIRTIO_CONFIG_S_DRIVER;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> +        puts("Could not write DRIVER status to host");
> +        return -EIO;
> +    }
> +
> +    /* Feature negotiation */
> +    for (i =3D 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
> +        feats.features =3D 0;
> +        feats.index =3D i;
> +        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), fals=
e)) {
> +            puts("Could not get features bits");
> +            return -EIO;
> +        }
> +
> +        vdev->guest_features[i] &=3D bswap32(feats.features);
> +        feats.features =3D bswap32(vdev->guest_features[i]);
> +        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), fal=
se)) {
> +            puts("Could not set features bits");
> +            return -EIO;
> +        }
> +    }
> +
> +    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)=
) {
> +        puts("Could not get virtio device configuration");
> +        return -EIO;
> +    }
> +
> +    for (i =3D 0; i < vdev->nr_vqs; i++) {
> +        VqInfo info =3D {
> +            .queue =3D (unsigned long long) virtio_get_ring_area() + (i =
* VIRTIO_RING_SIZE),
> +            .align =3D KVM_S390_VIRTIO_RING_ALIGN,
> +            .index =3D i,
> +            .num =3D 0,
> +        };
> +        VqConfig config =3D {
> +            .index =3D i,
> +            .num =3D 0,
> +        };
> +
> +        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
> +                false)) {
> +            puts("Could not get virtio device VQ config");
> +            return -EIO;
> +        }
> +        info.num =3D config.num;
> +        vring_init(&vdev->vrings[i], &info);
> +        vdev->vrings[i].schid =3D vdev->schid;
> +        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
> +            puts("Cannot set VQ info");
> +            return -EIO;
> +        }
> +    }
> +
> +    status |=3D VIRTIO_CONFIG_S_DRIVER_OK;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> +        puts("Could not write DRIVER_OK status to host");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.=
c
> index 301445bf97..604f1cf003 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -19,6 +19,7 @@
>  #include <ethernet.h>
>  #include "s390-ccw.h"
>  #include "virtio.h"
> +#include "virtio-ccw.h"
>  #include "s390-time.h"
>  #include "helper.h"
> =20
> @@ -54,7 +55,7 @@ int virtio_net_init(void *mac_addr)
>      rx_last_idx =3D 0;
> =20
>      vdev->guest_features[0] =3D VIRTIO_NET_F_MAC_BIT;
> -    virtio_setup_ccw(vdev);
> +    virtio_ccw_setup(vdev);
> =20
>      if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
>          puts("virtio-net device does not support the MAC address feature=
");
> @@ -88,7 +89,7 @@ int send(int fd, const void *buf, int len, int flags)
>      while (!vr_poll(txvq)) {
>          yield();
>      }
> -    if (drain_irqs(txvq->schid)) {
> +    if (drain_irqs(txvq)) {
>          puts("send: drain irqs failed");
>          return -1;
>      }
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scs=
i.c
> index 71db75ce7b..6ab0f755f2 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -15,6 +15,7 @@
>  #include "virtio.h"
>  #include "scsi.h"
>  #include "virtio-scsi.h"
> +#include "virtio-ccw.h"
>  #include "s390-time.h"
>  #include "helper.h"
> =20
> @@ -476,12 +477,11 @@ static int virtio_scsi_setup(VDev *vdev)
>      return 0;
>  }
> =20
> -int virtio_scsi_setup_device(SubChannelId schid)
> +int virtio_scsi_setup_device(void)
>  {
>      VDev *vdev =3D virtio_get_device();
> =20
> -    vdev->schid =3D schid;
> -    virtio_setup_ccw(vdev);
> +    virtio_ccw_setup(vdev);
> =20
>      if (vdev->config.scsi.sense_size !=3D VIRTIO_SCSI_SENSE_SIZE) {
>          puts("Config: sense size mismatch");
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 0f4f201038..0488b3a07e 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -2,6 +2,7 @@
>   * Virtio driver bits
>   *
>   * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com=
>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
>   * your option) any later version. See the COPYING file in the top-level
> @@ -13,6 +14,7 @@
>  #include "cio.h"
>  #include "virtio.h"
>  #include "virtio-scsi.h"
> +#include "virtio-ccw.h"
>  #include "bswap.h"
>  #include "helper.h"
>  #include "s390-time.h"
> @@ -44,69 +46,38 @@ VirtioDevType virtio_get_device_type(void)
>      return vdev.dev_type;
>  }
> =20
> -/* virtio spec v1.0 para 4.3.3.2 */
> -static long kvm_hypercall(unsigned long nr, unsigned long param1,
> -                          unsigned long param2, unsigned long param3)
> +char *virtio_get_ring_area(void)
>  {
> -    register unsigned long r_nr asm("1") =3D nr;
> -    register unsigned long r_param1 asm("2") =3D param1;
> -    register unsigned long r_param2 asm("3") =3D param2;
> -    register unsigned long r_param3 asm("4") =3D param3;
> -    register long retval asm("2");
> -
> -    asm volatile ("diag %%r2,%%r4,0x500"
> -                  : "=3Dd" (retval)
> -                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), "d"(r_par=
am3)
> -                  : "memory", "cc");
> -
> -    return retval;
> -}
> -
> -static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
> -{
> -    return kvm_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY, *(u32 *)&schid,
> -                         vq_idx, cookie);
> +    return ring_area;
>  }
> =20
>  /***********************************************
>   *             Virtio functions                *
>   ***********************************************/
> =20
> -int drain_irqs(SubChannelId schid)
> +int drain_irqs(VRing *vr)
>  {
> -    Irb irb =3D {};
> -    int r =3D 0;
> -
> -    while (1) {
> -        /* FIXME: make use of TPI, for that enable subchannel and isc */
> -        if (tsch(schid, &irb)) {
> -            /* Might want to differentiate error codes later on. */
> -            if (irb.scsw.cstat) {
> -                r =3D -EIO;
> -            } else if (irb.scsw.dstat !=3D 0xc) {
> -                r =3D -EIO;
> -            }
> -            return r;
> -        }
> +    switch (vdev.ipl_type) {

Wait, we're just accessing the global vdev directly here?

> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return drain_irqs_ccw(vr->schid);

In that case, what's the point of vr being passed in? Isn't vr->schid =3D=
=3D vdev->schid?

This makes me think that vr->schid is not needed, and it can just be pulled=
 from the vdev.

> +    default:
> +        return 0;
>      }
>  }
> =20
> -static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
> +int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>  {
> -    Ccw1 ccw =3D {};
> -
> -    ccw.cmd_code =3D cmd;
> -    ccw.cda =3D (long)ptr;
> -    ccw.count =3D len;
> -
> -    if (sli) {
> -        ccw.flags |=3D CCW_FLAG_SLI;
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_run(vdev, vqid, cmd);
> +    default:
> +        return -1;
>      }
> -
> -    return do_cio(vdev->schid, vdev->dev_type, ptr2u32(&ccw), CCW_FMT1);
>  }
> =20
> -static void vring_init(VRing *vr, VqInfo *info)
> +void vring_init(VRing *vr, VqInfo *info)
>  {
>      void *p =3D (void *) info->queue;
> =20
> @@ -134,7 +105,12 @@ static void vring_init(VRing *vr, VqInfo *info)
> =20
>  bool vring_notify(VRing *vr)
>  {
> -    vr->cookie =3D virtio_notify(vr->schid, vr->id, vr->cookie);
> +    switch (vdev.ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        vr->cookie =3D virtio_ccw_notify(vr->schid, vr->id, vr->cookie);
> +    }
> +
>      return vr->cookie >=3D 0;
>  }
> =20
> @@ -200,165 +176,24 @@ int vring_wait_reply(void)
>      return 1;
>  }
> =20
> -int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
> -{
> -    VRing *vr =3D &vdev->vrings[vqid];
> -    int i =3D 0;
> -
> -    do {
> -        vring_send_buf(vr, cmd[i].data, cmd[i].size,
> -                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
> -    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
> -
> -    vring_wait_reply();
> -    if (drain_irqs(vr->schid)) {
> -        return -1;
> -    }
> -    return 0;
> -}
> -
>  int virtio_reset(VDev *vdev)
>  {
> -    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
> -}
> -
> -int virtio_setup_ccw(VDev *vdev)
> -{
> -    int i, cfg_size =3D 0;
> -    uint8_t status;
> -    struct VirtioFeatureDesc {
> -        uint32_t features;
> -        uint8_t index;
> -    } __attribute__((packed)) feats;
> -
> -    if (!virtio_is_supported(vdev->schid)) {
> -        puts("Virtio unsupported for this device ID");
> -        return -ENODEV;
> -    }
> -    /* device ID has been established now */
> -
> -    vdev->config.blk.blk_size =3D 0; /* mark "illegal" - setup started..=
. */
> -    vdev->guessed_disk_nature =3D VIRTIO_GDN_NONE;
> -
> -    virtio_reset(vdev);
> -
> -    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE;
> -    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> -        puts("Could not write ACKNOWLEDGE status to host");
> -        return -EIO;
> -    }
> -
> -    switch (vdev->dev_type) {
> -    case VIRTIO_ID_NET:
> -        vdev->nr_vqs =3D 2;
> -        vdev->cmd_vr_idx =3D 0;
> -        cfg_size =3D sizeof(vdev->config.net);
> -        break;
> -    case VIRTIO_ID_BLOCK:
> -        vdev->nr_vqs =3D 1;
> -        vdev->cmd_vr_idx =3D 0;
> -        cfg_size =3D sizeof(vdev->config.blk);
> -        break;
> -    case VIRTIO_ID_SCSI:
> -        vdev->nr_vqs =3D 3;
> -        vdev->cmd_vr_idx =3D VR_REQUEST;
> -        cfg_size =3D sizeof(vdev->config.scsi);
> -        break;
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_reset(vdev);
>      default:
> -        puts("Unsupported virtio device");
> -        return -ENODEV;
> -    }
> -
> -    status |=3D VIRTIO_CONFIG_S_DRIVER;
> -    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> -        puts("Could not write DRIVER status to host");
> -        return -EIO;
> -    }
> -
> -    /* Feature negotiation */
> -    for (i =3D 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
> -        feats.features =3D 0;
> -        feats.index =3D i;
> -        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), fals=
e)) {
> -            puts("Could not get features bits");
> -            return -EIO;
> -        }
> -
> -        vdev->guest_features[i] &=3D bswap32(feats.features);
> -        feats.features =3D bswap32(vdev->guest_features[i]);
> -        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), fal=
se)) {
> -            puts("Could not set features bits");
> -            return -EIO;
> -        }
> -    }
> -
> -    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)=
) {
> -        puts("Could not get virtio device configuration");
> -        return -EIO;
> -    }
> -
> -    for (i =3D 0; i < vdev->nr_vqs; i++) {
> -        VqInfo info =3D {
> -            .queue =3D (unsigned long long) ring_area + (i * VIRTIO_RING=
_SIZE),
> -            .align =3D KVM_S390_VIRTIO_RING_ALIGN,
> -            .index =3D i,
> -            .num =3D 0,
> -        };
> -        VqConfig config =3D {
> -            .index =3D i,
> -            .num =3D 0,
> -        };
> -
> -        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
> -                false)) {
> -            puts("Could not get virtio device VQ config");
> -            return -EIO;
> -        }
> -        info.num =3D config.num;
> -        vring_init(&vdev->vrings[i], &info);
> -        vdev->vrings[i].schid =3D vdev->schid;
> -        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
> -            puts("Cannot set VQ info");
> -            return -EIO;
> -        }
> -    }
> -
> -    status |=3D VIRTIO_CONFIG_S_DRIVER_OK;
> -    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se)) {
> -        puts("Could not write DRIVER_OK status to host");
> -        return -EIO;
> +        return -1;
>      }
> -
> -    return 0;
>  }
> =20
> -bool virtio_is_supported(SubChannelId schid)
> +bool virtio_is_supported(VDev *vdev)
>  {
> -    vdev.schid =3D schid;
> -    memset(&vdev.senseid, 0, sizeof(vdev.senseid));
> -
> -    /*
> -     * Run sense id command.
> -     * The size of the senseid data differs between devices (notably,
> -     * between virtio devices and dasds), so specify the largest possibl=
e
> -     * size and suppress the incorrect length indication for smaller siz=
es.
> -     */
> -    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.sens=
eid),
> -                true)) {
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_is_supported(vdev->schid);
> +    default:
>          return false;
>      }
> -
> -    vdev.dev_type =3D vdev.senseid.cu_model;
> -
> -    if (vdev.senseid.cu_type =3D=3D 0x3832) {
> -        switch (vdev.dev_type) {
> -        case VIRTIO_ID_BLOCK:
> -        case VIRTIO_ID_SCSI:
> -        case VIRTIO_ID_NET:
> -            return true;
> -        default:
> -            return false;
> -        }
> -    }
> -    return false;
>  }
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index a0f24c94a8..259cff09db 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -34,7 +34,8 @@ QEMU_DGFLAGS =3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  .PHONY : all clean build-all distclean
> =20
>  OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o =
\
> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o =
\
> +	  virtio-ccw.o
> =20
>  SLOF_DIR :=3D $(SRC_PATH)/../../roms/SLOF
> =20

