Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D397C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 07:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM04E-0005Dp-BL; Mon, 02 Jun 2025 03:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM04C-0005Da-Sr
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 03:58:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM04B-00078H-1t
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 03:58:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cf214200so36198155e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748851119; x=1749455919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t9xV/UDmbUueBvjEDKh7zkVtHcXNiAiWaFxbgrpWCc0=;
 b=v00NKxBl7W6bt1WbeDOwG9F4aSZ1rup+UJ/aEeH/AOgERQwqkjPDM0gjXtSOtQgay9
 1ZVjTTOkDfsnJtRfkZSYiH0gv/JhMugmIoaOnt51cj6iV26LjDJiiftP5sjNZ1uwX7ei
 TOcUzz2Hsi9vkv/014P7fchiDE6hobcXq9mddncILqjqGUOAe8t7IPdWjRfpFiCfx6nQ
 aCkZzjBQQmhpaA2I9nJMFtARikOZMQoRDRQ8GWTSkuLiHLLOX6amLondTFawsH/f5s3I
 gu9a/IqyxQ9dpjYX5DXGoJ6j88QouuqW4ADCmqwgnP7b7Q30RPlhgVv49Pj08pYNGUqs
 Db4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748851119; x=1749455919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t9xV/UDmbUueBvjEDKh7zkVtHcXNiAiWaFxbgrpWCc0=;
 b=Kn+If1MopV3g6xdn9nzRYKA+TskW12XowoUBX4DpkXV2VPMQ1va8fLdzzOQp2rXoN6
 f05Uq6jF0XhDI1DP9qKn6hZc8R5/Y4iGNO5feKK+idIcaJqsEshuNV+kjX/yS4r0VaiI
 G24cuqGz0f47iQKrOct1T6WOEkq0lHCIICaNcjMfWWY/3kq5QUnrJinei30kMPoC0K1X
 PE9XurGAk3IFVICeuxQUYBRUnd1XwFRHC4ioMWO7dk9wKeRZomTomUa6oyb+313Rtyy0
 2B5L/T/VhZgBRYD/U8s4CNC+zsB3qvCMqZuozhFZm9FpgjTK6JrP++ZaBobFHZUlY9ef
 Rj1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+17Prr01wjaMx9eALurkrJ9uou6WX8OouEH3bT4VaIsICAi2GKE3XuYYtcLEZeDjkYvGmlef/Y5C@nongnu.org
X-Gm-Message-State: AOJu0YwUc15Jcctb9f1J3xnu86lVdy0VfpsNva/n4tUyId4Yba9tmXQt
 yTvuFra+JMz54vaB5LaoOm1rN0orWiOOUiqnWNW36bLwsq6JqB5PzGqzsW78OScEOdY=
X-Gm-Gg: ASbGncs70sdlR/HdVO43nMKCRPbri/jLZbLDCpJfE0NceHynjizAmaupuUn4uGUOj/T
 PbPlIMH26UH9iAwYg4uNBcETkoifW5D5RjkDgG/WwU+whb5KALbIesNua/9M01hNpBxFdv+brgQ
 iiQPOtTBEqn0EXf8JiHs+y8FAhfEKC/w+BrK3aIzUbYLOTvEZiUvzsJCxdnhG1xG7qsxyAAxiq2
 to8BM+j4c716aR3uXiHOuGF144rxXbmLnBC8j7w/Bn/rctqO8uh/T/xn5CLZVw0lMN3aCLT25Zs
 A0oimT8Dwrp4xysLO1OoOHtnKfGNO3yV0bsLZPioQVSGHStE7iycuSSCGyVlY6FjJigKsFpgCo7
 u8Cedl3eOjCL9qU3CSTPjHm5mcMJrGw==
X-Google-Smtp-Source: AGHT+IGn0Bue7/Lgoy3qOu1HhqptEonwu7gfE3fStjEocK/urTgr7wKJjpgsXN7jby8mpoCM/2RYpg==
X-Received: by 2002:a05:600c:5250:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-450d885e403mr80924715e9.19.1748851118572; 
 Mon, 02 Jun 2025 00:58:38 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006613sm114924805e9.28.2025.06.02.00.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 00:58:38 -0700 (PDT)
Message-ID: <19c90ca9-59d6-457a-9c1c-a256caf3e84e@linaro.org>
Date: Mon, 2 Jun 2025 09:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Akihiko Odaki's affiliation
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, devel@daynix.com
References: <20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 31/5/25 09:00, Akihiko Odaki wrote:
> My contract with Daynix Computing Ltd. will expire by the end of May,
> 2025. As I may contribute to QEMU for my research, use my email address
> at the lab.
> 
> As I'm the only maintainer of igb and no longer financially supported to
> maintain it, change its status to Odd Fixes until someone steps up.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> My email address at Daynix will remain active at least for the next
> month.
> 
> I added the submitter of the patches I recently reviewed to Cc. Please
> Cc my new email address for future reviews.
> 
> I have a number of patches that are not pulled yet. Colleagues at Daynix
> will take over the patches which are interests of the company. I will
> keep working on some patches that are my personal interests.
> 
> In particular, I intend to continue my work for Mac, Arm, graphics, and
> other trivial/generic improvements of QEMU.

Thanks for this :)

> I will repost the patches I
> intend to continue upsreaming but are unlikely to be pulled soon with my
> new email address by the end of the next month.
> 
> It was a great experience to contribute to QEMU as part of my job at
> Daynix. I hope others did/will find my contributions useful (and,
> ideally, not troubling).
> 
> Please feeel free to ask if you have any question. And just in case: I
> intend to focus on my research and am not interested in a job
> opportunity for now.
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250531-rsg-v1-1-2417b4fe8299@rsg.ci.i.u-tokyo.ac.jp
> ---
>   MAINTAINERS | 16 ++++++++--------
>   .mailmap    |  3 ++-
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


