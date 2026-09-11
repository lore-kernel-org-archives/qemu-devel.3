Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B5C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x530q-0005oX-Qd; Fri, 11 Sep 2026 11:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x530d-0005nF-C1; Fri, 11 Sep 2026 11:17:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x530X-0003Ay-Le; Fri, 11 Sep 2026 11:17:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1iHb1973600; Fri, 11 Sep 2026 15:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SUl1G8
 y6ddWh6Jx+khwW3q93fiTyKuR7N+i2yHakgmo=; b=iPFPkpxvh0RjjXHmfvPI3E
 pMv6aEthFfRj03C/EZRFaOU+eRoGMvU+OKUsnkw+23zx/qTiDI6O0Ea0i1eN3yxb
 6bpiVUtM3TkbALzwbW2B2HebOYeAOpVkTbFQKSktDZyq5vPzwOdsvqewZPtJAi9Y
 uGxKdds/7Y49AWGRZKF060tlH0IWemUeXKgk3U0BMUTD9NjG5mwnlP3wRWnR0jou
 QyjrH+JyKWhLMcdXG9KqDm1efEMS3eLDEPUIAS3WwEg8wD4H6AD+Wuzyc8RQNLNS
 KYazojGVFkvMgM7EyrMR6kly7fjSTtbJNFj/NePAVZx8qTH9VbqblBQGKPqfKd4A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sc7at-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:17:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoA9D1764909; Fri, 11 Sep 2026 15:17:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrf074-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:17:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFHcbE30999262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:17:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B884958068;
 Fri, 11 Sep 2026 15:17:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C55415805D;
 Fri, 11 Sep 2026 15:17:37 +0000 (GMT)
Received: from [9.61.94.186] (unknown [9.61.94.186])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2026 15:17:37 +0000 (GMT)
Message-ID: <efcb626f-fe3e-44a6-8f0c-4174c3d0204c@linux.ibm.com>
Date: Fri, 11 Sep 2026 11:17:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/virtio: Add "loadparm" property to virtio net
 PCI devices booting on s390x
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-6-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SLyzgw4RabJFwokq0F_cQ-RPvSnrMySL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX5HAhcookF93E
 tInFXkLwgV3CqBHS2fjft6RGXinJmcqxC7enmLDobVrMxOJypOUkdpGCxW6ufGQ0IYBIhyEVM0N
 4QLPfDjfPrHTOT9bHe3UmTTwUVr1iCBEv3xRDPH4nlw3IFwBs+u7ElQJnv8mYsRbiv76vVqksvs
 vshO47uQWfye+TKKvSUaCp07uhWiIl5rkXEO82hOB+9dEsLebg1jj26+0RocRTsECEUDOOs4J/Z
 srltlF6ahrVZHlgGGqiGQx6sMtDCWVdVIQLHBZu9pygFwk3tjVGGxBgpG4fCbnWB91pyqyqGfMH
 99bvK1ubgk91nm4qAr4E5gM375lrZ6fI6j7LrsnVOMIPrpb6GY0wUrAlU+MR8yc1Og27EPbIPgC
 SBy2PYzrraSaPLmsACh4O//9bboFJM8EyYgVLQLOxheE+b+pbBKQmOVgSdyCPMUhUWs3ai44c/n
 eXKRkE3u1/+VplNa5FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfXw2mJWPAnzrnw
 Sgkap3QJU2U72e8PanRqhIDz8zMDFV5OKp7O+26UHvlEJ7+wKf/oarvUy2zzVSWRmCdhQDPE8BU
 C/RL1gVH8ANO6RXg6we6tw0M0R/tEK0=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa41b94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qN506RqINZ981zxnCPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SLyzgw4RabJFwokq0F_cQ-RPvSnrMySL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Add optional loadparm property to virtio-net-pci to allow boot entry
> selection on s390x, consistent with virtio-blk-pci.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

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


