Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B05CCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdxv-0005s3-Nc; Sun, 17 May 2026 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdxm-0005rm-9r
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:03:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdxk-00085r-Rf
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:03:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so15027075e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779033811; x=1779638611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ESsDdhp0r23mjSE71uYokpqdXDNuyUJB7VNI5CyZn4=;
 b=MOdaz9SU8Nw5Gc27zRbKow4Hq9hs9NSW9J/AR4ek5UYLwmJDEY5QBVdMV1ZKP8q84i
 3K7kxJZlWk/kGbZ/HZg3/XBpMJ6JQwi8ewYyeGGH0mCS7+6ZlEcozJtnBvE6EA+zD8Sk
 g+/32CrXHcpWbau4qee0TzZaABeTDw8GK3/Cgl4PnLbdiYImmg5qZlArj+7MpOC4TV7/
 M3mFjRlG5mmRqyYzTY2vJt5vfpiYvZZEc7IfqpDMV5KQy423kw6JbPVnMIF7KIxeHLHz
 JWe5eVRWa3bdD5TF7qWNcXagvKKeiIupb5h/bSSWInAEdBxtKofB/6CxHsNBT2OdhDfh
 7Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779033811; x=1779638611;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ESsDdhp0r23mjSE71uYokpqdXDNuyUJB7VNI5CyZn4=;
 b=QJCHOd1O2/sFYQ32+H9+vmZRCFAki12SqxsUzy8ZoeooouwD4b7bbJR7xRmFdC9A0a
 P0UIg7fZoQgTvnCQIyGiZl5PI0uIDc6XrTmrGLxLZtdZdlTZd04MGQu5xpfcda5UeWII
 ZerUFQmVsDeVYH/iI3ia/cFMKjCyWqKyM0TBmECPHP7PLxGr/Qj36q8A0q2ZtGuBNWrd
 vPkbgBB247zn7RfC3KaeAcqiC6UDJSt33A8o+nw9CHqUBLj9ZJodTxT3Be1X9NnS2raq
 ctYQwmx4L1z7pA3ExgNg1BYbr4KNNJcYPTNP1cEXxYTXdkkHE/H53JsJgN0RQNFMp/Ce
 99zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4B4ejVNxghYMghkIdX9jhZSIo+6g8L2hEXSP1OlVbBrJnun6Ayyhjhlo6IvYi5UocuMokb4MaBLAT@nongnu.org
X-Gm-Message-State: AOJu0Yzs23rnn5itRIqX6WApSY0xiV1l8Esbxa2FoldiGI0oU0l7wFzq
 UnVIdCVqdZEUjbI8Gp5CRaNqD62g1RCL53tsnmR1ppZe3ywSykYfLgQnTgCPu+Zg4XM=
X-Gm-Gg: Acq92OHQJLvyDXOSWQLBOk+ggvQs9+3cKRfnghboZhsJsV0G1k9PM0BUAZmwueq9zoL
 TwHYiZXqUP6kqD2m2ojxB10aPTRaIt2cM/Sfq7lio68eyThLM2n7xk5bPScpOGADMsxtjlpIoWR
 uk0qVOH8yJBFnspcgLSjQUuRyPDyWgiZ9GZK4TLmDVrtj+IGwCycFijcwxVZaTAa33or2qMMZl9
 xBEb9uCWnMNU4Lm+D8GJmKt7ZmhS2QH6Wgd7NtlJilWkyx89MdX5Oj+EsXdc/UPDXn3Dd5xne7c
 MuFOOMx4GUXy+tDF92MiC38clTfq76RjfXTiUsNXGvH620BAWa7wK3MoTyGaa7W0Qw0sMV//hwp
 UjvzfDaD3Ja9j4dS5KGHLT2cpm0ZjMHLUOWylPBJY+8SW0sMPiBT5bQKw/kmAFrPUB58vfZDo0Q
 Kw/TRbRPjt1SDWjxzNBmOOvGcSrebX4UT4nucNg0LwDY/Ae4bxZh5AitmP2tBcFtsWiw==
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:2a24 with SMTP id
 5b1f17b1804b1-48fe66204e8mr158894755e9.31.1779033810927; 
 Sun, 17 May 2026 09:03:30 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c788sm187536795e9.12.2026.05.17.09.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:03:30 -0700 (PDT)
Message-ID: <bddc7c38-a5dd-405a-a7f4-46cd64816241@linaro.org>
Date: Sun, 17 May 2026 18:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517002550.321291-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/5/26 02:25, Richard Henderson wrote:
> We will not expose parts_round_to_int_normal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

