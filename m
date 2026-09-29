Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D344CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWrx-0004Ib-4I; Tue, 29 Sep 2026 08:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xBWrY-00046c-AX; Tue, 29 Sep 2026 08:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xBWrV-0003nw-Cf; Tue, 29 Sep 2026 08:23:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5VnP4017566; Tue, 29 Sep 2026 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RNXbRW
 wbooAURt4WVindgs+lcMDSqOMpbOT+CoN+ch8=; b=l+2TEHka0gy6r1yzSnlSrZ
 XXd5n7GQ9afer8woeyVdEU0AX5wRU8WneqCyrvWA50zRD9pu+hGEEsOVj+OuWGtb
 P/XHOwx4TjbLo0lS95tfE90asl6w49mbnISVUO1EbEHE+O9aH9DTh5R8cUEcQGLE
 eYVVklSDVh4wvgcdVZ10jQvp+Hdj533mcc53bt1Nk+5n3HcIeQYDMMs+Obbk2Dcx
 kMl3iacHo+N+y40Pas+h2vBZX2bsoNbJdJKSTVtt03qwGx5QB4nHsrpwLyRfA8YX
 g7z1wGbdrY/hIZwaBApMKWKXBfRuzFV0AlD0uQrQzMLBWCS/IUO64tbXY2D1uhQw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt66bq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 12:23:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAll2P1647352; Tue, 29 Sep 2026 12:23:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y9dut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 12:22:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TCMtGm53412280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 12:22:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 953CC2004E;
 Tue, 29 Sep 2026 12:22:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FD1D20040;
 Tue, 29 Sep 2026 12:22:55 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 12:22:55 +0000 (GMT)
Message-ID: <f9255bb1-3193-4b7f-a2ae-13610a0fc014@linux.ibm.com>
Date: Tue, 29 Sep 2026 14:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390x/pci: Use qemu_log_mask() for guest-triggered
 errors in reg_ioat()
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
 <20260928202325.309353-3-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260928202325.309353-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p41FfivBlIcYitFNez1T9Zb5nT-j85Mh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX/LDezhXY9Gya
 3Rs1f8riw5YLznzQsjlfQSfWur5Yl7TVhgA4zUPAV8j1lfv7YnSeiiNlk4I+kij4jC+fOeBy7X4
 aTerzWD5N6TfXnGZ4dDLHPcv3Mr51ImB3QC0n8QtbJm2DiarLhLabGA3dagzdSnkedrqELtL7cq
 KSVCYEFkOET1sbb3TM6bZk8u01COXsphDP8VrkY93pJLlfRqQxNiMVAFk3XNh+7U6VDOs80cwtO
 JpPwl3ipXk0qg7t+imzIfQsMoe/chbzY/ekMvvCPECUjRMU5HB14R3PY4DGrNSf1RJCX/HIqqt6
 YYEmryX3RjqonRtVSi5gFq5+bqDnZ2cDhckaGNYsgyOLTz+ZWvPnbeRzKZbLn5b10QVXubdMYKB
 aVZAA/0jMNvQ063llm7zkZ7PNLW21CWPo5NNapXQh21sK0aJODVILlkAwr5NvSugkK5+uTHzPTF
 kRpzVKLIUG1p5eO/fiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX/vbYqyD4eJIl
 n11QUifyHK6VXA+0r5VkAqVOsgWhRHRusfQ2Rz+HCCRLqn8lLYBwwPe/5qEM1ZbsF9d9WRn6oUp
 jpYKrUGCn3JEpRPc/QPfBN9zxdH7q/w=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbada4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=6nEuQmOdkwVQYqC_m6UA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: p41FfivBlIcYitFNez1T9Zb5nT-j85Mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 28.09.26 um 22:23 schrieb Matthew Rosato:
> The error paths in reg_ioat() that are triggered by a guest providing
> invalid MPCIFC arguments use error_report(), which writes unconditionally
> to stderr.  A misbehaving guest can exploit this to flood the host log
> by repeatedly issuing the instruction with bad arguments.
> 
> Replace these with qemu_log_mask(LOG_GUEST_ERROR, ...) so that the
> messages are suppressible.
> 
> Fixes: 863f6f52b713 ("s390: implement pci instructions")
> Fixes: dfcee1ea4c52 ("s390x/pci: add support for guests that request direct mapping")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index a51543df44..c6da3b4c07 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -17,6 +17,7 @@
>   #include "system/memory.h"
>   #include "qemu/error-report.h"

can we drop that now?

>   #include "qemu/bswap.h"
> +#include "qemu/log.h"
>   #include "system/hw_accel.h"
>   #include "hw/core/boards.h"
>   #include "hw/pci/pci_device.h"
> @@ -1044,11 +1045,12 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>   
>       /* currently we only support designation type 1 with translation */
>       if (t && dt != ZPCI_IOTA_RTTO) {
> -        error_report("unsupported ioat dt %d t %d", dt, t);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "unsupported ioat dt %d t %d", dt, t);
>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
>       } else if (!t && !pbdev->rtr_avail) {
> -        error_report("relaxed translation not allowed");
> +        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not allowed");

I think we need "\n" here. error_report does add it, qemu_log_mask not.


>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
>       }


