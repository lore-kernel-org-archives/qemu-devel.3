Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870B0C36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUus-0002d3-3D; Tue, 01 Apr 2025 02:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUuo-0002bX-8e
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:16:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUum-0000XA-LC
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:16:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so34533585e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743488158; x=1744092958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0kmTwm1IoCVXB16o5jPM20YKT/aWdvA+NNWPH1MXrXg=;
 b=QygeC7LgRbz/DmcqkFuEjy5Wzs6eGTr7rdhMY4TOOoylToNV0Kku8z9OAS2Apzmr9p
 ri9QF+5bbv9/LR9JOsCNPkplJiatiTQbiC64MVQMxBBNhiLqZGm8sXUs0tWHEDyzNHlM
 jzFv3zfMt76WDpwqJHo8nGegyLY2FU0HJcLaKMYN6atp4KDr90mChcSfi7ihMcCXgn7u
 UaP78F4x3oeLFD2DImgVk6tNFDt+6EiFI8CRHdS7Ywt8Yl+JBX8hezsCjufN1eTygpwx
 uO1xPIWxpc36eZOQtW2lrvvbtAO49/VjMSlfhk1uyWhcUDyVxwBqtkGSKTEl/tyI1f8k
 fFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743488158; x=1744092958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0kmTwm1IoCVXB16o5jPM20YKT/aWdvA+NNWPH1MXrXg=;
 b=Q8hiTnGXyBBPz71SzK/aYsTAnRYOtNRcGb5+RqamK5U2ILnPoMult8TZ5idvDS8yeE
 7kpHUICBdYxfY15QY9I3sfZ81Fjs6Z/VP8axRvxDFADmmci/1FxDN0ky52aL3m3KmzOf
 1rrYwaf/7KS2eydnvAkanTll2h/5gOUBb1vHwesy1rLOezyfJga6WqEDigrBsnNCpRAa
 mKlvOl+G69dbhxols9+7yyt6fkF92KHJ8dGsIxnS1J21yrKTrz1To94VqkgcUTkHjPSo
 j9oDxei6JzH3sJFSv0SJTPl7qFe6VSm72we42p+qjLuZelQN5vRaeKCrmuHuR1u7P9h2
 8TFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqTchIfgOWjfoynaHq3hyrrnKQ8Fb/5+c9XEEfVxvYojJ6Ge1SaQQqk5W11dg9MpX8h8N9P3ZSFVlC@nongnu.org
X-Gm-Message-State: AOJu0YzBQi2NJbWhqiZ/E0zpt58Cu3Y1xEf+3ggS1muRSo6U9U0yYSIq
 p5bXR0xPvOnn3ZMXmdr0Zrlstf65JS49rMy9zFodPwI1z/5sWwM6s9AAOJc/MK0=
X-Gm-Gg: ASbGncv/XgRrJ9QNPg7FvJ6ztZGwWyHoUniQ/5w1RF7ALo/nR+RcbRwevtNh9OjQ+5l
 T51uFg7s9dLbTOMnzpxDl2pOy7B8Y9WpZSuPrA1Gzjh7GuRpVQVQiJf0kRKUttxKWhTQlxAWOt8
 x64D5dK1tbWrby4hQ8hn9CHi/I8i/wXxfqrhkBa8pCtvXRQMXxjBsPxb34xB6SGdY/919w1gY4r
 mrUQ5GWUER7q2rDwA4nd+GKczHlARCj9fUog1QH+/Kj1Rk+g3P1R1BKGjwLSvEvRi5WzernLCg+
 EcfNH6x8Fd270lyHyL1pL1NGFg/rFWINMUFIOpEZ4VmMwzAScDgamNTZe0/e6xM58oAAya5rqYA
 hWM84es8tvFpA
X-Google-Smtp-Source: AGHT+IF8WYzAHUjtr+b3pC+UIJsJm6/kMHtmCkW7dJYMgdwpi3h2xsmy5yujddu6r5OhUWONaOI76A==
X-Received: by 2002:a7b:cc05:0:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43d91045659mr113699615e9.5.1743488158123; 
 Mon, 31 Mar 2025 23:15:58 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16d35sm10029575e9.0.2025.03.31.23.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 23:15:57 -0700 (PDT)
Message-ID: <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
Date: Tue, 1 Apr 2025 08:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Pierrick,

On 1/4/25 01:42, Pierrick Bouvier wrote:
> Nothing prevent plugins to be enabled on this platform for user
> binaries, only the option in the driver is missing.

Per commit 903e870f245 ("plugins/api: split out binary
path/start/end/entry code") this is deliberate:

     The BSD user-mode command line is still missing -plugin.
     This can be enabled once we have reliable check-tcg tests
     working for the BSDs.

Should we enable this without test harnessing?

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   bsd-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Ideally we'd have helpers for common user code in common-user/...

Anyway, since this patch does what it says:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


