Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B627C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWh-0000Qo-Fn; Tue, 16 Jul 2024 11:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sTkWV-000087-L7; Tue, 16 Jul 2024 11:55:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sTkWQ-0007U5-3x; Tue, 16 Jul 2024 11:55:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GFSoba016846;
 Tue, 16 Jul 2024 15:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=I
 WZlbb7Jjkt3qxxUKY3RW0SXa1keM5tb2K+makqDvfk=; b=CcCrtPItPPdTKf8zy
 bWi2U7c3iUfAAYuzNs637VuqReejW4cSqJMgOb7a8FIo80a273aggq49Cp4WRf6g
 6vu+/KxSenhyowoQopfV9y/4ApH9X8R7nLWTVZX0TAQTp+Edqsr2xq23JkT1QVDA
 dKFL5lJkmNCtOvueu4mAghzXV0fqAcGQOEtGIU5fEUKpTFnL9rQymmSymd3/uN8G
 WVmt3XfjBEFBTXfTiyc9Gu5hacy4KHKD3JsMYh/+wQQxqlyaLgGB3bfGkrylELLt
 s9JYlo6eRbkkn7RwYKC8XRvI8aaduplZk2ZqxchGeSQEaNBMmVZJFqUPTYTnB9Cs
 MjDug==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40duhhg1nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 15:55:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GFtCHa022713;
 Tue, 16 Jul 2024 15:55:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40duhhg1np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 15:55:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GDrNwM014947; Tue, 16 Jul 2024 15:55:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4wpcpr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 15:55:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GFt8RJ7013080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 15:55:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCB2358051;
 Tue, 16 Jul 2024 15:55:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 747A958075;
 Tue, 16 Jul 2024 15:55:06 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 15:55:06 +0000 (GMT)
Message-ID: <a4c816a1-5a51-4b53-a70a-7a68af8d9e8a@linux.ibm.com>
Date: Tue, 16 Jul 2024 10:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync
 Injection support
From: Mike Kowal <kowal@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
 <20240715183332.27287-2-kowal@linux.vnet.ibm.com>
 <a2e4ac6a-f585-4f52-81d7-5a85858f5fd9@kaod.org>
 <5e504c64-58eb-4f9f-aeb2-7fb390b19fb0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5e504c64-58eb-4f9f-aeb2-7fb390b19fb0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4DRX3oehDMvgqkrd9vTHVuObVfBXCNmc
X-Proofpoint-ORIG-GUID: RkRZABedZ79axXg3o8LE7qI5tWcn2MhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407160117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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


On 7/16/2024 10:32 AM, Mike Kowal wrote:
>
> On 7/16/2024 2:28 AM, Cédric Le Goater wrote:
>> On 7/15/24 20:33, Michael Kowal wrote:
>>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>>
>>> XIVE offers a 'cache watch facility', which allows software to 
>>> read/update
>>> a potentially cached table entry with no software lock. There's one 
>>> such
>>> facility in the Virtualization Controller (VC) to update the ESB and 
>>> END
>>> entries and one in the Presentation Controller (PC) to update the
>>> NVP/NVG/NVC entries.
>>>
>>> Each facility has 4 cache watch engines to control the updates and
>>> firmware can request an available engine by querying the hardware
>>> 'watch_assign' register of the VC or PC. The engine is then reserved 
>>> and
>>> is released after the data is updated by reading the 'watch_spec' 
>>> register
>>> (which also allows to check for a conflict during the update).
>>> If no engine is available, the special value 0xFF is returned and
>>> firmware is expected to repeat the request until an engine becomes
>>> available.
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
>>> ---
>>>   hw/intc/pnv_xive2_regs.h |  90 ++++++++++++++
>>>   hw/intc/pnv_xive2.c      | 253 
>>> +++++++++++++++++++++++++++++++++------
>>>   2 files changed, 307 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
>>> index 7165dc8704..f8e4a677c6 100644
>>> --- a/hw/intc/pnv_xive2_regs.h
>>> +++ b/hw/intc/pnv_xive2_regs.h
>>> @@ -283,6 +283,15 @@
>>>   #define   VC_ENDC_SYNC_QUEUE_HARD               PPC_BIT(6)
>>>   #define   VC_QUEUE_COUNT                        7
>>>   +/* ENDC cache watch assign */
>>> +#define X_VC_ENDC_WATCH_ASSIGN                  0x186
>>> +#define VC_ENDC_WATCH_ASSIGN                    0x430
>>> +
>>> +/* ENDC configuration register */
>>> +#define X_VC_ENDC_CFG                           0x188
>>> +#define VC_ENDC_CFG                             0x440
>>> +#define   VC_ENDC_CFG_CACHE_WATCH_ASSIGN PPC_BITMASK(32, 35)
>>> +
>>>   /* ENDC cache watch specification 0  */
>>>   #define X_VC_ENDC_WATCH0_SPEC                   0x1A0
>>>   #define VC_ENDC_WATCH0_SPEC                     0x500
>>> @@ -302,6 +311,42 @@
>>>   #define VC_ENDC_WATCH0_DATA2                    0x530
>>>   #define VC_ENDC_WATCH0_DATA3                    0x538
>>>   +/* ENDC cache watch 1  */
>>> +#define X_VC_ENDC_WATCH1_SPEC                   0x1A8
>>> +#define VC_ENDC_WATCH1_SPEC                     0x540
>>> +#define X_VC_ENDC_WATCH1_DATA0                  0x1AC
>>> +#define X_VC_ENDC_WATCH1_DATA1                  0x1AD
>>> +#define X_VC_ENDC_WATCH1_DATA2                  0x1AE
>>> +#define X_VC_ENDC_WATCH1_DATA3                  0x1AF
>>> +#define VC_ENDC_WATCH1_DATA0                    0x560
>>> +#define VC_ENDC_WATCH1_DATA1                    0x568
>>> +#define VC_ENDC_WATCH1_DATA2                    0x570
>>> +#define VC_ENDC_WATCH1_DATA3                    0x578
>>> +
>>> +/* ENDC cache watch 2  */
>>> +#define X_VC_ENDC_WATCH2_SPEC                   0x1B0
>>> +#define VC_ENDC_WATCH2_SPEC                     0x580
>>> +#define X_VC_ENDC_WATCH2_DATA0                  0x1B4
>>> +#define X_VC_ENDC_WATCH2_DATA1                  0x1B5
>>> +#define X_VC_ENDC_WATCH2_DATA2                  0x1B6
>>> +#define X_VC_ENDC_WATCH2_DATA3                  0x1B7
>>> +#define VC_ENDC_WATCH2_DATA0                    0x5A0
>>> +#define VC_ENDC_WATCH2_DATA1                    0x5A8
>>> +#define VC_ENDC_WATCH2_DATA2                    0x5B0
>>> +#define VC_ENDC_WATCH2_DATA3                    0x5B8
>>> +
>>> +/* ENDC cache watch 3  */
>>> +#define X_VC_ENDC_WATCH3_SPEC                   0x1B8
>>> +#define VC_ENDC_WATCH3_SPEC                     0x5C0
>>> +#define X_VC_ENDC_WATCH3_DATA0                  0x1BC
>>> +#define X_VC_ENDC_WATCH3_DATA1                  0x1BD
>>> +#define X_VC_ENDC_WATCH3_DATA2                  0x1BE
>>> +#define X_VC_ENDC_WATCH3_DATA3                  0x1BF
>>> +#define VC_ENDC_WATCH3_DATA0                    0x5E0
>>> +#define VC_ENDC_WATCH3_DATA1                    0x5E8
>>> +#define VC_ENDC_WATCH3_DATA2                    0x5F0
>>> +#define VC_ENDC_WATCH3_DATA3                    0x5F8
>>> +
>>>   /*
>>>    * PC LSB1
>>>    */
>>> @@ -358,6 +403,15 @@
>>>   #define  PC_NXC_FLUSH_POLL_BLOCK_ID_MASK PPC_BITMASK(36, 39)
>>>   #define  PC_NXC_FLUSH_POLL_OFFSET_MASK PPC_BITMASK(40, 63) /* 
>>> 24-bit */
>>>   +/* NxC Cache watch assign */
>>> +#define X_PC_NXC_WATCH_ASSIGN                   0x286
>>> +#define PC_NXC_WATCH_ASSIGN                     0x430
>>> +
>>> +/* NxC Proc config */
>>> +#define X_PC_NXC_PROC_CONFIG                    0x28A
>>> +#define PC_NXC_PROC_CONFIG                      0x450
>>> +#define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN PPC_BITMASK(0, 3)
>>> +
>>>   /* NxC Cache Watch 0 Specification */
>>>   #define X_PC_NXC_WATCH0_SPEC                    0x2A0
>>>   #define PC_NXC_WATCH0_SPEC                      0x500
>>> @@ -381,6 +435,42 @@
>>>   #define PC_NXC_WATCH0_DATA2                     0x530
>>>   #define PC_NXC_WATCH0_DATA3                     0x538
>>>   +/* NxC Cache Watch 1 */
>>> +#define X_PC_NXC_WATCH1_SPEC                    0x2A8
>>> +#define PC_NXC_WATCH1_SPEC                      0x540
>>> +#define X_PC_NXC_WATCH1_DATA0                   0x2AC
>>> +#define X_PC_NXC_WATCH1_DATA1                   0x2AD
>>> +#define X_PC_NXC_WATCH1_DATA2                   0x2AE
>>> +#define X_PC_NXC_WATCH1_DATA3                   0x2AF
>>> +#define PC_NXC_WATCH1_DATA0                     0x560
>>> +#define PC_NXC_WATCH1_DATA1                     0x568
>>> +#define PC_NXC_WATCH1_DATA2                     0x570
>>> +#define PC_NXC_WATCH1_DATA3                     0x578
>>> +
>>> +/* NxC Cache Watch 2 */
>>> +#define X_PC_NXC_WATCH2_SPEC                    0x2B0
>>> +#define PC_NXC_WATCH2_SPEC                      0x580
>>> +#define X_PC_NXC_WATCH2_DATA0                   0x2B4
>>> +#define X_PC_NXC_WATCH2_DATA1                   0x2B5
>>> +#define X_PC_NXC_WATCH2_DATA2                   0x2B6
>>> +#define X_PC_NXC_WATCH2_DATA3                   0x2B7
>>> +#define PC_NXC_WATCH2_DATA0                     0x5A0
>>> +#define PC_NXC_WATCH2_DATA1                     0x5A8
>>> +#define PC_NXC_WATCH2_DATA2                     0x5B0
>>> +#define PC_NXC_WATCH2_DATA3                     0x5B8
>>> +
>>> +/* NxC Cache Watch 3 */
>>> +#define X_PC_NXC_WATCH3_SPEC                    0x2B8
>>> +#define PC_NXC_WATCH3_SPEC                      0x5C0
>>> +#define X_PC_NXC_WATCH3_DATA0                   0x2BC
>>> +#define X_PC_NXC_WATCH3_DATA1                   0x2BD
>>> +#define X_PC_NXC_WATCH3_DATA2                   0x2BE
>>> +#define X_PC_NXC_WATCH3_DATA3                   0x2BF
>>> +#define PC_NXC_WATCH3_DATA0                     0x5E0
>>> +#define PC_NXC_WATCH3_DATA1                     0x5E8
>>> +#define PC_NXC_WATCH3_DATA2                     0x5F0
>>> +#define PC_NXC_WATCH3_DATA3                     0x5F8
>>> +
>>>   /*
>>>    * TCTXT Registers
>>>    */
>>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>>> index 2fb4fa29d4..f6a735cca5 100644
>>> --- a/hw/intc/pnv_xive2.c
>>> +++ b/hw/intc/pnv_xive2.c
>>> @@ -329,40 +329,48 @@ static int pnv_xive2_write_end(Xive2Router 
>>> *xrtr, uint8_t blk, uint32_t idx,
>>>                                 word_number);
>>>   }
>>>   -static int pnv_xive2_end_update(PnvXive2 *xive)
>>> +static int pnv_xive2_end_update(PnvXive2 *xive, uint8_t watch_engine)
>>>   {
>>> -    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>>> -    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>>> -    int i;
>>> +    uint8_t  blk;
>>> +    uint32_t idx;
>>> +    int i, spec_reg, data_reg;
>>>       uint64_t endc_watch[4];
>>>   +    assert(watch_engine < ARRAY_SIZE(endc_watch));
>>> +
>>> +    spec_reg = (VC_ENDC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>>> +    data_reg = (VC_ENDC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>>> +    blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID, xive->vc_regs[spec_reg]);
>>> +    idx = GETFIELD(VC_ENDC_WATCH_INDEX, xive->vc_regs[spec_reg]);
>>> +
>>>       for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>>> -        endc_watch[i] =
>>> - cpu_to_be64(xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + i]);
>>> +        endc_watch[i] = cpu_to_be64(xive->vc_regs[data_reg + i]);
>>>       }
>>>         return pnv_xive2_vst_write(xive, VST_END, blk, idx, endc_watch,
>>>                                 XIVE_VST_WORD_ALL);
>>>   }
>>>   -static void pnv_xive2_end_cache_load(PnvXive2 *xive)
>>> +static void pnv_xive2_end_cache_load(PnvXive2 *xive, uint8_t 
>>> watch_engine)
>>>   {
>>> -    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>>> -    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>>> +    uint8_t  blk;
>>> +    uint32_t idx;
>>>       uint64_t endc_watch[4] = { 0 };
>>> -    int i;
>>> +    int i, spec_reg, data_reg;
>>> +
>>> +    assert(watch_engine < ARRAY_SIZE(endc_watch));
>>> +
>>> +    spec_reg = (VC_ENDC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>>> +    data_reg = (VC_ENDC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>>> +    blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID, xive->vc_regs[spec_reg]);
>>> +    idx = GETFIELD(VC_ENDC_WATCH_INDEX, xive->vc_regs[spec_reg]);
>>>         if (pnv_xive2_vst_read(xive, VST_END, blk, idx, endc_watch)) {
>>>           xive2_error(xive, "VST: no END entry %x/%x !?", blk, idx);
>>>       }
>>>         for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>>> -        xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + i] =
>>> -            be64_to_cpu(endc_watch[i]);
>>> +        xive->vc_regs[data_reg + i] = be64_to_cpu(endc_watch[i]);
>>>       }
>>>   }
>>>   @@ -379,40 +387,50 @@ static int pnv_xive2_write_nvp(Xive2Router 
>>> *xrtr, uint8_t blk, uint32_t idx,
>>>                                 word_number);
>>>   }
>>>   -static int pnv_xive2_nvp_update(PnvXive2 *xive)
>>> +static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
>>>   {
>>> -    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>>> -    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>>> -    int i;
>>> +    uint8_t  blk;
>>> +    uint32_t idx;
>>> +    int i, spec_reg, data_reg;
>>>       uint64_t nxc_watch[4];
>>>   +    if (watch_engine > 3) {
>>> +        return -1;
>>> +    }
>>
>> Why not an assert here and below ?
>>
>>
>> Thanks,
>>
>> C.
>>
> Hmmm, I added assert()s...  Not sure what happened, maybe applying a 
> different patch overwrote it.  I will verify changes and add assert()s 
> back in.
Strike that.   The asserts were done in patch set 4.
>>
>>
>>
>>> +    spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>>> +    data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>>> +    blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>>> +    idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>>> +
>>>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>>> -        nxc_watch[i] =
>>> -            cpu_to_be64(xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + 
>>> i]);
>>> +        nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
>>>       }
>>>         return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
>>>                                 XIVE_VST_WORD_ALL);
>>>   }
>>>   -static void pnv_xive2_nvp_cache_load(PnvXive2 *xive)
>>> +static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t 
>>> watch_engine)
>>>   {
>>> -    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>>> -    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>>> +    uint8_t  blk;
>>> +    uint32_t idx;
>>>       uint64_t nxc_watch[4] = { 0 };
>>> -    int i;
>>> +    int i, spec_reg, data_reg;
>>> +
>>> +    if (watch_engine > 3) {
>>> +        return;
>>> +    }
>>> +    spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>>> +    data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>>> +    blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>>> +    idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>>>         if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
>>>           xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
>>>       }
>>>         for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>>> -        xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + i] =
>>> -            be64_to_cpu(nxc_watch[i]);
>>> +        xive->pc_regs[data_reg + i] = be64_to_cpu(nxc_watch[i]);
>>>       }
>>>   }
>>>   @@ -964,12 +982,70 @@ static const MemoryRegionOps 
>>> pnv_xive2_ic_cq_ops = {
>>>       },
>>>   };
>>>   +static uint8_t pnv_xive2_cache_watch_assign(uint64_t engine_mask,
>>> +                                            uint64_t *state)
>>> +{
>>> +    uint8_t val = 0xFF;
>>> +    int i;
>>> +
>>> +    for (i = 3; i >= 0; i--) {
>>> +        if (BIT(i) & engine_mask) {
>>> +            if (!(BIT(i) & *state)) {
>>> +                *state |= BIT(i);
>>> +                val = 3 - i;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +    return val;
>>> +}
>>> +
>>> +static void pnv_xive2_cache_watch_release(uint64_t *state, uint8_t 
>>> watch_engine)
>>> +{
>>> +    uint8_t engine_bit = 3 - watch_engine;
>>> +
>>> +    if (*state & BIT(engine_bit)) {
>>> +        *state &= ~BIT(engine_bit);
>>> +    }
>>> +}
>>> +
>>> +static uint8_t pnv_xive2_endc_cache_watch_assign(PnvXive2 *xive)
>>> +{
>>> +    uint64_t engine_mask = GETFIELD(VC_ENDC_CFG_CACHE_WATCH_ASSIGN,
>>> + xive->vc_regs[VC_ENDC_CFG >> 3]);
>>> +    uint64_t state = xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3];
>>> +    uint8_t val;
>>> +
>>> +    /*
>>> +     * We keep track of which engines are currently busy in the
>>> +     * VC_ENDC_WATCH_ASSIGN register directly. When the firmware reads
>>> +     * the register, we don't return its value but the ID of an engine
>>> +     * it can use.
>>> +     * There are 4 engines. 0xFF means no engine is available.
>>> +     */
>>> +    val = pnv_xive2_cache_watch_assign(engine_mask, &state);
>>> +    if (val != 0xFF) {
>>> +        xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3] = state;
>>> +    }
>>> +    return val;
>>> +}
>>> +
>>> +static void pnv_xive2_endc_cache_watch_release(PnvXive2 *xive,
>>> +                                               uint8_t watch_engine)
>>> +{
>>> +    uint64_t state = xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3];
>>> +
>>> +    pnv_xive2_cache_watch_release(&state, watch_engine);
>>> +    xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3] = state;
>>> +}
>>> +
>>>   static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>>>                                        unsigned size)
>>>   {
>>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>>       uint64_t val = 0;
>>>       uint32_t reg = offset >> 3;
>>> +    uint8_t watch_engine;
>>>         switch (offset) {
>>>       /*
>>> @@ -1000,24 +1076,44 @@ static uint64_t pnv_xive2_ic_vc_read(void 
>>> *opaque, hwaddr offset,
>>>           val = xive->vc_regs[reg];
>>>           break;
>>>   +    case VC_ENDC_WATCH_ASSIGN:
>>> +        val = pnv_xive2_endc_cache_watch_assign(xive);
>>> +        break;
>>> +
>>> +    case VC_ENDC_CFG:
>>> +        val = xive->vc_regs[reg];
>>> +        break;
>>> +
>>>       /*
>>>        * END cache updates
>>>        */
>>>       case VC_ENDC_WATCH0_SPEC:
>>> +    case VC_ENDC_WATCH1_SPEC:
>>> +    case VC_ENDC_WATCH2_SPEC:
>>> +    case VC_ENDC_WATCH3_SPEC:
>>> +        watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
>>>           xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | 
>>> VC_ENDC_WATCH_CONFLICT);
>>> +        pnv_xive2_endc_cache_watch_release(xive, watch_engine);
>>>           val = xive->vc_regs[reg];
>>>           break;
>>>         case VC_ENDC_WATCH0_DATA0:
>>> +    case VC_ENDC_WATCH1_DATA0:
>>> +    case VC_ENDC_WATCH2_DATA0:
>>> +    case VC_ENDC_WATCH3_DATA0:
>>>           /*
>>>            * Load DATA registers from cache with data requested by the
>>>            * SPEC register
>>>            */
>>> -        pnv_xive2_end_cache_load(xive);
>>> +        watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>>> +        pnv_xive2_end_cache_load(xive, watch_engine);
>>>           val = xive->vc_regs[reg];
>>>           break;
>>>         case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>>> +    case VC_ENDC_WATCH1_DATA1 ... VC_ENDC_WATCH1_DATA3:
>>> +    case VC_ENDC_WATCH2_DATA1 ... VC_ENDC_WATCH2_DATA3:
>>> +    case VC_ENDC_WATCH3_DATA1 ... VC_ENDC_WATCH3_DATA3:
>>>           val = xive->vc_regs[reg];
>>>           break;
>>>   @@ -1063,6 +1159,7 @@ static void pnv_xive2_ic_vc_write(void 
>>> *opaque, hwaddr offset,
>>>   {
>>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>>       uint32_t reg = offset >> 3;
>>> +    uint8_t watch_engine;
>>>         switch (offset) {
>>>       /*
>>> @@ -1095,19 +1192,32 @@ static void pnv_xive2_ic_vc_write(void 
>>> *opaque, hwaddr offset,
>>>           /* EAS update */
>>>           break;
>>>   +    case VC_ENDC_CFG:
>>> +        break;
>>> +
>>>       /*
>>>        * END cache updates
>>>        */
>>>       case VC_ENDC_WATCH0_SPEC:
>>> +    case VC_ENDC_WATCH1_SPEC:
>>> +    case VC_ENDC_WATCH2_SPEC:
>>> +    case VC_ENDC_WATCH3_SPEC:
>>>            val &= ~VC_ENDC_WATCH_CONFLICT; /* HW will set this bit */
>>>           break;
>>>         case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>>> +    case VC_ENDC_WATCH1_DATA1 ... VC_ENDC_WATCH1_DATA3:
>>> +    case VC_ENDC_WATCH2_DATA1 ... VC_ENDC_WATCH2_DATA3:
>>> +    case VC_ENDC_WATCH3_DATA1 ... VC_ENDC_WATCH3_DATA3:
>>>           break;
>>>       case VC_ENDC_WATCH0_DATA0:
>>> +    case VC_ENDC_WATCH1_DATA0:
>>> +    case VC_ENDC_WATCH2_DATA0:
>>> +    case VC_ENDC_WATCH3_DATA0:
>>>           /* writing to DATA0 triggers the cache write */
>>> +        watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>>>           xive->vc_regs[reg] = val;
>>> -        pnv_xive2_end_update(xive);
>>> +        pnv_xive2_end_update(xive, watch_engine);
>>>           break;
>>>     @@ -1157,12 +1267,43 @@ static const MemoryRegionOps 
>>> pnv_xive2_ic_vc_ops = {
>>>       },
>>>   };
>>>   +static uint8_t pnv_xive2_nxc_cache_watch_assign(PnvXive2 *xive)
>>> +{
>>> +    uint64_t engine_mask = GETFIELD(PC_NXC_PROC_CONFIG_WATCH_ASSIGN,
>>> + xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
>>> +    uint64_t state = xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3];
>>> +    uint8_t val;
>>> +
>>> +    /*
>>> +     * We keep track of which engines are currently busy in the
>>> +     * PC_NXC_WATCH_ASSIGN register directly. When the firmware reads
>>> +     * the register, we don't return its value but the ID of an engine
>>> +     * it can use.
>>> +     * There are 4 engines. 0xFF means no engine is available.
>>> +     */
>>> +    val = pnv_xive2_cache_watch_assign(engine_mask, &state);
>>> +    if (val != 0xFF) {
>>> +        xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3] = state;
>>> +    }
>>> +    return val;
>>> +}
>>> +
>>> +static void pnv_xive2_nxc_cache_watch_release(PnvXive2 *xive,
>>> +                                              uint8_t watch_engine)
>>> +{
>>> +    uint64_t state = xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3];
>>> +
>>> +    pnv_xive2_cache_watch_release(&state, watch_engine);
>>> +    xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3] = state;
>>> +}
>>> +
>>>   static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>>>                                        unsigned size)
>>>   {
>>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>>       uint64_t val = -1;
>>>       uint32_t reg = offset >> 3;
>>> +    uint8_t watch_engine;
>>>         switch (offset) {
>>>       /*
>>> @@ -1173,24 +1314,44 @@ static uint64_t pnv_xive2_ic_pc_read(void 
>>> *opaque, hwaddr offset,
>>>           val = xive->pc_regs[reg];
>>>           break;
>>>   +    case PC_NXC_WATCH_ASSIGN:
>>> +        val = pnv_xive2_nxc_cache_watch_assign(xive);
>>> +        break;
>>> +
>>> +    case PC_NXC_PROC_CONFIG:
>>> +        val = xive->pc_regs[reg];
>>> +        break;
>>> +
>>>       /*
>>>        * cache updates
>>>        */
>>>       case PC_NXC_WATCH0_SPEC:
>>> +    case PC_NXC_WATCH1_SPEC:
>>> +    case PC_NXC_WATCH2_SPEC:
>>> +    case PC_NXC_WATCH3_SPEC:
>>> +        watch_engine = (offset - PC_NXC_WATCH0_SPEC) >> 6;
>>>           xive->pc_regs[reg] &= ~(PC_NXC_WATCH_FULL | 
>>> PC_NXC_WATCH_CONFLICT);
>>> +        pnv_xive2_nxc_cache_watch_release(xive, watch_engine);
>>>           val = xive->pc_regs[reg];
>>>           break;
>>>         case PC_NXC_WATCH0_DATA0:
>>> +    case PC_NXC_WATCH1_DATA0:
>>> +    case PC_NXC_WATCH2_DATA0:
>>> +    case PC_NXC_WATCH3_DATA0:
>>>          /*
>>>           * Load DATA registers from cache with data requested by the
>>>           * SPEC register
>>>           */
>>> -        pnv_xive2_nvp_cache_load(xive);
>>> +        watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>>> +        pnv_xive2_nvp_cache_load(xive, watch_engine);
>>>           val = xive->pc_regs[reg];
>>>           break;
>>>         case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>>> +    case PC_NXC_WATCH1_DATA1 ... PC_NXC_WATCH1_DATA3:
>>> +    case PC_NXC_WATCH2_DATA1 ... PC_NXC_WATCH2_DATA3:
>>> +    case PC_NXC_WATCH3_DATA1 ... PC_NXC_WATCH3_DATA3:
>>>           val = xive->pc_regs[reg];
>>>           break;
>>>   @@ -1219,6 +1380,7 @@ static void pnv_xive2_ic_pc_write(void 
>>> *opaque, hwaddr offset,
>>>   {
>>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>>       uint32_t reg = offset >> 3;
>>> +    uint8_t watch_engine;
>>>         switch (offset) {
>>>   @@ -1231,19 +1393,32 @@ static void pnv_xive2_ic_pc_write(void 
>>> *opaque, hwaddr offset,
>>>       case PC_VSD_TABLE_DATA:
>>>           break;
>>>   +    case PC_NXC_PROC_CONFIG:
>>> +        break;
>>> +
>>>       /*
>>>        * cache updates
>>>        */
>>>       case PC_NXC_WATCH0_SPEC:
>>> +    case PC_NXC_WATCH1_SPEC:
>>> +    case PC_NXC_WATCH2_SPEC:
>>> +    case PC_NXC_WATCH3_SPEC:
>>>           val &= ~PC_NXC_WATCH_CONFLICT; /* HW will set this bit */
>>>           break;
>>>         case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>>> +    case PC_NXC_WATCH1_DATA1 ... PC_NXC_WATCH1_DATA3:
>>> +    case PC_NXC_WATCH2_DATA1 ... PC_NXC_WATCH2_DATA3:
>>> +    case PC_NXC_WATCH3_DATA1 ... PC_NXC_WATCH3_DATA3:
>>>           break;
>>>       case PC_NXC_WATCH0_DATA0:
>>> +    case PC_NXC_WATCH1_DATA0:
>>> +    case PC_NXC_WATCH2_DATA0:
>>> +    case PC_NXC_WATCH3_DATA0:
>>>           /* writing to DATA0 triggers the cache write */
>>> +        watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>>>           xive->pc_regs[reg] = val;
>>> -        pnv_xive2_nvp_update(xive);
>>> +        pnv_xive2_nvp_update(xive, watch_engine);
>>>           break;
>>>        /* case PC_NXC_FLUSH_CTRL: */
>>> @@ -1814,6 +1989,12 @@ static void pnv_xive2_reset(void *dev)
>>>       xive->cq_regs[CQ_XIVE_CFG >> 3] |=
>>>           SETFIELD(CQ_XIVE_CFG_HYP_HARD_BLOCK_ID, 0ull, 
>>> xive->chip->chip_id);
>>>   +    /* VC and PC cache watch assign mechanism */
>>> +    xive->vc_regs[VC_ENDC_CFG >> 3] =
>>> +        SETFIELD(VC_ENDC_CFG_CACHE_WATCH_ASSIGN, 0ull, 0b0111);
>>> +    xive->pc_regs[PC_NXC_PROC_CONFIG >> 3] =
>>> +        SETFIELD(PC_NXC_PROC_CONFIG_WATCH_ASSIGN, 0ull, 0b0111);
>>> +
>>>       /* Set default page size to 64k */
>>>       xive->ic_shift = xive->esb_shift = xive->end_shift = 16;
>>>       xive->nvc_shift = xive->nvpg_shift = xive->tm_shift = 16;
>>

