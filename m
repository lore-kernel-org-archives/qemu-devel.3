Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0007EC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHp0d-00009b-RA; Wed, 21 May 2025 15:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp0b-00008a-VL
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:21:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp0Z-00018Y-Tk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:21:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so6797394b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747855302; x=1748460102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qDHA+xSix926l7YrJ4wV6VmM8fWhiDAdq/6MRD2s9M=;
 b=K3SjjQNYkJ1kr9k0zdduL91pcjBgy1F27NaDMKkZh6hfeRyxw+kDMAysnAD6WoMiG5
 gs7XguW4ReY7As6Ir9pGgD9sJNVuTtVwcaduRIpTdTGfsTMIWPctm5rskDc0Nju2dNHo
 sgIFRX1oNpf9FJBhYme+/W63v9pUMvxYHneZw2ZQB7kGS3jadsRJRRKGjhSRSkPPf9zI
 qprrNenN4IGLy9z9fgD6rqDz39D5WJnhDiVvfHAuQP6vIcwfDWhgnQ9keNSnO2SPIbsY
 9sutRFtjeew5SO7sKJXUBGTxL0mYc2bzwU1Sh2UpbbVcGJJWhCrbh1oXp5WF0Vcv/NKg
 ppAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855302; x=1748460102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qDHA+xSix926l7YrJ4wV6VmM8fWhiDAdq/6MRD2s9M=;
 b=A93COuR/s4/2gpmYKSHh6acRiTgqbg8q1t00HH8yCVNK6eKX2SPdim0KQJoe7LGykU
 7brGIQqG9yFRoY1HJUs4wPSa9t3Lj2HSr4RoqukRloM4jmDr1jIYPlTwZcDeUlCdbE/R
 onhCvWY353sdJgyHFqxt84dLUo27/hv1gakR0wHXlBf4jNE5nxkUcjQb9Uwlt7S3N6xT
 M18S2Xd/aVQj57eRVotH9y0/B1evc9DmfE7bIFZo2q0b0BAruFRGXoAG/4Lp3Z0OmFud
 jZMlH58FX4IiL6FJTh3pksPOVnRzCM7pR1fDHbQ6OZK5bfRHl7TII7VLxgqj3rO4SosU
 /C0Q==
X-Gm-Message-State: AOJu0YxeYPMVuBVGWAu+zBtewVfssRSMeWc8Zc+NMuzSLlLM467NEkQD
 DNVZTeubSBqwSOBUTw+8Vzg3mACzcECHiMNjiD+GnWPnORm8RqonTUrNVVhGd7XzxJI=
X-Gm-Gg: ASbGncufSW8R2NO0f+avr+tC4TYF+46Ea5VAw7+dfziW7uKr7eobFv5lMsmQ2FliqlV
 2nMPPAQWJjiHw7uGU20UtMGeOC5BXMN+c8OwWHCJ7pXHYsUrpjGnO+Ml4+iD6q48O0dwnblk9xE
 S22lEmxPjrWCwaf4x/V5VQA+PZ7Yvd3HPGIyGqLWFi4RKRVLCI8p4MVnxoZWgbYtLsgtr+3hZ+m
 PEHqZDGiOz7Wz+rYQZPtd90kgXHzZ0FQ3m9qHlgOqL8wcORHynp1XJAJKZ4YnONv8Upzhf4PKkM
 bY0ZuYxD/J0Ue7tdgrON3Ya/fqXLLgEhbcP8gU4T0Xk/+Z34bQf04pF/eAsMRXIe
X-Google-Smtp-Source: AGHT+IELb63qTsPtuKaet61WBaXmsujxLrcGdsKx5N6w//s+QPYLe8NoTE6vaH20et2hcKuwX4+nxg==
X-Received: by 2002:a05:6a20:d70a:b0:218:17a2:4421 with SMTP id
 adf61e73a8af0-21817a2540dmr24139972637.10.1747855301579; 
 Wed, 21 May 2025 12:21:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf8e054sm9953663a12.41.2025.05.21.12.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 12:21:41 -0700 (PDT)
Message-ID: <f2c36e84-9ae8-4b2e-8a4a-b6af8b2809b1@linaro.org>
Date: Wed, 21 May 2025 12:21:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] qapi: expand docs for SEV commands
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-3-pierrick.bouvier@linaro.org>
 <871pslkur5.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <871pslkur5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/18/25 10:57 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> This gives some more context about the behaviour of the commands in
>> unsupported guest configuration or platform scenarios.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 5d0ffb0164f..ae55e437a5f 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -110,7 +110,11 @@
>>   ##
>>   # @query-sev:
>>   #
>> -# Returns information about SEV
>> +# Returns information about SEV/SEV-ES/SEV-SNP.
> 
> We prefer imperative mood "Return" over "Returns".  Could also use "Get"
> or "Query"; matter of taste.
> 
>> +#
>> +# If unavailable due to an incompatible configuration the
>> +# returned @enabled field will be set to 'false' and the
> 
> I'd prefer "field is set".
> 
>> +# state of all other fields is undefined.
>>   #
>>   # Returns: @SevInfo
>>   #
>> @@ -141,7 +145,16 @@
>>   ##
>>   # @query-sev-launch-measure:
>>   #
>> -# Query the SEV guest launch information.
>> +# Query the SEV/SEV-ES guest launch information.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. The launch
>> +# measurement for SEV-SNP guests is only available within
>> +# the guest.
>> +#
>> +# This will return an error if the launch measurement is
>> +# unavailable, either due to an invalid guest configuration
>> +# or if the guest has not reached the required SEV state.
>>   #
>>   # Returns: The @SevLaunchMeasureInfo for the guest
>>   #
> 
> Errors better go into their own section.
> 
>     # Returns: The @SevLaunchMeasureInfo for the guest
>     #
>     # Errors:
>     #     - If the launch measurement is unavailable, either due to an
>     #       invalid guest configuration or if the guest has not reached
>     #       the required SEV state, GenericError
> 
>> @@ -185,8 +198,9 @@
>>   ##
>>   # @query-sev-capabilities:
>>   #
>> -# This command is used to get the SEV capabilities, and is supported
>> -# on AMD X86 platforms only.
>> +# This command is used to get the SEV capabilities, and is only
>> +# supported on AMD X86 platforms with KVM enabled. If SEV is not
>> +# available on the platform an error will be returned.
>>   #
>>   # Returns: SevCapability objects.
>>   #
> 
> Likewise.
> 
> Suggest to use the opportunity to switch the intro to imperative mood.
> Together:
> 
>     ##
>     # Get SEV capabilities.
>     #
>     # This is only supported on AMD X86 platforms with KVM enabled.
>     #
>     # Returns: SevCapability objects.
>     #
>     # Errors:
>     #     - If # SEV is not available on the platform, GenericError
>     #
> 
>> @@ -205,7 +219,15 @@
>>   ##
>>   # @sev-inject-launch-secret:
>>   #
>> -# This command injects a secret blob into memory of SEV guest.
>> +# This command injects a secret blob into memory of a SEV/SEV-ES guest.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. SEV-SNP guests
>> +# do not support launch secret injection
>> +#
>> +# This will return an error if launch secret injection is not possible,
>> +# either due to an invalid guest configuration, or if the guest has not
>> +# reached the required SEV state.
>>   #
>>   # @packet-header: the launch secret packet header encoded in base64
>>   #
> 
> Likewise.
> 
>> @@ -236,8 +258,15 @@
>>   ##
>>   # @query-sev-attestation-report:
>>   #
>> -# This command is used to get the SEV attestation report, and is
>> -# supported on AMD X86 platforms only.
>> +# This command is used to get the SEV attestation report.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. The attestation
>> +# report for SEV-SNP guests is only available within the guest.
>> +#
>> +# This will return an error if the attestation report is
>> +# unavailable, either due to an invalid guest configuration
>> +# or if the guest has not reached the required SEV state.
>>   #
>>   # @mnonce: a random 16 bytes value encoded in base64 (it will be
>>   #     included in report)
> 
> Likewise.
> 
> docs/devel/qapi-code-gen.rst:
> 
>      For legibility, wrap text paragraphs so every line is at most 70
>      characters long.
> 
>      Separate sentences with two spaces.
> 

All changes done, as requested.

