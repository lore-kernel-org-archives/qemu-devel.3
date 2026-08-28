Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F469C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x021w-0002p6-AX; Fri, 28 Aug 2026 15:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x021t-0002oO-QO; Fri, 28 Aug 2026 15:14:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x021s-00083Y-6c; Fri, 28 Aug 2026 15:14:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGVYNK2491403; Fri, 28 Aug 2026 19:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P7Yikz
 iFt9zjnwaNI3jwtTTAKPHBbTINf2zdWzxxSd4=; b=KsHGzMngcjsV41EeaXlHTA
 bLqPPMPPbZpSHd1UJEOOBwkx915ymVJhA4SFPMmHR2qNWnd5iY2H2HDiXj2MUJ++
 l4gHEay3DWhkNNzO9goLw+8VpIoTBdnhSHp0/7wpJBnJBvFS2zSTyIillIvM3d5n
 hCcUYhpQqw8eGyUTeivvdqg0WsPzv6Q1/ltlaRmLImNFmTChw3XZWsCiTbOJEw9P
 sfd6gjhu9BhQTrhIIqHPVvemMlmPRlV5QmlRQ+N/cAW3uQbUsoMp/2qZ/W0aG0oO
 3lYbVNRtynrRrKhAFQA5baMl/9cybe9gce6lyIHP2vlallgGV2YonVta36R7Td0w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jeprg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 19:14:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SJBhAM025084;
 Fri, 28 Aug 2026 19:14:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qrjf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 19:14:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67SJED3p23528096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 19:14:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4170558052;
 Fri, 28 Aug 2026 19:14:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B5E58045;
 Fri, 28 Aug 2026 19:14:11 +0000 (GMT)
Received: from [9.61.147.148] (unknown [9.61.147.148])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 19:14:11 +0000 (GMT)
Message-ID: <a2d15e9a-88a3-4e30-bf49-efb1716cf8f7@linux.ibm.com>
Date: Fri, 28 Aug 2026 13:00:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] hw/virtio: Add "loadparm" property to virtio net
 PCI devices booting on s390x
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-6-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260818205324.580199-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE2NiBTYWx0ZWRfX+qUgwfcmzzJU
 eWkIaW5w8Z4UyDO6P5CBIFVUhCHNoFqvfYZst6sezJEHS9lG5/8jpP+qNW28ovvseHRMxMbQ5pO
 x+JtlvIzCtW3lzt9g63X4gma/9MUjWM=
X-Proofpoint-GUID: Q2B7tYt6U5gX0jwsM3djpOBXGxPQVptB
X-Proofpoint-ORIG-GUID: Q2B7tYt6U5gX0jwsM3djpOBXGxPQVptB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE2NiBTYWx0ZWRfX5PCfz88mjyWt
 mrRdyFKP3aAADeEZjOJczbMY2eg97Bjv6OSOz4GYFnAnQuBUY21VYJUn70SVQDLxExvRNmdtVZx
 5bRr+H4zLuanZsfdLd3KLm1Pef2Kb8mhwQPhcrZi3uRMymExm5lusAb2h1fKnMWpta++uXSFXPp
 reLldTI5OKoeYUcZB3vEIHISWqgfKtn7Oy7uQ2UCa/7pfykfFNV7/fYor2B9DvpC2GGJT+I12eu
 PZlHrlyR4bZ2wTGbfZW29CrX0Qs5PGdYEV6+dHNeEeJYKYE2KnK+S9WmvNnx7Wut6khesLbVDF9
 AKRdHYYMfwd9pP5+yLVriepAk2XQExl9ECkpKEBvxrdCMY6Hu0QxOvHM30jnFvDnCk2kuIkT0FP
 pOq8+rA9xV23/2moXZ/fmpM/5C1oKzo2SbsKr0sYhJcKe3ZWxn9EbR8OfvwKv57e3G9Xy1E0pO0
 z3YK0rTeW5KEnPcNKvw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a91de07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=2rQFh7-wCYwWiqwkiKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
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

On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> s390x PCI IPL devices require a "loadparm" property. Add it to virtio-net-pci
> to support booting from it on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/virtio/virtio-net-pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
> index fd3e0303f5..893d1905a9 100644
> --- a/hw/virtio/virtio-net-pci.c
> +++ b/hw/virtio/virtio-net-pci.c
> @@ -77,6 +77,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
>       k->sriov_vf_user_creatable = true;
>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>       device_class_set_props(dc, virtio_net_properties);
> +    pci_qdev_property_add_specifics(dc);
>       vpciklass->realize = virtio_net_pci_realize;
>   }
>   

Should this patch be integrated into the last patch? If pci netboot 
breaks without it, then the answer is likely yes.

If, however, loadparm is not required (I suspect this to be the case), 
then the commit message should be changed as it implies that pci netboot 
will fail without a valid loadparm:

Add optional loadparm property to virtio-net-pci to allow boot entry 
selection on s390x, consistent with virtio-blk-pci.

