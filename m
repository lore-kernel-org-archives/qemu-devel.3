Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DD5C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYvD-00062t-Cz; Sun, 04 Jan 2026 19:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYug-0005kP-K6
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:57:41 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYuf-0002gj-2h
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:57:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso21031474b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574655; x=1768179455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUZobb6ZfXvwucK4ncW8QXWJSoL79U4doMF8cAQv0A0=;
 b=OL7GTgUheSXrHtONlY+e0ItApTabfVAl0lGwr/UXu3s8Vgbwo9rNunzG8Y2KNG9jAO
 1ISYz0HS0ShAv1js9AkAVL2dDHvrGBNDQyeVhE5Xmhv4bPzfQ9BlyC1E5DfHv2mMDuVg
 tiPEy1BIgB9uCOTfeyMtEVUMcXu/e3834gFqwpqviPjHTx5/vusUkUii5wuLbSotFA6R
 uEtHD7JX2sfseIEDzTxNDstlbeqHgm6wuXLNuCMHxt7snkcZUgfB4Hby26BLjgftzbdG
 pc3jH8zPgblgkIjwSuKj9vjf3Uf9Q2ow56ovGPdF1vYYAacRY0bjukqoBC0lpsVlGF70
 oX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574655; x=1768179455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUZobb6ZfXvwucK4ncW8QXWJSoL79U4doMF8cAQv0A0=;
 b=ek8vSoyL3rxr4liM3ospz0pvKa0UXNEKdIeW9S7RBuOhVKprFoEf53iVJylFnb15v3
 +3c3vJ4f21rRz+8AC93rZZ9IwmXqDvUeCbQejxhcL8V/VJlRgX2ROcQSaQZDDTcy50TX
 NG2P5PLTSkFBxmeUDbIcD6Q1qtaiKr2r5xIRMT5er6jexYbKK9H+QUdAeZuoLQy15SCu
 TNWi1V2O4F+Y+/t+R3nFpZzm+cPwpiYHbVeB82OXv2ZcC6mpdrjDFPCpUZWFeL25Ru0A
 ENPErWPxyA08yqzk7xLhgkCPqfUBYjdEuDgyf02yE7Oqpgnp7cP5vUR4RR29t/f7tIfB
 yXAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDDOUJqJxZuon9Soq310edrmlVp+m2U6SUdNe1u4VNzyFITOdNt/QIPDj4Bxs6mzIVsT5kVmtpFJyR@nongnu.org
X-Gm-Message-State: AOJu0YxTjniQWh1Sls02FUz9ubUdS1hJevFb0dgL7wnnoJxdo9V1wPUG
 DUDDFjiUxvnQHM27HmusNLiBFzy4AleZASSy01K92WRAV56xkf4WJDpvCdWx0fJDivw=
X-Gm-Gg: AY/fxX6vaDMN+BXFVcsuht2FH+/Z7zVxK35jagXGCM0tbwmujSAlTLJNDOtcWt1t1Ri
 +B09foKrxgSdpMNGq68xbHBM/a1PpYQqqIzIhYVDCc2A/Wmnp+Qpl8Jf+CmMYPZLZH3EcLYUdnA
 KTFv1/w0M15JrCH+wLe8mXPKquUhKI+HTGtM8or97vn29ApP8E8ATAx5xIRVwroqOjseWhhSE47
 tXOZ/KNNWVibtIMgCwfqEdmPw01BUk/quX26/F4gcvbCbK33MNYnOYuK6UV1Me7hcTI9Gtbcf3Y
 35nwxDtLk3Ahbe9YlBXFB70p0JNKs1iNYURVYX4HhMHnUnAKZXa/mcSYnAeMk8HhuZiTuWqhaS0
 wB7iMat5RU+XtiG4Ir/WtnlaTp/c/jiEpd3Pq1m3f7p/+wmTw+JZo0wTNTiheEKL+T33LABoPyl
 I8Zq9am1VbAnD/hx6FT83La6pJgCFmug==
X-Google-Smtp-Source: AGHT+IHB7bgl7Ez7L9lwjVzKM6+/zp+pMV9SrgJuIMlHzH/HZEA5B1/+usXtO+yoc95qdP6rspAGVQ==
X-Received: by 2002:a05:6a00:b60e:b0:7e8:450c:6190 with SMTP id
 d2e1a72fcca58-7ff66480a16mr40631174b3a.39.1767574655496; 
 Sun, 04 Jan 2026 16:57:35 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7ae354easm46228461b3a.16.2026.01.04.16.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:57:35 -0800 (PST)
Message-ID: <30b79d92-8ab1-41b9-b73f-e95573ee3340@linaro.org>
Date: Mon, 5 Jan 2026 11:57:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs/targets: Forbid Renesas RX to use legacy
 native endianness API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224163304.91384-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/25/25 03:33, Philippe Mathieu-Daudé wrote:
> The qemu-system-rx binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Preliminary commits allowing this final change:
> 
>   . 0f4af4e2672 target/rx: Use MemOp type in gen_ld[u]() and gen_st()
>   . 2062fa663c0 target/rx: Propagate DisasContext to generated helpers
>   . 8b71fd6ffec target/rx: Propagate DisasContext to push() / pop()
>   . 363fff6d1b1 target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
>   . cb8e4556d58 target/rx: Factor mo_endian() helper out
>   . f9903a8a23e target/rx: Replace MO_TE -> MO_LE
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/rx-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

