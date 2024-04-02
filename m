Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24216C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcj9-00055x-7m; Tue, 02 Apr 2024 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrciB-0004bW-HA
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:53:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrche-00065b-BD
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:53:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4161d73d876so2138975e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058800; x=1712663600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s26WwhVTEazCwToak+Pg/fznLaGeZTPUdLmVmhcPpcE=;
 b=xl7hALzttF6maGxU43Fvgj4drzi3UF2+fLlm7Msie4M264rotpgoJgW1t2mKlfY+al
 bYl3gn8kBk9GmNMZb3FZTKZRvG+Cjbpjdq3QlvucBR8Jsi4ozqdKfJ/VetsvQF/QE11F
 xALh/YIRsjFtR0DsWn0ierNA8PNpg4X5fCx8sYvuF5B9SxHkCEpAMYl1nF/TnU6GBHWq
 cQfvy4rJriN4Jz9wBSnRCCjHRHFgc9gHQf7KC/WAgma1CEujGFC+x7Ei4bOFOjD2JPSh
 CdztTOBtHntI9ns0ZNNdbt5zYXPow43klGyDzZCGUZTqn/Bj3qWj4NTzdlyLtihGCbor
 2S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058800; x=1712663600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s26WwhVTEazCwToak+Pg/fznLaGeZTPUdLmVmhcPpcE=;
 b=iDahxR8XAuxGwrwrVUn6bq49GzEsbvSDYcJIs9NHLEGtfHOn8rHu6k05j4+JcZobSl
 hxTfaOMpc9Gjt6c68M4oF8fS8B0A5V5kBaHlEPgIR1b6CLfzTLnyjVh0ZThx5mRFFAQU
 ftdjEYabjskQZanqTbNCMjRXternmYIx0vKOAi+ewOB6Szffk6BcCpv8zEplPibrtUvl
 /kb4g69wnVcPJlzXs1GqKXPOR18yK+C0e2aqi+cF4tJjx3/uYjehHonbJDcs6f1MNe0T
 HwE5VUeTf26v9rTQA4B3w7dKAznsxWsbtgRisZcbhqZE+yv9e3ldGQ2GhBp7m/BigclL
 iCLg==
X-Gm-Message-State: AOJu0YyecS1s9vrVtP/B9zQtPpG70TyMWvc10SEjGR0xCVIXOm09CEIt
 orKy6aEh8zbvE0OltMUbODuYfVC8D1mfMzP3PBYsNc/+gY/dpgq3uKeqR39oXtI=
X-Google-Smtp-Source: AGHT+IFAI2A/B0UdkUuRekQUj8df6RHWZIr2DaAAkidmBlT4n8DdYO7V8MycZuLWAVcagbyJ8bJvRA==
X-Received: by 2002:a05:600c:3b29:b0:414:9141:1461 with SMTP id
 m41-20020a05600c3b2900b0041491411461mr8151323wms.29.1712058799860; 
 Tue, 02 Apr 2024 04:53:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20811487wmq.33.2024.04.02.04.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:53:19 -0700 (PDT)
Message-ID: <8dd44a53-f16d-4fc1-bc08-fcd1af5e57a4@linaro.org>
Date: Tue, 2 Apr 2024 13:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/checkpatch: Avoid author email mangled by
 qemu-trivial@
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Weil <sw@weilnetz.de>
References: <20240402113015.66280-1-philmd@linaro.org>
 <20240402113015.66280-2-philmd@linaro.org>
 <CAFEAcA8iCdNOdnrqY+7yupUvxQQfCLh17WRHZ6zFhVQrB4CXgg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8iCdNOdnrqY+7yupUvxQQfCLh17WRHZ6zFhVQrB4CXgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/4/24 13:52, Peter Maydell wrote:
> On Tue, 2 Apr 2024 at 12:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Commit f5177798d8 ("scripts: report on author emails
>> that are mangled by the mailing list") added a check
>> for qemu-devel@ list, complete with qemu-trivial@.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   scripts/checkpatch.pl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 7026895074..4fe4cfd631 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1573,7 +1573,7 @@ sub process {
>>                          $is_patch = 1;
>>                  }
>>
>> -               if ($line =~ /^(Author|From): .* via .*<qemu-devel\@nongnu.org>/) {
>> +               if ($line =~ /^(Author|From): .* via .*<qemu-(devel|trivial)\@nongnu\.org>/) {
> 
> I recommend checking against qemu-.* rather than trying
> to capture explicitly all the suffixes we have. (For instance
> there's a line in mailmap for a commit that was attributed
> to qemu-block@, which this change still wouldn't catch.)

Oh, good point.


