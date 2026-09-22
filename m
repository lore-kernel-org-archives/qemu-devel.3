Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8137C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8vnH-0000YJ-3v; Tue, 22 Sep 2026 04:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8vn5-0000XH-JS; Tue, 22 Sep 2026 04:23:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8vn3-0007Fa-PK; Tue, 22 Sep 2026 04:23:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M05VLK2940024; Tue, 22 Sep 2026 08:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7T1GHK
 7JABY0zuJrkd8Hp6lHqugxlg0Om1MORjz0mEg=; b=ZJFShERNF5c1Pr34WC3v+l
 BYQf/bhbhaebB81ZhZZUAtsBVBwR5ZsOMpCnp3LUTplI8jsQn1qb58vsqnfMVj6A
 dTCWHfKq3Te0ooXbnc8I7HYMJCrJeGhnHTQFVnfuOTLzXSon9iIA0j8suq9HgOSU
 XwpQwzXO/KjDd3Vuxr2ufteVAHBorpEbY6a6RsGrMVTkVuHXTxGseoA7J6umxcYw
 jlqhO/cFJ3OYf941noRNakMbeT3QrmSlbgb2nHj8JsaUJVUrzvzT3jezA4yWqmIw
 NtdsaV07azm2CJSQz7kf4VCgs6YXxIgzoLWUaE581yZyhgkVMwBTLs1d48mtKyng
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2cr4e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:23:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M5WLb02995396; Tue, 22 Sep 2026 08:23:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy8rrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:23:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68M8NfCa40173838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 08:23:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51B162004D;
 Tue, 22 Sep 2026 08:23:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB3EC20040;
 Tue, 22 Sep 2026 08:23:40 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 08:23:40 +0000 (GMT)
Message-ID: <71c30a02-c833-46c4-8fa6-87a1a2f6a985@linux.ibm.com>
Date: Tue, 22 Sep 2026 10:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hw/intc/s390x: Fix check after g_try_realloc
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-8-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260921184305.3791311-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nvmoKqX5ZigMW_19p6LWWIgBiwoOrcHx
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab23b11 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=hkw4_FDKqiTbW938wNIA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExNSBTYWx0ZWRfX87iznRfzA6DT
 NJfY6ErjMQeQtQx7SJaIog0slvkY0MjY4JDXeL9Ggt/BNGw6vl8hxf1YgUKoCMatrIvlwIWCPIk
 U1ePteX5rrCfaFXZ7LVRRdUb5Mqy+754KPQ9o5NUMAKIhOwje4aVcp/FHF+xcykz+Ip5sRQrh5o
 xvlTuaobzTU1eJemfkiZICFSMFzdcKvoY5O+shZxE+cP164CKL+R+GT8TzqbaIuu8DIf7q/+D6W
 VAfgLQUnFDn8EfAs1bXaJNt1SOAnRzabGlHlKwsiNXuEPzA2No6AMU0esaj8y0CGGl+koog5K/t
 qJEvhLrZSwane5eRTCzUjrdWXaSk3EX9K70iRiiEMm2PiWvVa4z5f39juJWCuotHFSn+jP4Njta
 oHL8SiL7SqbhRLLHao5jDxQT6Y1HGPcot2xG+7OeQ+pCv8VSt8lAjjuFK8tVsnYd45zkvofB3/p
 YJh8ey3070TcYqKciMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExNSBTYWx0ZWRfXwSSCV4veMxGv
 OZz2wQIgNpRH0QHFzVtRX+yI12wOp0DeyAuK48NtZ0OKNAViBmFLGVz8jQpieX5FgLxHCq1/BXw
 W3aa0215lgUYFha4P8R3xxxVarYzzjM=
X-Proofpoint-GUID: nvmoKqX5ZigMW_19p6LWWIgBiwoOrcHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220115
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
> The loop to store pending IRQs uses g_try_realloc() to expand the
> buffer being used, but the returned address is stored in a
> pointer-to-pointer, thus the check is supposed to be examining
> the contents of the pointer, and not the pointer itself.
> 
> Define a temporary variable to catch and test the returned pointer.
> If it's NULL, return to the caller to perform the free on the
> unmodified buffer. If it's not NULL, store it in the caller's
> pointer and restart the loop against the new struct.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller device")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/intc/s390_flic_kvm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index 5e6d422fba..ebee6bca9c 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -254,6 +254,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
>                             void **buf, int len)
>   {
>       int r;
> +    void *realloc = NULL;

Ideally use a different name to avoid shadowing the libc function.  (e.g. new_buf)
Other than that

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

>   
>       do {
>           /* returns -ENOMEM if buffer is too small and number
> @@ -263,10 +264,11 @@ static int __get_all_irqs(KVMS390FLICState *flic,
>               break;
>           }
>           len *= 2;
> -        *buf = g_try_realloc(*buf, len);
> -        if (!buf) {
> +        realloc = g_try_realloc(*buf, len);
> +        if (!realloc) {
>               return -ENOMEM;
>           }
> +        *buf = realloc;
>       } while (r == -ENOMEM && len <= KVM_S390_FLIC_MAX_BUFFER);
>   
>       return r;


