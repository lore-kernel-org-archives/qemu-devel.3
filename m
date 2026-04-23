Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF68F9937C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsS9-0004En-SB; Thu, 23 Apr 2026 07:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsS5-0004Dg-40
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:42:37 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsS2-0004G0-O7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:42:35 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c7961d7bc09so2468306a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944553; x=1777549353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgJt+GYeQJmyLhpLEvINdIx/oi2SxTXXacSjZwEWqQk=;
 b=IG1JURErNHigqTinWwJsM8a5ZCNQwjeHvcT/knvagTUO+Neu5vL+Ak1diu6z8mOsZy
 EKSg5ea1BfUs0x4dbYDzJo8MX1KMrFpXbsPSVJbH9ovoJW2AgB+WXbnnm/XmV29SkBRw
 0sjuHZvsDieyPkDdsHIHSCxGNmm5oE5oWE9ap4f1f2TXBDtTzqyQSIaZS1YYv38IERy1
 tlxTVgPwH91EjTlEP6Z8x6M+Y9Ed/qq8ynf5XqvkdhaQU0r+ojosS2jLRiJhO0ZAHjYt
 qYnW0Z6TPZIPYLQhWKvX5hi9cc/iomMTO7y60ZzasfK6wXzLR7+i0YPCY1YLUifqohSD
 AplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944553; x=1777549353;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgJt+GYeQJmyLhpLEvINdIx/oi2SxTXXacSjZwEWqQk=;
 b=O4BNELgaHbik0y9z5yjNfehB7HNcezM5LqzN8h3ezj6N82d2TBx6k/7Umu3Mg7UmzD
 ab+xIyE6Bfodkoehx+ASCZkHew+uKnaL1GCJw3lanOXBM3htU92dmmD+vX+iQBxSQ7sp
 xAb8P79f5s2kyU5OF0hS9KkfPPs5jWLrH3IBVJJTW52xWzFt7ejsk2bm3kV8Xrn738xo
 xxBDUcYUBJ0DaoRDk07poijsgkkhMCIgxzhMdbMTsTUbGews/AtMJVKxIHtnnox1ZuRf
 vY6EzVe6eotcsTZK2bk+IOfSj2OsNWe3WZV9rzyGgILpeOTaXsZgksjnLmMEUkT+RslG
 e/fA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91a7hopiKLI4p79Qs+raHu+Q0BHEkI3Lh8RZGzzxJJZuoFgH47I7kBT/jsRxxmkS+7QKlNnb2Y+4rB@nongnu.org
X-Gm-Message-State: AOJu0YypteRSg4lQ0JMImEFgTDQ2C3hq+p49VauMQ+/PzCWyH7ov69Sw
 D2lCFtZxqARqdLKKW5zCuOaCCRuIqHhU7EsKGncaMNJ+Bj0tthGAMOfUqiTSBodtHWc=
X-Gm-Gg: AeBDiesP8rxgGffCJgUagpD4eseKN9rJQtRCgWUD38DMsBfSwXuQsD1TsWM3LljvfgG
 +5ZaC1asbupcQk5Hi/n8nnFHX9WFWZOhIznsLpMtiDGXv7RqYwYbdirTTHZ+GBUUx5ZJOoVD4IY
 oTd/BWTl+8CVqv+yQz7gnM4KbxXtGn1DW/9MOowwlq5tVdfrUuLw1puD0e8FbBVrSONyM2Efh73
 PB4cLNK+MEBzPVFL9VkCec1+i/ak1dZUVmsOyX5OJI9/rGs7pDSFIk3VzRHhaT94zk28WG07xGa
 BjOI/bN0TVhDOB6XyIQuyV6yVNVg7ChLyPXK9obexRezb3EmQ8x4VCTbOjGoVqX1L9vIDfV7GML
 M8z4Y9iBHn05oJhlN6TWLL/Uc+FOomdTIF9oielmuGEUaRqSLFQa6RkRiz/9oX7+dveDnfgyqIu
 PRplqXASLxiPTY7yyU8Zr8ZTnXUexzu71SorigQcsDyKZN5dJpcg==
X-Received: by 2002:a05:6a20:a12b:b0:3a2:dafd:3c02 with SMTP id
 adf61e73a8af0-3a2dafd4cd8mr18768175637.19.1776944553034; 
 Thu, 23 Apr 2026 04:42:33 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797701b1a3sm15181239a12.19.2026.04.23.04.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:42:32 -0700 (PDT)
Message-ID: <be16cec9-6a28-41bc-ac76-8329bea784b6@linaro.org>
Date: Thu, 23 Apr 2026 21:42:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/microblaze: Fix endianness used to disassemble
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-stable@nongnu.org
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> MicroBlaze CPU model has a "little-endian" property, pointing to
> the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
> Explicit CPU endianness") took care of having all MicroBlaze
> boards with an explicit default endianness (similarly with
> commit 91fc6d8101d for linux-user binaries), so later commit
> 415aae543ed ("target/microblaze: Consider endianness while
> translating code") could infer the endianness at runtime from
> the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
> definition. Doing so, we forgot to propagate that runtime change
> to the disassemble_info structure. Do it now to display the
> opcodes in correct endianness order.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

