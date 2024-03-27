Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C0DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 05:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpM2f-0003rN-2q; Wed, 27 Mar 2024 01:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rpM2d-0003rB-Pa; Wed, 27 Mar 2024 01:41:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rpM2b-0000h3-LI; Wed, 27 Mar 2024 01:41:39 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R5PPZb010889; Wed, 27 Mar 2024 05:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UjUkq+b+LBS5RhyF4eMJSQ+wfVYc6hR0LqlqbAetgII=;
 b=hSTLGDXoz4Wci/LmnQaeqq0adqsUw7E46moxCzK2KMZ5jP7OH9CrBf6PlcDVshTtGURV
 EO6EA3iNysUl6nFdjmwHw40X2isltoYmNKNwJVtxdwU2l3msnVVSU8NVFnmsrV8ZSi04
 /KZPnNeRjg9EQaI5BFszOt0x2pG7gWEPRJy+nRKq9k+e1FG1djPHzzXAh0iZc1gei12u
 x/SHkpfwoh0voJSPpHb1TnTDSLOlqXD6gsD/IEElWj9vJ7tYWxhvQAF9K8PI9M7LV7ig
 oNBHrmpIkvjaXZaL4j/EdMCY2d2LOz9yhgHTpV+2q29PW7jNnGXLlovaNAL7zdt+J43v SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x497jrcf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 05:41:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42R5fSF2002681;
 Wed, 27 Mar 2024 05:41:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x497jrcf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 05:41:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R2RgjX016421; Wed, 27 Mar 2024 05:41:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29du50p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 05:41:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42R5fOTk36897096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 05:41:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D0295804B;
 Wed, 27 Mar 2024 05:41:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D05558055;
 Wed, 27 Mar 2024 05:41:22 +0000 (GMT)
Received: from [9.171.55.159] (unknown [9.171.55.159])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 05:41:21 +0000 (GMT)
Message-ID: <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
Date: Wed, 27 Mar 2024 11:11:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
To: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Neuling <mikey@neuling.org>
References: <20240312165851.2240242-1-npiggin@gmail.com>
 <20240312165851.2240242-36-npiggin@gmail.com>
 <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NLsTo9v0NYBFfBHblUAQHtRkbHBahtrf
X-Proofpoint-ORIG-GUID: GAKxGBIGwpWR9KwvLXOxtitOjgxR6K0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403270036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/26/24 21:32, Peter Maydell wrote:
> On Tue, 12 Mar 2024 at 17:11, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>
>> Introduce the nested PAPR hcalls:
>>      - H_GUEST_GET_STATE which is used to get state of a nested guest or
>>        a guest VCPU. The value field for each element in the request is
>>        destination to be updated to reflect current state on success.
>>      - H_GUEST_SET_STATE which is used to modify the state of a guest or
>>        a guest VCPU. On success, guest (or its VCPU) state shall be
>>        updated as per the value field for the requested element(s).
>>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Hi; Coverity points out a problem with this code (CID 1540008, 1540009):
> 
> 
> 
>> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>> +                                         SpaprMachineState *spapr,
>> +                                         target_ulong *args,
>> +                                         bool set)
>> +{
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    target_ulong buf = args[3];
>> +    target_ulong buflen = args[4];
>> +    struct guest_state_request gsr;
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +    gsr.buf = buf;
>> +    assert(buflen <= GSB_MAX_BUF_SIZE);
>> +    gsr.len = buflen;
>> +    gsr.flags = 0;
>> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> 
> flags is a target_ulong, which means it might only be 32 bits.
> But H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE has a bit set in the
> upper 32 bits only. So Coverity complains about this condition
> being always-zero and the body of the if being dead code.
> 
> What was the intention here?

Hi Peter,
Ideally this is intended to be running on a ppc64 where target_ulong
should be uint64_t. I guess same holds true for existing nested-hv code
as well.

Hi Nick,
Do you think keeping both nested APIs (i.e. entire spapr_nested.c)
within #ifdef TARGET_PPC64 would be a better choice here?

regards,
Harsh

> 
>> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
>> +    }
>> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>> +        return H_PARAMETER; /* flag not supported yet */
>> +    }
>> +
>> +    if (set) {
>> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
>> +    }
>> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
>> +}
> 
> thanks
> -- PMM

