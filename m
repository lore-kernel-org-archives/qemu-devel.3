Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D021FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 20:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7gSN-0008LN-GL; Wed, 23 Apr 2025 16:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7gSL-0008If-LN
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:12:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7gSJ-0006ZR-VV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:12:29 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso286480a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745439146; x=1746043946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Iv5SATF2CTzFHF4MLbFYOrIyCkUqabC7/gqFf83Xi0=;
 b=U/pr4+gIWT0JVz0jF6+lKjPlh70j+DLW7T8bBX6/1i20ZbruM+2aK8lkaP/+lbj5kv
 EVl4UnfDzPBP9DME/pUCkoPyAzJ/Qm3upINODgKmJ0mmY49vbDXylnKIrwgMJRKNJ02f
 PCpIM6jSMRl/RTUiAN4y3HuETFD1r3ZWyT5fg/Tm19PFXVrG3eDg23uDFjbaGad36M4h
 B6/Pk9Xjl11YjE5BgakCIxzaBe7K9iMBSSnere4x/bhw0pUAHTV2HiAbRcDXoJKv4BxP
 evl9BY3j7DkWl7HR2Rpwh56Dkle7SqJcx0Mgqae6fhFj4EsAD0Fi/CSyGp+RzrgMcU74
 NI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745439146; x=1746043946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Iv5SATF2CTzFHF4MLbFYOrIyCkUqabC7/gqFf83Xi0=;
 b=lSufU9CzIWPNAfIbkz2seCKItoK2a4wDI1RFhMloUUkRdPT+KAbmC5LZhk+1OJF65m
 kHlf2rO9RumvwqWtfrgTGOZ8wK3HABxQVuOnrjgBCXkoSOGL3KGKyo9P0pdl84IsoDfE
 XkfsEP3uw3BKCWou6rAJClwDlbKDHDQvWwySie2aco4oS2ElplN6E0cqpgEYlWONHsyp
 6oEo95hFq7JnamNtt91+ltD3ft0pIyk1YlUDsK+TLx5UYhH5KWprk1at1nW1Arr0u/bX
 +3aWHd9jnFvJXVTR5DV0Lmir7sDUnbEqNn6Z6mKofpkxvch8uN+oqikZNgYXQFEi0d4O
 rINA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW371tAzfzUNGYho2pTu2gU2la5UAqjY0J4Eb0dHCJry7fEbbG48KScMzG9nDakVGgnpodojdkgx5UQ@nongnu.org
X-Gm-Message-State: AOJu0YyogW/GhKjFXLvFS9nJRD8shPF6IOKD2KxWNYDoK76eX1GpHE0e
 HtVG1QkBXcNnRDQEWwa4KRAy16lUPhJA4bfIkr4mf3Z73MAfkZ3fz7o6sFpKXPU=
X-Gm-Gg: ASbGnct2NHRRqpgIShozAcexjaCOtjP6Flz85aEK/c9jXLvUydksEAie/31DdjiV44O
 TIWZ/eNzomCSmv9PyatnbhY9Ufj3tlxW796Dj46i5T9zzX55E+FdnUYlzhFC5ziYUD4BzMvg0Ol
 aZaxDbksdG+4rEDAGUIGFb2tKUoMJhpbOY8eu6piM0E1/t34HBzwgDl6pxOSzdjb/LqZ94q9ggY
 4ZgssDe7yXOWRnfumYD8kWLKFCmeGjJdc4hz3P0mEbpSD8+ChyIG5gFdRHU8HUdGPbIwKUi21Je
 p9fWsoPW/CaEaO5iGhFGqN1i+eGGyrxX10IfLEejj9ei3IDP/+NPyg==
X-Google-Smtp-Source: AGHT+IF445NfdiiwwULABActSIWNVJp6oAtbnyptohQJDCWEzRmrXCv3qqttVvn0mqlzI0+bYJvNfg==
X-Received: by 2002:a17:90b:314c:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-309ed286424mr166907a91.19.1745439146256; 
 Wed, 23 Apr 2025 13:12:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309e0ccefe2sm2091048a91.30.2025.04.23.13.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 13:12:25 -0700 (PDT)
Message-ID: <24345256-3a93-4fa1-bb89-f001c5430083@linaro.org>
Date: Wed, 23 Apr 2025 13:12:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
 <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
 <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
 <990864df-638a-4c0d-a01b-87c916771bd8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <990864df-638a-4c0d-a01b-87c916771bd8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/23/25 13:04, Richard Henderson wrote:
> On 4/23/25 12:33, Pierrick Bouvier wrote:
>> Else, in case we make this array const, can we expect the linker to deduplicate it? I'm
>> not familiar with how final .data section is assembled.
> 
> No, we do not expect de-duplication.
> It's a "that would technically break the object model" thing.
> Const or not,
> 
>     static S *a = &(S){ };
>     static S *b = &(S){ };
>     assert(a != b);
> 

I see.
However, it's only type names, and not really object models (we don't 
duplicate interfaces themselves, but list of interfaces).

Or did I miss something in QOM?

> 
> r~


