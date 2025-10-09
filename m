Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34DDCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tyt-0000mt-SF; Thu, 09 Oct 2025 12:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tyr-0000ls-B3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:05 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tyh-00076J-M9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:04 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b62ed9c3e79so767277a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029127; x=1760633927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDvd2ky362pMjrUkjWwd3CBiud7WqmgsPMxO97Q3n98=;
 b=lDX7EijdQ1pUz16ruf48YWabyJIjEEK8gHoh/HH87fxYnTkY9lIhq4fNgjApFE92un
 sMeFbYcOBmJ5EqLo6dyOEF0J2XfSGgQM7bP7xf3jyR4u8QU6J6j/Q3zb8ha7UP7wIIGL
 e6bq4g6SSbxhzOYiki/dPBYtuiufleW0xI8i4cZwVQhaPoY64nTh+4S/4PDV0imnJ+65
 653xEOy3LzBUs4J5vjGGDIyDpUUME9Euy1sX9Sp9kRP4AUIwrh91T48Ex/6xS0XBPfEf
 NQJbTXyoBGOh1b1gl7+1bn3c1+lj32k6FtiFCG5JnD8pBjsaV5Rgj5wkoQgAvGMpqT6w
 vJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029127; x=1760633927;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDvd2ky362pMjrUkjWwd3CBiud7WqmgsPMxO97Q3n98=;
 b=jiU5xelTJLbH3PjkAwamZMBOqOTrt/HLIWyOffSHLpxW5LSzox63t8H9KI8kb2fA75
 0vcuCFaFV0hm0omM7vx8HlmUqToa7AgRdvT8r3jUIvjM4YaUmJvYBNaedRb6dceoRzrs
 AfX98GXfw7EJUZhROwDW4W835oITZFrnXp2ZbJ3E7JH5QHqD1/qf1R5pPexwVWSlJztq
 l1saYS3ZhlqKWfXcvY376bp34cQAfzdsZ+8U2VGQnNZaJi1lL1q35N781xjYiFZJbplR
 X/+cqRYvzOZwTCowjGoYe1lJ3kwnLA/tRpG9uVa8+HY3E8nDoa7GVWKTfJk50W67qVFD
 EjuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc1JcCvW8IaBacH0TJ7c+Fvw/YUVOnwYlW7Mebi1M0joZxLm1COqgqw82M7XPtWqr1m2qZRCzC7jtS@nongnu.org
X-Gm-Message-State: AOJu0YwFHqr1EJuYDgzuxEHeFc6tn7NRAx2ClDIZ3/lPDQu1HyCTnxi8
 AO1Q5THpW/ktzHDVGnsKmG3eyNDoUi4eDqWCJLqQeDVD71iDxlU8L5U2jRL0JCfT5R8=
X-Gm-Gg: ASbGnctbLu/TCzXF5q0zOueUg4DofZ93kIHcrgKaIxL16Km5+Wl4Kcy6gUKtbF0DiPB
 TfXUdwAKjArLwKg09JxApdTDZ7a+Zn4g6fDCY0s8GRxGhTZFlLY5hu2cwuOoehB//ZpM64DazMA
 AUT3q0WqwHcNmOPrX5YhfxL1xwIJdCaEOI1xlOOLYT1qFL6rDOKEsxTibNz8RPj5vHaHKiCA3cW
 ORlOhEtjvMU8lVhlooK/ng67j0n0grmzrARs51FMxlxeLPg94AQAICKKL9IE01m0YZfdfl6Jpre
 w1rykc2F56TSdm1ywMSzQTdUAhcnYewZwrHfRh6LnouVdfKWaC0SSdphzL56BGe2WWcL4NLpTPt
 N7vyKKgKFN2ShxCnz2aiG/oF1tG2kdpoHGZ0DujUOxswjJjmZQFMg41xZKeGfPLkV
X-Google-Smtp-Source: AGHT+IHWM4I7J46IFta0AskL3BljOeliBnV4z/PXrYt8uWTD5efnnw8WJGUOaOv8DYkAgZYbVS3AIw==
X-Received: by 2002:a17:903:1a06:b0:283:c950:a783 with SMTP id
 d9443c01a7336-2902741e42amr109288385ad.56.1760029126948; 
 Thu, 09 Oct 2025 09:58:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f36413sm33416265ad.99.2025.10.09.09.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:58:46 -0700 (PDT)
Message-ID: <3a2785d3-f820-443e-be3b-f25f7b190d72@linaro.org>
Date: Thu, 9 Oct 2025 09:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/hppa: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it in a commits.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/openrisc); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

