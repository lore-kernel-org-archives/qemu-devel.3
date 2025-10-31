Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3D9CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmFK-0007pj-TW; Fri, 31 Oct 2025 06:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmEj-0007e3-VA
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:20:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmEg-000424-Ik
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:20:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso967074f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761905993; x=1762510793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnHjcdSn0P+cFf0qWItza4cccJHqkagZQ+H3wvNM5Is=;
 b=iAOcp2ALaIGgT96uLg8NAqMlhP59rWYfAHiNMgnDPJsmdDgafTN9CPPYMjsBZo6VBI
 ClhdQ5MxuWed7Vdrdd6HYU0RoK6d+F1V4kQCHYeDP1zO/ihVy9dCC0mVcnUq9ot74fnZ
 pn4zk7x+vuszqun5Sx1gg77QmbJDuqXv1zsCGEuN2IHoCkDpL1EdA0ogcnwc5I+Yt28Y
 YkTRBscpJvaI9mUKhKIYRQRH9P8RD87KvhsP5v+IAu40O7papDrY6bUTGqrL/ytefI+e
 mKIWGrXdO+wtMmiDwmf53xk9TahS4U4WxMOIwpEjnT4LGpmM36AE/iuJeM+GElOn9CYJ
 uVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761905993; x=1762510793;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnHjcdSn0P+cFf0qWItza4cccJHqkagZQ+H3wvNM5Is=;
 b=enClnTRqag+4Q13DXuIUqvXbCK6W6BMzccWjF5XH1dEqciAg8dVoqUvI4QEUkRhnTC
 NEl4eqMHvXmHd98wezDi+0ycfVffwn0v+Yn/90MbVN+HPZRgq9oPdW2fz75poyIr90qD
 7/7VXyOPblid9SuFLD3UKJyvYirO29q3QGoGRZfbQ7NoXTLPryWa/bhse8LzyeR+NHw7
 hNedAHknakY3ASvy2Z6GR9BY2Q1xFS7lcXeVSER58FlBo5y9Y1Lw1VLQX406RNwiBx51
 qNvc8bkmBvwcOatmNMQdxH5/8/y1IeVWXHGyhzh/YNVFqwzOhIImqQEl7zvX/cZAjRrq
 Gqcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg5WpM5Jq8Do1RVK+h5wCQGy8kVYzfka5vUNoK9O/ueZ3Lyz/zIiHJD2MoLMQYRq2rRfIliOKbl3UG@nongnu.org
X-Gm-Message-State: AOJu0YzZH7ilVp8X8I2+N+MpqbjaXXzrpCnk/bVND5OBUvR0V1nS20rC
 v9pWC2q/FTo/qw5dgWuDeZzGwuAShAMYAc3FHEXF9ET2n1f7WcTDf6vWsHN9BJ49UjoLT5JjlF/
 hrcRAk27E/UdFnkU=
X-Gm-Gg: ASbGncvFz0DJknNRLynPhRtr/64FiR+xK0cNQD2DDjxtqvpqcUX80BJbjeeO5oOdccQ
 fiic633BiGh80qOfGGUJObrp0GbdCV4fpnLNC5qCtxeOe9/B9BzT2S/fgY15c7X8KEuIAKTdtCZ
 9b5jSlsFJbuD/t8UV7iRzBtlmict/Uu1LqfaRRKC99g2TD07J8TuUzy531Wh5nYv266EiAGFt00
 NkABG7FxFBZ/1T6sOnJL9gX1RK2cWDJ5FlQJz4f4vpTo219m1zjngMpt5IWHAHX98IJZc8VCLZ4
 ywfHpvrR5qrKTszbx8NFFYRmx+AYXtlo7FxjZ5NGF1haT60Ms1ut8jx7lJpHh9ecVsKP1+4HYjg
 yhNh+zxmuJIa1d38e2PEYeKDzHlSdOukBMno0WGev7ff2xDG/7z17n7I1KLWtd9+jVl0msqduIP
 iIQnoI1SkRuyuBqVyr24tOKDYFOg2LgAHfpukaVZkQkAncOA6+fAb0rjfnqHC0qIISHg==
X-Google-Smtp-Source: AGHT+IFb/E0N8IYdeiNhiS8IlrZxjIPLj6DjATrQ3bcWq4ASIsrV+lHUZkYSnhoUTZaf3KjSJ3vRzA==
X-Received: by 2002:a05:6000:2382:b0:427:613:7772 with SMTP id
 ffacd0b85a97d-429bd6c1948mr2604978f8f.32.1761905993017; 
 Fri, 31 Oct 2025 03:19:53 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff4f6sm3509973f8f.4.2025.10.31.03.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
Message-ID: <8a312445-c113-40d3-a37b-f0f6fe8463c1@linaro.org>
Date: Fri, 31 Oct 2025 11:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Mark the MIPS replay tests as flaky
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-2-philmd@linaro.org>
 <f30f2246-dec8-43a1-a7bb-cb8fddfdbf2a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f30f2246-dec8-43a1-a7bb-cb8fddfdbf2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 31/10/25 11:00, Richard Henderson wrote:
> On 10/31/25 10:41, Philippe Mathieu-Daudé wrote:
>> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
> 
> If you're going to reference this, you might want to re-open it.

I didn't notice it was closed (now re-opened).

Per commit 1f881ea4a44 ("replay: stop us hanging in rr_wait_io_event"):

     This fixes most of the failures in replay_kernel.py
                ^^^^

