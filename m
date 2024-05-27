Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F87C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBX4e-0007ID-IQ; Mon, 27 May 2024 05:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX4R-00079D-3V
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:55:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX4A-0008Vt-MB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:55:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42108822e3cso15333585e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716803693; x=1717408493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E3dSc3yfYv/r+d4wN3BGfw+S9Y3dPGG6wtoFQR1sb/w=;
 b=YcR8227M38uV/qi7+GT5eCsMf/mlHioR82oWWtSL7FU0K2L5RxAWYfVZ4bq+IUkAxt
 YDN4LHBF6m6xrkyj4ZrEXDKFJMO9NSmr/0WoEi/85mdWRXQt+n2cRuQCk4KSmiapxXJw
 Id9FbZXNA9vcjKY49efQ4w676QSmRlTQD3DZNP3UJcwtyPaQvnmSVlB+Z+hyZq9MZEKG
 /M2fdUhL6awnwzeQQaryeSGALohIfXvPWO3IgdQmG+zg9kpELXzyLpVmC6fC0vqJJmGl
 iCz7RvIjCl17k1nRdM8KIbxo0WYuAz0rvjUEfy3SvB2liUYMPzdteLE6BqOmcrraYL0T
 YG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716803693; x=1717408493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E3dSc3yfYv/r+d4wN3BGfw+S9Y3dPGG6wtoFQR1sb/w=;
 b=P2+Y27GYAbDF7DQ/SqPpswnQMp3OIaSc1JxmA8NBh3Jenx67ab1DSEc/182+FXUr17
 gj63NUTFVdfp1lyzVZ/7dOGjDwHqaA0H/CFyHvf9kHm+IYND0LNZ7Syp9zW2wghEWQjX
 anLhaCVTH1Ic/kn1Y3tg4JQ6pVbL9zQ5n/XkbFFQHYU9WD7VoxMZBEGAha76EPugr6/1
 IHZXIaRaM/SJdYJgOiGJ9Stw1R7x+nE4sGQ6+4Tg7DCMl9TYUxTzse6Oisvvxaq9l0Pu
 yrNCsbp8d8yFl0IFLW8PIdMR0f5cZFAaI9OPk5iKmRTB0F2L/KUv1vOZBM8bWztAltzO
 R3Ag==
X-Gm-Message-State: AOJu0YxqmusAS+OuJkGCma0Y9JmzAP9V/UMhoxQ8ZeVUUBkIb+cPCHzv
 QZcmIqjRqKaOUhUavMeTuwu4f0VC3RtoxhHvv2Hj3e8nVdtczvNJTu9FmuBkPbU=
X-Google-Smtp-Source: AGHT+IHZZqJuTtU8NkYtawvQRFPq+AGB5/vYdZMEJU6Ir6pg+NRAhHfgKkI62X78BYIUSv1zDUAo3w==
X-Received: by 2002:a05:600c:4fd2:b0:418:3d59:c13a with SMTP id
 5b1f17b1804b1-421015b3ca3mr107433235e9.9.1716803692816; 
 Mon, 27 May 2024 02:54:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089ccb10sm103677425e9.44.2024.05.27.02.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:54:52 -0700 (PDT)
Message-ID: <df2abc64-9cff-44fb-876e-11a1711ecf4c@linaro.org>
Date: Mon, 27 May 2024 11:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] qemu-keymap: Make references to allocations static
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
 <20240524-xkb-v4-1-2de564e5c859@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524-xkb-v4-1-2de564e5c859@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/5/24 07:35, Akihiko Odaki wrote:
> LeakSanitizer complains about allocations whose references are held
> only by automatic variables. It is possible to free them to suppress
> the complaints, but it is a chore to make sure they are freed in all
> exit paths so make them static instead.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   qemu-keymap.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


