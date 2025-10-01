Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41E3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v431D-0001e1-LI; Wed, 01 Oct 2025 16:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v430o-0001VD-FS; Wed, 01 Oct 2025 16:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v430d-0000yN-6Q; Wed, 01 Oct 2025 16:01:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591EUToF012149;
 Wed, 1 Oct 2025 20:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j7K52y
 /ftSMBzmuuFMoGGz+YQbE05X+bXgR04LlRuKE=; b=T/hl89cqCAar2pLuQwevdQ
 1T6Vze0690x25tKr8cu6tuk8I0PzB0HHUo3XxcEHFOZRlr6rVPM7JtUc+eYWSooM
 amaZt35c8RzgOTH4P7Ok3+2c7liTSOeEEdpCkbaJSAQB1zsR6DtckWxsj30baFpc
 GWo1aiRT/87waj0DZ1fSGuhdev9te3cL2UVaYTUoFf+0q0m1fC+q/TqoCasxNOp1
 zsOPSBd8RGXFPcbfyLpO9VLZExAyBjgc8rpG2v5T58wwyRDoQZ4oXzs3LUMc0lxK
 5/xb6CCnPSM5yCG/M3BYmeMlCCro/fgXxfpkTuSmEFYqXlxCnnssvQck+2rU9gjw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwrp82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:00:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591GtOTR001543;
 Wed, 1 Oct 2025 20:00:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfjaf1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:00:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 591K0Q3721430822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Oct 2025 20:00:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A00458058;
 Wed,  1 Oct 2025 20:00:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B80B58067;
 Wed,  1 Oct 2025 20:00:25 +0000 (GMT)
Received: from [9.61.10.212] (unknown [9.61.10.212])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Oct 2025 20:00:25 +0000 (GMT)
Message-ID: <d439465f-4946-4cd1-90fd-6f6041cf8ba6@linux.ibm.com>
Date: Wed, 1 Oct 2025 16:00:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: fix interrupt blocking by returning only
 the device's summary bit
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com
References: <20251001154004.71917-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20251001154004.71917-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7j2DoS/6fq1P
 0ocx/KQyhfOpTaMVOEPcP7J+1XMlY86Azdovk9KwVUQ6BuoAmzjZqG/tSRbezacDCmGkXjUucNI
 xt68gw0KVqyzMXDyz7jvRajsHyNDQ6efaDWvRha1hQ0Voy9Vi0d7kLaUpH8DtG+STC7WiD5gW5q
 aZt/4kClNMu92tVLIx+9MlNKhbY+84J+/2ZwwBtm3V1E6Y88t1FxbKiC8YL4fLtIeJKMQCYBr7l
 utR4E6/qKe90Vm+jTmUppmWPWM3JYUwmwuYfMqfg2lp0GzKrvXkuSIXr+0ta3U/lO75hESiqm3y
 wbyQGrTzCrmLk6BoUqF88Qg8IXdqX0cDj3IGfLUPkRH+tqinziS6HV3kMfXqW2pPh0BYBd+Avgk
 iJj30iJp1pjafq02z1d1rR2Ya7gLqA==
X-Proofpoint-ORIG-GUID: IdMy-l9V7PhQOpMqqqnpSDeyez1xne-S
X-Proofpoint-GUID: IdMy-l9V7PhQOpMqqqnpSDeyez1xne-S
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dd885c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=LA8OFg6YlTBt7G8A3eoA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/1/25 11:39 AM, Jaehoon Kim wrote:
> Previously, set_ind_atomic() returned the entire byte containing
> multiple summary bits. This meant that if any other summary bit in the
> byte was set, interrupt injection could be incorrectly blocked, even
> when the current device's summary bit was not set. As a result, the
> guest could remain blocked after I/O completion during FIO tests.
> 
> This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
> returns true if the bit was set by this function, and false if it was
> already set or mapping failed. Interrupts are now blocked only when
> the device's own summary bit was not previously set, avoiding
> unintended blocking when multiple PCI summary bits exist within the
> same byte.
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

Thanks Jaehoon!

To give a little additional background info, this issue was noticed when issuing simultaneous fio jobs across multiple virtio-blk-pci devices on an s390x guest (e.g. not the s390 default virtio-ccw tranpsort nor PCI passthrough).
In doing so, occasional I/O hangs were observed in the guest that were determined to be loss of initiative.
The root cause of this loss of initiative is the erroneous summary bit checking that Jaehoon is fixing here, where a decision might be made to not deliver an adapter interrupt because a different summary bit in the same byte happened to already be on.  We really only want to skip the interrupt if the exact same bit was already on.

I have also tested this against an s390x guest virtio-pci+fio setup where I could reliably reproduce the issue and verified that this fix resolves the issue.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/s390x/s390-pci-bus.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index f87d2748b6..e8e41c8a9a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -652,7 +652,16 @@ static const PCIIOMMUOps s390_iommu_ops = {
>      .get_address_space = s390_pci_dma_iommu,
>  };
>  
> -static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
> +/**
> + * set_ind_bit_atomic - Atomically set a bit in an indicator
> + *
> + * @ind_loc:   Address of the indicator
> + * @to_be_set: Bit to set
> + *
> + * Returns true if the bit was set by this function, false if it was
> + * already set or mapping failed.
> + */
> +static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)
>  {
>      uint8_t expected, actual;
>      hwaddr len = 1;
> @@ -662,7 +671,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
>      ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
>          s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
> -        return -1;
> +        return false;
>      }
>      actual = *ind_addr;
>      do {
> @@ -671,7 +680,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
>      } while (actual != expected);
>      cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
>  
> -    return actual;
> +    return (actual & to_be_set) ? false : true;
>  }
>  
>  static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
> @@ -693,10 +702,10 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
>      ind_bit = pbdev->routes.adapter.ind_offset;
>      sum_bit = pbdev->routes.adapter.summary_offset;
>  
> -    set_ind_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
> +    set_ind_bit_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
>                     0x80 >> ((ind_bit + vec) % 8));
> -    if (!set_ind_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
> -                                       0x80 >> (sum_bit % 8))) {
> +    if (set_ind_bit_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
> +                   0x80 >> (sum_bit % 8))) {
>          css_adapter_interrupt(CSS_IO_ADAPTER_PCI, pbdev->isc);
>      }
>  }


