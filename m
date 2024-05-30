Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08AAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgva-0001bk-IG; Thu, 30 May 2024 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCgvZ-0001bB-1K; Thu, 30 May 2024 10:38:49 -0400
Received: from red-soft.ru ([188.246.186.2] helo=gw.red-soft.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCgvW-0007lN-MK; Thu, 30 May 2024 10:38:48 -0400
Received: from [10.81.100.51] (unknown [10.81.100.51])
 by gw.red-soft.ru (Postfix) with ESMTPA id B8A4E3E1C97;
 Thu, 30 May 2024 17:38:40 +0300 (MSK)
Message-ID: <bc1ccfd3-164f-8179-8209-80af79e41deb@red-soft.ru>
Date: Thu, 30 May 2024 17:38:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/net: prevent potential NULL dereference
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
 <219da54c-7c9d-4baf-ba0c-d4afb6101cbe@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?0J7Qu9C10LMg0KHQstC40YDQuNC00L7Qsg==?=
 <oleg.sviridov@red-soft.ru>
In-Reply-To: <219da54c-7c9d-4baf-ba0c-d4afb6101cbe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 185620 [May 30 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: oleg.sviridov@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2; red-soft.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/05/30 13:08:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30,
 bases: 2024/05/30 00:42:00 #25335358
X-KLMS-AntiVirus-Status: Clean, skipped
Received-SPF: pass client-ip=188.246.186.2;
 envelope-from=oleg.sviridov@red-soft.ru; helo=gw.red-soft.ru
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.299,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thanks for review.

Would it be correct to use hcall_dprintf() as in other functions of the 
module? For example, in h_add_logical_lan_buffer().

Best regards,
Oleg.

29.05.2024 16:52, Philippe Mathieu-Daudé пишет:
> On 29/5/24 13:07, Oleg Sviridov wrote:
>> Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL 
>> and is dereferenced immediately after.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
>> ---
>>   hw/net/spapr_llan.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
>> index ecb30b7c76..f40b733229 100644
>> --- a/hw/net/spapr_llan.c
>> +++ b/hw/net/spapr_llan.c
>> @@ -770,6 +770,10 @@ static target_ulong 
>> h_change_logical_lan_mac(PowerPCCPU *cpu,
>>       SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>>       int i;
> 
> Trying to change a MAC when no NIC is present is dubious, we could
> at least report this using qemu_log_mask(LOG_GUEST_ERROR).
> 
>> +    if (!dev) {
>> +        return H_PARAMETER;
>> +    }
>> +
>>       for (i = 0; i < ETH_ALEN; i++) {
>>           dev->nicconf.macaddr.a[ETH_ALEN - i - 1] = macaddr & 0xff;
>>           macaddr >>= 8;
> 

