Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF527C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAY8-0004ck-E0; Mon, 29 Jun 2026 07:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAY6-0004c2-Ke; Mon, 29 Jun 2026 07:53:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAY4-0003cP-Ge; Mon, 29 Jun 2026 07:53:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmSNf2918383; Mon, 29 Jun 2026 11:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Is/rrH9ZeBbHYTmY6TMNq8knxp2ETo
 SAKz7V1k72kUE=; b=ktrD9n9IDRo4JTPsz2ihJSzpUND+H7LRwRvXo5dR6UB9On
 05MRfDEbS2bO7/prKvZR/bu0LzRLJ0gcUCJCQhMxxOXIEz/K/fq7M3V2jQospCo7
 POVm1rdIg4v0l2l9AVskqCOfZbTvNwgz3bFMRFJrJ2Clf+huVaQzqoeRHvpr62yL
 y/E4BUBzZ1w2b6ZbvHAM9G6IqnfnITJ1/xPV6St6N28L2rpYpTSZHb6gydlhjf4e
 T7qU125RMvvkb1k9ldSKMY+V9QcMTC9iqpTDxe1nhWW4S59XK+g22fNXxdJPrAzL
 mlv22N61gS+EBbKBGLBCw1HlvvTCGrArpIMZmWvw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rerux9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:53:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TBnhto031956;
 Mon, 29 Jun 2026 11:53:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq5dw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TBr5Fl44237202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 11:53:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D30982004B;
 Mon, 29 Jun 2026 11:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B88B20040;
 Mon, 29 Jun 2026 11:53:04 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jun 2026 11:53:03 +0000 (GMT)
Date: Mon, 29 Jun 2026 17:23:02 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 2/2] ppc/pnv: add test to verify external DTB is honored
Message-ID: <akJaUpckzqdnZmHq@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260626112239.177191-1-shivangu@linux.ibm.com>
 <20260626112239.177191-3-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626112239.177191-3-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a425ca6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=kw6g8SXCx7t_rz4BuM0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: tM63XX4YVJVbxssVRrqR9xcgPr-bXi8o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NyBTYWx0ZWRfX8FMY8NuMi+YR
 /iTVRh8NeO6ALZVDkkoOcfN/sW9bKSlBXvcA3wIG2AVAXy9aMhwtdNQPiyZQyPfFod6VxaoNA9G
 ihCVayyUaPS0ZGVpX/+Y7hMV0irqthctDOiet/V3EYcRlVA1QyOAAi3SmjStw9BvaPrxr3jy2iz
 hxyka440QxXjWlqg5z+MOzH6T10pXPlSYBNlkIT/WEf0972H0D/OR75qAgDP9p9o1Owzg3lmzFf
 /MOQ6AAAbpSa63Fs+w1oujRm9O9a7WPK/60EwEmwHngH03C5TiD7DJbWGf3PCx2RHHt1AH+4clM
 ATbq8Xlu7xf+8om9o+XhZBXQIZZDQbIpuDpn75NQzLyLkLREJK6p9yKf1ap3TKQ1uitB/pR3cwx
 ma0WNWgHsDbKMQtTgWaPFyo7d6n+r8SXEjuDWLcjPRMpOfeGajlNMnfRM8B4MlvtqRYhMIUyFVk
 d1ursPK37+o8V4cDp9Q==
X-Proofpoint-GUID: uR4ZSQ5nmXAx_sZ0qqQ1sibtzxazk5lO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NyBTYWx0ZWRfX4CJVkJEo/Bjg
 aCxUOpWZszMpO0ODyJzY+ma0cOWckyRtC3Ym50c2ikBR2/eY3t70voBZjMecrol5mZuWXqLKdbJ
 JwnKg1KzufsL0Yj8TglvIr0dqF/Zpmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 26/06/26 04:52PM, Shivang Upadhyay wrote:
> Test boots a powernv11 machine, using a custom dtb.
> Custom dtb has the following bootargs.
> 
>     chosen {
>         bootargs = "hello world";
>     };
> 
> Test Checks wheather above bootargs make it to kernel's command line.

nit: s/wheather/whether

> +    # testdtb for power11, which contains string "hello world" in command line
> +    ASSET_SAMPLE_DTB = Asset(
> +        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dtb'),
> +        'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')

nit: since you are anyways sending a v3, can you rename output.dtb to
something like qemu-powernv10.dtb, etc so in future you don't modify
this generic path unknowingly ?

> +
>      def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>          self.require_accelerator("tcg")
>          kernel_path = self.ASSET_KERNEL.fetch()
> @@ -104,6 +109,20 @@ def do_test_ppc64_powernv(self, proc):
>          # Device detection output driven by udev probing is sometimes cut off
>          # from console output, suspect S14silence-console init script.
>  
> +    def test_ppc64_powernv_external_dtb(self):
> +        self.set_machine('powernv11')
> +        self.require_accelerator("tcg")
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        sample_dtb_path = self.ASSET_SAMPLE_DTB.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', sample_dtb_path)
> +        self.vm.launch()
> +
> +        # check if custom dtb is reflected or not
> +        wait_for_console_pattern(self, "Kernel command line: hello world", self.panic_message)
> +

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


