Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E44CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 03:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC8Lz-00073W-RL; Thu, 23 Oct 2025 23:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vC8Lx-00072z-9Y; Thu, 23 Oct 2025 23:20:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vC8Lv-0005Sz-Ed; Thu, 23 Oct 2025 23:20:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NHGcMU009507;
 Fri, 24 Oct 2025 03:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E3Uylb
 dQZzgk3xu7QuXsgwtg6zerAAQoxu2KBY9T3dY=; b=F69ySHZW2axQno6ePTZnyb
 7fL2PZNC4JhvRx5QtlOz3ibY2LbYmQcbJegHe/G4+iHv3ZsHNcIO4423OPJF83Dx
 eaPl9CQ0DebtSH7wNaZmaIfLBDq49w5niYv1v3SAXmPNfGVFC+yIXsEAojhaILjM
 nHP1VOoESJ+rB1IQErnXqPFXHCy9dO4WtvmTecE9FNcVq59CeLBX/z51TTuHs1MC
 In+Rn8RCkxD5NWJC0+m1eyMCOLOtrF7IbOQ+qDZGPLvSuiKOp787crn2JU7lG8vA
 Z/jbPwZsNGQ7IndwsjzDURMKczUHGR6BvQLf/Hpo1futJEBEKqmNgi7greJIFADw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3275cxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:20:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O3I5Xd005686;
 Fri, 24 Oct 2025 03:20:04 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3275cxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:20:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NNPRTr014650;
 Fri, 24 Oct 2025 03:20:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7shcg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 03:20:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O3Jxxd62915068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 03:19:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A06820043;
 Fri, 24 Oct 2025 03:19:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C57320040;
 Fri, 24 Oct 2025 03:19:54 +0000 (GMT)
Received: from [9.39.26.73] (unknown [9.39.26.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 03:19:53 +0000 (GMT)
Message-ID: <8affcf68-8782-4cb8-8923-1f625d599091@linux.ibm.com>
Date: Fri, 24 Oct 2025 08:49:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 2/5] hw/core/loader: capture Error from
 load_image_targphys
To: Vishal Chourasia <vishalc@linux.ibm.com>
References: <20251022192717.1644251-1-vishalc@linux.ibm.com>
 <20251022192717.1644251-5-vishalc@linux.ibm.com>
Content-Language: en-US
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20251022192717.1644251-5-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68faf065 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=6Tfyqbp0RZxg3S9JSXoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6TG9WX4Jjlhb
 KFTxzuNpjsTvGO0Wjs6UklLQD6LhyFWDDNLls+E6IvWwOnP0IfjAIWfFUYx6ILra6D6CztsxOcz
 xpJrJEeF5eo9fN2gHjA+gqDBsaAZCH9mrnEsXls4+gTPRKFQLHuDu2Uax+oUrjKpv2bzGnaCfKZ
 ACYVRJt5LtbVuVfZsFaxeaE0d6yRLAWEnhnzjG5netJYEiSDW3tTnp7EpFf4RjzFvsdJGY/X+AI
 wIrtzzRbQTNCrJcAiEyd7rIU57v36F/Q9OSkeHp93Wd09CrKpSyf3WVtHblO7X3no0PclKGHiio
 VHzwenDTSEsIAvTWfdRfdn7dnCNvCmZOPCBJhJA4z9v98agK5vi/JDmfYi7yjQ+7GL/rVrC13Zt
 ITLl20YG6W6k8AD3AKpHoIGvkqSLVQ==
X-Proofpoint-GUID: xD-nj0K6x6CvlVy6OLt4aDUYfIzOEMsz
X-Proofpoint-ORIG-GUID: 1KSM_Uzud7wlwmZT-QyUV_HDQGnNf2zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
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

> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
>
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

The series might need a rebase again This patch fails to apply on 
current upstream.


Thanks,

- Aditya G



