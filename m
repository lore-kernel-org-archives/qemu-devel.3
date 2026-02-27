Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C003104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6El-0002M2-8h; Fri, 27 Feb 2026 17:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6EV-0002J0-3V
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:22:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6ET-0008JC-KT
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:22:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso33530605e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772230968; x=1772835768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=laQeLrkd2ExBqEl9v8d60lyREPD8T8cRbOsW0WuGe2c=;
 b=alHS3hKSKgTAugdzWRjkY+AF7Q1FvlZX1z/k9L+I4yjTihwpL1DtcsA6fZoavmIojd
 2mXnQoSTxAkJAzm+vZ7dMunIHd6UgXaFPfZPCs5oktqAtrgxZTAD38uvZ7wCPBBeopHB
 2/UxhiLht3y5llFZihwnmwXvWFhwUYpRglmAN5NnrdV50vplNCYAJHcsckKz/UxUXsLG
 64wDPDAqvzZvBJRzSwr+uFx39hP7syglVqVzPFjlOiNqGwl8f6lhNTnqfIIMVNoO/6k3
 gM8Yt691Z5NFVOy7ebzjMuTPUFGw3Z9ABgwcJGa9vjk7Hx7MUVEP26YOUlhyeBhkAv+9
 +q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230968; x=1772835768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=laQeLrkd2ExBqEl9v8d60lyREPD8T8cRbOsW0WuGe2c=;
 b=d7XKjkWGEVoKkljaCw8nlfNmERfJ6egr1uti9sfji3+xqCh54QqSV31efQxijEAtcv
 OdNxZukHnxv3jtQ5kctRZBY7uAxq64YIYBxKkF7j+iGx+RgwAZA/qLODCB8MoJddBFOz
 vIr2S0nBcnPObIA6TxGTSerxIp7117Westzaz29nVSxzmr0EY2H72qYf12gvYqQ2e0XV
 ZsC60d9sbRc66qzPrOQoyCr952c59qHzBxjSej4SeZm3FK5CxqX605ofLSTFBLXHRday
 ojhIa871baea+N8kxn7KdQmA+t77IFjpfTGy7oSxj9MLcVAKerQixVGZiWKXp+qC057t
 Xlkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjAeVw62swgh/1LFUJTpFl5FBHeuQUYyRNwXhhAG74u0iamlwoFnjHG2OisaGkMv9dNtuDyuVjN1dQ@nongnu.org
X-Gm-Message-State: AOJu0Yxn5o6L5xhFRIHaOCI3ZrZ9WwvS/O8lQHgzasC7V76mqcTNvThB
 562Qd/46w2MFrOl0dCJqNj000pp4wQ68ljWBsdP/jXOtwqQvkegHssFHEUkP72A0YRg=
X-Gm-Gg: ATEYQzz9hj5TkCVwr/+zPLq9Z7n1ZnIzQ+AYTIla64OkSfqYOYXDyGh/sCCIb1rQaDv
 imPtTD4eoUwOzKScc5HLMWKkcSELb1UCBllTGKhsrkNhE7A10k24VTNAEEgSz6VLgo16zG5vY78
 VJl4HRxwwVrczQJLsGc2h0qjlzMT8omM7uv77KQ7lZPc0pEtGQVkdqSac9mi2vZzytg6Mh5ecVH
 xGLB2pnxEGdvOn1f/+wPQsQl8HdhPt6JIIIKFmtD6VA21FYnzoxIr4LdynDnd1qv5eXM2QxjzHk
 x+LxkVvT5Bp7F4m2zX9T0Dg9cHDUXa9Yk44XUCEDr+/LQvYCHn8VmsgZAeGNbeCwiNBfti5T2tl
 0g0rGCC2755GAKRGmHZB6GBPrgfMsGJ4zBN6TbmWz382PE9PQAh97X+aYHXZ2+t0MC8IzBmpdHN
 Hd7K/5VPKjmkck8V2zUWSah9nM8PLK61xCpM/zFXS7K43VFWjjCCdmaPC3+YdsCbHc9g==
X-Received: by 2002:a05:600c:c16e:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483c99348c5mr73001995e9.13.1772230967961; 
 Fri, 27 Feb 2026 14:22:47 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm210745335e9.15.2026.02.27.14.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:22:47 -0800 (PST)
Message-ID: <f1131f1f-a884-416e-9209-2de6dc1d167c@linaro.org>
Date: Fri, 27 Feb 2026 23:22:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm/aspeed_gpio: Don't leak string in
 aspeed_gpio_init()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227135736.2280161-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 27/2/26 14:57, Peter Maydell wrote:
> We allocate the string for the GPIO property name, but never free it.
> Use g_autofree to avoid this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/gpio/aspeed_gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

