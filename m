Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69473CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEnt-0000bb-UW; Fri, 24 Oct 2025 06:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vCEns-0000ap-5f; Fri, 24 Oct 2025 06:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vCEnq-0002AP-38; Fri, 24 Oct 2025 06:13:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O30IiL028945;
 Fri, 24 Oct 2025 10:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=da6o11
 MoA24LTIBqSUCd2qh69DTn2+gOmmF/yhYNf+A=; b=gCyT7YdkrOrYhMkMhT9FGP
 8i+z8HL2WY+gvBmm4DlXt4xzCUYZFV+zswADo0xXEWRFTXk7G4MUlaN1NFlpTfkN
 uZJRCTvtlHUxZHv0rVYTiG67ulh0lgbwh+pzs3NEJmiXA8CQCKCHcEYAis+Igomu
 yUprqDmLxC2B64auUuc6D7oIqvZ7cx+RI1xG1YB1bCwDdBXn5qlVURzsuy3xOQ8d
 aLs/UByDF9H0P7Mx+uQZ2d5FzLH//COUB9kUrel+3jfNa0a+o5hnFR/ZOG2TH4il
 VDT1Pd0DbZDrQHAfxhq1l7wjOET6ZeFRxrm5QCANcVvqIgR1I+v6JTd2GPwJhcGQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276s7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:13:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OABDmF003684;
 Fri, 24 Oct 2025 10:13:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276s7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:13:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9u66p002926;
 Fri, 24 Oct 2025 10:13:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejtcam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:13:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OADcmx33227378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 10:13:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09CF258055;
 Fri, 24 Oct 2025 10:13:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C20C65803F;
 Fri, 24 Oct 2025 10:13:35 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 10:13:35 +0000 (GMT)
Message-ID: <40245045-8bed-4afc-8b7f-2b49af089aa6@linux.ibm.com>
Date: Fri, 24 Oct 2025 15:43:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/ppc: Removal of the unusable e200 CPUs
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251024065726.738005-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251024065726.738005-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb5154 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CCyhFsOl0CvqeXcFLfQA:9 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/ieCgXPk9UKZ
 ip9nmgGYa163a9XaP+jbA23etwwCgm2ZbGu/d5qg8ot6x1LCNEhyWWrLhKdUzRoBNnN63hxHOVR
 vYyNvhopfg/zvw1CLElKE0wjT1JFAaQNZiccaXdf8Ne65V0wJOczEWkirg+Hdp2SDjcZZldXsUe
 rY34UGX/ouJIcx5kfaHY0K2QfNQI02porqb5fFct+kl/pB1DaeQ0xVbrfJR9705vwd0oG7gUkjf
 GhKuK7uuwlZNjHfk4rWBVraPmaXkOOy5y2gEJU1SmCsVnxzK8v+WwwVCgj4jrrPcC2Rz+lt4lZX
 EplVu6S1hwpSZHgo5kblAuM2mbg6dyY1kbgY1sI3+t65ewIaDNHGy+hFVJoK2TFS+6bVi9OHQPE
 DKonB7uhE/iaXnsdnuB1ZmW+TNEVVQ==
X-Proofpoint-GUID: oRd5SZDxf2Oc7pdIOx8XtspTq88ef7Y_
X-Proofpoint-ORIG-GUID: GXcasl2GyyR1CZ4syJ-OMohlRMx3mggD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 10/24/25 12:27, Thomas Huth wrote:
> The second patch removes the unused e200 CPUs, see its patch description
> for the rationale.
> 
> Since the removal of the code causes GCC to inline another function,
> this suddenly triggered a false compiler warning, so we have to
> rework the related code first (see the first patch).
> 
> Thomas Huth (2):
>    target/ppc/cpu_init: Simplify the setup of the TLBxCFG SPR registers
>    target/ppc: Remove the unusable e200 CPUs
> 
>   target/ppc/cpu-models.h |   4 -
>   target/ppc/cpu-models.c |   5 --
>   target/ppc/cpu_init.c   | 185 +++-------------------------------------
>   3 files changed, 14 insertions(+), 180 deletions(-)
> 

Queued.

