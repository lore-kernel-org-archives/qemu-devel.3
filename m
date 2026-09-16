Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0270C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6v8r-0003iI-IH; Wed, 16 Sep 2026 15:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6v8f-0003hP-6E; Wed, 16 Sep 2026 15:17:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6v8b-0003xK-DD; Wed, 16 Sep 2026 15:17:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1VRT006701; Wed, 16 Sep 2026 19:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I/8KC9
 hcBGhfJiUOtjN93iOwtxQXIjHJJSLdigBPBy4=; b=k5OctkbxOhBzkBLpuFWzHn
 YDfCP/0jmW6IPN6Gjotuz6zgn21LtmuQVgPcNzM1cAFRUbMx/9z87mXbK6ZRa1/Q
 TnWJzQ3sT0RiS2aQK6Ud++hbvzmuvfqP4Fm13kHtuR8We0ufCmnnIg/vxtYcwQqX
 l6bZEIed/GK7X4P754O8XtS6LSDS8C1Ky/Rm2fgcM/DdQY204j2sHLkZvoPNxNRZ
 ewY6Ft8OR//NKbKzFqRvsAnw/EyhfhYE1J4uDtkpORf+jvDixeGJCb40rhxsFKev
 FvCXQxnyTlEr4B4yR94kp+/YL5lBa0QFeo5xAi0+I86xVuOt9pW5iSwvSDnExjKg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83xj9p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 19:17:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIxgEr1649278; Wed, 16 Sep 2026 19:17:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03c015s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 19:17:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GJHYK253215490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 19:17:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFC7B5804B;
 Wed, 16 Sep 2026 19:17:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D667E58067;
 Wed, 16 Sep 2026 19:17:32 +0000 (GMT)
Received: from [9.61.249.152] (unknown [9.61.249.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 19:17:32 +0000 (GMT)
Message-ID: <1a755a8a-2615-49c1-b9ef-508f3245c497@linux.ibm.com>
Date: Wed, 16 Sep 2026 12:17:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/16] s390x/pci: implement IOMMU replay
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-2-kshk@linux.ibm.com>
 <2c2bf867-a11a-4591-88bf-bf38d114d364@linux.ibm.com>
 <3687f02c-a0fb-4801-9b45-e32bc87dd248@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <3687f02c-a0fb-4801-9b45-e32bc87dd248@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI2MyBTYWx0ZWRfX9l+qbVLtdTpB
 Owmcozmw84gdNDwalX9rp6jUEH6lGGZH3WZLG4ViXGtb0KGdEDLKHD9k3shHcBMBfexkSKzB0wf
 MDdPbVommju3+SKGnJl/BCjT19H0ePGqkbM/Dpm2Wgo5c1GnLoX1agPwODvT2gqlDeyKowaJxRg
 owUNzWlReuaI6IEUrAJFyiXTM0XU4PXLvsScelPuh0TpjmChwdxpJL46p2bQhq8NmA6ed4+nJ/E
 Xn/xX4jsmo87XXmsYcS5DcjlF4yXtcXkC0lL8TAr6Rewdhm52FiOkQq5KLyDTgi5hqCjoPZurEl
 7c53yBnthKWiP8bEXr+Wti4Z1wg3upKSkZ/u6GdM9ZjobOqpnKW9547vUrunJdDFKSDPhJt4Dpb
 OsLiApuN/UvWbAB3zPWZf9wWL+Hj0+ga0a+QShmFtp9sucsbAfVe80vQX3GQHHXgoKr2jXgHoIu
 Dd5rFKDElm/9MjMdECg==
X-Proofpoint-ORIG-GUID: --Yuwn6HgHM2fZ0QK7GEePWG8Vk8CgFq
X-Proofpoint-GUID: --Yuwn6HgHM2fZ0QK7GEePWG8Vk8CgFq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI2MyBTYWx0ZWRfX2EULOI2jHCCt
 mz5EAly13LguNYjjZTuTyjmWoPxk3QQIOwOUip2mOdyKATGsEr1cxYrA0ixyPTAKczdBGpkLkf0
 ZudfJ3ONeGq8VD66PcahM+DOby+RfkQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaaeb50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=HAOIqs6GJIo4af_rMDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160263
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/16/2026 12:05 PM, Matthew Rosato wrote:
>>> +                    pbdev->state = ZPCI_FS_ERROR;
>>> +                    s390_pci_generate_error_event(ERR_EVENT_PERMERR,
>>> pbdev->fh,
>>> +                                                  pbdev->fid, 0, 0);
>> A permanent error will indicate to the guest that PCI device in
>> unusable, in that case would the guest drive a device re-initialization?
>> Would it be better to generate a ERR_EVENT_SERVAC to allow the guest to
>> attempt recovery and so drive the mappings again?
>>
> The problem is that if we hit this scenario, we've exhausted the vfio
> DMA limit for the device, so there is no way to create more mappings
> without freeing some other ones up.
> In the case of a RPCIT, we can ask the guest to try and free up all
> stale/invalidated mappings to make room, but in this case
> 1) we have no mechanism to ask the guest to do that
> 2) we are in the middle replaying only the valid mappings, so there are
> no invalid mappings to flush anyway -- so we're really in a permanent
> error case here -- the number of vfio-allowed concurrent DMA mappings is
> less than what our IOMMU wishes to replay.  AFAICT this can only get
> solved by forcing the guest to throw everything out and start over.
>
> I think in reality, you would only hit this in a migration scenario with
> a vfio-pci device (which we don't support with this series) where the
> vfio DMA limit is lower on the target than it was on the host.
> If you hit this doing IOMMU replay of a vfio-pci device without a
> migration involved then the limit should be the same as it was before
> replay and it should have been impossible to map more than the vfio DMA
> limit (so if you managed it, a permanent error also seems reasonable
> because there may be a deeper issue).
>
> Would an 0x3a trigger a total wipe of the IOMMU contents that we were
> trying to replay?  If yes, it might be something to consider if/when we
> support vfio-pci migration but I'm not sure it makes sense under the
> current scenario(s) where we should never hit this path.
>
> Thanks,
> Matt

I think on 0x3a the guest will attempt a hot reset and so I think will 
also re-initialize the IOMMU [1]. But as you said this only would apply 
in the case of vfio-pci and may not be applicable to the virtio case. We 
can re-visit this if/when we support vfio-pci migration.

[1] https://elixir.bootlin.com/linux/v7.2.5/source/arch/s390/pci/pci.c#L731

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



