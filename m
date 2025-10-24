Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B79CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 03:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC8Tv-00082M-K1; Thu, 23 Oct 2025 23:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vC8Tu-000827-MZ; Thu, 23 Oct 2025 23:28:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vC8Ts-0006Jf-Ly; Thu, 23 Oct 2025 23:28:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O12qw2027261;
 Fri, 24 Oct 2025 03:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aZtY4V
 CZ1Z5SbEXRBunQCrz+J2GPN8KOH6oF/G5DSYE=; b=Y75vJJN4Tupv07VugHkP4Y
 XF7ZpE25GorkauieiI7ktTrvuoYrmRevT+m4z7lEUB0nTLh5Gpy9JdOqN9GdUFEB
 Zejm9VRlkg3I0H5lB9Ug5mZaZG2adGIohqFPUV8v/zWTsOgaxLLYQbyA/lO9fyoA
 vju4N8kFMPQsIECCkCuaxM9gteaKedi7clS8djmm7jsKhmj80CvkbmtNQdfzxq7h
 qytz0M0OzeQK04Rh/H2so1rsnx/uAADmasCO8OZLrqyGjVEkVREKEyq/vLrsCz2C
 NhuD4RPtd1+yVWmfRb2g/FYJqulUwLMmogJiJh/HteSqgNblt3cp8yOPUCv05h0A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fndtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:28:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O3PYrm020979;
 Fri, 24 Oct 2025 03:28:38 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fndtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:28:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O1Jw0s011075;
 Fri, 24 Oct 2025 03:28:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1gwab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:28:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O3SYlU51118424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 03:28:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2312A20043;
 Fri, 24 Oct 2025 03:28:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B1B720040;
 Fri, 24 Oct 2025 03:28:31 +0000 (GMT)
Received: from [9.39.26.73] (unknown [9.39.26.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 03:28:31 +0000 (GMT)
Message-ID: <cc23968d-9a17-43b5-80ef-0da8f8f782c2@linux.ibm.com>
Date: Fri, 24 Oct 2025 08:58:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 5/5] hw/ppc: Pass errp to load_image_targphys() and
 report errors
To: Vishal Chourasia <vishalc@linux.ibm.com>
References: <20251022192717.1644251-1-vishalc@linux.ibm.com>
 <20251022192717.1644251-11-vishalc@linux.ibm.com>
Content-Language: en-US
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 hpoussin@reactos.org
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20251022192717.1644251-11-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68faf267 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=q0npivk-H-EHGLgLYL8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8XUxxZXEJnxgpqaRxi72nMEaHpfnOf8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9Bf0tjRXKu1h
 BVCxBw99ZQ9+kkpz2D0GtQgSzblllIvirB3fcEixeiw6S5DiR3eACnLxQJjuRccl1kzx/JTrKbc
 a3j3/0bVC33hSjWaIp1bEpnDZopPvegUvJUbjh2TMR51RlxCVk+vmyMbKtiTgQWhplmCQpmlct9
 709UaJyjwWs3Zi+XNSZ71T9Cpaco0oKn5bkj3eeFra9EN0qIbKg/ljgY1lEp0zYIIsAmpfV/Hxs
 XSW5TNDp1C4+3ew+tlFMd12mCItA5bHHaFD3TpDnVDOrgq/CouAhqCjbJVWnWoUvgrVCslrC9X7
 yfbKWAsvr1ZzUK4PrcLfHiPhHY4q8dBoBi1uug/wBqyCFLlGGKCVCo55aFWt/1A2mDgY9ReH/gE
 UpaNn5bEMntlswiE06lKxijRlD/Y0Q==
X-Proofpoint-ORIG-GUID: WaPwHZkR1WpbhgshxHVbSgXVIXHONRnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 23/10/25 00:57, Vishal Chourasia wrote:

> Pass errp to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
>
> Pass error_fatal which automatically reports detailed error messages and
> exits immediately on failure. Eliminating redundant exit(1) calls, as
> error_fatal handles termination

Nitpick: There's no 'errp' now and we aren't capturing error info in 
caller anymore, can replace that with error_fatal.


The patch looks good to me. Will test.


Thanks,

- Aditya G


> The behavior remains functionally identical, but error messages now
> come directly from the loader function with more context about the
> failure cause.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/ppc/amigaone.c      | 13 ++-----------
>   hw/ppc/e500.c          | 19 +++----------------
>   hw/ppc/mac_newworld.c  | 16 +++-------------
>   hw/ppc/mac_oldworld.c  | 16 +++-------------
>   hw/ppc/pegasos2.c      |  9 ++-------
>   hw/ppc/pnv.c           | 28 +++++-----------------------
>   hw/ppc/ppc440_bamboo.c |  8 +-------
>   hw/ppc/prep.c          | 17 ++++-------------
>   hw/ppc/sam460ex.c      |  7 +------
>   hw/ppc/spapr.c         | 13 ++-----------
>   hw/ppc/virtex_ml507.c  | 10 ++--------
>   11 files changed, 28 insertions(+), 128 deletions(-)

