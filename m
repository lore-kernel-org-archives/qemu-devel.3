Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EB7CF857B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2Ir-0005Hm-Kz; Thu, 20 Nov 2025 05:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vM2Ip-0005HV-Td; Thu, 20 Nov 2025 05:54:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vM2Io-0005CI-3s; Thu, 20 Nov 2025 05:54:15 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLl3Uf007043;
 Thu, 20 Nov 2025 10:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U5h8Eg
 /ZR4WFv/WFzCvPfEfe3jCrxFWTh/GoMiyvhG0=; b=LMrcqX4cKECR6Of2+hCvGC
 3vlwVUIOKo5FcjxPEyKw20PZUUhuQdYM8OeKu30XPVmmgEpMOORcQa2dw+8bjeGU
 UdpnhafEyHMBdGht1foxUHLXF/e6/PfnWSB/liKhaUiNPCVApLLJG9rdC/qZi725
 1uH5n1gUIE5UIUXPnqp3V+TLkIylSbtzjFZZ0SQXutYznki4uSbTUGcCHNCX3M5k
 KMMYJHXTHJDtSa2/UGfVw86hf7a/xy7ho2VGoC5qGzvCWy/6djq4hPUCt36ekUbo
 nWJ5n0C3Mq3z9HwUvY+8DzgUMRFVoXSBiGfaoqe4iMWdv4bsJL4J8hNv8qVmdWMQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsvkrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Nov 2025 10:54:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9jY86022042;
 Thu, 20 Nov 2025 10:54:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un5xyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Nov 2025 10:54:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AKAruj438076716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 10:53:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE5CB20043;
 Thu, 20 Nov 2025 10:53:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E6F620040;
 Thu, 20 Nov 2025 10:53:56 +0000 (GMT)
Received: from [9.111.47.84] (unknown [9.111.47.84])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Nov 2025 10:53:56 +0000 (GMT)
Message-ID: <cb7ac0cf-940a-4079-aa84-4433a4b49908@linux.ibm.com>
Date: Thu, 20 Nov 2025 11:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: s390 maintainer updates
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251120104602.205718-1-david@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251120104602.205718-1-david@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y4DxJrfIITGUgLrFGHJSe8iunGbK7EmZ
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691ef349 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=69wJf7TsAAAA:8 a=5YGhHGg18xIh5mIUSk0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: y4DxJrfIITGUgLrFGHJSe8iunGbK7EmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8y6FpCgBuV9m
 1P2mnrDBgm1o3iCd0We9bs80TuNQrlOJLna7dy3OPktWSBV/ASn7T7yHZYHwCclCbScDB7TGoGq
 3Mjgx9MkKQKfp9um3DZgwn385ApwDNO5QPrtBaYEZZj/iDUwZD0jEeFZkSuQ2NM+GmNE0g/Sz9x
 X850I7Rc+sTV7DhMoGBzdn1EoN/5iQJkRjVDcWRfg3fKv8nu7PWBdvptAKYrA9ZF1mgMy+yoCkJ
 0J71Bk5oWrZLufvA/ZZxNNhquitpptWoMhIWuJtUEVbY9iKYJDi7+wjkwRzDHJER/o8hXu1SUI9
 sK3p7KplMBjmsM3Jj4hzrRHHnTT1NjIXS3iViuBAQ82Y45Du0EGAHlecHUqF2StXd/FfLAtq7G5
 BVBhztzUbMvp8sClUBZlftShDA/0Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
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

Am 20.11.25 um 11:46 schrieb David Hildenbrand (Red Hat):
> Unfortunately, I don't have a lot of capacity lately to take good care of
> s390 in QEMU like I used to; and it doesn't look like that situation
> will change. So let me convert myself to a reviewer in the s390 areas I
> co-maintain.
> 
> Fortunately, we still have two other maintainers for "S390 floating
> interrupt controller", so no action needed on that front.
> 
> For the other sections we get two new maintainers: Hendrik will
> maintain "S390 CPU models" and Ilya will co-maintain "S390 TCG CPUs".
> 
> Thanks Hendrik and Ilya for stepping up!
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Thank you for your work on s390/kvm is the past. There would be no gdb,
nesting, cpumodel and virtio-mem support without you for s390. You did
an awesome job.

See you on the mailing list.



> ---
>   MAINTAINERS | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1c5080e50..d048c9f30d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -364,8 +364,8 @@ F: target/rx/
>   
>   S390 TCG CPUs
>   M: Richard Henderson <richard.henderson@linaro.org>
> -M: David Hildenbrand <david@kernel.org>
> -R: Ilya Leoshkevich <iii@linux.ibm.com>
> +M: Ilya Leoshkevich <iii@linux.ibm.com>
> +R: David Hildenbrand <david@kernel.org>
>   S: Maintained
>   F: target/s390x/
>   F: target/s390x/tcg
> @@ -1862,7 +1862,8 @@ F: target/s390x/ioinst.c
>   L: qemu-s390x@nongnu.org
>   
>   S390 CPU models
> -M: David Hildenbrand <david@kernel.org>
> +M: Hendrik Brueckner <brueckner@linux.ibm.com>
> +R: David Hildenbrand <david@kernel.org>
>   S: Maintained
>   F: target/s390x/cpu_features*.[ch]
>   F: target/s390x/cpu_models.[ch]
> @@ -2919,7 +2920,7 @@ L: qemu-s390x@nongnu.org
>   S390 floating interrupt controller
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> -M: David Hildenbrand <david@kernel.org>
> +R: David Hildenbrand <david@kernel.org>
>   R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/intc/s390_flic*.c


