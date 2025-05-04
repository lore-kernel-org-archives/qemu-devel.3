Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB56C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc7Y-0000lY-IY; Sun, 04 May 2025 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc7W-0000iJ-QT
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:23:14 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc7V-0007rm-7j
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:23:14 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af523f4511fso3410924a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375792; x=1746980592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BLjUVLdVq38E0HUOI0rLguEylIZdL7Xxs7lg4wT4WD4=;
 b=vJo/NuilHgXaYBWK6OC+TVlXh34mT8y0GyorgRxEW40oA44hubKyJPXidxnHsUqqow
 EtxBUEau1I98TA/eL5Wcn8KPz2O9C0Ovkf0stAX2F8v0XJkyazOqYp+HVsMn+dwIijfu
 ezx2srbTOEUs4xS17467LCb359luiy6Gd+0394jmHYt1V/4MphMXcjjIoDhOXCGeFYdm
 l+dJ1DxkdSwqbvUx+vMYFkg8XiEHg4dcGARXoQLcYIfjvfjPEftTzpxLuciCp5L2nG8V
 iS1cpwAYTBXdt3liSHpp1RAisAmJYZCoLelO1YkcrVmW53V6tZwaQAiOafnMn1Lfa9pX
 7DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375792; x=1746980592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BLjUVLdVq38E0HUOI0rLguEylIZdL7Xxs7lg4wT4WD4=;
 b=gRRXFrMaqe6KkwyuT4jCkwB2wYHPk4jz681mP9ZwjBxF+040+FGOtaAfEpvmyYhZZ6
 fpd2qlprg9CCJS1IQ+1zaV4A2e9KkkXE23JsVTDeoy0PAui83RriV8gspVsU6W01JJT6
 zjjTz9GzE4+GWUHSWAh7If3VqUQxA6sM2zNWAwSXI64ouRD5QCNR0wgixxchyruyrC9k
 YgiHB9mFQEVHDDzO3c7OmB5AcqutV/zHjCuwG9y/ZhzvDV/l5828JC24Xq+PbU4Tr0Wi
 XI4G06ZFzPg7Qvz/Z3nWZEcRBT93Gomoaz3aFNRtXEY5ELtR34HNyZk3bGdtkYggC9wX
 lkuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmyy0zEQ3lOnaYYXTl6bN7VA/EkLzaI3ec9uclPMk+6SOWk0HGBlvLVymRiOZmZa/0uIDV6nP55Ksf@nongnu.org
X-Gm-Message-State: AOJu0Ywh1Szs/Y4Dbmhy0wYsrWaAoklCQMs2PXxklO7feRymnbn71rrM
 N3IkXK+agg4WjsuGmOqR2rD/XDnM9XQtaJQ94IZ1ewPvF/CKQUpyTznpRnV2K58=
X-Gm-Gg: ASbGncugb0HrpFPgeCHObTnzB/Bs9Uk6Rn1TMpvw3ePDMUIEktzdomqiD6T+YC7SUmk
 rptMVeIiG2wWDPP1fwFQcl0nkB7OyqA5DTcHHWeigowihqWOvwgT7KxnWsnEUHDG05hK0ZvKJa4
 mDoYv+ssd86H+MIWJ5J3sxXMuMT8Cpb5zrA1/58XlEvVq7sxE9qExWxPYwycwDC16/pivKdvl6b
 F3DeO0xMCthn7XEhRO8GQChfQ4777NEex36KhUSDXv0Kj/SflOZ5rYIx/BtVgWRUT+/KdvDUVuO
 5UztlpFrVTpqitsSqwCOzZ8mATUwFQNvpJyhhneuziscMOEja8hWGrYgw6rfhnMtsWykCTvsAHQ
 TdwLkoCs=
X-Google-Smtp-Source: AGHT+IGG8iLGeA4CdD0ixdSNcxIntlbOJm3it6GQMfYx68he3yFqHRk29MPYt91OlZ6NQtlxvF0qQw==
X-Received: by 2002:a05:6a20:d48b:b0:1f5:86f2:ba57 with SMTP id
 adf61e73a8af0-20e978cab74mr6244131637.30.1746375791746; 
 Sun, 04 May 2025 09:23:11 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3c3e8b9sm3995961a12.47.2025.05.04.09.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:23:11 -0700 (PDT)
Message-ID: <fb79692d-4320-44fc-a555-4c491b172959@linaro.org>
Date: Sun, 4 May 2025 09:23:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 40/40] target/arm/machine: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-41-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-41-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index bb1c09676d5..b404fa54863 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
>   arm_common_system_ss = ss.source_set()
>   arm_system_ss.add(files(
>     'arm-qmp-cmds.c',
> -  'machine.c',
>   ))
>   arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
>   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> @@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
>     'cortex-regs.c',
>     'debug_helper.c',
>     'helper.c',
> +  'machine.c',
>     'ptw.c',
>     'vfp_fpscr.c',
>   ))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

