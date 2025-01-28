Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD78C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcr8l-0000lE-LS; Tue, 28 Jan 2025 14:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr8g-0000fk-US
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:20:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr8f-0003Rl-H0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:20:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso100381585ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738092043; x=1738696843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dtPXa4OiG8kFHCPmG0owNIdqBZhTVUZzDu/vsTz9GM=;
 b=SCSe2QfR5hMFlle6l7zoQXMp0SvUBOPWQX3mfDQOSvMw68O9XML3rldTIdkQPXZJwd
 h+dJBYzR5588HArURreZCFdoQHRNFlIYLWRtY69Tris+LqLRvQ6P+SaSLFgF5H+CPZzf
 bj3M+OX4VOHyW1B6RnWiYEOZDhcvBEPeG4x/WL6KGfJPSQ//HzWcQ77Bx3iQOz5pq78S
 LNzdAeQBrmOQxAMV58pb4xRNPzygtBg6DSpvmZR7njRwUqx+l+YEMUBFH5xgMr5E+8EH
 PwZCQHXesPbKpKCIEI+Vv7+Cku6dDH17shOVArGimN7YySmfLA5+86pINPam8mU3Cq0S
 XPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738092043; x=1738696843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dtPXa4OiG8kFHCPmG0owNIdqBZhTVUZzDu/vsTz9GM=;
 b=kj7MuDkaUUZwmJ9JKqqVhAtAPNp9OBuhNAtrGgiCMUCacYgoCy0NIG744NYoabRCiz
 3wdWFdzumL3acQ1CZ55wcAsX63jvkn5XaO1nEv6Z0t4z7LjJBsLJCKZEvL+1zOIyqBLm
 5Q8kmhqMHHAnHS3jFxu2A7XqOSRT3oqQ91Gz9C13bH4mh4Qt3Vj+ouWFDAf2ayprXY/9
 CC+2OcFqvgWgfIZ+wSx+SjWKILLm+iUV0Q9h9AFDUb9hEP02nN+0AX7W/Ffe0m0nQ728
 hwQ1VhxC7nLm5QfQJfEH8R4AlWUbY5mc8skziodl3zwCeUyqbwJqud78/l5fzOBfqodd
 VmYQ==
X-Gm-Message-State: AOJu0Yxglw3rf2stTDKHn5dXpvLDj48QRIRmgUA3ChmbO2BSt9HsDEVw
 wNVewzApxtYecCmZf8PHrmwsVss1RYZiqcB+Qwh+jajF0+FWDj+XzR1nWxayhlq3L3nmJb9Ac9g
 D
X-Gm-Gg: ASbGnctO6oNqBXRlGTY3QI3ifB7bNILDTZlBOVYFZuBiwf1vDbJRfNZ697HZUTVslYF
 +OfzqFizHrJe9Hd05GFNNVlduHXpCNL4FndUhldikIBG/cA9KRZr7sU9cWs7JFVCGVv7ISd05mu
 mgfSXu87Xb5Dc0BB7Q8LTB2SsQzmuXHjUJnkEEUCVVYeaAQolPPLj6nNqoob5lu3BhzvAsl58XL
 tMmO+HaOR4fgxhMABTJEZ+D4A1Na916nGyg1/UluXFImHydRZtY2cv6hzFtjXCxE0yGACWUJsKT
 QONYXvOxH7+yu6vPNDAVq1oQFko0fKxu8T00ZL6QttPZl8uAPI9RKvjnJA==
X-Google-Smtp-Source: AGHT+IHC4HB8CuokfWeMF+a3eaZEj5LfiEwsugpEeYvZPT0+QpDQl2bdjQKum7yBDpFtq6Sl9coE9w==
X-Received: by 2002:a05:6a20:a126:b0:1db:de38:294b with SMTP id
 adf61e73a8af0-1ed7a6f9350mr720625637.38.1738092043188; 
 Tue, 28 Jan 2025 11:20:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69e652sm9591255b3a.34.2025.01.28.11.20.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:20:42 -0800 (PST)
Message-ID: <2594d450-e122-4afe-8ad1-632cb348d699@linaro.org>
Date: Tue, 28 Jan 2025 11:20:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/qtest/migration: Initialize
 MigrationTestEnv::arch early
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135429.8500-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 05:54, Philippe Mathieu-Daudé wrote:
> Some tests expectMigrationTestEnv::arch to be set. Initialize
> it early enough to avoid SIGSEGV, for example like the following
> g_str_equal() call in migration/precopy-tests.c:
> 
>     954 void migration_test_add_precopy(MigrationTestEnv *env)
>     955 {
>     ...
>    1001     if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
>    1002
>    1003         migration_test_add("/migration/dirty_ring",
>    1004                            test_precopy_unix_dirty_ring);
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/qtest/migration/framework.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

