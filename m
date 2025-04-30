Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69EDC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAjE-0000yb-B2; Wed, 30 Apr 2025 12:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAj1-0000vM-CV
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:55:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAiz-0002r9-Qs
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:55:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227cf12df27so1393505ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032156; x=1746636956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=93Sa+LElEqpL/1w6Hw81G4EgtaYAZcKRdaMRrV72LVg=;
 b=pdo9CO8qPFVnIH22j6mJlAumtrqgkme24jtSsdU6gIlhW/DVvN3GvkYKNDyTpD9x55
 7ulteMDipiGFDRwJUrwkoBd+Brn5RLiHezYILxhqEzjyJaU2/E9hIkkenFr1MvkYzF08
 iVY/v0THD1dkB/U6fj7naLHmrwkcptbu9d7yk0wSJO1hkWFWGFpiyjatp9uOa8/Bk0U8
 BxuHDYAQnUYK5PYJXtj2cvlf9Klz3m1RkiTcKzZ88ufhutDBsw6XB8LTJHTEqgXNfa3i
 3k6BqVaLNl/VGjl3+iD9H5HhisN0HNAwLmcrBk1ycvUeIGILmJu7k6m5QCwhHEQ5QlF1
 C3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032156; x=1746636956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93Sa+LElEqpL/1w6Hw81G4EgtaYAZcKRdaMRrV72LVg=;
 b=AWgOkATgkvyJeGZGd6iFQxtrxHo05Ait+FXuEwmASvPZoehwc7lkFruo3JdmUYR5nS
 e4/7h2NAmpLTbADVcEMU6yqz0FOXQydD96My7cNpX6KV8BoXGbY1/O0UPR50BEdmL8OZ
 SXYx/fvfDmd70et8jv7vXNV5ATvU0UzzzPwqRkQyjlPQBgWwrEPPhPb7tRJJLydphOKL
 sVTWm7OvR+gAD8J69nqXcJfNKxaHxOc5QOuK01IN8ltxdWPS35vjnabNm3DMeii4LxdM
 uCj0dQeiq2GqziwQxf7f3cl6nPZRfaXtwJwe3cwOemXxTI5q+ocJvihp0gKfq0khy00z
 POqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFaNgZD08EPmz34338RhHn/2KCPj7L9MufHcZnqBFETGBkmNPiaTuU9xJ6F8qlODAto4mz3mCvwkJQ@nongnu.org
X-Gm-Message-State: AOJu0YyCRvrhJTUwEa+yOfxM9A5VyPYqjuCBhWsuRGqIj1fEUceTVgED
 nXqZxgzOn+XvCMJ84CtAOltTgL1/+yTa9ZbLkgj+j887QykqZY206Y2qbRakCPw=
X-Gm-Gg: ASbGncv+aLSDvcVGfZmo+qf1NEryLbqR0QnLYAZb85VN69W3XkN8PrpsxnA6HMFqcPL
 kPhRqcW8MFYPheByYL0c9863ZoeESGSOqPkkf9XmiMbrGFEqv7Ca5LZu/JoxMTZ3Wn6+vqg35hi
 ItGvVgrflfNXKWNiCbePCXSZZ6fit3Jy5VrTHj/I4wdHwkxL33V3kRXTEFXvNZ3AEvm69khBfPz
 X4obh7Q9WSyaUw+kbALjjd6BDv9pfmWFiGtVSvFOuYm+hOXAbodeBYl+Uc61XW3ux0XkeeUkgJO
 AXK17/KzQhEVDpOJor7EsDYCiVaTTImyHZQaOeOH0uWztRNGMTT03w==
X-Google-Smtp-Source: AGHT+IHJgVxSajiLnW5KWNjjYwze/3F9e0Dj3uU9xLbWz6EcX27lYzzqPV2PyWzIPVXo8SWzPQ0Vyw==
X-Received: by 2002:a17:902:cf10:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-22e03429f77mr2768005ad.10.1746032156364; 
 Wed, 30 Apr 2025 09:55:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76fa2sm125197005ad.19.2025.04.30.09.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:55:56 -0700 (PDT)
Message-ID: <cba8d86a-2ff2-4d01-91cd-fd5b02c2e588@linaro.org>
Date: Wed, 30 Apr 2025 09:55:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


