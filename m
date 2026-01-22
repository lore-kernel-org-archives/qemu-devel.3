Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A5D46952
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 17:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viyXj-0005iL-Eb; Thu, 22 Jan 2026 12:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1viyXe-0005h3-IQ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:32:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1viyXb-00022b-Cm
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:32:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEIl64007813;
 Thu, 22 Jan 2026 17:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ZRs5nBLUWQAxjQdfInWCrTbCym0jav
 hAOE79clxbbcU=; b=RLGAxGLHG4abLjtjnFbRUQq/M6pHqi198H7KNKFpHMMD1H
 jdkE0LR9QZMGbDXLR5iZcfCnIp4tM4uOvNvMhwQNDcyrkJjRnIfSK1yTWVaU08ha
 NIOCNX0NFjWtrNDqkOsgc0g6Bu5JgkjbHYqCZF6C/RuJOnbRpnelPuopMCM93SyN
 U5f8YE68vY8TVaKqjvSsAFXi2zbGWnmO0ps/KNuRx75bqpJOdTAPxoY+tZzwNn3g
 doIdVR4IK1IUkBbJUi4UbYX3hgUpjFj2Mzk3/sc32sGs8yjAO64yVOJJ9NWGekCu
 gZDNYoojhrhmIUOSXFIEAgWOnztGr3OieK4g0HnA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukhvq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 17:32:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MFf82j016636;
 Thu, 22 Jan 2026 17:32:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ybtu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 17:32:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60MHWCgT43450628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jan 2026 17:32:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32732004E;
 Thu, 22 Jan 2026 17:32:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876C020040;
 Thu, 22 Jan 2026 17:32:09 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.24.131]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 22 Jan 2026 17:32:09 +0000 (GMT)
Date: Thu, 22 Jan 2026 23:02:06 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] tests/functional: Enforce sha256 as hashsum algorithm
 for all tests
Message-ID: <aXIcMAWfKXM_kBs3@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260121101957.82477-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121101957.82477-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEzMSBTYWx0ZWRfX2NZxZEkDJ7up
 NBO9VSUODyP2ppyWrsVP9GYvp/JL59EbcWYm0OoVe5wr3LQsrLGDVGDTvuF/3VeuOuSQA2wnKCd
 /UHOoPW62pGKe0ykDOZ9JknyQrz7s4ZmCOzgpMqPKDGChUbQDovwgmHmjD7ECZerG3TyLxe+1N+
 yRYepHfx8Wt+VAYQJWPHsUdkt6XQlHQPlxyTfg6BnMsqV/aPTIrK9roOcV9kAUtQwn0KNeQBqGG
 PUo/FiO7YIe5ShjdKB4u+m8jBC42WsheO2tbLA4XMQ4spui3DQ9UxU2jB1g16cI+g/2b+GaK4sv
 ht1sN922hNLxEuGkDqqHeHQOZrc/IqTECufiD/ZMwe5TZWXU/BB+4uxSWQbosnTjUxIqmRKDXQG
 yL5cQmE3okFgWnhqcyrMeXELur05dLmGL9GOVhikEIhINtFI01Wmh2LDaxhp/X58dEg3Ob0c0g4
 f0JNPNAAcWgtKcEADRg==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69725f20 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=uJKhRoVsQpQ1z33JokAA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: wN7NgLwQbWpoO0bZm4THmk7DioeHlIuM
X-Proofpoint-GUID: wN7NgLwQbWpoO0bZm4THmk7DioeHlIuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/01/21 11:19AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The functional testing framework currently supports both, sha256
> and sha512 as hashsums for the assets. However, all but one test
> currently only use sha256, which should also be sufficient according
> to the current security standards. Having two algorithms around already
> caused some confusion (e.g. the clean_functional_cache.py script only
> supports sha256 right now), so standardize now on enforcing sha256
> before more tests use a mix of the two algorithms.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/ppc64/test_fadump.py | 4 +---
>  tests/functional/qemu_test/asset.py   | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)

Looks good to me.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


