Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432E2C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0uw-00030X-Rd; Mon, 05 May 2025 14:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0uu-0002zQ-OX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:51:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0us-0007GK-UR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:51:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3014678689aso3746306a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471109; x=1747075909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wFa5afTFllsh88Fa9jTh0JeUcoNick2xFbmV1V5kyxg=;
 b=Fv2BZJjpSrFvZ+kz2OaspRc8T4bfgMyWxDk5rF0u15Ud+AQnuV054hVNSF3BRlTv9W
 PdnBxqcApaspnEpQdzXY3Moog/UCzyTgegTZcpxU2bV0dgVnem8KcZup4sdfm8w5PzUP
 iLXJIOPndEAkrsa8CerVzlTzD9CQGHWIIkJEfsFg56Ezaq2VdNzGoRItLES8JRsp6ZNc
 Kdefg1MJXK1g6NyaxDH7CGpramvG1sP5YRxfz+D6AEejuWu9Z03wAlk/qFi1LpEzwZta
 zY7MFu+MnX9I4k4qf7zmINoHIE5cmtvkI890t0giOPiTSPlnaQ2x8afIfDe/nMmqDWwz
 28yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471109; x=1747075909;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFa5afTFllsh88Fa9jTh0JeUcoNick2xFbmV1V5kyxg=;
 b=H3MaGtcrc3CWUxKok7v12F0qBfpr2oT1+QVcl+sdJ3kCIJFyQQxJ6zOaS4kFbSV67k
 MNc8zj6noycl6V7dURyWkOivqSYgsYv/b3+xtV3pmKRzN30nYKwagr39EsWWbSuHjWYD
 D3ziTQSwQVeeju1Wj0qZzvkJ3Qcr2mV7xKKeAp8yEVranLOQJTgGBGcZHdCrYXtSQFmW
 gUOrU8SdGPDNS/JTi7M0GhGnEJKkWUrsv4S6i7OIe0fqGXxooEvraycZZ/xGNjZ9SxXI
 6JLVFywDu5iZ4TZWfpsQkURiL0uGWHOEsUyTq2pC2RBLGIxf8QnM/yLYvDSB3pwaFnif
 alMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDe6rXjwDVRzb9LQheqCGZm0ItL+S7Ve9MaX00JaTM+JVXHD/EE1fDvKmDzy/x7GY8xaiTRuzzOyNE@nongnu.org
X-Gm-Message-State: AOJu0YzAIfQd2coExxsKjfcoKwSSY6uxEk2yR2X0qeGjDhAmN8zxCYa4
 aiGugg6hHIEO2zV57UtHo0S1vixW78FVvjBvAWdrHRdC7aG4IVf4NBtpoY7kWJs=
X-Gm-Gg: ASbGncs5Rmm9nguRRxeXQIchvmo5C4ruQab73KNBvxYYZF46NWdIrFrpYIBt0ydNGkd
 Bt5NMKfcaOyEwJtrThwotTeHEJLdnsaQw3wF15ZokGytq+FkVOBD2ZTujjfjr3HZ6ANSKkNXYd1
 vuIoZXmqQpaKxvru5XgnsLg5ggqReE+ra/6C0FNAfKCaWp9oAC/miAqFNNiBMyni5GE+UxWYzwa
 VWPhaXCBEP7GT2eVpkUTt6IpXWx7zbbYm+8MMUYZTjn7ovNK4YGJWSzaTI++M6qgSdDyGUWVTk9
 z5GK00or/zY0Sy0D0wgBBQk2LSddhtnjGpsI9KC0jEjdpcJeysUHyC0VPtsRrrRDfKBDYvbmPLS
 T19LZiYI=
X-Google-Smtp-Source: AGHT+IFT2VC3lXxrH5o9hFQWMnOfnze8kfwxQwH28m537ex0rGytUEYd+B6nwd6awF4Y2DFyjfxf5A==
X-Received: by 2002:a17:90b:2dc1:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-30a7c0de480mr668649a91.31.1746471109072; 
 Mon, 05 May 2025 11:51:49 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a263ea6e8sm16512549a91.1.2025.05.05.11.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:51:48 -0700 (PDT)
Message-ID: <7129b772-cd75-4b55-b660-a75d176ab059@linaro.org>
Date: Mon, 5 May 2025 11:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 43/48] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
From: Richard Henderson <richard.henderson@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-44-pierrick.bouvier@linaro.org>
 <2c005b5f-1308-4c7e-9b0c-9640aef294e9@linaro.org>
Content-Language: en-US
In-Reply-To: <2c005b5f-1308-4c7e-9b0c-9640aef294e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 5/5/25 11:43, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/tcg/iwmmxt_helper.c | 4 +++-
>>   target/arm/tcg/meson.build     | 3 ++-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> It appears iwmmxt_helper.c could be built once, like crypto_helper.c.

Based on the crypto answer,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

