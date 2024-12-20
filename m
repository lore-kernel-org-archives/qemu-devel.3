Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA52E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfdN-00053M-DA; Fri, 20 Dec 2024 11:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfdK-000533-NE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:13:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfdJ-0005NQ-4M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:13:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso20232705e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711223; x=1735316023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aMDa/Rl09wde133rM4FN2QRMrXvdllRZVl5uvENi3Uc=;
 b=NWcqWulTUHSrulHLP95zUUtzdrQ87kNX3tBsQR2w0urZOs7F5r813gsG4ft9UIa4Ip
 lneo7dQF0Fg1mcXNy+7c6i/zr5wlg5Pod0k5u9E3ruip6IXbdrXQBzp3mG8g/ll1Oe8K
 rLZXjWBnVODGZBRTyeQS1dFBfMmjQOfdRifwxyPrrLiaCkWbDs1dKRp+qWijvBhe8tI0
 9vLzUD2y+0/xu8lfGB7ftyud29wCIPiXtnOnGUVRVkAzmOLv3f8BHrYR/9d4KH9vTQ2n
 7PJG4T3Dt3IPc79M2OpjVT9vOOq7mCi4mKEoJW56JW4vUXplv4WXV8XgLjIcmidrIymg
 oQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711223; x=1735316023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMDa/Rl09wde133rM4FN2QRMrXvdllRZVl5uvENi3Uc=;
 b=g5QcOREakLj/+VtX2tRChxUdt5fx2gN2cnOiDU3N2GcIjoGC+vvwM7BphL7P1CywoC
 x0zEs2A+kzWukYQOOboSiLtf/UrjdQiI7O5xmw6ba3SUIsryzqnlmRsLxOxONL2cy+AR
 5dhGhm3furemF8TfdNRFqD3r/fP4VtrieMHBX5bBaB7ahduTBPw+a9hdlKXZIuEyjSl2
 sCiFl+efUhk6fdF+jYfcGdLkHEf6/P+Qtdb0pW+1WUVLbIWbh3PutkMm3nelEV7LkfLL
 ZjQRNzuifKUK12to60HyQ6BnUp3fQuBd44XXmr6fK3WR1kOi7fNtJuFmDMGSuLcqSawo
 IgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfRAPGZkcey5Yf6xLF3Ddj+aKUR55/4R0mjT2k1NkxMY9rICX7YTCjEK5brjoZeaP0QeFrEd49UabI@nongnu.org
X-Gm-Message-State: AOJu0YyQZbdN4slNnNhZLh1u15z1+MUYUeYf4TFBtFQ+sHEVJlecPMIo
 riUHT1S2T25YrVg/jwnzPcKQMrQy20HNZosNf2CxrPr/4s+OwgNru5LgILRcEpE=
X-Gm-Gg: ASbGncvx557MOrVZUQQLEscnJm+j4/Q/Cqhx6W8pXUNcBMVmwlYlOSLQduZ0injoBz1
 XvWMHx1eqD+QU2viUnencgK3cVon2WVywxODM9V28zl1cwGB4oVPnLp5WuuthwlXbAxLOC1dcdZ
 5ZRO8YWQOiCYjs/YrYGahY6V4hj3NufDJADIMBRb4mBsfCZOFTYvcMmw9girtA7OlrdMfCdG+WV
 pB7SEdPa3JbHFm8qhjC6tKOhHNLBEArv3qbVoAjFMSTbsplJ53kcC2TjeywAHbDlQ==
X-Google-Smtp-Source: AGHT+IFOaB44qYvYCICOBKjNavtnSnBwrOklb8K5JuO/DiQ6NHReT1L41gtejYsQvMVIj8N0pj0eOw==
X-Received: by 2002:a05:6000:184e:b0:386:3082:ee2d with SMTP id
 ffacd0b85a97d-38a223ffb7dmr2626754f8f.41.1734711222710; 
 Fri, 20 Dec 2024 08:13:42 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d32sm4405400f8f.99.2024.12.20.08.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 08:13:42 -0800 (PST)
Message-ID: <23da6bd5-2f4e-4138-b2f3-56cdb3bfdaa7@linaro.org>
Date: Fri, 20 Dec 2024 17:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Restrict curr_cflags() declaration to
 'internal-common.h'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241216214030.59393-1-philmd@linaro.org>
 <eeeca090-5d4e-4366-a565-3f705ed3bf31@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eeeca090-5d4e-4366-a565-3f705ed3bf31@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/12/24 15:22, Richard Henderson wrote:
> On 12/16/24 15:40, Philippe Mathieu-Daudé wrote:
>> curr_cflags() is only used within accel/tcg/,
>> move its declaration to accel/tcg/internal-common.h.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/internal-common.h | 3 +++
>>   include/exec/cpu-common.h   | 3 ---
>>   accel/tcg/watchpoint.c      | 1 +
>>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> 
> Thanks, queued.

Thanks but I'll take it via my tree to avoid blocking my PR :)

