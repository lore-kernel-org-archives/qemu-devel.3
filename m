Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B517C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5kV-0006YT-1j; Tue, 26 Mar 2024 08:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5kS-0006WP-PA
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:17:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5kP-0004gx-PU
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:17:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-341cf77b86dso1650539f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711455463; x=1712060263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+CvJbbwaN3gu2LDxLhWXeNXxtcBh4rdfLG4lvNAmVmE=;
 b=zwQJ/S0dkoL2UebO25Dn9mY0XkPBJ28ApJc9XyW83pKW3dkeOll0DowyeJmPWO3faL
 7S9NiLGWgaQByW7EIH4W6ztDTY9WikZGvGJSMM5yTY9fnBn2QKh844j1/5wXlYclVmxz
 pTgcML7e7COx4TfFPhfbLEN1ceD5qkAb1ASvEYTh8TDbOO9++rlc7cC0iMUjdvxLoNPd
 2S6KhgRzzq7JMKLOLYKmyu9ISDYsn+iolBJsHa9ovl0SF4Asi2a7RllqNze/qjH1kKjI
 JxZoKn/eNfJ96gafbLxLsYfqnhBfC0Jz6JuJ3P66/jQtqdT7MQ6Agy06gpITMNniMycy
 iXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711455463; x=1712060263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+CvJbbwaN3gu2LDxLhWXeNXxtcBh4rdfLG4lvNAmVmE=;
 b=ItARgjRWhH0IZ6db3qhK6WlZiNiYM/OiZKcslcGnQaI2Q6Avq/+qw4DV7ADO//agDn
 Mmd/FDISpxyw7LVMKwxLqcyEdeecjUcosKVoBJkSgpsrBBoe0QwTqSxz/1gAsWzorfOH
 UqCKP1H79WlGPaqfwxpQS9iy9XXGplMJXMSeQ3dKduUE0Js0PS8En3VHMs1XEcmQ9t8v
 mFx6nugHq8CkLhH2j6uIRWORZdhUOvPQcE3SnkK7bGWNdQwCXy9IpVALAgMlDIsUL8td
 epPKetYukZmCFSMCi8u4jeGLCEpW8Aeo8OJ+1cdinB5qqO18MznmBk+Abdb+/QzSs54Y
 fe8Q==
X-Gm-Message-State: AOJu0Yy+GK1ZP6p56uDCpbvBrZsyLHDeHfPmjPs25xOuQmVYpAbG9ZyD
 UhMpcIIeZorAxpKqUHfpERykIPI8t1PDCPek64cXv3YUy3E3Ks7qocJDBLj4UKM=
X-Google-Smtp-Source: AGHT+IH/0x881Tg1KCQEHgOO/amUEa7aJ4sRVYGn/Uxud+HM5UfeitXZcj58rf213bJ8cHlsfoVulA==
X-Received: by 2002:a5d:66ce:0:b0:33e:ca3a:1bba with SMTP id
 k14-20020a5d66ce000000b0033eca3a1bbamr8851064wrw.20.1711455463091; 
 Tue, 26 Mar 2024 05:17:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a5d6b50000000b0033e93e00f68sm12087753wrw.61.2024.03.26.05.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:17:42 -0700 (PDT)
Message-ID: <94e841dc-3589-472d-b6eb-b96d19c93407@linaro.org>
Date: Tue, 26 Mar 2024 13:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 06/21] target/i386: Make X86_CPU common to new
 I386_CPU / X86_64_CPU types
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-7-philmd@linaro.org> <87h6gtp8f4.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87h6gtp8f4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 26/3/24 11:57, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> "target/foo/cpu-qom.h" can not use any target specific definitions.
>>
>> Currently "target/i386/cpu-qom.h" defines TYPE_X86_CPU depending
>> on the i386/x86_64 build type. This doesn't scale in a heterogeneous
>> context where we need to access both types concurrently.
>>
>> In order to do that, introduce the new I386_CPU / X86_64_CPU
>> types, both inheriting a common TYPE_X86_CPU base type.
>>
>> Keep the current "base" and "max" CPU types as 32 or 64-bit,
>> depending on the binary built.
>>
>> Adapt the cpu-plug-test, since the 'base' architecture is now
>> common to both 32/64-bit x86 targets.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> [...]
> 
>> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
>> index 7f5dd5f85a..97316d131f 100644
>> --- a/tests/qtest/cpu-plug-test.c
>> +++ b/tests/qtest/cpu-plug-test.c
>> @@ -90,7 +90,7 @@ static void add_pc_test_case(const char *mname)
>>       data->machine = g_strdup(mname);
>>       data->cpu_model = "Haswell"; /* 1.3+ theoretically */
>>       data->device_model = g_strdup_printf("%s-%s-cpu", data->cpu_model,
>> -                                         qtest_get_arch());
>> +                                         qtest_get_base_arch());
>>       data->sockets = 1;
>>       data->cores = 3;
>>       data->threads = 2;
> 
> Doesn't build for me:
> 
> ../tests/qtest/cpu-plug-test.c: In function ‘add_pc_test_case’:
> ../tests/qtest/cpu-plug-test.c:93:42: error: implicit declaration of function ‘qtest_get_base_arch’; did you mean ‘qtest_get_arch’? [-Werror=implicit-function-declaration]
>     93 |                                          qtest_get_base_arch());
>        |                                          ^~~~~~~~~~~~~~~~~~~
>        |                                          qtest_get_arch
> ../tests/qtest/cpu-plug-test.c:93:42: error: nested extern declaration of ‘qtest_get_base_arch’ [-Werror=nested-externs]
> ../tests/qtest/cpu-plug-test.c:92:47: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
>     92 |     data->device_model = g_strdup_printf("%s-%s-cpu", data->cpu_model,
>        |                                              ~^
>        |                                               |
>        |                                               char *
>        |                                              %d
>     93 |                                          qtest_get_base_arch());
>        |                                          ~~~~~~~~~~~~~~~~~~~~~
>        |                                          |
>        |                                          int

Sorry, I forgot to mention this series is based on:
https://lore.kernel.org/qemu-devel/20231010074952.79165-1-philmd@linaro.org/
"qtest: Introduce qtest_get_base_arch() and qtest_get_arch_bits()"

