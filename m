Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DADCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE91Y-0002F1-Lf; Wed, 29 Oct 2025 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vE91U-0002C8-AR; Wed, 29 Oct 2025 12:27:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vE91P-0008KY-Dn; Wed, 29 Oct 2025 12:27:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TCL8ng020885;
 Wed, 29 Oct 2025 16:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=5nGiu3+DYKLipI2zymf6FzpspOzeEKI+CNW51jQRB5E=; b=Cm7JzvtYJQUP
 hX/qvfzxg9DQYuoWfoGQZ5IVTHlRsvreM4wcog/gJ8wAqqJwfd+QmpMlN/9/YNcS
 VMZtm9npiKI4MAXvL4en0p2Dp4Y12jWNygBnfo3dB8A9RoqKufAXKn3opEAd2ZFT
 tLK5FuqpllGbfcVMutQhuSCgJPXhwGNtF/zwwzHfBSdZzKrhBhlMPDrf+DAfzAH9
 S6MxhIwW/wSJA06apbeif86UGwNj4L9AgW708Aoyw7uJttB4dwYgRiCMUWDEOJvj
 5PgwwLao4i8lPlpIhjpTRetiB79YwokchNW+MHgTLfsp1smSAyJeJivJ4+qki+pk
 l/9+uX92WA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agm8nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 16:27:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TGO1IQ012589;
 Wed, 29 Oct 2025 16:27:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agm8n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 16:27:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TDiKpq023844;
 Wed, 29 Oct 2025 16:27:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx4b29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 16:27:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TGROtS61145516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 16:27:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3AC58056;
 Wed, 29 Oct 2025 16:27:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFBB458052;
 Wed, 29 Oct 2025 16:27:23 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 16:27:23 +0000 (GMT)
Message-ID: <e863e676dac2bb802e1f66dff57fe4c26464d7c9.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional/ppc64: Fix class names to silence
 pylint warnings
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Harsh Prateek Bora
 <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath
 <rathc@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>, Aditya Gupta
 <adityag@linux.ibm.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Date: Wed, 29 Oct 2025 11:27:23 -0500
In-Reply-To: <20251029141946.86110-1-thuth@redhat.com>
References: <20251029141946.86110-1-thuth@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=6902406f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=cOzduJsHjfEYIaPULTkA:9 a=QEXdDO2ut3YA:10 a=poXaRoVlC6wW9_mwW8W4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-ORIG-GUID: gpFbQNwyJT0dZF7NRY-r_E2ppSjk57y_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX9iZxOOPM7wUw
 Ns3+Koxb7CI56cLQa5j9ZuRhMr3KmQlPqNZzGB+bMXbP/Mx/ZsHpwuybsHapO3I5m0BWUNEIeHt
 ucNVOFWj2U78go9T9YMV61QzwBSr1YKLuTvV3V+JqOzib5cNnbl1QoGxe2qsAPWWgexTPi8QmqP
 LjFEdlJd5QUlXgw/8l0o6mzZ9QtQiWQ0sSY0mzd3YqL1aJJi/HH9RdIRMo/llT/HPUNuzom25Vn
 Vo2x1psBdTad+7Aa3+FpFUP4YWNGWzvuoLXMB8DueG5A5hlICxV8m09J+aKcCFbv2QhMww8eOBs
 8JVLB+LTKnvD27BlV/vt/u1WVvu8gB7FvANiLMfvvaCtv+eaLMw1YrLkTKdi5s6/pJ1e/zK8qXn
 AIJd4omIRB3JOQpyHoHKZot0IsujEg==
X-Proofpoint-GUID: rCGKM4R_Oxz25fb94eF_pKHle1wrTtt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Wed, 2025-10-29 at 15:19 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about inconsistent CamelCase names here, so let's
> slightly change the names to make pylint happy again.
> 
> In the sam460ex test, also split a line where pylint was complaining
> about it being too long.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/ppc/test_74xx.py            | 2 +-
>  tests/functional/ppc/test_sam460ex.py        | 5 +++--
>  tests/functional/ppc64/test_powernv.py       | 2 +-
>  tests/functional/ppc64/test_pseries.py       | 2 +-
>  tests/functional/ppc64/test_reverse_debug.py | 2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/ppc/test_74xx.py b/tests/functional/ppc/test_74xx.py
> index 5386016f261..219c7991aca 100755
> --- a/tests/functional/ppc/test_74xx.py
> +++ b/tests/functional/ppc/test_74xx.py
> @@ -10,7 +10,7 @@
>  from qemu_test import QemuSystemTest
>  from qemu_test import wait_for_console_pattern
>  
> -class ppc74xxCpu(QemuSystemTest):
> +class Ppc74xxCpu(QemuSystemTest):
>  
>      timeout = 5
>  
> diff --git a/tests/functional/ppc/test_sam460ex.py b/tests/functional/ppc/test_sam460ex.py
> index 31cf9dd6de8..024406d155c 100755
> --- a/tests/functional/ppc/test_sam460ex.py
> +++ b/tests/functional/ppc/test_sam460ex.py
> @@ -8,10 +8,11 @@
>  from qemu_test import exec_command_and_wait_for_pattern
>  
>  
> -class sam460exTest(LinuxKernelTest):
> +class Sam460exTest(LinuxKernelTest):
>  
>      ASSET_BR2_SAM460EX_LINUX = Asset(
> -        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
> +         '/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux'),
>          '6f46346f3e20e8b5fc050ff363f350f8b9d76a051b9e0bd7ea470cc680c14df2')
>  
>      def test_ppc_sam460ex_buildroot(self):
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index 9ada832b781..0ea6c93e428 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -10,7 +10,7 @@
>  from qemu_test import LinuxKernelTest, Asset
>  from qemu_test import wait_for_console_pattern
>  
> -class powernvMachine(LinuxKernelTest):
> +class PowernvMachine(LinuxKernelTest):
>  
>      timeout = 90
>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index 67057934e8d..7840c4e3ff8 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -10,7 +10,7 @@
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
>  
> -class pseriesMachine(QemuSystemTest):
> +class PseriesMachine(QemuSystemTest):
>  
>      timeout = 90
>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
> diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
> index 69551fb84df..4eef779936d 100755
> --- a/tests/functional/ppc64/test_reverse_debug.py
> +++ b/tests/functional/ppc64/test_reverse_debug.py
> @@ -18,7 +18,7 @@
>  from reverse_debugging import ReverseDebugging
>  
>  
> -class ReverseDebugging_ppc64(ReverseDebugging):
> +class ReverseDebuggingPpc64(ReverseDebugging):
>  
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_pseries(self):


