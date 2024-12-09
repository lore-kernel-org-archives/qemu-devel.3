Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F03AE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkuA-0000rE-SH; Mon, 09 Dec 2024 16:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKku9-0000qn-8k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:02:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKku6-0005fQ-H3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:02:57 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434acf1f9abso46916415e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733778172; x=1734382972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/kMoK9Ui1/SI/o8C7Y26DyJrvdA+Ciqqdx26aFWtDA=;
 b=F2yiLLIlbI+1Vv3FOc5f031Z2J6fzuxSylyoiAns2ymJhbkbDqnWsaQkDvmOydTrvL
 dl2LFIXKQ0ekGL0DJSq73h81vxbtm08fFL9mHMGsffJlFnuN9E/bG5QNxA86Lo2CN5nz
 F/RnnWGO8GPg3tLxcMnFxrZ7wIRHixXmBDJ0NfbsySBoQEpZPge4nNjGOBjus794PoG0
 by0IFf24YWx3gv0kYzBHQ8hSZjAIWHCvKZ7H0CBjNikEZcwmR3gInHI5hx9kvfF1E5lV
 h5ujMQH9gBdrd5lfYgxOS+/NmMAO/k7o31xzXf07PWSMNe/b/LcCtjh0UMsaCYCE+dZa
 E4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778172; x=1734382972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/kMoK9Ui1/SI/o8C7Y26DyJrvdA+Ciqqdx26aFWtDA=;
 b=M51RmlxSgiIftfINCK3NPMbK6PkE44X0K9HBqUJ6AX8COS5ToFMKLA7Askk3jg60/u
 N072uID+9V31gMlGv5rz0xXG2iGdezWpyPdV3WHp0Eb7DgKgvdrjrpv3Ww+tNE834C3a
 CELnVYbTD6v7rkDzLcD3BohAVqeAK34t5SNN6xgbH+/w22oAF5B8Wz1NfxOg9rGH0UMU
 jT2HAI6IBIz65wKNWao76wOZXfUjXe9xgLmX/wMQgaDJVKXEd0BknxX1E1Fk50w+U0eG
 Zp0fFaQc5Hf9yx7FP+RKtHApeuV1CQzvRl9ZhTwGdZ9J0dg1QY2wzv2oXJcLjYod6i/o
 aM5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeG78eGxZZK9PqWg+kTju37gFZY9tiu0x1Lyq2qtX3PdAQDBI5W7WZkbn2AgWpTRPdOOdEBD+k5IXo@nongnu.org
X-Gm-Message-State: AOJu0YzY9uP7K5GEa/a8kmG/NYVULl/mGAz38uuMKGcO7aZ+blNqaiYc
 ZznhOMJeqt8+dUXwTuyEjITXPJt0bSWGcKXxtglOWD059NtJbUVM/jWppx4gHOY=
X-Gm-Gg: ASbGncu34cRxuresV4ZJiE07f0w9Y5azAa8RkMhn/5V8/zaIy+h9rcJ3FcGRq3y6q9b
 qy6YWhiCLf5cnc8OYFZhE+ytj8QbFI42sAQKvUHktck9aHY7GAyG08vPNG0SYbvpay5YvntOif5
 pd/yIahk6NaIZZ5J5tVoF/af3RK0FtW92U/B6O7+TXDB+/dq7XWZdjm9yUbjn7d+2Ak6nRkJoge
 QHAsinna+LnTVwrFWFo6xG3NuKl5kKQokPaCaQ9QzlIR9pPTklCW8JA6uRLlvWQMpX0UkJyE7b+
 QVQ5NlK7K2gtl+MN9WH1zzb2zeuifZBfeYXc
X-Google-Smtp-Source: AGHT+IF26uogiVChmgk4WmG+zIfBUEvwW2xGcjfADY5c1uwI4SoYBmVBlbaD3X0QloLrsb+9nKqvdQ==
X-Received: by 2002:a05:600c:3d8f:b0:434:a19a:5965 with SMTP id
 5b1f17b1804b1-434fff306afmr17913745e9.6.1733778172236; 
 Mon, 09 Dec 2024 13:02:52 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cad51sm202409265e9.36.2024.12.09.13.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:02:51 -0800 (PST)
Message-ID: <6deb8f73-1302-4a82-86a6-c4e8b13831c8@linaro.org>
Date: Mon, 9 Dec 2024 22:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tests/qtest/migration: Initialize buffer in
 probe_o_direct_support
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20241209204427.17763-1-farosas@suse.de>
 <20241209204427.17763-3-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209204427.17763-3-farosas@suse.de>
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

On 9/12/24 21:44, Fabiano Rosas wrote:
> Valgrind complains about the probe_o_direct_support() function reading
> from an uninitialized buffer. For probing O_DIRECT support we don't
> actually need to write to the file, just make sure the pwrite call
> doesn't reject the write. Still, write zeroes to the buffer to
> suppress the warning.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/migration-helpers.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3f8ba7fa8e..981910ba35 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -496,6 +496,7 @@ bool probe_o_direct_support(const char *tmpfs)
>   
>       buf = qemu_try_memalign(len, len);
>       g_assert(buf);

(we could directly use qemu_memalign here)

> +    memset(buf, 0, len);
>   
>       ret = pwrite(fd, buf, len, offset);
>       unlink(filename);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


