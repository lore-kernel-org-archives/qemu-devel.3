Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE33D2B925
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jfh-0003LC-Lt; Tue, 05 Nov 2024 08:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JfW-0003Az-QO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:32:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JfT-0007Rx-Nu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:32:26 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so3672302f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813542; x=1731418342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sL/q0ySFiqdKdwWl7IvNX/vct6C8s8NYR7Y2ZsZELkg=;
 b=IyMdzcGwW0BshrVFVaQ0cs72L8rpBKz/oKzGU1CXVt60Lem94ozeoxp0RS7koVoa7/
 YxbV9jNE39WPEj1OOfB0UZ3Dt9NombNdbTNbF+VM1SXfM545yWrdAUIbT7sfhmWL2GS7
 4iNTsIMfBbFznvaTgI033iKN6JHtAC3EpL4Dzow5FfRgp5o3APvCno7PW/rRMP8zeoV5
 xcZaqt5oJpI5j1JjZ5M5DwboW6GK2tk4SDqQ/6BIVnktTMRvU348hatI8pOFuPIQ3bVD
 ssL0444Gv18VW9z5fycawQor2CQAB8UtXzrTNClTaf7IIsddNSVScdDdUMyilLLxMT0i
 eQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813542; x=1731418342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sL/q0ySFiqdKdwWl7IvNX/vct6C8s8NYR7Y2ZsZELkg=;
 b=RRe3oweAapC+KGQb0CdVY9g1mEQ/bJxKZa+oru07kUmxhzc0F0EaMIex9IYaFrd9hn
 +TDNLhubAbbp1gQfrNMaZqovqeCsGMUnf63tGEaPKaOsci/w/JcMfQpeG/tM4pgrFnz0
 IwKqLi8o8IA54AhUTNiOtFRJMW5ge67KnRoRzIB80xmnnlnbFHBZdBioHKG7ifh4XGGi
 25oUch2r/CWxZQheLky/KU3+iuoE6hlF0NlZRwJUMVwJRn9LBTaxYtCHshDRuH8jOKpW
 nsOhtwrZZiJMKOvD4mezuQ+M68QxAX8vIDNmaSvCpqJzsokP/D+4IXMlVx6O3/BNOYNd
 7l5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE7noPvDEdit3hnZXQxn5ttlt8oxMQQXfLfWZIzi3tUTKtOpzarF0Iw+MSYLLY4oR8odm2Q8nc7OaZ@nongnu.org
X-Gm-Message-State: AOJu0YxracskV7V7D65g1T69EttEvNsbpLV+1WsdtSctrhzy0MFViwae
 O3uzj2mMWTmAiu4AlyKD7vyOvRjswTldtj+N33Q35aRH4svclP/yMYpFgmG2fdo=
X-Google-Smtp-Source: AGHT+IFRWGaK6omOGEuzLTxgV04kVOb1xiYgyf8hdNpYh/U69iPgRjWlhvd6NzSpQurjHlCPwswF4A==
X-Received: by 2002:a5d:6d84:0:b0:37d:5129:f45e with SMTP id
 ffacd0b85a97d-381be7c8137mr17810500f8f.20.1730813542076; 
 Tue, 05 Nov 2024 05:32:22 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7387sm16135325f8f.51.2024.11.05.05.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:32:21 -0800 (PST)
Message-ID: <a9c34a40-3f51-4496-95f1-d5d5237317c4@linaro.org>
Date: Tue, 5 Nov 2024 13:32:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] target/microblaze: Set MO_TE once in do_load() /
 do_store()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> All callers of do_load() / do_store() set MO_TE flag.
> Set it once in the callees.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 36 +++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)

I think you could have squashed this with the previous,
but either way,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

