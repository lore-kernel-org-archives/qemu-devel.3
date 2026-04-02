Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BF0D39418
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Gmk-0003Ci-Ab; Thu, 02 Apr 2026 08:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1w8Gmd-0003Bp-6w; Thu, 02 Apr 2026 08:04:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1w8Gma-0000rr-UU; Thu, 02 Apr 2026 08:04:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631KZKS23948870; Thu, 2 Apr 2026 12:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oc/x0d
 p7bcNQzXLGZ4aZmw2lGvTo1JdAPhI/5/gOlss=; b=WplQ7VRgn5xMz7r8mjYXzj
 QNcmlAwqQP34y4BpTobpz+Mva70P5NVY02xwTMpWCcsFa9YafMywRei2K6EGyUzW
 /ksoEjshLhvSjHUuygIuVbMZbB1e+yARBeeuo4/uBXgQI2w8lkgjbAaNcQlrsmWz
 Y4pxffDMn6v94QEhFXrecZt+o3cptYRPZ2GKp0Pva+RG7+8TT5Stl9P9357KA93Z
 DLcfOls5sQjB4XhdCTnEBhV8PXTu5yavAwBM/x72VZEY7SK7kuSjFkxzdbT84s8C
 mei+xbFITy/mam8AElEnTZGVY7VrvfMbSkSvaK+uAj6L/rk++8dli0H1J0qJKnpA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dckscj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 12:04:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6327f4Od008698;
 Thu, 2 Apr 2026 12:04:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11spbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 12:04:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632C3xlX27460088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 12:03:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D4FA2004B;
 Thu,  2 Apr 2026 12:03:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2617220040;
 Thu,  2 Apr 2026 12:03:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 12:03:59 +0000 (GMT)
Message-ID: <9a376d2d-1456-4283-8504-1a69c74cef62@linux.ibm.com>
Date: Thu, 2 Apr 2026 14:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] s390x/pci: Create function to contain translation
 status check
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260402022921.298818-1-kshk@linux.ibm.com>
 <20260402022921.298818-3-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260402022921.298818-3-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce5b34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=B0G84NvrpuzEfJ7AWGAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G10C_5yCpVN1PgWYYbxxniWAAogvFHRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNiBTYWx0ZWRfX9C5o+wKk2PU3
 jr29j7ZmCoUU7Z8bzsP8wd1QiUKGHRC3puQQ8th/nctc4shNFdLc2SC9xqajH3SCfOqAfvSnKRp
 +XsU3slsWIIMdIHsb2pbvaWWJcw1L6gzCqOFlGHRp/4OXZkfMidb+0YIjC4o6F6W80ljX8u0vIW
 nrpI5DQ5/2VojMtip8gfEEW9lezo6IHpoi2oHRsostwRZwG1xz9bhDz6e6Ohfz/3dZR3is41/ox
 OpIrA0fJc8n+IPZHgJXLnP0WYbhV33Mq6rpMgURMBq6c60LOG+hh47hYvhhwP9kAJr4M01k6vr3
 GbHU+Wyf4od9bZdn687/g3jeoS3hsGFAmpLxt06DNeFcWLGpnclJPVLpYGF6K1BrEPzRfqUNtwr
 l641BNjY7Fk6nCjkCl5i9XxiYUA9yNH/9mj7nStc/d4NiGQ916sNBQza5x1QyFYRF8vmNIJl9yZ
 xrak+s2nel8B2JCTo7A==
X-Proofpoint-ORIG-GUID: G10C_5yCpVN1PgWYYbxxniWAAogvFHRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020106
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 02.04.26 um 04:29 schrieb Konstantin Shkolnyy:
> Make it more clear what the bit means, and the new function will be called
> from yet another place in the future.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c        | 7 ++++++-
>   include/hw/s390x/s390-pci-bus.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 1834596076..7c784b31f3 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -993,6 +993,11 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +bool s390_pci_is_translation_enabled(uint64_t g_iota)
> +{
> +    return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */

I think from C perspective you can get rid of the != 0 part as
integers casts into bool with false=0 and true otherwise.

Apart from that
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



> +}
> +
>   static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>                       uintptr_t ra)
>   {
> @@ -1001,7 +1006,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       uint64_t pal = ldq_be_p(&fib.pal);
>       uint64_t g_iota = ldq_be_p(&fib.iota);
>       uint8_t dt = (g_iota >> 2) & 0x7;
> -    uint8_t t = (g_iota >> 11) & 0x1;
> +    bool t = s390_pci_is_translation_enabled(g_iota);
>   
>       pba &= ~0xfff;
>       pal |= 0xfff;
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 9228523ce8..eb15cb8b2d 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -390,6 +390,7 @@ int pci_chsc_sei_nt2_get_event(void *res);
>   int pci_chsc_sei_nt2_have_event(void);
>   void s390_pci_sclp_configure(SCCB *sccb);
>   void s390_pci_sclp_deconfigure(SCCB *sccb);
> +bool s390_pci_is_translation_enabled(uint64_t g_iota);
>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu);


