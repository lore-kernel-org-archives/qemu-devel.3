Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA400D4661F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTPC-0003NQ-F9; Thu, 15 Jan 2026 14:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTPB-0003N7-5m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:53:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTP9-0000hK-Ln
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:53:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so8105315e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768506794; x=1769111594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oxg48iJpicsxkRKyRe0DmuSZk4wGUzVv/6pVl2gFEUo=;
 b=UiG5ZlHN9cPcrU5FVna4oJqsVuGeLT4xkLxsLMX/P4xC7/iCuYICbVBTRbJnpG6OaB
 bxavBZwHREuOELHzHiuxc4OeTyOWuHJiNRxl/EgPS8/fJVPpxOqhkNSLrA6hLJ8cXy60
 7DnlykNZKfjG6slgB+oH3Rq37jQserZn3XvSuY8TfzEXeBJpg8ZYNOKPVFmBCWxXdYYm
 E1BnMQYeX5bm2qpNQEk8/KifhxFwpw26YfvGkryQZSQxi8BZdIe0ZMPOaDWetCcOqqgN
 zwUxJPUD06aYYfva0ACd47l/J5eR6b0Aab66pZE39KektBwtFpKGeL1AMGpEaRoEoH8D
 5XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506794; x=1769111594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oxg48iJpicsxkRKyRe0DmuSZk4wGUzVv/6pVl2gFEUo=;
 b=tEwJ9CPJjb5BmEOwpN3ErW3fPoqGu6FEa27HKJ4BciAfKh5S8hFUIrVhS1mEnkQDPy
 3i4QR8dEpp09XiqFfg1g1cYENTwt26aEsZ7PQ5dpgEb5Ff5q6vOUJrfPnwfUHpMtV+YC
 7xxT6ZvkSxUz7LhtUYHNxHU6NDxnLZACxw96TG14il4xoQwNtOyqZ2sdxmx1Y28gkdRj
 CHmZrde2hVOKjSE94akM4h6+mrbL2s14cCRjR+7V/O1PMYXXXQVo950dNEXettspahlD
 H6dnPIx3VLlL3OzsboOZxUQu/waMQOkXiUDQdqywvSiZLKkEv6dYIaZ5JbFWqYezOmQZ
 bwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn9L8FAiky3yHzOmHbyjymogYf3tj4eABbsiurxW0xxtiM2fP881ClnXmonvo1MuGtY52KivCMSrSS@nongnu.org
X-Gm-Message-State: AOJu0Yyr9KrciUfjtV34VZyEvMtERDGckRkrBn/YfCSsrIGKv3HU866G
 jzLp7Crc3UxNIJ9evNVe02FtqqYeTdTUu5mLpKyzZy2nLZ3OXaspf0dayd7SaxyTdVM=
X-Gm-Gg: AY/fxX6t80GCxhs7mS3UyclkAunzxBF2V6oat65EbGjB2YEIGMkrmpeep57wqoMuTut
 s37W7JFc+ZqpZ5nXT8EvIXckyTlsKGPrLtAS1NI16zwlQX9Vvl/k9t3G0BYt9z5VuDS9HoS2AAp
 Sj3hm4f80TOXRLrE0t5RybKhLpOWMD57JvgCsmJ22+f7ClM0ZMiL12VR0W1O2nGqNViyCoMiH9c
 6vH8JznnrQyKPt5ISRXNMivC7lbuOEz5oKIGKeDGzLIGqFtS51elWZaEXg55jWRwu28Vmi68dqr
 UdbUB7nNi+zRF+5UQMU/haGTfnYdRXvAR8zWUBsR73a0bCErtBnuQ+a0LOdWg/GzrLkdB2/wyH2
 2WwZnBYDwhXY2rspDJP7042QcFyXIVspjAykgjW0HNDrSwJaMufY81QrylAWzWATKe8fPKKKBgv
 MOXV0uFA+iKVkehGsf1NpFaU6rEXmehD82Y9h57rVJBuLD6d0RPuq6SA==
X-Received: by 2002:a05:600c:1909:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-4801e33c745mr11015495e9.31.1768506793746; 
 Thu, 15 Jan 2026 11:53:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2755absm80395205e9.15.2026.01.15.11.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:53:13 -0800 (PST)
Message-ID: <2e0cd040-b80b-4dbd-9645-eff04d84a8ac@linaro.org>
Date: Thu, 15 Jan 2026 20:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/nvmm: Include missing ramlist.h header
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>
Cc: qemu-trivial@nongnu.org
References: <20260114083812.18496-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260114083812.18496-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 14/1/26 09:38, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Compiling on NetBSD currently fails with:
> 
>   ../src/target/i386/nvmm/nvmm-all.c:1136:22: error: unknown type name 'RAMBlockNotifier'
>    1136 | nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
>         |                      ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1152:15: error: variable 'nvmm_ram_notifier' has initializer but incomplete type
>    1152 | static struct RAMBlockNotifier nvmm_ram_notifier = {
>         |               ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:6: error: 'struct RAMBlockNotifier' has no member named 'ram_block_added'
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |      ^~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:24: error: 'nvmm_ram_block_added' undeclared here (not in a function)
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |                        ^~~~~~~~~~~~~~~~~~~~
> 
> Include the right header to get this fixed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/i386/nvmm/nvmm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Queued via accel-next tree, thanks!

