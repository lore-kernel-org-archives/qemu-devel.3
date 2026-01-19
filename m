Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF55CCF2DD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuui-0006sV-0C; Mon, 19 Jan 2026 14:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhuug-0006p5-MU
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:27:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhuuf-0004GA-67
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:27:46 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so19246515e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768850864; x=1769455664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XIKF7oM1gYT4GT9/75cIp5gL5ST/OGQJ+6MykMo2t2A=;
 b=Yymogo662P4vcy0U1CdV5UJAYFkG3Mp7GE/B//hb/NiybOEi2qWqsn+mjLOveBfAz6
 bOOO00OU2QJFnwMnJF/V/wI1sQGtWyl7wwQdCYEoBDOLqhQFXg0Jt6218zahAnmVMXnD
 flZOjWF76PKghjqiZ16HdwsHZ0BncGQUJc2I5Mfx0sf7DLjCjunCyLpUh9lucq6fUgS2
 bsjy3dNZ5zBqLnnAUlnJM/bcipiaP9hOXwgR/W9nkjUvOomH98x1L9C5bQH8UK71bkwa
 vafzxjeM2CNyxmaWOydTPzTppUnWbY3ymAzQ7xH+22hBx4OVrLDpksUj/WgwDSze19Ch
 Djuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768850864; x=1769455664;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XIKF7oM1gYT4GT9/75cIp5gL5ST/OGQJ+6MykMo2t2A=;
 b=L8E84YBSRNPhhqz7JCQF7tWonMPCXNfzv98oQ449jjXcHMQztBvXLF6I7Jw1i1gvs5
 KnBYforsS+Zeo4QOD21eJ5XwIzzb5uJETMrNzlqnwaad9HIjh7N5N0PGKppD5XkO3uoG
 gC3AY0IiDLOaUu0tpyLEtp38oEQrd2MCVezWtHRmNDvb2oMxhbVniahdT9TAR/j/kHRF
 1j6zZ/CCazWft+ODW9jrm/E7YYRix23yF/YAsBsSx19WhHuGE68Lwr+ZT7DNHUDv1k7J
 xkYQE5GGMqsQWH/Yf98t+U0r3+YgWXMCMRMmnsNACiowOhaGv9Rcg2ncOTQ95PPRRQ8H
 eI2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7M3mU42NUV3SMzktMVFL7uCUv+r8HoBYnDf/hN0k2sqqXjbvwHs6pCPs+IPYH39fihk4rPIdgzRq@nongnu.org
X-Gm-Message-State: AOJu0YyE6uBWfvTf/QFlP+J0TJr+yR8tPcoI8M88dcSKGV5RXvqEe7vZ
 eFOBROMqv6d5LfCWvPc7yToBBuiGR2LWxRdLvzeMnGmWLeof8KjR2twyeq9Z9QT585g=
X-Gm-Gg: AY/fxX5Tai6EaeTHwEXu7e/4p5ig75Bo9qT5x2Z8122nsiRTHVFC84JYpPZwNtDIE8w
 VhfaVmkylM+Y5qhjYALhycI3T6InRjEEV7UBWvTuNUM7LKB56RnHrDn/kZ8RUmIpVLlbPIteiso
 0I7eCXUmaaOtXPUX3vSDJXKyhlPDVJ/C52U3ZMUndXlX3DWkix+k/Hy+vSm89WTdGkjmacn6nuL
 VVqPcsHuuo3G2a4KvH634H5iCstN21ij6mLXOWIgaotR38oX7W9NpechJIpY6XRQ3FTtJ/J+R5n
 be/1em6GeNTSkrqgJIBEKNIX61s96ELpX5mukrGYe8vcV+2zB7GiD9xhqdl8bO3+Jw557w4IZLz
 l3gqcaHYqDpZaXd4fJT4SnozV6L/8zX6xTXS0uccB1LxBzYZ8PgcxCgskW7x4DFXu8A+ha8R6rH
 MUsL6EvbzTMdovOd+32RX4gucGJSDSRe4NZep8EtZK3V5CDDsDAaoDHw==
X-Received: by 2002:a05:600c:8886:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4802168de81mr118799955e9.36.1768850863682; 
 Mon, 19 Jan 2026 11:27:43 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe78fcfsm86245855e9.19.2026.01.19.11.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 11:27:43 -0800 (PST)
Message-ID: <cb655b27-a6e1-4e16-b41a-288e3b9f6f13@linaro.org>
Date: Mon, 19 Jan 2026 20:27:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] plugins: enable C++ plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AFAICT this series is fully reviewed.

On 19/1/26 20:11, Pierrick Bouvier wrote:

> Pierrick Bouvier (11):
>    plugins: move win32_linker.c file to plugins directory
>    plugins: factorize plugin dependencies and library details
>    plugins: use complete filename for defining plugins sources
>    plugins: define plugin API symbols as extern "C" when compiling in C++
>    tests/tcg/plugins/mem.c: remove dependency on qemu headers
>    plugins: move qemu-plugin.h to include/plugins/
>    meson: fix supported compiler arguments in other languages than C
>    meson: enable cpp (optionally) for plugins
>    qga/vss-win32: fix clang warning with C++20
>    meson: update C++ standard to C++23
>    contrib/plugins: add empty cpp plugin


