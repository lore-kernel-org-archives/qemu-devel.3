Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA15CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOiv-0005fa-Rs; Thu, 15 Oct 2026 12:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xHOit-0005fL-Me; Thu, 15 Oct 2026 12:54:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xHOiq-00039S-Vr; Thu, 15 Oct 2026 12:54:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kopI3001265; Thu, 15 Oct 2026 16:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5zrU5f
 Z3PiqUFF8RwssqFwnlKJtToTrlJzD4b5BESak=; b=h19IxVCBYG2oyXzdkY0nzT
 y74Lk4zVMmG6bwI2oJOUsE0Lpct7vXUJ/qbD4EhyR9KPxvKddz7uVdoD/WaqS4CO
 uYbRWaMqWRe2FjbhKdXqTIvoTi+eXOUdovAKxGW0DVklewu9EdZdznJ6dyMOfnOo
 BOazLtIjqMTI+TmmgR83Oy6GeE+dgsAJwU992VJlCIpp9kVnQaHdMe+1w/S8pg39
 wVEC55fXoOBL8ehj+4W9VDbysoUdBbzWOv1Vm1UlYQgfPYIu7Pzk5AZjnVaixWID
 0elpwW5iu9WBqZE04tmEaV1FdCOggIbtQaPGyUsaEmsboK7USNM6U2HxoQSaWvgQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhu54u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 16:54:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG85uc2352089; Thu, 15 Oct 2026 16:54:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb23905kp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 16:54:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69FGraJV8782382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2026 16:53:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7345E58057;
 Thu, 15 Oct 2026 16:54:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E165E5805D;
 Thu, 15 Oct 2026 16:54:21 +0000 (GMT)
Received: from [9.61.99.49] (unknown [9.61.99.49])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Oct 2026 16:54:21 +0000 (GMT)
Message-ID: <b6ee502d-5749-439f-92f5-13110e5b85b8@linux.ibm.com>
Date: Thu, 15 Oct 2026 12:54:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: re-fetch DMA slot shadow count from VFIO
 upon IOMMU disable
To: Omar Elghoul <oelghoul@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, cam@linux.ibm.com, farman@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261007150416.13220-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261007150416.13220-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX4y1FkTGsPy2O
 /KtXRXgZsAPCciLtRxJobKkxsMqiY1jhb49Fs47PdfttUlCm3Z+8M7inBjr0Sh8Em9cH3sXExRb
 8lTvF/VU0sOxxqSwXXYtbn4ghHIHopE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX10H8ll0Zbq6F
 Gnlp+60wyZZt4yTE/mKWXhcxfovtMug/luVK/dceBllD+65jxlOv215nMmZk85kzlTeJsMsdVFH
 KtSZAj0JFK/i3Oe8XXmDVnutje6APbJ1HwwREUHp+DKpzr/t5hc6H7KuxJYs1j4GDGJGuiEiKu8
 ZigRgFondZYCwWzm0303djtKi44SRg0xq0Hc+MvfCxvRufoPvYCevYsIiZJTMJHLTw4vnfcB/lG
 Bimd26YUOR2DNHdTxpuDhd9GABmGXlZXkgjYVZwj2PoLIfI65vjsVSGBJXETPBFpq39ujLEFYY6
 4TgfjOcYg/1a9M2yu8fJ5M81321iiJAUV5rwPPqaj6BqOv4xMWWVRAC7bsT0SjafeZgiGzN6kZM
 oARabCJfZu1Ojnop9JLQE4ZSMSp0ovZpYpWR2WZf9RKO90TlQgVLzF8fwLkxRgcRtN7s0NPFrdb
 B6jbDI4OqxS51OhytUA==
X-Proofpoint-GUID: I5ulTX-lsOJ_gDk8SYwfov-_aeaSS0C0
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad10541 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=BLj5troBGk9AIOoPf2YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I5ulTX-lsOJ_gDk8SYwfov-_aeaSS0C0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150066
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 10/7/26 11:04 AM, Omar Elghoul wrote:
> s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
> mappings, but it doesn't reset the available DMA slot counter back to
> the VFIO-advertised limit. This is problematic when an IOMMU is disabled
> and re-enabled while reusing the container (e.g. during a guest reboot),
> which may cause the RPCIT path to fail with DMA slot exhaustion errors,
> manifesting as unexplained ENOMEMs in the guest.
> 
> Fix it by refactoring s390_pci_update_dma_avail() to take a pointer to
> S390PCIBusDevice instead of the plain file descriptor. Call it in
> s390_pci_iommu_disable() after the host mappings have been unpinned.
> 
> Further print a warning if the VFIO-advertised counter doesn't match the
> in-use shadow counter, to reduce the likelihood of introducing new
> similar DMA accounting bugs in the future.
> 

Thanks for digging into this.  Unfortunately it looks like this won't
apply after recent merges into master, can you please rebase for v2?

Also, one issue...

[...]

> -bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
> +bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail)
>  {
> +    VFIOPCIDevice *vpdev;
>      uint32_t argsz = sizeof(struct vfio_iommu_type1_info);
>      g_autofree struct vfio_iommu_type1_info *info = g_malloc0(argsz);
> +    int fd;
>  
> +    assert(pbdev);
>      assert(avail);
>  
> +    vpdev = VFIO_PCI_DEVICE(pbdev->pdev);

We can reach this for devices that are not associated with a vfio-pci
device (e.g. virtio-pci) and results in

/usr/src/qemu/hw/vfio/pci.h:123:VFIO_PCI_DEVICE: Object 0x2aa2d8a1410 is
not an instance of type vfio-pci-device
2026-10-15 16:44:18.851+0000: shutting down, reason=crashed

Thanks,
Matt

