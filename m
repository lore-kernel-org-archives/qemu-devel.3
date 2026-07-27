Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3178BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEC1-0008N1-W0; Mon, 27 Jul 2026 01:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1woEBz-0008ME-Go; Mon, 27 Jul 2026 01:47:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1woEBx-0004Tn-UH; Mon, 27 Jul 2026 01:47:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1ljP5856156; Mon, 27 Jul 2026 05:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=fnC3VU2QX0BmZeizcNnXv3x8oksJ4m
 acVoZK7Hyyhok=; b=JMegFdZ03kRM0GRS7vM+JHUHL3PaFCDqwyW7swvelCBHrk
 Tc7cH0VSAEe42zY3veZgVrLUUxS1+A8nXt3cKmC1hWG2vsMHtYKRWf6mBypbwAZw
 rk08Im4KA7ZeHEPFWW8SslDa8FRNx0VAINFrg0DbE5rn/o3hUUzFcU91Bun7/EvB
 5omJWtRS707k+mWSGZZGlBcPULfTYvEE7kDCorIMDsoaiD8gqQWhRPqEo0x3VbQi
 P0d4zdEd4fUkUVTAhmH206K1OXXwltDB/b4EsYpEcrJduwn5VIb6DWKHXebcmxRD
 zX+CFOyQ4AT68NvEZZbQHNHNRDDUWKKIxOh+WFGQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw76asb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 05:47:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5fGvP026175;
 Mon, 27 Jul 2026 05:47:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjv217-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 05:47:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66R5lnP440960348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 05:47:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FBE32004B;
 Mon, 27 Jul 2026 05:47:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 868F020043;
 Mon, 27 Jul 2026 05:47:47 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 27 Jul 2026 05:47:47 +0000 (GMT)
Date: Mon, 27 Jul 2026 11:18:06 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, thuth@redhat.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com
Subject: Re: [PATCH v2] tests/functional/ppc: skip remote interrupts test if
 -net user not built
Message-ID: <20260727110516.c62eed78-ec-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, thuth@redhat.com,
 adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <20260725174600.17683-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725174600.17683-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: t7dorexCDRiV9fGcKatFFacdn7QNZrVO
X-Proofpoint-ORIG-GUID: nGKNiFoUYP730nD0aJs5Gg9brG0iVtUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1NSBTYWx0ZWRfXzkUPonYpKJKA
 W+qb9V+VZUzioPOT0bK1hJbnagRwKNE1I3GccwVrahPsaQQpTcLjbD07dS6qoazPi/FNfM8uw/9
 dGCImhzs8+TgmJ+ydEWHKoZNOg8+G5kh8q0kK2RxVIOBB2xjnEMXSdL2k3l7yrh6LsyhpjIo0rF
 YceVCauM3WLXotmIEawpyfvIM6AARnWekDrMIkg6eP4uHfzPr6ozjqCMwsxnXG0EsRtDnFRo526
 dWcEltKyeV/WNkrwIfNfWjv079TIOAGYeOcTMlSABlE0pyssoXUj6CeJvDWD5IbA/u1OkoxoFsS
 sQFw2BL57YXDett9FxORHlUWDOcZuU9xD17cJkoGDvR7QgoPr1x1y9uOTcDyAR97LgQMdsMhjDb
 UXzMxiF1hHQdHWAYzzqVR0Bw/QcNfsqaHXUJBo6tUy7gHUbOcg510xzekKy+PXI+8Rn0JSFTnVM
 e24mlenXA+ezjFX/nxw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a66f10a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=U6qE2ORhIC03JROcnmMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1NSBTYWx0ZWRfX/xBsEC5NsiXS
 ei4ELYnKlepML4H9FRqf4yiBoJDM/w3TDlYnEcxfpkqWMrd+NG0Qhgtg7sUpR7GDHR/FEw2Hvx1
 q701E5gV0mdDlekx9cSb+KERp89pSBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270055
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

Thanks for making the suggested changes and sending a v2. My comments
are inline.

On 2026/07/25 11:16 PM, Shivang Upadhyay wrote:
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
> Adding netdev user requirement for this test.
> 
> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  tests/functional/ppc64/test_powernv.py | 1 +
>  1 file changed, 1 insertion(+)

Tested on a system without libslirp-devel. Test is correctly skipped:

  ok 1 test_powernv.PowernvMachine.test_linux_remote_interrupts # SKIP no support for user networking
  1..1

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index bac2017e18..9a95b6011d 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -91,6 +91,7 @@ def test_linux_smt_boot(self):
>      def test_linux_remote_interrupts(self):
>          self.require_accelerator("tcg")
>          self.set_machine('powernv')
> +        self.require_netdev('user')

One minor nit: require_netdev('user') is placed after set_machine().
Though it's not necessary, I would prefer to group all require_* guards
together at the top before any setup, so it's immediately clear what
preconditions the test has. Either way:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

~Amit

>  
>          # Have below setup in this test:
>          # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
> -- 
> 2.54.0
> 
> 

