Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EFDD2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 13:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBn5-0006NL-V7; Tue, 20 Jan 2026 08:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viBmg-0006Dk-RC
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:28:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viBmd-0003R0-Cy
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:28:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so40094265e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768915714; x=1769520514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=srwK5qMV3taU/eXCoCnrx9Y2KKg2uUGkqQJAM+4dcNM=;
 b=Lcx70FTVQ0uwfUH/3XCFCBJYtWfU7Ua68yziYkkdW7RVJLHh3AY5hPqsJPmNSRwPjV
 UTc3prmTRGkQJkbvxqLn+dDGRdzJgt3MLcgugItG4Z+GU4uX801N6cnY+p21afjvn2ou
 gPJALaYPKjyJPji0jlcfxZl9XqkHF9pZr01BlMGLn4JKTlVC70lk/ALnDvRUuURgTpQU
 WPcvuRXdt+ifGKr4HUKL5/wp7HvfvzYFda7Jpy3XjW3VzMv1QhYMYwNVXQwHkAOWjb4z
 xIzflgvHUXuAFEj7XdAYhbj4rm86H1cIjyYQydFsrRdmxiFr+zujQJZTzAbcXsgzrZBW
 HwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768915714; x=1769520514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srwK5qMV3taU/eXCoCnrx9Y2KKg2uUGkqQJAM+4dcNM=;
 b=m3hWFDxQK5z50K2PKF7MK3pHLYvDFYMK0BluxyxoZLwTRpHjvDqeqvS1b+k8+Uvyfa
 O2X7z2Imh41zbFA1l/FhqNBFdCqVa76tOyL4UnFTaO9LwPGXTW0PcOkUGhTfKXdvXly3
 MyNhe+akvt9vO5dzFDdWMf6tV92Ak57oBjTK14IYFwXu0cOLLR/sMlEa8d+V3OmgozHh
 V0Y3/TzNEOeGFgc26aPXZAG+I74K2GJAqbq9/yyliYL57Sshf5StDpIxnQ6kPKUfy1no
 7Ebtd1JX7jvs9Nha1rbuMnWBVa56s99V3g6x5a59q16Pq29r9FfAZHuve93cDay+9BIG
 qncA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt3QX8daXWEaGY7cdM/mzmfQBzaqB3aNDMe3uAOK4JMzR/IDUtfV7lsFWf8FOq+29Sh7pl6r0o3Bky@nongnu.org
X-Gm-Message-State: AOJu0Yx9yl+0RcamdPfUD3HpHtenHuZD+qqn1RKL59pROLJAop6YLuzm
 +5HCNxZaZEgGFNkpLP3SqIrgk6WQs08HoaxyeFFjIWo7qvkirB0Q7cSeGH7/5XK8wLI=
X-Gm-Gg: AY/fxX68lQrjjq+vrDRwnsVk2HbehXdpTmIzuXHY8OOfHy9geNkG9vZpDYmtbI3qxrL
 gHI+ipI3NaKAIPwAc05XACJr7wRTRQf0GQ9c4Dt/ds/AzdRGdVtyrAQdtQRIAbHwV+aBhj4sqS1
 P8Ar2D2ML8yNNlbpx1QtBdZ+Mft88q6r6HgL5Z5cs0llxGU54/banWvk9yGKFAx84ALphRhzldP
 JlcOmcChNAQToxrpzJEuCIcdZ7O+/WVXH2L10oiV1B7zGQ/vClN4BafYqOK3xU4a0a1vDnA5lGz
 0krzKj09SZOcNftCEdkM3wZgraB1D/9TF0RiIxm+D7dBaK5aC8dOKmq1gXyINkkpZlGktSys1Lu
 3F+esFa20YnvxaEq68bXjCChIx3cWYFeL+JT7F6aGGowV+bb2lxrNrAYWuLNyXpD4JjuZQqPldK
 5amnheO5jSxvU7zsOGTqMOEuY6R/5AR/BEKbjQ/7GwFGVdWP91RyUQwQ==
X-Received: by 2002:a05:600c:8b82:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-4801eb0e10emr183765335e9.28.1768915713788; 
 Tue, 20 Jan 2026 05:28:33 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm294068615e9.10.2026.01.20.05.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 05:28:33 -0800 (PST)
Message-ID: <6a5bd9c7-34e5-4d73-8980-a3b930754d98@linaro.org>
Date: Tue, 20 Jan 2026 14:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] plugins: move win32_linker.c file to plugins
 directory
Content-Language: en-US
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
 <20260119191138.811069-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119191138.811069-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/1/26 20:11, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   {contrib/plugins => plugins}/win32_linker.c | 0
>   contrib/plugins/meson.build                 | 2 +-
>   tests/tcg/plugins/meson.build               | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

