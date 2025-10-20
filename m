Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E07CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAihT-0003Fb-0o; Mon, 20 Oct 2025 01:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAihI-0003Eh-8V; Mon, 20 Oct 2025 01:44:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAihF-0007tg-Lw; Mon, 20 Oct 2025 01:44:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JKibP0029261;
 Mon, 20 Oct 2025 05:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=chmjDV
 LMYFgUxZLDpt1C2oSMUrUSxCTzE2t2+SWoH/g=; b=boBNLtWzRNlaz0p4z7r1RL
 +E7WfbqOt1Ov6eAQQyEgk7qyiK+Q8qlr1w7zYn0XNRYOT3zwP7AIAe2NXmfj9QfX
 qBbC3N6MpIcdp4ekpcWAWgU3RZ6WOrseUjBpJEeb7gCGvk++X+IIhan4JjAfZmLC
 MyHnm66y9tx7A984JpPL64Nr04yS+m3YVK+61mHRWRFygPkio4DFcRDPZ4csx6dI
 ylbAX+PdQHpV3nEz+5BTpB2szRX8+6MCCG/0QcUz60YY9T1YUxjn6zZrp/gJk8RO
 LEghBqpqDKp98eNQKkz/0ByRpjkbjQ8Kf82MXqElCt0dzZoHyqgxdaOmAtZggXxw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33eyu67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:44:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59K5eokP003144;
 Mon, 20 Oct 2025 05:44:38 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33eyu66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:44:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K2jbKd011053;
 Mon, 20 Oct 2025 05:44:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx0v01y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:44:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59K5iYEG20971842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 05:44:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EB4C20043;
 Mon, 20 Oct 2025 05:44:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67B7320040;
 Mon, 20 Oct 2025 05:44:32 +0000 (GMT)
Received: from [9.124.220.242] (unknown [9.124.220.242])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 05:44:32 +0000 (GMT)
Message-ID: <c79ac8e0-9d87-4c39-89b0-5e6a9981eedd@linux.ibm.com>
Date: Mon, 20 Oct 2025 11:14:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hw/ppc: Pass dump-sizes property for fadump in
 device tree
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-7-adityag@linux.ibm.com>
 <65b70282-c6ca-4140-92f6-d266082b6d49@linux.ibm.com>
 <wr5sfi6omicfuxnfua7pjkbm345niursrgrddfdkbzcexeqoap@xyqknkyfqmif>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <wr5sfi6omicfuxnfua7pjkbm345niursrgrddfdkbzcexeqoap@xyqknkyfqmif>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f5cc47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7osF5HoJbqPopLT3g4MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mPL2Q2udU_canFF21iPuQ6jEnrgo5EHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9eYJjYtTO/gy
 bEhuDb132hByyhiBJeFj2brgiJ6a7xFqqERZH6XVYrpplPfLc8K8WuEdNOLpyERHLjQ3hHTpy/D
 MoAqRfU0liPRszMqdpVlazYIRNBWLAV7/FIuYtRcI8M3MB1cd7gsooMgKE8rlO/2e7d9Ajzad0P
 kBWnab2z21zFNfOTdIN2B5XsBxFLXiv00d8O/HlXAoBwT6YVqfJTSL2Pp7CdJUiwPVP4BGGYFQc
 rZxdr/8EL1hEqKpRLFsQHlQWe5a3Cl2s21gS3+QfNBL9cRUzRtGzE3aKUpu48oFSnjyUBeyL29X
 caQaV43Ir6ydM2vJ6bV2ea8S6lOfnF+27Y3GhITk/PVpe4JKt66cemdQ38CD/TSaw8yxRbq1j4v
 SKTGGK8tj8yQhrVym3/Cfa9KeKIJTw==
X-Proofpoint-ORIG-GUID: rFEckr8sdUlp7Cw1jn-pFzvt0BsP1LYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 20/10/25 01:00, Aditya Gupta wrote:
> On 25/10/18 04:50PM, Sourabh Jain wrote:
>>
>>> <...snip...>
>>> +    uint32_t fadump_rgn_sizes[2][3] = {
>>> +        {
>>> +            cpu_to_be32(FADUMP_CPU_STATE_DATA),
>>> +            0, 0 /* Calculated later */
>>> +        },
>>> +        {
>>> +            cpu_to_be32(FADUMP_HPTE_REGION),
>>> +            0, 0 /* HPTE region not implemented */
>>> +        }
>> #nit-pick
>> Why to advertise if we don't support it? Kernel anyways ignores this for
>> now.
> Nice catch.
> PAPR doesn't seem to say about HPTE being optional anywhere, nor being
> mandatory, so to be on safe side, exported it with 0 size until/if
> it's implemented.
>
> PAPR R1–7.3.30–7 says this (trimmed, emphasis mine):
>
> 	The platform 'must' present the RTAS property,
> 	“ibm,configure-kernel-dump-sizes” in the OF device tree, which
> 	describes space required for 'firmware defined dump sections', where
> 	the 'firmware defined dump sections' are:
> 		0x0001 = CPU State Data
> 		0x0002 = Hardware Page Table for Real Mode Region
Yeah lets advertise HPTE with zero size.

- Sourabh

