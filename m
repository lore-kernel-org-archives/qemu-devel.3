Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237EACD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2tm-0006y4-2X; Wed, 13 May 2026 02:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2ti-0006wX-AC
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:16:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2tg-0005xy-5W
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:16:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so42854945e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778653002; x=1779257802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pozfXMLSvLP4umIlRJc+151bbBsBlEzaqarZZEar4zI=;
 b=Dk5wKQ0nYRi+YW1kEMy77pkpt/1lCBAPo06YZSi6F/4dxdeTDlbnpjKcaxb8hQTJNh
 1SGCoJfwS5gryyPzXwEvAROBNLC/ph+cSKjTp29Uj0Xnm1S/VCFuCteImWhMh3iP4hX0
 Ps68A8eNhiwhy9pfNnuaIYL0BgcQZj0EBcND4pGpgyszreZy6q83e1/xl0A43afmTXod
 St6rBjdy7lretONE1bZUxs6PlXYkhRNw2j7N4J+0+kWVzYFpnZr1FDZZXV5O1+JAFgNk
 1CvU4BZ5WOOUlyiM8kth3wvD3IXf3NBYbR4iOv+Lwifo32JEbvQ4JI0QKTzpvaZcyS7c
 2Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778653002; x=1779257802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pozfXMLSvLP4umIlRJc+151bbBsBlEzaqarZZEar4zI=;
 b=GxlB8lOLhKk729YfHTGuNxDB4CgDFR+leH8tIVbD5161Ra2PCg9gaAMNMv/G+PlaYO
 DzQ+jYM+qT9oCD2xEix/B/YuJZp3TzhYNGgFxpzAZ8ItF+1hQSHO5fb6CmnOFik+sCs1
 EjfbV8ru/fQVtyek0hKWgVcJMzcePCxNMz4UKpokjUcAB4P3FaiNg6u3qH2XHSmPA/uU
 UWIsetFmAfCF6MuYNrf5MUlCGra4sOmUdQWVMirbw24GWivYZe803EQ1bQtoSGP86r7o
 SWGaovOF4LSdMtP42yrzXlG5ZIWF5pKNtumFbxZfgE+uP2tivBhtMGZ6UtwBDSCBTDE8
 KauA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kTPkkKS7l8+Ql32rM0SRIaBL2fkFo6WOEF8gSxwv9LL3FxXeNzP3FU4EWBQYVZf07OH4XLjD0YedD@nongnu.org
X-Gm-Message-State: AOJu0YzluGb8VRsaSZoVYZ4eudcTJA6/tC9SipB/XT/TQ2ja2hsClkR9
 YME9OjU4O7wPeNV1evMLU0ioH7f/uNAppBwrtUnSoFOb5Vu56/Z/zvR8eIqgoyXZ0gQ=
X-Gm-Gg: Acq92OGJR+v3l6ysE5JMFxDMrYXalRcyGGew7uqkf5Nor0Ie20HyXtQEsB9kUNLQ7FF
 F4NHkaQmOauTRy9NAeEQskkABrkeE6flp4y/LqhScw5AOlhDEQvyYW+AhZLXiU+tkzZ+vrYOZGC
 F4pK0r0b1DqLfzGBALhfENtSBqs7s7b8IcEyQuXkzPR2yPjAU2US7KcYG82cd1TApyXEhr91Imy
 sFjRZ6Io4OoxOCEbpCcWqyYv7lZQsvZVegecWF9rm+nmV7mAY2znYkOjm+YKJTio2iYR3rnmIp0
 sBUXm6Tt7pAofK+UovM4Rp2vdE1scUyPdu5CpiABo7+oWAy/vM3k/yiUNEVyHEVcbdH0AeqHtIn
 1gJDwQGleTVPcWnj/zWyQB9OjpvKPEZoZFZz+w7WN9EFHO3pWVPWRQI+TbqluzEKXAuPZVSn3vH
 i6qlcMZdQAHiB5+5SrEG7+WMzldoOsSnquTxcjCP8EG8NJlFpxfLyphTRcY81GgbCNAA==
X-Received: by 2002:a05:600c:8590:b0:48e:635a:18c3 with SMTP id
 5b1f17b1804b1-48fc9916ed0mr17219615e9.4.1778653002234; 
 Tue, 12 May 2026 23:16:42 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fcdf63f05sm27121305e9.1.2026.05.12.23.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 23:16:41 -0700 (PDT)
Message-ID: <712c5b65-43f7-4db4-a7ec-6bac8983ca91@linaro.org>
Date: Wed, 13 May 2026 08:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] qom: add trace events for object/property
 lifecycle
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
 <20260512122958.788097-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512122958.788097-2-berrange@redhat.com>
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

On 12/5/26 14:29, Daniel P. Berrangé wrote:
> This adds tracing around object allocation & finalization, the addition &
> deletion of properties, and the addition & deletion of children.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qom/object.c     | 34 +++++++++++++++++++++++++++-------
>   qom/trace-events | 12 ++++++++++--
>   2 files changed, 37 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

