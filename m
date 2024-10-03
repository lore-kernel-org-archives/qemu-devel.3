Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51260CF34BB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9L-0006Mx-Ag; Thu, 03 Oct 2024 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9J-0006MH-Mm
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:53:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9H-0003JM-S8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:53:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso823535f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970829; x=1728575629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HggQnz65ToFzLh/DTXAhcvH2OgkXjubRfaW635E+SuI=;
 b=Z+22ON6N68WIMFARq+MdrDygh4yi8DeWE4dzvPt5TvkrAwyRWjyIEX8y9E5/piPHP7
 0hMzk0CgYxmYVyuXj4hYv/8cxCz5xbBsap4DnzrLIaBALfT7SiN0Po3eBasQUxpAE+uC
 w3UgX3go0Qm6D/fuysFVlLhQInyFx69MMRf3wNV//xOYDaojtDrkUM2QZ6PIkY7H5U7+
 Gn8EgHarOFdyaMM68H66oss0iHCr4tgisKKn9pxbLn4Eyj9zP7Z6ZN/5Tw8CJXzgHFJ7
 +SaHGG042aANoijKjwytRPSfru/86boDSa6elHbWRt21ULArt6a6zkL/a3Fh/MOhPV1r
 m+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970829; x=1728575629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HggQnz65ToFzLh/DTXAhcvH2OgkXjubRfaW635E+SuI=;
 b=u+/khf9QhmWQ/7EzSs4xW1UxpVWk6+lvPDAgovxxnyfX0yx6k4AiMYVK1laXlSwK93
 qqoJx1Z2nt1286uKh73AoGjEGUYTxNV8BPAhpoTm5MopCy7DMbTsqQvZCLNXIfC5CaOY
 oRywClGDKU77kuAy6qG0kxfG+Z/09RIwunLtUSuiKL9RvryPPeLzw1ZQ8+eRr3sCdvka
 MgJbrDe1zPq58HHDMc5hvmuWFsSfOAhDJU1ds0l1AQkhp0Y015WQqZZqMgte9UlIW4LZ
 koqwE1lZ3xpVmwqb55K4QBWtZcI+UMrVBLdJEAad4LZV8b9pU4/UiNH3MIu7wg/2GK0u
 luPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx9PH21wFL4GGzBzZmLKRsHOCld5+56qs2bcy5ZzKGVGLvlL4PpyUYGCczbcgyFdULYuYNWOiB8wnt@nongnu.org
X-Gm-Message-State: AOJu0YwORgGItqgt7YRMKLlhKqerR2J4cp5GnxHjst4j/L3gCT8axUch
 y/2TvP6LgeGW1seeTxcHMZmFZFeuIQA/CB/roLW+XYEShHbVtVh1Gyvn5mP9gKY=
X-Google-Smtp-Source: AGHT+IGF9VYbJb4HWC/ipypWkf6sER3jc18mpvJ2jIPHy/ulOQQ9WadQd/xzE6w8AiPxStwKqynrOA==
X-Received: by 2002:a5d:60c2:0:b0:37c:d4e8:2c6a with SMTP id
 ffacd0b85a97d-37cfba11d8dmr3750276f8f.51.1727970829544; 
 Thu, 03 Oct 2024 08:53:49 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:53:48 -0700 (PDT)
Message-ID: <9fed2cdf-a96a-4d5a-a529-62388124d1fa@linaro.org>
Date: Thu, 3 Oct 2024 17:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/adc: Remove MAX111X device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
 <20241003140010.1653808-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003140010.1653808-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> The MAX111X ADC device was used only by the XScale-based
> Zaurus machine types. Now they have all been removed, we can
> drop this device model too.
> 
> Because this device is an SSI device, in theory it could be created
> by users on the command line for boards with a different SSI
> controller, but we don't believe users are doing this -- it would be
> impossible on the command line to connect up the GPIO inputs which
> correspond to ADC inputs, or the GPIO output which is an interrupt
> line.  The only example a web search produces for "device max1111" or
> "device max1110" is our own bug report
>    https://gitlab.com/qemu-project/qemu/-/issues/2228
> where it's used as an example of a bogus command that causes an
> assertion in an aspeed machine type that wasn't expecting anything
> other than flash devices on its SMC bus.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/adc/max111x.h |  56 ----------
>   hw/adc/max111x.c         | 236 ---------------------------------------
>   hw/adc/Kconfig           |   3 -
>   hw/adc/meson.build       |   1 -
>   4 files changed, 296 deletions(-)
>   delete mode 100644 include/hw/adc/max111x.h
>   delete mode 100644 hw/adc/max111x.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


