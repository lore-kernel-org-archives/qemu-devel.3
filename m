Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B81FC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoR-00067B-67; Thu, 03 Sep 2026 15:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoK-0005zt-Bs; Thu, 03 Sep 2026 15:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004ys-Fc; Thu, 03 Sep 2026 15:09:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2xc91550802; Thu, 3 Sep 2026 19:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IfF6Bl
 2j0bQPHb6+XvDEutjxbtiw3/QkUMY+eQnxkFE=; b=prEYsL7XJlJUl1L+RXFkWb
 HBi595fsqTB4dfZpDI6nOASX7DnarApbL1/lVDcsfrlFbdE690quU0B7QnlklJiK
 QGg3B/Lu6UERO9ccfm9qHURZcg4Kq3LI6o/0yv9W2bKg1ADHjfjFU7SyTRIk0e9G
 BYgmS1dB2H434l8kFLchqs9h8VIQQAM34QKQQW+koTS12tjlNYyjEAbxWY/uu2qE
 Q0ApVMjyertEMFuBAoHpEaKi0YQr+YRUXr9nm9E7LbsrsKJNHU/ocqSU/oRACD1D
 8jtlKVJCtqrWM/egxCWi9cNPpd4Q9uFf5mCML63oNI+nX5jC0fPPNUC8mGah/q2w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rpmam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuHZU028150;
 Thu, 3 Sep 2026 19:09:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygryec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J990t33555086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95B9F58051;
 Thu,  3 Sep 2026 19:09:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24C825805C;
 Thu,  3 Sep 2026 19:09:09 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:09 +0000 (GMT)
Message-ID: <b08aa77e-6ce5-446a-9ced-1f107dad606d@linux.ibm.com>
Date: Thu, 3 Sep 2026 09:15:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] pc-bios/s390-ccw: Use bus specific IPL_TYPE
 directly for scsi IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-4-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99c5d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=tULXT7rEgByDIO15at8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXzqMcrwfb3T/c
 akVGMDE4VR/hsfZvgUqrtHQhqcnNU62pNc/9/Hs74H+d9EHmWBt0TK7x1zvRNCA7EmpTts4QHFp
 q/Z4esIp59WzjJsOFm1/tHnsCOf6gU0LLVGj0/s1VdeYOkPEqdB670AwTBOjKqLRaFiRabf5WxT
 LF4AVUOoe+d0Yd3veYoRr6Mk6TOGLAlYWyyeWR+yTbQNshdtSUvJt5GN0LIrIoRy51QM1yo7pdB
 8hw8hui5/2RwQBL9Hi72Yn66fwv+M4MBCttRMTjwqhmcHDVN2dohOPNy5TTQCGF7rNq2LRDCBB4
 upaFGFdsJdzTcFRZqlCP7zaLTQy7XCTR20E1dXH01im2GM2PhmGlE4ZNy9prMFouUR+msgWNAVM
 BGYgoYg+JA7gF3yy6f1uMnJvt9UE6G0gEDmoVPxzg5TytPLHc1Q1RtFr/HUOZthcOVkrALM38h2
 LCA3S3v9RIYdK8Wq7Rw==
X-Proofpoint-GUID: RzHoB30fEIuSga7fzVQ1b2T1jMGM2Yk0
X-Proofpoint-ORIG-GUID: RzHoB30fEIuSga7fzVQ1b2T1jMGM2Yk0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX1BB6fa9skjPb
 ZHkFlbo65lhk9KqDNNkSnB39FsI/KLc9TfJKkCqEYvNQNyG4nphj8d1ZP9JL1kNLYgpOx0+Fb4i
 9YLRkORVuw8nbVVjDeZSK0zF6RvkBzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
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
> All existing switch cases that handle S390_IPL_TYPE_QEMU_SCSI directly fall
> through to S390_IPL_TYPE_CCW.  Rather than always fall through, reassign
> vdev->ipl_type to the appropriate bus for the scsi controller and proceed
> as usual, where the bus is designated by the "bus" field and set during
> the IPLB build.
> 
> Because S390_IPL_TYPE_QEMU_SCSI should not appear as an ipl_type once the
> device is found, remove that specific case from other existing switches
> and allow it to land in the default case, which will generally result
> in an immediate error.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c          | 13 ++++++++++---
>   pc-bios/s390-ccw/virtio-blkdev.c |  1 -
>   pc-bios/s390-ccw/virtio.c        |  5 -----
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8fc1cbf653..6ab2b8f75b 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -261,8 +261,16 @@ static bool find_boot_device(void)
>           vdev->selected_scsi_device.channel = iplb->scsi.channel;
>           vdev->selected_scsi_device.target = iplb->scsi.target;
>           vdev->selected_scsi_device.lun = iplb->scsi.lun;
> -        blk_schid.ssid = iplb->scsi.ssid & 0x3;
> -        found = find_subch(iplb->scsi.devno);
> +        vdev->ipl_type = iplb->scsi.bus;
> +        switch (vdev->ipl_type) {
> +        case S390_IPL_TYPE_CCW:
> +            blk_schid.ssid = iplb->scsi.ssid & 0x3;
> +            found = find_subch(iplb->scsi.devno);
> +            break;
> +        default:
> +            puts("Unrecognized SCSI controller");
> +            break;
> +        }
>           break;
>        case S390_IPL_TYPE_PCI:
>           found = find_fid(iplb->pci.fid);
> @@ -346,7 +354,6 @@ static void ipl_pci_device(void)
>   static void ipl_boot_device(void)
>   {
>       switch (virtio_get_device()->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           ipl_ccw_device();
>           break;
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 98b6cec3a0..83a1185dd5 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -253,7 +253,6 @@ int virtio_blk_setup_device(VDev *vdev)
>       puts("Using virtio-blk.");
>   
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_setup(vdev);
>       case S390_IPL_TYPE_PCI:
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index a0d249db24..0b33544144 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -61,7 +61,6 @@ char *virtio_get_ring_area(int ring_num)
>   int drain_irqs(void)
>   {
>       switch (vdev.ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return drain_irqs_ccw(vdev.schid);
>       default:
> @@ -109,7 +108,6 @@ void vring_init(VRing *vr, VqInfo *info)
>   bool vring_notify(VRing *vr)
>   {
>       switch (vdev.ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
>           break;
> @@ -130,7 +128,6 @@ bool vring_notify(VRing *vr)
>   bool be_ipl(void)
>   {
>       switch (virtio_get_device()->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return true;
>       case S390_IPL_TYPE_PCI:
> @@ -231,7 +228,6 @@ int vring_wait_reply(void)
>   int virtio_reset(VDev *vdev)
>   {
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_reset(vdev);
>       case S390_IPL_TYPE_PCI:
> @@ -244,7 +240,6 @@ int virtio_reset(VDev *vdev)
>   bool virtio_is_supported(VDev *vdev)
>   {
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_is_supported(vdev);
>       case S390_IPL_TYPE_PCI:

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

