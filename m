Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EBECCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 05:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6j0u-0003Fz-No; Thu, 09 Oct 2025 01:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6j0s-0003Fh-Od; Thu, 09 Oct 2025 01:16:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6j0p-0001xG-Lw; Thu, 09 Oct 2025 01:16:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HIUeg002656;
 Thu, 9 Oct 2025 05:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9hCjAR
 TaqakU9yx1RGL6zIRes4Bja5Kf/+lfQSGX6NQ=; b=RctimfVp82VRsHRCdCveCQ
 KTSVkucA410Twgm2kymmXQHwOhs1HzXFFxaKXJggkLaPmj+tBaqJtGhOEYybjkcm
 eHGY/Ry6MS/mGh5QP3Iw17bSVLZH4Oqx7HIqx6Ts++NVCfETaHLr1lu/lh0y57zw
 NmBAiWWrBROI324uGmQMQODeZ04Ob/3xa3WaIdtHwnWg5NOphG2cMh0QeXMOA8uq
 PzaC7TCV45Mfn36LwaIzE/x42OJuspiOTblsRm+tFL+eObhxe/p8OCCezrA0WfM6
 iR+b15/eS0FzJVLBi65mqG94eZI7fAuY1ChaNnV/vHP4zPucjGWuEeXDaRDp9B1Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86tfbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 05:16:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5995BAru001263;
 Thu, 9 Oct 2025 05:16:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86tfbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 05:16:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5991U4us021035;
 Thu, 9 Oct 2025 05:16:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8sjfjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 05:16:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5995G71s26477170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 05:16:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C149958052;
 Thu,  9 Oct 2025 05:16:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C2AF58056;
 Thu,  9 Oct 2025 05:16:06 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 05:16:05 +0000 (GMT)
Message-ID: <089f1165-2c4e-445e-902b-80ad14b21d4c@linux.ibm.com>
Date: Thu, 9 Oct 2025 10:46:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ppc/spapr: remove deprecated machine pseries-4.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
 <20250507052048.90559-4-harshpb@linux.ibm.com>
 <a5893e2f-c340-4d6c-8014-e207de4b3cfb@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <a5893e2f-c340-4d6c-8014-e207de4b3cfb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OUANCx3LGGLRY4y3rgJlEBDR8P9IA1_9
X-Proofpoint-ORIG-GUID: ZO9RrhhaGaSqkFC6gdiRqRCwpNk9l9OH
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=68e74519 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=VJ07JQiwR9Yi3m89-oEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9/ppWoPZxn6Z
 1hedH8sRJj9XjMMR2l+YSQYR90jPFtQWEQUmmC5wWzDtG1OM43MqDxHMJGagHIqYUGzIJsOgjzZ
 KzMYWvLvrdyM+qV0UsY4rJpq9OgIZTRFGzqncShjT6xW8mtDJd3y8k0OAQh9/0bPuE/GLkZ5PnE
 WK/F6Cgizx+215TbfXZso28+Toj/COEhC4uh1pYf28aL3pz8fRF+0BzMn5Ub2hH6mxy2rm9zzN7
 77KdV/UrgkGd79uFDfFv3HQH2NvfAqNNXK3HNLXlBKwT6q+6T0y/vjjHFPAA+xsxNUM/Rg4qCkO
 eNxT9RvxNRsxkCJjaEHcYtgRuR7CSdKQnfj5Iy2p2t6UEcZ9P3QIkujvGMyuSvntwio3I046yUF
 Zt0I1wpThoFiOb4Mgxgid62rmPvmHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/8/25 12:49, Philippe Mathieu-Daudé wrote:
> On 7/5/25 07:20, Harsh Prateek Bora wrote:
>> pseries-4.0 had been deprecated and due for removal now as per policy.
> 
> Please consider splitting, but up to the maintainer.

Hi Philippe,
Thanks for your reviews on this patchset.
I am revisiting this patchset to include 4.1 and 4.2 also.
I usually prefer to split patches wherever appropriate, however, in this
case, I think related hacks are better removed along as there remains no
other consumer of those hacks and can cause build breaks in some cases.

I will send a v2 including removal of 4.1 and 4.2 though.

Thanks
Harsh

> 
>> Also remove pre-4.1 migration hacks which were introduced for backward
>> compatibility.
>>
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h |  1 -
>>   hw/ppc/spapr.c         | 27 ---------------------------
>>   hw/ppc/spapr_caps.c    | 12 +-----------
>>   3 files changed, 1 insertion(+), 39 deletions(-)
> 

