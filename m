Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ADCF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwG-000189-5i; Fri, 10 Apr 2026 15:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBHwA-0000za-LK; Fri, 10 Apr 2026 15:54:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBHw7-0001Ze-6s; Fri, 10 Apr 2026 15:54:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ADoAGq2212477; Fri, 10 Apr 2026 19:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DHhHml
 KudBj+vPuHomIFyu6B9rGptmGvg0FQJlMSTcA=; b=SLALuvY6s/N0QMkvoDahft
 9ZTMi1iFtNkL3J/8Itia6mCmBQ/jyCyZqHN4rLiqcXY44tEZc66XfXQ8mFvDfEJa
 U8Q4A4P4O3HnjL5WhYTUSn9NhKUVpBlTby7Z6CobzOOZhMFe3kqVHuY1IA87J5OR
 EHTvAe6UeHIdKtrUTn1U3ehKjXtdrGKixiLAs1odcAY5oqRvkyF0DGYpClyodfOC
 1Tit5gOwO0Qi2wERBDdJHJKH1nVeag/PEKsN6CUNXftmwYqx5cXWh7RuBn2HFpye
 KmYx6X3IfNtfYL2VHxt2U8msLmIBiXJj0xIziTdze3mbe1SRt9+/5FGP32ljs9hw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2htpdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 19:54:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AH3sNk030068;
 Fri, 10 Apr 2026 19:54:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7ss92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 19:54:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AJs7PM58261932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 19:54:08 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B117158051;
 Fri, 10 Apr 2026 19:54:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B6A25805C;
 Fri, 10 Apr 2026 19:54:31 +0000 (GMT)
Received: from [9.67.17.158] (unknown [9.67.17.158])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Apr 2026 19:54:31 +0000 (GMT)
Message-ID: <13e51aea-32de-498d-83ce-d2f082064fb1@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:54:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
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
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE4NSBTYWx0ZWRfX2UOAR1fQ74bS
 PjmZPGmTMtzdeEIQ/0Eo/vTmxmcjupp8dqRo65hpDgh1tKjWDKTazKvd5xpkIP0tqSICa6fVPYn
 pKqhbDAC5PjSkgLd5b71MlqBgVNttqjp4oIG9nxJloycOsnEAmtMhGrfFjxqdpyP9KETdN5p5Nk
 IolwkNXuXQA/FoKs/hW3HutjWIB90KpZuzNfZTqn7/XeJx6SOFchoFUipERr5cUF/SoSUL6qQ3q
 LQxen4SPS+Ns4J7t8s2eBN3xz863f+wMR+HW3AaJ+7crCf70+oPaPx2iEaZtL9EITdgwDO6kVfS
 Tgc/T5vdymjaxZAnPqzCcn+vkkm0VV9ZmyNRSJk+GC8rILFh5h6rcbuewk9bmADeCFqkY9kmMrR
 gyZQKPCwHvJDwzpQl5Qe807BnlZU14iiCWIcmtkdVUJAbr8TLQsricLpm+ZrC5G9EJdf0jbU3if
 mV+edq5s3gU079UfYOg==
X-Proofpoint-GUID: 90KX3YY40WFpCfRMrpL0U8I2-pnIRkMZ
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d9557b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ABqtuHcFZ0KkfVKGhysA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 90KX3YY40WFpCfRMrpL0U8I2-pnIRkMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/2/26 18:14, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
>  pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
>  2 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index b66ca9ca7e..d2079e19bc 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -211,6 +211,49 @@ static void init_lists(IplDeviceComponentList *comp_list,
>      cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
>  }
>  
> +static bool is_comp_overlap(SecureIplCompAddrRangeList *range_list,
> +                            SecureIplCompEntryInfo comp_entry_info)
> +{
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +
> +    start_addr = comp_entry_info.addr;
> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
> +
> +    /*
> +     * Check component's address range does not overlap with any
> +     * signed component's address range.
> +     */
> +    for (int i = 0; i < range_list->index; i++) {
> +        if ((range_list->comp_addr_range[i].start_addr < end_addr &&
> +            start_addr < range_list->comp_addr_range[i].end_addr) &&
> +            range_list->comp_addr_range[i].is_signed) {
> +            return true;
> +       }
> +    }
> +    return false;
> +}
> +
> +static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
> +                                SecureIplCompEntryInfo comp_entry_info,
> +                                bool is_signed)
> +{
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +
> +    start_addr = comp_entry_info.addr;
> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
> +
> +    if (range_list->index >= MAX_CERTIFICATES) {
> +        zipl_secure_handle("Component address range update failed due to out-of-range"
> +                           " index; Overlapping validation cannot be guaranteed");
> +    }

On audit mode, you will still attempt to access outside the bounds of
the array.  If the intention is to simply ignore adding more entries to
the list, then make sure to return early.

> +
> +    range_list->comp_addr_range[range_list->index].is_signed = is_signed;
> +    range_list->comp_addr_range[range_list->index].start_addr = start_addr;
> +    range_list->comp_addr_range[range_list->index].end_addr = end_addr;
> +}
> +
>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>  {
>      if (zipl_load_segment(entry, sig_sec) < 0) {
> @@ -253,6 +296,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>       * exists for the certificate).
>       */
>      int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
> +    SecureIplCompAddrRangeList range_list = { 0 };
>      int signed_count = 0;
>  
>      if (!secure_ipl_supported()) {
> @@ -282,14 +326,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>                  goto out;
>              }
>  
> -            if (!sig_len) {
> -                break;
> -            }
> -
>              comp_entry_info = (SecureIplCompEntryInfo){ 0 };
>              comp_entry_info.addr = comp_addr;
>              comp_entry_info.len = (uint64_t)comp_len;
>  
> +            if (is_comp_overlap(&range_list, comp_entry_info)) {
> +                zipl_secure_handle("Component addresses overlap");
> +            }

Seems to be mixed styling here where `is_comp_overlap` is a bool and the
error is handled outside the function, and `comp_addr_range_add` is void
and the error is handled within.

For consistency, I think is_comp_overlap could be check_comp_overlap,
void, and handle the error within.

> +            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
> +            range_list.index += 1;

Index should be incremented within the function.

> +
> +            if (!sig_len) {
> +                break;
> +            }
> +

What is the reason for this check moving here?  If it's intentional for
the check to be at this point in the function, I'd suggest putting in
here in the original patch the code was introduced so it doesn't look
anomalous.

>              verified = verify_signature(comp_entry_info,
>                                          sig_len, (uint64_t)sig,
>                                          &cert_len, &cert_table_idx);
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 6d65cd5596..c625ac2e3a 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
>      uint8_t  flags;
>  } SecureIplCompEntryInfo;
>  
> +typedef struct SecureIplCompAddrRange {
> +    bool is_signed;
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +} SecureIplCompAddrRange;
> +
> +/*
> + * Custom struct for managing a list of secure IPL component address ranges.
> + * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
> + */
> +typedef struct SecureIplCompAddrRangeList {
> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
> +    int index;
> +} SecureIplCompAddrRangeList;
> +
>  static inline void zipl_secure_handle(const char *message)
>  {
>      switch (boot_mode) {


-- 
Regards,
  Collin

