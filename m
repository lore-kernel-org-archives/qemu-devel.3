Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E916CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjLr-0003T6-Qn; Thu, 11 Jun 2026 13:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wXjLn-0003SQ-Ik; Thu, 11 Jun 2026 13:37:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wXjLl-0001qV-03; Thu, 11 Jun 2026 13:37:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BBhjCx3872855; Thu, 11 Jun 2026 17:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V3VwJw
 TKEd5/blceOO6nHRHbj4CdEJ7spP89gnGJ394=; b=p7G1IVgo1h1DQyH0QblLb6
 Zxua6WXR2IG9JvDTk2ZCyJfH3LkSVOShHDkwRMPeY0MjyHFiyQbSIzZM5P+QnqPn
 7MD/ZqYi6MtfVGjZHOJDHMBpEPBRnzySRt0hqOXFFhcmASlBRkqMUI2PN1gdyWxI
 4VSRGa5uOMEbJHhuLFaAfKfpEf8gDWwNuJ0ESrc84h2JI+rfZ1CkEZxYlBhDm+kD
 F5+1EBpUeqHuP0RIao3B9AkHt7FtVlpMV94sWQbQT8mjBmZUB0BdzEDfu2jqXDye
 KMwP9HQE5YNKO2wZfnYu0HplirCUc1jSD61NTZCpUgVZr0TObta7jKAJ2SCS3+PQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ew4cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 17:37:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BHYk7d003948;
 Thu, 11 Jun 2026 17:37:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09m8f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 17:37:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65BHbi4T59965924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2026 17:37:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC5D5804E;
 Thu, 11 Jun 2026 17:37:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D81F5803F;
 Thu, 11 Jun 2026 17:37:42 +0000 (GMT)
Received: from [9.61.99.146] (unknown [9.61.99.146])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2026 17:37:42 +0000 (GMT)
Message-ID: <b92cabbe-4c2f-4949-850c-c663109f35c5@linux.ibm.com>
Date: Thu, 11 Jun 2026 13:37:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 22/32] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-23-zycai@linux.ibm.com>
 <19be6b1f-1683-4038-90b4-282744ca839f@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <19be6b1f-1683-4038-90b4-282744ca839f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE3NyBTYWx0ZWRfXzO7uDie/zODu
 eomm1YgO/z/twcyo74HIcXaTb9EOroY2vwn29L1tNlvcZ9KBZcr15S0iUCs8DvYwJLL05csyTvG
 4FJQTE8RJOc5Q6jEWf5Qpb8u1y7Vum1C/nFMKPRcuSF4KNW8oHrZZcp39viJ8cepVb7X7Xssa74
 nwYZMnu8zcCiZ9zodgdO9M3yYbSxXS6Gsd/j1fRugqvMbn09Q1ODW69K6FwhpFVTqIyKrJFvmGp
 7/0G3k9ApSij8zWCvqMx4z2609qGKc9ghacaaj3EfdWq+b1cDkusiTKsqXxZNj3LUNewxC7U4Mg
 ez+nI84IEoqU8jrD0kgrJtBpxGhK4L3R0iNDnHSY7LEArflFVBiV7DUYzEhrhl64CLaZDDz1nEw
 YmRFUvk+/JG36nCG6UDCbAQiYVgpmCuBvcav4150yI2Go/ATc2FHyeafHW8sKPJvGLPm/tuoIY5
 JbLQIysGGc6AFacF+XQ==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2af26a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=lkyEdsbLyFGhA1-F8ZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mg-TAil165frl5Ack-YbJaWpvCVUJtfi
X-Proofpoint-GUID: Mg-TAil165frl5Ack-YbJaWpvCVUJtfi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE3NyBTYWx0ZWRfX/bb2gY9FsNQ5
 H+QQEkWxb6Wb8dFY9PkRENJ39iVQ2eBMDoi7OR+RrwnN/hyP/Ajx4nzPGUrZEkzdGA/a5oG1D0R
 k6JWoyNcDf5cJbsW5zP5eYNhAiz8qq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

On 5/28/26 12:18 PM, Collin Walling wrote:
> On 5/5/26 16:18, Zhuoying Cai wrote:
>> Add address range tracking and overlap checks to ensure that no
>> component overlaps with a signed component during secure IPL.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/secure-ipl.c | 49 +++++++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index 6e943446a7..fdac74aa97 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -220,6 +220,51 @@ static void init_lists(IplDeviceComponentList *comp_list,
>>      cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
>>  }
>>  
>> +static void check_comp_overlap(SecureIplCompAddrRangeList *range_list,
>> +                               SecureIplCompEntryInfo comp_entry_info)
>> +{
>> +    uint64_t start_addr;
>> +    uint64_t end_addr;
>> +
>> +    start_addr = comp_entry_info.addr;
>> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
>> +
>> +    /*
>> +     * Check component's address range does not overlap with any
>> +     * signed component's address range.
>> +     */
>> +    for (int i = 0; i < range_list->num; i++) {
>> +        if (range_list->comp_addr_range[i].is_signed &&
>> +            (range_list->comp_addr_range[i].start_addr < end_addr &&
>> +            start_addr < range_list->comp_addr_range[i].end_addr)) {
>> +            zipl_secure_error("Component addresses overlap");
>> +       }
>> +    }
>> +}
>> +
>> +static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
>> +                                SecureIplCompEntryInfo comp_entry_info,
>> +                                bool is_signed)
>> +{
>> +    uint64_t start_addr;
>> +    uint64_t end_addr;
>> +
>> +    start_addr = comp_entry_info.addr;
>> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
>> +
>> +    if (range_list->num >= MAX_COMP_ENTRIES) {
>> +        zipl_secure_error("Component address range update failed due to out-of-range"
>> +                          " index; Overlapping validation cannot be guaranteed");
>> +        return;
>> +    }
>> +
>> +    range_list->comp_addr_range[range_list->num].is_signed = is_signed;
>> +    range_list->comp_addr_range[range_list->num].start_addr = start_addr;
>> +    range_list->comp_addr_range[range_list->num].end_addr = end_addr;
>> +
>> +    range_list->num += 1;
>> +}
>> +
>>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>>  {
>>      if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> @@ -261,6 +306,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>>       * exists for the certificate).
>>       */
>>      int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>> +    SecureIplCompAddrRangeList range_list = { 0 };
>>      int signed_count = 0;
>>  
>>      init_lists(&comp_list, &cert_list);
>> @@ -292,6 +338,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>>              comp_entry_info.addr = comp_addr;
>>              comp_entry_info.len = (uint64_t)comp_len;
>>  
>> +            check_comp_overlap(&range_list, comp_entry_info);
>> +            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
>> +
>>              /* no signature present (unsigned component) */
>>              if (!sig_entry_info.len) {
>>                  break;
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index cc0302f56b..29bbf65c6c 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.h
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
>>      uint8_t  flags;
>>  } SecureIplCompEntryInfo;
>>  
>> +typedef struct SecureIplCompAddrRange {
>> +    bool is_signed;
>> +    uint64_t start_addr;
>> +    uint64_t end_addr;
>> +} SecureIplCompAddrRange;
>> +
>> +/*
>> + * Custom struct for managing a list of secure IPL component address ranges.
>> + * Tracks up to MAX_COMP_ENTRIES address ranges with an num counter.
>> + */
>> +typedef struct SecureIplCompAddrRangeList {
>> +    SecureIplCompAddrRange comp_addr_range[MAX_COMP_ENTRIES];
>> +    int num;
>> +} SecureIplCompAddrRangeList;
>> +
>>  static inline void zipl_secure_error(const char *message)
>>  {
>>      switch (boot_mode) {
> 
> I wonder if these checks are necessary in the BIOS, since it looks like
> the kernel will handle it in arch/s390/boot/ipl_report.c and
> physmem_info.c?  I guess confirmation is needed to check if component
> address are checked by the kernel.
> 
> If it's still needed, perhaps model the code after how the `intersect`
> function works to simplify things a bit.
> 
> Otherwise, I think it's safe to drop this patch and let the kernel
> manage checking the memory overlaps.
> 

The checks are still necessary in the BIOS because component addresses
are preserved but not validated for overlaps by the kernel. I’ll model
the code after the kernel’s intersect function. Thanks for the suggestion!


