Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68333FB5EAF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 04:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Lzx-000803-7j; Tue, 17 Mar 2026 00:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2Lzv-0007zq-Mz; Tue, 17 Mar 2026 00:25:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2Lzt-0001UP-SI; Tue, 17 Mar 2026 00:25:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H3QPkZ3991856; Tue, 17 Mar 2026 04:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fABXx+
 +o+m3dK50Ev7uWdkLAtbnZ6lTAIXDv2a9n/l0=; b=JQomY0hEAbtAy4krbWaElT
 KT7/D1MkAXUm6oVULSEcF60KhCBrPoNXATcVjp97JQAx+GMc9osotpUtPpcHKUId
 oTz7A11GEeNuulv/MQ+wNHj3ksQ+KVYC/uCQvWJdNnzAHo+DHL0wP6/Es8xPHAZY
 7Y7WNe4HRkeqa1/9Pols7EDbHkeWR7SNqnx7CJx7CUlVon3Kg3DW+H8nLMMDdNsW
 z8v74BHP4fo7PgGUEd42sNbrf1WE5Y9vMnB+lcV4qMPL3ro/jCvo2MdFLLSfAkpP
 uc5KiZ+cs2aMBHVFCDMBvmhpuYvagA0bgI7iivbW0kPiU43Fb/XzFGatCUsRS9/Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs30gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 04:25:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H1Umrc014011;
 Tue, 17 Mar 2026 04:25:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxynke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 04:25:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H4PRhP33817184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 04:25:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E54F5805A;
 Tue, 17 Mar 2026 04:25:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 051C75805E;
 Tue, 17 Mar 2026 04:25:26 +0000 (GMT)
Received: from [9.67.86.225] (unknown [9.67.86.225])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Mar 2026 04:25:25 +0000 (GMT)
Message-ID: <21bf545b-52d4-4aba-898a-a6c99853ce4e@linux.ibm.com>
Date: Tue, 17 Mar 2026 00:25:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-21-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b8d7b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=E5lKPWEJhvkvK4qr4msA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gyvu0FqxETd_GpbfbtSDKvhWTpAyowgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAzMyBTYWx0ZWRfX65Us1kcI17o7
 InuwT2TEB/fuX9iM4tbUkyoMGd9H7MYyIp0ZN3bPXl9LboaNp3ICO9rfHpdL+IWKQg0KzGX+432
 vw5w32ocFWUfBAq1g9WTDsXqIBMwbYPcwkJ4tOYNyQoHOw3CILZAkzDFA1SoH670QGReyIVodsl
 hegzI04mBtL4oxbc4zUuyNXw6zE52s9l/XnJLvNiCUyG7ncv1xPG1y8iQasHbJom0huqnA+G7HX
 7wQNXJalslzfObhHQWU8OuRg/z9t0EcJ58qdMvFxTYbX5segI4nJX6tIpF9ASB9ZJgm7Wm2nrZX
 EhEjxWrt4VG8Ya0L8HBCYfXgo8fLdgdRGrihh6BLAzl6B0HdqWd46OwcRieoV7972evDQBOf5ss
 UbiSTS0q5rpV0AKeiCRxs/pFx0ihT/JAuKvlsvD6zxPLNsNHLOK8+f1euOMIzm3mfTHddmZTfFC
 2TXz4aSmJNb2jVV2A9g==
X-Proofpoint-GUID: gyvu0FqxETd_GpbfbtSDKvhWTpAyowgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/5/26 17:41, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/secure-ipl.c | 52 +++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h |  6 ++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 8d281c1cea..68596491c5 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -211,6 +211,53 @@ static void init_lists(IplDeviceComponentList *comp_list,
>      cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
>  }
>  
> +static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range,
> +                            int addr_range_index,
> +                            uint64_t start_addr, uint64_t end_addr)
> +{
> +    /* neither a signed nor an unsigned component can overlap with a signed component */

How about: "Check component's address range does not overlap with any
signed component's address range."

> +    for (int i = 0; i < addr_range_index; i++) {
> +        if ((comp_addr_range[i].start_addr < end_addr &&
> +            start_addr < comp_addr_range[i].end_addr) &&
> +            comp_addr_range[i].is_signed) {
> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
> +
> +static void comp_addr_range_add(SecureIplCompAddrRange *comp_addr_range,
> +                                int addr_range_index, bool is_signed,
> +                                uint64_t start_addr, uint64_t end_addr)
> +{
> +    if (addr_range_index >= MAX_CERTIFICATES) {
> +        zipl_secure_handle("Component address range update failed due to out-of-range"
> +                           " index; Overlapping validation cannot be guaranteed");
> +    }
> +
> +    comp_addr_range[addr_range_index].is_signed = is_signed;
> +    comp_addr_range[addr_range_index].start_addr = start_addr;
> +    comp_addr_range[addr_range_index].end_addr = end_addr;
> +}
> +
> +static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
> +                               int *addr_range_index,
> +                               uint64_t start_addr, uint64_t end_addr, bool is_signed)
> +{
> +    bool overlap;
> +
> +    overlap = is_comp_overlap(comp_addr_range, *addr_range_index,
> +                              start_addr, end_addr);
> +    if (overlap) {
> +        zipl_secure_handle("Component addresses overlap");
> +    }
> +
> +    comp_addr_range_add(comp_addr_range, *addr_range_index, is_signed,
> +                        start_addr, end_addr);
> +    *addr_range_index += 1;
> +}
> +
>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>  {
>      if (zipl_load_segment(entry, sig_sec) < 0) {
> @@ -254,6 +301,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>       * exists for the certificate).
>       */
>      int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
> +    int addr_range_index = 0;
>      int signed_count = 0;
>  
>      if (!secure_ipl_supported()) {
> @@ -283,6 +332,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>                  goto out;
>              }
>  
> +            addr_overlap_check(comp_addr_range, &addr_range_index,
> +                               comp_addr, comp_addr + comp_len, sig_len > 0);

super nit: I'd prefer !!sig_len versus sig_len > 0.

> +
>              if (!sig_len) {
>                  break;
>              }
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index eb5ba0ed47..69edfce241 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -16,6 +16,12 @@
>  VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>  int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>  
> +typedef struct SecureIplCompAddrRange {
> +    bool is_signed;
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +} SecureIplCompAddrRange;
> +

Since this is a custom construct made for keeping track of address
ranges, why not define your own list data structure that also keeps
track of the index?  Could do:

typedef struct SecureIplCompAddrRangeList {
	SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
	int index;
}

Then you could greatly simplify the function signatures by passing the
list and single entry.  Depending on how reduced the code is after the
changes, it might look better to just do something like this in
zipl_run_secure and get rid of addr_overlap_check:

```
if (is_comp_overlap(list, comp)) {
	zipl_secure_handle("message");
}
comp_addr_range_list_add(list, comp);
```

Would make things look a lot cleaner imho :)

Note: it may make sense to carry this list structure in other areas too
-- it would help keep track of the respective list indexes and result in
less variables passed around.

>  static inline void zipl_secure_handle(const char *message)
>  {
>      switch (boot_mode) {


-- 
Regards,
  Collin

