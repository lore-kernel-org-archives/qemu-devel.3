Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAF1C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woccr-0007Bz-Cd; Tue, 28 Jul 2026 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1woccp-0007Bl-R5; Tue, 28 Jul 2026 03:53:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wocco-0002dj-4p; Tue, 28 Jul 2026 03:53:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3mKug4109976; Tue, 28 Jul 2026 07:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=2RzfPZ7cR/8einNva2H9ioM9I6M/kl
 fQzs7YqC6QFhI=; b=iGIxPJ8CRrT/Epws3zxiuQoUSdPBO1eqCDAbKv8Uh7ZQRZ
 3rZdfnvkYNLnvJqPxKKwZd27YC/ksUbiWn+whpE+uLjmAQr/4sHucA2lxFyIX25y
 bw6XwIqcbREFWCbaTzvNGZc+LA6wE9cDGKAS1UrpemVaugo77rh5UbDccX1aVJJg
 Qt/KPIiLQttwHITxHJJwzRDnpVLEez0Gmg3+eZFD+vCKQgumOjlcsLsutV+GvP1i
 Gq0fp/NmUDUj84jTs6ZH9aHXB6HRPSiiVE9j+qKWj8d3Yc5/82DvXlB0kglNNRVX
 m9hTnntlfoq5asuE3Cjg27yup+zrddVROqb3Sk3w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7c3j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:53:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S7fHeR002613;
 Tue, 28 Jul 2026 07:53:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq90hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:53:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66S7r91a51052876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 07:53:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 697FD200F5;
 Tue, 28 Jul 2026 07:53:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91F17200F4;
 Tue, 28 Jul 2026 07:53:07 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Jul 2026 07:53:07 +0000 (GMT)
Date: Tue, 28 Jul 2026 13:23:29 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, thuth@redhat.com
Subject: Re: [PATCH v3] tests/functional/ppc: skip remote interrupts test if
 -net user not built
Message-ID: <20260728132223.288d56ce-6c-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 thuth@redhat.com
References: <20260728074612.42397-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728074612.42397-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zSB9shp0si-X7pcOs8dC6XxOB-dUMDQl
X-Proofpoint-ORIG-GUID: oPhsWcdzbF5eo1oqbqZQFLJgYMzPGorF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfXy05btRj8camc
 GHKHl4pJzCGxzFNvBxvvw/grDemtQOro+CqN2HdR6S1EUcUlcdTvC2Vf1hA4BoDuwIxfT16GvrP
 JuyrMot0auE7I+TOkSsTverLnWco/vCrFu0d10CSWfeRCMnwD9hiyaK5b23K+6i2jNYC7key8gH
 S1jCqYmtYUCYTrXkuIKCtV8mwhvWArNEPFKZJSLel/Z8Q4wQ4LRMVWsAzM5+XL/Y9zC31bHesJi
 4tthrWfJzimUn0diuWA2FsgpCi7esqDVdn1kupdU1wIU3z4YbqKi7wcsFE5FlhvJyGYDRJC5jTP
 DNxU2WhcAKuX71selGYqLLkVoy84IgNLAdS4nywEX8hw/WtCouwONOTB7erH5EKUSTZQ0vflboP
 m/ox+Zogq1wnIiUTrnjsWLmFuyM1nLGXZMrk2Yd9V2okH/LzMUO/V4lbClZPILefF969OZVMNHz
 dRpXHHhXM6BsRjZGG2Q==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a685fea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=6--wvjDIrt9mtkLDudQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX9Sv40UgsNPAQ
 eUPYRfN3hFD9K4MR4FDKyYP1e2vA1bi5fcfQh2AxsM+OMDy6cNB+ykHiZu7ZtaHuQR0GcNcmoKE
 PNCRS2I7ck07Au1pQJre4FBTi7K6+SM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280066
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

On 2026/07/28 01:16 PM, Shivang Upadhyay wrote:
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
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Fixes: 63f5ba80921 ("tests/functional: tests/functional: Add remote interrupts test for PowerNV")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---

Looks like my Tested-by: from v2 got missed. Anyhow, sharing it again
here...

Tested on a system without libslirp-devel. Test is correctly skipped:

  ok 1 test_powernv.PowernvMachine.test_linux_remote_interrupts # SKIP no support for user networking
  1..1

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
> Changelog:
> 
> v3:
>   - rearranging the require_netdev, before set_machine. to keep all test requirements in same
>     place, as suggested by Amit.
>   - keeping review tags from Thomas and Amit.
> 
> v2: https://lore.kernel.org/qemu-devel/20260725174600.17683-1-shivangu@linux.ibm.com/
>   - moved to require_netdev method, suggested by Amit and Thomas.
>   
> v1: https://lore.kernel.org/qemu-devel/20260724085440.520125-1-shivangu@linux.ibm.com/
> 
> 
> ---
>  tests/functional/ppc64/test_powernv.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index bac2017e18..f3e05e4d38 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -90,6 +90,7 @@ def test_linux_smt_boot(self):
>  
>      def test_linux_remote_interrupts(self):
>          self.require_accelerator("tcg")
> +        self.require_netdev('user')
>          self.set_machine('powernv')
>  
>          # Have below setup in this test:
> -- 
> 2.54.0
> 
> 

