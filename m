Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B0AEE20B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voOTY-0005cU-To; Fri, 06 Feb 2026 11:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1voOTX-0005c8-Fy; Fri, 06 Feb 2026 11:14:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1voOTT-0006Rd-4L; Fri, 06 Feb 2026 11:14:29 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616Clwdn013135;
 Fri, 6 Feb 2026 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rWmslC
 O9ILl70z4eTpnXQImCigHCpsxJqsnnHk8yesU=; b=FsNS6wdWiaghnnGvA4NkNz
 TPPgIw7fdJuSmZQLz3WFAIh3BycchwT3eZz1V9ZxaarJSvkuRIhNqyW2mdszS0mQ
 HXhoYfqgwyL9P06lQRzaEC7nCeLePo6k/raGTy1lgtK94CIpw9lD0iXebs9ZF2Mo
 8fxhvFaZaXzs+NG+my9ZM/0AU4+m9IT6W/5blOmr4C0UuVB29NVi3HuqxR4cMC72
 0IyqstWSZfOxQP0a4kf2bNfiR0Wrqvc02R/aHE20KckF9sVAs6/bmistEU9/yJYF
 4jKdAc0bTVheAIcc+zt+KVKXBKB1ZppfovNGQ2hmb9Y+ng/Rwgv7c80zpYPOTzbg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h9762-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 16:14:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616FZ79j009198;
 Fri, 6 Feb 2026 16:14:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1veyex2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 16:14:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 616GEK9Q3015512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 16:14:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0AC58045;
 Fri,  6 Feb 2026 16:14:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAD9958056;
 Fri,  6 Feb 2026 16:14:19 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.130.235]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 16:14:19 +0000 (GMT)
Message-ID: <1a13623d1ae1744ba14c6b8f71c2d6b75728d463.camel@linux.ibm.com>
Subject: Re: [PATCH v3 10/14] pc-bios/s390-ccw: Introduce virtio-pci functions
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Fri, 06 Feb 2026 11:14:19 -0500
In-Reply-To: <20260127161547.459443-11-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-11-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6986135e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=5uILobFg11BtxNOoY8UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 63U5Mp_ifuzd0NtCSrMVbX8Io6tBytTG
X-Proofpoint-ORIG-GUID: 63U5Mp_ifuzd0NtCSrMVbX8Io6tBytTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExNSBTYWx0ZWRfX9eT1ag2fKeJ+
 BaHyu1Z7mb8BfN7JJIbxWm/+UdkNQ99M3B0orLpQLHTS2wmBptS6E0vgpqU68cAneDFJNPcEnr0
 5VB0/CQwdyG+kJgNwzSdRR22rw0l3XpOIcGvRVuSG2Z2X4daDoOsfD93h0/QG11A4HaAZNT0S4f
 AXlksRTIEEXy4tvP5KhLZR6KWarv+PQzxJlczCTp3pj92B2Hcw0Ghr9y5N6Nx4XjaaRHbqz3e4A
 KzEPhXDQDs1jHgqShtoQ5wSTiHx4bVSH0N5yetfueVSDJyMO3gDREHmRY8jtRKw67jQCbvbSWqu
 kMdq5PzgZ3k84RKoPcvdxXCbP2QGTibTJ5bclqtGgp3WNmEIgXXCY9gUlXe8oy5fgTfAbpc+2m9
 /7qdK01zM11gE334iiGM/LMRAD1IW7iyZEHAta1ziBOUOgddkVSEkeO763oTz2CRktvaWbgU7mk
 b5utnybgt5u3k0w87Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define common functionality for interacting with virtio-pci devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile     |   2 +-
>  pc-bios/s390-ccw/virtio-pci.c | 168 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-pci.h |  86 +++++++++++++++++
>  pc-bios/s390-ccw/virtio.h     |   1 +
>  4 files changed, 256 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>=20
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index a62fc9d766..3e5dfb64d5 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS =3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> =20
>  OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o =
\
>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o =
\
> -	  virtio-ccw.o clp.o pci.o
> +	  virtio-ccw.o clp.o pci.o virtio-pci.o
> =20
>  SLOF_DIR :=3D $(SRC_PATH)/../../roms/SLOF
> =20
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.=
c
> new file mode 100644
> index 0000000000..70abac0256
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -0,0 +1,168 @@
> +/*
> + * Functionality for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "helper.h"
> +#include "virtio.h"
> +#include "bswap.h"
> +#include "virtio-pci.h"
> +#include "s390-time.h"
> +#include <stdio.h>
> +
> +/* Variable offsets used for reads/writes to modern memory regions */
> +VirtioPciCap c_cap; /* Common capabilities  */
> +VirtioPciCap d_cap; /* Device capabilities  */
> +VirtioPciCap n_cap; /* Notify capabilities  */
> +uint32_t notify_mult;
> +uint16_t q_notify_offset;
> +
> +static int virtio_pci_set_status(uint8_t status)
> +{
> +    int rc =3D vpci_write_byte(c_cap.off + VPCI_C_OFFSET_STATUS, c_cap.b=
ar, status);
> +    if (rc) {
> +        puts("Failed to write virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_get_status(uint8_t *status)
> +{
> +    int rc =3D vpci_read_byte(c_cap.off + VPCI_C_OFFSET_STATUS, c_cap.ba=
r, status);
> +    if (rc) {
> +        puts("Failed to read virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +/* virtio spec v1.3 section 4.1.2.1 */
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
> +{
> +    switch (device_id) {
> +    case 0x1001:
> +        vdev->dev_type =3D VIRTIO_ID_BLOCK;
> +        break;
> +    case 0x1000: /* Other valid but currently unsupported virtio device =
types */
> +    case 0x1004:
> +    default:
> +        vdev->dev_type =3D 0;
> +    }
> +}
> +
> +int virtio_pci_reset(VDev *vdev)
> +{
> +    int rc;
> +    uint8_t status =3D VPCI_S_RESET;
> +
> +    rc =3D virtio_pci_set_status(status);
> +    rc |=3D virtio_pci_get_status(&status);
> +
> +    if (rc || status) {
> +        puts("Failed to reset virtio-pci device");
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +long virtio_pci_notify(int vq_id)
> +{
> +    uint32_t offset =3D n_cap.off + notify_mult * q_notify_offset;
> +    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
> +}
> +
> +/*
> + * Wrappers to byte swap common data sizes then write
> + */
> +int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data)
> +{
> +    return pci_write(virtio_get_device()->pci_fh, offset, pcias, (uint64=
_t) data, 1);
> +}
> +
> +int vpci_bswap16_write(uint64_t offset, uint8_t pcias, uint16_t data)
> +{
> +    uint64_t le_data =3D bswap16(data);
> +    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data=
, 2);
> +}
> +
> +int vpci_bswap32_write(uint64_t offset, uint8_t pcias, uint32_t data)
> +{
> +    uint64_t le_data =3D bswap32(data);
> +    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data=
, 4);
> +}
> +
> +int vpci_bswap64_write(uint64_t offset, uint8_t pcias, uint64_t data)
> +{
> +    uint64_t le_data =3D bswap64(data);
> +    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data=
, 8);
> +}
> +
> +/*
> + * Wrappers to read common data sizes then byte swap
> + */
> +int vpci_read_byte(uint64_t offset, uint8_t pcias, uint8_t *buf)
> +{
> +    return pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, 1);
> +}
> +
> +int vpci_read_bswap16(uint64_t offset, uint8_t pcias, uint16_t *buf)
> +{
> +    int rc =3D pci_read(virtio_get_device()->pci_fh, offset, pcias, buf,=
 2);
> +    *buf =3D bswap16(*buf);
> +    return rc;
> +}
> +
> +int vpci_read_bswap32(uint64_t offset, uint8_t pcias, uint32_t *buf)
> +{
> +    int rc =3D pci_read(virtio_get_device()->pci_fh, offset, pcias, buf,=
 4);
> +    *buf =3D bswap32(*buf);
> +    return rc;
> +}
> +
> +int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf)
> +{
> +    int rc =3D pci_read(virtio_get_device()->pci_fh, offset, pcias, buf,=
 8);
> +    *buf =3D bswap64(*buf);
> +    return rc;
> +}
> +
> +/*
> + * Read to an arbitrary length buffer without byte swapping
> + */
> +int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
> +{
> +    uint8_t readlen;
> +    int rc;
> +    int remaining =3D len;
> +
> +    /* Read bytes in powers of 2, up to a maximum of 8 bytes per read */
> +    while (remaining) {
> +        for (int i =3D 3; i >=3D 0; i--) {
> +            readlen =3D 1 << i;
> +            if (remaining >=3D readlen) {
> +                break;
> +            }
> +        }
> +
> +        rc =3D pci_read(virtio_get_device()->pci_fh, offset, pcias, buf,=
 readlen);
> +        if (rc) {
> +            return -1;
> +        }
> +
> +        remaining -=3D readlen;
> +        buf +=3D readlen;
> +        offset +=3D readlen;
> +    }
> +
> +    return 0;
> +}
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.=
h
> new file mode 100644
> index 0000000000..96c17ac3c7
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -0,0 +1,86 @@
> +/*
> + * Definitions for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIO_PCI_H
> +#define VIRTIO_PCI_H
> +
> +/* Common configuration */
> +#define VPCI_CAP_COMMON_CFG          1
> +/* Notifications */
> +#define VPCI_CAP_NOTIFY_CFG          2
> +/* ISR access */
> +#define VPCI_CAP_ISR_CFG             3
> +/* Device specific configuration */
> +#define VPCI_CAP_DEVICE_CFG          4
> +/* PCI configuration access */
> +#define VPCI_CAP_PCI_CFG             5
> +/* Additional shared memory capability */
> +#define VPCI_CAP_SHARED_MEMORY_CFG   8
> +/* PCI vendor data configuration */
> +#define VPCI_CAP_VENDOR_CFG          9
> +
> +/* Offsets within capability header */
> +#define VPCI_CAP_VNDR        0
> +#define VPCI_CAP_NEXT        1
> +#define VPCI_CAP_LEN         2
> +#define VPCI_CAP_CFG_TYPE    3
> +#define VPCI_CAP_BAR         4
> +#define VPCI_CAP_OFFSET      8
> +#define VPCI_CAP_LENGTH      12
> +
> +#define VPCI_N_CAP_MULT 16 /* Notify multiplier, VPCI_CAP_NOTIFY_CFG onl=
y */
> +
> +/* Common Area Offsets for virtio-pci queue */
> +#define VPCI_C_OFFSET_DFSELECT      0
> +#define VPCI_C_OFFSET_DF            4
> +#define VPCI_C_OFFSET_GFSELECT      8
> +#define VPCI_C_OFFSET_GF            12
> +#define VPCI_C_COMMON_NUMQ          18
> +#define VPCI_C_OFFSET_STATUS        20
> +#define VPCI_C_OFFSET_Q_SELECT      22
> +#define VPCI_C_OFFSET_Q_SIZE        24
> +#define VPCI_C_OFFSET_Q_ENABLE      28
> +#define VPCI_C_OFFSET_Q_NOFF        30
> +#define VPCI_C_OFFSET_Q_DESCLO      32
> +#define VPCI_C_OFFSET_Q_DESCHI      36
> +#define VPCI_C_OFFSET_Q_AVAILLO     40
> +#define VPCI_C_OFFSET_Q_AVAILHI     44
> +#define VPCI_C_OFFSET_Q_USEDLO      48
> +#define VPCI_C_OFFSET_Q_USEDHI      52
> +
> +#define VPCI_S_RESET            0
> +#define VPCI_S_ACKNOWLEDGE      1
> +#define VPCI_S_DRIVER           2
> +#define VPCI_S_DRIVER_OK        4
> +#define VPCI_S_FEATURES_OK      8

How are these status values different from VIRTIO_CONFIG_S_* in pc-bios/s39=
0-ccw/virtio.h? Maybe
expand that list instead?

The rest of this seems fine to me, though I do need another coffee.

> +
> +#define VIRTIO_F_VERSION_1      (1 << (32 - 32)) /* Feature bit 32 */
> +
> +struct VirtioPciCap {
> +    uint8_t bar;     /* Which PCIAS it's in */
> +    uint32_t off;    /* Offset within bar */
> +};
> +typedef struct VirtioPciCap  VirtioPciCap;
> +
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
> +int virtio_pci_reset(VDev *vdev);
> +long virtio_pci_notify(int vq_id);
> +
> +int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
> +int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
> +int vpci_read_bswap32(uint64_t offset, uint8_t pcias, uint32_t *buf);
> +int vpci_read_bswap16(uint64_t offset, uint8_t pcias, uint16_t *buf);
> +int vpci_read_byte(uint64_t offset, uint8_t pcias, uint8_t *buf);
> +
> +int vpci_bswap64_write(uint64_t offset, uint8_t pcias, uint64_t data);
> +int vpci_bswap32_write(uint64_t offset, uint8_t pcias, uint32_t data);
> +int vpci_bswap16_write(uint64_t offset, uint8_t pcias, uint16_t data);
> +int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data);
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 0fdee8468c..0c34d59be2 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -255,6 +255,7 @@ struct VDev {
>      uint8_t scsi_dev_heads;
>      bool scsi_device_selected;
>      ScsiDevice selected_scsi_device;
> +    uint32_t pci_fh;
>      uint32_t max_transfer;
>      uint32_t guest_features[2];
>  };

