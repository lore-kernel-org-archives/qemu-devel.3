Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C15CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIec-0003Mk-8C; Tue, 04 Nov 2025 10:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIeX-0003HF-RF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:08:58 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIeW-0004qC-GH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:08:57 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640b0639dabso4767731a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268935; x=1762873735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FEFbh5ypGo36tJSXvx8HB6Cd3yotO9rnhJ1Cf7TY+ns=;
 b=hjXtyS0tibJ2RSyfFaqs/tT6kDGhj5LDkxsrQuTLfo4Zka79l0bvdh2wWvgQ5o94XM
 7xpUoPL7zMYUEXMXXm4f44ntxxSyQEZCYw68Z2ItaRy+StIz+UlHae23VZRYiKt61TWf
 ULO6S0Qk5RIPsgSHvBgKMsFM5sQJa40/sfYuhzXzyz1h00XJtGHpMfGFCUDrK5G6u5ir
 C0VFP0+2iLeXBV7Om6Ws33JND619cU5GahYnBjBwwZlFNdaJuqyozo8pE/5BmAUTi6Le
 3IfBggw/MEr2qkP20vJYEZ1qh6vrC5I4/SMakMrQ4unfKO5stnmrjHSvLsqafmATO8A5
 8dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268935; x=1762873735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEFbh5ypGo36tJSXvx8HB6Cd3yotO9rnhJ1Cf7TY+ns=;
 b=pHa33jzQdyC3TyaxmslgoOlNeV3RJ2C5NQfs+U0XytfbKVGbu8ZID6nPRUaQ9p7yXX
 y9edZ3TO/6HdOFvImN/Rn/9xghrLbSg9EH6kNMJvfNekS6oJYazT9qc5vVY6x3ZlO2cL
 i2uQiZ06RAaC3qr+JixUdkdOvGux3bUB8QDQAGTgvErRLgkgDzmtShw6E6Da/GdRxYnw
 TkgIN2b2yNGXREXzk3XVLvyuhDTmFzEGr5GEQJ5gi8cExeit7mvrwoTzt0bv1nvqk+Jv
 RKOshwMhozPMOPhgjfR1f8ODjbW0qNmI06pHRVg3xQ323HsF64hhdGgCDqCv1HzggNnT
 K5pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEaI6IBuCVJFOtYEZFXHzBApv4uNMtDg0WLgpR5Yw4dvAhxJBhhQ2+WITyMwVJu2k4E15GjStM1lbb@nongnu.org
X-Gm-Message-State: AOJu0Yzr7ml/QOe2yNwjbkLYMIe4VX7gQlga5/w7R8nVZ/CJ5XunrKhc
 olDWxvkLVf3apMseboW31EnkeTCYgRDDyOY/M4uYa2bo+rCoebCvls1urhARThDdTyU=
X-Gm-Gg: ASbGncvr08f+3+SWxmDVNEtjqTsSjmWZ7MBbO0xRd0bKVOlEbBJioHM0BePHFpf5zaO
 Z9EEnrCrHAB+15+P/cXJUtPtLiXk78el1yK8mD2bT2tRl/pb6Cjvi4wZ3YZPb14s0Q8eRi5PpC4
 WV0DRQwHUb78IeWGwpPaftOqHzbYnqdTrsZpXd3zqfFCNpiuiYsw+on1hqqfRE3aBnPloBtClgS
 2rBObYz9rlBhsS90Uu/l1XbuN+qsQLjlhoTpBJ9eU/75oBPnF4mJIKqzy9bfkEkgwysM7drDgrj
 AfSm19wWstpeGo9GjHbtTxqOW8N7cy49r/xDlM+RY/r62Ut/KIFtr0pKiohYHoFlMG6YfbO7muK
 aVmzR1rIxlW/U0JpGIFgXyDlUhkzSb2oW3x2wmIVDPn28QFtrYC4tSG8xxdDtTxwvqlPJPPWJRo
 cVfFqJo54BJnFK5hT32TiEmobnJoLKzQ==
X-Google-Smtp-Source: AGHT+IFjPO3t7G9le9dGOHkTQF4Hp9ZO151XxmsADNA0LqgBcc7paj4VnqglLmPKyRqUhDguBEtbcg==
X-Received: by 2002:a05:6402:34c6:b0:640:9aed:6ab6 with SMTP id
 4fb4d7f45d1cf-6409aed6c84mr10142176a12.24.1762268934704; 
 Tue, 04 Nov 2025 07:08:54 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a7f2a5sm2231179a12.34.2025.11.04.07.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:08:54 -0800 (PST)
Message-ID: <9b1aae8b-911f-49c3-84bd-67f5e0e8a137@linaro.org>
Date: Tue, 4 Nov 2025 16:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] hw/sd/sdcard: Handle RPMB MAC field
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <b6f5698c0ca017871d54834f0c7bd4b4b6316bbd.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b6f5698c0ca017871d54834f0c7bd4b4b6316bbd.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 4/11/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Implement correct setting of the MAC field when passing RPMB frames back
> to the guest. Also check the MAC on authenticated write requests.
> 
> This depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256 which is
> always available via glib - assert this, just to be safe.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


