Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3697FCD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 01:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLWJ6-0005q8-OX; Fri, 08 May 2026 21:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLWJ4-0005o9-L1; Fri, 08 May 2026 21:16:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLWJ2-0001I0-FO; Fri, 08 May 2026 21:16:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648EsgWa2503246; Sat, 9 May 2026 01:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p58GKm
 dpoNE6O/HxwgyoiRhehxrK3yLCqIe44vfn8lk=; b=r4M82mbHpe5NPISHk7xMkY
 96c5SwE+xxDOi0pQqJH455mp/ToHPWVr0grRorP5m6vPRDTsFc6FcTmALi8QI6w0
 t5cOzM3IUiPbLzomZrxooL7ND3bZLjaabcXoSQEGtSWQMKmnKOASdk9fmYhGfqGM
 hTIogseVzaP7ZGQYgYdWgXtxbczqH0fg/XGyo/XQHEibwkiKnuxKGHJYO0LZeNW6
 b9it1K93w1gXctfZgWb4vTAhX9fJvI8qDuuwPxBeY7utMkauvciWfkJaFpBRSx9D
 x1jukiZ9HHxRQklm0RdZQEEB9GLqpN3Qir2hs8LFZnpHqfekSQKBdxOQvI75bF4A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1x656-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 01:16:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64919hHg020387;
 Sat, 9 May 2026 01:16:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgtceu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 01:16:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6491GVqa30278340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 01:16:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F9DF5805C;
 Sat,  9 May 2026 01:16:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DED55805E;
 Sat,  9 May 2026 01:16:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  9 May 2026 01:16:30 +0000 (GMT)
Message-ID: <60502b8ce770a418bd8c66f3b236e15bcbda6892.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] s390x: Introduce PCI SCSI IPLB and boot type
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
Date: Fri, 08 May 2026 21:16:30 -0400
In-Reply-To: <20260504221613.826825-5-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tbdiDEQIoFE0crpy28M1XgHNowuHvOHL
X-Proofpoint-GUID: tbdiDEQIoFE0crpy28M1XgHNowuHvOHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwOSBTYWx0ZWRfX2p5xyur0GsCX
 aD9RWAyeatyk6QbRLvjlCiYGZYqQqEa0cN1Cee3ODrAK3XaVlBJxFkagT4xIqj3Z5ba8LqTQG6+
 VznKq19SJ9Ntx6ipliro8vd75QIKjYCaS6GPB0ZtRB4SvZRhqWuakcoAjregt+kW7W3FkC8XXwm
 v0tsvbeXoYxwgABmLlw760t6ngK2R7QzNNma83xgrs/lielVnK9s3jaZvVO+/QHL7U7obNH2XfW
 ycwdkeFumGQl5RGo0Be0+YUJmZpvGFIZXCi7qtXMTcxN+qOyem9fwbaHbf4jJythjqHskg+RKJG
 IWXZDGx0pwAFjFnceneKNA9LqD2Ico2UjfhYkPSR5vMH0bUy//Pi9CY6wnjcYnVj1MJMTEhRnRr
 hSLx76mmBp9t5ruuM32KkhGUfsmRPxNraThMWB3BLgxFdCDSpBABEWnFDu4PGMVvBC7ikQ2KcRJ
 hRPObo90PA5RYvGYHKQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fe8af1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=6Bxsp5yC6BjMQxoAau0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-05-04 at 18:16 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define a new IPLB format for SCSI PCI devices and add cases to handle it.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h    | 15 +++++++++++++++
>  pc-bios/s390-ccw/main.c        | 11 ++++++++++-
>  pc-bios/s390-ccw/virtio-pci.c  | 29 +++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-scsi.c | 14 +++++++++++++-
>  pc-bios/s390-ccw/virtio.c      |  5 +++++
>  5 files changed, 72 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 67db54c964..951c5e2d8e 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -25,6 +25,7 @@ enum S390IplType {
>      S390_IPL_TYPE_CCW =3D 0x02,
>      S390_IPL_TYPE_PCI =3D 0x04,
>      S390_IPL_TYPE_PV =3D 0x05,
> +    S390_IPL_TYPE_PCI_SCSI =3D 0xfe,
>      S390_IPL_TYPE_CCW_SCSI =3D 0xff
>  };
>  typedef enum S390IplType S390IplType;
> @@ -117,6 +118,19 @@ struct IplBlockPci {
>  } QEMU_PACKED;
>  typedef struct IplBlockPci IplBlockPci;
> =20
> +struct IplBlockPciScsi {
> +    uint32_t lun;
> +    uint16_t target;
> +    uint16_t channel;
> +    uint8_t  reserved0[74];
> +    uint8_t  opt;
> +    uint8_t  reserved1[3];
> +    uint32_t fid;
> +    uint8_t  ssid;
> +    uint16_t devno;
> +} QEMU_PACKED;
> +typedef struct IplBlockPciScsi IplBlockPciScsi;

Now that I get to the point where I see why you renamed the ...QemuScsi str=
uct in patch one, I'm
struggling.

This combines the PCI stuff in IplBlockPci, with the CCW (!) and SCSI stuff=
 in IplBlockCcwScsi (nee
IplBlockQemuScsi). Some of the stuff (ssid, devno) isn't needed for PCI, an=
d I find myself wondering
what the "right" struct should look like...

Can we add the PCI stuff to a (generalized) struct that's just "IplBlockScs=
i" and have fields that
are specific to -ccw or -pci? That's basically what IplBlockPciScsi is, eve=
n though it's not used
that way. Or is it better that there's overlap between Ccw/CcwScsi (e.g., o=
ffsetof(Ccw.ssid) =3D=3D
offsetof(CcwScsi.ssid)) and Pci/PciScsi? If the latter, there's quite a bit=
 of difference in their
layouts, e.g., the location of the opt and fid fields. That worries me...

> +
>  union IplParameterBlock {
>      struct {
>          uint32_t len;
> @@ -133,6 +147,7 @@ union IplParameterBlock {
>              IPLBlockPV pv;
>              IplBlockCcwScsi ccw_scsi;
>              IplBlockPci pci;
> +            IplBlockPciScsi pci_scsi;
>          };
>      } QEMU_PACKED;
>      struct {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 1a9579beab..b2bc35962a 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -257,7 +257,15 @@ static bool find_boot_device(void)
>          blk_schid.ssid =3D iplb.ccw_scsi.ssid & 0x3;
>          found =3D find_subch(iplb.ccw_scsi.devno);
>          break;
> +     case S390_IPL_TYPE_PCI_SCSI:
> +        vdev->scsi_device_selected =3D true;
> +        vdev->selected_scsi_device.channel =3D iplb.pci_scsi.channel;
> +        vdev->selected_scsi_device.target =3D iplb.pci_scsi.target;
> +        vdev->selected_scsi_device.lun =3D iplb.pci_scsi.lun;
> +        found =3D find_fid(iplb.pci_scsi.fid);

...because of this. I don't see iplb.pci_scsi.fid set anywhere. Patch 5 set=
s ipl.pci.fid, but that's
at a different offset within the respective structs in that union.

> +        break;
>       case S390_IPL_TYPE_PCI:
> +        vdev->scsi_device_selected =3D false;
>          found =3D find_fid(iplb.pci.fid);
>          break;
>      default:
> @@ -318,13 +326,13 @@ static void ipl_pci_device(void)
>  {
>      VDev *vdev =3D virtio_get_device();
>      vdev->is_cdrom =3D false;
> -    vdev->scsi_device_selected =3D false;
> =20
>      if (virtio_pci_setup_device()) {
>          return;
>      }
> =20
>      switch (vdev->dev_type) {
> +    case VIRTIO_ID_SCSI:
>      case VIRTIO_ID_BLOCK:
>          if (virtio_setup() =3D=3D 0) {
>              zipl_load(); /* only return on error */
> @@ -343,6 +351,7 @@ static void ipl_boot_device(void)
>      case S390_IPL_TYPE_CCW:
>          ipl_ccw_device();
>          break;
> +    case S390_IPL_TYPE_PCI_SCSI:
>      case S390_IPL_TYPE_PCI:
>          ipl_pci_device();
>          break;
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.=
c
> index 736869f4f5..01a1401ef2 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -53,6 +53,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id=
)
>      case 0x1001:
>          vdev->dev_type =3D VIRTIO_ID_BLOCK;
>          break;
> +    case 0x1048:
> +    case 0x1004:
> +        vdev->dev_type =3D VIRTIO_ID_SCSI;
> +        break;
>      default:
>          vdev->dev_type =3D 0;
>      }
> @@ -200,6 +204,26 @@ static int virtio_pci_get_blk_config(void)
>      return rc;
>  }
> =20
> +static int virtio_pci_get_scsi_config(void)
> +{
> +    VirtioScsiConfig *cfg =3D &virtio_get_device()->config.scsi;
> +    int rc =3D vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioSc=
siConfig));
> +
> +    /* all fields of scsi config must be byte swapped */
> +    cfg->num_queues =3D bswap32(cfg->num_queues);
> +    cfg->seg_max =3D bswap32(cfg->seg_max);
> +    cfg->max_sectors =3D bswap32(cfg->max_sectors);
> +    cfg->cmd_per_lun =3D bswap32(cfg->cmd_per_lun);
> +    cfg->event_info_size =3D bswap32(cfg->event_info_size);
> +    cfg->sense_size =3D bswap32(cfg->sense_size);
> +    cfg->cdb_size =3D bswap32(cfg->cdb_size);
> +    cfg->max_channel =3D bswap16(cfg->max_channel);
> +    cfg->max_target =3D bswap16(cfg->max_target);
> +    cfg->max_lun =3D bswap32(cfg->max_lun);
> +
> +    return rc;
> +}
> +
>  static int virtio_pci_negotiate(void)
>  {
>      int i, rc;
> @@ -367,6 +391,11 @@ int virtio_pci_setup(VDev *vdev)
>          vdev->cmd_vr_idx =3D 0;
>          virtio_pci_get_blk_config();
>          break;
> +    case VIRTIO_ID_SCSI:
> +        vdev->nr_vqs =3D 3;
> +        vdev->cmd_vr_idx =3D 2;
> +        virtio_pci_get_scsi_config();
> +        break;
>      default:
>          puts("Unsupported virtio device");
>          return -ENODEV;
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scs=
i.c
> index 9ea00c6fe6..09d2caa879 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -16,6 +16,7 @@
>  #include "scsi.h"
>  #include "virtio-scsi.h"
>  #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>  #include "s390-time.h"
>  #include "helper.h"
> =20
> @@ -479,7 +480,18 @@ static int virtio_scsi_setup(VDev *vdev)
> =20
>  int virtio_scsi_setup_device(VDev *vdev)
>  {
> -    virtio_ccw_setup(vdev);
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_CCW_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        virtio_ccw_setup(vdev);
> +        break;
> +    case S390_IPL_TYPE_PCI_SCSI:
> +    case S390_IPL_TYPE_PCI:
> +        virtio_pci_setup(vdev);
> +        break;
> +    default:
> +        return 1;
> +    }
> =20
>      if (vdev->config.scsi.sense_size !=3D VIRTIO_SCSI_SENSE_SIZE) {
>          puts("Config: sense size mismatch");
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 79dccdcbfc..598768d12b 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -89,6 +89,8 @@ static int virtio_do_run(VDev *vdev, int vqid, VirtioCm=
d *cmd)
>  int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>  {
>      switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_PCI_SCSI:
> +    case S390_IPL_TYPE_PCI:
>      case S390_IPL_TYPE_CCW_SCSI:
>      case S390_IPL_TYPE_CCW:
>          return virtio_do_run(vdev, vqid, cmd);
> @@ -130,6 +132,7 @@ bool vring_notify(VRing *vr)
>      case S390_IPL_TYPE_CCW:
>          vr->cookie =3D virtio_ccw_notify(vdev.schid, vr->id, vr->cookie)=
;
>          break;
> +    case S390_IPL_TYPE_PCI_SCSI:
>      case S390_IPL_TYPE_PCI:
>          vr->cookie =3D virtio_pci_notify(vr);
>          break;
> @@ -150,6 +153,7 @@ bool be_ipl(void)
>      case S390_IPL_TYPE_CCW_SCSI:
>      case S390_IPL_TYPE_CCW:
>          return true;
> +    case S390_IPL_TYPE_PCI_SCSI:
>      case S390_IPL_TYPE_PCI:
>          return false;
>      default:
> @@ -252,6 +256,7 @@ int virtio_reset(VDev *vdev)
>      case S390_IPL_TYPE_CCW_SCSI:
>      case S390_IPL_TYPE_CCW:
>          return virtio_ccw_reset(vdev);
> +    case S390_IPL_TYPE_PCI_SCSI:
>      case S390_IPL_TYPE_PCI:
>          return virtio_pci_reset(vdev);
>      default:

