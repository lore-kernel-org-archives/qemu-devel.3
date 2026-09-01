Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFCC624A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Edm-0001Nd-To; Mon, 31 Aug 2026 22:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1Edm-0001NM-1X; Mon, 31 Aug 2026 22:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1Edk-00051g-D9; Mon, 31 Aug 2026 22:54:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68111ooG2808688; Tue, 1 Sep 2026 02:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=o5e/TQ
 k0XlIYoaH+PfyBsnkXbXYIr6Sc0agJ+SX8AlQ=; b=F+KSxhuPmTqwvz1KudKXno
 7yCjYV80htn7gE4KEOQabEQBSYkJvQ6MRDQN1/lRFFP2w0nlcZhfQEmgss0aCJfZ
 +Jeo8X/qfIaCUYxW7XTT01a7QhBTZEIIH8DTCb1VGZaQLUoxbRSWEtUYEkGO4QMU
 v1mhpOkaq0b9BzzgU6SciIOmWSQgkxiYI1pTn4DG23z7AR/9itDX5TL38Fj0HWOa
 xmdNw7zcjVLQXESsY1bjYBKJjtTwrHDCqgrPjTbD4B3vB9D91KyjJLWhkz6TAtWo
 T+iXfvyvSbYoAXcMvMcEDVTQohH2JKIjjsTmcJxENtwZ7vP0ZrmfuLlrxeByd68g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudn8ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 02:54:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6812QLBd002861;
 Tue, 1 Sep 2026 02:54:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w1hp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 02:54:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6812sKuR41353716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 02:54:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 671AE58058;
 Tue,  1 Sep 2026 02:54:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCE5E58057;
 Tue,  1 Sep 2026 02:54:19 +0000 (GMT)
Received: from [9.61.253.112] (unknown [9.61.253.112])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 02:54:19 +0000 (GMT)
Message-ID: <445485b2-2bb3-424d-b087-0a9f3dc86312@linux.ibm.com>
Date: Mon, 31 Aug 2026 22:54:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] s390x: Find scsi-pci boot device and build IPLB
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: teFjToXY4jD0fd-B8Bxc9Tx6T9G-HyAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAyMCBTYWx0ZWRfXxZ2AAiVH6s2/
 FA1AviFyS+X+0LvVaxWTiVLvThdGdZKDJdl0G00Fbn8nYxDE3v5XgKCC+++KkwBdyzLGctz222i
 err5uJsrjR29p3IEseMN8n3Ira/Cm32uXNjIgKXOQuPTjlHLr+iYqe722/FWZgJNMgLpFraNs8W
 jCA6T17jUpTXVbJoSpP7vkj9vuPlDz+RGoQRuxxR7tfQbJ2z7XEXkoAy6YVvdfBXzcdRn002jKY
 ShL+5VIroWQWf0HV2X3cXc3FjszNo0q47RS4fgcp7FJyuwh5O+HK+Z7M001SW3DnjZ7G8ig7lej
 xKvSrbw3KhfNNE8vk/YdHiMTYwZO3otpYVapTNd2exUiJ8tG7mLKbakB5v59IlzILAYD1uuNVgL
 2IS4oRjcDzwghJIywChykg1Xi1RwgKqEpCBduj+mj7LuUKjacyk3Fkixla4MvZHiatHWUlbm3HY
 P+im0nfCcswySIn5crA==
X-Proofpoint-ORIG-GUID: teFjToXY4jD0fd-B8Bxc9Tx6T9G-HyAd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAyMCBTYWx0ZWRfXwFN7nZFFpQ5V
 +VMiGmkwiR13jZhMX/1rk0K/qpyQpaXmXIAnD70X0unk3UPgHweI2AMHtu9p8DAl/kQcqIdxhkD
 /a3m1c/mHnyhqdvCGBrIE2tePZt6svg=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a963e5e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=z2GIV3De8ZczWHra9CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/31/2026 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add logic to identify a virtio-pci scsi controller and target lun with
> assigned bootindex, then build IPLB for it.
> 
> Unfence PCI case for scsi devices in BIOS.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c          | 37 +++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/main.c |  3 +++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 6969e11b27..0cab043b12 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -402,6 +402,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>   }
>   
>   #define PCI_DEVTYPE_VIRTIO       0x05
> +#define PCI_DEVTYPE_SCSI         0x06
>   
>   static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
>   {
> @@ -417,6 +418,26 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
>               if (pbdev) {
>                   tmp_dt = PCI_DEVTYPE_VIRTIO;
>               }
> +        } else {
> +            SCSIDevice *sd = (SCSIDevice *)
> +                object_dynamic_cast(OBJECT(dev_st), TYPE_SCSI_DEVICE);
> +            if (sd) {
> +                SCSIBus *sbus = scsi_bus_from_device(sd);
> +                VirtIODevice *vdev = (VirtIODevice *)
> +                    object_dynamic_cast(OBJECT(sbus->qbus.parent),
> +                                                TYPE_VIRTIO_DEVICE);
Small nit: indentation is not quite right here.
TYPE_VIRTIO_DEVICE should align with OBJECT in the line above.

> +                if (vdev) {
> +                    pci_dev = (PCIDevice *)
> +                        object_dynamic_cast(OBJECT(qdev_get_parent_bus(DEVICE(vdev))->parent),
> +                                            TYPE_PCI_DEVICE);
> +                    if (pci_dev) {
> +                        pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
> +                        if (pbdev) {
> +                            tmp_dt = PCI_DEVTYPE_SCSI;
> +                        }
> +                    }
> +                }
> +            }
>           }
>       }
>       if (devtype) {
> @@ -621,6 +642,22 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->pbt = S390_IPL_TYPE_PCI;
>               iplb->pci.fid = cpu_to_be32(pbdev->fid);
>               break;
> +        case PCI_DEVTYPE_SCSI:
> +            sd = SCSI_DEVICE(dev_st);
> +            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
> +            if (scsi_lp && strlen(scsi_lp) > 0) {
> +                lp = scsi_lp;
> +            }
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
> +            iplb->blk0_len =
> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
> +            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> +            iplb->scsi.lun = cpu_to_be32(sd->lun);
> +            iplb->scsi.target = cpu_to_be16(sd->id);
> +            iplb->scsi.channel = cpu_to_be16(sd->channel);
> +            iplb->scsi.bus = S390_IPL_TYPE_PCI;
> +            iplb->scsi.fid = cpu_to_be32(pbdev->fid);
> +            break;
>           default:
>               return false;
>           }
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a2a24b024f..d2a2ac3138 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -267,6 +267,9 @@ static bool find_boot_device(void)
>               blk_schid.ssid = iplb->scsi.ssid & 0x3;
>               found = find_subch(iplb->scsi.devno);
>               break;
> +        case S390_IPL_TYPE_PCI:
> +            found = find_fid(iplb->scsi.fid);
> +            break;
>           default:
>               puts("Unrecognized SCSI controller");
>               break;


