Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F649C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVlH-00018k-4n; Thu, 01 May 2025 11:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVlF-00014Q-6h
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:23:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVl9-0005Li-S8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:23:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso995399b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113014; x=1746717814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7n108UvSqkNg4G+6t+Prq0mGC9LU+Xzgi3XWfeqdPY=;
 b=FKsBgo98SSXfj6WGCWF6WAM5LwP6Cxr37pAOzmooxnhvyTRQy1FuUw2TIa2npFrDvE
 plV8dRHPhynX9F7fU9WdQb7tc8qjjS+cnZu2+fhnAc1BC3JR3LlYnKaZZMgUPh7NnBK/
 1PKPxdYlbV5XRyJi+ukqtd19am2UaGsBQOqfHzZEAFO69Pv3ou8FexQIf1dHXJ5hL/jY
 iZYaIHf3hsgpDEkyDNyFQ97J4945SPOort/UnCphdCWG7C9i0iby3xwbpo3OUvkHb7ek
 2F6upALiAstTYK2WAIj4UVkyDqR2a7ir6Hua/XR4gVj1MIFjoX18wJVMdhss6erwajyH
 vRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113014; x=1746717814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7n108UvSqkNg4G+6t+Prq0mGC9LU+Xzgi3XWfeqdPY=;
 b=P1S/QYHI5ckP0f26JdbblaXBTCvIoLZcbBTB3FOxM7p6SmgiAHrw9uxpImU7wsXjw+
 J9uYRHY53hfHHteQYqbwO6wm3qw3m4QYEgK+STRJ0BzI8CcYvYM2gXlS6en0nM1oKvec
 UuIvebK/AFiPbNFbVeieoC7IuXMGVhwuLd2tOEtBP9XGbJ/TZ6Cbo6U6VlHziSDo6VF3
 AOHoiL9iuKqc+f0keaNUyX1idW5y5Rt576KvlUALQIB7BRIxs4vbjiRzTF4inVLYvk6z
 Y4tWtjFqQ4qs8zRxcRMauftt4fzrVmAlE/jNhSmO8V8Wtf5NTCZ0IYlZIhT+U0iOGkLo
 Bc6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWkfYyctrz7XdcgBo6x9NLvZcDcDsxS8jbAsJit3ocYAYzOtYsyjydCjY9LcPJwUxIvqUjKhxAYwIk@nongnu.org
X-Gm-Message-State: AOJu0YzkKtBNE4yrOmHcs80JOIvKwJQ3fw1L8R4VSJmluPuuFNYyoT/1
 /jZO0La47iW8AqJnByOklfVRVhkEVmEi18+kJKb5fx9ZbAA1i8LpnMY3TM9XmSkV8wyycjmODDq
 5
X-Gm-Gg: ASbGncu44Cj0zkYB6Y8UOYtN3sHi0vszc38WnpYDQ6jpziTTKkUTFGa8Kus7wC9JHjC
 9kyi6cev0F/XQQowxkBYwOsk/LGKqOSUfXYeTOzRhaQH+am2Cvk/h457smpoQqFG6Eg0uY+GGmr
 h6tvFU1KlNZrJDufxEd79c1SImPenN2gShytm0UJeFwTblRay1tnhp3CbCK4JIrGfHfDoPUAK+Y
 UsZkBvLgFVIfNZVcQEM958LZvliLCyKkxpjk3/XAMpBpxZkn44bbB3+cENPQ8HBJ63uoKzaEs33
 6t+Zz/ZjkblxcKd+ncPjBGRCfiAoZbckYwPIj1koW1JuREQNm4bS3Nxwwq5GFu7sqCxBmVnEgnT
 qIScV5SEFh4inT5WLrw==
X-Google-Smtp-Source: AGHT+IG+xQpwe9JF6Emr8LMDFsv4jviepaSVeUO75oUuLU3qAugUOfQvpi7rbysYNF5LL/QQQa9dMA==
X-Received: by 2002:a05:6a00:c91:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-74047785114mr4469458b3a.10.1746113014345; 
 Thu, 01 May 2025 08:23:34 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb195bsm933775b3a.36.2025.05.01.08.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:23:33 -0700 (PDT)
Message-ID: <cf287b71-59c4-45a9-b0cd-42b9425b410f@linaro.org>
Date: Thu, 1 May 2025 08:23:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/33] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Associated code is protected by cpu_isar_feature(aa64*)
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/arch_dump.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

