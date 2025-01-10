Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB9E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWM1T-0007QQ-0u; Fri, 10 Jan 2025 15:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM1R-0007Q9-Tu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:54:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM1Q-0007eU-An
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:54:25 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21636268e43so53267105ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542462; x=1737147262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rBjVEyS8kdEWVLcyJonVubcc3foMHZv9sZlQiYhexXM=;
 b=gIBklg2g/E0kqxOZMmUwxriCtdf0vQstLa+/NDp9j9lo5QqAQN7Ep64MoTKcCG2a9n
 PzLDC8AjOViRcLnGHNPJVTzKGaNTPw2AtdWZVN5pJ6kF0GLUn44l1KaUbY4XTkrukqTx
 ErB14ZgdxmTHWklchm57JyyoKjRKCaebBgvMSuZc6M2esQZINPUbd1859B2/V6TFU7R8
 NsVrznRuLcMvTP4Z+hKshuAmIkFLik2Zai9OcJ0E5HveAz6jeQti8JrCyMkYka3X0K9S
 HNLk4FGq5FbzQ4imkJXHYLm/SMREoaMNhYdbz0SDAAKs2MOKt4S4rRnXXUjLj9kzimqz
 OO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542462; x=1737147262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBjVEyS8kdEWVLcyJonVubcc3foMHZv9sZlQiYhexXM=;
 b=LX7f2BO1S1Rznoef8Sdc7mbcjfFrhPsfxbkPhPdbgqGZ9SJjwpWT9H28ypgqwKKwby
 5Ny53eEJUamq2HNF/uObuBUJ2tyS/5zK4zMsB1qK0Gf0nxbUxyA+yX7bH22aM5s+r9TI
 zsncpJDGs+EPHQ2sm6EceuLFWb2gQy5hrGVDJSOn1UtfuFOaB+r1S+2+qUZ+1YDjr4qi
 fbyWNHyFtSCPPyfO4DA9gGV5YbDyhslNzn0vBdJBwtADxaC8zkrEhps80FylSruhpsjc
 Jij3HITnsjQlmzkoom/I06WGE3F/fPh40uaig4UBSf/ge9v6JS/QXIcW00m80mrVm0ci
 U8AA==
X-Gm-Message-State: AOJu0YxTmV8rS4uTyNp/guepJOw/QwNJTxGfZSCB/kXBmbdV6tIFMGCT
 Fr/I72Xb7t1M/Y3STKvpFRJZiIwF+rNgUPBql8KYGvHZKkKiF3+SA6mosvxYeV0=
X-Gm-Gg: ASbGncvadomJS2m4sUPbJZECItVMbQVspiQyZuhgzuiCBv0DG7ivrlk8eSGNDzf585B
 mfHx/4KJb/brFwYnvGVLk5RitMbTQzoxbNdXy9ciopIunNEKdXy1d87JikDOxXEPt+GEeJiiMkP
 UH0UvDVyDi3MSJWmORC5f6TzmVxne6FKCLtjHH17oZ45LKvmpD+xpbdEMHK+B3VAfz/B71Atndu
 sEQ7X6cSwmpOLCvUAGUdQPRzxFas12nSNto355Qn6GmUFZ0M/wcQkkW12AZ6CXWO465Gg==
X-Google-Smtp-Source: AGHT+IGeEwiREsp24qovdI7wZDrWh/J8z6c+jfHejXzHqKE4eu2i823v2NS9Z3hzGCwW3CFTYhEw0w==
X-Received: by 2002:a17:902:db0e:b0:215:a57e:88e7 with SMTP id
 d9443c01a7336-21a83f48cd6mr173206785ad.3.1736542462138; 
 Fri, 10 Jan 2025 12:54:22 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f256e44sm17215635ad.216.2025.01.10.12.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:54:21 -0800 (PST)
Message-ID: <70b28370-228d-41e6-88cd-eda686d55b21@linaro.org>
Date: Fri, 10 Jan 2025 12:54:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
 <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/10/25 08:30, Peter Maydell wrote:
> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   docs/system/arm/virt.rst | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>> index d25275c27ce..9f1457cf9a2 100644
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst
>> @@ -17,9 +17,17 @@ to have the same behaviour as that of previous QEMU releases, so
>>   that VM migration will work between QEMU versions. For instance the
>>   ``virt-5.0`` machine type will behave like the ``virt`` machine from
>>   the QEMU 5.0 release, and migration should work between ``virt-5.0``
>> -of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
>> -is not guaranteed to work between different QEMU releases for
>> -the non-versioned ``virt`` machine type.
>> +of the 5.0 release and ``virt-5.0`` of the 5.1 release.
>> +
>> +When saving a VM using the ``virt`` model, the snapshot is automatically set to
>> +target the latest ``virt`` versioned model. When loading the VM with a more
>> +recent QEMU version, you'll need to set machine model to match the version of
>> +your snapshot. When loading it, QEMU will return an error with the expected
>> +``virt`` version you should set, so you don't need to record it.
> 
> I don't think we should be encouraging this -- our standard approach
> is "use the versioned machine types if you want migration", not
> "you can start with an unversioned type on the source end". So I've
> dropped this paragraph.
> 

That's fine for me, I don't have a strong opinion on this.
I just had a (good) surprise when I saved a vm with virt machine, and 
realised it's versioned by default. It's good to know that when you 
export a virt machine, you are guaranteed it's bound to a specific 
version, so you can always load it with new QEMU versions. This is what 
I tried to express with this paragraph.

>> +
>> +VM migration is not guaranteed when using ``-cpu max``, as features supported
>> +may change between QEMU versions. To ensure your VM can be migrated, it is
>> +recommended to use another cpu model instead.
> 
> This paragraph is good, though -- that 'max' doesn't work for migration
> is important, and we should definitely document that.
> 

Agree!

> thanks
> -- PMM


