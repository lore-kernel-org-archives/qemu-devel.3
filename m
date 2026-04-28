Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AD6FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHnN3-0001jq-Og; Tue, 28 Apr 2026 14:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wHnN1-0001iz-HR; Tue, 28 Apr 2026 14:41:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wHnMz-0008TX-RG; Tue, 28 Apr 2026 14:41:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SEYR2M2036575; Tue, 28 Apr 2026 18:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sboEx6
 sI8jx68+4ybidi8ktV4XZhiJG98WfhbeKEVpQ=; b=dXWtggqMOHaqspx5qtP3/x
 MC1KlAZaa25ux3K8Wuaf36lZ7rt8sB43qEj3RdaqpVE1TgLz1rVw6tCYKBZBJDQf
 OHZnvreeVS1amjPpcg1dh7SEQzWb3Y9FwywIsrjznsKx5Zrb5O/6uiOCnpqBPVJj
 C7Gud6IXevRMFM3vtfPbQW3c5SFuWXS4jVEbEePhcBlfa4mMns06ve7qqjPgwcQ/
 uw+6w3NwNAsJUaDhvAT8gfTMeo2nfyJ78jTksZGCQhVlXa+gaTFIonwdvGK880/n
 VKh7AT4tGtZsnXPyZ/OxdpCpR2sTfp13qjfe+5iqwYexZKn7+G5Xxe6cqfMTKuZA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jp3cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 18:41:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SIckPE015778;
 Tue, 28 Apr 2026 18:41:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyau56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 18:41:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SIf95d26280626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 18:41:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69DDF58056;
 Tue, 28 Apr 2026 18:41:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92CF15805E;
 Tue, 28 Apr 2026 18:41:07 +0000 (GMT)
Received: from [9.61.117.177] (unknown [9.61.117.177])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 18:41:07 +0000 (GMT)
Message-ID: <84f700a1-d41f-4b3a-8840-30956534ec2b@linux.ibm.com>
Date: Tue, 28 Apr 2026 14:41:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-21-zycai@linux.ibm.com>
 <13e51aea-32de-498d-83ce-d2f082064fb1@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <13e51aea-32de-498d-83ce-d2f082064fb1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NyBTYWx0ZWRfX7XPVJ9ycfRgk
 5H72R2qbDitOIOgtQimAPIRpxG9zXqRAhMovcNIAcnCFTPHCieZvCLQTrZllHZT5X65Y78hDgAq
 pGw7uHei50/SjlS+hin5DMA6VxFvxGhNV+AmBkNPsaTpLevydUyuCP1zrVrrAKsCNZBEFhcNpIh
 2LlKIYcJ+F6ApdY3SR4uOAemA+Ru4NN2Axok8PHmmZ9h8jeW/kRYsInLGd+bPSdn0jjTBkbC7ax
 EHt6D+rQI92cV4aDGxfh+7kKOnqYQByM8N5wniZl4xYfTG5J0b7FWJ9R3iIZlAeukqNdF+sZCJQ
 gdeHKNbMeEFnB+z1l6OiLI7bt/XkTUZwmAl7al+74K5GKQStL4i44fHNwG4Wykvz+h8uOgCD38A
 7Tu4RLapilSuu+BQDu5WxMrdR3L5Hgz+5u1ZnaI16N2zD5ZtywKH5SCbh7JOmvvYWQ3mTGq90Op
 0jTEhz6Ku2OlfV5M1fQ==
X-Proofpoint-GUID: yH0VWgnz5sIoO6-lrO0I-wqpjCRO2WXR
X-Proofpoint-ORIG-GUID: yH0VWgnz5sIoO6-lrO0I-wqpjCRO2WXR
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0ff47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=RNgVx3aTONk1U17rOuMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/10/26 3:54 PM, Collin Walling wrote:
> On 4/2/26 18:14, Zhuoying Cai wrote:
>> Add address range tracking and overlap checks to ensure that no
>> component overlaps with a signed component during secure IPL.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
>>  pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
>>  2 files changed, 69 insertions(+), 4 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index b66ca9ca7e..d2079e19bc 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c

[...]

>>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>>  {
>>      if (zipl_load_segment(entry, sig_sec) < 0) {
>> @@ -253,6 +296,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>>       * exists for the certificate).
>>       */
>>      int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>> +    SecureIplCompAddrRangeList range_list = { 0 };
>>      int signed_count = 0;
>>  
>>      if (!secure_ipl_supported()) {
>> @@ -282,14 +326,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>>                  goto out;
>>              }
>>  
>> -            if (!sig_len) {
>> -                break;
>> -            }
>> -
>>              comp_entry_info = (SecureIplCompEntryInfo){ 0 };
>>              comp_entry_info.addr = comp_addr;
>>              comp_entry_info.len = (uint64_t)comp_len;
>>  
>> +            if (is_comp_overlap(&range_list, comp_entry_info)) {
>> +                zipl_secure_handle("Component addresses overlap");
>> +            }
> 
> Seems to be mixed styling here where `is_comp_overlap` is a bool and the
> error is handled outside the function, and `comp_addr_range_add` is void
> and the error is handled within.
> 
> For consistency, I think is_comp_overlap could be check_comp_overlap,
> void, and handle the error within.
> 
>> +            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
>> +            range_list.index += 1;
> 
> Index should be incremented within the function.
> 
>> +
>> +            if (!sig_len) {
>> +                break;
>> +            }
>> +
> 
> What is the reason for this check moving here?  If it's intentional for
> the check to be at this point in the function, I'd suggest putting in
> here in the original patch the code was introduced so it doesn't look
> anomalous.
> 

Thanks for the suggestion.

This check was moved here because overlapping checks apply to all
components, meaning every component, signed or unsigned, must ensure it
does not overlap with signed components. The checks after this point
apply only to signed components. I can put the check here in the
original patch.

>>              verified = verify_signature(comp_entry_info,
>>                                          sig_len, (uint64_t)sig,
>>                                          &cert_len, &cert_table_idx);
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index 6d65cd5596..c625ac2e3a 100644
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
>> + * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
>> + */
>> +typedef struct SecureIplCompAddrRangeList {
>> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
>> +    int index;
>> +} SecureIplCompAddrRangeList;
>> +
>>  static inline void zipl_secure_handle(const char *message)
>>  {
>>      switch (boot_mode) {
> 
> 


