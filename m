Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D9ECCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtIx-0000AK-TL; Thu, 23 Oct 2025 07:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtIv-00009f-VH; Thu, 23 Oct 2025 07:16:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtIu-0005pn-1X; Thu, 23 Oct 2025 07:16:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6OIJT007627;
 Thu, 23 Oct 2025 11:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=uriAptiPnAV5azmsiTza/YWyV0fIO3
 fdNsWIaJYIKzQ=; b=QQo95W1lLv9tg8Jxjjh04d7kchi//vVzmETfX5Jr1s431t
 V2otnYoG3XDGMyg9g+ya0TTlHEWyiVdOUU3Q8UPL685nABkq7WKiGstAK2AbRyNY
 BX7q1IZL1ugRVWT1Kt0sQSNjCGGQsjLpwpGApVRyePln+p0un6pGExsyEEnSl+At
 dQZqIDEg7uAUHLvB5WOtlG8aedp9kKy3VsNkx1udfNCK8oZE2Fe6inhGhtHuDkhM
 vY/jE0GJWsnTqPD8JH04IUebjqG+IWOu0Kd1NHkcsjdSWPhQLl2HEw5LAMC192Kz
 JWsnuS5MUby62vqJvW7LaDi6Yt0fH0alHk5smKqw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271t98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NAvVdV008011;
 Thu, 23 Oct 2025 11:16:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271t95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA9loj032249;
 Thu, 23 Oct 2025 11:16:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n5bwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBGFQQ28180790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:16:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1306720040;
 Thu, 23 Oct 2025 11:16:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9505B20043;
 Thu, 23 Oct 2025 11:16:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.253])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 11:16:01 +0000 (GMT)
Date: Thu, 23 Oct 2025 16:45:57 +0530
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
Subject: Re: [PATCH v5 4/8] hw/ppc: Implement saving CPU state in Fadump
Message-ID: <zn4pygbr5jqzvxy5hindbqaiejhixwqashs23zf2lfxnrs7xyd@7f6jj2dgagzh>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-5-adityag@linux.ibm.com>
 <4f0ddce6-c738-4d5b-8dc6-d997dd89289f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0ddce6-c738-4d5b-8dc6-d997dd89289f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa0e84 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UPML_UvK1ebSDbTHbhEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1lZL+tkE37GU
 T8RleymSbej5TwThRSU/rN0mHe/FipvdvwX4SB7WKynw+NrxbTSajBUOFL0YtWAdUelza3UCXgA
 UCU3tVsskTd3Algi8Lu81shWjGIzf8iurGh0bu8BRbry0Nj6YlFgk1it9E/eeAFDF4m6P2FKyub
 RBUpUT25ZYTbg6Rx1pXyr4Hubt2G+RIkEyPckEIUZgvJZ23p1TvKCcMPMtCCfLUk3vpEXCw0IZF
 xusIqP7qjYRIpZpTSiUXxtSUCeFf0xzZsoFtHQv03UrmXXFk8k571FTPCtKEvN5BRoFgj1PHQOX
 1ZaveAMprpKZlue/Jv0C6aHj7sErSX5+KkQ9WClsZQY6Rp8/0usWijt+1Psa2e1shfqpdWeqwVf
 UymjR+2lSpbNQs7fwIs4c+HpeVaKBQ==
X-Proofpoint-GUID: ebCqPRRgM3c3qFhIjDqUEpSl9IzRNm4O
X-Proofpoint-ORIG-GUID: wjfb7I6wafdVFHHUvgjf9XvaDFzgGssN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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

On 25/10/23 02:35PM, Sourabh Jain wrote:
> 
> 
> > <...snip...>
> > +    curr_reg_entry->reg_id =
> > +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> > +    curr_reg_entry->reg_value = cpu_to_be64(
> > +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
> 
> Seems like converting full 64 bit CPU ID to 64 bit BE value will not bring
> reg
> entry in below format. Isn't it?
> 
> 8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical CPU ID
> (BE)
> 
> 
> 
> > <...snip...>
> > +    /* End the registers for this CPU with "CPUEND" reg entry */
> > +    curr_reg_entry->reg_id =
> > +        cpu_to_be64(fadump_str_to_u64("CPUEND"));
> > +    curr_reg_entry->reg_value = cpu_to_be64(
> > +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
> 
> Same here.

Yes, it follows the format since even though we use 8 bytes, but
swapping the 8 bytes at a time, brings the lower 4 bytes of 'vcpu_id'
to the higher 4 bytes after a 8 byte swap, which is where the CPU ID
should be according to the format.

It is also consistent with how the Linux kernel reads this field:

		cpu = (be64_to_cpu(reg_entry->reg_value) &
		       RTAS_FADUMP_CPU_ID_MASK);

Thanks,
- Aditya G


