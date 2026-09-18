Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46C3C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7dbd-0000lI-C2; Fri, 18 Sep 2026 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dbE-0000ij-6K; Fri, 18 Sep 2026 14:46:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dbC-0006wj-Mu; Fri, 18 Sep 2026 14:46:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IH1pWN660585; Fri, 18 Sep 2026 18:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=nj+wwWbiPG8wZbsPWuUCTeGB93pT9c
 xKRXFo3rOYdTg=; b=oEe35jbJjBBzrDdCYX0Hy47cYSryHsgF7W40V3kRxBOK8L
 pROypmMMLUMioQ+vxlUHS9bL+yn2XBBSWzRcaneasHWAIYN9AsDb4b+JOY3uIwha
 VmfxwoLSX+he1LCefW6fddCvweA0vNGW+hPwRBS0HoNIAiG0V4CHQy4nSZtR/SLC
 M6Lz9dzvowMvoqGHvIjVm3H9xfRW2M7iBUnxItrVYzXMNes19pewx9d3GInKtDl4
 DDpqw/pxrs4VnwJ5ulYujiaIgf6RtxglpdgA0P8pVk6DnN8G0bxlyoBMR6KP0JGW
 t0X0wuGaQ7fwvfoF70Y/QGCYjb2Yu51yJ6Q3foYg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eh9nf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:46:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGpC5k1015632; Fri, 18 Sep 2026 18:46:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffgrvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:46:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68IIk7Rx14811432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 18:46:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 350A620043;
 Fri, 18 Sep 2026 18:46:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D854B20040;
 Fri, 18 Sep 2026 18:46:04 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 18 Sep 2026 18:46:04 +0000 (GMT)
Date: Sat, 19 Sep 2026 00:23:51 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com
Subject: Re: [PATCH v2 2/2] tests/functional/ppc64: extend ppc64 powernv net
 device tests
Message-ID: <20260919002127.3cdafd83-be-amachhiw@linux.ibm.com>
Mail-Followup-To: Aniket Sahu <asahu1x@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, 
 milesg@linux.ibm.com, harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com, 
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-3-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916103635.7797-3-asahu1x@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfX+zVLXRJzj2BF
 KCczNZSWzRM9VUOa0SKZ9typG2jufCQD7MryzASTqECAY0UnbCJpjx8DmakSrxfr2cKP+AXj5KQ
 qZLhYuTfdSJxIpiSMUtqQA1XL/CnxmTNS4S2Hu+PdGAdtG6YkeGFdkSWK8mlUL3xJD05az28wQG
 g/iwEGeS0v3cICPJM7IpHTI4xUHY8eTa5PjFK81I4+UmQ3aIijvf3FF1wfuGWbZw+hyeYOCWW90
 DVhNT+OJ4NFw8bODLIchD4EInZY0t9927mnbDPkN4MEANSh5RLxZj4WNTB7DHcl3zWxxnnL2Rih
 cqcP97f3kEtUAfWfZ2OUw/ZwG2LMM2U97OaN9fMBflUHAlr9H3CfM+g10NfVLOwzA/VoTTdfvGE
 kHx8GUxO01ln2PbVHauo9Havb+GVhwWXvtvND/0eq4XDKzi+d7oXTr85CI2Md25c7IWKBN287lR
 TglHWEeagoqwyuNAf+w==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad86f4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=gbOv8vlnZcgnT89JuzEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: -IdymL8VhDWr4GmqGFyFdYrpSBI36XSi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfXyM7v2yxifDHw
 fhC2PcdBIojb8ABQECwCFLrldT5ycLg+aV/tjbkX1/91U7TyZSxAWTct3crViWKVBft2QcHHLPq
 FKI02h9xxgORor+9wsn5+Me+fAtXNeI=
X-Proofpoint-GUID: mxiKRu5mS-8EdNEGO4fRA1dB0UN3l9hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180266
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/09/16 04:06 PM, Aniket Sahu wrote:
> Added console checks as the probe log lines will appear before the
> S14Silence-console init scripts.

Please add your missing SOB.  The changes look good to me.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> ---
>  tests/functional/ppc64/test_powernv.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index f3e05e4d38..200fd2c894 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
>  
>          self.wait_for_console_pattern("CPU: " + proc + " generation processor")
>          self.wait_for_console_pattern("INIT: Starting kernel at ")
> +        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
> +        # during PCI enumeration, after OPAL hands off to Linux.
> +        self.wait_for_console_pattern("nvme nvme0")
> +        self.wait_for_console_pattern("e1000e")
> +        self.wait_for_console_pattern("xhci_hcd")
>          self.wait_for_console_pattern("Run /sbin/init as init process")
> -        # Device detection output driven by udev probing is sometimes cut off
> -        # from console output, suspect S14silence-console init script.
>  
>      def test_ppc64_powernv_external_dtb(self):
>          self.set_machine('powernv11')
> -- 
> 2.52.0
> 
> 

