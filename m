Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41DECA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 12:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unyvv-00077a-JY; Mon, 18 Aug 2025 08:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unyvs-00077A-VE
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:25:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unyvq-0005KF-8T
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:25:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso4447588f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755519944; x=1756124744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z/p9uBiPT9OZMAkn0ziiONnfOdHf3qCxhE7lfD/95Zw=;
 b=MsXjy/042DxXUYbG3JO1mJooDbH7zVLJJMyCXz6qYNigPEO47dnc1ewTIw5Un1nbtp
 ikwfy7iK+sUwI2DGPAsvDTk7Q9rK2YKSw/seJbm8ddC6BEJCKbSL5Un6aA5Nxg/D1585
 EGbHXpW2dORlPEkcekDpQynYMwJzFU8rbtKSECGmZHLbD7oOsY47Z/BfdUYBpfmksDHQ
 SHVHX19YSSw/g7ffWQzCDAf2s1iUQU7X+PgmxRc2WnLSwJtbwhto6zws20fKH1SMEmAI
 2ftyUm0hxy6RHUupzUcTLyZOG5J3CAP4r3fUx67u41oJLNJMcMf6eO6BIC9++fDbsnd9
 FB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755519944; x=1756124744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/p9uBiPT9OZMAkn0ziiONnfOdHf3qCxhE7lfD/95Zw=;
 b=jHejFQ52qQjxw6dbbh01EdisySaMAmvV1NUExFRx5zHNONu6coXYE9rG1BLPgzg1VP
 2z5FHTrEdAMhjBGIHU4ZXuovZuqVgO2NAvJsxbmH6e8fAlD0ynkMetSFq9pof12Jb9Mu
 0lPrFEmhECzg+gdBqJk3XyOmsY89K1/Od2N5oeMiJQ733dG8Xp/rRS6sMoMAfpjZ9o45
 bmyc/Hj2XOOGsV85VyQB6GF0od3n6+7bQBPg2O4KYUnaJYZVBAEVKQ73sNhdgKbLV7h1
 ww9Oel1P/0zX+l4n170Axm1SKkZhPbKc8/crrk/wRsrf6PYlMx3+U5dSrc9a2g1/Kbqq
 vaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU77Ee19M36QGcCwvFFj6spPp0rz+Jj3b3OLVzkoVoGaFHr1y2s4r3L3VJsaqnIBbW3acVsJYWq0QmL@nongnu.org
X-Gm-Message-State: AOJu0YwLqA6vVqnhE6JDCkHctesylGLUahc29z3Hz1Kr+isBMXknd+TV
 XUVWqBFUKtQ/CgqeXLduZBxYfZPyHkyqrXP6JbL1RbFODha8XForxG3b0RwiGfpLxcY=
X-Gm-Gg: ASbGncvxtJ1wBNbdg41Qv8RqQQi5taTB/0TL8wh8K8WBY3PeEzq+59oqCFN7BJ8enxw
 sNA4qx3KIvkrcGbbI57uUDSZBzcgv4FewbI4v9M7zaiyJ6oAM3muE6EgjP66TPs9NmCDOWrt6Wp
 BpmGwJcxGSB1gUarXIxlvYu0NzcET2mb1PF7UDq4uFqarf4u/IWcAyDcZFjOhzPkjqRCDsNa0R8
 s5/QaHrsqKiZSCpl/NQWWpDA5qp6cQ2sC+ug+KxTWO3TXGR63B7LX2VofHwW21lr4yVVkt6XmgA
 yDIckhtoj50A3zBB0SjoSEM47otJVRTrTaBQhKUe3wiicJ+Bn81WYImMliUoBqj99NfRj0M4CPP
 eMRgoqgSEHU03BRH7x7m9j6ebSNAiOfFff/JcH7M0R4jpD7f5LZ+hBh2QtTge89igqw==
X-Google-Smtp-Source: AGHT+IGilkvPna/pseBpmJqr7m7HiNqKa0DQPhOqtEPGu9DNp6OgfZZHu3z37vXmU8EQc4jWi9cYqQ==
X-Received: by 2002:a5d:5f46:0:b0:3b6:1a8c:569f with SMTP id
 ffacd0b85a97d-3bb66943594mr9292597f8f.1.1755519943893; 
 Mon, 18 Aug 2025 05:25:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9a8asm12641646f8f.39.2025.08.18.05.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 05:25:43 -0700 (PDT)
Message-ID: <2265e19f-cc45-4e23-a8f2-717641247e67@linaro.org>
Date: Mon, 18 Aug 2025 14:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] target/arm/hvf cleanups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/8/25 06:13, Richard Henderson wrote:
> While working on other things cpregs related, I noticed that
> target/arm/hvf failed to produce a sorted cpreg_indexes[].
> 
> I wondered if that explained the migration-test failure that
> we have, but no such luck.  (I have no idea how to debug that
> test, btw; so far it is still just a mysterious SIGSEGV.)

I'm experiencing a pleasant speedup. I suppose this is
expected, due to the array rearrangement.

> Richard Henderson (7):
>    target/arm: Introduce KVMID_AA64_SYS_REG64
>    target/arm: Move compare_u64 to helper.c
>    target/arm/hvf: Split out sysreg.c.inc
>    target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
>    target/arm/hvf: Remove hvf_sreg_match.key
>    target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
>    target/arm/hvf: Sort the cpreg_indexes array
Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


