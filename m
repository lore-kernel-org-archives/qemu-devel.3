Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A730C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoN-00062y-9W; Thu, 03 Sep 2026 15:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoK-0005zv-FA; Thu, 03 Sep 2026 15:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004zh-Gv; Thu, 03 Sep 2026 15:09:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2QAe3425605; Thu, 3 Sep 2026 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2hAlVR
 GcTH0Hma2MKGDzl7TpblizVfR6OEOwRLnS1EI=; b=dl4ArYDXH9RpI9LFCc7qq3
 gDtpCwMy2RlzO9G9+2MKhZwdX53mVFZo3Frxt8QKdRNZ53tkO+d3/6AYMsaPppAn
 x1CfyiZQJ+C0Kqm9QN+yxWbuJwxtb9UepbDdyWbunvCqwpMGATy5L62IrW/rGN9n
 K4gVeIY0fEBkVICfOTEFLDa4zpX+c3C2aiGH88L2m7pBtcpP68qSPPfBBVJuQyX8
 TjbJ4WGNfZdiwTesAQpcImHi8AeTuvWGg1OuMX2a7uYhoMqBjlS5H6TQQRIIisaw
 7IhuX41XPmi7mKi0fyzF7Ml21+B0nEgAlcnYgUNQV4LQv7kkEppRMWk/8yFvKQNw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq556pqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuKP3002300;
 Thu, 3 Sep 2026 19:09:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqs9g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J9BaJ13894394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F9B58051;
 Thu,  3 Sep 2026 19:09:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E99DE5805A;
 Thu,  3 Sep 2026 19:09:10 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:10 +0000 (GMT)
Message-ID: <7797d54b-9e08-4e96-8575-3414203f808a@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:04:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] pc-bios/s390-ccw: Add support for virtio-scsi-pci
 IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-7-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXzLvDiIKXiLOw
 4mdnvAm+VxM9Hkte3NLdYDx0Lb5TPyO7Fj1VrvoRkWse8QdqbJf5XOfJdwdoWJjVYu7qeVDYdSE
 LUgATAD8ko37H66ZmMFUj6CUCVAIH+iL2xdgdFEAduAzinMr5Z3oRIbJInsJX123NIFVS296J/F
 /diw0a1mpaD5vTBGJH8XE15S35JLHOAdRJPVRre4OMiahNEXCcwvzjNsZ/N6DYbGx4Jg87POpyl
 yiOVel0wbIku3+Mj4vVe5gCYJRypIfnXoGKmqTxPfagGaWzhlcNZoU3zbUcUCnbXV4coBzLgKX1
 8jerHjBYTH9/z/Mm+GNSyaeu5/h0uYdRgmMoiPG3Wz6JEX16mOogx7lk/Vb0cYyl9ETDUf/qS5U
 /vrntnn8sqW+sxgxzBYnDg4e4Y0ydsPIjLD47ZyudefN7k55eXcEAr+kRWEqolTduLslm9Y2VbI
 g/t8Q7sZUNG9yPYf8LA==
X-Proofpoint-ORIG-GUID: p4QC5KADFv90gRepB40HsM1Fa34YL3oc
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99c5da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IUq3LbfTMRt0A4Tc6esA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p4QC5KADFv90gRepB40HsM1Fa34YL3oc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXwXbdUiviMtdu
 QVs1PkmUEQ4BGcWVuPa0D0yTPfqRjZJ03XV0u45cEO5Q6h6tLTJLJvkVj4HgMy+lactSR3uhR4g
 u8NoxG38q2qKe+wN0K/+w45w2cDiQMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Read virtio-pci configuration and configure virt-queue for scsi devices.
> 
> Also add check for virtio setup failures when doing scsi setup and return
> early if it fails instead of waiting for subsequent failure.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c        |  3 ++-
>   pc-bios/s390-ccw/virtio-pci.c  | 30 ++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-scsi.c | 18 +++++++++++++++++-
>   3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 6ab2b8f75b..a2a24b024f 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -273,6 +273,7 @@ static bool find_boot_device(void)
>           }
>           break;
>        case S390_IPL_TYPE_PCI:
> +        vdev->scsi_device_selected = false;
>           found = find_fid(iplb->pci.fid);
>           break;
>       default:
> @@ -333,13 +334,13 @@ static void ipl_pci_device(void)
>   {
>       VDev *vdev = virtio_get_device();
>       vdev->is_cdrom = false;
> -    vdev->scsi_device_selected = false;
>   
>       if (virtio_pci_setup_device()) {
>           return;
>       }
>   
>       switch (vdev->dev_type) {
> +    case VIRTIO_ID_SCSI:
>       case VIRTIO_ID_BLOCK:
>           if (virtio_setup() == 0) {
>               zipl_load(); /* only return on error */
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index 231ab6e04d..277c3ea68d 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>       case 0x1001:
>           vdev->dev_type = VIRTIO_ID_BLOCK;
>           break;
> +    case 0x1048:
> +    case 0x1004:
> +        vdev->dev_type = VIRTIO_ID_SCSI;
> +        break;
>       default:
>           vdev->dev_type = 0;
>       }

I normally dislike magic numbers, but the meaning here is clear enough, 
and the comment above the function is a good enough pointer to the 
source of the magic, in my opinion:

/* virtio spec v1.3 section 4.1.2.1 */
void virtio_pci_id2type(VDev *vdev, uint16_t device_id)

So lgtm :)

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


