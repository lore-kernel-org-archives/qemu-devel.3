Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D49C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnC74-0004Na-CF; Fri, 24 Jul 2026 05:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wnC6x-0004Jv-JT; Fri, 24 Jul 2026 05:22:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wnC6w-00015V-0A; Fri, 24 Jul 2026 05:22:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O5BcK83220060; Fri, 24 Jul 2026 09:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LGl/u5
 fLgMgtmVjrM3pWvd6OQLvNmFSMmmXnlP6Fko0=; b=pcz1+9PtpqgK6+xeAjk29a
 7ciIodfGXStzOqn8ssDu6b41i5V/KURFTZEfVa2TleFZ8+yMSFHf5LmLSQHM3ak9
 BI0iyjYkWHCu7jX4MgDh1JHN8cReOmd/z1p11fsNZ/t6l4MiMDW2ktCuTXi8Qdme
 sqnvCqLgtIT+RH/yhiWqyOLY8+A2rpa4H0fYh4M0XVneRW6+aG7mtm8bjYWCP0jf
 gEA99s5LMSQ1yhUmT135DPColNZV6yXtQ1deUdyK7xPnhgkYGxZ/NZsYztyW5Wir
 vDcr7/cK+D3ziENBEftqh3ygZ+4tQrgDb/kmKVb3o5PsHDd82XrDCoU7inc/7o8A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77auyej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 09:22:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9Jc32004783;
 Fri, 24 Jul 2026 09:22:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqgejg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 09:22:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O9MKGk46531054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 09:22:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61D2420222;
 Fri, 24 Jul 2026 09:22:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD5BA20225;
 Fri, 24 Jul 2026 09:22:18 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Jul 2026 09:22:18 +0000 (GMT)
Date: Fri, 24 Jul 2026 14:52:29 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com
Subject: Re: [PATCH] tests/functional/ppc: skip remote interrupts test if
 -net user not built
Message-ID: <20260724144108.86a98713-59-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724085440.520125-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: X2sVqkGGIyiU2slVECCEbQdFFPj1MbbC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfXycfWvTKEm4M+
 47h+AmNlnF4IIHRcXkDQC5QMMnZPTj/CM8pr3I1cil5o4MNHX3HYLz+NOxQr4TiLeVBFhZDVK+h
 Jw+eKFytEeNgc5w5Px93nqPY+MSKiGI=
X-Proofpoint-GUID: KZ7AIOMRz1sHvIqPo77P7KjzSD1Fyh8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfXzbkDZM4GcFXL
 zRpHvIlm/H8bsMWSOovoJmCf3v4tZa+LRNtS1oVl7Y9TlQDmOELaFesK8yHjYpzvC7nf70iabuB
 mujGgLB7IVr8wja6g00X0yvWXIl+SRP0WSzSua29LgRi6xCm20rE+1kVV5qls2GCsGdixTtyk2I
 tkQas6euRmbRjTNGWjT8x3k0lQgqDSeXhSb4if2TUdiMhJ3xIZgilgvdLQj7WMrOBlo+oSHgSEp
 /SXrhgirXT0uvyFGJ8k9n2NUohFKYbui69hvlB7ht6wZdbmJBhdOnmHsSxO10UBs0rHVu5txL7Y
 lWpF6XwY+qM927DXx26nkMAPo6iEC9cYtT6X8v/Q/ymaZ84/oqzEn0f0HubNbF60EenwyIJ4dLL
 dAezMcqIFgqLYY7b9QmCbtB/dochVngb+cLcPgC83m9ruPL/IxA9Mvagb56dixM7PIPcC9qDuUZ
 iCifC++TvI4kLKvgYBA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a632ed1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=S7ZAVMCwYWg9vFqUeq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240083
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Shivang,

Thanks for the patch. Please find my comments below:

On 2026/07/24 02:24 PM, Shivang Upadhyay wrote:
> While running remote interrupts test, without libslirp-devel installed,
> facing the following panic logs.
> 
>   File
>     ...
>     raise VMLaunchFailure(
>     ...<3 lines>...
>     ) from exc
>     ...
>         Output: qemu-system-ppc64: -netdev user,id=net0: network backend
> 'user' is not compiled into this binary
> 
> Skipping the test if vm fails to launch.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  tests/functional/ppc64/test_powernv.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index bac2017e18..73ba4e7221 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -11,6 +11,8 @@
>  from qemu_test import wait_for_console_pattern
>  from qemu_test import exec_command_and_wait_for_pattern
>  
> +from qemu.machine.machine import VMLaunchFailure
> +
>  class PowernvMachine(LinuxKernelTest):
>  
>      timeout = 90
> @@ -112,7 +114,11 @@ def test_linux_remote_interrupts(self):
>              f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
>              '-append', 'root=/dev/nvme0n1 console=hvc0',
>              '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
> -        self.vm.launch()
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure:
> +            # Maybe not compiled with netuser backend
> +            self.skipTest(f'Could not find -net user')

I think VMLaunchFailure would be raised for any VM launch failure — not
just a missing netdev backend. This bare catch will silently skip the
test even when the VM fails for completely unrelated reasons which may
mask real regressions.

The framework already has require_netdev() which probes the binary
before launching the VM using qemu-system-ppc64 -M none -netdev help.
Catching a post-launch failure to work around a pre-launch condition is
the wrong layering entirely.

Below change should be enough to achieve what you are trying.

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index bac2017e18df..f3e05e4d3810 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -90,6 +90,7 @@ def test_linux_smt_boot(self):
 
     def test_linux_remote_interrupts(self):
         self.require_accelerator("tcg")
+        self.require_netdev('user')
         self.set_machine('powernv')
 
         # Have below setup in this test:

Thanks,
Amit

>  
>          # Wait for boot to complete
>          console_pattern = 'CPU maps initialized for 1 thread per core'
> -- 
> 2.54.0
> 
> 

