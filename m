Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B29C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqdd-0004kA-5U; Mon, 04 Aug 2025 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqdN-0004by-Kw
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:33:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqdK-0000Do-Is
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:33:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so5348315e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296404; x=1754901204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n08+OAsSCraFxY9l4+3LjEILGlsjZjmJCIJtwLxrpKU=;
 b=mbaXOQmfSwJ2P87ls53tuxMsG0tO8SApagIah1G4JyWslBnIW4bLvKktgwrUVp1iCY
 EjY8YBpISsFw5ezgRG77XZ3AAPkcooKyv4ax7DzL+38mV71q8CqZ/ZT2Ws6ZU2DWp/36
 gFyEMLjCzMwP2uS3dEyvXtaaxUWS4/4ZaKJ5juy5b2VywIcBzCyDcaPC2l9bK0Up6ovW
 yyQhCDiiwkjUkydqwyxETe1mRiLXGauHxEivRRHi8GVJsK6oiBGH7E8IfQk5adLEHnYw
 1S8WRmQUdZxBPwlICQYhFUgmKBB3o21CFiYTkipxkik3Xv1bv1EaVfE0I5GhlmJdPBqi
 qEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296404; x=1754901204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n08+OAsSCraFxY9l4+3LjEILGlsjZjmJCIJtwLxrpKU=;
 b=I1ES5PqXDzj6DMab9vSm0uh4Rs8N1LdqukfGl2zNuqmSRxmqWZ+xty7lMspmcmkthP
 9VPLs/PzidU8QzeuhC4yrghCNmXOwxW0XooO7/jPnxQh4t30hOeiUkL4ZaZxw/ohoDSK
 NRd5tKI4y7UuAfoxnl85TRg/7VthuatUddZvFazOaK/XgqzmyyG0r1tDDDlmIGO/1uwG
 DEObMo3PezR6fVc1gxuWFaxu5Bdd0LhoJax9mvOKjwdxlsYjUAiDIfrotDLfZnCMR2yO
 JBrPrSvoNzsc4lmJQVFs1sawQPWkI5Bpu4ZkMmrxAhb0XMLb+Zh2Sp3z51q2tB97MXky
 OzGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaH/tRlDEEvf56LT7E+Ec9O2xRIbw8tCCze8KL6SDBZufTSGfZHm4YujDdfrKzF63PPnqD13lINfWD@nongnu.org
X-Gm-Message-State: AOJu0Yz8pmDZLUeYnQqdRzJP6k6KiqMZyp3Mgbe7S88J2GGpcqw2z81X
 +QTt5EDhn9c5NVx5X5OvYXUzoODXmPuC3dbve4b8tuTrukejAyZqPfJ5FhKaLnMvf8M=
X-Gm-Gg: ASbGncvgqs8M8dFmOnFuDNtEHUn8b0tDYfNRAnec1uRRNleBIbMtE/0NzGtJYiTnISs
 CoXzdA8hb9iLG9VY+eFaXNiBxRnYSBSV/moyNZ+RAsQJlL+4MXNPaf0ix3wUy/oRwwUtIpVhysU
 LHorlZhDmvEx9gbI2yFwniN7t6LU+BcDBc3igc5JyonzLMIMPUmqPTJdEcubsI/XgVz9TY/jtTf
 EXXU6Wr2ZfDJYOaeQXMY/0zKJT6PG9xEbKafKAXwJnI85qau4tYMmY+/9ch+XK2N31WObFr28ov
 FIN5hOtvY5KF/CDCMor60ZOHSe67exNVj6obKb0yPTFMQWZIuVaemWba3wqO6149UNeCIq9OYmc
 aP4iM1/LR1PsYtDhX3JVnnVQFSGSn/W/kzEkSXXmErpmXE1tpMkrV0ysJSV29mzSotdB+gts=
X-Google-Smtp-Source: AGHT+IEjRUmnidbRN+eNHuVNR2KrFxkSFqigfKWRJnBPEqNsOohbwUWWLYXgxJitvGYhznatAOSGKg==
X-Received: by 2002:a05:600c:4692:b0:456:133f:a02d with SMTP id
 5b1f17b1804b1-458b6b312d9mr68678215e9.17.1754296404351; 
 Mon, 04 Aug 2025 01:33:24 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458a7c91c0esm137550935e9.11.2025.08.04.01.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:33:23 -0700 (PDT)
Message-ID: <a0e892dd-b432-4665-908b-ab338d9d497f@linaro.org>
Date: Mon, 4 Aug 2025 10:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] tests/functional: Move xtensa tests into
 target-specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-24-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-24-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> xtensa tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                                 | 2 +-
>   tests/functional/meson.build                                | 6 +-----
>   tests/functional/xtensa/meson.build                         | 6 ++++++
>   .../functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} | 0
>   .../{test_xtensa_replay.py => xtensa/test_replay.py}        | 0
>   5 files changed, 8 insertions(+), 6 deletions(-)
>   create mode 100644 tests/functional/xtensa/meson.build
>   rename tests/functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} (100%)
>   rename tests/functional/{test_xtensa_replay.py => xtensa/test_replay.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


