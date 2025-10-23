Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B24CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzsI-0000Fc-NI; Thu, 23 Oct 2025 14:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBzsH-0000F2-9u; Thu, 23 Oct 2025 14:17:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBzsE-00067h-4L; Thu, 23 Oct 2025 14:17:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEa9FC007314;
 Thu, 23 Oct 2025 18:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3mNAjo
 87fFC0wbdSkILtgImV7tnvDwxs17dZ82mQq0M=; b=jLO7cMFZhVOKLDYNBQJzmr
 Z7YoATN6x6KeiXVFA1uls+Fn6bAtQi9tNENM1vrCCdta4sQyfWtLpOq+qGmXAsql
 TdqAWpdhDK4voX6yevrFTFCW8YVBSYzZGLMA18eLRgUUQGbK7YF3Hn/fFmEeDrfF
 SAjVn7q1cYjm0HPKj7POFBvolasKCB1sG/oI8mRvig1I02gKevmgHH3aWC9nU3pE
 1b/0a+3NB9bmiBD/TzMg7APVHdNby9n0YHU03TbAM7gku0xxpm+qDoB78I67XwJK
 DyiPr/z/CkUXYxk+aRzye8IxtRrO8Lr9rlmdF6nZyM2hVQyjRp9Psj7/KS5jnWUg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fkt68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 18:17:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NGQkge014779;
 Thu, 23 Oct 2025 18:16:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sfdwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 18:16:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NIGssk61276502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 18:16:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 926E558062;
 Thu, 23 Oct 2025 18:16:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A6D95805D;
 Thu, 23 Oct 2025 18:16:54 +0000 (GMT)
Received: from [9.61.246.20] (unknown [9.61.246.20])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 18:16:53 +0000 (GMT)
Message-ID: <71399c58-fc33-4d33-9410-db3cbb8f9432@linux.ibm.com>
Date: Thu, 23 Oct 2025 11:16:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-6-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251020162023.3649165-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa712b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=Vc6ARtGatunV12CEZOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l_DDY8NXwFTyoHIw4pJeAdmbYwkMgVQZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXy+f+4uLPq1lo
 5YR00bQ5CViZKVyeqWWONNmOKXcaC6aCpzoFC3XvDYBnqKYMqG5swjeWpzN+qkpyEYbOvympfjh
 Fw+6iwQFXtJ3Gjjj+fyzBRWeqoIPK81zctB5Hbt3xu52aj2twJPrxkYSexj7n1eSl600+2r5oh8
 ZbPz3KeA9eTkl2M/LaByIwqIU7X+sCa50wxuOP5PcexhVxpb30z4kmBKR+aH0THfi4aDc89MoxK
 oGeuGkQkkHtjTh4C7ItoOVlCzMk7rF4FmA1MAyFl0CAkQWqusOwvkc5XiE9IkU1Uq7wdRBN9tEJ
 eTpEvU3qZjnqQAzf+BWJAoJCwl4+duDNXki/vPh6xzAKftVkJA7QKkQjzuRST9AOLXqDjw9UfrB
 zrZ2nhoIuIeL2w5U+wbxVIio/P7xiQ==
X-Proofpoint-ORIG-GUID: l_DDY8NXwFTyoHIw4pJeAdmbYwkMgVQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 10/20/2025 9:20 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> Enable virt-queue PCI configuration and add routines for virtio-blk-pci devices.
>
> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
> ---

Just a general observation in this patch, the BAR we are reading and 
writing to is BAR 4 for the virtio device. I think QEMU defines all the 
structure in BAR 4 
(https://github.com/qemu/qemu/blob/88f72048d2f5835a1b9eaba690c7861393aef283/hw/virtio/virtio-pci.c#L2169). 
But after looking through the virtio spec, I couldn't tell if BAR 4 is 
hardcoded in the spec and should be used by default. So maybe we should 
try to read the BAR number from what the device provides to be more spec 
compliant? If we think that its okay to just use BAR 4 for now, then we 
should at least have a #define for it (also for magic number 15 which is 
a zpci address space number for PCI config space).

Thanks

Farhan



