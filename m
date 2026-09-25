Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FB9C98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zIF-0001bs-BO; Fri, 25 Sep 2026 02:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zI5-0001Zk-Oq; Fri, 25 Sep 2026 02:20:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zI3-0004vf-MW; Fri, 25 Sep 2026 02:20:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aCX2061558; Fri, 25 Sep 2026 06:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RP931O
 KVHgzHT3WzJWYvFeTvBbkfWyn6Q3DsHKNYhb0=; b=sL4eHHatIna0oBbe5pYI8g
 xMlOHZzOtjZJplLieZjtx7+UgFkXBV6zzcyC8FZwlrNr2yqDR7uHWs/5CY/+m8pP
 Q2zMRHOzJONeo1ej4azs4JmrfAOEPrk1YEuDODWD6kTBlqhdqAe9qYACDg/vZcRk
 VrtzuV1LjrHa3U7POtNONxlJRqsroFf2e5AQuxbXwJ5dZ02y/9gb7k8/Qb7C1w5B
 RSnJcVb9BidXnsvrlG0P/0WTRFf1kwu6BNAZJc9LOquZWGX1VVkMRB4oRY5HoCvH
 HLk8LiF+U5pyXRxQhfz8XHRDVO8m9/Wr54d2QZTs/vqsrWdb1A9pEYIPA142qstw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsnf7m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:19:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lnk33245081; Fri, 25 Sep 2026 06:19:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu917hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:19:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P6JtI830671580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 06:19:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65E1A58061;
 Fri, 25 Sep 2026 06:19:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EEF858043;
 Fri, 25 Sep 2026 06:19:48 +0000 (GMT)
Received: from [9.43.103.81] (unknown [9.43.103.81])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 06:19:47 +0000 (GMT)
Message-ID: <f4fcb216-4a58-49de-ab5e-6e315cb1f21d@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:49:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] ppc/spapr: add PReP boot partition detection
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-2-uverma@linux.ibm.com>
 <85471317-0434-46bc-8c44-d899a3bcd177@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <85471317-0434-46bc-8c44-d899a3bcd177@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab6128e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mWTBhnHDoA_t3FSpoBAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t5AEQeMLlEnrp0AQqNP3e6sLT5Y1y6Ev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXxCudbwu4A8UT
 h1U0wTTvZ2NfU8O+MOi/pMn1Nl3HXSMukDuRXcnPt0Co5BX+gMMNLWB1XCeGqWB0PzgZ86NWW81
 cOPnnensTK9qtZDU7EPK8YGDmfBarOr/l9RrJtjkETbwoJAsBybD2yVZnqTKD1ntNVsZ7wpBSOe
 7bqFgRg/j7YZT30v1l5TdRM3EL9wzPvmlHasZEnpW3ArD5xdU6kPGXR5XJVpCpRMlxumlfyojqa
 /EgT7NPvnmxQWKCsHDXSUw9KZIh95tdro7e+cTRa1obr7YgUtntbJeABlznOmfT1K2sSugMCK1I
 /AQ8c7byH5sD5sjlkUf0jJNxb270HjnTmJNk98ZiinXnzi74DzuheS9gc9jKbfWnud03wWdJ1U/
 owa6YiWAM/kW4dLzge4IPqxGKhcr497FMob7+rm9IJz08my2xQgHchgMyWmlOnc9UPBDVLhq7XK
 40fE/gjFxVYm9AtpNhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX5RCCt8cAxTl8
 eVQZiPlzIRETxB9R3kw+hxjR2zXKEFWaN4y98x+8oaMFH3RVa2ccJXvd6QElD1PY0tQ0a9Mv7me
 FVlyBugFNmx0ccn2N5vwyQEAf9B+TKU=
X-Proofpoint-GUID: Gu4XpeTFU-SuxiyWBZuOP6eDPKvs1z8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Narayana,

On 9/17/26 10:44 PM, Narayana Murty N wrote:
> 
> 
> On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
<snip>
>> +    entries_lba = le64_to_cpu(header->partition_entries_lba);
>> +    num_entries = le32_to_cpu(header->num_partition_entries);
>> +    entry_size = le32_to_cpu(header->partition_entry_size);
>> +
>> +    if (num_entries > 128) {
>> +        num_entries = 128;
>> +    }
> Why is silently truncating to 128 the right behaviour?
> 
> This bounds the loop, which is good, but it also means that a valid PReP 
> partition after entry 127 will not be found. If 128 is an intentional 
> VOF limitation, can we document that? Otherwise it may be better to 
> validate the table size and iterate the actual number of entries subject 
> to an explicit resource limit.

The PReP is usually the first partition in a disk and systems usually 
have max 128 partitions, though GPT spec doesn't have any upper limit. 
So, I capped the limit to 128, will add a comment here for this in the 
v2. I don't think iterating beyond 128 is necessary, but I'm open to 
changing this.

>> +
>> +    if (entry_size < 128) {
>> +        return false;
>> +    }
>> +
>> +    buf = g_malloc(entry_size);
> The "entry_size" comes directly from the GPT header, so checking only 
> the lower bound means a malformed image can drive an arbitrarily large 
> host allocation here.
> 
> Do we need to allocate "entry_size" bytes at all?
> 
> We only consume the fixed fields at the beginning of the GPT entry. It 
> seems safer to use `entry_size` only as the stride between entries and 
> read `sizeof(GPTPartitionEntry)` bytes for each entry after checking 
> that `entry_size >= sizeof(GPTPartitionEntry)`.
> 
> That also avoids having to invent an arbitrary maximum GPT entry size.
> 
Sure, will fix the allocation of buf to sizeof(GPTPartitionEntry) in v2.

>> +    for (i = 0; i < num_entries; i++) {
>> +        current_entry_offset = (entries_lba * SECTOR_SIZE) +
>> +                               ((uint64_t)i * entry_size);
> Both the multiplication and addition are based on image-controlled 
> fields. Could we validate the complete partition-entry array against 
> blk_getlength() using checked arithmetic before iterating it?

Sure, will fix in v2.

>> +
>> +        ret = blk_pread(blk, current_entry_offset, entry_size, buf, 0);
>> +        if (ret < 0) {
>> +            warn_report("GPT: failed to read partition entry %u "
>> +                        "(ret=%d)", i, ret);
>> +            g_free(buf);
>> +            return false;
>> +        }
>> +
>> +        current_entry = (GPTPartitionEntry *)buf;
>> +        if (memcmp(current_entry->type_guid, GUID_PREP_BOOT,
>> +                   sizeof(GUID_PREP_BOOT)) == 0) {
>> +            *offset = le64_to_cpu(current_entry->first_lba) * 
>> SECTOR_SIZE;
>> +            *size = (le64_to_cpu(current_entry->last_lba) -
>> +                     le64_to_cpu(current_entry->first_lba) + 1) * 
>> SECTOR_SIZE;
> I think this needs validation before returning the partition.
> 
> If last_lba < first_lba, the subtraction underflows and produces a very 
> large partition size. There are also multiplication/partition-end 
> overflow cases.
> 
> I'd expect something along the lines of:
>      first_lba <= last_lba
>      first_lba <= disk_last_lba
>      last_lba <= disk_last_lba

Sure, will add these checks in v2.
<snip>
>> +typedef struct BlockBackend BlockBackend;
>> +
>> +bool spapr_vof_find_prep_partition(BlockBackend *blk,
>> +                                   uint64_t *offset, uint64_t *size);
>> +
>> +#endif /* HW_SPAPR_VOF_H */
> 
> we parse header_size, CRC fields, usable-LBA fields, etc. into 
> GPTHeader, but only check the signature.
> 
> I don't think CRC validation should replace range validation, but at 
> least the header fields which determine the layout we consume should 
> probably be validated before trusting the partition table.
> 
> check CRC validation posibilities .
> 
Sure, will add the CRC validation for GPT header and partition entry 
array in v2.
It's worth noting that SLOF doesn't have many of these validations, but 
will add these additional sanity checks in VOF.

> Thanks,
> Narayana Murty N
> 
> 

Regards,
Utkarsh


