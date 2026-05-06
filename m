Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C96CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 19:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKiBo-0002RV-6y; Wed, 06 May 2026 15:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wKiBl-0002R7-Ha; Wed, 06 May 2026 15:45:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wKiBj-0005jO-Nq; Wed, 06 May 2026 15:45:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646A1CaO2578306; Wed, 6 May 2026 19:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K9AKGp
 vSN2cGB5bh6CZByiFjr3LipP4KEuSciLYRnNY=; b=ZHRTff3peRCB+UOlUTustt
 PHl0c51qjQ5gYA1huNnCsqa029LUoIoWCjd4jX2HvARuwEqzBY/sQpBqxacDX/hw
 SpIyNDEdIk6pIBncGkUxFvuW+B42geXdIwTqhTxPYeSq/fTe9FjgMIkbX2jo1QmL
 jPCWFiWA+YBVx/Mk1vkXHzefY5LCjk2qqsfkxdUgH1B3poTI6oudqCDeEI1IVtat
 k+TL5mLU/KiHMI9f4zO7SckgvmB7+4SnWplAVj7ax1n+A/pH5HWN3APK4ne1qHzU
 8aAMfQ4NIbReebDnpdqunPAkBlyh9AqeCS/ntpiMT9qADzqcdtaeBeL4KtzU3Hfg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4srgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:45:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646JdcjN025978;
 Wed, 6 May 2026 19:45:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h7q5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:45:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646Jjcn411797030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 19:45:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBBD85805C;
 Wed,  6 May 2026 19:45:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3FA758058;
 Wed,  6 May 2026 19:45:37 +0000 (GMT)
Received: from [9.61.162.242] (unknown [9.61.162.242])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 19:45:37 +0000 (GMT)
Message-ID: <946651d9-0cd5-4482-96e5-a4c59b4d5fcc@linux.ibm.com>
Date: Wed, 6 May 2026 15:45:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
To: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-s390x@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20260506174135.2630613-1-thuth@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260506174135.2630613-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE5MiBTYWx0ZWRfX/SWdAfl3CeUO
 uvFAnfSBeVzv2BuunE/VV+T2QVs5JCBKm9yeADfAhz+w8R2zKLoHZuQb1KlSjjKm/n8ktD+GWma
 qoOTaE7TMWf6mLJKbIZXlTrLbk0F/pVqLBesQ6xwq6xVE0z2pfZb+QBv/Oqi/DXLGzHfkH/owcx
 6moWRPHvZRNOdW+68Fe+2SVHNpJes06APcj+7qCvnqtVj0pEtp8j6x45vVRV8qUyvB9eIhWdBKF
 Q0KzHOP+wbKQ2iGydh7sU6NFD7Jun3AUVKp4f6FkQP3OLckEk65ipa7qRuezIVkm9sTWEZ61z8C
 VGg9rH5Vwz2iGOVf6yCVRLy5c++OrdoBejS47XexWuazmC/msQLMRZ/Aw9gOWdphavQBFKbrFuV
 PZC1rBrHzuxySg/IocXt0mHTKgQrg55Wo1L9lhOd6xHC5V7RKB3q/oYO+ZOy9ct8Rbckh52PWvn
 YWmTW4M2UtlcNymHE2A==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb9a64 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Nx961GGavPmN8L6er0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uSxKXNppQq927MT7aj5mcnsgnld2f3xz
X-Proofpoint-ORIG-GUID: uSxKXNppQq927MT7aj5mcnsgnld2f3xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060192
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 5/6/26 1:41 PM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The elements that get removed with QTAILQ_REMOVE are never referenced
> afterwards anymore, so the corresponding memory should get freed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 1 +
>  hw/s390x/s390-pci-vfio.c | 1 +
>  2 files changed, 2 insertions(+)
> 

Thanks Thomas!  Code looks good and I did some regression testing with
this patch applied:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

Should we also consider adding:

Fixes: b354d5d804 ("s390x/pci: clean up s390 PCI groups")
Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")

?   Neither are commonly-driven paths, but s390_pci_end_dma_count can be
driven N times via unplug of N vfio-pci devices.

Also out of curiosity, did you just stumble on this or was there some
tooling or testing that was being employed here that found this?

Thanks,
Matt



