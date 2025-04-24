Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0700C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7smU-0005gY-ME; Thu, 24 Apr 2025 05:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1u7smM-0005bv-2P; Thu, 24 Apr 2025 05:21:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1u7smI-00087M-6c; Thu, 24 Apr 2025 05:21:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O4hR6e024462;
 Thu, 24 Apr 2025 09:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0ZbRcl
 hy8gWk33Pf933svHcqtC/dlqEWGsOYvSx9nn0=; b=GvpM2B5Wa0Bu6TU0gNfBSi
 SVq03tdAmlKNU827fKeLeAU6dSq0l6Uq9q2FuoaQfiPPrt5dp4JdKD2KFXZIFx5K
 ShTMxjSpPHSOuvywKvgK9z6Tk39VGy8W8U76IAeqTqeNY0dwyp4yrRPvqE3A6AFl
 g+n/H8BYSjG16X/nSovRgvbphUg27pWrRK2zkavHth553J8Ejc3HMUDQvPUt3QVE
 K2FjnC1wkYhC3Qp1y3BFzmj2VxM5e6wlRyqZr7fIzbMfyAhmTA/251f8TPbu/nUj
 XkEeyipMSkm4TX41t/M/LN6Amk4dXRDbO0LndYQTOuD+0EsCbmdRS1WGhvdhnUDw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jwt04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 09:20:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53O93XS6001748;
 Thu, 24 Apr 2025 09:20:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jwsyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 09:20:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7KgB1005872;
 Thu, 24 Apr 2025 09:20:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxff3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 09:20:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53O9KpKZ22348420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 09:20:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78B9B5805A;
 Thu, 24 Apr 2025 09:20:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA77A58051;
 Thu, 24 Apr 2025 09:20:49 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Apr 2025 09:20:49 +0000 (GMT)
Message-ID: <11874ac0-2136-4a01-ac19-7d28753b8ba6@linux.ibm.com>
Date: Thu, 24 Apr 2025 14:50:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_ppc64_pseries: Skip
 test_ppc64_linux_smt_boot if necessary
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org
References: <20250424085426.663377-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250424085426.663377-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=680a0275 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=f7IdgyKtn90A:10 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=c6Au5R0RPyANlU6bnO0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x4wis7istlkmB4uOTeIG24f2iwLOrP_2
X-Proofpoint-ORIG-GUID: jbkykwMsUboAuUzLGZb6iySbj3yLcxlL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2MCBTYWx0ZWRfX92LUCNMAsMT+
 XMnZavho2vJKDKxIlLgmDgdN/pCabW+z/7CgOtkWM7mlvvgDjgQWJjNWD5wAjPuy2T/pkFHIEej
 Ibbv+MjcE8vvjQu09ERVAUQyuTGdKxpP4JIOfT/HpIWI6O320PmjPRCTXnhz2clJvvtizXwpdCK
 m26A7YbD2du8fUSLgnFnRYVrqCHc+hG6MbSObY6b1f/EU0sIUPJmo/I2OnkqymkSrP6anOTry9a
 YcjxyCJ1YsN8XYOECYSyeYsmCS/oVLlRYQB2Dmuxri2vFCmXWdZDBApoaIvQppgD9hgmxPcM+bQ
 Us30JhyOaoovrkeqRBzYiCuuiZkFAWSDHTxwk0TLjNxkyxuS3IJkZqJWezOb8EIK39gR/E/PXB/
 OC2h/t3ZqVX2xziOFNx0EYz7pvQ2m42BnYq9uFoG3WVbAUWHiipe7b+5+bRacnmUs0hd0qNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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



On 4/24/25 14:24, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The test_ppc64_linux_smt_boot function lacks the set_machine('pseries'),
> so this test is currently failing in case the 'pseries' machine has not
> been compiled into the binary. Add the check now to fix it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   tests/functional/test_ppc64_pseries.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
> index fdc404ed033..67057934e8d 100755
> --- a/tests/functional/test_ppc64_pseries.py
> +++ b/tests/functional/test_ppc64_pseries.py
> @@ -63,6 +63,7 @@ def test_ppc64_linux_hpt_smp_boot(self):
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
>       def test_ppc64_linux_smt_boot(self):
> +        self.set_machine('pseries')
>           self.vm.add_args('-smp', '4,threads=4')
>           self.do_test_ppc64_linux_boot()
>           console_pattern = 'CPU maps initialized for 4 threads per core'

