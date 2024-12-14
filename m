Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E84BE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 12:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMROC-0005ji-7e; Sat, 14 Dec 2024 07:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRO9-0005cp-7k
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:36:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRO7-0007Em-GF
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:36:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385df53e559so2150068f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734179808; x=1734784608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53J+gHz4GTA7IwX3L1I4JZNGX33N09H4SZFKIYc9atA=;
 b=qiHMxGZ6pYiT9XgP2KiC52bmfG2g1Kw9DUirad1EI/LjBjnhirSyShga44w4M9woYH
 QlAqBBvtNSpQIJZvpUolo36IMjk/+eaIbIw0SSLXXmTk6o87KhGLt0xxggF97e/66Ia9
 1PWDDyezOz6GyXm80SJ1lsiPm+D2O558hc88quubU5Hoauqyj8kfRBuIHoGbx9ADixdq
 CVYGEBj1jHu5uMYQafbVYW91wNKUswCQuvtd6SqtYumC+MpyWqadVROvORQj+rc1NRS2
 exrUwWfKa+4ouTguk14ThadtAUaD4fb2PWTn/wX2C0TM1Eb9La9NLztGYtUqTw8OpQet
 Arhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734179808; x=1734784608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53J+gHz4GTA7IwX3L1I4JZNGX33N09H4SZFKIYc9atA=;
 b=ETodi0etaNRVkdU7uUX0yY3LPNnKn8bnuleYw2k/k2RmavuJcjt2v+Hv6jGP1lse15
 Rg524gi8C+U79gL0hSAODQxc25/IRWeub1Bpst3OTnGt9st2tGhgWPliwQ/L/wdFw8P/
 O8QWKFbI6lpRzlDRoUQXukc2bBFrRR9BXgKdiqlFlU5RAYiOB9v+hK7I+7boz1MGaVfh
 LF5KKcdekW3Gyp9b91R38Mx5sw7LNNc3t6Q4tw+0kkObkcQT4ZmQidNLulvwHepNum1H
 ZVudAVe72pFIw88uq6QBVidRxbuDZ9/lGEk+upjcAgH9ICZv+oXR6Qd4wVMu0RTuHJci
 DU2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgCfPssSwlPVxRLDiOU8l9E74i9ztYjyMutFjM28A9E1NVdR8godxhD0TGsdiEQBPEi3ssDQ5+AKn3@nongnu.org
X-Gm-Message-State: AOJu0YwgRzCBIDOu2vJCgND6Y2oE69ZcdHcKU/+hWobmwOTfOsr41n1y
 8uKeVKf6sY60tmxJnvwc0L1990YiwqMBWBQUnCTRYsxVLBSV6jR+fqAZH7/r0t8dTLK9UKM/vhT
 rLgE=
X-Gm-Gg: ASbGncvW6jzzDjMbWgEFxuQrsO1J41OImdiL1LtuQpYICh2uCS9e6KBT3/0QTBmtl0E
 Y8ukJByTcWbXxyHpQk5GcTTyGrt0e6CrqZuTYKo0M2F0+kQD7yclTZqvXsUWREVAjhMBk1gek1y
 Hm3HBsD0hz8oJnxF1DmBjb2spBjvjtxiEVbdgUcs2NsJqNof7YrjNgJQ2Ah7LX3P194UK05YEHT
 MdkFvdBQORHFvZm77ckOn2qox5tiC0NEKzxA0LtyhCqP0E1zU1xrq9u4o5GS2fo+XjQziuzJNzl
 CIF2xB8PnlOrCBevZBierZbIsoX8mq8NNmp9UhaFdkBQ+Q==
X-Google-Smtp-Source: AGHT+IEziDnw0qpojWcbkICQtOFFd9b3H2QJ+CqWMXSyjFvRYq96ZtUd9HwKhhnDsawqFL4KBymnbA==
X-Received: by 2002:a05:6000:2a6:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-3888e0f4763mr4367897f8f.36.1734179808288; 
 Sat, 14 Dec 2024 04:36:48 -0800 (PST)
Received: from [192.168.224.213] (196.red-95-127-57.dynamicip.rima-tde.net.
 [95.127.57.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a87esm2449768f8f.59.2024.12.14.04.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 04:36:47 -0800 (PST)
Message-ID: <f97c1cd6-32ee-4735-ae5c-0bb55e505c6b@linaro.org>
Date: Sat, 14 Dec 2024 13:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k/next-cube: Disable the default CD-ROM drive
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20241214091720.49779-1-huth@tuxfamily.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241214091720.49779-1-huth@tuxfamily.org>
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

On 14/12/24 10:17, Thomas Huth wrote:
> The NeXT-Cube does not have a CD-ROM drive by default, and the
> kernel does not seem to deal with the empty drive very well, so
> let's disable the CD-ROM drive for this machine.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index f576452fc3..de7ce13762 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -1052,6 +1052,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = RAM_SIZE;
>       mc->default_ram_id = "next.ram";
>       mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
> +    mc->no_cdrom = true;
>   }

Sigh.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


