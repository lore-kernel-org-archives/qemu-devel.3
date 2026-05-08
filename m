Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D0CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOvU-0007TQ-C9; Fri, 08 May 2026 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOvR-0007T7-A8; Fri, 08 May 2026 13:23:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOvP-0003Ko-D5; Fri, 08 May 2026 13:23:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648Du0wZ3027857; Fri, 8 May 2026 17:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hmPYjk
 h+2UkaTsqN5/sL8/C0doPyfjGox71YYcJn1kY=; b=SgAEMwTcAZpwIX/q2eZ0Vm
 9ZT3E/UmdPffLgVLIVIsmhYaDr6DZXK7FNmrjCiOOTzTTTJQqg8Z+Zj+w8cG0M2i
 cDKf4skXHukIE3dlyqMq/aKt7BsMAf+to0DZaBwFrZlty+zl9rr02OJTMdZSdr7V
 us3nJPddCWQkyFAylJRrS4pIcEk8P6wr/U9O9OhDcpQsABlLQZiC0C4ze3ISrST1
 gTyZQFRRmESnq9dvN72Lco5B79sCOHMNuu4GrPdghmBPmRaxugMzheHSlJAs+nHB
 9NCDEkoibvfuqRRVnxbU/J7fAbaH28DUHAISXP6qBgVVlFFz1GDibyaFyRFtWTQw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy3f93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:23:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648H9QcW025240;
 Fri, 8 May 2026 17:23:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk963e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:23:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648HNd1X29229602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 17:23:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44A295805F;
 Fri,  8 May 2026 17:23:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D6A158054;
 Fri,  8 May 2026 17:23:38 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 17:23:38 +0000 (GMT)
Message-ID: <0f872fd5ae16db2dac3239f9b1820f4d3f2127db.camel@linux.ibm.com>
Subject: Re: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset
 for multi-queue virtio configurations
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
Date: Fri, 08 May 2026 13:23:37 -0400
In-Reply-To: <20260504221613.826825-3-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX5DJndyymLb9p
 PwXfvtXsmoCc6ebOA6VwOSrggvuuVUS2ekpDptthjNhzD28elshDXi4nVyZIcmjWMIqeOvNpR4z
 9Pk1cnIFosOFWRy8BAsMA0rugdOjzag5jykhseeZzyknmS3Ae2HKYL1K+br5nYUUApWdMvKdjB4
 Pp5ROWhzX5kdPbu4zxEgAUiitHPkSS9ok4CaFGLX0fhJrLzbBuTA12yQRyIaT1GbFSiw5iOY0h7
 hIaN8M+mCGk5mQ1gqWr+cvlW5lnbHsHh1bR0VKnKWAliaioJPMCftNErfwAZC7Sh+I4G7vtKRh1
 1JqydQEyixXfQjMVLidzvYU2HkQ69krK/tckqDsC5R4MpcPHzoqhPt/jlRae1wiqaJEmRC/g/UR
 pDCrLdySoaUO/mRoPUMuMmN8kSKdMhcBkxdGyHPElo3Gwht5m1mjaj3FWC2mKhaJMICLH5v+8w2
 HpJgEMNiHV13MNORIWA==
X-Proofpoint-ORIG-GUID: 11wrdxhR6vUCpDbuEHhSGpo3tz22HeZ3
X-Proofpoint-GUID: 11wrdxhR6vUCpDbuEHhSGpo3tz22HeZ3
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fe1c1d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YkybD2OV0nDwmGFSmDkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> The initial support for virtio-blk-pci IPL devices used a single virt-que=
ue, but
> other device types require multiple queues, and for PCI device types this=
 also
> requires a per-queue notification offset.
>=20
> Add a PCI notify field to the VRing struct so that each queue has a uniqu=
e
> notify offset.  Also re-select the target queue before writing buffers to
> ensure the proper queue is active.

Why is this patch 2/5, when the series is n/6?

>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-pci.c | 36 ++++++++++++++++++++++-------------
>  pc-bios/s390-ccw/virtio-pci.h |  3 ++-
>  pc-bios/s390-ccw/virtio.c     |  4 +++-
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  4 files changed, 29 insertions(+), 15 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.=
c
> index 53bdb52e76..736869f4f5 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -74,10 +74,10 @@ int virtio_pci_reset(VDev *vdev)
>      return 0;
>  }
> =20
> -long virtio_pci_notify(int vq_id)
> +long virtio_pci_notify(VRing *vr)
>  {
> -    uint32_t offset =3D n_cap.off + notify_mult * q_notify_offset;
> -    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
> +    uint32_t offset =3D n_cap.off + notify_mult * vr->pci_notify;
> +    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);

You no longer need the q_notify_offset variable nor the read into it.
(Ah, Joy already pointed this out; nice!)

>  }
> =20
>  /*
> @@ -166,7 +166,7 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, vo=
id *buf, int len)
>      return 0;
>  }
> =20
> -static int vpci_set_selected_vq(uint16_t queue_num)
> +int vpci_set_selected_vq(uint16_t queue_num)
>  {
>      return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.=
bar, queue_num);
>  }
> @@ -332,7 +332,6 @@ int virtio_pci_setup(VDev *vdev)
>      VRing *vr;
>      int rc;
>      uint8_t status;
> -    uint16_t vq_size;
>      int i =3D 0;
> =20
>      vdev->guessed_disk_nature =3D VIRTIO_GDN_NONE;
> @@ -380,28 +379,39 @@ int virtio_pci_setup(VDev *vdev)
>          return -EIO;
>      }
> =20
> -    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
> -        puts("Failed to read virt-queue configuration");
> -        return -EIO;
> -    }
> -
>      /* Configure virt-queues for pci */
>      for (i =3D 0; i < vdev->nr_vqs; i++) {
> +        uint16_t vq_size;
> +        uint16_t vq_notify;
>          VqInfo info =3D {
>              .queue =3D (unsigned long long) virtio_get_ring_area(i),
>              .align =3D KVM_S390_VIRTIO_RING_ALIGN,
>              .index =3D i,
> -            .num =3D vq_size,
> +            .num =3D 0,
>          };
> =20
>          vr =3D &vdev->vrings[i];
> -        vring_init(vr, &info);
> =20
> -        if (vpci_set_selected_vq(vr->id)) {
> +        if (vpci_set_selected_vq(i)) {
>              puts("Failed to set selected virt-queue");
>              return -EIO;
>          }
> =20
> +        if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)=
) {
> +            puts("Failed to read virt-queue configuration");
> +            return -EIO;
> +        }
> +
> +        info.num =3D vq_size;
> +
> +        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.ba=
r, &vq_notify)) {
> +            puts("Failed to read virt-queue configuration");
> +            return -EIO;
> +        }

For either of these error exits, do you need an identifier logged as to -wh=
ich- virtqueue failed, as
you're in a loop?

> +
> +        vr->pci_notify =3D vq_notify;
> +        vring_init(vr, &info);
> +
>          rc =3D set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
>          rc |=3D set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
>          rc |=3D set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.=
h
> index 90d07cb9a7..993fc285ac 100644
> --- a/pc-bios/s390-ccw/virtio-pci.h
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -62,9 +62,10 @@ struct VirtioPciCap {
>  };
>  typedef struct VirtioPciCap  VirtioPciCap;
> =20
> +int vpci_set_selected_vq(uint16_t queue_num);
>  void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
>  int virtio_pci_reset(VDev *vdev);
> -long virtio_pci_notify(int vq_id);
> +long virtio_pci_notify(VRing *vr);
>  int virtio_pci_setup(VDev *vdev);
>  int virtio_pci_setup_device(void);
> =20
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 30e6b2bc16..00850acc2f 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -114,7 +114,8 @@ bool vring_notify(VRing *vr)
>          vr->cookie =3D virtio_ccw_notify(vdev.schid, vr->id, vr->cookie)=
;
>          break;
>      case S390_IPL_TYPE_PCI:
> -        vr->cookie =3D virtio_pci_notify(vr->id);
> +        vr->cookie =3D virtio_pci_notify(vr);
> +        break;
>      default:
>          return 1;
>      }
> @@ -154,6 +155,7 @@ static void vr_bswap_descriptor(VRingDesc *desc)
>  void vring_send_buf(VRing *vr, void *p, int len, int flags)
>  {
>      if (!be_ipl()) {
> +        vpci_set_selected_vq(vr->id);
>          vr->avail->idx =3D bswap16(vr->avail->idx);
>      }
> =20
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index d32a4830ca..75ae5bdbc2 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -107,6 +107,7 @@ struct VRing {
>      VRingUsed *used;
>      long cookie;
>      int id;
> +    uint16_t pci_notify;
>  };
>  typedef struct VRing VRing;
> =20

