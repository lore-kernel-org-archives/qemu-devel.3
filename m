Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D46CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr05E-0007mi-TN; Wed, 18 Sep 2024 15:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sr05B-0007lP-8v; Wed, 18 Sep 2024 15:11:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sr057-00067V-Uv; Wed, 18 Sep 2024 15:11:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEZ79N001239;
 Wed, 18 Sep 2024 17:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=8
 nX2AsKR0KkvToecjjOSXWu8dEJnXQP2wNpUQqBWUd8=; b=sNa3ajbDqbee3ETQ3
 UI5jQ6EseU2Ldcx8iiONzVx+UNOE6nvqo3ZBwBAuPW2fXYniCexhF9a88mIqsXTj
 YoOQdeCs9CaNhijUUCbutCuXiKsdOOn+04N37GAjYGK3GkRNPkSH+sB/YYDrmHcV
 tIGQwEEYIJQjaRtMEEvk11VzJvBDLyOlArE2qBIOgwPEtu/Iu4IBCWqm11RSFTxu
 g+5D5ae9T4FZCv6IaihjJ7L3BdIG9sGl0CDm0E4A4klgyxHPOODABFEYAmQGwzYj
 ql1J3RxbyxI6oumCzzM5Jl1yAj0mGjfpkEbG3HZwI8+HpJdGaxG3D35wPteYRPYa
 atGHg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ujf7ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 17:09:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48IH904R028421;
 Wed, 18 Sep 2024 17:09:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ujf7ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 17:09:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48IFnkGZ000620;
 Wed, 18 Sep 2024 17:08:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn71ck6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 17:08:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48IH8tCu41615724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 17:08:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D5CE58064;
 Wed, 18 Sep 2024 17:08:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26D1958062;
 Wed, 18 Sep 2024 17:08:55 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2024 17:08:55 +0000 (GMT)
Message-ID: <5eca0fa0-7925-47c3-a857-34f500f98312@linux.ibm.com>
Date: Wed, 18 Sep 2024 12:08:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add XIVE tests for the powernv10 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240916182311.30522-1-kowal@linux.ibm.com>
 <475a7b69-d0ee-4acf-88c9-64ac03864fe5@redhat.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <475a7b69-d0ee-4acf-88c9-64ac03864fe5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _WL330NMT5I4UfhW6hbSXOg8qy-6gzZs
X-Proofpoint-GUID: 4AYu_cdJF4WMJk67z-rOHTQ1k0bst1Jz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 9/18/2024 10:05 AM, Thomas Huth wrote:
> On 16/09/2024 20.23, Michael Kowal wrote:
>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>> These XIVE tests include:
>> - General interrupt IRQ tests that:
>>    - enable and trigger an interrupt
>>    - acknowledge the interrupt
>>    - end of interrupt processing
>> - Test the Pull Thread Context to Odd Thread Reporting Line
>> - Test the different cache flush inject and queue sync inject operations
>>
>> Co-authored-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> Co-authored-by: Glenn Miles <milesg@linux.ibm.com>
>> Co-authored-by: Michael Kowal <kowal@linux.ibm.com>
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   MAINTAINERS                        |   3 +-
>>   tests/qtest/pnv-xive2-common.h     | 246 ++++++++++++++++++++
>>   tests/qtest/pnv-xive2-flush-sync.h | 194 ++++++++++++++++
>>   tests/qtest/pnv-xive2-test.c       | 351 +++++++++++++++++++++++++++++
>>   tests/qtest/meson.build            |   1 +
>>   5 files changed, 794 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/pnv-xive2-common.h
>>   create mode 100644 tests/qtest/pnv-xive2-flush-sync.h
>>   create mode 100644 tests/qtest/pnv-xive2-test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ffacd60f40..f410dc1714 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2660,6 +2660,7 @@ L: qemu-ppc@nongnu.org
>>   S: Odd Fixes
>>   F: hw/*/*xive*
>>   F: include/hw/*/*xive*
>> +F: tests/qtest/*xive*
>>   F: docs/*/*xive*
>>     Renesas peripherals
>> @@ -3326,7 +3327,7 @@ R: Paolo Bonzini <pbonzini@redhat.com>
>>   R: Bandan Das <bsd@redhat.com>
>>   R: Stefan Hajnoczi <stefanha@redhat.com>
>>   R: Thomas Huth <thuth@redhat.com>
>> -R: Darren Kenny <darren.kenny@oracle.com>
>> +R: Darren Kenny <darren.kenny@oracle.com>
>
> Please drop this hunk.


It looks like there was some white space at the end of the line that 
shouldn't have been there.  And I am guessing that my editor 
automatically removed it when editing the file.  If you prefer I can add 
it back in and will look into disabling this 'feature'...

MAK


>
>>   R: Qiuhao Li <Qiuhao.Li@outlook.com>
>>   S: Maintained
>>   F: tests/qtest/fuzz/
>> diff --git a/tests/qtest/pnv-xive2-common.h 
>> b/tests/qtest/pnv-xive2-common.h
>> new file mode 100644
>> index 0000000000..66647686ee
>> --- /dev/null
>> +++ b/tests/qtest/pnv-xive2-common.h
>> @@ -0,0 +1,246 @@
>
> Please add at least a SPDX-License line with the license information.
>
>> +#ifndef TEST_PNV_XIVE2_COMMON_H
>> +#define TEST_PNV_XIVE2_COMMON_H
>> +
>> +/*
>> + * sizing:
>> + * 128 interrupts
>> + *   => ESB BAR range: 16M
>> + * 256 ENDs
>> + *   => END BAR range: 16M
>> + * 256 VPs
>> + *   => NVPG,NVC BAR range: 32M
>> + */
>> +#define MAX_IRQS                128
>> +#define MAX_ENDS                256
>> +#define MAX_VPS                 256
> ...
>> +static void get_struct(QTestState *qts, uint64_t src, void *dest, 
>> size_t size)
>> +{
>> +    uint8_t *destination = (uint8_t *)dest;
>> +    size_t i;
>> +
>> +    for (i = 0; i < size; i++) {
>> +        *(destination + i) = qtest_readb(qts, src + i);
>> +    }
>> +}
>> +
>> +static void copy_struct(QTestState *qts, void *src, uint64_t dest, 
>> size_t size)
>> +{
>> +    uint8_t *source = (uint8_t *)src;
>> +    size_t i;
>> +
>> +    for (i = 0; i < size; i++) {
>> +        qtest_writeb(qts, dest + i, *(source + i));
>> +    }
>> +}
>> +
>> +static uint64_t get_queue_addr(uint32_t end_index)
>> +{
>> +    return XIVE_QUEUE_MEM + end_index * XIVE_QUEUE_SIZE;
>> +}
>> +
>> +static uint8_t get_esb(QTestState *qts, uint32_t index, uint8_t page,
>> +                       uint32_t offset)
>> +{
>> +    uint64_t addr;
>> +
>> +    addr = XIVE_ESB_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
>> +    if (page == 1) {
>> +        addr += 1 << XIVE_PAGE_SHIFT;
>> +    }
>> +    return qtest_readb(qts, addr + offset);
>> +}
>> +
>> +static void set_esb(QTestState *qts, uint32_t index, uint8_t page,
>> +                    uint32_t offset, uint32_t val)
>> +{
>> +    uint64_t addr;
>> +
>> +    addr = XIVE_ESB_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
>> +    if (page == 1) {
>> +        addr += 1 << XIVE_PAGE_SHIFT;
>> +    }
>> +    return qtest_writel(qts, addr + offset, cpu_to_be32(val));
>> +}
>> +
>> +static void get_nvp(QTestState *qts, uint32_t index, Xive2Nvp* nvp)
>> +{
>> +    uint64_t addr = XIVE_NVP_MEM + index * sizeof(Xive2Nvp);
>> +    get_struct(qts, addr, nvp, sizeof(Xive2Nvp));
>> +}
>> +
>> +static uint64_t get_cl_pair_addr(Xive2Nvp *nvp)
>> +{
>> +    uint64_t upper = xive_get_field32(0x0fffffff, nvp->w6);
>> +    uint64_t lower = xive_get_field32(0xffffff00, nvp->w7);
>> +    return (upper << 32) | (lower << 8);
>> +}
>> +
>> +static void set_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t 
>> *cl_pair)
>> +{
>> +    uint64_t addr = get_cl_pair_addr(nvp);
>> +    copy_struct(qts, cl_pair, addr, XIVE_REPORT_SIZE);
>> +}
>> +
>> +static void get_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t 
>> *cl_pair)
>> +{
>> +    uint64_t addr = get_cl_pair_addr(nvp);
>> +    get_struct(qts, addr, cl_pair, XIVE_REPORT_SIZE);
>> +}
>> +
>> +static void set_nvp(QTestState *qts, uint32_t index, uint8_t first)
>> +{
>> +    uint64_t nvp_addr;
>> +    Xive2Nvp nvp;
>> +    uint64_t report_addr;
>> +
>> +    nvp_addr = XIVE_NVP_MEM + index * sizeof(Xive2Nvp);
>> +    report_addr = (XIVE_REPORT_MEM + index * XIVE_REPORT_SIZE) >> 8;
>> +
>> +    memset(&nvp, 0, sizeof(nvp));
>> +    nvp.w0 = xive_set_field32(NVP2_W0_VALID, 0, 1);
>> +    nvp.w0 = xive_set_field32(NVP2_W0_PGOFIRST, nvp.w0, first);
>> +    nvp.w6 = xive_set_field32(NVP2_W6_REPORTING_LINE, nvp.w6,
>> +                              (report_addr >> 24) & 0xfffffff);
>> +    nvp.w7 = xive_set_field32(NVP2_W7_REPORTING_LINE, nvp.w7,
>> +                              report_addr & 0xffffff);
>> +    copy_struct(qts, &nvp, nvp_addr, sizeof(nvp));
>> +}
>> +
>> +static void set_nvg(QTestState *qts, uint32_t index, uint8_t next)
>> +{
>> +    uint64_t nvg_addr;
>> +    Xive2Nvgc nvg;
>> +
>> +    nvg_addr = XIVE_NVG_MEM + index * sizeof(Xive2Nvgc);
>> +
>> +    memset(&nvg, 0, sizeof(nvg));
>> +    nvg.w0 = xive_set_field32(NVGC2_W0_VALID, 0, 1);
>> +    nvg.w0 = xive_set_field32(NVGC2_W0_PGONEXT, nvg.w0, next);
>> +    copy_struct(qts, &nvg, nvg_addr, sizeof(nvg));
>> +}
>> +
>> +static void set_eas(QTestState *qts, uint32_t index, uint32_t 
>> end_index,
>> +                    uint32_t data)
>> +{
>> +    uint64_t eas_addr;
>> +    Xive2Eas eas;
>> +
>> +    eas_addr = XIVE_EAS_MEM + index * sizeof(Xive2Eas);
>> +
>> +    memset(&eas, 0, sizeof(eas));
>> +    eas.w = xive_set_field64(EAS2_VALID, 0, 1);
>> +    eas.w = xive_set_field64(EAS2_END_INDEX, eas.w, end_index);
>> +    eas.w = xive_set_field64(EAS2_END_DATA, eas.w, data);
>> +    copy_struct(qts, &eas, eas_addr, sizeof(eas));
>> +}
>> +
>> +static void set_end(QTestState *qts, uint32_t index, uint32_t 
>> nvp_index,
>> +                    uint8_t priority, bool i)
>> +{
>> +    uint64_t end_addr, queue_addr, queue_hi, queue_lo;
>> +    uint8_t queue_size;
>> +    Xive2End end;
>> +
>> +    end_addr = XIVE_END_MEM + index * sizeof(Xive2End);
>> +    queue_addr = get_queue_addr(index);
>> +    queue_hi = (queue_addr >> 32) & END2_W2_EQ_ADDR_HI;
>> +    queue_lo = queue_addr & END2_W3_EQ_ADDR_LO;
>> +    queue_size = __builtin_ctz(XIVE_QUEUE_SIZE) - 12;
>> +
>> +    memset(&end, 0, sizeof(end));
>> +    end.w0 = xive_set_field32(END2_W0_VALID, 0, 1);
>> +    end.w0 = xive_set_field32(END2_W0_ENQUEUE, end.w0, 1);
>> +    end.w0 = xive_set_field32(END2_W0_UCOND_NOTIFY, end.w0, 1);
>> +    end.w0 = xive_set_field32(END2_W0_BACKLOG, end.w0, 1);
>> +
>> +    end.w1 = xive_set_field32(END2_W1_GENERATION, 0, 1);
>> +
>> +    end.w2 = cpu_to_be32(queue_hi);
>> +
>> +    end.w3 = cpu_to_be32(queue_lo);
>> +    end.w3 = xive_set_field32(END2_W3_QSIZE, end.w3, queue_size);
>> +
>> +    end.w6 = xive_set_field32(END2_W6_IGNORE, 0, i);
>> +    end.w6 = xive_set_field32(END2_W6_VP_OFFSET, end.w6, nvp_index);
>> +
>> +    end.w7 = xive_set_field32(END2_W7_F0_PRIORITY, 0, priority);
>> +    copy_struct(qts, &end, end_addr, sizeof(end));
>> +}
>
> Are you going to re-use all these functions in other .c files later? 
> If yes, please don't use such generic names like "copy_struct()" for 
> functions in header files. Otherwise, please put this stuff into the 
> .c file instead (at least the last functions are rather big already, 
> so they don't look like good candidate for inlineable functions from a 
> header anyway).


I can rename or re-factor the use of copy_struct().

Many of these other function will be used by the other tests which is 
why they are in this common .h file.

MAK


>> +#endif /* TEST_PNV_XIVE2_COMMON_H */
>> diff --git a/tests/qtest/pnv-xive2-flush-sync.h 
>> b/tests/qtest/pnv-xive2-flush-sync.h
>> new file mode 100644
>> index 0000000000..21d18ad9a7
>> --- /dev/null
>> +++ b/tests/qtest/pnv-xive2-flush-sync.h
>
> Please add at least a short license statement here, too.
>
>> @@ -0,0 +1,194 @@
>> +#ifndef TEST_PNV_XIVE2_FLUSH_SYNC_H
>> +#define TEST_PNV_XIVE2_FLUSH_SYNC_H
>> +
>> +#include "pnv-xive2-common.h"
>> +
>> +#define PNV_XIVE2_QUEUE_IPI              0x00
>> +#define PNV_XIVE2_QUEUE_HW               0x01
>> +#define PNV_XIVE2_QUEUE_NXC              0x02
>> +#define PNV_XIVE2_QUEUE_INT              0x03
>> +#define PNV_XIVE2_QUEUE_OS               0x04
>> +#define PNV_XIVE2_QUEUE_POOL             0x05
>> +#define PNV_XIVE2_QUEUE_HARD             0x06
>> +#define PNV_XIVE2_CACHE_ENDC             0x08
>> +#define PNV_XIVE2_CACHE_ESBC             0x09
>> +#define PNV_XIVE2_CACHE_EASC             0x0a
>> +#define PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO   0x10
>> +#define PNV_XIVE2_QUEUE_NXC_LD_LCL_CO    0x11
>> +#define PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI   0x12
>> +#define PNV_XIVE2_QUEUE_NXC_ST_LCL_CI    0x13
>> +#define PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI   0x14
>> +#define PNV_XIVE2_QUEUE_NXC_ST_RMT_CI    0x15
>> +#define PNV_XIVE2_CACHE_NXC              0x18
>> +
>> +#define PNV_XIVE2_SYNC_IPI              0x000
>> +#define PNV_XIVE2_SYNC_HW               0x080
>> +#define PNV_XIVE2_SYNC_NxC              0x100
>> +#define PNV_XIVE2_SYNC_INT              0x180
>> +#define PNV_XIVE2_SYNC_OS_ESC           0x200
>> +#define PNV_XIVE2_SYNC_POOL_ESC         0x280
>> +#define PNV_XIVE2_SYNC_HARD_ESC         0x300
>> +#define PNV_XIVE2_SYNC_NXC_LD_LCL_NCO   0x800
>> +#define PNV_XIVE2_SYNC_NXC_LD_LCL_CO    0x880
>> +#define PNV_XIVE2_SYNC_NXC_ST_LCL_NCI   0x900
>> +#define PNV_XIVE2_SYNC_NXC_ST_LCL_CI    0x980
>> +#define PNV_XIVE2_SYNC_NXC_ST_RMT_NCI   0xA00
>> +#define PNV_XIVE2_SYNC_NXC_ST_RMT_CI    0xA80
>> +
>> +static uint64_t get_sync_addr(uint32_t src_pir, int ic_topo_id, int 
>> type)
>> +{
>> +    int thread_nr = src_pir & 0x7f;
>> +    uint64_t addr = XIVE_SYNC_MEM +  thread_nr * 512 + ic_topo_id * 
>> 32 + type;
>> +    return addr;
>> +}
>> +
>> +static uint8_t get_sync(QTestState *qts, uint32_t src_pir, int 
>> ic_topo_id,
>> +                        int type)
>> +{
>> +    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
>> +    return qtest_readb(qts, addr);
>> +}
>> +
>> +static void clr_sync(QTestState *qts, uint32_t src_pir, int ic_topo_id,
>> +                        int type)
>> +{
>> +    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
>> +    qtest_writeb(qts, addr, 0x0);
>> +}
>> +
>> +static void inject_cache_flush(QTestState *qts, int ic_topo_id,
>> +                               uint64_t scom_addr)
>> +{
>> +    (void)ic_topo_id;
>> +    pnv_xive_xscom_write(qts, scom_addr, 0);
>> +}
>> +
>> +static void inject_queue_sync(QTestState *qts, int ic_topo_id, 
>> uint64_t offset)
>> +{
>> +    (void)ic_topo_id;
>> +    uint64_t addr = XIVE_IC_ADDR + (VST_SYNC << XIVE_PAGE_SHIFT) + 
>> offset;
>> +    qtest_writeq(qts, addr, 0);
>> +}
>> +
>> +static void inject_op(QTestState *qts, int ic_topo_id, int type)
>> +{
>> +    switch (type) {
>> +    case PNV_XIVE2_QUEUE_IPI:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_IPI);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_HW:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HW);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NxC);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_INT:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_INT);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_OS:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_OS_ESC);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_POOL:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_POOL_ESC);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_HARD:
>> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HARD_ESC);
>> +        break;
>> +    case PNV_XIVE2_CACHE_ENDC:
>> +        inject_cache_flush(qts, ic_topo_id, X_VC_ENDC_FLUSH_INJECT);
>> +        break;
>> +    case PNV_XIVE2_CACHE_ESBC:
>> +        inject_cache_flush(qts, ic_topo_id, X_VC_ESBC_FLUSH_INJECT);
>> +        break;
>> +    case PNV_XIVE2_CACHE_EASC:
>> +        inject_cache_flush(qts, ic_topo_id, X_VC_EASC_FLUSH_INJECT);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_LD_LCL_NCO);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_LD_LCL_CO:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_LD_LCL_CO);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_ST_LCL_NCI);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_ST_LCL_CI:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_ST_LCL_CI);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_ST_RMT_NCI);
>> +        break;
>> +    case PNV_XIVE2_QUEUE_NXC_ST_RMT_CI:
>> +        inject_queue_sync(qts, ic_topo_id, 
>> PNV_XIVE2_SYNC_NXC_ST_RMT_CI);
>> +        break;
>> +    case PNV_XIVE2_CACHE_NXC:
>> +        inject_cache_flush(qts, ic_topo_id, X_PC_NXC_FLUSH_INJECT);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +        break;
>> +    }
>> +}
>> +
>> +const uint8_t xive_inject_tests[] = {
>> +    PNV_XIVE2_QUEUE_IPI,
>> +    PNV_XIVE2_QUEUE_HW,
>> +    PNV_XIVE2_QUEUE_NXC,
>> +    PNV_XIVE2_QUEUE_INT,
>> +    PNV_XIVE2_QUEUE_OS,
>> +    PNV_XIVE2_QUEUE_POOL,
>> +    PNV_XIVE2_QUEUE_HARD,
>> +    PNV_XIVE2_CACHE_ENDC,
>> +    PNV_XIVE2_CACHE_ESBC,
>> +    PNV_XIVE2_CACHE_EASC,
>> +    PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO,
>> +    PNV_XIVE2_QUEUE_NXC_LD_LCL_CO,
>> +    PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI,
>> +    PNV_XIVE2_QUEUE_NXC_ST_LCL_CI,
>> +    PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI,
>> +    PNV_XIVE2_QUEUE_NXC_ST_RMT_CI,
>> +    PNV_XIVE2_CACHE_NXC,
>> +};
>> +
>> +static void test_flush_sync_inject(QTestState *qts)
>> +{
>> +    int ic_topo_id = 0;
>> +
>> +    /*
>> +     * Writes performed by qtest are not done in the context of a 
>> thread.
>> +     * This means that QEMU XIVE code doesn't have a way to 
>> determine what
>> +     * thread is originating the write.  In order to allow for some 
>> testing,
>> +     * QEMU XIVE code will assume a PIR of 0 when unable to 
>> determine the
>> +     * source thread for cache flush and queue sync inject operations.
>> +     * See hw/intc/pnv_xive2.c: pnv_xive2_inject_notify() for details.
>> +     */
>> +    int src_pir = 0;
>> +    int test_nr;
>> +    uint8_t byte;
>> +
>> +    printf("# 
>> ============================================================\n");
>> +    printf("# Starting cache flush/queue sync injection tests...\n");
>> +
>> +    for (test_nr = 0; test_nr < sizeof(xive_inject_tests);
>> +         test_nr++) {
>> +        int op_type = xive_inject_tests[test_nr];
>> +
>> +        printf("# Running test %d\n", test_nr);
>> +
>> +        /* start with status byte set to 0 */
>> +        clr_sync(qts, src_pir, ic_topo_id, op_type);
>> +        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
>> +        g_assert_cmphex(byte, ==, 0);
>> +
>> +        /* request cache flush or queue sync operation */
>> +        inject_op(qts, ic_topo_id, op_type);
>> +
>> +        /* verify that status byte was written to 0xff */
>> +        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
>> +        g_assert_cmphex(byte, ==, 0xff);
>> +
>> +        clr_sync(qts, src_pir, ic_topo_id, op_type);
>> +    }
>> +}
>
> That also does not look like proper content for a header file. Please 
> put it into a .c file instead.


When these test were originally written, the authors had all of the 
tests and their functions in one .c file.  Some thought it was too large 
and confusing and I separated the different test functions into separate 
.h files (and including .c files is not typically done).   I suppose I 
could have the different functions as individual qtests, opposed  to one 
XIVE test...   And I couldn't find an example multiple qtest .c files 
compiled and linked together into one qtest.

MAK


>
>> +#endif /* TEST_PNV_XIVE2_FLUSH_SYNC_H */
>> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
>> new file mode 100644
>> index 0000000000..471512dccd
>> --- /dev/null
>> +++ b/tests/qtest/pnv-xive2-test.c
>> @@ -0,0 +1,351 @@
>> +/*
>> + * QTest testcase for PowerNV 10 interrupt controller (xive2)
>> + *
>> + * Copyright (c) 2023, IBM Corporation.
>
> Maybe update to 2024 ?
>
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> +A * later. See the COPYING file in the top-level directory.
>
> Misplaced "A" at the beginning of the line.
>
>  Thomas
>

