Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3000DC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMoT-0000JP-SO; Thu, 19 Jun 2025 17:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMoS-0000JH-SY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:28:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMoR-0002JL-7E
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:28:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso1022544b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750368526; x=1750973326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q8q91LM+dF24q3vCyU18PZxwc7MbhejnzJ5vltXfO0E=;
 b=wIQVgh9lYogwoFCcEnWk+cUraQMeDF88WlzqUZqjzXRGoxWwOpf7EHPQqG8bzNztTe
 4Fkn5otUBcHyaFJCw/GzRZvioxJiW4ZyGcowvYatyKm00sfp9oHCu5+PHMx1mSYVqWYR
 8tAELmtNtVIuq+JEkFN3HZDIfvqllUR39gfJ5ghOE1f8OrSW8ISHoBDFtngGRXZjkG8U
 U1P2I6gWR5wa0UezynbdOUu9vj9MXVl7/ahu3J1qIP++qrLFZ0BYERtLb2U1Ude0CyJR
 vKd5R6loMfMIzTaL3skivMI9XQFeFS+1RKNNNvqulmcTVUuX5biAoSOXO8G68Hxh3UNo
 f+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368526; x=1750973326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8q91LM+dF24q3vCyU18PZxwc7MbhejnzJ5vltXfO0E=;
 b=qgFQcnA/iUor0Ujorfi6dbscWj2iv1BcqRLqjf1ybqfRKIsFiN8OBJXgoDXkiuM4xx
 qkz7uj6M34iHBeEyHvXrgUm2sDqSXPjXgigwnVAt3GoCcDKvmhzMlAfemXlWuVyLldpQ
 jV4Z7tzSFyw0Epb8TU+jOzhBFMi9UadrmzFh9hlNXQPBVxv0eBuyuEMb2L/zmZfjxeXv
 WnPxB7CPohXv+2FsgS3AWOrFth5l73NfmKu29RXSuJmNabJzuGGJmJ3w5Wv1w9yOkNZn
 Oz48myK/qB4POFgx/nGuMGdOX6ByWQFr/zX6Uvr4InMWXDoZTo7atJ4qd8pi4vBZYk19
 84gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVWESaKVVvTqlaS5QgCS5inFl8ila5ngwOBP2CacJiek9wAOyHLclwiCO6LmsCmSCdVZM6oHqUuaU1@nongnu.org
X-Gm-Message-State: AOJu0YxxUwAIFOxFsn3AuF+/1ce5Nf89rn0K6bjKSFcL4IwvflaHAnKo
 yR/j5WCkzt8xOoVtj4A9gqF5r+Ylx/Bwy6XDr7RPEHKqTGgVPk4UrLyAB5bsSaCclTE=
X-Gm-Gg: ASbGncsGaKIJCCl3TkX/uYeyvXs4GI50v5/wKk1EWmj562XqQv+DW26yUvM+pzqn6uF
 4+7vaIw0r2TgfERY4uf8AXyK6FDuR0BEB9S8J8KAZSMsUOiFQiXygS7i61DyThmz3bcJ7YV/eba
 FuHEvFNjucXvqiM/I4Ligxgbb/ns7+VouX6I3E88OlVNzyqP0dp0VNHbHY3Ac/eV0uFF+lbpOUm
 Nht/Ax0smGMDs6fiQFywt+5zqqbP7e3liNOBK0Iz4S9kPBNfXbrJ9yKYyfN81KmtsJVjaIJyDN9
 cpZgLQqGSlt0he/xkCbcTfZcfnZhAk9USm1zoiEs5e897TrzmREgYSHglHAsDYQV8Dkq3xbO7Gh
 mmyhMmD52WfIuNPCQ3KRJclse7lBL
X-Google-Smtp-Source: AGHT+IEKMwlOuTSLooqFqiPgUndDuHmRMWWTVuJtQHxIOvVQ1g5J9V6OyUOGrXufkeUyZcufQOqggA==
X-Received: by 2002:a05:6a00:a0f:b0:746:24c9:c92e with SMTP id
 d2e1a72fcca58-7490d6a290dmr415175b3a.8.1750368525705; 
 Thu, 19 Jun 2025 14:28:45 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a6494b3sm531910b3a.125.2025.06.19.14.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:28:45 -0700 (PDT)
Message-ID: <2d819061-8262-4da5-add3-20d567dde52d@linaro.org>
Date: Thu, 19 Jun 2025 14:28:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-20-philmd@linaro.org>
 <1e7d58dc-b348-4c6f-b7bd-e8da047e21c8@linaro.org>
 <b3bea159-8da3-4a7d-8485-fcd6519b845d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b3bea159-8da3-4a7d-8485-fcd6519b845d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/19/25 14:20, Philippe Mathieu-Daudé wrote:
>>> @@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
>>>       sms->smp_cpus = smp_cpus;
>>>       if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
>>> -        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
>>> +        g_autofree char *size_str = size_to_str(RAMLIMIT_BYTES);
>>> +
>>> +        error_report("sbsa-ref: cannot model more than %s of RAM", size_str);
>>>           exit(1);
>>
>> Not a bug bug, but autofree has no effect because the block doesn't end before the call 
>> to exit.
> 
> Right. Isn't it better to use g_autofree as a general code pattern?
> 

It's a case of "this doesn't do what you think it does", which is bad form.

If you are actually interested in freeing the string to avoid a false positive during leak 
analysis, wrap the two lines in another block:


     if (...) {
         {
             g_autofree ...
             error_report(...)
         }
         exit(1);
     }


r~

