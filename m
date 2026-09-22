Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF47C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8w0r-0003To-JW; Tue, 22 Sep 2026 04:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8w0p-0003TX-L7; Tue, 22 Sep 2026 04:38:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8w0o-0008Rt-0O; Tue, 22 Sep 2026 04:38:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M05VM92940024; Tue, 22 Sep 2026 08:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=u3W5ak
 MTv5KBXDyiAvsuvInpfGZyJh98M4Ht/TaCR6M=; b=c6IUaTFnR76uhWgHBC/3Tx
 06hX2O08VckwOjHIs7DrfdMw5hBK6YIprGjpIs72IyjiPnZniRF/6zfuo43BWVoo
 p6ZX4GWFJq8j2RFkKc5fxCO3gLvRqOll/sLBouHfz0mBOLebsS4zjixV180NGNsj
 zLcEc6fI5wsU4CO++ii58OA9i0nP3OgDgg3I8VzIGpcjYbt5LDnSCKgkXFek76FJ
 6ZETbGa6AzWUAVJKn/oA69lUq++JUxm7av7NMoFKAK+53W9m9Z5pHtKvHiTW5b43
 l2iJyQGPq7iWu2hyfSo4xUSSY5ugBTp7HFXMW6LxXxvNhxV/Voh3Pj9pfVo2Brkg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2css9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:38:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M5ZS4o2995712; Tue, 22 Sep 2026 08:37:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy8t9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:37:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68M8btMN31588638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 08:37:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D839C2004B;
 Tue, 22 Sep 2026 08:37:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B553C20043;
 Tue, 22 Sep 2026 08:37:55 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 08:37:55 +0000 (GMT)
Message-ID: <8f5bd4cb-78c4-4bb8-b34e-3ab4830df2e6@linux.ibm.com>
Date: Tue, 22 Sep 2026 10:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR
 ioctl
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-7-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260921184305.3791311-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3sgV9NdRB4l98KUMM174AaU8xTW6xp63
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab23e68 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=rcfhhjRW5OIkq_R7rkIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyMyBTYWx0ZWRfX8kCrjekB9EvT
 uXRRFfoysSatT5ivMz1BZumtyJguytATTcJHRzUbkfVpUNiKgTujllRo9SNXUhxGaRzKLbIB7R+
 9pujNLriHhqQFzg+qNsk0Cn5Muciu4jzwRAQSVdMhCy+YSXL3ODDLGw2pI9XOzkKu5edD6xC/Cz
 T4qGEF7WVgHEp8eFRSuefwvH8FR2AUc3VfT0aqdKyNQ6u5WJZpvKXWM8gFy5tv0fQiTavIpSBdR
 4LoWEkgJdT1yPAkzXQKqUtjHPIgmZuyrHRREe7NkufzVkWuvLLR7Sa9fIwutlPyHghhRUNpHgfV
 TbQ53R2ok3a04/0pFEh1apITxTQ7lQD0V/cFIHbeR846ZHt6L1fpNqrMJk3aLJ1kZaXvNhIuJW2
 eH1TVWtc55vywfWediS8+YX2Q7MhRMLhYgYM+rVlKVQ+2QObWujyWPsjfJMwuO4ewn7Jz7NapUJ
 JKkTLJUpce6UCPKvOXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyMyBTYWx0ZWRfXw6QUkE8xIlaw
 GxK7Bxrwnjh9wmYeLYY+oSydAtaOYDrJr6gIxlm8RR3aXnoyL9ZLJOir2u5cEODDtuR83O3T/+D
 WcfzMSVF26msPhxS4S1p48R2MptIg/8=
X-Proofpoint-GUID: 3sgV9NdRB4l98KUMM174AaU8xTW6xp63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220123
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 21.09.26 um 20:43 schrieb Eric Farman:
> The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
> receives the contents of the attribute struct as its payload,
> rather than a pointer to the payload itself as is convention.
> 
> This may result in erroneous errors from the ioctl, which would
> result in clear_io_supported being false when it otherwise could
> be used (which is helpful in device recovery).
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/intc/s390_flic_kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index f833a3996a..5e6d422fba 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>       /* Check clear_io_irq support */
>       test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
>       flic_state->clear_io_supported = !ioctl(flic_state->fd,
> -                                            KVM_HAS_DEVICE_ATTR, test_attr);
> +                                            KVM_HAS_DEVICE_ATTR, &test_attr);
>   }
>   
>   static void kvm_s390_flic_reset(DeviceState *dev)


