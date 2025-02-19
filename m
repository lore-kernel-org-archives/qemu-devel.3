Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA28DC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk65-0002J3-3e; Wed, 19 Feb 2025 08:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkk62-0002IR-QO
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:26:38 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkk61-00011o-6y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:26:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f504f087eso1758976f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739971595; x=1740576395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApzCe6gw52Vr0U4qKaBlvpA6sFckj62Uh/SJHb4xlaE=;
 b=jYKQra0Jsgdwn+6NKjG0zlYNwPg+ercOeix5b2qJsKjeoZy8UehreVWOxySaywKR1J
 gZ9Ra56ZAPN1zg9XDs8BoEKWZyoPy6imwfcDNkJ6biA5QzRJLOGZ+S+/+PBkuBiedUWX
 yEH2qnt98ppLgfJ5pptuQ0hfFTH5euyi1HIFXIi5mCP2WiFDg9haXdMQDeuGLoHD1aGX
 FyeFd6gNjRaPO1ZMu6yjo0QWXsUjhK6licavvxRVqptdOUJMQroMkkmSXxngPHLlEZ1p
 frFCDp6O/zgFSI8CBuoD2nJjAzekqGQoAI3aq9hikiZdKsEX8k/MEtVTYKKsfItlIuAN
 3ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739971595; x=1740576395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApzCe6gw52Vr0U4qKaBlvpA6sFckj62Uh/SJHb4xlaE=;
 b=e8kxY5QYGXJObFC4PnnNiQ2QeGxeApLS5g4elwESj12J7WVDfq6UNDkDvMlODC4xXW
 QnONglyOZqoO0LOoNqQMd+TPx33gg5GxINPuqvHGhsn4q3tHXd3T9L9XpWoztdxf6Bdb
 071BQS0Otf7YbwQHI8IDgb4CKPccgUKTBeuTxKxXe7aORuq6ZmP9j2QQNufz8fadyHu6
 bAlvgb0T6zfk8iozTCZ/fBlKcUvFLReBbVjlxFlxl1N0AFNYbF+KZGUKc6ydNpdsMuD9
 rP3juVkFdnsHxlXvIAWA8HpU1vRYrITOQbfNWzogUQTCqQuEvNocPjnYDLhISmn5xUFj
 brxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtOutkAVEknAQbGukCBsUz99CWGoaljqCU+n8yZ+5hpvKlIWhzSg9u3obPrD1HYnbqPtsZFawW5rpB@nongnu.org
X-Gm-Message-State: AOJu0YwgSQ4G2ijHkeU1aHHbaM48SS+W+uFvCekgUf82NQh3y7Bn+G19
 BCXAhiAwGJNxA/ngEo7DZ5xCTx/GUuUCK+hgLIjTKOFFFvQ/pRWdJzpr2nizQo8=
X-Gm-Gg: ASbGncsMSe2hy2AmkSShE8UC+CALWM3Gxw/8sWa9qHAL6rjpHkXPnEI02zAZ5ypHNKJ
 M3DvDQmX9ikuXVCMxFtLr9/9ndjnU8s4upHxNJaJcEffRWnuhj8qzWmFoMWF+590ELmqo46DGWu
 i82uJ/36PsLS1+gGtDp+rvg/xwSJaWGBOsJAtwZHbK2RKp9c6WvDqlyygc79xOUsIxQxk7onsSe
 GUN/Qr1X4bv/kfq2dG6NXwZ2WC5+vAg3GEah3DEB+zH5yvFZQgGYmeyuK29MzfjYMvMwi3EJVVj
 +GIOzMkeBhhKPJ0nVkFb6SLdObSoFH/WMinpWkQ8BtBvM6yNBKCqxZhdRd8=
X-Google-Smtp-Source: AGHT+IFBeJWfpV2S8N6NGt0tYK5PIGuOzTQEfA1RfCb5WB/AsLSez+XcDsc4SRHd9bB7ByA8JaQiQg==
X-Received: by 2002:a05:6000:2a8:b0:38f:4f07:fad6 with SMTP id
 ffacd0b85a97d-38f58782ba2mr3021638f8f.5.1739971595380; 
 Wed, 19 Feb 2025 05:26:35 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc8b4sm18076299f8f.50.2025.02.19.05.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:26:34 -0800 (PST)
Message-ID: <b1843604-2fb8-4a17-bb2a-b827a5d28a71@linaro.org>
Date: Wed, 19 Feb 2025 14:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] Makefile: "make dist" generates a .xz, not .bz2
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20250219130009.342000-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250219130009.342000-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 19/2/25 14:00, Michael Tokarev wrote:
> Fixes: 9bc9e9511944 (make-release: switch to .xz format by default)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


