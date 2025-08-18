Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52AECA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unt6z-0005gK-0D; Mon, 18 Aug 2025 02:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unt6x-0005fO-7k
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:12:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unt6v-0006tc-NY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:12:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1963so1773543f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755497566; x=1756102366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3eQF8SZr8WFsPmUilUd6zztEOJgHBCpwO4YPtgjJDQ=;
 b=SXSrMzomy8kMs7DhxpwYppsA03GavIvI+lay6cXRDReIrQrz6JviJRdj46tpSWiZGr
 82uQg3bFxVPlue0zXqQaL7AbqSWOKstleE9kwJ9/BzKd/Ma1ZDz5ogZb2OCfUyRCcN7C
 42rPfBH2xhLMQCPbXqVe7e2bolWSid/IP8aHNc47QbiZlIrbUpW9mgvP13cM6AdE5VpF
 B+Tjm7USOMc52SOj2JPkIXWLXkC+Got3DBIEJs+HAlWNclNnuvUT8D/3f7sdtzuGhC5l
 djwq7kJ5qunwNut8zxFhxLSOv0YL4+OrVP9U1DcLBjyxVuA6306yNBycs1Acv2HneJea
 3yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755497566; x=1756102366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3eQF8SZr8WFsPmUilUd6zztEOJgHBCpwO4YPtgjJDQ=;
 b=aFubZQAtjb0YnQRZ5ShIAZcEyqoZS3kt0fSWUUo736ta2Qsx1aKfa0quUelNq4po/F
 14ijMdtlfzcRn+WRFmCZFZy9WIM8BaMO/Ou16THV5o0UoEIC9lVbgejnqEZjD2Xo+mEp
 cZXzCzodHWEwSQsUBKHH04qCU8I1X3im8bFzSQ/UupRuTRIosEZ44rf12Hf7YTHQx9MG
 3ffx7S78A9tVhReP9aAFPTvvLfD7lh+8ELLt+IYs5c/UufzfVIDRmDeSkNVZJdc533Jp
 PWZAgB88fhRULDsj1poMLNehhLX/hvHpUbjwtQXtNJwmD41FQcUSswDAQU3Y/QeX6Bzf
 vp9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9TivawUJ4VcIznvcg3yShQEGAw9HgFm3jPVKmkRt+sduE1KvAWOv+eXizg7o7oKPutxQ4suJvmjMt@nongnu.org
X-Gm-Message-State: AOJu0YwmNBLXoUsQEHXgpqkghxYYAAmbNegm2S2yOjGnOfho76k9YqSb
 SeLHLgMOHkPVBN6xt8uJEJ/AhqWA94u775/exnLKNI6BBiaIzLnBS87ZOyrYeBuZxOU=
X-Gm-Gg: ASbGncuiZSYpfXD2Ge2lpIS5W/gpcgYfkgqnKav4AKtoiQDGtqAiw49rAn1jPUuRR1b
 2phIJ7wR+LULYITajK8o+a1ZY7I5u9hZo2vmncNm43dPVrqyOJ8V8nFxnDriEnV6BSVImImrmXL
 pwSILAjf2X1EURcfi+HIPX6Po+uLTNqwPzS4NZBmLxIRPzQe72dKqjA+A2LU/gnNsSP2WLY+syM
 HKzUayNnuxUoO/8TFVEhDy8qq+HmZ2yJEm1o9Pxh6FkpBtBl7OGndcTVtHUkc7FAg+BjJf04SZM
 A9DdXeT3n7GQ5onRWvQY03FPJJOYgQIqMM74YP+5Kgl324ZotdXM3ofva0u8VK3H+oWQEI1JnEB
 ciG7m1oXQm0fXgyshpzgEpv4l/qdwH+VFiJi/vXt7vYD3j29QE66Rvgguo8rNedq/mg==
X-Google-Smtp-Source: AGHT+IGcTJOP6SNO6AnqsZENiK4LbOgYyJUHS2CxGHzgSAn6vuZbd3OK7w1zcaPV/KXI3YHNJ0FovA==
X-Received: by 2002:a05:6000:2008:b0:3b7:970d:a565 with SMTP id
 ffacd0b85a97d-3bc6aa27b1cmr5015801f8f.46.1755497566274; 
 Sun, 17 Aug 2025 23:12:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9a72sm11420701f8f.34.2025.08.17.23.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:12:45 -0700 (PDT)
Message-ID: <0e92ebdd-a62a-433c-9fa4-8ba0678cfa74@linaro.org>
Date: Mon, 18 Aug 2025 08:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/arm: Move compare_u64 to helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
> We will use this function beyond kvm.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h |  3 +++
>   target/arm/helper.c | 11 +++++++++++
>   target/arm/kvm.c    | 11 -----------
>   3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


