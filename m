Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE61C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdfj-0000MZ-Sb; Thu, 29 Feb 2024 05:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfdfh-0000LW-AD; Thu, 29 Feb 2024 05:29:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfdfe-00068m-2H; Thu, 29 Feb 2024 05:29:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41TANO84027393; Thu, 29 Feb 2024 10:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GMJ75easQeeFUvG3qLV8sirt+ikRys37PuUQvTURvtU=;
 b=j2j5wMfHo+mhhfOtwltBfq8vqVVh+Hg6OBT32NhixGYbL/sSp1DKq1TgVYbeaZUkEroU
 srqqP0ZgpndmVQBfSaCxZYP9MaIuKhCDs6QekBYc/61sVB0EPTuF4jQtwzmORRRDSKqb
 FnqTCfRrAth4LprOywcp4XseYlc/WQ7Al/IZUNP7uLdVItAUIG454RPFeiGnUSCYNNJz
 PGDGEIcLn30a8cTtZilddemJe0kTynZFjj0KhGb2vsgJwg5At7/Freuo3REhomb30rV3
 Q5GZQg1qqnDPhAchQMn35mIp6uzHgrzrHx229lLi/WL4F4mOADzndniaeATA+U7/oAAP 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqrmh45g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 10:29:39 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TABAAw000517;
 Thu, 29 Feb 2024 10:29:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqrmh455-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 10:29:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9p5T6008211; Thu, 29 Feb 2024 10:29:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mmg27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 10:29:38 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41TATYSV14287540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 10:29:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C47835805F;
 Thu, 29 Feb 2024 10:29:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C0F658055;
 Thu, 29 Feb 2024 10:29:32 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Feb 2024 10:29:31 +0000 (GMT)
Message-ID: <5efdebda-636c-4ac1-9f3c-3e1a850079f5@linux.ibm.com>
Date: Thu, 29 Feb 2024 15:59:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] spapr: nested: Initialize the GSB elements
 lookup table.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-11-harshpb@linux.ibm.com>
 <CZFRXDZ1CYSH.34D4OR8HLW63U@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFRXDZ1CYSH.34D4OR8HLW63U@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y13Jr1VskW7kS-UhY5ZpdAqgHa_i9h76
X-Proofpoint-ORIG-GUID: DGXbXsuhhWZAeLu3bVURfGmuePueSHAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/27/24 15:32, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> Nested PAPR API provides a standard Guest State Buffer (GSB) format
>> with unique IDs for each guest state element for which get/set state is
>> supported by the API. Some of the elements are read-only and/or guest-wide.
>> Introducing helper routines for state exchange of each of the nested guest
>> state elements for which get/set state should be supported by the API.
>>
> 
> This is doing more than just adding helper routines for the GSB access.

Yes, some of the GSB elements are also introduced along with respective 
helpers.

> 
> [snip]
> 
>> +
>>   typedef struct SpaprMachineStateNested {
>>       uint64_t ptcr;
>>       uint8_t api;
>> @@ -16,6 +201,8 @@ typedef struct SpaprMachineStateNested {
>>   typedef struct SpaprMachineStateNestedGuest {
>>       uint32_t pvr_logical;
>>       unsigned long vcpus;
>> +    uint64_t parttbl[2];
>> +    uint64_t tb_offset;
>>       struct SpaprMachineStateNestedGuestVcpu *vcpu;
>>   } SpaprMachineStateNestedGuest;
>>   
> [snip]
> 
>>   
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>> @@ -172,17 +452,40 @@ struct nested_ppc_state {
>>       uint64_t sier;
>>       uint32_t vscr;
>>       uint64_t fpscr;
>> +    int64_t dec_expiry_tb;
>> +};
>> +
>> +struct SpaprMachineStateNestedGuestVcpuRunBuf {
>> +    uint64_t addr;
>> +    uint64_t size;
>>   };
>>   
>>   typedef struct SpaprMachineStateNestedGuestVcpu {
>>       bool enabled;
>>       struct nested_ppc_state state;
>> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
>> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
>> +    int64_t tb_offset;
>> +    uint64_t hdecr_expiry_tb;
>>   } SpaprMachineStateNestedGuestVcpu;
> 
> It's adding new fields in existing nested guest state
> structures. This should be explained a bit more, split into
> another patch, or moved to patches where they get used.

Yes, these new fields are actually representing GSB elements.
These elements were explained in the documentation patch which shall now
point to the documentation in the kernel docs as suggested earlier.
Let me know if we need to document additionally in this patch commit log
also.

regards,
Harsh


> 
> Thanks,
> Nick

