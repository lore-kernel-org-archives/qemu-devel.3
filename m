Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F948C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS17u-00080D-5P; Thu, 11 Jul 2024 17:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sS0qz-0002ey-VE; Thu, 11 Jul 2024 16:57:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sS0qu-000122-NO; Thu, 11 Jul 2024 16:57:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BJTOuv021400;
 Thu, 11 Jul 2024 20:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
 nlzyifu5vfK5qMAOUu4dJZex6ZWzBrmYJseuypekaw=; b=Lmi44YOxrnzz08NOW
 fXOI+15+/tiq1h5mWHr9AED9A2kO2lrh2hfM1cELjB5sxFeBJLE0rGuIqppMlMch
 Ue2MTy9gbdjq92XxvnnqWWhlhoWS1khGyFKo13aazQBKXrsWZFtytbIXENHF1qq9
 bOmS43nEvL2rBXggOVrHM0st1J0NB13Ly7YH0VhLzuVzmayiLPGLKlENEpEftvwh
 /yTSTokUSV3D8GSVgMA5d2hwInhPZ7ENYK+kyf4cQSLGt73NY7hhpDzn0xWr7dYc
 6r8CTUDM95g4Ss79hyAZJYzBU3OpHndB8v57mKpvxFMpw1RNf9Ixvt8EkmfiB27k
 MoM6g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ankar632-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:57:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BKv770022554;
 Thu, 11 Jul 2024 20:57:07 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ankar630-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:57:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46BIExrJ024694; Thu, 11 Jul 2024 20:57:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8uk65k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:57:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46BKv3xo26542634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 20:57:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F38B558062;
 Thu, 11 Jul 2024 20:57:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B3A558065;
 Thu, 11 Jul 2024 20:57:02 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jul 2024 20:57:02 +0000 (GMT)
Message-ID: <b7d5e3cb-f6e2-431c-aa96-b728f94f637d@linux.ibm.com>
Date: Thu, 11 Jul 2024 15:57:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync
 Injection support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
 <20240617204302.12323-2-kowal@linux.vnet.ibm.com>
 <12c2313d-0c7f-4063-85f6-768f5d657ae5@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <12c2313d-0c7f-4063-85f6-768f5d657ae5@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fuZaiM_pVkzT5azVXA-8JTzyTFNfHNzj
X-Proofpoint-GUID: EJljSy9duFoNLSfXPmv2wCramsyJF6Q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110142
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
X-Mailman-Approved-At: Thu, 11 Jul 2024 17:14:51 -0400
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

Hello Cedric,

This patch will be split into 5 patches to ease the review.  I also 
acknowledge most of your other comments.

Can you elaborate on the gic_get_current_cpu() comment?  Did you want me 
to use that method name to get a the current CPU?  Also, is this 
something that you think needs to done at this current time since there 
are many other existing uses to get the CPU, or can we delay this and an 
issue for for this to be done at a later time?

Mike

On 6/18/2024 12:39 PM, Cédric Le Goater wrote:
> Hello Michael,
>
> On 6/17/24 10:42 PM, Michael Kowal wrote:
>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>> XIVE offers a 'cache watch facility', which allows software to 
>> read/update
>> a potentially cached table entry with no software lock. There's one such
>> facility in the Virtualization Controller (VC) to update the ESB and END
>> entries and one in the Presentation Controller (PC) to update the
>> NVP/NVG/NVC entries.
>>
>> Both the Virtualization layer (VC) and Presentation layer (PC) need 
>> to be
>> configured to access the VSTs. Since the information is redundant, the
>> xive model combines both into one set of tables.  Since the VST 
>> tables can
>> be set through both, they are dynamically re-mapped in memory by first
>> deleting the memory subregion.
>
> This is an extra patch.
>
>>
>> For the NVG and NVC tables, it can make sense to only configure them
>> with the PC, since they are only used by the presenter. So this patch
>> allow to configure the VST tables through the PC as well. The
>> definitions are still shared.
>>
>> Each facility has 4 cache watch engines to control the updates and
>> firmware can request an available engine by querying the hardware
>> 'watch_assign' register of the VC or PC. The engine is then reserved and
>> is released after the data is updated by reading the 'watch_spec' 
>> register
>> (which also allows to check for a conflict during the update).
>> If no engine is available, the special value 0xFF is returned and
>> firmware is expected to repeat the request until an engine becomes
>> available.
>>
>> There is also support for writing a completion notification byte in 
>> memory
>> whenever a cache flush or queue sync inject operation is requested by
>> software.  QEMU does not cache any of the XIVE data that is in memory 
>> and
>> therefore it simply writes the completion notification byte at the time
>> that the operation is requested.
>>
>> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
>
> There should be a Signed-off-by for Fred also.
>
> That said, this patch is big. Would it be possible to split it a bit
> to help the reviewer ? I am quite rusty in XIVE now.
>
> If so,  I think we could separate :
>   - the code cleanups (alignment)
>   - cache watch updates (may be PC and VC)
>   - injection operations
>   - memory_region updates
>
> Some more comments below,
>
>
>> ---
>>   hw/intc/pnv_xive2_regs.h  | 106 ++++++++
>>   include/hw/ppc/pnv_chip.h |   1 +
>>   hw/intc/pnv_xive2.c       | 511 +++++++++++++++++++++++++++++++++-----
>>   3 files changed, 554 insertions(+), 64 deletions(-)
>>
>> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
>> index 7165dc8704..ca05255d20 100644
>> --- a/hw/intc/pnv_xive2_regs.h
>> +++ b/hw/intc/pnv_xive2_regs.h
>> @@ -232,6 +232,10 @@
>>   #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK PPC_BITMASK(32, 35)
>>   #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK PPC_BITMASK(36, 63) /* 
>> 28-bit */
>>   +/* ESBC cache flush inject register */
>> +#define X_VC_ESBC_FLUSH_INJECT                  0x142
>> +#define VC_ESBC_FLUSH_INJECT                    0x210
>> +
>>   /* ESBC configuration */
>>   #define X_VC_ESBC_CFG                           0x148
>>   #define VC_ESBC_CFG                             0x240
>> @@ -250,6 +254,10 @@
>>   #define  VC_EASC_FLUSH_POLL_BLOCK_ID_MASK PPC_BITMASK(32, 35)
>>   #define  VC_EASC_FLUSH_POLL_OFFSET_MASK PPC_BITMASK(36, 63) /* 
>> 28-bit */
>>   +/* EASC flush inject register */
>> +#define X_VC_EASC_FLUSH_INJECT                  0x162
>> +#define VC_EASC_FLUSH_INJECT                    0x310
>> +
>>   /*
>>    * VC2
>>    */
>> @@ -270,6 +278,10 @@
>>   #define  VC_ENDC_FLUSH_POLL_BLOCK_ID_MASK PPC_BITMASK(36, 39)
>>   #define  VC_ENDC_FLUSH_POLL_OFFSET_MASK PPC_BITMASK(40, 63) /* 
>> 24-bit */
>>   +/* ENDC flush inject register */
>> +#define X_VC_ENDC_FLUSH_INJECT                  0x182
>> +#define VC_ENDC_FLUSH_INJECT                    0x410
>> +
>>   /* ENDC Sync done */
>>   #define X_VC_ENDC_SYNC_DONE                     0x184
>>   #define VC_ENDC_SYNC_DONE                       0x420
>> @@ -283,6 +295,15 @@
>>   #define   VC_ENDC_SYNC_QUEUE_HARD               PPC_BIT(6)
>>   #define   VC_QUEUE_COUNT                        7
>>   +/* ENDC cache watch assign */
>> +#define X_VC_ENDC_WATCH_ASSIGN                  0x186
>> +#define VC_ENDC_WATCH_ASSIGN                    0x430
>> +
>> +/* ENDC configuration register */
>> +#define X_VC_ENDC_CFG                           0x188
>> +#define VC_ENDC_CFG                             0x440
>> +#define   VC_ENDC_CFG_CACHE_WATCH_ASSIGN        PPC_BITMASK(32, 35)
>> +
>>   /* ENDC cache watch specification 0  */
>>   #define X_VC_ENDC_WATCH0_SPEC                   0x1A0
>>   #define VC_ENDC_WATCH0_SPEC                     0x500
>> @@ -302,6 +323,42 @@
>>   #define VC_ENDC_WATCH0_DATA2                    0x530
>>   #define VC_ENDC_WATCH0_DATA3                    0x538
>>   +/* ENDC cache watch 1  */
>> +#define X_VC_ENDC_WATCH1_SPEC                   0x1A8
>> +#define VC_ENDC_WATCH1_SPEC                     0x540
>> +#define X_VC_ENDC_WATCH1_DATA0                  0x1AC
>> +#define X_VC_ENDC_WATCH1_DATA1                  0x1AD
>> +#define X_VC_ENDC_WATCH1_DATA2                  0x1AE
>> +#define X_VC_ENDC_WATCH1_DATA3                  0x1AF
>> +#define VC_ENDC_WATCH1_DATA0                    0x560
>> +#define VC_ENDC_WATCH1_DATA1                    0x568
>> +#define VC_ENDC_WATCH1_DATA2                    0x570
>> +#define VC_ENDC_WATCH1_DATA3                    0x578
>> +
>> +/* ENDC cache watch 2  */
>> +#define X_VC_ENDC_WATCH2_SPEC                   0x1B0
>> +#define VC_ENDC_WATCH2_SPEC                     0x580
>> +#define X_VC_ENDC_WATCH2_DATA0                  0x1B4
>> +#define X_VC_ENDC_WATCH2_DATA1                  0x1B5
>> +#define X_VC_ENDC_WATCH2_DATA2                  0x1B6
>> +#define X_VC_ENDC_WATCH2_DATA3                  0x1B7
>> +#define VC_ENDC_WATCH2_DATA0                    0x5A0
>> +#define VC_ENDC_WATCH2_DATA1                    0x5A8
>> +#define VC_ENDC_WATCH2_DATA2                    0x5B0
>> +#define VC_ENDC_WATCH2_DATA3                    0x5B8
>> +
>> +/* ENDC cache watch 3  */
>> +#define X_VC_ENDC_WATCH3_SPEC                   0x1B8
>> +#define VC_ENDC_WATCH3_SPEC                     0x5C0
>> +#define X_VC_ENDC_WATCH3_DATA0                  0x1BC
>> +#define X_VC_ENDC_WATCH3_DATA1                  0x1BD
>> +#define X_VC_ENDC_WATCH3_DATA2                  0x1BE
>> +#define X_VC_ENDC_WATCH3_DATA3                  0x1BF
>> +#define VC_ENDC_WATCH3_DATA0                    0x5E0
>> +#define VC_ENDC_WATCH3_DATA1                    0x5E8
>> +#define VC_ENDC_WATCH3_DATA2                    0x5F0
>> +#define VC_ENDC_WATCH3_DATA3                    0x5F8
>> +
>>   /*
>>    * PC LSB1
>>    */
>> @@ -358,6 +415,19 @@
>>   #define  PC_NXC_FLUSH_POLL_BLOCK_ID_MASK PPC_BITMASK(36, 39)
>>   #define  PC_NXC_FLUSH_POLL_OFFSET_MASK PPC_BITMASK(40, 63) /* 
>> 24-bit */
>>   +/* NxC Cache flush inject */
>> +#define X_PC_NXC_FLUSH_INJECT                   0x282
>> +#define PC_NXC_FLUSH_INJECT                     0x410
>> +
>> +/* NxC Cache watch assign */
>> +#define X_PC_NXC_WATCH_ASSIGN                   0x286
>> +#define PC_NXC_WATCH_ASSIGN                     0x430
>> +
>> +/* NxC Proc config */
>> +#define X_PC_NXC_PROC_CONFIG                    0x28A
>> +#define PC_NXC_PROC_CONFIG                      0x450
>> +#define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
>> +
>>   /* NxC Cache Watch 0 Specification */
>>   #define X_PC_NXC_WATCH0_SPEC                    0x2A0
>>   #define PC_NXC_WATCH0_SPEC                      0x500
>> @@ -381,6 +451,42 @@
>>   #define PC_NXC_WATCH0_DATA2                     0x530
>>   #define PC_NXC_WATCH0_DATA3                     0x538
>>   +/* NxC Cache Watch 1 */
>> +#define X_PC_NXC_WATCH1_SPEC                    0x2A8
>> +#define PC_NXC_WATCH1_SPEC                      0x540
>> +#define X_PC_NXC_WATCH1_DATA0                   0x2AC
>> +#define X_PC_NXC_WATCH1_DATA1                   0x2AD
>> +#define X_PC_NXC_WATCH1_DATA2                   0x2AE
>> +#define X_PC_NXC_WATCH1_DATA3                   0x2AF
>> +#define PC_NXC_WATCH1_DATA0                     0x560
>> +#define PC_NXC_WATCH1_DATA1                     0x568
>> +#define PC_NXC_WATCH1_DATA2                     0x570
>> +#define PC_NXC_WATCH1_DATA3                     0x578
>> +
>> +/* NxC Cache Watch 2 */
>> +#define X_PC_NXC_WATCH2_SPEC                    0x2B0
>> +#define PC_NXC_WATCH2_SPEC                      0x580
>> +#define X_PC_NXC_WATCH2_DATA0                   0x2B4
>> +#define X_PC_NXC_WATCH2_DATA1                   0x2B5
>> +#define X_PC_NXC_WATCH2_DATA2                   0x2B6
>> +#define X_PC_NXC_WATCH2_DATA3                   0x2B7
>> +#define PC_NXC_WATCH2_DATA0                     0x5A0
>> +#define PC_NXC_WATCH2_DATA1                     0x5A8
>> +#define PC_NXC_WATCH2_DATA2                     0x5B0
>> +#define PC_NXC_WATCH2_DATA3                     0x5B8
>> +
>> +/* NxC Cache Watch 3 */
>> +#define X_PC_NXC_WATCH3_SPEC                    0x2B8
>> +#define PC_NXC_WATCH3_SPEC                      0x5C0
>> +#define X_PC_NXC_WATCH3_DATA0                   0x2BC
>> +#define X_PC_NXC_WATCH3_DATA1                   0x2BD
>> +#define X_PC_NXC_WATCH3_DATA2                   0x2BE
>> +#define X_PC_NXC_WATCH3_DATA3                   0x2BF
>> +#define PC_NXC_WATCH3_DATA0                     0x5E0
>> +#define PC_NXC_WATCH3_DATA1                     0x5E8
>> +#define PC_NXC_WATCH3_DATA2                     0x5F0
>> +#define PC_NXC_WATCH3_DATA3                     0x5F8
>> +
>>   /*
>>    * TCTXT Registers
>>    */
>> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
>> index 8589f3291e..ed16260b93 100644
>> --- a/include/hw/ppc/pnv_chip.h
>> +++ b/include/hw/ppc/pnv_chip.h
>> @@ -131,6 +131,7 @@ struct Pnv10Chip {
>>     #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
>>   #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
>> +#define PNV10_PIR2THREAD(pir)    (((pir) & 0x7f))
>>     struct PnvChipClass {
>>       /*< private >*/
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index 4b8d0a5d81..2050ed5efd 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -33,6 +33,16 @@
>>     #undef XIVE2_DEBUG
>>   +/* XIVE Sync or Flush Notification Block */
>> +typedef struct XiveSfnBlock {
>> +    uint8_t bytes[32];
>> +} XiveSfnBlock;
>> +
>> +/* XIVE Thread Sync or Flush Notification Area */
>> +typedef struct XiveThreadNA {
>> +    XiveSfnBlock topo[16];
>> +} XiveThreadNA;
>> +
>>   /*
>>    * Virtual structures table (VST)
>>    */
>> @@ -46,16 +56,16 @@ typedef struct XiveVstInfo {
>>     static const XiveVstInfo vst_infos[] = {
>>   -    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),  16 },
>> -    [VST_ESB]  = { "ESB",  1,                  16 },
>> -    [VST_END]  = { "ENDT", sizeof(Xive2End),  16 },
>> +    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),     16 },
>> +    [VST_ESB]  = { "ESB",  1,                    16 },
>> +    [VST_END]  = { "ENDT", sizeof(Xive2End),     16 },
>>   -    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),  16 },
>> -    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc), 16 },
>> -    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc), 16 },
>> +    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),     16 },
>> +    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc),    16 },
>> +    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
>>   -    [VST_IC]  =  { "IC",   1 /* ? */         , 16 }, /* Topology # */
>> -    [VST_SYNC] = { "SYNC", 1 /* ? */         , 16 }, /* Topology # */
>> +    [VST_IC]  =  { "IC",   1 /* ? */         ,   16 }, /* Topology # */
>> +    [VST_SYNC] = { "SYNC", sizeof(XiveThreadNA), 16 }, /* Topology # */
>>         /*
>>        * This table contains the backing store pages for the interrupt
>> @@ -330,40 +340,111 @@ static int pnv_xive2_write_end(Xive2Router 
>> *xrtr, uint8_t blk, uint32_t idx,
>>                                 word_number);
>>   }
>>   -static int pnv_xive2_end_update(PnvXive2 *xive)
>> +/*
>> + * After SW injects a Queue Sync or Cache Flush operation, HW will 
>> notify
>> + * SW of the completion of the operation by writing a byte of all 
>> 1's (0xff)
>> + * to a specific memory location.  The memory location is calculated 
>> by first
>> + * looking up a base address in the SYNC VSD using the Topology ID 
>> of the
>> + * originating thread as the "block" number.  This points to a
>> + * 64k block of memory that is further divided into 128 512 byte 
>> chunks of
>> + * memory, which is indexed by the thread id of the requesting thread.
>> + * Finally, this 512 byte chunk of memory is divided into 16 32 byte
>> + * chunks which are indexed by the topology id of the targeted IC's 
>> chip.
>> + * The values below are the offsets into that 32 byte chunk of 
>> memory for
>> + * each type of cache flush or queue sync operation.
>> + */
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
>> +static int pnv_xive2_inject_notify(PnvXive2 *xive, int type)
>> +{
>> +    uint64_t addr;
>> +
>> +    /* current_cpu is null when write comes from QTEST */
>> +    PowerPCCPU *cpu = current_cpu ? POWERPC_CPU(current_cpu) : NULL;
>> +
>> +    /* Assume a PIR of 0 for QTEST */
>> +    int pir = cpu ? ppc_cpu_pir(cpu) : 0;
>
> please introduce a routine like gic_get_current_cpu(). 
> gic_get_current_pir() ?
>
>> +    int thread_nr = PNV10_PIR2THREAD(pir);
>> +    int thread_topo_id = PNV10_PIR2CHIP(pir);
>> +    int ic_topo_id = xive->chip->chip_id;
>> +    uint64_t offset = ic_topo_id * sizeof(XiveSfnBlock);
>> +    uint8_t byte = 0xff;
>> +
>> +    /* Retrieve the address of requesting thread's notification area */
>> +    addr = pnv_xive2_vst_addr(xive, VST_SYNC, thread_topo_id, 
>> thread_nr);
>> +
>> +    if (!addr) {
>> +        xive2_error(xive, "VST: no SYNC entry %x/%x !?",
>> +                    thread_topo_id, thread_nr);
>> +        return -1;
>> +    }
>> +
>> +    cpu_physical_memory_write(addr + offset + type, &byte, 1);
>> +
>> +    return 0;
>> +}
>> +
>> +static int pnv_xive2_end_update(PnvXive2 *xive, uint8_t watch_engine)
>>   {
>> -    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> -    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> -    int i;
>> +    uint8_t  blk;
>> +    uint32_t idx;
>> +    int i, spec_reg, data_reg;
>>       uint64_t endc_watch[4];
>>   +    if (watch_engine > 3) {
>
> Does it deserve an assert instead ? May be use ARRAY_SIZE(endc_watch)
> also. I think these comments apply to other changes below.
>
>> +        return -1;
>> +    }
>> +    spec_reg = (VC_ENDC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>> +    data_reg = (VC_ENDC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>> +    blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID, xive->vc_regs[spec_reg]);
>> +    idx = GETFIELD(VC_ENDC_WATCH_INDEX, xive->vc_regs[spec_reg]);
>> +
>>       for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>> -        endc_watch[i] =
>> -            cpu_to_be64(xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + 
>> i]);
>> +        endc_watch[i] = cpu_to_be64(xive->vc_regs[data_reg + i]);
>>       }
>>         return pnv_xive2_vst_write(xive, VST_END, blk, idx, endc_watch,
>>                                 XIVE_VST_WORD_ALL);
>>   }
>>   -static void pnv_xive2_end_cache_load(PnvXive2 *xive)
>> +static void pnv_xive2_end_cache_load(PnvXive2 *xive, uint8_t 
>> watch_engine)
>>   {
>> -    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> -    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>> - xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> +    uint8_t  blk;
>> +    uint32_t idx;
>>       uint64_t endc_watch[4] = { 0 };
>> -    int i;
>> +    int i, spec_reg, data_reg;
>> +
>> +    if (watch_engine > 3) {
>> +        return;
>> +    }
>> +    spec_reg = (VC_ENDC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>> +    data_reg = (VC_ENDC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>> +    blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID, xive->vc_regs[spec_reg]);
>> +    idx = GETFIELD(VC_ENDC_WATCH_INDEX, xive->vc_regs[spec_reg]);
>>         if (pnv_xive2_vst_read(xive, VST_END, blk, idx, endc_watch)) {
>>           xive2_error(xive, "VST: no END entry %x/%x !?", blk, idx);
>>       }
>>         for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>> -        xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + i] =
>> -            be64_to_cpu(endc_watch[i]);
>> +        xive->vc_regs[data_reg + i] = be64_to_cpu(endc_watch[i]);
>>       }
>>   }
>>   @@ -380,40 +461,81 @@ static int pnv_xive2_write_nvp(Xive2Router 
>> *xrtr, uint8_t blk, uint32_t idx,
>>                                 word_number);
>>   }
>>   -static int pnv_xive2_nvp_update(PnvXive2 *xive)
>> +static int nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
>
> I would prefer that we always use a pnv_xive2_ prefix.
>
>>   {
>> -    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> -    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>> - xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> -    int i;
>> +    switch (nxc_type) {
>> +    case PC_NXC_WATCH_NXC_NVP:
>> +        *table_type = VST_NVP;
>> +        break;
>> +    case PC_NXC_WATCH_NXC_NVG:
>> +        *table_type = VST_NVG;
>> +        break;
>> +    case PC_NXC_WATCH_NXC_NVC:
>> +        *table_type = VST_NVC;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "XIVE: invalid table type for nxc operation\n");
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
>> +{
>> +    uint8_t  blk, nxc_type;
>> +    uint32_t idx, table_type;
>> +    int i, spec_reg, data_reg;
>>       uint64_t nxc_watch[4];
>>   +    if (watch_engine > 3) {
>> +        return -1;
>> +    }
>> +    spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>> +    data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, 
>> xive->pc_regs[spec_reg]);
>> +    blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>> +    idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>> +
>> +    if (nxc_to_table_type(nxc_type, &table_type)) {
>> +        return -1;
>> +    }
>> +
>>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>> -        nxc_watch[i] =
>> -            cpu_to_be64(xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + i]);
>> +        nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
>>       }
>>   -    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
>> +    return pnv_xive2_vst_write(xive, table_type, blk, idx, nxc_watch,
>>                                 XIVE_VST_WORD_ALL);
>>   }
>>   -static void pnv_xive2_nvp_cache_load(PnvXive2 *xive)
>> +static void pnv_xive2_nxc_cache_load(PnvXive2 *xive, uint8_t 
>> watch_engine)
>>   {
>> -    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>> -                           xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> -    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>> -                           xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> +    uint8_t  blk, nxc_type;
>> +    uint32_t idx, table_type;
>>       uint64_t nxc_watch[4] = { 0 };
>> -    int i;
>> +    int i, spec_reg, data_reg;
>> +
>> +    if (watch_engine > 3) {
>> +        return;
>> +    }
>> +    spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>> +    data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
>> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, 
>> xive->pc_regs[spec_reg]);
>> +    blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>> +    idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>> +
>> +    if (nxc_to_table_type(nxc_type, &table_type)) {
>> +        return;
>> +    }
>>   -    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
>> -        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
>> +    if (pnv_xive2_vst_read(xive, table_type, blk, idx, nxc_watch)) {
>> +        xive2_error(xive, "VST: no NXC entry %x/%x in %s table!?",
>> +                    blk, idx, vst_infos[table_type].name);
>>       }
>>         for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>> -        xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + i] =
>> -            be64_to_cpu(nxc_watch[i]);
>> +        xive->pc_regs[data_reg + i] = be64_to_cpu(nxc_watch[i]);
>>       }
>>   }
>>   @@ -642,6 +764,9 @@ static void 
>> pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
>>            * entries provisioned by FW (such as skiboot) and resize the
>>            * ESB window accordingly.
>>            */
>> +        if (memory_region_is_mapped(&xsrc->esb_mmio)) {
>> +            memory_region_del_subregion(&xive->esb_mmio, 
>> &xsrc->esb_mmio);
>> +        }
>>           if (!(VSD_INDIRECT & vsd)) {
>>               memory_region_set_size(&xsrc->esb_mmio, vst_tsize * 
>> SBE_PER_BYTE
>>                                      * (1ull << xsrc->esb_shift));
>> @@ -657,6 +782,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 
>> *xive, uint8_t type,
>>           /*
>>            * Backing store pages for the END.
>>            */
>> +        if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
>> +            memory_region_del_subregion(&xive->end_mmio, 
>> &end_xsrc->esb_mmio);
>> +        }
>>           if (!(VSD_INDIRECT & vsd)) {
>>               memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize 
>> / info->size)
>>                                      * (1ull << end_xsrc->esb_shift));
>> @@ -681,13 +809,10 @@ static void 
>> pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
>>    * Both PC and VC sub-engines are configured as each use the Virtual
>>    * Structure Tables
>>    */
>> -static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
>> +static void __pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd,
>
> _ and __ prefixes should be avoided. They are reserved for internal use.
>
>> + uint8_t type, uint8_t blk)
>>   {
>>       uint8_t mode = GETFIELD(VSD_MODE, vsd);
>> -    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
>> -                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>> -    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
>> -                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>>       uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
>>         if (type > VST_ERQ) {
>> @@ -722,6 +847,16 @@ static void pnv_xive2_vst_set_data(PnvXive2 
>> *xive, uint64_t vsd)
>>       }
>>   }
>>   +static void pnv_xive2_vc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
>> +{
>> +    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
>> +                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>> +    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
>> +                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>> +
>> +    __pnv_xive2_vst_set_data(xive, vsd, type, blk);
>> +}
>> +
>>   /*
>>    * MMIO handlers
>>    */
>> @@ -965,12 +1100,68 @@ static const MemoryRegionOps 
>> pnv_xive2_ic_cq_ops = {
>>       },
>>   };
>>   +static uint8_t _cache_watch_assign(uint64_t engine_mask, uint64_t 
>> *state)
>> +{
>> +    uint8_t val = 0xFF;
>> +    int i;
>> +
>> +    for (i = 3; i >= 0; i--) {
>> +        if (BIT(i) & engine_mask) {
>> +            if (!(BIT(i) & *state)) {
>> +                *state |= BIT(i);
>> +                val = 3 - i;
>> +                break;
>> +            }
>> +        }
>> +    }
>> +    return val;
>> +}
>> +
>> +static void _cache_watch_release(uint64_t *state, uint8_t watch_engine)
>> +{
>> +    uint8_t engine_bit = 3 - watch_engine;
>> +
>> +    if (*state & BIT(engine_bit)) {
>> +        *state &= ~BIT(engine_bit);
>> +    }
>> +}
>> +
>> +static uint8_t endc_cache_watch_assign(PnvXive2 *xive)
>> +{
>> +    uint64_t engine_mask = GETFIELD(VC_ENDC_CFG_CACHE_WATCH_ASSIGN,
>> + xive->vc_regs[VC_ENDC_CFG >> 3]);
>> +    uint64_t state = xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3];
>> +    uint8_t val;
>> +
>> +    /*
>> +     * We keep track of which engines are currently busy in the
>> +     * VC_ENDC_WATCH_ASSIGN register directly. When the firmware reads
>> +     * the register, we don't return its value but the ID of an engine
>> +     * it can use.
>> +     * There are 4 engines. 0xFF means no engine is available.
>> +     */
>> +    val = _cache_watch_assign(engine_mask, &state);
>> +    if (val != 0xFF) {
>> +        xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3] = state;
>> +    }
>> +    return val;
>> +}
>> +
>> +static void endc_cache_watch_release(PnvXive2 *xive, uint8_t 
>> watch_engine)
>> +{
>> +    uint64_t state = xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3];
>> +
>> +    _cache_watch_release(&state, watch_engine);
>> +    xive->vc_regs[VC_ENDC_WATCH_ASSIGN >> 3] = state;
>> +}
>> +
>>   static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>>                                        unsigned size)
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>       uint64_t val = 0;
>>       uint32_t reg = offset >> 3;
>> +    uint8_t watch_engine;
>>         switch (offset) {
>>       /*
>> @@ -1001,24 +1192,44 @@ static uint64_t pnv_xive2_ic_vc_read(void 
>> *opaque, hwaddr offset,
>>           val = xive->vc_regs[reg];
>>           break;
>>   +    case VC_ENDC_WATCH_ASSIGN:
>> +        val = endc_cache_watch_assign(xive);
>> +        break;
>> +
>> +    case VC_ENDC_CFG:
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>>       /*
>>        * END cache updates
>>        */
>>       case VC_ENDC_WATCH0_SPEC:
>> +    case VC_ENDC_WATCH1_SPEC:
>> +    case VC_ENDC_WATCH2_SPEC:
>> +    case VC_ENDC_WATCH3_SPEC:
>> +        watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
>>           xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | 
>> VC_ENDC_WATCH_CONFLICT);
>> +        endc_cache_watch_release(xive, watch_engine);
>>           val = xive->vc_regs[reg];
>>           break;
>>         case VC_ENDC_WATCH0_DATA0:
>> +    case VC_ENDC_WATCH1_DATA0:
>> +    case VC_ENDC_WATCH2_DATA0:
>> +    case VC_ENDC_WATCH3_DATA0:
>>           /*
>>            * Load DATA registers from cache with data requested by the
>>            * SPEC register
>>            */
>> -        pnv_xive2_end_cache_load(xive);
>> +        watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>> +        pnv_xive2_end_cache_load(xive, watch_engine);
>>           val = xive->vc_regs[reg];
>>           break;
>>         case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>> +    case VC_ENDC_WATCH1_DATA1 ... VC_ENDC_WATCH1_DATA3:
>> +    case VC_ENDC_WATCH2_DATA1 ... VC_ENDC_WATCH2_DATA3:
>> +    case VC_ENDC_WATCH3_DATA1 ... VC_ENDC_WATCH3_DATA3:
>>           val = xive->vc_regs[reg];
>>           break;
>>   @@ -1064,6 +1275,7 @@ static void pnv_xive2_ic_vc_write(void 
>> *opaque, hwaddr offset,
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>       uint32_t reg = offset >> 3;
>> +    uint8_t watch_engine;
>>         switch (offset) {
>>       /*
>> @@ -1072,7 +1284,7 @@ static void pnv_xive2_ic_vc_write(void *opaque, 
>> hwaddr offset,
>>       case VC_VSD_TABLE_ADDR:
>>          break;
>>       case VC_VSD_TABLE_DATA:
>> -        pnv_xive2_vst_set_data(xive, val);
>> +        pnv_xive2_vc_vst_set_data(xive, val);
>>           break;
>>         /*
>> @@ -1084,6 +1296,10 @@ static void pnv_xive2_ic_vc_write(void 
>> *opaque, hwaddr offset,
>>           /* ESB update */
>>           break;
>>   +    case VC_ESBC_FLUSH_INJECT:
>> +        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ESBC);
>> +        break;
>> +
>>       case VC_ESBC_CFG:
>>           break;
>>   @@ -1096,19 +1312,36 @@ static void pnv_xive2_ic_vc_write(void 
>> *opaque, hwaddr offset,
>>           /* EAS update */
>>           break;
>>   +    case VC_EASC_FLUSH_INJECT:
>> +        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_EASC);
>> +        break;
>> +
>> +    case VC_ENDC_CFG:
>> +        break;
>> +
>>       /*
>>        * END cache updates
>>        */
>>       case VC_ENDC_WATCH0_SPEC:
>> +    case VC_ENDC_WATCH1_SPEC:
>> +    case VC_ENDC_WATCH2_SPEC:
>> +    case VC_ENDC_WATCH3_SPEC:
>>            val &= ~VC_ENDC_WATCH_CONFLICT; /* HW will set this bit */
>>           break;
>>         case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>> +    case VC_ENDC_WATCH1_DATA1 ... VC_ENDC_WATCH1_DATA3:
>> +    case VC_ENDC_WATCH2_DATA1 ... VC_ENDC_WATCH2_DATA3:
>> +    case VC_ENDC_WATCH3_DATA1 ... VC_ENDC_WATCH3_DATA3:
>>           break;
>>       case VC_ENDC_WATCH0_DATA0:
>> +    case VC_ENDC_WATCH1_DATA0:
>> +    case VC_ENDC_WATCH2_DATA0:
>> +    case VC_ENDC_WATCH3_DATA0:
>>           /* writing to DATA0 triggers the cache write */
>> +        watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>>           xive->vc_regs[reg] = val;
>> -        pnv_xive2_end_update(xive);
>> +        pnv_xive2_end_update(xive, watch_engine);
>>           break;
>>     @@ -1117,6 +1350,10 @@ static void pnv_xive2_ic_vc_write(void 
>> *opaque, hwaddr offset,
>>           xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= 
>> VC_ENDC_FLUSH_CTRL_POLL_VALID;
>>           break;
>>   +    case VC_ENDC_FLUSH_INJECT:
>> +        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ENDC);
>> +        break;
>> +
>>       /*
>>        * Indirect invalidation
>>        */
>> @@ -1158,12 +1395,42 @@ static const MemoryRegionOps 
>> pnv_xive2_ic_vc_ops = {
>>       },
>>   };
>>   +static uint8_t nxc_cache_watch_assign(PnvXive2 *xive)
>> +{
>> +    uint64_t engine_mask = GETFIELD(PC_NXC_PROC_CONFIG_WATCH_ASSIGN,
>> + xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
>> +    uint64_t state = xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3];
>> +    uint8_t val;
>> +
>> +    /*
>> +     * We keep track of which engines are currently busy in the
>> +     * PC_NXC_WATCH_ASSIGN register directly. When the firmware reads
>> +     * the register, we don't return its value but the ID of an engine
>> +     * it can use.
>> +     * There are 4 engines. 0xFF means no engine is available.
>> +     */
>> +    val = _cache_watch_assign(engine_mask, &state);
>> +    if (val != 0xFF) {
>> +        xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3] = state;
>> +    }
>> +    return val;
>> +}
>> +
>> +static void nxc_cache_watch_release(PnvXive2 *xive, uint8_t 
>> watch_engine)
>> +{
>> +    uint64_t state = xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3];
>> +
>> +    _cache_watch_release(&state, watch_engine);
>> +    xive->pc_regs[PC_NXC_WATCH_ASSIGN >> 3] = state;
>> +}
>> +
>>   static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>>                                        unsigned size)
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>       uint64_t val = -1;
>>       uint32_t reg = offset >> 3;
>> +    uint8_t watch_engine;
>>         switch (offset) {
>>       /*
>> @@ -1174,24 +1441,44 @@ static uint64_t pnv_xive2_ic_pc_read(void 
>> *opaque, hwaddr offset,
>>           val = xive->pc_regs[reg];
>>           break;
>>   +    case PC_NXC_WATCH_ASSIGN:
>> +        val = nxc_cache_watch_assign(xive);
>> +        break;
>> +
>> +    case PC_NXC_PROC_CONFIG:
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>>       /*
>>        * cache updates
>>        */
>>       case PC_NXC_WATCH0_SPEC:
>> +    case PC_NXC_WATCH1_SPEC:
>> +    case PC_NXC_WATCH2_SPEC:
>> +    case PC_NXC_WATCH3_SPEC:
>> +        watch_engine = (offset - PC_NXC_WATCH0_SPEC) >> 6;
>>           xive->pc_regs[reg] &= ~(PC_NXC_WATCH_FULL | 
>> PC_NXC_WATCH_CONFLICT);
>> +        nxc_cache_watch_release(xive, watch_engine);
>>           val = xive->pc_regs[reg];
>>           break;
>>         case PC_NXC_WATCH0_DATA0:
>> +    case PC_NXC_WATCH1_DATA0:
>> +    case PC_NXC_WATCH2_DATA0:
>> +    case PC_NXC_WATCH3_DATA0:
>>          /*
>>           * Load DATA registers from cache with data requested by the
>>           * SPEC register
>>           */
>> -        pnv_xive2_nvp_cache_load(xive);
>> +        watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>> +        pnv_xive2_nxc_cache_load(xive, watch_engine);
>>           val = xive->pc_regs[reg];
>>           break;
>>         case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>> +    case PC_NXC_WATCH1_DATA1 ... PC_NXC_WATCH1_DATA3:
>> +    case PC_NXC_WATCH2_DATA1 ... PC_NXC_WATCH2_DATA3:
>> +    case PC_NXC_WATCH3_DATA1 ... PC_NXC_WATCH3_DATA3:
>>           val = xive->pc_regs[reg];
>>           break;
>>   @@ -1215,36 +1502,66 @@ static uint64_t pnv_xive2_ic_pc_read(void 
>> *opaque, hwaddr offset,
>>       return val;
>>   }
>>   +static void pnv_xive2_pc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
>> +{
>> +    uint8_t type = GETFIELD(PC_VSD_TABLE_SELECT,
>> +                            xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
>> +    uint8_t blk = GETFIELD(PC_VSD_TABLE_ADDRESS,
>> +                           xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
>> +
>> +    __pnv_xive2_vst_set_data(xive, vsd, type, blk);
>> +}
>> +
>>   static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>>                                     uint64_t val, unsigned size)
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>>       uint32_t reg = offset >> 3;
>> +    uint8_t watch_engine;
>>         switch (offset) {
>>         /*
>> -     * VSD table settings. Only taken into account in the VC
>> -     * sub-engine because the Xive2Router model combines both VC and PC
>> -     * sub-engines
>> +     * VSD table settings.
>> +     * The Xive2Router model combines both VC and PC sub-engines. We
>> +     * allow to configure the tables through both, for the rare cases
>> +     * where a table only really needs to be configured for one of
>> +     * them (e.g. the NVG table for the presenter). It assumes that
>> +     * firmware passes the same address to the VC and PC when tables
>> +     * are defined for both, which seems acceptable.
>>        */
>>       case PC_VSD_TABLE_ADDR:
>> +        break;
>>       case PC_VSD_TABLE_DATA:
>> +        pnv_xive2_pc_vst_set_data(xive, val);
>> +        break;
>> +
>> +    case PC_NXC_PROC_CONFIG:
>>           break;
>>         /*
>>        * cache updates
>>        */
>>       case PC_NXC_WATCH0_SPEC:
>> +    case PC_NXC_WATCH1_SPEC:
>> +    case PC_NXC_WATCH2_SPEC:
>> +    case PC_NXC_WATCH3_SPEC:
>>           val &= ~PC_NXC_WATCH_CONFLICT; /* HW will set this bit */
>>           break;
>>         case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>> +    case PC_NXC_WATCH1_DATA1 ... PC_NXC_WATCH1_DATA3:
>> +    case PC_NXC_WATCH2_DATA1 ... PC_NXC_WATCH2_DATA3:
>> +    case PC_NXC_WATCH3_DATA1 ... PC_NXC_WATCH3_DATA3:
>>           break;
>>       case PC_NXC_WATCH0_DATA0:
>> +    case PC_NXC_WATCH1_DATA0:
>> +    case PC_NXC_WATCH2_DATA0:
>> +    case PC_NXC_WATCH3_DATA0:
>>           /* writing to DATA0 triggers the cache write */
>> +        watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>>           xive->pc_regs[reg] = val;
>> -        pnv_xive2_nvp_update(xive);
>> +        pnv_xive2_nxc_update(xive, watch_engine);
>>           break;
>>        /* case PC_NXC_FLUSH_CTRL: */
>> @@ -1252,6 +1569,10 @@ static void pnv_xive2_ic_pc_write(void 
>> *opaque, hwaddr offset,
>>           xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= 
>> PC_NXC_FLUSH_CTRL_POLL_VALID;
>>           break;
>>   +    case PC_NXC_FLUSH_INJECT:
>> +        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_NXC);
>> +        break;
>> +
>>       /*
>>        * Indirect invalidation
>>        */
>> @@ -1548,13 +1869,19 @@ static const MemoryRegionOps 
>> pnv_xive2_ic_lsi_ops = {
>>   /*
>>    * Sync MMIO page (write only)
>>    */
>> -#define PNV_XIVE2_SYNC_IPI      0x000
>> -#define PNV_XIVE2_SYNC_HW       0x080
>> -#define PNV_XIVE2_SYNC_NxC      0x100
>> -#define PNV_XIVE2_SYNC_INT      0x180
>> -#define PNV_XIVE2_SYNC_OS_ESC   0x200
>> -#define PNV_XIVE2_SYNC_POOL_ESC 0x280
>> -#define PNV_XIVE2_SYNC_HARD_ESC 0x300
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
>>     static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
>>                                          unsigned size)
>> @@ -1566,22 +1893,72 @@ static uint64_t pnv_xive2_ic_sync_read(void 
>> *opaque, hwaddr offset,
>>       return -1;
>>   }
>>   +/*
>> + * The sync MMIO space spans two pages.  The lower page is use for
>> + * queue sync "poll" requests while the upper page is used for queue
>> + * sync "inject" requests.  Inject requests require the HW to write
>> + * a byte of all 1's to a predetermined location in memory in order
>> + * to signal completion of the request.  Both pages have the same
>> + * layout, so it is easiest to handle both with a single function.
>> + */
>>   static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
>>                                       uint64_t val, unsigned size)
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    int inject_type;
>> +    hwaddr pg_offset_mask = (1ull << xive->ic_shift) - 1;
>>   -    switch (offset) {
>> +    /* adjust offset for inject page */
>> +    hwaddr adj_offset = offset & pg_offset_mask;
>> +
>> +    switch (adj_offset) {
>>       case PNV_XIVE2_SYNC_IPI:
>> +        inject_type = PNV_XIVE2_QUEUE_IPI;
>> +        break;
>>       case PNV_XIVE2_SYNC_HW:
>> +        inject_type = PNV_XIVE2_QUEUE_HW;
>> +        break;
>>       case PNV_XIVE2_SYNC_NxC:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC;
>> +        break;
>>       case PNV_XIVE2_SYNC_INT:
>> +        inject_type = PNV_XIVE2_QUEUE_INT;
>> +        break;
>>       case PNV_XIVE2_SYNC_OS_ESC:
>> +        inject_type = PNV_XIVE2_QUEUE_OS;
>> +        break;
>>       case PNV_XIVE2_SYNC_POOL_ESC:
>> +        inject_type = PNV_XIVE2_QUEUE_POOL;
>> +        break;
>>       case PNV_XIVE2_SYNC_HARD_ESC:
>> +        inject_type = PNV_XIVE2_QUEUE_HARD;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_LD_LCL_NCO:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_LD_LCL_CO:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_CO;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_ST_LCL_NCI:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_ST_LCL_CI:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_CI;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_ST_RMT_NCI:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI;
>> +        break;
>> +    case PNV_XIVE2_SYNC_NXC_ST_RMT_CI:
>> +        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
>>           break;
>>       default:
>>           xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, 
>> offset);
>> +        return;
>> +    }
>> +
>> +    /* Write Queue Sync notification byte if writing to sync inject 
>> page */
>> +    if ((offset & ~pg_offset_mask) != 0) {
>> +        pnv_xive2_inject_notify(xive, inject_type);
>>       }
>>   }
>>   @@ -1815,6 +2192,12 @@ static void pnv_xive2_reset(void *dev)
>>       xive->cq_regs[CQ_XIVE_CFG >> 3] |=
>>           SETFIELD(CQ_XIVE_CFG_HYP_HARD_BLOCK_ID, 0ull, 
>> xive->chip->chip_id);
>>   +    /* VC and PC cache watch assign mechanism */
>> +    xive->vc_regs[VC_ENDC_CFG >> 3] =
>> +        SETFIELD(VC_ENDC_CFG_CACHE_WATCH_ASSIGN, 0ull, 0b0111);
>> +    xive->pc_regs[PC_NXC_PROC_CONFIG >> 3] =
>> +        SETFIELD(PC_NXC_PROC_CONFIG_WATCH_ASSIGN, 0ull, 0b0111);
>> +
>>       /* Set default page size to 64k */
>>       xive->ic_shift = xive->esb_shift = xive->end_shift = 16;
>>       xive->nvc_shift = xive->nvpg_shift = xive->tm_shift = 16;
>
>
>
> Thanks,
>
> C.
>
>

