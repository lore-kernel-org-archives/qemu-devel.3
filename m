Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF01CCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOenI-00088N-DG; Sun, 17 May 2026 12:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOenG-00088F-S8
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:56:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOenF-0000nK-B0
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:56:46 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so573642a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037003; x=1779641803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2KmYH1YkcFMYjcfIUYDb41xwnqbkmqtS5300tRlFQs=;
 b=nPbsAWHfXmiqKXm0za18gSx9zbqJRrK8d5tqNbAzA9ly2S+aNMZ+r2dYApNx6/ZpkQ
 tWxwde9rMU8dBjT2TSSnG1MkL6P/ainnDx+1ezqvjvApbg11UkJBt3FVGx18kG2wOX9n
 XU/d8OU117c3U2RbYNSHegfpj5G6RmnTtIcFcYH/n5XV8P4ewwEDhUQACFEgt8BoHtmK
 TqZf1i6/+Aoy8H+7StcEQ374ZKEoAU816gnwRZZ8sdyMJWg5ijhyG99jbgzI6GFa9mYA
 KzQtrCeRdwV4XXLXMDZmnGXDuiIGHPQ0JNqEky6Rkv9TXKuZVN+QFT5C7UU1kiLk1t1w
 rzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037003; x=1779641803;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2KmYH1YkcFMYjcfIUYDb41xwnqbkmqtS5300tRlFQs=;
 b=XP6uCoA0BGlMX3bg70zpdGP+MJXDR695orqfFJi9zTQnIYnDq8MVtBkYRi8HgEwvYg
 sN4OjItX1GhjrhNGm6QK16YjVloP3cKcNVUfuJszdO+p/5hBBG/o6bYK3wTFU8qv2JQK
 U96gzLUpF2WNaEkVijagpJzRAu3T2nOpE+jkl1tYSYn8xhy9wFrgJwyh0lS2U0PkRhK6
 dJAiasuiaBjn8jgUzCC1h2tC81ifmB1medLHUwmiPeLXOm/ZU+pneUfs+HjC2HkE+TA4
 vMCGtNs8uFyal5hJxSqn9HmRZTuq+vl2uW/4kJm2CM3EM+IjhCnWuIlKnyu5RtyPHY+p
 JGvg==
X-Gm-Message-State: AOJu0YxL2uFr0BTF2zzrX7ip8rcV12UUDQtYRsYAfeo1jwsemxpG+gTF
 QAIwuR0JTF5TsajsmjGcWwfXRu6xwGBkaPYPBN5AF8KnYRP6hCVWLySQRm9girhxKvBya7Ob6Dt
 KuBoj
X-Gm-Gg: Acq92OEnPcjMVDJRrHAyzCOM01THho85+Ul8vhlYCpTw+YghtOE+rUbkw+trv9xwJmk
 pPngzikmgsG+3Gjws6AwcMn2J+h8VI1PRz/PfBHviADYmElpxCCkGCn8wM4j+wdd5ofYR/f6byg
 QbB+haaVVZkJUY6ItpKIIkfvgBNa+hWkML2Qvmr+4y1QXsveK7NV64KfONM/8M6vuU06tN6al4B
 BQsQP0tq1EgM6z0B++U+krzc3+YQdiVd4Jvk+TppI5ZSSkiRACY+IenJ7issKBYyXfkeArPcB9f
 oIMSJpC3kz5RiXCKooloP+MvLDORjwDoo68E+Bnd8xDPFiI/TSt2KFIvDmF9kBrDNKuNHT8LrKK
 OxCAb4CloqRyoYRlPQ0YHOG1RCKWQ1S5M7n9T84zqQaY10OGOWp3I2mmmN1g0wNywcmv95HBmbZ
 SIZtF2X7EzLQ+AlTO4wg/w3R/pGW0at+0rOdhA
X-Received: by 2002:a05:6a00:a214:b0:835:3949:3c1f with SMTP id
 d2e1a72fcca58-83f33cf029cmr12240328b3a.24.1779037002953; 
 Sun, 17 May 2026 09:56:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm11424772b3a.39.2026.05.17.09.56.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:56:42 -0700 (PDT)
Message-ID: <45158a53-1ef2-466d-94dc-5e1d45cc2f07@linaro.org>
Date: Sun, 17 May 2026 09:56:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/mss_timer: Remove dead code in timer_write()
To: qemu-devel@nongnu.org
References: <20260512134750.3543639-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512134750.3543639-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 5/12/26 06:47, Peter Maydell wrote:
> In timer_write(), we switch() on the address offset to handle
> registers that need special-casing, with a default case that handles
> both "unsupported (64-bit mode) register" and "can just write value
> to st->regs[]".  However, as Coverity points out, every register is
> covered by the special-casing, so the "write to st->regs[]" code path
> is dead.  (timer_read() has a similar structure but there several
> registers do go through the default code path.)
> 
> Replace the dead code with an assertion.
> 
> CID: 1613905
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/mss-timer.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

