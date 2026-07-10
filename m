Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CCFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiHuH-0004kE-0F; Fri, 10 Jul 2026 16:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHuE-0004jQ-DT; Fri, 10 Jul 2026 16:33:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHuC-0005Ad-Q5; Fri, 10 Jul 2026 16:33:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKIGB52115110; Fri, 10 Jul 2026 20:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3mJW6B
 JYyqZtJO7JzT18lTXkYKIEKU43VOKD1Z36oQw=; b=h+TIxxmKXf9Uaq4UaDegtL
 Ec20aowyHBPpMr132KYs96tk+ieogYgdrng8mC7YYCzKX7aBROsfrKGgTwtzhgZh
 3OeZltOfS6tOvpLeTjDdDMyAGmPaXJ0Z3ebVIrH9ocN0Zca1D9t+LaF2gOQv6xLp
 4kiVyYmh/bNvUsq+f4n7dSBwc/mZRGRvrBlAbdgAYdudSuEyllyj0zN7fFrqcjVN
 2EeY3XvJJf7Tcn3zK2YUINndmZDY2+Ztlct1Ta9TEOKqZj8pRL0xBdhMwJaFxwQD
 cvwQL0d+PyQc82vVR6ZW3uozLp19QLGJB1idJVXW2ERSCBkIX2PappAkRKguhhow
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0e045-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:33:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AKNoYM026201;
 Fri, 10 Jul 2026 20:32:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqm0vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:32:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AKWvK616319130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 20:32:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A49A5805A;
 Fri, 10 Jul 2026 20:32:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164FA58052;
 Fri, 10 Jul 2026 20:32:56 +0000 (GMT)
Received: from [9.67.136.45] (unknown [9.67.136.45])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2026 20:32:55 +0000 (GMT)
Message-ID: <3cf9351b-71c3-4803-b9e3-52987b6d8068@linux.ibm.com>
Date: Fri, 10 Jul 2026 16:32:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 26/33] pc-bios/s390-ccw: Add additional security
 checks for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
 <20260707234047.2499921-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260707234047.2499921-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a5156fc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=XMBjRswBOKp5J3ctqEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IRIZzhi05jYV1glANnxGIOngspC7h25N
X-Proofpoint-ORIG-GUID: IRIZzhi05jYV1glANnxGIOngspC7h25N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX5cylH0UzdU3F
 HYoFWOEonEyfZyHVJWAJg01YhJY9q4i7DLRU1Xlsi3YpPCdNdtrvd/0bHE7Y3b/ZiR8LKsSALcw
 0t1L4Topvrj/4vSmme6joFMFV7qAbdA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX0LewmDmpolNk
 OxmMFu9FTQhSjQOD4vWJ+/qfSnjeJ1hCsyMFBRNf4gKyUBLtQYtdQOsMZYB2jqujQP4UY7S+MyG
 Mps3qYMjPgpGkd1bmb3YhjPunc/JLz9jL/UIMeII/Vtg+3cGLYX+fdOQ66RPWWVdEBU0EuqXaC6
 gpaLQ3osL86FUIEfh5wpi8d90LeYaSagLfOp+mrMDghO4kMsxzfhEnzlcBRM/bMZIb3fdRUsHbd
 T+X2SPsFqqoBuWB3K6d17DbeD2zR2XKLVuuWl2n+Wrzd9yov7zpvboUkdxLIeSYgkdMRHWk4TrO
 gTx/P6CLYgdgqJwkIq3GI0m3qOC3ixu49Cbwi9gGAz5wCw2ffhQIKwErl1cUElwzgBTvcgLPl+t
 2QyU9zKIBxqaP5au5Tr30DejSq7bz1LRQ+htzSewxYDRnaihTJ8QWFEzZDN9bb3vTfsBGsMGXgv
 Z1st3Q4/pd7QfWY0afA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 7/7/26 19:40, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
> 
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
> 
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
> 
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
> 
> When SCLAF is installed, its content must be evaluated during secure IPL.
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> ---

[...]

This significantly cleaner and much more conscise.  Thank you for all
the effort of getting this to the current state.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

