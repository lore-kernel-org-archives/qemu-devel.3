Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F0ACF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSv5-0006Mi-Lb; Thu, 03 Oct 2024 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSv4-0006MJ-25
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:59:30 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSv1-0008E6-Rk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:59:29 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so1459802e87.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727989166; x=1728593966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YTgKq4VoQ/uwlOIQTH0KDZ7hgfPURLwKhBkke9AV0zo=;
 b=Cm1LCry/0Jao9KSGVWvUd1DTyeC+T0A8sHV2tYip1Bd+pyAMF6t1ERtw97OZpZRZtI
 qiWFfk4dnERbGVi7Dg6yY6HRMI6dV2YqSQ1ZrWxO0ciYxlANxcdS8PtHVlTlGKyyaj9+
 z/7dlhV0zaOV46+nsED7QqIctfeBDkwlBlAiNE+ha1jvhGlNFm5AvVp3aGycuNH4zs+M
 h/VlLH9rVYgBn9vJguCR4+///n/PZeIXJ8WA9PjLk4fyRrOIQLTNvEUcltkJFRcrQFcm
 vzs0A3mHMn2TxKx74nwopdz6Os1jPYBkTwry5pWVm3eWGn46pvAquTHLoSyc5EiwY2oS
 /amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727989166; x=1728593966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTgKq4VoQ/uwlOIQTH0KDZ7hgfPURLwKhBkke9AV0zo=;
 b=Z9cWTiA4MO2OFl0FMnYIZeOsunVmIRFG4ARIp3CUYpV6tIRk65IQPJ9TOf1BnvAzBj
 dDocUF4GtccRfoz781+BD06dlRh52fid/Zm1B1HlVljRkFXJmFKTF11Tb37WEa/RuIq9
 68b0AaFfflmjRwbV8q/xu6faQXrmZgFEf0O2lqQwJgI/PHAjnTpJhLcNxvRjYNuBDa9u
 0h1twM47hw2fRrWIKjFrPr+JvnKupRnLJW8HDD/kkWk5pJ8Rw6GFg903GS+fiZh9xjtD
 rFidIHYbIzWBk+8ez4hvf2S6Li0DNjKqkoalGj+zgsQBVQ37VbzvGPwB27x60B1RwS5R
 /U1w==
X-Gm-Message-State: AOJu0Yxae2uJxXBgNKpWDwB2NFRbpF87GwfIa2OGpbFYOoE9+kaIlHL2
 oXO/4BQ/j/CQL9oexORcvhgNJ8mE1I1/YlqJda1O95RYN1jPXIQQa3eHqgbYr0U=
X-Google-Smtp-Source: AGHT+IHf2OoOB+7ighGkuRIODz1kYtzZ5WbQUyMqcXkWNaNbW+5sVmrWpMb55GL/sg+kOL1rG4Aq7g==
X-Received: by 2002:a05:6512:33ce:b0:536:741a:6bad with SMTP id
 2adb3069b0e04-539ab85b43cmr351887e87.12.1727989165741; 
 Thu, 03 Oct 2024 13:59:25 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79d8d3edsm52344535e9.7.2024.10.03.13.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 13:59:25 -0700 (PDT)
Message-ID: <e898c191-23f8-4e5d-9361-0ae7e8c5b78b@linaro.org>
Date: Thu, 3 Oct 2024 22:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 eblake@redhat.com, armbru@redhat.com, ajones@ventanamicro.com
References: <20240919112056.620917-1-dbarboza@ventanamicro.com>
 <ZuwXjyqhxwHBEvR_@redhat.com>
 <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
 <ZvaN7-W4VLr6TGsm@redhat.com>
 <046df1e9-5e4c-4f1c-8edb-1ee1244fe340@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <046df1e9-5e4c-4f1c-8edb-1ee1244fe340@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 2/10/24 20:06, Daniel Henrique Barboza wrote:
> 
> 
> On 9/27/24 7:50 AM, Daniel P. Berrangé wrote:
>> Markus: QAPI design Qs for you at the bottom
>>
>> On Wed, Sep 25, 2024 at 10:19:33AM -0300, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 9/19/24 9:22 AM, Daniel P. Berrangé wrote:
>>>> On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza 
>>>> wrote:
>>>>> Add a QMP command that shows all specific properties of the current
>>>>> accelerator in use.
>>>>
>>>> Why do we need to expose /everything/ ?
>>>
>>> I wouldn't mind pick and choose advertised properties for the 
>>> accelerators
>>> like we do with other APIs.
>>>
>>> This would mean that each arch should choose what to advertise or 
>>> not, given that
>>> some accelerator properties might be relevant just for some archs. 
>>> The API would
>>> be implemented by each arch individually.
>>
>> Well with qemu-system-any we might get multiple arches reporting
>> info in the same binary, so we'll need to fan out to fill in the
>> per-arch info, after doing a common base.
>>
>> Hmmm, i wonder if qemu-system-any will support mixing KVM and TCG ?
>> ie KVM for the host native accelerator, combined with TCG for the
>> foreign archs ??? Hopefully not !
> 
> If you're talking about Phil's patches it seems that it'll be TCG only:

Orthogonaly to the single binary series (mentioned below with the
'any'-architecture target), we plan to add a "Dual HW/SW accelerator".
It will be implemented using the same AccelOps structure we currently
have, and internally it will dispatch between HW/SW. First prototype
plan to provide HVF+TCG.

IMHO query-accelerator should expose accelerator generic properties,
not the target-specific ones. At least by default, we could add an
optional flag to include target-specific stuff. At least that'd keep
the core accel core simpler.

> https://lore.kernel.org/qemu-devel/20240305220938.85410-1-philmd@linaro.org/
> 
> Patch 2 commit msg states:
> 
> ------
> Add the 'any'-architecture target.
> 
> - Only consider 64-bit targets
> - Do not use any hardware accelerator (except qtest)
> - For architecture constants, use:
>    . max of supported targets phys/virt address space
>    . max of supported targets MMU modes
>    . min of supported targets variable page bits
> ------
> 
> 
> Thanks,
> 
> Daniel


