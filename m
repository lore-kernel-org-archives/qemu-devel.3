Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C235DCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tWr-0001fr-SY; Thu, 09 Oct 2025 12:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v6tWo-0001eo-Av; Thu, 09 Oct 2025 12:30:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v6tWj-00025Q-Bb; Thu, 09 Oct 2025 12:30:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599E1SEX031409;
 Thu, 9 Oct 2025 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ul8+Nn
 OzvMKGjbpG2pkGVEMdIDFsEcgvJ59azKloo54=; b=LfIg9nexSTyvO3eERKcTjU
 1Tf0rxhKH8iehlX8914nAvUS3+1EUaJFL7FUpq49TKu9h0kcJaoEDi2eWN2LQje4
 dU3I3Me9JKVSRGGG1L2nCgUwtqg0KlE+bAUHJzuod2MIv8yC/33YzuAlyuTVYLIv
 rGjXy2xcIY5ZHZ3fledfqFxRBnp1fim0Hpp60u2AeUWKrF7rEV+GhW+t9vJc/a4L
 X7z7WVpbaL9wnnTl8nF4ss/fhnq691itad/DRSToy+ocCGXwOZefOCfenkYehfnl
 5cTQy7Seg9QoTGIj0LNgYfzo9lczRZBQmjr5El/8uhVsH68kjM9PiubVj1Qpkeng
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81nve4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 16:29:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599FcGYG022773;
 Thu, 9 Oct 2025 16:29:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vdgux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 16:29:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 599GTs5726018376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 16:29:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17F5C5805C;
 Thu,  9 Oct 2025 16:29:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 558DB58051;
 Thu,  9 Oct 2025 16:29:53 +0000 (GMT)
Received: from [9.61.255.148] (unknown [9.61.255.148])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 16:29:53 +0000 (GMT)
Message-ID: <1279bf77-22f7-470c-a3ec-59ee68d40a48@linux.ibm.com>
Date: Thu, 9 Oct 2025 09:29:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390x/pci: set kvm_msi_via_irqfd_allowed
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20251008203350.354121-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251008203350.354121-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ms4cH1GyVFppx5PNCrgOsIP3aXzOcQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyXg4DmHEuurH
 4SdiVGl9B5OCPYnkr/C6TupmYH+seJ+g6wKoDBtb07URxSrfK0Ts17CeAepiLHJwKmUp5tJMjsN
 09mvxnVneT1gfnqD3p8WX9ByTjDIM997sBThvrCYtAcw0DwY+lkfAp0svzkIpOKXARvlH5P/fls
 V9BoJQKhYVU+G8AhOvJX36wFdEqffsNzwk2Iwg25232s+PzUmPapQ2+b6Fc4/7zym8bqC/a58Pd
 edBJinnPAN65ZHv+MQETPf0c/2Xgzl6y2v6uButS54ytffmns5VTDZQkWh1DTbGiIs65aPObfg0
 Yg5Q9VLd0T2uBNL+h3BBr//00fQm358knqh1SRPMCul0R7vYixdGrgkk5DFMtvXH7/5ys4gEKh/
 9EC/+kWEPDpIWkH6Suj8r7iCpJ5xsA==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e7e304 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=oDUlcF5mch2PdcvZY34A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9ms4cH1GyVFppx5PNCrgOsIP3aXzOcQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 10/8/2025 1:33 PM, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> v3:
>   - Fix builds when !KVM (Thomas). Tested build on x86 and s390.
>   - Note: Dropped all review tags due to the code re-organization.
> ---
>   hw/s390x/s390-pci-bus.c         | 1 +
>   include/hw/s390x/s390-pci-kvm.h | 7 +++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..52820894fa 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>       s390_pci_init_default_group();
>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                                S390_ADAPTER_SUPPRESSIBLE, errp);
> +    s390_pcihost_kvm_realize();
>   }
>   
>   static void s390_pcihost_unrealize(DeviceState *dev)
> diff --git a/include/hw/s390x/s390-pci-kvm.h b/include/hw/s390x/s390-pci-kvm.h
> index 933814a402..c33f2833a3 100644
> --- a/include/hw/s390x/s390-pci-kvm.h
> +++ b/include/hw/s390x/s390-pci-kvm.h
> @@ -14,12 +14,19 @@
>   
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "hw/s390x/s390-pci-inst.h"
> +#include "system/kvm.h"
>   
>   #ifdef CONFIG_KVM
> +static inline void s390_pcihost_kvm_realize(void)
> +{
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> +}
> +
>   bool s390_pci_kvm_interp_allowed(void);
>   int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist);
>   int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev);
>   #else
> +static inline void s390_pcihost_kvm_realize(void) {}
>   static inline bool s390_pci_kvm_interp_allowed(void)
>   {
>       return false;

