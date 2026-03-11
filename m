Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E35EFCC9B0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 06:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0CfU-00036c-Oc; Wed, 11 Mar 2026 02:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0CfS-00034m-Dl
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:03:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0CfP-0000TL-KR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:03:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJkWhW1524531; Wed, 11 Mar 2026 06:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VXX6BaFh09ZlNLldK7h7p/JTMzNLGd
 diJcb6mR8gpgU=; b=VVo+/NpyWP0gg7wroWpHTbhu1zSKHbHU25qJ8Lz1t5RHYy
 P+Sy7HrnnhSvohtBMJfVEQa8UlgEQwP+e56ZoTGbiY50ExLnnPq4go3p0DZ0QxgV
 6VZkYp4USzILV71F9vGbnLEcealP44PfD5lBXK4XGeuUu2qJW34d43OzPugu3s/1
 R5c4QXzLiMQv2OOo6309nCPlKtI2oD1LJHgroPiI+qMfPSMU9wNZIXpZULrqS9AK
 c5r2siTyrzbcgEGQ8rkX+6w5Jqpd1CbNEDk53Q+IFgVn5e4/mkH6DnlVyeL3Aqih
 XXe9N1l4ujfnn8ob181vpbdZGubqe6QWJ4aZUgAw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmegku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 06:03:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0p0fE015633;
 Wed, 11 Mar 2026 06:03:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybnc94r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 06:03:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62B63Qs046006722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 06:03:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2A4E2005A;
 Wed, 11 Mar 2026 06:03:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13F6120063;
 Wed, 11 Mar 2026 06:03:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.213.196])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 11 Mar 2026 06:03:24 +0000 (GMT)
Date: Wed, 11 Mar 2026 11:33:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/10] PPC PR for 11.0 soft-freeze
Message-ID: <abEDACgG6T4N9F0P@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
 <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
 <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LF92K4YNVkzhkFb_CqX2bcWUWtsyhJOi
X-Proofpoint-ORIG-GUID: LF92K4YNVkzhkFb_CqX2bcWUWtsyhJOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0OSBTYWx0ZWRfX/xT28+EfMxbQ
 Gv/n0y72EFbDwkCcQ0M3UahuKAfniAlJxVwP6B2Ii2sZlihCTwinAQ9Dp9DiKqPf5th9umRkltZ
 bXSfUa1Y6P9mLHJj+WuM1f7Lk+SLKoYtW70cG9ZuTpdCNeREGwVkD4xlIvAZGUmAmpjIJFUn8nR
 B1RGxZmj6sOwL4Ig1BX0ucuLIUeYMM+SWpOqnztIuFIynN/ihAvPdTy2RGW4RJbvwa+gOWuQniE
 7YHknI9QimfMnfkgrKPOdiXMar8JkqHfKt82bL3r6lQQgwi7ZPMfokbiakYoTL7+qEdcDcRJc9K
 LRcPlUEBzShcvBVl8XFj3A89ACrsHGKJ1C2cwnvFq1I1Sj75MaBA5QgbYPSj7xxVdJs0jIfCRQg
 CgJrvnPTGdioRNlTeRlBFegdvAEIKrmOhB1wg3/MasvjrWr4A3VqAvYhwKmNwTs/3xBGrnH7rrD
 hc+5hHohnOioEqqkiBA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b105b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=US1h2DCW-XsVH_cf1JMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Peter,

I run the pipeline everytime before sending, curious about the tests I
missed.

1. How can I get the console log of the failed centos test ? Or how to
(or if I can) run that test on my system ?

I did not find the log in the gitlab test's artifacts.
Surprised with the failure on the particular centos distro.

2. Is there a way to enable these tests, or to get access to these
tests: aarch64-macos-build & x64-freebsd-14-build

I read these are run using cirrus ci, can these be run on our systems,
if not on gitlab ?

Thanks for the suggestions Peter, i have the fixes ready for the next
version.

Thanks,
- Aditya G


