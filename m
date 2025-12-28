Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818B6E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzRh-0002Q3-Pp; Sun, 28 Dec 2025 17:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzRf-0002PI-EN
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:41:04 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzRe-0001Er-6e
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:41:03 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-644715aad1aso10035843d50.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961661; x=1767566461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/kcKbsKSRRV3yszoqcubmBrf/PHanErnpIZMjt/MdI=;
 b=Z33PUtu7OJa2bA3nHCbi5KDmJEWwWX5kB3rIbnIf5+FKcu3EczmUk78gBDkAS3k6aw
 CH4AtI1hA8MB6NwoXPKcbZkZ9PR1tMgmHio0LE7ZXxpNwk9aNbRtfMsmIoJj6dEFTv0L
 QWntUcanJ6sajVp6jf+yjFBrawy2ihqhxcWCo9jU4mw/as8Gewnsv3s8VKQ9jwcjymGY
 VgaHzX/wGSbVdIyYfg8SvcbRXpGZnvas4WOfIjodAxgJmHRqGwBKmW2KNkt/PvSw4pFs
 mS++lfJXvWuKQ5D7w2b7Igxb6Em67/tNjekRuCUQoJW4eWV3CXUq70Dl62U+XR9t1vx9
 EnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961661; x=1767566461;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O/kcKbsKSRRV3yszoqcubmBrf/PHanErnpIZMjt/MdI=;
 b=SNrfcx2rbaULoXF4cGUJOpIg3IVsTs/c7xOcrGh9/El+L0O7x0Iczjl6v3+KAbwzlV
 K2o3oLPYqhKMqfP770E229fKdwVyq/yWeP1JIULbIocL90qHmgwoBPl7KFWhFLrOIGxU
 wLbm/zY5tZZox3D1Wg37zsrRGZd5hVDeG7zXy30o3yNWTRwUVjtMSvBZ119NkUVadlkU
 vHLhbLqwsCR1lJAgoRExwfes3xH9w7CDcbfd60nz5RhZqM6WNRG4dTyj90WdRdJT99TX
 0xaAAcZvtwMKFlnxR9Bo8wanN6CEkL6LzUPZY2LiiqT5fSiy6DL6W4ARJIqxbQp/YsI0
 iwgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxLW2SKgQqjV8ez6ML0aa4OtG6vmrn6+Bst/TYG1hGJdxeGuK1qSw9DY638Dv65Mknn95HXwwQjgHC@nongnu.org
X-Gm-Message-State: AOJu0YxybNnPajERHvp4UOlraYF4cPj7a5qTn980xxtEMabN4IbED/u/
 /VRHlOzvligPmWygsSwfDEIuGN0dq5ILAcv2376lKIgMBdGCFawgeqYXmrUitEPumz3uRnL0ZNm
 6iix9
X-Gm-Gg: AY/fxX6oni98+SVZf5iEae0MwJ8XV1gpn14ojxK5PK93pbxp1kVGsFI4zOwuKRoAQMq
 JW4pbrQA0uXG59JHkcJUuOuyvP8wODdy0fbfDvNHV1XvPAT2SwYeqzAJwgHjL8za2kUtDXiqHKN
 BbAUj+v+1U59MdMWhc7dqDtY+tg1kkV9uKkJ2MI46Od0YfL3u/9Phr+UtmeAmDgMi5IBZO6+ikD
 S+DiGhxN+ZiEr8ddmtQcdjL67wZs5yycHpvja9j3MjXEW/oKmv9InXXZv9zaI/NqD59L2vteytF
 Y/NxhypqA0JB4u58oVKv/e+MlVd98Ikoqifgu1TnVnJhtCXJPtti7eyzHsaECyaWHIw5pVUWPHl
 ICXfqMOt9h1bjz71jQwqG8fL5DEJhUTf4RQkv+YApRO2o5AZzjW5AGArj6wpPxrA34QFJ8Wh9/5
 JPGpWvwe+1eFrsDmfSUHJPpVw5RnndMJo57FAPK4zrUYZuTk3x4dAteNJLMVZ4qoww1/4sNWiXQ
 JSgv0/8
X-Google-Smtp-Source: AGHT+IE92gkIdy/npimnY9RZiu0q7e2jkaw++ORCSy0d6bEioxwmnlELog92lFUTnz6mualuGSK7sQ==
X-Received: by 2002:a53:864c:0:b0:644:60d9:8660 with SMTP id
 956f58d0204a3-646632e1ccamr19738559d50.44.1766961661097; 
 Sun, 28 Dec 2025 14:41:01 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a92d94asm14001129d50.19.2025.12.28.14.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:41:00 -0800 (PST)
Message-ID: <24169d9f-3e8b-484b-843d-9ccac1750c42@linaro.org>
Date: Mon, 29 Dec 2025 09:40:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/avr: Inline translator_lduw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251218213053.61665-1-philmd@linaro.org>
 <20251218213053.61665-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218213053.61665-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:30, Philippe Mathieu-Daudé wrote:
> translator_lduw() is defined in "exec/translator.h" as:
> 
>   192 static inline uint16_t
>   193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   194 {
>   195     return translator_lduw_end(env, db, pc, MO_TE);
>   196 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since AVR only exists in little-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

