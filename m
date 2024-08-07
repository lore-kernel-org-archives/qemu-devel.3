Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D6C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbb9Y-00035D-OD; Wed, 07 Aug 2024 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb9U-00033N-3U
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:32:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb9Q-0000Mf-Q4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:32:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso748702f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723015922; x=1723620722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9U8WkO1kK/7k7XuzE7kO1kaVhMx9sxV/6/7scjLh188=;
 b=eDbRhMIydLGogr2C7ba8qcCfcL8NKokrLaRnzuRqTdbLpR+Hny1fmfI27nxwZUXd5l
 9eHZdbqi9KzLQgiH0cbt62Kb6Cy1YcL1iwfc6FJ7kcKYNMjznzBMpgBvo2ONIoO/utaN
 br5hyiJUw54I6c9NltxWUEusUFYD2Jrt/AUQPgk6e508QcD4ogC3GovRAViM7VVY4b/j
 dvtGM2ySEP8bkcXXGTUyxJ5UeaBLVU+Zb0kQOqEpH3Cdf7Ws4PLUei3iI3XmrlOcJhPF
 d4WyCo0Oadgw+vhHZt/jchmpEeZIWWZ0u0UPV/oUfE+cpYiCJzh5ew3AE+NLFAnNmQ9k
 kJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723015922; x=1723620722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9U8WkO1kK/7k7XuzE7kO1kaVhMx9sxV/6/7scjLh188=;
 b=VmCiB6By8X3UUTsQWUPmrf2/PwOwkQj0r61rzPbzIZiu27yG8qcb3xlHRhdsbgzUI2
 NKnWkgM2hcuwHyGqTFLMWhHto7fuuVkXM3sqNGYU24Xo7ybnSD2Q+AghObv6KXgzAhgd
 M3ULVSQJqsXKel1WaNFQcIzkHhS7SNaBKtcGNDTSg6ity0F1A7VJQb1Qawn3KHglJtVH
 qZp499oWkJ2/UxNYYmTUxZOsAE/0teUc/MS5fTeLrYi5ctNp+fBP5jciadmR/nqALrxQ
 Bi0Vjj+dS6vwAvi7RSZOAbHnIGpcQr1+Ttx8aDhnq5dSqbByYUEiNz9mAg6ZKlgPK+NB
 RR0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMF9VuIAAKmuYMjrpMOe6AQiXQO4yn2dwA6YpfjNjoBeq4CHGtQQTSK0007Z6mGcAZi6xjlgOuQtp7IdxD8a0GkoGG4tU=
X-Gm-Message-State: AOJu0Yz5J0yiIarc4oXqjWbUqHw7kiPKcgpU20pk50ccg1cns4BynDkq
 89gxtqtL2n9CVkkmuOaa0p7aKcIlz26gYDTre6tHclyYub5P4PF5GETmnpOQJJE=
X-Google-Smtp-Source: AGHT+IFbgMtzhQELWl3Ro43IG33irM5ohuE+10OClIuFBR8E3t1w75tVt3p1G+Sn+YALDHfKTetSCQ==
X-Received: by 2002:adf:e7c5:0:b0:368:12ef:92cf with SMTP id
 ffacd0b85a97d-36bbc153c80mr13269772f8f.48.1723015922209; 
 Wed, 07 Aug 2024 00:32:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d314sm15086266f8f.95.2024.08.07.00.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 00:32:01 -0700 (PDT)
Message-ID: <86393cd8-a34e-4b28-8f89-dc965f04b1b6@linaro.org>
Date: Wed, 7 Aug 2024 09:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/24 05:46, Richard Henderson wrote:
> On 8/7/24 00:19, Philippe Mathieu-Daudé wrote:
>> qmp_query_gic_capabilities() is not specific to the ARM
>> architecture but to the GIC device which is modelled in
>> hw/intc/, so move the code there for clarity.
> 
> But the GIC is certainly arm architecture specific.
> It's built into the CPU, and shares state.

Yes... but there are also SoC with ARM cores, GIC and non-ARM cores ;)
Example: ZynqMP with MicroBlaze cores.

> The fact that it's modeled in hw/intc/ and not in target/arm/ has always 
> been a needle in the side, though it seems there are no good options.
> 
>> @@ -39,6 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>>   endif
>>   specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 
>> 'apic_common.c'))
>> +specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: 
>> files('arm_gicv3_cpuif_common.c'))
> 
> Is it more or less confusing that you're not using CONFIG_ARM_GIC, for 
> something that is GIC related?

(You figured in the next patch) this commit aims to be "no logical
change" to indeed use CONFIG_ARM_GIC in the next (simpler) patch.


