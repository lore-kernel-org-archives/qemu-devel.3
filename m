Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A84C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwOF-0000YP-Bw; Tue, 25 Feb 2025 09:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwOD-0000Xq-BP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:58:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwOB-0002Zj-U7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:58:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso57700625e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740495506; x=1741100306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvQvWyv54uBoHNnslyv07xCf3EVB6afG4aoRt5qAol0=;
 b=f5RVeoJnvatTqpHOdCq8gmmU7wYDElXNb0+A3gRNwRzv4pr7A8HV/EyOotVE0lAMRH
 idT1LCLxEYFhIHMaUHaJrxSO0LFZEQuj902yuwCr/Cz4+DowFJZd6VQWMxhHWhz7RSJ1
 yVSYkN2/lSeXHPfNz9IZ4Mw/HxZ7QmiHmn8qqk0dQuNdqs2wXNBwIpNb3ziMxDrtbwwI
 21Qsz3y8FDwiuaYnRah6zamNYm+VNeCELnld2K0DsulTpcgBKhLedPuzhLaHjPiTAq/E
 MtiWxc7RJUqa6u6cyqPZj/ps/Mxvj0ngP6ktAHylZAI15XUJUMHNgfdgmcHkbog8jfVh
 1VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740495506; x=1741100306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvQvWyv54uBoHNnslyv07xCf3EVB6afG4aoRt5qAol0=;
 b=Et5a8bAtLvWabQinWcF4BFsyLpqqoWT2DKSWM5HUffRVEXD2UUiGtLd7GbD0LR6Xdl
 eRLvxMY+U16MVbXC4a8FcOLU7YFofAAJEUEcmZfV2vLr90HMRkFEYtmMH5l4RkeA4Xf2
 Jy5WYEoGh1dapE7p5DaUIVvTrKqCHKZP89g1f/t3nlf1Qo9XQWbqBwIrbYIdKTPVGCFd
 E42alElRB4ZemUuVGWuN7PttIVla8ULo1wOpXMWos148wrZjacyR+abdtBENMUC2Rt/d
 VMMKZiuDhdUUvvFde3uE1W5R0WIO0b6WlM7slK2yfp/77Tu73tCGXGCPnAghTWnNR33q
 DVgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl94/tWy6CqhM4yjX7THOWQsx4flf5EnuPE0LyJH3dO/80k0L0J9ydFSLiXPqdQWalwxKz1KPx5vEK@nongnu.org
X-Gm-Message-State: AOJu0YzwN3rpGN0IqXkXPQjdGQKBdX80G5N6PVroKlAJ1pTVMvc4Bs1X
 zushrHS6YaA3KD33KGb9tKA2RB7lH2l7qtOyu6N9QwGFAv+61ylE1Tq10koapxQ=
X-Gm-Gg: ASbGncu9gDJRdEPHlr8EeQ7BGF8Smh0VuRrkgpqXHS+fVfQwyHHLDMIhk49ctERUhDK
 a5oBxNkX62MWiVSrRHmMn/Gb7lrPhJW7rPz4ccAmtkN2QZCu1QXj/b6w0X5/3b65xTXhhB3g4Ty
 K6u+lVifCOoPKT6Lfz1WS3KM3Yo5tH06dOhwpt2/VF8Oc41aifpYRFBbVDYLg+jhfkrYJieUJPF
 Nz7itXHi+PhXEYz8xuNkH/kzQEIuxx/Yc9iTQUZfiuvO1djofPmnNE2aY8fEazPAucvis1s6Xkg
 NQU1c1Zed5EN+2R7RhV90aJ4VPKA7kAisr2B/NH1DvhKyyLFpuBjtwBhxLKbJqkq2EU/bw==
X-Google-Smtp-Source: AGHT+IHfqUSN52pJjZ9yIV2YS1s15zMpiZc/RelHUu+BdUHe1kjK/7UxNyn2K5CjXf6u/6dLuYOOeg==
X-Received: by 2002:a05:600c:444d:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43ab0f2dcbcmr40285835e9.10.1740495506371; 
 Tue, 25 Feb 2025 06:58:26 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f3e26sm143928585e9.23.2025.02.25.06.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 06:58:25 -0800 (PST)
Message-ID: <0b3eeb1d-8cad-4379-a784-b23d54c0029a@linaro.org>
Date: Tue, 25 Feb 2025 15:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] plugins/loader: populate target_name with
 target_name()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-3-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225110844.3296991-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/2/25 12:08, Alex Bennée wrote:
> We have a function we can call for this, lets not rely on macros that
> stop us building once.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


