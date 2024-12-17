Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F9EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 18:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNc7u-0003xf-Ip; Tue, 17 Dec 2024 13:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNc7Z-0003wn-BE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:16:40 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNc7W-00087b-VN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:16:36 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffa49f623cso68752951fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734459383; x=1735064183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CakArC05xKe7lXJaPcX12chg18piszPz/0v88uxmHr8=;
 b=ue8cJkVAEYEzihgXd4mNsHkpzWRRY1VoSL1Uxk8HK/xOVai1yncvPGccGEnBjwBWjF
 s2al/Pe6WiqOovdQru6FokXBjETHa8WDHGI6dhc+dbe4kJ+md+aND4iMIE3Lfyri8EKk
 z8XG6cINdHT98lnnmGVL3mhCxYq1gBJrUqeGW+Xvm9KGL+QtSihT2A8AnblCB5W7AU5+
 RGuo/GBzlXjiOVazl75FdV8T28lv6vwXCOcOAHfLrChBBOTe/AdpjoSGKk2AqVtbJ/AW
 46Ay24dFfG18gtDLvQ96Th9W/cWo3+QS+fdnOALZzTqD2qP04+HBKBQ3ZvngrLjqmdUE
 4PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734459383; x=1735064183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CakArC05xKe7lXJaPcX12chg18piszPz/0v88uxmHr8=;
 b=hoIAD0HY7amqqVZ66WtNXrJ0xlU+LMFJswgP9szB6TGZODdYtBe8WWsP/5mwyc2RKD
 7KeWkXGm6dtE5B/dHW5mYn1HbrXx+au4bmC5JeiV6J2Uh+pnL3HV3+GjkdrjmkKtktK4
 SycrbNGXApuBML+a8q5VbUxcoK8NR9PgOxTwCtRoS8zTe/dw74+Poi2OzaRlIxdKkcny
 gb2FPryXodFAtdwblSzkznqGVCpdQFr05US8VRqzt/ClV8U2aczPdA0TmqK/PPRvHybf
 jxRdDz1nnxFSOQEZu0cf5DAt/y0IqyBK7vCBNl3vz/9Ztjqj7nHDnkazb7SQkJC0k/tl
 T2cQ==
X-Gm-Message-State: AOJu0Yx8zPTxAIJBnOI0MSC+mB/hFPR78VVBJ+rqDuKsEKUg8bJ/1Dgg
 7sFN3ZrDDIOM4F9/gmomOlF4NF5qlKa3eaXgAIM6eVPp36me0O64OF3X8ymiFEDaOFwlc5TlKGn
 MWblGPDNY
X-Gm-Gg: ASbGncvhrzd5kaFs8QliGPKJhwA35oeTcCKF2QWhRJpM0zk70IsIWH4ErswkA7zziZE
 43ymj4poz9dB2xQrVr18F/eVcgjARWqrur5dyOGcOd5oCve6XgzuJ4txF1XEdKINa8sfyBFMikC
 b/f2Eo27XKHmvG/QSQ83JSn6qa3CGSZARom65XkHd/NBeTI9qWf129iZzm/KTcmqU/ZNl088rOS
 ucPqeMssOhfI4t4W05inFj8A80VHnB61q3QkwSMyZOplwf71KS9OvF3f1YLg6eKjgsQbnRzoUU=
X-Google-Smtp-Source: AGHT+IETb1tl+O+Qn5lmJAWzu+ZBuVAt3jwAp0N/dZaCyufmMVzqXRA01da+4025OhzP4PwKyLxIuA==
X-Received: by 2002:a05:651c:d0:b0:300:1f12:bbc9 with SMTP id
 38308e7fff4ca-3044db581c6mr288301fa.34.1734459383183; 
 Tue, 17 Dec 2024 10:16:23 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-303441a41d1sm13377601fa.100.2024.12.17.10.16.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 10:16:22 -0800 (PST)
Message-ID: <0f9d4f78-88dc-46da-b987-2929758b5d6f@linaro.org>
Date: Tue, 17 Dec 2024 12:16:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Move minor arithmetic helpers out of helper.c
To: qemu-devel@nongnu.org
References: <20241217174442.3914177-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217174442.3914177-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

On 12/17/24 11:44, Peter Maydell wrote:
> helper.c includes some small TCG helper functions used for mostly
> arithmetic instructions.  These are TCG only and there's no need for
> them to be in the large and unwieldy helper.c.  Move them out to
> their own source file in the tcg/ subdirectory, together with the
> op_addsub.h multiply-included template header that they use.
> 
> (Ironically, this means that helper.c no longer contains
> any TCG helper function definitions at all.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> One last tiny cleanup for the end of the year...this is a pure
> code movement, with no changes.

Because of pure code movement,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ideally op_addsub.h would become tcg/op_addsub.h.inc too.

> +/*
> + * Note that signed overflow is undefined in C.  The following routines are
> + * careful to use unsigned types where modulo arithmetic is required.
> + * Failure to do so _will_ break on newer gcc.
> + */

The comment is out-of-date vs -fwrapv, which we use.

There are a bunch of other saturation related macros/functions hanging about.  We should 
probably unify them.


r~

