Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA1DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9Y-0004Qv-Ok; Sat, 30 Aug 2025 11:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uruQf-0001Vr-Bw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:25:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uruQd-0005nr-96
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:25:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso1654930b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455943; x=1757060743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eazFEZ/warEqmiIBMckVciehCS3zVdzmndLA33pq8q8=;
 b=jwD/DZ3AC2wAWZHFSEdGq8ixQ6PyE2qU4WU2l5ma++/mtHx9VOj/WsCUHSehkBKnjH
 MlBVGkpJDo/C2e/P3+UVPMkiQP0uBieT35LFh0p0y2OO6du/hfomvyVLWgpRY6Llcxuv
 RuNKN8v8ADfskJpKmZGAVNegUkT2NordoT/+TuJyMQiEzSYuErGJ9l5Yn+e3c/hNwPwl
 VNbYTAnqxdfNjALGeWdAq2yA0XdAr2NGAzKFgEsjYUjl9vGHEiL80YDva1phtRoa1M1b
 v8wLzCgXFKECM/OYQCckdhOIWgeK6sEkiLTbG/nnmh5h7Dv6KCJadu16vdCuFyVVjg1n
 tgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455943; x=1757060743;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eazFEZ/warEqmiIBMckVciehCS3zVdzmndLA33pq8q8=;
 b=MaMUyUo6jb5xCsH4M1LJp6KfrJ2EiG9UEeJtpLKFamf1BVw8s7bW5AAbGUkg3+UcST
 XtsK0/3ZUqOTTUYHtTjPvIK06IU6aJLNM+nTqtsHI0CSsyJOoPDgVoMB6+ruGnnUzw5f
 FVZIEEZuc6SKu05oNgTeOZzM2AG49bNua6q8TfACLOL8TtSOW/KkfYcu6R7sV4aIqBZK
 6aPH357eLOKUC1vjmAX+9A4XNkgUI4JmhjMoQ1coqcB0S6GA1IYRZ/OA1i6D9O/AwWpT
 T1uk0XX9P6WsHIwqLzTJq23tAb9UJQPq5uwFBZeJfo97mBqCI5SQVRO4VZkVSU8z1833
 +IbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/ppmxLo2I29dGcUirCwcijs9wk8NbUXI16XLkbJyAtxsW0RZ3PG26tDJDoNBTvaCFQV5qAXTxNYN@nongnu.org
X-Gm-Message-State: AOJu0YycRq4vgXuzhpbZfTnW0fgw0GFyFROzXZl64MSvbWtFFtmpoPZh
 WQ1hkUL4RcFPnyCJqfmhyKN1drEJvih3iz6FNlYdKd7R/1mdF0eD402ThaezOf63yxY=
X-Gm-Gg: ASbGncs+HZFNilIp4MLIerhUTauLWeSdBhpTFiKA1iPePef574gIRQqYyQAKNgEfIFq
 nFasMHIm9wnly+95oJtliE+uYKBDv9Jq7ig8ReFy82JK/tD3r8VldjWUs//ZpZabn/zFLlFRRU6
 Ppaw9Wjaxb7qYkz4XBkV57tlT2WOKmo7g8yLV6gSLBht8Nx14qQzHfoY8GSJ6flxMvbb5hQ4FSO
 KWxR5gZkbZI6Jj9q42lGi5gdgqmpZV4Rl4X0I2GXZPuMWcWsJt9lMkSLs8Cs2OzqGGZUWBZNdM0
 icU978A1wlqHrnBsyiQN4VKgkFdDsoSYli4MUKWiYPiiVZ2JeQJLs7URQcf7p+uwpujMatgbJqA
 paSBF1ZznLxjLh5HzS0RV0eYQP71QVxzqHLRtMoHs9R8I6OLqk679Xiz+p61k1A==
X-Google-Smtp-Source: AGHT+IG+52+QcJeI4T+LjB/SUtwVF0SeTg7BbpL29q3bp+hQU6LT5cBDI++xxIO2caafzOZIXwIdwg==
X-Received: by 2002:a05:6a21:6d8a:b0:243:9c12:e52c with SMTP id
 adf61e73a8af0-2439c12f831mr13810436637.4.1756455943159; 
 Fri, 29 Aug 2025 01:25:43 -0700 (PDT)
Received: from [10.48.39.227] ([172.56.181.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2d97acsm1643761b3a.41.2025.08.29.01.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 01:25:42 -0700 (PDT)
Message-ID: <18d2a666-4ea0-427e-9e50-55464a9d9b53@linaro.org>
Date: Fri, 29 Aug 2025 18:25:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
 <t1qw7c.221yk652cxq5o@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <t1qw7c.221yk652cxq5o@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/29/25 17:44, Manos Pitsidianakis wrote:
> On Thu, 28 Aug 2025 19:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The user-mode '-p' option has been deprecated since 9.0 and
>> doesn't do anything except emit a warning. We are well past
>> our minimum deprecation period, so drop the option.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> docs/about/deprecated.rst       | 10 ----------
>> docs/about/removed-features.rst |  8 ++++++++
>> bsd-user/main.c                 |  8 --------
>> linux-user/main.c               | 12 ------------
>> 4 files changed, 8 insertions(+), 30 deletions(-)
> 
> What about docs/user/main.rst?

Thanks.  I've squashed that removal while applying.


r~

