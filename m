Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B78C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphb7-0002Bk-LZ; Fri, 31 Jul 2026 03:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wphb4-0002Bc-PA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:23:58 -0400
Received: from [115.124.28.97] (helo=out28-97.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wphb1-0007HJ-5d
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:23:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08424093|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0166486-0.00529842-0.978053;
 FP=2869144909575110999|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045213054;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.ia3Fx5Z_1785482500; 
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ia3Fx5Z_1785482500 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 15:21:41 +0800
Message-ID: <ac3191b2-daee-40d7-8a26-51ac9fca2c5a@open-hieco.net>
Date: Fri, 31 Jul 2026 15:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-5-zhang_wei@open-hieco.net>
 <amxJf2elltpmBHFD@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amxJf2elltpmBHFD@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.97 (deferred)
Received-SPF: pass client-ip=115.124.28.97;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-97.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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



On 7/31/2026 3:06 PM, Zhao Liu wrote:
>> +/*
>> + * Use AMD-style MCE status records for QEMU-injected memory failures on
>> + * AMD and Hygon CPUs.
>> + */
>> +static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
>> +{
>> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
>> +}
>> +
>>   static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>>   {
>>       CPUState *cs = CPU(cpu);
>> @@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>>       uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
>>       int flags = 0;
>>   
>> -    if (!IS_AMD_CPU(env)) {
>> +    if (!kvm_mce_inject_uses_amd_status(env)) {
> 
> Maybe we can check hygon directly here?
Yes. Since there is only one user of this helper, keeping the check 
inline is clearer. I'll update it in the next version.


Thanks,
Tina


