Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B608C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezTB-0005P4-Tc; Mon, 03 Feb 2025 11:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezTA-0005Ov-I8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:38:44 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezT8-0007Mh-Up
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:38:44 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so7560601a91.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738600721; x=1739205521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QNp7gVlbU3zX+LYlNqUvYFfAGCndN87uVCN40LrvOTI=;
 b=GMP4ovUphQcA2qAPMe/r1uVvzX/KqLb7b8Z9rzoD0EEDUJ4Xk1yc7pa6xvN6vee3wi
 26SeD8I+/5WbvPnm6QJ06lyfI8mS2fa+ayajkbJT/Vaai/0fTV2ozsoUVBXcsgaMs/k2
 WEOea+b/aDNV1zqG/sfkqpzuUqqfGG3oTtV5IGmJ2TH2SiULF/d+6zK/xr8qVJZfQJdC
 CUF9DsYZCeX+KRN4tJWcNAqW1qfuqkCpEZoVWyXs9HSIrf1RmyH8YBfsZFBfyuPArKuU
 iAZGAi7e5W5DYgtPrXDr2LUiJi/50DhlI7viyVDdwxnNp7gk8mgDmQzhknfYLB6XZ+yq
 pw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600721; x=1739205521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QNp7gVlbU3zX+LYlNqUvYFfAGCndN87uVCN40LrvOTI=;
 b=VXqnPSCuxRujJXClIaLW3OJdeFqu9KduLLSqmFLTaU5y9MsZjv1EqLWuNk0AILRJ2m
 H8uAvbfwF2Aw0JdhQYdAjKKAjIeZSe7h7MKyBLDHEgeone1jFTHdSMz0NprtYce+ABzP
 4IL5wciNsnzqhie1Tm7PnazMJ+Ud/ABxCM1QpdnW3syhOmKBm9QSMDqv4Q40NW/Qczky
 6I8ccdmEgy/civbk01ciV8RbxYMDS7jXoAcqqPEC832YEPqOEUkK1GSxTDKGxMuplgSU
 sAwt+UbxW8RbCO+ua5Hvfw97DtuuZlVMvV8mQPspvw61VJ0ui2Motm/SsceXI9U5VfKK
 sxFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgTnHvVR9qI19m4Wc1WTrdpOi2guwJjF4F7ZOBc7VSnBwdOh04/MNiJa2JR9/NVbEM4cCC/CjiffRZ@nongnu.org
X-Gm-Message-State: AOJu0Yzu8ELh204DDiDwaibWgMK7kfdZuYsBSLkbn0yAxw0iD/EPccHC
 5J/+/2r+Iq/3MyhNK1qSsFApNCwY83IY3YBp3Ogd1qABOlicGimNJCMpBkJNHjU=
X-Gm-Gg: ASbGncvCDNCZkSkMknSEpB1ouz8cFu+QqiRRM8aqNPEbsQXtdb43W8kl43py4rKAz9H
 ONRrbwDopbstsxjUfT7iLABZP8MU/aufZwYZ9AeGw8YLR6TGhyuF35l24U5ouFeB0VqkA6UJcem
 81aYWqMy1aKwworenqLYb9cc5FGXYUeDMlHDkheQJR0y5D3KOrrOgu7R5Or3aZD9W3Yj7o03ZEM
 aDLH1ovqJGRknrqxjw6reJWW9kK+/229ppsDKxcLIgXr7HTLJG8SiipoOnmRYSi1W2vfgzbp3Hb
 /Vb9X1S+9JbCinf2bYW5iLKIswn6Fp19hGeOMny91gtMqCz4huDs6o0=
X-Google-Smtp-Source: AGHT+IF7fw0oS7BLxN+cS0yF8LLlw993fOrc/d3hMPRXZj3RvM8XsPZpNHd0xy/vZgqUwU12nX3i8A==
X-Received: by 2002:a05:6a00:1946:b0:72a:aa0f:c86e with SMTP id
 d2e1a72fcca58-72fd0bda6c1mr34493240b3a.4.1738600721126; 
 Mon, 03 Feb 2025 08:38:41 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6539fc4sm8730451b3a.73.2025.02.03.08.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:38:40 -0800 (PST)
Message-ID: <3aa0e508-00c8-477f-b5a8-2cf20afb8efd@linaro.org>
Date: Mon, 3 Feb 2025 08:38:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] meson: Introduce CONFIG_TCG_TARGET
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-5-richard.henderson@linaro.org>
 <5c118b5d-a943-499c-a0ce-f19c74ab7d94@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c118b5d-a943-499c-a0ce-f19c74ab7d94@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 2/3/25 02:08, Thomas Huth wrote:
> On 03/02/2025 04.18, Richard Henderson wrote:
>> Use CONFIG_TCG as a project-wide flag to indicate that TCG is enabled
>> for *some* target.  Use CONFIG_TCG_TARGET to indicate that TCG is
>> enabled for a specific target.
>>
>> Within a specific compilation unit, we can remap CONFIG_TCG based on
>> CONFIG_TCG_TARGET.  This allows us to avoid changes to the bulk of
>> the code base.
>>
>> Within meson.build, while CONFIG_TCG may be set in config_host_data,
>> it may not be set within config_target.  Thus all references to
>> CONFIG_TCG in source_set 'when:' need not be updated.
>>
>> For the moment, CONFIG_TCG and CONFIG_TCG_TARGET are identical.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/qemu/osdep.h |  7 +++++++
>>   meson.build          | 11 +++++++----
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 112ebdff21..1f6f73a148 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -34,9 +34,16 @@
>>   #include "config-host.h"
>>   #ifdef COMPILING_PER_TARGET
>>   #include CONFIG_TARGET
>> +# ifdef CONFIG_TCG_TARGET
>> +#  undef CONFIG_TCG_TARGET
>> +# else
>> +#  undef CONFIG_TCG
>> +# endif
>>   #else
>>   #include "exec/poison.h"
>>   #endif
>> +#pragma GCC poison CONFIG_TCG_TARGET
> 
> Shouldn't that rather go before the "#endif" instead?
> 
> Also, would it be possible to rather adjust scripts/make-config-poison.sh instead of 
> poisoning this switch manually?

No, I want to unconditionally poison it so that no other uses are ever introduced.


r~

