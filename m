Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6ADC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFajd-0008Ct-95; Thu, 15 May 2025 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFaja-00088A-MK
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:42:58 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFajY-00065a-8f
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:42:58 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30df7c98462so1162061a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747323770; x=1747928570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ed5OpV8LcoXGv4f+CEtHJEcEJDwnymAn/7MyejJClM=;
 b=pkfXo3lOPcotMg5/1OfJkzpnXatnDihq2dZmcjfyXIVmQxssv1gOij4t25M/YxWzgI
 lmRmgfeN+lUWEJUpOaaLx5/S536LPF0gSwYV9+tHc98M2HZNzXxLY0n24KNs+V0DwMlK
 jR0WOaTscoGQuW0OA+hJKhuhRldsHLIlAMeHWXPOOPUf1lgYQhEzrmRaeo1iak7NIjFK
 msjvQ7gcRv/2mnErC0mQjckDu+61WDTjRLshPd4bcTcKUBZ0iFeRFxu5nA99QplfrdO3
 jAuHo8JS4qfmQVM8kYpUPb+MoGFEhMSryiXwjzrMQcSmgTXu6L5FKRAUh7KdAUDrQmZR
 b08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747323770; x=1747928570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ed5OpV8LcoXGv4f+CEtHJEcEJDwnymAn/7MyejJClM=;
 b=mcMhrvWn8k56Jeg7G2+d0oU5sW2nrXsdyEd8HB6i6wQyOsMi6PI99LHvkixfSJRJ1E
 vp10g3rlTIWrZLGM5Nlmqgv9FxLg9sc7EM3rnaNy7FR4cRrIcEYK6nNhOcJst9UMVWGt
 sTN6oWGCAD2qo4DUEwDVMgDTvI/EnILLrtNyCUTnf1jils2VZKUnOjMDXgxzaY6kucAP
 CnuHTAWVqTTBthE/lEUsMmCjDQWvLIScS8ptnuK4dYaZGuPeCk4z3jQGXAxZL3iNEt71
 1qQbUyCyNE8lpC6wGRZKH00nLL55Us+uw9R5arEgMBLXrxN9ZSFjLxC6hfC0Hzq50ji7
 RJIw==
X-Gm-Message-State: AOJu0YzYs6plAd/+ZPZo4bucvi6M7vfavqjx7/PNXWRwXqv+f8HBvyHR
 UQkdjdYg72t28SJXlmyFuEInMSf72goe5DDuTe7T1lL7JINLy9s5QL5sRDxdcuzdb45IVIiCizu
 n
X-Gm-Gg: ASbGnctAw9TnuJnDrvb7CtJazbA7YCtK67O592Kz5+pl4/8eGxfdEVRlwdjckxxrtZV
 t9Zfa5GsGoY2B1kxLojPxTqq4DiLC1G+vjadpgJeIjKSLF08a3sTqlCuN+FCyXJNlFmG1RXOHs2
 oTawo0JgY6WUXqeMQrfSdkK1x176B8UmdzArKksC1a8y9rv2jF78qvKJoDMaVyUuOkckLt8G/Aa
 9jQB2CmzmEl5BAh7WjSBPnMIYWgLXOWPV7Th3Dw/PsjUPyhNFjUGPIlp5+YWhDfi/NhXD1ng6xW
 ghvdIPPmlTujRYTWIyQm+FZRuomfhh6jcAAKdJgaxcCTKga+qew8w201eR5RH2Nm
X-Google-Smtp-Source: AGHT+IGz4HCU94VubISGCgyhUxhcPGeLN0Z2du+nCRyv5Gh3o8z8b406lAFmkNYwXsDAKo8IV0U7Ow==
X-Received: by 2002:a17:90b:3c0f:b0:30c:4b1d:330 with SMTP id
 98e67ed59e1d1-30e2e65e705mr12792667a91.27.1747323770372; 
 Thu, 15 May 2025 08:42:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e3345fe6csm3639443a91.26.2025.05.15.08.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 08:42:49 -0700 (PDT)
Message-ID: <b1497baf-323b-431c-a6bc-2758db3cc428@linaro.org>
Date: Thu, 15 May 2025 08:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qapi: introduce 'runtime_if' for QAPI json
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, berrange@redhat.com, thuth@redhat.com,
 Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-2-pierrick.bouvier@linaro.org>
 <878qmy5vxc.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <878qmy5vxc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 5/14/25 9:39 PM, Markus Armbruster wrote:
> Consensus is to shelve this series, and eliminate target-specific
> conditionals instead.  But let me scribble down a few notes for
> posterity just in case we ever take it off the shelf again.
> 
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> This new entry can be used in QAPI json to specify a runtime conditional
>> to expose any entry, similar to existing 'if', that applies at compile
>> time, thanks to ifdef. The element is always defined in C, but not
>> exposed through the schema and visit functions, thus being hidden for a
>> QMP consumer.
>>
>> QAPISchemaIfCond is extended to parse this information. A first version
>> was tried duplicating this, but this proved to be much more boilerplate
>> than needed to pass information through all function calls.
>>
>> 'if' and 'runtime_if' can be combined elegantly on a single item,
>> allowing to restrict an element to be present based on compile time
>> defines, and runtime checks at the same time.
> 
> I understand the combination is "and", i.e. both conditions need to be
> satisfied.
> 

Yes, if results in introduction of an ifdef, and runtime_if, an if.

#ifdef IF_CONDITION
if (runtime_if_condition()) {
...
}
#endif

> The syntax change I'd consider elegant (it's subjective!) is *none*.
> Instead of
> 
>      'if': 'CONFIG_DINGS',
>      'runtime_if': 'target_bums()'
> 
> use
> 
>      'if': ['all': ['CONFIG_DINGS', 'target_bums()']]
>

Why not, but I don't see how to identify what would be an ifdef, vs what 
is an if, and I don't think that using something like 
"is_capital_letters" or "has_parentheses" is a good thing.

> Might need semantic restrictions to simplify the implementation.
> 
>> Note: This commit only adds parsing of runtime_if, and does not hide
>> anything yet.
>>
>> For review:
>>
>> - I don't really like "runtime_if" name.
>>    What would make sense, IMHO, is to rename existing 'if' to 'ifdef',
>>    and reuse 'if' for 'runtime_if'. Since it requires invasive changes, I
>>    would prefer to get agreement before wasting time in case you prefer
>>    any other naming convention. Let me know what you'd like.
>>
>> - As mentioned in second paragraph, I think our best implementation
>>    would be to extend existing QAPISchemaIfCond, as it's really
>>    complicated to extend all call sites if we have another new object.
> 
> I figure the alternative is an abstract type with two concrete subtypes,
> one for each kind of conditional.
> 
>> - No tests/doc added at this time, as I prefer to wait that we decide
>>    about naming and proposed approach first.
> 
> We'd need
> 
> * Positive test(s) in tests/qapi-schema/qapi-schema-test.json
> 
> * Negative tests similar to the ones with have for 'if'
> 
> * Documentation update docs/devel/qapi-code-gen.rst
>

As we decided to follow the approach (1) "Drop target-specific 
conditionals", I will focus on the other series, and drop this one.

Thanks,
Pierrick

