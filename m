Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B474DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wek76-0002wX-0k; Tue, 30 Jun 2026 21:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wek70-0002vt-1J; Tue, 30 Jun 2026 21:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wek6x-0004Tc-LD; Tue, 30 Jun 2026 21:51:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UNIinO3447412; Wed, 1 Jul 2026 01:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zg9Gso
 g+INwMexCAZDnVjLCwm7LGqdvw/U+v0xEm5Zk=; b=cUJRuxp4C9RaZyhK1BFv8C
 Mff0HfkY8oxt13vSqEm57/ZM+FvlUiseV5gKnRCTIB5exTtZcniUil0r7x50k/QF
 QJoI+64JUNskkWVxVGqo+/9WEVI8tQBhyDbBbA1WfxeW1dM5n5ef6Eh82mEiV98z
 j3WuBaUKdgOX4rmvUfGz8ypXjAu0GZTfvMd0Sp2dPUYafdCo/JYQ6Dlh24gIBsrh
 /xhXsrAu55w/UdenVvgEcmXzA8UnfD6aDgts0Sb6U3P8JGWkgBsQRvcGwpbEI42Q
 8xByX1gvd41KjPvIuHqpGFifoq1eII1ck3K6itrxEwjmtCn3hF15MklxmNRWQc1A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe209y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 01:51:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6611o336005094;
 Wed, 1 Jul 2026 01:51:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhd30y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 01:51:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6611pPmC59703640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 01:51:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9B2B2004B;
 Wed,  1 Jul 2026 01:51:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4651720067;
 Wed,  1 Jul 2026 01:51:17 +0000 (GMT)
Received: from [9.67.23.244] (unknown [9.67.23.244])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 01:51:16 +0000 (GMT)
Message-ID: <d225ef6f-14c9-4bce-8f6b-12590071114c@linux.ibm.com>
Date: Wed, 1 Jul 2026 07:21:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
 <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
In-Reply-To: <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vZyHofFPYV6323zKUTAmiRoshqRFA1uJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX8brOzZwxeLru
 CrYEhVrmddV+r0S9MkqVnqzMV02QT16JuNXbGny3FY8ru5TGkROSJ/yyvqs/IqNXksfQB3oBKU9
 pwIQWJvfcpWzH450ctTr7WVfD/L+lSs=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4472a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jFxEIJLJGxOkPOqaoPIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX/djNckrFoscy
 EvvdJ+pywS7wHCT9ceMMA16NcG6dCDh6KveuMIMO9rFaBmwsL2QqPwNC2It2N55xhPQ6u/Wmsh7
 MwR4vFtBZ1rBgn1J0Z1Rv+NGkfnLGqQYjtoOuzFlkpM4WyaKzBIOWx5H+H/i/iernOh6lDHlAsV
 XWuvACvbeHRNEyQTL+kZMrdcLAviG6Jq36ASy9AyyX/rhhJIKafQ444yrIU+P34WQb4BOtqOQYr
 N4XZmIp4mAmVegkdrzFfcG5z4tRFzpZr4fSSxeQOfyxv1Erj8M9eYKEa3ldkdOSI9ToaqJ06gty
 1CG9wSa/ytpbNO0lLlXXMZjYFBQ8SYRAwVC3Y9HiEqUO6BK1IGdw4rpnpEsQT0dquKCvd1T4/RG
 OG+BPyoRSKCvVlc+983IskGlpOJjsmYExV82YcGT5+iUYhm0YxRbXwjJqV6lJMEHPvo4oMb4Dfu
 92bZKJuEB/l8pKRgWIw==
X-Proofpoint-ORIG-GUID: qv15DRiyvtH463WVSpSlniXiS2nFTvqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017
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


On 01/07/26 00:22, Aditya Gupta wrote:
> On 26/06/30 09:55AM, Nikhil Kumar Singh wrote:
>> Hi Aditya,
>>
>> One comment below.
>>
>> On 23/06/26 19:49, Aditya Gupta wrote:
>>> @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
>>>        const PnvChip *chip = data;
>>>        QTestState *qts = NULL;
>>>        g_autofree char *tmp_path = NULL;
>>> +    const char *machine = "powernv10";
>> Would it make sense to introduce `pnv_get_machine_type()` in patch 2
>> instead of patch 3? That would avoid hardcoding `"powernv10"` here and
>> allow this patch to use the helper directly.
> Could be done, but i will prefer to keep it in current state, as of this
> patch, power11 wasn't added to this test, and the test only runs for
> powernv10, later as powern11 gets added in next patch this is changed to
> use pnv_get_machine_type.
>
> If pnv_get_machine_type gets introduced in this patch, it makes sense to
> modify all other tests also to use it, which is more than what this
> patch intends to do (just remove hardcoded index in spi test).
> To me, it seems okay to keep it as is, what do you say ?
Thanks for the explanation. I agree with keeping it as is for this 
patch. Looks good to me.

  ~ Nikhil
>> Otherwise, the patch looks good to me.
> Thanks for reviewing, Nikhil !
>
> - Aditya G
>
>> Thanks,
>> Nikhil

