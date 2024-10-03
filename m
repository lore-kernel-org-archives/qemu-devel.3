Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDC2CF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9Q-0006Nr-O7; Thu, 03 Oct 2024 11:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9P-0006Nc-Sj
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:53:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9O-0003Kb-HE
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:53:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so10614535e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970837; x=1728575637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APlSNHRKvXFou5Ts1BnGZEWqHMevuN/wl68E4bPbLxg=;
 b=b7kXIzPdvh25Y+UlcBJYNlfbjSMjEoccoTICB8cuSgbr73XWpmMcpWeA+nAI74VZj0
 Y4dyXch31+INx56Lkjee4Z8S6+hlQ2c+lgiaYPLXTiIIX7Z9FLi+8LwDYu3jkv9/CrPv
 +awMQIuWTt1Qlro7lYFX50mWQ98S5aLGSewLbq1SlTQ6YDQG1mnZLel+UNlIZgMTNPKz
 bKl5fsab+AAfAYqEs36Rq6D9DKvXplKLDiar2nCkrjw54nzLIKztHNs5JCbpLzDL7plh
 OWJDHRaVR987csa1quRkQ/Wk/jJ/To62je9ZhbEzQikG8Urgzlm8QMzFa5ITS9pMY9fb
 dG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970837; x=1728575637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APlSNHRKvXFou5Ts1BnGZEWqHMevuN/wl68E4bPbLxg=;
 b=tXM2fYDd9Xtd99c4/guKdY8mZkwJViEbkxNh6weYuzc45xcEe7Hrhghd2GDgw7IuU+
 1XyBzTG4rkLxyFZvHZWFMhzRcR6szQ+XiJHWr0MkHhUuobgKSV+PNk0L9YxBi/tiAXL/
 SSC7ir9l/qdZmCIbhVchKJvimeBpovxiJM/4fyTo+CUdrYh84DrHMkklQ2rulxLiTJwW
 TyKWtJXjH7gRfdfPSGwIK5sp8+gUGYvSnfeMLl1JkmdvVfW7Aj4321MwF+6cMxEffPKr
 0WuGlCw1wLzIk0opVyZsXRzsN62RskyhQiWUVaOdDBWFlhpvKUQedB92Ox/1XEcjQST4
 KJiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzZ8SI4JN76+dO/UnzNodo5qFrSb7iV24V2SZxfBfwHmlKYSbFXtHQODR1oijxi3xgdGKOgI/UOkWy@nongnu.org
X-Gm-Message-State: AOJu0Yze9/J2Q2eOuZyVOgY9ooBuOtAXiXt0Jsgcp57/E96sOBGCkdF+
 tcnbY/MhO0bKFYILye+PndvvfnQXQpESDIwtQLJbxmqmZikSXdwdbm0HKgO2RnQ=
X-Google-Smtp-Source: AGHT+IFm9fwrB70dfmY18JwpB1Mw73cspHDbO/fXYVmlURKlfHczwwapYNSyximSrbazv2coudq34g==
X-Received: by 2002:a5d:5341:0:b0:37c:cd59:5a6b with SMTP id
 ffacd0b85a97d-37cfb8cb7b9mr4845866f8f.27.1727970836707; 
 Thu, 03 Oct 2024 08:53:56 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:53:56 -0700 (PDT)
Message-ID: <eaebae31-7e4d-478a-a064-dbbeb7943355@linaro.org>
Date: Thu, 3 Oct 2024 17:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/gpio: Remove MAX7310 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
 <20241003140010.1653808-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003140010.1653808-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/10/24 16:00, Peter Maydell wrote:
> The MAX7310 GPIO controller was used only by the XScale-based Zaurus
> machine types.  Now they have been removed we can remove this device
> model as well.
> 
> Because this device is an I2C device, in theory it could be created
> by users on the command line for boards with a different I2c
> controller, but we don't believe users are doing this -- it would be
> impossible on the command line to connect up the GPIO inputs/outputs.
> The only example a web search produces for "device max7310" is a user
> trying to create this because they didn't realize that there was no
> way to manipulate the GPIO lines.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/gpio/max7310.c   | 217 --------------------------------------------
>   hw/gpio/Kconfig     |   4 -
>   hw/gpio/meson.build |   1 -
>   3 files changed, 222 deletions(-)
>   delete mode 100644 hw/gpio/max7310.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


