Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBC8CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyzF-0007sA-Je; Mon, 20 Oct 2025 19:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyzD-0007rK-NT
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:08:19 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyzB-0006Mp-UN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:08:19 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b632a6b9effso3208377a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001696; x=1761606496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0OnY+G6SucFiSC1Ha0XjhMDXzI0B8LGekH0SlSl6EE=;
 b=egnlJWitrNkqdclAASJnd9DFCOdhH26FnjyY+bKZioPw0D8YsxgU0fML9fBHVdqlDo
 kZ7DM7VpszZVq7ayIDqljAG6/QzYjq0OY79bbuHY7N1JrGdpnL/e5TPp5p+h7RdwCqi2
 ifn1cFy07ezc47Sxf2vR92oRuHHflFt5rbdcKC7Kyk6DLtvC6RcTTlmSA1XzckJVslry
 AnbP65aYVnG79lS9D6PJlTui1+oaYq7s5sCGinDsAnEgNTePyZ7qZ4pJk2uz5XrAWjAl
 wUcyhjiH15xLXB8ruMCq82Nxx3qEzwARtS5RrIZTLRQSaBE/ncc8i881Uy1cBaTJUt83
 7q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001696; x=1761606496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0OnY+G6SucFiSC1Ha0XjhMDXzI0B8LGekH0SlSl6EE=;
 b=hn+WCydZktLSLTh0f0hmfD3D3sieDJ/sNnqa1Bccs4EQGS7GZ2pTrJOcScyuGTyYHg
 j8fjIfEtLGneAJSTffKPjTTymnV1sTrwZjaGw693EsF5FFKP2zQ5lS31SXdbpxd62P3M
 nLpSXmZ0ge5HG6lmyIcy9ESsxuT4/7VL+uetOhhE06lac6ewcNT/+FeDg8YYrL+niZpn
 JYkJulL6KA+FPoBFuShgn14SJ8OKGitQpCLBFkbA33VoN/TguzSS+zMF6niecqoBcI/T
 b9i39oRTh6XHHQ/g121BDOlaRnR/FG3gFyvd+vLpKnMkGi6G+EW5xA+MzsWO8SY9whTi
 TwGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdzS8AV7idddx4Q7QzTMZD+3jePUlm1WkzScl0wV5dccb4l6JuwTumL3eaISfnZo9SpOhaqk+xwLRP@nongnu.org
X-Gm-Message-State: AOJu0Yxn+qiFzuc/zd3HgBUr/nkiCfJot/Iyvjv7FB/GeSBRyujjzsmx
 pSE7K63xDF3nSAYkqFw2e80sTIkeYzizcpC73oKt87g/khfnXW6oIoYuvoYUW5lO79w=
X-Gm-Gg: ASbGncvC17s5za17dEqs/C5PSpzLyBOxDzAMk3NxQQCq2o0a3QjzrP562XRejq+kaK/
 VTThPROyxNWRSIPGk/uSdONxQ63ZIq+rEVE+2t04vy7IDmTxZ7oxADKK5ugtVnciWXDaTOCh9ka
 CdzaAT/p+2nP2AF2JQdYUhw1wgPM9K9eJXPDBWb1SMyFTA2du7uULHTBpT16LWXJSBiEBQcZuYA
 qrrUcZhnaLeKJUdcYeAAJ7EH0jsiVFZlcOnH4jeiV0AKeXOD0LmJ2Vyu58P7R3zyH1X6tSTNwsq
 ecPFhhaNp2Zt4g8v+DuKP+0+wBtRwX9i2v1XurC8F5BZgtViN6zzl+z6n7cH5UhyGX2p3VXgYi6
 KSkueh8jGCyVhjz1EOenmM/spTrh76ZlyXUI39mF7upXWjs0CsVkS/4R7h+mJMDlaiSvwQo4qeG
 FE7QSi057VhDebBQ==
X-Google-Smtp-Source: AGHT+IETOiBgONkNoHieLsjP1kdtVotTW1riJMn+J8nKKFOA48haiRhuK2dmg5TahHfncehxcwpCxQ==
X-Received: by 2002:a17:902:d506:b0:290:c5c8:9412 with SMTP id
 d9443c01a7336-290c9cf37demr201646965ad.5.1761001695970; 
 Mon, 20 Oct 2025 16:08:15 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fddfesm90404695ad.88.2025.10.20.16.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:08:15 -0700 (PDT)
Message-ID: <648e387f-808f-40c7-8ffe-4f519b8233ae@linaro.org>
Date: Mon, 20 Oct 2025 16:08:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/30] qemu/target_info: Add target_arm() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025-10-20 15:14, Philippe Mathieu-Daudé wrote:
> Add a helper to distinct whether the binary is targetting
> ARM (32-bit only) or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


