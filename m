Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045E4FCA191
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzjOD-0003Q5-5i; Mon, 09 Mar 2026 18:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzjOA-0003Pw-LP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:47:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzjO8-00035V-Lu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:47:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so9466765f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773096467; x=1773701267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aud/vsM8qXLxgAKvFp0agbpqFv9C+zDE18mTApxpkgY=;
 b=aLbbFWoZTwN+6GRPni3Qo9R0UABvgRqQB3u2cW5Ejvb1Pb0MMPErPX9ontC2aGdkeq
 YZ9UYtHVp56VBkXmV3w4f7LMo2udGCUHfm/JjV4Z2VHHDFqUGcJsbAYPAzofzKKJg1gY
 fNuxjYzKc1fzSeJq03KT2DLH6AEdMqdAqC70XaVfZnpDtlJG6UQ/SPLED10Se9HzIfYg
 1POmngjxXw7sa3OUBWRwZpoX091zjuVDSmU1SODK71KERIVp+KP5UyJBCr/xQogMIii7
 dgpfwyqG4Kc8YPiyww+M1EnIm2WSWWawdxi2+cxtk/LntmZY1DPQJzIlTSpe6p/o0NsQ
 OkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773096467; x=1773701267;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aud/vsM8qXLxgAKvFp0agbpqFv9C+zDE18mTApxpkgY=;
 b=J6IgvgvZ7rOEFflfUXjQS7og8VpMi8cnyXg+zecg4XpZsklPi/n7QyiMBdIzwCVDP1
 3MPeGwlkXI+YEKHqWEqeCl8H0PD+qU/8DShheTD619OjbDUsWCoLOOwdeqJiJpsrcbru
 Z5z09QXpFnkAtxaib78nIN/RtJrxZBxiNA/kx/ukywATXlEoumDJSOElH6HfYCgEq4NT
 wog1y9HXiltJUro+VFQextl7HdLy28mbOE5IO6QomdjwC1BIaIV0fal+eyCE6Xp68g+/
 h8Yc/loe4iyibTJ2+qvXTts3qzmkV/I1MQoLO49euRdDuvIo8KhAMC6zznT/rwZnbbp8
 OhHQ==
X-Gm-Message-State: AOJu0Yxj7tRh023eKhMn87K3TWPrqXaSnqiJp8vDNztJTS1/lMpk6BjF
 X0n3gi759wbwua4eO1NOrDRUjmoGM0N9EIKryYnXg2w+sIckL0rjFBlOpRHQ052oGUsRrEN/MIa
 FJbihuh4=
X-Gm-Gg: ATEYQzxKJnv6YZEgspS4UmWQk2KUX4YBqYRCVJ8SlkQumyjTmx5ILQCh1GHbyx5g0eL
 xPDKV+YT3WDq2R/xqc+94LbcPk+bBauAQGF5bjbi5vBXgKzb4q228JFKrb1/Gc760aWaRSBr9Wb
 5SgC870MzRrmja9kFld+N8DThYs60SnEu8fUe0smAo3PBRftqlbV3ExuaYkyjgsvtgmHo8mZMIx
 q1SUuYYgNptvD3VGnnFgUpS1sImoLZbT5kFYDIqLTs5wW75l8Ww2EeMrD1uRjF0vnmwGbqIryAx
 6qLFybvmhi81j8LxQoLdlMDHaW5Zi50Ghv675ONuyp7otp2hIwoi9PDSy147n/n0/vha1lJOjrH
 fY8kF4FHuvc9W4b+YrhOWH6aTuUWynYb0U/Do0Se3MF7hDl99YgONcRmVp5A0ajYjPvZBJRefH/
 55NCxTfD6jW8GyAMdLX5/zvzZ3JY8zZYyeWjc6zoJdpDt76G+9Z9X48eyuDfKxwRfrzasl9CPEt
 C4S
X-Received: by 2002:a05:6000:381:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-439da64f629mr23684736f8f.3.1773096466573; 
 Mon, 09 Mar 2026 15:47:46 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm30844759f8f.15.2026.03.09.15.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 15:47:45 -0700 (PDT)
Message-ID: <bca933e0-83da-4518-a7f6-af3e611293c3@linaro.org>
Date: Mon, 9 Mar 2026 23:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260205212914.10382-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205212914.10382-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/2/26 22:29, Philippe Mathieu-Daudé wrote:
> The HPPA target is a 64-bit one, so tcg_global_mem_new()
> expands to tcg_global_mem_new_i64(). Use the latter which
> is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Patch queued.

