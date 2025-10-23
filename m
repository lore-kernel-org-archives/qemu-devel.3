Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B09CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuUq-00060j-3z; Thu, 23 Oct 2025 08:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuLt-0000H1-OP; Thu, 23 Oct 2025 08:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuLp-0007Fk-Nq; Thu, 23 Oct 2025 08:23:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N861Dh007748;
 Thu, 23 Oct 2025 12:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Bzo9dZ
 jLQLLcoi2IlFwNt306xbaKzuykW4guLjxN52k=; b=jF7e/arYpfJVJI5qmVVtEj
 d6ecZqmccSNPUy07ApwcSstuYVHopQFXxDh9bu4fYtng0zHs85TfI/4p6NRNG/x8
 BH8TN2vY/twG25u6+kqPuBhKZrfW1G+UIXsBstKHmL068StUnQsy8UhC92FQaSxR
 y4Sq1bWym8D737foqsCH5QaSnNV75GLJXdrkEPQKWIcKcneANdzUWU+rftTI8qbB
 ZK2lDRu/uxXvbNOwmlgoNiw5w26EC4Pi8xRiZvp6wRyJStoUQJsm4secXBjTmg+L
 B9fLLWBnPgckuudwRvq8/VqklZS8JyqrjCFwRTI7gfkRExzzM/4HMG3Cs77I+IGw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v327229x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:23:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NCCI0r026104;
 Thu, 23 Oct 2025 12:23:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v327229s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:23:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAhEfZ002320;
 Thu, 23 Oct 2025 12:23:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejnev3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:23:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCNNuP14746156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:23:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0AC35805D;
 Thu, 23 Oct 2025 12:23:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08BE358058;
 Thu, 23 Oct 2025 12:23:22 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:23:21 +0000 (GMT)
Message-ID: <610d1821-71a7-4bfd-b588-3baea0bfff95@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:53:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <764df5c7-55d3-48ec-a28b-0c837e13c595@linux.ibm.com>
 <671f7ace-fe86-5443-40b7-d02dd16b922b@eik.bme.hu>
 <f4473b0d-f25e-bc05-a1e6-e5e2971a6688@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <f4473b0d-f25e-bc05-a1e6-e5e2971a6688@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1e3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=4QgSZ3G415G0bw6G-nUA:9 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzL6JCnEILeXW
 nJWVV+gK14NbQw98VTP4Pu6/Q7jbmN6QNYi1iTEqowYEdMcNIYTibl3sK1WeS3NpR7fnonehrJz
 JDU7I/CVITBBN8TjumQCo8DR1c6E37rVOAhw5WYM+Q2NiEP8wBVRhTc3pR+6cL6y2Uus00vOBlV
 F9hWVmSXIvoSTTkPCNRFHx2PVBJxh0aoFMt580Gi7PujQJtf4BCp9KgpryeMuVcmM65lOKEbDsf
 kJlV0MvZUfOoxsopha8RUuCpOo911DVpn+yiTJzQP2Gd2YwvcP5ElcGnc1Ka3I7aX5G2JjcDeks
 lR7/ajVhRAvtik+lztoKB/RawUNSSjrhDucDHRQpGFQvpdBVkZi3o3KpEzcboVxEp8JsYs0Rq/l
 NBoklNSOWcbc5bqObu4fgCOCIK6Kmg==
X-Proofpoint-GUID: wQJkt20ZeETKNF0FIYlW20vMGm9zZS6v
X-Proofpoint-ORIG-GUID: ScQhnxZPZxheISmpkHrLhjbsm_iiYLBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
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



On 10/23/25 17:45, BALATON Zoltan wrote:
> On Thu, 23 Oct 2025, BALATON Zoltan wrote:
>> On Thu, 23 Oct 2025, Harsh Prateek Bora wrote:
>>> On 10/23/25 05:36, BALATON Zoltan wrote:
>>>> This series changes how the fdt for VOF is generated in pegasos2 by
>>>> moving the static parts to a dtb and only generate the changing parts
>>>> such as memory size and PCI devices programmatically. This simplifies
>>>> the code and allows simply adding emulation of Pegasos I which has a
>>>> different north bridge and slightly different memory map but otherwise
>>>> very similar and can be emulated by reusing parts from the amigaone
>>>> machine. The machine was tested with a Pegasos I ROM image and MorphOS.
>>>>
>>>> The first VOF patch (submitted separetely before, the reviewed v3 is
>>>> included here) fixes handling the name property in VOF that cannot be
>>>> represented in a dts as that always takes the path as the name and
>>>> cannot accept an explicit name property but we need the name property
>>>> to appear when guest queries properties which previously was worked
>>>> around by adding it to every node.
>>>>
>>>> Regards,
>>>> BALATON Zoltan
>>>
>>> Queued.
>>
>> OK. In that case I can do follow up if needed but I still plan to send 
>> updated raven series and if time allows updated firmware for sam460ex 
>> but the latter is unsure if I can finish before the freeze.
> 
> Or if you haven't sent the pull request yet (I was confused by getting 
> cc-d on a pull that did not go to the list, maybe was only for testing) 
> then I can still update this series too. I see there was some problem 
> with another patch from Thomas so there will be another version of that 
> too. So the plan is to update raven series, after that update this one 
> to address Philippe's comments then if there's still time I see if I can 
> do the sam460ex U-Boot update but you don't have to wait for that last one.

Sure. no issues.
I have included these patches in the pull request I sent today and am
planning another pull request before soft/hard freeze, so we can include
remaining patches that gets reviewed in that. Thanks.

regards,
Harsh

> 
> Regards,
> BALATON Zoltan

