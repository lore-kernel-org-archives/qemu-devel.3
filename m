Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F448CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtAA-0006TR-1U; Thu, 23 Oct 2025 07:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtA8-0006TB-HO; Thu, 23 Oct 2025 07:07:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtA5-0003yq-Gn; Thu, 23 Oct 2025 07:07:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3p0Je032408;
 Thu, 23 Oct 2025 11:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=B1+jXYyWjVh2I157WLFtX1tIPb6TQR
 iOiup2J8vZ5W8=; b=cbnvSPRydyow/ZBByom/S3Njjxwb7s8N362H3ryvG2PM9B
 K6oAISLmVQChNNidXtAuCC1Hqb5bfbdHo4ZHPiejYEZ/suJeHVxUp5x5d6+d+RJ2
 XNuWA+q+52BF/bZqh91+RU5moPQV34683s7qAO9rCxkD9e8+MO6mQCkp+glxhEZL
 m+y9O6gL6K3UdddcYDRGTDAr+qvDGmWdM5jycrjgLWwV5f2SVw57KwWDwh7xNqcf
 dcPtslArcI/CB806306MsQX+zzspkZ3SiGwe0RpD7b99NulWpu0aHc2VKk4psx/T
 3v8tRiZFZG5Qrq8ifRPcrmlUG3lscGgOca9X5hiw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgdvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:07:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NB483l016128;
 Thu, 23 Oct 2025 11:07:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgdve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:07:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9VslD014669;
 Thu, 23 Oct 2025 11:07:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdjqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:07:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NB79Sx25362916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:07:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF1D520043;
 Thu, 23 Oct 2025 11:07:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E471620040;
 Thu, 23 Oct 2025 11:07:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.253])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 11:07:02 +0000 (GMT)
Date: Thu, 23 Oct 2025 16:36:58 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 1/8] hw/ppc: Implement fadump register command
Message-ID: <xb37gpoxw7hwf7clxsry4tzb77rbbeys5becr6x3wjzkxkva7f@vtu3d2xpftzw>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-2-adityag@linux.ibm.com>
 <6a198b3f-b9c1-4226-8e35-c853baf178b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a198b3f-b9c1-4226-8e35-c853baf178b4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gPfAkXVOY9mtrFHz1To-6uoOHphiloog
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1yJiN81VYGMb
 SKfxntVcNM6wEtFOLSdmYpE0d0y/YJiZ3gORkYHzGWpscu2ojjaSeRquSZkvijQJVI+OuQ6yPEE
 I028umFo1OA1XowqOODTUjME8ALAWrs17WmoyDK5rU2xh8/9/v1IsVQ/hUAIVascYyNr7h7NH+c
 EjHRLs1q1eouPTnAUuFyto82RS46o9RErk9K1a3ahtQfCon+MjQW0lq9nbaOlr5Pf2EwWkSHOYb
 2GZ9BaunaAYKxbbkVnmjJWcHBEjE+1M2YvgtjtsB2SmoT+KeiPRwM/AdyyYEN8GdMOqCmgB9MWb
 Co00qDNk3td/Rv0FQx3MOkZcYHFaqfZpKVgudf8/q7qYghnV1EisZxiJdH9iXlnxTzmoI/4caKd
 Lo5DLQnG8g+xEi15HsXiPvkOCgq12A==
X-Proofpoint-GUID: YxlMW1miP60vHvuP7oXyk6LqWG1DHKbf
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa0c63 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iQ3NubbHQ8z_GTrxu3kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 25/10/23 01:46PM, Sourabh Jain wrote:
> 
> 
> > <...snip...>
> > +/*
> > + * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> > + *
> > + * Note: Any changes made by the kernel to the fadump memory struct won't
> > + * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
> > + * as we store the passed fadump memory structure passed during fadump
> > + * registration.
> 
> Seems like you forgot to update the above comment.

Yeah, missed to reword here. Reworded in the description.

> 
> Rest all look good to me.
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for the tag Sourabh !

- Aditya G


