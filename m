Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21A9C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmGh-0001HY-Kd; Wed, 19 Aug 2026 15:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGg-0001H2-J3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGf-0000Fp-4B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso1319074a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168887; x=1787773687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mj7aRthqObDz/pmLSm6BnLAGS2A/rxYvyTRmD0ALh1M=;
 b=CNoseFUBnnNRMlrWYdUfp3cc2ngn6cskeNucjSQ0v3h1rNgH4zdaAwleK4xjfNvP5N
 cRPICx/6dxaO/qoqIAgGET8wZwGGZJGztkiq9HX8cyZtTE2nIyzwqlEIA3YexTznqls9
 es4T/1x2GL+UBKr6/rulTmmxG/xYy7xv6Sfp7qbjwg/FST0ZLlIqWYJuWhOp6ZV/UNpJ
 20cHWcNulB/+RFuM5kITehQpVK2VOYvkrjNc82uqxi7jFjEp0UJ7WPAAGh51cb/2hkw4
 0wcCPQckxLUtJXmmZ/IvjGbq57vbrQqLTp/IS7GevQ1AJpaSOsgblRxxqwiWKNqpn+6w
 qaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168887; x=1787773687;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mj7aRthqObDz/pmLSm6BnLAGS2A/rxYvyTRmD0ALh1M=;
 b=fY6K4DqHIWAyvdWl1i/8HnXODxb71VUxHBVqT2zycJ6eQni2/qwpq16RAJfYqasMaa
 EASEi4hDJ61dIlaTeh7V6x8K1EQHTaEniqO6DISDSHCP3xv2ZNVtYEGm0FX+iQK1u18G
 Py4pF8BPOL734UtPiKkKkBdAEG5ZoLF1mxoVA0lGtKX0/Z5rS6jES602uMflzAXvRXDd
 rvH8u1AlgwDM9CPZtQMmKA5DGcI/+M4pFfiFKowTO9nXpYNRETrymGKqeMnkY0tfboaK
 QeJDmcOAmEHDZW5QYQBNy5J4EoXzwBT87tTVGFfCspr0D9/n7H+IR0afQ0nzEiZhLmju
 rZdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rod4yYEZL9I3FWOQ/WM/XeUg7kMNtpr1Nr6ze+VAYfQLEDqGkkQZYVoNXCukXYE9H9XGtnPUv4f4t/a@nongnu.org
X-Gm-Message-State: AFuF++kPApIF1n2fjHVWkkOOfB1wJrgIW3zVVEpUVjtyTxCE8kqoNJMW
 K1j9sWHLGSjuOyAInHr4ZsThEa+P3AjQWQHH6N1uz4bbxTKLNaOd9OXPO0soWm7iMto=
X-Gm-Gg: AR+sD11b4FFUVENKxBYnAUjnhG9axludjKidQbGsMNPd7I+8W0YtX3InIoj7wMTxi56
 b/Nf3FMVZjVHLkJsveoJAn1q2NiQzRhGV/tdE82+rQbpEBykBSDxiZ9H7nMWJ79WnUkW8s3ICD/
 /D9SWGH3+m7ug2NbUy59aS4zne4Wa/SM+PXn5qWeHK1FgNDTJY7k6THNwPw7/G4/OLFpwGvte9E
 a1wHnI6biIIHcWaeZauDP/j1WP1C+SgzBD2RbNPOipoGSxzZ/Hmuu4L7ayCocgr7uHViyEPml8E
 a4Kv3x7kCG1GVJmy+cFMiKv4s2C7H9Y9DEvqHXC3GyinpW414qLzD3o+PWAIWLoKD9mtU3nAACR
 QPX/o0Xi3Dubq70hs7G4N8h91ss9ennJwzV4n8E249Zbvo9ST1bGEhWBiTmBswlzj61wqfOnQ71
 9s32cUOXyPNlA/O3asu9vkhibNqTWepn1EgSeNYnxoMIJbfsC1V/YyiCH5aDvL10uYjMBRo3Y+6
 JLk7p+t
X-Received: by 2002:a17:90b:4a4b:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-3958054b82bmr11905914a91.0.1787168887433; 
 Wed, 19 Aug 2026 12:48:07 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm4055310a91.7.2026.08.19.12.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:48:06 -0700 (PDT)
Message-ID: <c7373f94-8ea1-428a-84ab-0fa76e529692@linaro.org>
Date: Wed, 19 Aug 2026 12:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] linux-user: Remove 32bit host support in
 thunk_convert|print()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-7-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/18/26 10:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.
> 
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   linux-user/thunk.c | 47 +++-------------------------------------------
>   1 file changed, 3 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

