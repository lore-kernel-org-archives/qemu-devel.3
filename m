Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC15C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYOp-0004IF-UY; Thu, 13 Aug 2026 12:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYOo-0004I1-O2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:35:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYOn-0003lE-7b
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:35:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWcLR2736699
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=akM+ln
 DQvx5nYcLW+j+m63x43E1V5D4IpzvMtjPoIl0=; b=izj7grGiaiPOowB55tkOMN
 qoF2LXtw9wH6Z6FOVMiqhaIUNWLVMZge2Y2qPvQUJaAfePlE3sYSU7p4bBmyIuo7
 v1ysjonJNybOjpShSBBWY+r1+/rJtiwQpNBYvrKMZPBPgLpI80imM2uX1vZ7nAtz
 AUPKpQU5QfvBOJGt0TLyzAkw9L3Yv8Fy16K4HIClHkyQOofWmKqu+iMIwDWAZWCw
 vAkHae24gsuowaXbMSEV5hxntUySD9xOL1mR2v/omDD5POqb1vYIGCJPWNEwHxKk
 W5HJThb3gyuyCyxa3iAk+PGfVfJJ1cflhlrEqFlQ2qOSg5sqTXvanZIeXmVAEQgg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma0yps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGQMG5010553
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gkmyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DGZGpL27918664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF50120043
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1856B20040
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:16 +0000 (GMT)
Received: from [9.43.103.247] (unknown [9.43.103.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:35:15 +0000 (GMT)
Message-ID: <e89bb6d3-3522-493c-8bac-106e374294c3@linux.ibm.com>
Date: Thu, 13 Aug 2026 22:05:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] ppc/spapr: Add VFIO EEH error injection backend
To: qemu-devel@nongnu.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520095446.64206-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfXxKr4wAWrr4nb
 AbKoiIa8SZRriIENoSejKlRd1sCcwLgTii16QpzBJCNgI3uBBg+G3CwNtGon1RUR3ZQ+fA2mnH9
 eXkd7POJ2/3RttCJyrrJDfoOddCoETbiq+FxPItWWMXjgaTnwZDtS5FUVd6M5GxqxLMlwAMh3cH
 2tw8/ZqfR1IqPQUeWTfqO0eVWgFqm4BNMNEXgwMpQ8C/Kj5Ooi//p6fXIrJK0+eBRjKkvdvAWvE
 K8CP+bx8M7TjCuQ4sehxMz7BkBvbgCkcOZn9RVAusLJ1F1tmHaKi4aYmDnS9R14q+fuX5rWl46P
 Oq01JhmZIstpVBYa3p7bdXOgGNb/DzabW1DuqrOu0sP1PKnIzO0+N6+BUdQCGqNjj7boMlYXjII
 39ULZwwhQVmuUSqJOowQoN8KsjqyaFuNPMujBNavaWr10bgPdHQ/BoyZbUP/t/Oa4SLfGRpH0Ac
 NIu5hH8fkSWlIKf6TUQ==
X-Proofpoint-ORIG-GUID: MXQ-ZsRiRP3WYtxmaHn7P26rK6m4wXw_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfX0c7p2pw/XLjq
 f/DTBWhHhq7fge6QV/jsE2zpxfOK+TNzrsdBWT5tA/MlF568XRwR3vxgU28VN3rezSQfRQ7YSCs
 7vyQAjCikpum6gv2nFkavPaEqoE7Idk=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7df247 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KqBAmHc-NpPwGoBe6oUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MXQ-ZsRiRP3WYtxmaHn7P26rK6m4wXw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 20/05/26 15:24, Narayana Murty N wrote:
> +    VFIOLegacyContainer *container = vfio_eeh_as_container(&sphb->iommu_as);
> +    struct vfio_eeh_pe_op op = {
> +        .op = VFIO_EEH_PE_INJECT_ERR,
> +        .argsz = sizeof(op),
> +    };
> +
[...]
> +    /* Perform the ioctl to inject the error */
> +    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
> +        return RTAS_OUT_HW_ERROR;
> +    }

Hi Narayana,

Sorry, one detail I missed in my previous review:

Could `container` be NULL here if `vfio_eeh_as_container()` fails or 
returns NULL? If so, should we add a NULL check before dereferencing 
`container->fd`?

Thanks,
Nikhil

