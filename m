Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDCBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 07:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbxCd-00086A-W2; Thu, 08 Aug 2024 03:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbxCa-00085T-8v
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:04:48 -0400
Received: from [2607:7c80:54:3::138] (helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbxCY-0000Yj-FF
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:04:48 -0400
Received: from [192.168.7.205] ([71.202.166.45]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47874gci1167508
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
 for <qemu-devel@nongnu.org>; Thu, 8 Aug 2024 00:04:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47874gci1167508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723100683;
 bh=5Um7rAFFnT5Tiac91F0HG0ItDj1eAbLEa90R0NX03dw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=RyKJfAK6CiOaddB7IGCEqPAtdbFB1ponfzwflU0ODiX8ilxtPJg3rd8ruk2Cgax+O
 QJUCHQg8c0n0WoqNcvVCXEwD9Q4Orz6ub72DChnBabrz+Srd+ly5KkqFyyHWu+CDCW
 F9fAUuI4WjAR+UN4f0xzjlAHQY7HgXxL2mRwN3Na9+SzMiSq/cQJeoc73K14RMJami
 bJ8PEvJ9gMHjzIAANGNOy3D1VUjtZ5MCnJUSaYAykihnBBi19WWO8izxLtCOV5+04w
 7qhl8HGTxgqNpTuajyU6Kc1Vc+gW0e2m7s8IMfsbbkQFeqiArhNd+o4u9695aNdYmn
 03Z0AGugRUutg==
Message-ID: <f4422fc2-d8fc-4902-80c7-0e2dda5bba59@zytor.com>
Date: Thu, 8 Aug 2024 00:04:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
To: qemu-devel@nongnu.org
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-3-xin@zytor.com> <ZrOZkYuSKhYH0ymi@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ZrOZkYuSKhYH0ymi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:7c80:54:3::138
 (failed)
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/7/2024 8:58 AM, Zhao Liu wrote:
> On Wed, Aug 07, 2024 at 01:18:11AM -0700, Xin Li (Intel) wrote:
>> @@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>               "vmx-exit-save-efer", "vmx-exit-load-efer",
>>                   "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
>>               NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
>> -            NULL, "vmx-exit-load-pkrs", NULL, NULL,
>> +            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
> 
> Oh, the order of my reviews is mixed up.
> It's better to move VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS into this patch.

Usually a simple definition is added in a patch where it is used, not in
qemu?

>>           },
>>           .msr = {
>>               .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
>> @@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>               NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>>               NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
>>               "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
>> -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
>> +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
> 
> Should we also define VMX_VM_ENTRY_LOAD_FRED? "vmx-entry-load-rtit-ctl"
> and "vmx-entry-load-pkrs" have their corresponding bit definitions, even
> if they are not used.

I'm not sure, but why add something that is not being used (thus not
tested)?



