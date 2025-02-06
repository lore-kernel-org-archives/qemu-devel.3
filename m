Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D9C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfysS-0001Ty-EF; Thu, 06 Feb 2025 05:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfysQ-0001SY-5n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:12:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfysL-0002Hf-Ov
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:12:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dc1dfd9f2so171603f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738836768; x=1739441568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=74qmYuiEHZsoW3qpFUrxotGCmscxu7yjDuGjZCX+Wj4=;
 b=FavQIoe8K4z4kG9CRNFVQgkIPyME1YRyt6NwqjfPxDljRyG4Z5n4ZHfwDhh+oVeKJN
 +BV0GOtoDkkMRHvPsa48XWktLIJ1jnOYahks0fpRpKE9aV4OIchD07ON14+vvEHTLJr6
 cBsbDNtTsLjUkJC19BgVjXvx9ibIExG3qEwonkHazYgE3vD2x7CQEXYpyEIgFX0lQOHi
 zCcDKpD2CPkSdH6jmUMJbp71bnXU0dJhe2hGg26wY1+VKSkpnUtpEoTb354PqpiauyKT
 k/U0NUwDnvG85eljxpLTOlLgkeI3RqgcMPS8eplDNTMspud1ELurwqF0HG1zxpNqTevo
 8egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738836768; x=1739441568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=74qmYuiEHZsoW3qpFUrxotGCmscxu7yjDuGjZCX+Wj4=;
 b=g2MV5/pnBTaTbkVXuLEBGj9XHk8UAVkSr6FXhzh22n2Plz7HYNhD0kKiUTKboBnUiA
 GBGOqHwlgW9f9czaPW8MhR/YRTEjMlt0hMUWN7ltA+57vPmfhuLEJ9Jl23uCaGQc7B7d
 FbxmZvqJlZULbZjC4ceqTQeyEmK4pWS4Aaf8jyU84l6WSt28SKlEEaMhUW5NIw9xrIpe
 Wqe9qC0WbosNHRh3+xWlv490kv9EyvkWtYXkHb8CHEuuGIjMfBcbTIVN2uHbnhrPnzId
 kBb1ZVWD+drmzJKp+AGYl6XcR9ChfiCZ0e7id0k8vtgnuVXaMlqXrfV8yk8cf4n1Vid5
 Doiw==
X-Gm-Message-State: AOJu0YzKb4o+XCWiwLDAdlJnR3oI/0MUuWRNiOzcJ+A1C/N4fj7/tLwo
 Lp+dbzztHSXxlt86j2r84XsiQzJoBWO7+zuyocDw9jAR/UCbdmKaMxuDX0VvEx8=
X-Gm-Gg: ASbGncvQvM1GpCHVKiBYt+rAu3CTDjmz1NSfY3TlEKIBl5Tj0N+Pv16CmPHWyKBu4gp
 +PjjdTGCc+TvykoDsxP3FU+dSy5AgQ8Yb/Dxqwdw156VP15IrDJTEAYAqaood9uMI8JWeES453H
 q7H2z3RGpINx5W7B2q7SrmTnuUoMl9mnj2nXywhUeB9CQ5SJUJNMBV9QbUs7vAfqpWutE9Gqi86
 hsEn4U4O7JUODs4wQKf6cOnUzKxhmWiFp0nZPU0H65T5cKEU/hjiSwfQeRmHomZr5w8+0/Qq4Hx
 s9GKktZKzF8AB4qAB7cUzC4c6XS2J2uIFlvvmRwd8pip0aYAGuNZlig2o+k=
X-Google-Smtp-Source: AGHT+IG8UN2JRUsaTbO/GEIpX0lp3+G9jpKZxO8CSvmHpdU80rjLnqFlC5G5cIUzm1EWYeXdfMw9rg==
X-Received: by 2002:a05:6000:a8a:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-38db48fec0bmr3972471f8f.52.1738836767869; 
 Thu, 06 Feb 2025 02:12:47 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1b9b3sm1336405f8f.13.2025.02.06.02.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 02:12:47 -0800 (PST)
Message-ID: <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
Date: Thu, 6 Feb 2025 11:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org> <87a5b07u1d.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87a5b07u1d.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/2/25 08:03, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> MachineClass::auto_create_sdcard is only useful to automatically
>> create a SD card, attach a IF_SD block drive to it and plug the
>> card onto a SD bus. Only the ARM and RISCV targets use such
>> feature:
>>
>>   $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>   hw/arm
>>   hw/riscv
>>   $
>>
>> Remove all other uses.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Impact?
> 
> As far as I can tell, this stops creation of the if=sd default drive
> these machines don't actually use.  Correct?
> 

Yes, since these machines don't expose a SD-bus, the drive can
not be attached and always triggers the same error:

$ qemu-system-hppa -sd /bin/sh
qemu-system-hppa: -sd /bin/sh: machine type does not support 
if=sd,bus=0,unit=0


