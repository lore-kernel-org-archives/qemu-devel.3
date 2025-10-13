Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC1CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8FdZ-0003Mw-6q; Mon, 13 Oct 2025 06:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v8FdX-0003Md-DY; Mon, 13 Oct 2025 06:18:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v8FdU-0004Dy-Ny; Mon, 13 Oct 2025 06:18:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CLGEd3009098;
 Mon, 13 Oct 2025 10:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iqtg2O
 xCRrc+RKm/ff9rzzeCiM3GtQKtsOtjesa58SU=; b=cAH0xBlH+ZpNFJB23+9j1l
 1TBqCtQUhwcvVlRtXDrGlvV2U6Jl1vLrmjuPssdXG7gQne1ZA+iCO7fGmujZGcbd
 DTZo9Y68664ZnKFlsTW1T7ARq4kBDJq1qq8jkwszfPPrF2buul0rB51FhWOHyTm8
 sb5mM6A9QYsf5tTRz1RwjcG4fP3yjhDFeEneBO8Vmhrp7gJ9Nmi9u3SWK3+X+D8b
 EQ3r6n5b/YNqpt16V6+N0PuzhcHxHrXqL3dw35gDSBo+7gx2Y+qcKwRqGq90oguA
 +9wgeNli03S97pMzLhtSi2SiIlO+egImkTL1N9zBzHHci4L79c6os0SJjeHEJzfA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtraee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:18:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DAFjdB026939;
 Mon, 13 Oct 2025 10:18:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtrae9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:18:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAHP27017008;
 Mon, 13 Oct 2025 10:18:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jn768-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:18:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DAINc662915032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 10:18:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC8DD2019E;
 Mon, 13 Oct 2025 10:18:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B990B20199;
 Mon, 13 Oct 2025 10:18:21 +0000 (GMT)
Received: from [9.124.216.147] (unknown [9.124.216.147])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 10:18:21 +0000 (GMT)
Message-ID: <5f414f58-f687-46c5-bcaa-32339ea9311e@linux.ibm.com>
Date: Mon, 13 Oct 2025 15:48:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
To: Peter Maydell <peter.maydell@linaro.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Cc: npiggin@gmail.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
 <aOyj5p2xzoxCyYZC@linux.ibm.com>
 <CAFEAcA8zGH1sHL45WU=E2p4p0EizuOs3QRaniHW7ES-CQDPajg@mail.gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <CAFEAcA8zGH1sHL45WU=E2p4p0EizuOs3QRaniHW7ES-CQDPajg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nu-r5run7LbK2UpEUgaPXvibFrhLBjpE
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ecd1f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=07WxnQuDVi7JMVqgBJUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KehpuL2CdDWaKQziwlbb64k4xXnfRkSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX65GBScMKwphO
 6C4KBq45jPoreyG0yuKntPmmxzVYfWTby/NUhwf2SIHYBALNGf8QYuwYXiYsTPTgHw+qqzFU/Xc
 bq4ueP23qrURK/R0+MD8L0d7eGAKrMYTZ9jInK0VeFyxd3ejCpE9BGuaYjEfr4PWJHZyWqot+0S
 L8rzMafq/ZabMDvs0GOHx0EquJ0Hp9MvJ7g6J3hVvBN9aM729mUgX+4v/gM7TcvKdQQj9SOcRFu
 4x91ik2y4m41HxNwvvECJzJkuXYZQASS6OTszwmqyw2YKwseJ7sd5LO3hsO6D6Lc4VPHFUl43E8
 vSQefe1w6WkJwelksxA4eG6R3JSM2fUf0bPwZgIWIfcCd1aaVO/WfF2E4T9pORgUBGWcuaM7sxt
 nQal2qpii21K6xKQyNRHT7KmnRvtpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/10/25 14:05, Peter Maydell wrote:

> On Mon, 13 Oct 2025 at 08:02, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>> On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
>>> On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>> <...snip...>
>>>
>>> Rather than printing a list of reasons why the load might
>>> have failed, I think it would be better if we enhanced
>>> the error handling in load_image_targphys() and friends
>>> (i.e. use Error), so that these functions can report back
>>> to the caller exactly why they failed and then the caller
>>> can give that error message to the user. That way we can
>>> improve the error reporting for every board that uses
>>> these load functions.
>> Hello Peter,
>>
>> Wouldn't it be better to print the error inside the function itself.
> No, because some users of this family of load functions
> use a sequence of calls to handle different possible
> formats. We don't want the function to load file format A
> to print any errors if we're then going to continue and
> successfully load the file as format B.
>
> More generally, our usual coding practice for functions
> is that they use Error to tell the caller what went wrong,
> and it's the caller that then gets to decide whether they
> want to print an error and exit, tell the monitor about
> an error, or just continue to try something else instead.

In that case, maybe we can have 'load_image_targphys' take an 'enum 
LoadError*' ? Caller can pass that argument if interesting in handling 
errors.

Though i see 71 instances of this function, will have to modify all call 
sites (probably by passing NULL as error* which will be same as previous 
usage).

What do you say ?

Thanks,

- Aditya G

>
> -- PMM

