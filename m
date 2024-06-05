Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B1CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 20:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEwpI-0007hX-2w; Wed, 05 Jun 2024 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sEwpE-0007f4-UF; Wed, 05 Jun 2024 16:01:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sEwpC-00037G-2e; Wed, 05 Jun 2024 16:01:36 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 455JehDt018883; Wed, 5 Jun 2024 20:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=yhZVHb2AdOAeY1SYY359oeHtz38b493XinPya2+bVoM=;
 b=JP99lc3ZVHK90nsr2/TgSsW4+81N/SU2hyrFUj2owSX6Og6fqMBqVS6guHKwLNdK/wkd
 ukxZ7ec/CLUJtFICrRsI4y2uQGt3nrHk1loGgi/sIq0v+VtQjd9PNFEIFVQ+OJ7R/b3s
 wyRTGOBIY74Wjp/Y3l9+mjoBAGKhmE3EbHjesfX0va1q1IW7gvybVJHN3GbB4/KWnDWc
 +mw/DfavZ102kNmpVb+9MyR60NrmXH8wMijqxEC5Xilcm2T3IYnNN/YpB5HUhHI+h47z
 RM/KpFpmxlBc7lII78OM4cW/yJZAcvhV1PJyhuf/FJi/NvmoIWe2jx4cQykjvmzXiE22 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjx43g32s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 20:01:29 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 455K1ToB020853;
 Wed, 5 Jun 2024 20:01:29 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjx43g32n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 20:01:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 455HNTFL026521; Wed, 5 Jun 2024 20:01:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp35rxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 20:01:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 455K1OCI23396882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jun 2024 20:01:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ED4B58061;
 Wed,  5 Jun 2024 20:01:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0380658067;
 Wed,  5 Jun 2024 20:01:24 +0000 (GMT)
Received: from [9.67.134.30] (unknown [9.67.134.30])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Jun 2024 20:01:23 +0000 (GMT)
Message-ID: <0f90fc59-7c49-4ceb-a97a-2f5f07230f09@linux.ibm.com>
Date: Wed, 5 Jun 2024 16:01:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390x: Build IPLB chain for multiple boot devices
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-4-jrossi@linux.ibm.com>
 <722f7af6-a5f0-4528-a327-a897255f7ea8@redhat.com>
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <722f7af6-a5f0-4528-a327-a897255f7ea8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qeh4eEPxRbxQTFu90Lr1UCk4DArUBHFi
X-Proofpoint-GUID: IY1hhDZz0OgUAqyHT8Ys-q68JD0GjzKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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


On 6/4/24 2:26 PM, Thomas Huth wrote:
> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Write a chain of IPLBs into memory for future use.
>>
>> The IPLB chain is placed immediately before the BIOS in memory at the 
>> highest
>> unused page boundary providing sufficient space to fit the chain. 
>> Because this
>> is not a fixed address, the location of the next IPLB and number of 
>> remaining
>> boot devices is stored in the QIPL global variable for later access.
>>
>> At this stage the IPLB chain is not accessed by the guest during IPL.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.h              |   1 +
>>   include/hw/s390x/ipl/qipl.h |   4 +-
>>   hw/s390x/ipl.c              | 129 +++++++++++++++++++++++++++---------
>>   3 files changed, 103 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 1dcb8984bb..4f098d3a81 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -20,6 +20,7 @@
>>   #include "qom/object.h"
>>     #define DIAG308_FLAGS_LP_VALID 0x80
>> +#define MAX_IPLB_CHAIN 7
>>     void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
>>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error 
>> **errp);
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index a6ce6ddfe3..481c459a53 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -34,7 +34,9 @@ struct QemuIplParameters {
>>       uint8_t  reserved1[3];
>>       uint64_t netboot_start_addr;
>>       uint32_t boot_menu_timeout;
>> -    uint8_t  reserved2[12];
>> +    uint8_t  reserved2[2];
>> +    uint16_t num_iplbs;
>> +    uint64_t next_iplb;
>>   }  QEMU_PACKED;
>>   typedef struct QemuIplParameters QemuIplParameters;
>>   diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 2d4f5152b3..79429acabd 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -55,6 +55,13 @@ static bool iplb_extended_needed(void *opaque)
>>       return ipl->iplbext_migration;
>>   }
>>   +/* Start IPLB chain from the boundary of the first unused page 
>> before BIOS */
>
> I'd maybe say "upper boundary" to make it clear that this is at the 
> end of the page, not at the beginning?

The chain does start at the beginning of a page.  That being said, the 
comment still needs to be reworded, I'm just not sure exactly how.  
"Start the IPLB chain from the nearest page boundary providing 
sufficient space before BIOS?"  Basically because each IPLB is 4K, the 
chain will occupy the N unused pages before the start of BIOS, where N 
is the number of chained IPLBS (assuming 4K pages).

>
>> +static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t 
>> count)
>> +{
>> +    return (bios_addr & TARGET_PAGE_MASK)
>> +            - (count * sizeof(IplParameterBlock));
>> +}
>> +
>>   static const VMStateDescription vmstate_iplb_extended = {
>>       .name = "ipl/iplb_extended",
>>       .version_id = 0,
>> @@ -391,6 +398,17 @@ static CcwDevice 
>> *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>>       return ccw_dev;
>>   }
>>   +static void s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>> +{
>> +    S390IPLState *ipl = get_ipl_device();
>> +    uint16_t count = ipl->qipl.num_iplbs;
>> +    uint64_t len = sizeof(IplParameterBlock) * count;
>> +    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, 
>> count);
>> +
>> +    cpu_physical_memory_write(chain_addr, iplb_chain, 
>> be32_to_cpu(len));
>
> The be32_to_cpu looks wrong here, since you just computed len in 
> native endianness.
>

I'll check it out.

>> +    ipl->qipl.next_iplb = chain_addr;
>
> Just a matter of taste, but I'd prefer to set ipl->qipl.next_iplb in 
> the same function where you set ipl->qipl.num_iplbs ... so I'd rather 
> return chain_addr here and then do this on the calling site:
>
>     ipl->qipl.next_iplb = s390_ipl_map_iplb_chain(...);

That should be doable; I'll change it for v2.

>> [snip...]
>>
>> @@ -487,6 +502,58 @@ static bool s390_gen_initial_iplb(S390IPLState 
>> *ipl)
>>       return false;
>>   }
>>   +static bool s390_init_all_iplbs(S390IPLState *ipl)
>> +{
>> +    int iplb_num = 0;
>> +    IplParameterBlock iplb_chain[7];
>> +    DeviceState *dev_st = get_boot_device(0);
>> +
>> +    /*
>> +     * Parse the boot devices.  Generate an IPLB for the first boot 
>> device,
>> +     * which will later be set with DIAG308. Index any fallback boot 
>> devices.
>> +     */
>> +    if (!dev_st) {
>> +        ipl->qipl.num_iplbs = 0;
>> +        return false;
>> +    }
>> +
>> +    iplb_num = 1;
>> +    s390_build_iplb(dev_st, &ipl->iplb);
>> +    ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
>> +
>> +    while (get_boot_device(iplb_num)) {
>> +        iplb_num++;
>> +    }
>> +
>> +    ipl->qipl.num_iplbs = iplb_num - 1;
>
> It's somewhat confusing that ipl->qipl.num_iplbs is one less than 
> iplb_num ... what does ipl->qipl.num_iplbs exactly define? The amount 
> of additional chained devices beside the first one?
>
> A comment either here or qipl.h that describes the exact meaning of 
> num_iplbs would be helpful.
>
>> +
>> +    /*
>> +     * Build fallback IPLBs for any boot devices above index 0, up to a
>> +     * maximum amount as defined in ipl.h
>> +     */
>> +    if (iplb_num > 1) {
>> +        if (iplb_num > MAX_IPLB_CHAIN) {
>> +            warn_report("Excess boot devices defined! %d boot 
>> devices found, "
>> +                        "but only the first %d will be considered.",
>> +                        iplb_num, MAX_IPLB_CHAIN + 1);
>> +            iplb_num = MAX_IPLB_CHAIN + 1;
>
> What's now the real maximum number of iplb_num ? If it is 
> MAX_IPLB_CHAIN + 1 then the if-statement above looks wrong, should it 
> be "if (iplb_num > MAX_IPLB_CHAIN + 1)" instead?
>
>> +        }
>> +
>> +        ipl->qipl.num_iplbs = iplb_num - 1;
>
> You could move that into the body of the above if-statement, since 
> otherwise the value has been set earlier in this function already.
>
>> +        /* Start at 1 because the IPLB for boot index 0 is not 
>> chained */
>> +        for (int i = 1; i < iplb_num; i++) {
>
> Just to double-check: Is "i < iplb_num" right?
> Or should it be "i <= iplb_num" instead?

Sorry that I did not realize how poorly named the variables are here.  I 
will rename them in v2, which I think will clarify all of these 
comments/questions (and you are correct that the warning message is off 
by one), but in the meantime the gist of it is that ipl->qipl.num_iplbs 
tracks the number of chained IPLBs only (so it is one less than the 
total boot devices).  MAX_IPLB_CHAIN should also probably be 
MAX_BOOT_DEVS instead.  I could change "num_iplbs" to "chained_iplbs" 
and similarly "iplb_num" could be changed to "num_boot_devs" to make it 
more clear what is going on:

     ipl->qipl.chained_iplbs = num_boot_devs - 1;

>
> BTW, have you successfully tested booting with 8 devices that all have 
> a boot index, but only the last one is bootable?

Yes.  I will write an automated test to include in v2 also.

Regards,

Jared Rossi



