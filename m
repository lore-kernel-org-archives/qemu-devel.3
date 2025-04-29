Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7793DC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9r8L-0006bS-OE; Tue, 29 Apr 2025 16:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9r8H-0006Yz-SZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:00:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9r8F-0006qI-R8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:00:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227d6b530d8so72150475ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745956842; x=1746561642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEadjd5tOyr0eugK6N2eDCZrmBdzot8tRaocMzFdz8E=;
 b=p95zy4w8oRAgEPLnIyQ0k+I1CWg4zfugcMeBFA423649MNWqFx5+f2GvTidNc3k0qL
 PLWd9GD6J/S8mXEpi6uGok2Atawijb03EfF/Wa08ArGVgfMq5MiszxnEvb2ouMjMoSdi
 8dIuB5XbJmopGH0DTVNl7EG0fXreZKNo66lDrraN3FkVHwPtasqfZjv22O1iBFKHIJ5M
 pMYLrazHeiZp1UobZAr2nyi3pMMgvTndfQQtG/uNWjCdBynvyClXapwxKzxtMyUEMCA3
 i+EpwNB4tjg/eCKG+sdv7DxgdqDdSpk4OZrzswW/PNjc4r5RnB6LN6PXLmrcxLIyCpjV
 A2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745956842; x=1746561642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEadjd5tOyr0eugK6N2eDCZrmBdzot8tRaocMzFdz8E=;
 b=jb0nrdppKJm0LyR7gJrWzNnkfWmrajvsWC8ZZNvGB9sf6dnm+9DoDB93dWphR4YbcF
 ZbObrznQzUynRIPSB2oXdsApH6NFXkEqWpYUkqovOSovyqF5QjfDvDu5tR48IDidc12m
 0bFvRWPk2oF/oS16IunF4n+ykuCHHPJBH+C8guvuyrwczPVjClSw4jNgoxNU5M7X4PlV
 UyJ2tgTHfZOHt1zOqpzhlBTs2M/dt5uRkfaAWXrAOohK7rFdP3MwIIkaouQkN0VVzCqW
 LwMKCmgB8sfS8+PHPgfDY8SGcY3PBdnh1HQPbvmmzDnPV3JxTbHJbpAnxDZR5CgGVAIN
 KDGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmFUr25LZNq/C1TFq92Oa0DFjDSVcNM9yF8JqLmGW2RzOyffIgI4RcrdzwlVt0PE+lsfZUKkVtZLPZ@nongnu.org
X-Gm-Message-State: AOJu0YzrcctzJLkCw9pnFZrNiEqZJt4v9L/v/aXF0OO0UklXcvFvoi5h
 8D+HoLbv/HjNAZWjhR5k65dXiF9fCso8HNtjnFcQc3NTmtFZiImouEpV7Ir9i0EGeOVmue+PRFQ
 W
X-Gm-Gg: ASbGnctjCg8XPNekSYODSwZxPYlOWBL24wNSCG3xo6lrjBR4IxasjaA1a/pXQrwlWOm
 16rAc1c+eFrf5shGJyYI3PdKzbqWXZRQgq3QXK0NoL5WX9GghhAo4ATAPVmnbMJ5iKFg3Qeyx/X
 yOwrpP6xAuC8PmQwUiHrYIFgbexYq0Z+hQEwp/pTTHE8pzsGxu81nM1Y8PM4npgW+rRivViDkgA
 7gUz5q1zclDTazexNLDdltqSlVVGEJunTMXzC79RC6HGQCKHer9eeiPancJQDUzpD8//My4/b8n
 mi376vRMjmHpDL6meD7cYwhXyB6FzyCX5Q2/uXnffik3fCzEqgq875/0XmJIfB4NqW5Soy4VUhh
 6uncAU08=
X-Google-Smtp-Source: AGHT+IEZoTgr1IFy55UoNQYCBvlkTKTPvmpex4k8Fb1p6owsyOEkqUYGwawILCGn+1/oxjj+sWKZjg==
X-Received: by 2002:a17:902:d488:b0:224:1af1:87f4 with SMTP id
 d9443c01a7336-22df3507006mr11109715ad.22.1745956841902; 
 Tue, 29 Apr 2025 13:00:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76c17sm107474945ad.8.2025.04.29.13.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 13:00:40 -0700 (PDT)
Message-ID: <6af13861-91ed-423f-9d13-fffadab06fdd@linaro.org>
Date: Tue, 29 Apr 2025 13:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-7-richard.henderson@linaro.org>
 <39c6c35b-f483-4313-977d-544ad5946247@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <39c6c35b-f483-4313-977d-544ad5946247@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/28/25 23:39, Philippe Mathieu-Daudé wrote:
> On 28/4/25 22:10, Richard Henderson wrote:
>> This function is only relevant to tcg.
>> Move it to a tcg-specific file.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/riscv/cpu_helper.c  | 97 -------------------------------------
>>   target/riscv/tcg/tcg-cpu.c | 98 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 98 insertions(+), 97 deletions(-)
> 
> https://lore.kernel.org/qemu-devel/20230703183145.24779-9-philmd@linaro.org/ ;)
> 

Heh.  Incidentally, why a new cpu.c instead of the existing tcg-cpu.c?


r~

