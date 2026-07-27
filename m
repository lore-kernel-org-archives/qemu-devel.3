Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28608C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKHK-0007kH-MJ; Mon, 27 Jul 2026 08:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woKH3-0007jM-Sj; Mon, 27 Jul 2026 08:17:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woKH2-000814-BO; Mon, 27 Jul 2026 08:17:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIkKR1838150; Mon, 27 Jul 2026 12:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ARx8t+
 lGncNBP6jtiC7Oo0eDEvW3qcnajzZcS03Pwsg=; b=Hv8rqZaGrFqjBvJUDD6l3L
 nnJHj1r2HaLprvdokpRzL/e2eFx9/7CXBDZNh/e34H+0xT33UcQQPBSdgiWi6DPm
 46jsWViOPREn6rvcknAfBP5CyU90CAj/7S14+nsCeXu7hkI4WgDgnzMwrirLH2J5
 PZIfaYyDsubN/unCdOIpgkzyL6B3JP2Y4VhLLU55Fnu+KxRxC1NQm6g8t19iEn7x
 mABC2xQMN8XHnODtM9zGpOrpZ11qkVMwK9QlZVf/hzKql6vwUlQ29RNmvbh+c2Kd
 VocYf4xm8ob6l3FJXATa+u3bFZujFG4dO/rvpAVckqDGsrSYtf/J/CA/rld8FTOw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nfg3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 12:17:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RCBIN8010157;
 Mon, 27 Jul 2026 12:17:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xw1jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 12:17:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RCHRDo46596546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 12:17:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F4DD200C3;
 Mon, 27 Jul 2026 12:17:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E648B200C2;
 Mon, 27 Jul 2026 12:17:26 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 12:17:26 +0000 (GMT)
Message-ID: <49089127-7189-4bdc-bbf9-5a3ecdc99659@linux.ibm.com>
Date: Mon, 27 Jul 2026 14:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] more hardening fixes for s390
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <87ldawsk8a.fsf@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <87ldawsk8a.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXy+RS4D5gmX03
 0zUQlnOOZ8janU2BACaDk275zWcyqNxTEbMObqBEe7c8mQwwoidTaOiMJoTMiU/Ivn8WAfUtIhX
 9WmMBMMg7tstwHk2k87GSqqHadkxp+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX+kjaEOGHoTNw
 2fVRLYE7mXqt+LnmFydfyyEtrqyAxty/rfYLy0+vr3azAREGmx2PTaAqQh0+vyfZC6iABzxyQNM
 0ALYaFEeJTylO1/pxXuBA2s5xVG88gnr85jJXCbpF6P9r7c8Chd3ivBATrr8G6aiQUxrl4Up/uT
 zC9YEy64AVmP04RHDnOmFIMxuVaSM8WwedhLgah1cR0UYmjWcv6s9Y4TNeh3mokhYtSJxwIX1cK
 v6Dj9Qm6UjbNhoDpqlqJM4MQakqkTFKnqrysqkUnIxIacqvqiD8ow/RiZthd/WIFC3D84xodRvM
 TGH1ZaSlqz4BjhFXuN270CXwWW7h/PkY52lpM2eRctQeC6Cp+WKrqrdrk3JKo7yKzQfjT9HQcFa
 LMsGHQqMagEOzC8CaEJ9pBSIq00YQcyu8PDC4JL4/XnpvVU9/djhYgYxhPD60xyEnIFAZeMclG+
 J9PL/4xUFiE5+odhPFA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a674c5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NLiCwHATAAAA:8
 a=VnNF1IyMAAAA:8 a=0_scnjIuNO9bK2VfJ8sA:9 a=QEXdDO2ut3YA:10
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-GUID: c5g02AkdgRqq_a4G9gGQ6vcFvgg8sfmL
X-Proofpoint-ORIG-GUID: c5g02AkdgRqq_a4G9gGQ6vcFvgg8sfmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



Am 27.07.26 um 14:14 schrieb Cornelia Huck:
> On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Cornelia, Eric, Matt,
>>
>> here are 5 more fixes for hardening QEMU against invalid input. Nothing
>> is strictly a security issues as defined in the policy. For example
>> https://qemu-project.gitlab.io/qemu/system/security.html says assert /
>> abort: If triggering the code path requires kernel privileges (or root
>> account access) in the guest, asserts/aborts in QEMU are a self
>> inflicted denial of service. These will not be treated as security
>> flaws, at most hardening bugs.
>> And if anyone can provide invalid boot loader content it can provide
>> anything to boot if secure boot is not available.
>> We should fix those anyway, probably even for 11.1
> 
> Fixing: yes. For 11.1: how easy are they to trigger? For the bios fixes,
> I assume you need a broken/crafted disk image; I assume that for the
> other two, you need some buggy/misbehaving guest. Did you actually
> manage to trigger this via some kind of test case?

Easy to trigger, but only with modified guests or modified zipls. Normal
guests will not trigger those.

