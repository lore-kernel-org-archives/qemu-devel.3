Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C730C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbcaO-0000fV-0v; Wed, 07 Aug 2024 05:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbcaM-0000eT-Qi
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:03:58 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbcaK-0004Fg-Vv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:03:58 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso16738121fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723021435; x=1723626235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1Q94/zg0X3fLzs3pCmUXZzOPeJTeXK+OTu8CaU5ZlI=;
 b=vQWr75mMmPJn0QBZNm4fTuMQc5sll6eYKBit4rn8Cu0EeoejsE8BABRDF6O7WEuQRK
 RhedWCBd90SeBwiWqvs+1cyLvorcKkJWkQrct40uKkv6iMmNrEWEOFbrju6trm+xmQA0
 E41X38obPq4steJPV+ZRavuAioCQIK9fiBC31d8+YWlclUsRXSOHUvs0Nci25UlnN43T
 LX/ZJ5vn6v5gbcCjFOHbTrWycXfdan1dDeohbg/Za/eUxnE29yjmmYLIue8/IlIT0qP9
 LdxatI4g9085jNpsf0yVjKPVzuW3Kpsq+7FMWAMzubMymd64skUkOj43iQcefcA5f2QO
 iIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723021435; x=1723626235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1Q94/zg0X3fLzs3pCmUXZzOPeJTeXK+OTu8CaU5ZlI=;
 b=TC3YWjM6PYXifaWyliJXo+awhE8gktot/Uj5h42PBazSO2CeCK5IMx53LPx5EFwPLo
 07fmHyMIosklIE3IpgJ/IE7bSvmt0UL0zIlDOHDRlhjOSZLh3GXRM2nTiu9AuS0uGbfg
 piS0mBInSWX6gA1GXWP9bL2+kpVy+YF3RqFr4Q7Xj+IEphgnk4Mln8aVh5mNqvEf5X5f
 huSHVjLxi2q4zzBipIsW763cGnmHAoaUTgFvBQLCb/CX5m94ROtDYgSTOUmInSazvPLi
 /JN45xdpbl3yw2HAxrzonAxnVy1HGmeMKF5KtCMankcm80fyF29U50CTmmstkQyr/143
 65iA==
X-Gm-Message-State: AOJu0Yx5eWTWo/e9ExRDFRlWmWdvrtzd/yhmSpbomEQ7Dbf41PQmAuh8
 H0ScB7vdIl6twVZXm6tKheQHY2zjHlSMC7EWIW8JfaiJI2zOcZ9pInOHnHtzUHg=
X-Google-Smtp-Source: AGHT+IHjWuD1qLXj5yw6CCCa5bYqgCZFCcvTB1eyLFBBYNvNNc2uU9pYvYzZ3xDR2HD6UUSCCjPvMQ==
X-Received: by 2002:a2e:91d0:0:b0:2f0:32f1:896d with SMTP id
 38308e7fff4ca-2f15aabce68mr129308041fa.23.1723021434620; 
 Wed, 07 Aug 2024 02:03:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06fbfdsm15137654f8f.106.2024.08.07.02.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 02:03:54 -0700 (PDT)
Message-ID: <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org>
Date: Wed, 7 Aug 2024 11:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org> <87o764yce3.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o764yce3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/8/24 10:18, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> When configuring QEMU with --without-default-devices and
>> not including machines using a GIC, the GIC model is not
>> built in but the 'query-gic-capabilities' command still
>> returns false hopes about GIC:
>>
>>    {"execute": "query-gic-capabilities"}
>>    {"return": [{"emulated": true, "version": 3, "kernel": false}, {"emulated": true, "version": 2, "kernel": false}]}
>>
>> Restrict the command to when the GIC is available. If it
>> isn't we'll get:
>>
>>    { "execute": "query-gic-capabilities" }
>>    {"error": {"class": "CommandNotFound", "desc": "The command query-gic-capabilities has not been found"}}
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2484
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/misc-target.json | 4 ++--
>>   hw/intc/arm_gic_qmp.c | 2 ++
>>   hw/intc/meson.build   | 2 +-
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 8d70bd24d8..b857e44c2e 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -316,7 +316,7 @@
>>     'data': { 'version': 'int',
>>               'emulated': 'bool',
>>               'kernel': 'bool' },
>> -  'if': 'TARGET_ARM' }
>> +  'if': 'CONFIG_ARM_GIC' }
>>   
>>   ##
>>   # @query-gic-capabilities:
>> @@ -335,7 +335,7 @@
>>   #                     { "version": 3, "emulated": false, "kernel": true } ] }
>>   ##
>>   { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
>> -  'if': 'TARGET_ARM' }
>> +  'if': 'CONFIG_ARM_GIC' }
>>   
>>   ##
>>   # @SGXEPCSection:
>> diff --git a/hw/intc/arm_gic_qmp.c b/hw/intc/arm_gic_qmp.c
>> index 71056a0c10..1fc79c775b 100644
>> --- a/hw/intc/arm_gic_qmp.c
>> +++ b/hw/intc/arm_gic_qmp.c
>> @@ -6,6 +6,8 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qapi/util.h"
>> +
>> +#include CONFIG_DEVICES
> 
> Uh, why do we need this now?

Now qapi-commands-misc-target.h is generated guarded with
'#ifdef CONFIG_ARM_GIC', and CONFIG_ARM_GIC is defined per
target in CONFIG_DEVICES.

I'll update the patch description, but does this makes
sense to you? QAPI headers don't include headers defining
guards, we have to include them manually where we use QAPI
headers.

> 
>>   #include "qapi/qapi-commands-misc-target.h"
>>   #include "kvm_arm.h"
>>   
>> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
>> index 45d3503d49..b9550967e2 100644
>> --- a/hw/intc/meson.build
>> +++ b/hw/intc/meson.build
>> @@ -39,7 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>>   endif
>>   
>>   specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
>> -specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
>> +specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gic_qmp.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> 


