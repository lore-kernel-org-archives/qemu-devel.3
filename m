Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95748C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 22:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycie-00021j-Kb; Mon, 24 Aug 2026 18:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycic-00021T-1H; Mon, 24 Aug 2026 18:00:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyciY-0006Wn-7B; Mon, 24 Aug 2026 18:00:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVsCG1725734; Mon, 24 Aug 2026 22:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qHaVCM
 zSZsIc+ZuZPGRA+RegFCacm3mtVCXU6hZmMt4=; b=g8QapnO7qZpkeuqkcHSwvb
 zPuw5cFXYYOShLc7JHWOPuw0n+dcJw4LSJKtG8RdOZO1EU5JWaMJjIrqsRQGPZRz
 cVQFvnyyu5L8KzrYFdpE+LBlYannoMGWem5AQay1n1Kv6CoqXHG4mkFXM8Wm7YB0
 Idm0zlJOJkMXFxTQQIyUSAacbAWsHamz7SQPCCiN8ufaAnIP/d7+xcPZ7QjM64Fu
 bZoanWZV9+b2Tp2zz+AD9DIbRzLaqP/b3841iYtPQLdcZDuLwQfE1NCLUY4c3O4N
 de6pAUSdQj2MM3B7TLaR9MQCHz1o5iU4f7g1xigXI2fJ5AWgIHHxmpPiH7jf1Ayw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ecduw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 22:00:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLuHXC019561;
 Mon, 24 Aug 2026 22:00:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy0fqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 22:00:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLxY7j28705504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:59:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86F5A5805A;
 Mon, 24 Aug 2026 22:00:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1F7E58052;
 Mon, 24 Aug 2026 22:00:13 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 22:00:13 +0000 (GMT)
Message-ID: <31f8a6a3-073e-4d84-b743-906e0a6f85f1@linux.ibm.com>
Date: Mon, 24 Aug 2026 18:00:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-14-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-14-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8cbef1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=yGonlt_J30laUZWCZlEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXxa/q7Gb63VDU
 V51jWbdLx2qQGaTjGDMmuECqw3MjuzeLeP1nFHWAoxWURZWF6S6L3tmcvUKx5tilTEVMu+RxRkp
 V2KMdXVHxQpRniVzPNnG+rkI1wEcY9c=
X-Proofpoint-GUID: f2Lxumf1qvXKpUMz5UTLVySpCHcsMgQD
X-Proofpoint-ORIG-GUID: f2Lxumf1qvXKpUMz5UTLVySpCHcsMgQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXxVd67y0x+CEC
 ldi7MJXEMqyFwGTcfWWr0jaGVFFJhC7FxZma2R/5PV0aLDbXmegNJldJVbzCEsiDHMKuY/8vH42
 kQEk9/g1dETfUa8pe45VvH5c+LKsWtdPmkQCwK6EvVuV0mZFzjtl48fcoXQUSHOyGMYMfUdCPeZ
 AmhqjlS+xk8/AO2GRENpGofuU20DE+1i8qOT7k3daBy6fUk2us92YlW69znhvWflwxYU4WZlSqv
 TihojLmefsEApf60Osob+jIhIV5GeEolwRe7lfQhRJx/RmPIK69Dm9A+89YXjjxL/KCUfevkvXY
 gTJVCToz660qiSGQvkUbHvN+LsL1ctwpxYnHRuKbLrJv4nSR8uUnydiTMaVif/CCwrFuO3buL/K
 KX89JcKJsl2iNqUyDD8fW2nub7uW4KNeI1mXcoY4sKMqzkfH4bD/GkTR2GeKiEZ66Nx9PgjPesE
 Zzv87Cw4psOPrp/9BDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> Because S390PCIIOMMU has just been cleaned up of fields it didn't have to
> carry, add a comment explaining why it exists in the first place and
> discouraging adding more fields to it in the future.

In following the theme with the other patches, how about a re-word to
something like:

Now that S390PCIIOMMU had been reduced to only the IOMMU container
information needed by the PCI layer for the associated slot, add a
comment explaining the purpose of the structure.

> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>  include/hw/s390x/s390-pci-bus.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index e3cbee2695..17ecf3e0da 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -271,6 +271,17 @@ typedef struct S390PCIDMACount {
>      QTAILQ_ENTRY(S390PCIDMACount) link;
>  } S390PCIDMACount;
>  
> +/*
> + * This structure holds the PCI device AddressSpace that QEMU needs to link
> + * into its internal structures before the zPCI and PCI devices are fully
> + * initialized. QEMU wants to have this "root" AddressSpace before the PCI
> + * device is plugged in. It's only actually used for I/O while the PCI
> + * device is plugged in and configured by the guest, at which time it has
> + * additional memory subregions from zPCI device, that can do real work.
> + * In other words, S390PCIIOMMU holds fields that logically belong to
> + * S390PCIBusDevice but need to exist before S390PCIBusDevice exists.
> + * Therefore, no other kind of fields should be placed in S390PCIIOMMU.
> + */


Starting from "In other words," your comment gets inaccurate.  We will
actually ensure that a S390PCIBusDevice is either 1) already created
prior to the PCIDevice or 2) will create it on-demand during
s390_pcihost_plug() for TYPE_PCI_DEVICE if it didn't already exist.

This nuance goes back to my comment earlier about the lifecycle being a
bit odd.

For now I would suggest to just drop the last 3 lines starting with "In
other words, ..."

With those 3 lines removed and the commit message re-worded:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


