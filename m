Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5D1F01821
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySsC-0001fn-Fj; Fri, 06 Mar 2026 05:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vySsA-0001fZ-0m; Fri, 06 Mar 2026 05:57:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vySs2-0001JN-SF; Fri, 06 Mar 2026 05:57:33 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6264w76w3265837; Fri, 6 Mar 2026 10:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kjvmYH
 jkM6wPDhHw/R+lHHP4ks5oqVUC94/01kjgBUQ=; b=mPV+UhsSPauBfVDfegU2qO
 0wxG9QNtY0qY5KBtVi5NghiYdOEf7LfvJBFwMplI397zjILqzvzSVTKSlv3Dz+ug
 3O7JNcq+I/tsMhmNdnfzo6bRaJbiQvUCCu1Ib6zzpvqI+VqSPkXJEhxN/BMmaPmG
 O0+lxEOXmfT1M5ntOVvimKv2HYxH53fRqRUUe63oiOtIalTrE+ZWQHC+EzqvrYp9
 oRWGdypEJICcW37sX9N+29T39Xr7U6rLZQ5dwClsGLxVury87qAojdpMgvFa9bEs
 iw8rn9jB3/axAefFmoctR//GfzSUIuqoJRdEEpWX1cpWnUhTqh3WE7/kv7Awx2qw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjg5ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:57:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626APhkR027662;
 Fri, 6 Mar 2026 10:57:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjq7j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:57:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626AvJAu55902480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:57:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8F742004F;
 Fri,  6 Mar 2026 10:57:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C9BB2004E;
 Fri,  6 Mar 2026 10:57:17 +0000 (GMT)
Received: from [9.39.17.151] (unknown [9.39.17.151])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:57:17 +0000 (GMT)
Message-ID: <8496e83a-887c-4d97-8af1-11ae6aee6f96@linux.ibm.com>
Date: Fri, 6 Mar 2026 16:27:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
To: Hari Bathini <hbathini@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
 <20260225124633.1841222-11-adityag@linux.ibm.com>
 <ced81a3c-41d0-404e-a910-43dbe76a1112@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ced81a3c-41d0-404e-a910-43dbe76a1112@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69aab314 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hCOZ8gWSQOPy2C441k8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX4zvad4aaKvdf
 y/jlZzRnBAY051q6Xrx6bESUH+RtvQfOS77OaGzmvl1RrEz/7Wpqgwr1Wajzpebn56FD17hBmSP
 07FP5/SrKb9T5SE3cthlEofq/1g8ChQucpI5rCfO8YBTWr9ju8DjSx1F2BSallGtH6fULUdjeGP
 lnyAhK7bWm4FuT3CPpUpkMMe71xR0gV7vxSa9J51E8okX5Rsz1SLPClxWVS1W/B3nYFyb/Gbjoq
 wVfqwzAytz6UnYHfma2p4gqJ7WjyJpE9FXChf0qzPGyFrQuKFoKTkb1PLkN/82RRX8ehA4zIwUP
 +5X+GRF9Vk+txEiHmfABMVlUOXllCkQWhaMv4JMlFI7vPNBEKiXq0GIaGsUcqok8dcdVF14F2i+
 Cmuc97j4aWqL0RJ470QZMt1Pq0so8Ce+eO4fBsN1hWSk0P+CDHbwc45BfsMzjSBZAQ8lwFDP8LZ
 Nxu2slz80/r3owVd9DA==
X-Proofpoint-GUID: CzokISRWREUGVX_qyrVB6IYOOOm9QGxs
X-Proofpoint-ORIG-GUID: rgY4JB8m6NfCUo4hbaEpIJ6iDvjpItcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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


On 06/03/26 16:24, Hari Bathini wrote:
>
>
> On 25/02/26 6:16 pm, Aditya Gupta wrote:
>> Add maintainer and reviewer for MPIPL subsystem.
>>
>
> Couple of minor nits in patch 2 & 7.
> None the less, for the series...
>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
>
Thanks for the review Hari, will fix the nits in v4.



