Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70561C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9M9-0003tl-3f; Mon, 03 Jun 2024 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9M7-0003tc-59
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:12:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9M5-0004eO-NU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:12:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a68bf84d747so213234166b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717427532; x=1718032332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJTnu+2WLNzpxM8IQO3KBrYbT8thwVeyVSBd9MOjLwk=;
 b=yihnvRFvB2gWRHzkAi9pcoA9dbJMXH1Y2KjCXDm8xX4xKMd22Hioi9s5+wHrKnxm77
 NWU5eCIa8HmlpZGtoBgqWNTYlACCYGEr5otOu59SrO+JjasMx3J4vOS26zn9qEVfh4r8
 1+dg9TlNNtsmMKPQGVWu1mQQjCeyNgYDl6Eb/CclNc5CLzfeKYvJhv/0Ve6irqbLKj55
 YfXi0DWRq01XnHkg1mbHi8P4GKZRHXUWq66aNcBDPV7qxUgQw00xMjI06SbZKMzxaBR9
 pmRxxfrR8FDSQCT84ZTWsv7CUPIr37xFlZwmqGYmv4kpnuiErzNrQmWGs0HpQAaLqTMl
 DjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427532; x=1718032332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJTnu+2WLNzpxM8IQO3KBrYbT8thwVeyVSBd9MOjLwk=;
 b=U4ICeHaYqxy90n/uvFdK94B/gyk9Har1KG/V2rfKomnvm7/jG28gwQEUHDwhJxTe9K
 lXfqDHFaC/Rc6XVWhc/O7A1qpTaqIZ267jFyKwaciRW3rHbyjq8MB7Eba18hexdzgFhP
 qKvq0oRx04yWsy/q3Ye02d17s5EJfJRiXZweibV5hm3zBdAtfMYDZfbSNZbs52fc6hyc
 4vESJO0ZpVYKxl4JwtBh2Yp92NJyYzZ+yeU67ZH4CnwFkgbyQMiO60JVieuyqOHIKnZ8
 aVof503ysUtnOMoKrNR3aTCbYjaMCoUduaq7LRh1ttZHyOZE3f68OLOeghPkkxZ+RVSx
 o0ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqLwtVrxPTBKVAE7E3EVaec4ejcGEFkKJCZoiiqrW5vZuWNvMaSOqmfZ5fuhz6bUBDmhGPDp4yEE+P9A18hJeyai7KNU8=
X-Gm-Message-State: AOJu0YywK4I8kDA334c1t1HpiY4oVAAgZ/RWc1sicZZAOqQaUE6ChxZW
 s4NbZOCXiBXDzxzlXnB2IUoKW59pVq4wH40dq71NnVZZAcbiCF6BFvYBG7IyVak=
X-Google-Smtp-Source: AGHT+IFMHfxDJN2aiox9hGsOoCnyp/xRzkT1zH7H+p9ZlV4Vkg/f6GYNnB2f7B39iMrgzXh+MFYE5A==
X-Received: by 2002:a17:906:b044:b0:a63:cb4e:9a10 with SMTP id
 a640c23a62f3a-a6822049c19mr558040366b.77.1717427531781; 
 Mon, 03 Jun 2024 08:12:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b66c0c87sm361942266b.73.2024.06.03.08.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:12:11 -0700 (PDT)
Message-ID: <9e39ddbd-6075-4d1d-af0f-a12d982e9559@linaro.org>
Date: Mon, 3 Jun 2024 17:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] usb: add config options for the hub and hid devices
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-3-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530112718.1752905-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/5/24 13:27, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/Kconfig     | 10 ++++++++++
>   hw/usb/meson.build |  4 ++--
>   2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


