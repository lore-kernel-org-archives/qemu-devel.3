Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D6C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbSP-0000Pz-OV; Thu, 31 Jul 2025 18:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbEg-0003Be-Nf
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:54:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbEf-0003VM-8P
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:54:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so1574225b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998888; x=1754603688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmboZ4eHGQ/kIW0KKyRvGgoame92JAhsUpHf5zohKg4=;
 b=QQSvLR98skwTvUNTzKPKvqK8NpbZyy1qxQfLtSG2kUbGttIFoLH4rGjQOXPs6twHnY
 HDpQ5PS3Mfh3j6kF43Kn3qRD90tFZxw0OEoz4z0ePX4wmAe6nxQqGio/i4Fu5mZRYE+J
 N+umBsFDAwWL7zR9EholHxJLWrn1lY1BFBDUcm4QxDgNK4WaAsGH1jimg9AleANssAD7
 tV/89AZVIKhSo67LhPgS/0YGD2shc/mr9W/xUPaY7f88qCfWaePx9QgvwLbMCMsJW6Ed
 0iucBfWX9RKoqQstyP2MZHEyMwGzUHFTGtMHxDkb+2iGs3ZEyw/6VBYUduIJHYAOZvZD
 jfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998888; x=1754603688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WmboZ4eHGQ/kIW0KKyRvGgoame92JAhsUpHf5zohKg4=;
 b=KyRY/zj1hHk3i8PHrfdIuecD0nY0iUkv+j5JgrTsHo9yc/POOq89NX1mXh962YM0hj
 jMfocSfFZt37Nm+ks+Qie0rh+hq9/6Sr85fAiSTdKR1j0J/nRODEOa965yOedFiIiww7
 Z+/vOiVDa9nqMpzNZqpMh1/9V72Tr3JnVBdmZv3L5iaH5nzmOHnFOXqenuahTRnPcpzJ
 3mBZOi3x3pR9zZE9dQzEFE3kClmnybA9GUGiIFNTnv/ZjzeQ/TGq/ENAHIeMtgSCjFOe
 N6W5OmVQxMfZyWexfL7GP2iEVExms7K/HuvjWkA6JtnzjWSTp8Oub8qaQmwEOiZ6tZd6
 Mk4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFdz4PTD91ZctjwfkepYnvIHkYsUy5uNmG7N5+kmMGbdh0zWjz6gdQHV5QV+MUYR78NL2UUEygwdTy@nongnu.org
X-Gm-Message-State: AOJu0YxyKwgnOptH3Yk76NSxprHIkZTtsoEciLuchz95vwg0d81BJJQW
 HReSAe38rVLGxNg2e5lBJwVtJHDfS8gcz5APRajB6d0rZU5nV44fMIRkx1N1jHxPYGxN9ibSMx3
 HIyz8
X-Gm-Gg: ASbGncsWtA3bBJ6RaAzr4dSXHdb1gA/j+A2BA72yzC0YWHUhoFHeV6HzMcHiYO9AHNY
 U+fDF2WLZa+Ds3t6IYcJCMFcLqa8L69ddNmiD/QICOLZ7tU82JxYNxe+lq7Pw3IvIyqDCaFNvr6
 /SXgvXrSwsZIym8cp8kj+BwXmbUKPELHP/56mB923tsM+zdvrCy6MfaDphoEVjp0706nxczL94G
 HW1RbpUwjqHcSb8i2tewFp9DdVPg+E8Fv4f0n1wF5hfNWcvsf8YqJ0SdrC3tWtgJRVY1vfRNnLy
 efG/ZuTa7J/74vC299ep9NyL+ikkLX4vbOoqiYmOyI9uZ32dgKDh3efd3WnospV+RULZ4iEISgW
 ONvZncs8ehVQihF4IygUquIvHEjdt/ycJ9/VFRFz2ESpcKw==
X-Google-Smtp-Source: AGHT+IE61+JkEms7mvwrCtkF9V7eu8qG5cEP0uNEk6gtbqSx2Zto5kK4NzL+71vULGl7yx9z4qn25w==
X-Received: by 2002:a05:6a20:1593:b0:23d:34f2:3a22 with SMTP id
 adf61e73a8af0-23dd7b33fd7mr5187585637.7.1753998887735; 
 Thu, 31 Jul 2025 14:54:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422baea948sm2312845a12.43.2025.07.31.14.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:54:47 -0700 (PDT)
Message-ID: <10af0b4e-5e35-4356-8813-9e11c0d0d3a6@linaro.org>
Date: Thu, 31 Jul 2025 14:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 73/82] linux-user/aarch64: Release gcs stack on thread exit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-74-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-74-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


