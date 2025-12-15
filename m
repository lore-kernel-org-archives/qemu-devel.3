Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BA0D5B16F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8J4-0004ai-FV; Mon, 15 Dec 2025 08:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8Ix-0004aK-AJ; Mon, 15 Dec 2025 08:08:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8Iu-0001t2-ED; Mon, 15 Dec 2025 08:07:58 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFBNKQq006760;
 Mon, 15 Dec 2025 13:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nesAFX
 mRiyEHNX4NpZS0Lxvie8bJGcFIUzH6WvrjKYs=; b=WmEqd0ER6j6VRKNABXqWvv
 N0t3itl7ti4HchYDFv7T6bGNrPrOw+QqV5BRzxM9UxYAJKd14qj4yLHeQ1MNYx5g
 SsVtouh6CzDHw4U/xia9KWc56B/NLKVYhdWZn46wGiljJIFNqZT4sN9/3dmpRkul
 eEePJSLKjI3aoDNBN9IToecFUCQFLCsdy/UW51SSLGXvNFi48JkPszd7nuWfegiU
 mPHQgfWppYqKh4Si0oXBQDKCYmwgb/jYIaivcEpvrpUP9zn29LBsu2WdshWL4gEP
 pjnj6Fxlb1KXaB3hJH57zyXuwRdupIRQ/cnSUiRa8k7cXGpEPm3FK1OsGZDAyS8g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpsncd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:07:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFD4hM8027707;
 Mon, 15 Dec 2025 13:07:53 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpsncb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:07:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFD4ToT014324;
 Mon, 15 Dec 2025 13:07:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjp5pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:07:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFD7oeN65929700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 13:07:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7320C58057;
 Mon, 15 Dec 2025 13:07:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 280C358058;
 Mon, 15 Dec 2025 13:07:50 +0000 (GMT)
Received: from [9.10.80.79] (unknown [9.10.80.79])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 13:07:50 +0000 (GMT)
Message-ID: <f1900417-7fca-4885-a748-fec12f61b643@linux.ibm.com>
Date: Mon, 15 Dec 2025 07:07:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pnv/psi: Add VMSTATE information to PnvPsi
To: milesg@linux.ibm.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, adityag@linux.ibm.com, npiggin@gmail.com,
 kowal@linux.ibm.com
References: <20251211170012.2220477-1-calebs@linux.ibm.com>
 <7f76d2e8b1a1d6fda09806882bd2ad354840271a.camel@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <7f76d2e8b1a1d6fda09806882bd2ad354840271a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX6K+R2v6TPhE+
 PLGqV2Af+p8NIpDOhJKZdhmYLlqoKyzbH0PAfb7et1k3ez3oJrPhNv968yjxySurds9JyrQzqr4
 Hv6SxT3m7mW/a9CiSXM0lRAB+gBf83w/Q3cUkSn3ZcqaIpH6ICVsXw1qyth1HOj2MfNOSHAd+7E
 bb/1O1MF47S7yMQPc8LXCFeBDc22G9X1h6+656yV2y7KNLVdi7ejcj2DhlznnMm1l7Vg+gHcxqa
 oXkh/h6qnMrMqfI2STdImLQA6kgeSVlBFxVDn87AEbobqilxomgF/AD2xizegyWRYuBynLz9Qly
 flrYAR2BYBVhXo1SwN65tMjduoOrTkUjwDQlxT3SKX/7yx9dsP7gjoQQVJ9qbLwNMLbTfMyKimh
 2zJsxeWaYPcWSS264kyY9BvCfMhwkA==
X-Proofpoint-GUID: -ZGx6hEzfiQ54SeeIb1kGoliGmlLX7f6
X-Proofpoint-ORIG-GUID: aWTtw7a4fwKBNKwONVqkXKbX0PfBS1FI
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69400829 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=NkfvODqGwORNHL9yF2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I can do that, if others agree. I see the commit msg should really be "hw/ppc: ...", so it would fit with the others.

- Caleb

On 12/12/25 11:05 AM, Miles Glenn wrote:
> Caleb, why not add this commit to your other submission of patches
> titled "Snapshot support for several ppc devices"?
> 
> -Glenn
> 
> On Thu, 2025-12-11 at 11:00 -0600, Caleb Schlossin wrote:
>> PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
>> to the device class and a post_load() method to restore dynamic data items and
>> memory region mappings.
>>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>> ---
>>  hw/ppc/pnv_psi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>> index 5d947d8b52..88d5f1d45d 100644
>> --- a/hw/ppc/pnv_psi.c
>> +++ b/hw/ppc/pnv_psi.c
>> @@ -25,6 +25,7 @@
>>  #include "qemu/module.h"
>>  #include "system/reset.h"
>>  #include "qapi/error.h"
>> +#include "migration/vmstate.h"
>>  
>>  
>>  #include "hw/ppc/fdt.h"
>> @@ -35,6 +36,8 @@
>>  
>>  #include <libfdt.h>
>>  
>> +#undef PSI_DEBUG
>> +
>>  #define PSIHB_XSCOM_FIR_RW      0x00
>>  #define PSIHB_XSCOM_FIR_AND     0x01
>>  #define PSIHB_XSCOM_FIR_OR      0x02
>> @@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>>  {
>>      PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
>>      MemoryRegion *sysmem = get_system_memory();
>> -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
>>  
>>      psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
>>  
>>      /* Update MR, always remove it first */
>> -    if (old & PSIHB_BAR_EN) {
>> +    if (memory_region_is_mapped(&psi->regs_mr)) {
>>          memory_region_del_subregion(sysmem, &psi->regs_mr);
>>      }
>>  
>> @@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
>>  
>>  type_init(pnv_psi_register_types);
>>  
>> +#ifdef PSI_DEBUG
>> +static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
>> +                                    GString *buf) {
>> +    uint i, prev_idx = -1;
>> +    uint64_t  reg1, prev_reg1 = -1;
>> +    uint64_t  reg2, prev_reg2 = -1;
>> +    uint64_t  reg3, prev_reg3 = -1;
>> +    uint64_t  reg4, prev_reg4 = -1;
>> +    for (i = 0; i < nr_regs; i = i + 4) {
>> +        /* Don't print if values do not change, but print last*/
>> +        reg1 = regs[i];
>> +        reg2 = regs[i + 1];
>> +        reg3 = regs[i + 2];
>> +        reg4 = regs[i + 3];
>> +        if (reg1 == prev_reg1 && reg2 == prev_reg2 &&
>> +            reg3 == prev_reg3 && reg4 == prev_reg4 &&
>> +            i < (nr_regs - 4)) {
>> +            if (i == (prev_idx + 4)) {
>> +                g_string_append_printf(buf, "        . . .\n");
>> +            }
>> +            continue;
>> +        }
>> +
>> +        g_string_append_printf(buf, "  [%03X] 0x%016lX %016lX %016lX %016lX\n",
>> +            i, reg1, reg2, reg3, reg4);
>> +        prev_idx = i;
>> +        prev_reg1 = reg1;
>> +        prev_reg2 = reg2;
>> +        prev_reg3 = reg3;
>> +        prev_reg4 = reg4;
>> +    }
>> +}
>> +#endif
>> +
>>  void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
>>  {
>>      PnvPsi *psi = PNV_PSI(psi9);
>> @@ -985,4 +1021,10 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
>>      g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
>>                             offset, offset + psi9->source.nr_irqs - 1);
>>      xive_source_pic_print_info(&psi9->source, offset, buf);
>> +#ifdef PSI_DEBUG
>> +    /* Print PSI registers */
>> +    g_string_append_printf(buf, "\nPSI Regs[0x0..%X]\n",
>> +                           PSIHB_XSCOM_MAX);
>> +    psi_regs_pic_print_info(psi->regs, PSIHB_XSCOM_MAX, buf);
>> +#endif
>>  }
> 


