Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B0DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 14:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIpn3-0002T5-24; Tue, 11 Nov 2025 09:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vIpmw-0002RZ-WF; Tue, 11 Nov 2025 09:56:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vIpms-0001y5-Au; Tue, 11 Nov 2025 09:56:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBFUhx028610;
 Tue, 11 Nov 2025 14:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1n4NV4
 rTL1uB8zDjOgwH2T/xUEGfiOJV5/YEkGfaolI=; b=HdFsF4l6zhs5Owck2YW4/C
 MB57cYDkHqaEtbvXiJVtndVoyh3zqtf6XVvaZzq2VGfsnPAlo8qp2myIV7RZJHA+
 v1R21ur7zhZ2FerVMbhbIMKs9ZouRmMgK967YrQU/hD1NBM87Cp8v/lZeXNHZy5s
 pCsQOknDkwuCRQtIT7jaGTFwH59k5Levsd13iJTLhQrqFPETgDyPn8s6+E+7k2ey
 4jeV1tMKuwA0OKcG2OE3ku8MbwBYt7Bhjo/J1feUv46Hv3yCYdP8lThySSWrG6ef
 x0jjtF7EAZTTO0k1bbkOcE+WOm+dHjTsONnBtfhOZ9aSBJ4Eu5fPymlKR+uudyvg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m83pq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 14:55:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDllbN028880;
 Tue, 11 Nov 2025 14:55:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sbeeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 14:55:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ABEtr4f33423804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 14:55:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CB032004B;
 Tue, 11 Nov 2025 14:55:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E21E20040;
 Tue, 11 Nov 2025 14:55:52 +0000 (GMT)
Received: from [9.111.47.163] (unknown [9.111.47.163])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Nov 2025 14:55:52 +0000 (GMT)
Message-ID: <375dccd4-b7bf-4db2-9998-cbd5b50474b5@linux.ibm.com>
Date: Tue, 11 Nov 2025 15:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Miehlbradt
 <nicholas@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
 <d5990a22-76dc-4c20-ba38-6179899a3f42@redhat.com>
 <a80fc77e-e565-42ce-9d31-3e09d694c7f2@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <a80fc77e-e565-42ce-9d31-3e09d694c7f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69134e7e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UHEQkFMDxEVUuGuboHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xDU8QWr-LUIlnGzzx7uzWi024z3jbi5W
X-Proofpoint-ORIG-GUID: xDU8QWr-LUIlnGzzx7uzWi024z3jbi5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX3TuKCNpIja0Z
 JBj+77m1AG+BhELsUpSf4p6dTT86m/0b5YH7ALv/oUawLyl3Y4Ve2ikClwt17PoXa+NjS4B4Nuo
 s6lpgUOk7bvesxphSTI1vXLTvdXOYabIOzHKyGYR287FG3M05chasEildNjcuQGJuKGWWiVSYni
 EcY5n7FhyWDBJjoaSQ94uyVwsKn/bGKAYKLThCI+cdDEHT1ntl3LocrNO863+uSp/SzLa2DRsWp
 HKKJ3Gt6GPRhkYjTVtphv6+jk1kjybg9P+wKW8aQmFCpSUk9OEUlAx3kSoPgcXYXgFfb4PF7Z0C
 lvsh2LKaFZZRdJLgVZ1t3epHt0GdNTVX8wkYMrTV8cXieqtQ7+sxOjz2r5v/EmcBpgP5juCu+F/
 vZcdnt9AGMb6YxG8RJYb2cy8JK4uhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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


Am 11.11.25 um 14:37 schrieb David Hildenbrand (Red Hat):
>>>>        /*
>>>>         * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
>>>> @@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine,
>>>> ResetType type)
>>>>        switch (reset_type) {
>>>>        case S390_RESET_EXTERNAL:
>>>>        case S390_RESET_REIPL:
>>>> +    case S390_RESET_REIPL_CLEAR:
>>>>            /*
>>>>             * Reset the subsystem which includes a AP reset. If a PV
>>>>             * guest had APQNs attached the AP reset is a prerequisite to
>>>> @@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine,
>>>> ResetType type)
>>>>                s390_machine_unprotect(ms);
>>>>            }
>>>> +        if (reset_type == S390_RESET_REIPL_CLEAR) {
>>>> +            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
>>>> +        }
>>>> +
> 
> ...
> 
>>>
>>>
>>>
>>> Do I see that right that this patch never made it into qemu master? IIRC
>>> Matt has clarified all concerns?
>>
>> I was hoping to see a reply from David that he's fine with the patch now...
>> David?
> 
> Staring at this again, one more point regarding userfaultfd: doing the discard on the destination while postcopy is active might be problematic.
> 
> I don't remember all details, but I think that if we have the following:
> 
> 1) Migrate page X to dst
> 2) Discard page X on dst
> 3) Access page X on dst
> 
> that postcopy_request_page()->migrate_send_rp_req_pages() would assume that the page was already transferred (marked received in the receive bitmap during 1) ) and essentially never place a fresh zeropage during 3) to be stuck forever.

Can we have a postcopy running while we are in system reset? Or as an alternative can we check for postcopy running and not discard in that case.

