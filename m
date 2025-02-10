Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C113C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUO5-0001Hl-Is; Mon, 10 Feb 2025 09:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUO1-0001Gc-Qm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:03:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUNx-0002kf-Bm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:03:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so8420445e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739196217; x=1739801017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54fufbxc7LkWLY3gsqftXZih0oh4axfXg2KzENgF1oo=;
 b=P2fqfghC6knXqtSxtOPh9lvj5VO3QGaxeVUDj0daSpQcE4c7BrhL21KX1T6TIr2gdL
 lfDWaY+JSAyqXL6hdtfxgFdpr3THkuLrrxLyy0/g3JDha7gcuQhrNoo+wR/PojGVClHy
 YAnOalZpG91Cha64IwJdIEVXqnHslQU+ieh1+jI6BDAlv41lfwBP6S+xi98CFpJZ0NnX
 tleFsTW6fRhwFkwr4ExQUvcc8PxGoOv/+zKuMR9cq+W+pnbUAfnwpH1IIV3U+I4N/xvd
 rwD8kZS8wteTwzmsb9Ii3wkDRuqCCaAsJk90CbFv6rvRmMWKASW+u7rqyNDTP4Iv4uvR
 74Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196217; x=1739801017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54fufbxc7LkWLY3gsqftXZih0oh4axfXg2KzENgF1oo=;
 b=ZhV8Ug5yhVOz6TzvG6USM7ZiId2KTbVjguzgE3im3SR1QClkkfxcgo+e8TwXaXSaJ7
 MYWNMon8rfTO9bjVAeB0DcnyFOHMAe4fgS2Koojz5Y5sGxk3GFV9Z+ZOAzPkWYW3F8kJ
 1osJpFN1rEjPjXNTSBqzc0MNocYrkCxobGPNDqs4PtRNk3tVdzSVEHtwEgUuIUHkdI39
 Qc5nc3pIz8oxq7TZ+HqcsymTf6SyBgt0kcM2+JGOQPfUTcGVbILjGhzdlaUs6SII10/d
 xBD6k4sU1pdy/YSDN6t+4ivVkjs9s281meAZOF3zQc05dxiIUjRX+zl5Ce86yy36FATk
 TDIg==
X-Gm-Message-State: AOJu0YxGiTw22i6y2nDhgPW/zA/6EUWsGqb3eYn4vEOgbKM1a1wLjUyd
 SqB3jCUrTdAJJMz8yT9ive4rGHw0RnN843GEFSe5hqM43gX2K/oTYu8ivVBFGZ3vQzKGpzdez8i
 VJLA=
X-Gm-Gg: ASbGncv1qWxrz0kAB84/2w/zR3V75L+IO6nc7E9387qGz12KxwYXqzcAXPa9YfIS218
 Kctv2drcMw1plk1E91WY59ufYdTM3jVNAIXzrs93eFpK3aoFkuJty7243ImFmOF+SdLgUHlwMgt
 t8cMhJB77qrPmVoGI5/l9M3c+5U95OjsWTJE47pHh/fYU/axD6mvjGlUYawAbkubV5VKqSwfkAa
 ebim/ksZvjaqW6MmfUQr9HtC6nlZyzQRhtR5iUOfLVLcv7TJtkO7OepY5GRrge1licnxvQtm52p
 AE4MINOMs2C4hwJYNeGisr1+zQXM8j4BFxfuZEGaXQ2Z+DVy/cZnndr7rUI=
X-Google-Smtp-Source: AGHT+IFDI5iAKPiEdC4yZNr/+SQbo3QKZ1T3kfMWNM/vRzjowTchx4JCU+sOnY2E6kvln6x9huM1BA==
X-Received: by 2002:a05:600c:1e0e:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-43924988870mr103881395e9.8.1739196217423; 
 Mon, 10 Feb 2025 06:03:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd9c48173sm4661490f8f.37.2025.02.10.06.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:03:36 -0800 (PST)
Message-ID: <96b39b3e-1a90-457c-bd8a-40a1b6216c1a@linaro.org>
Date: Mon, 10 Feb 2025 15:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org> <87a5b07u1d.fsf@pond.sub.org>
 <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
 <8734gpj4wn.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8734gpj4wn.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/2/25 13:49, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 5/2/25 08:03, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> MachineClass::auto_create_sdcard is only useful to automatically
>>>> create a SD card, attach a IF_SD block drive to it and plug the
>>>> card onto a SD bus. Only the ARM and RISCV targets use such
>>>> feature:
>>>>
>>>>    $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>>>    hw/arm
>>>>    hw/riscv
>>>>    $
>>>>
>>>> Remove all other uses.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Impact?
>>>
>>> As far as I can tell, this stops creation of the if=sd default drive
>>> these machines don't actually use.  Correct?
>>
>> Yes, since these machines don't expose a SD-bus, the drive can
>> not be attached and always triggers the same error:
>>
>> $ qemu-system-hppa -sd /bin/sh
>> qemu-system-hppa: -sd /bin/sh: machine type does not support
>> if=sd,bus=0,unit=0
> 
> To be precise...
> 
> Before the series, a bunch of machines create an if=sd,index=0 drive by
> default even though they cannot use it.  HMP "info block" shows it:
> 
>      sd0: [not inserted]
>          Removable device: not locked, tray closed
> 
> "By default" means -nodefaults suppresses it.
> 
> After the series, this default drive is gone.
> 
> That is all.
> 
> Correct?

Correct.

> The commit message could be clearer about this.  Perhaps:
> 
>      hw/boards: Do not create unusable default if=sd drives
> 
>      A number of machines create an if=sd drive by default even though
>      they lack an SD bus, and therefore cannot use the drive.
> 
>      This drive is created when the machine sets flag
>      @auto_create_sdcard.
> 
>      Delete that from machines that lack an SD bus.

I reworded as:

     hw/boards: Do not create unusable default if=sd drives

     A number of machines create an if=sd drive by default even though
     they lack an SD bus, and therefore cannot use the drive.

     This drive is created when the machine sets flag
     @auto_create_sdcard.

     See for example running HMP "info block" on the HPPA C3700 machine:

       $ qemu-system-hppa -M C3700 -monitor stdio -S
       (qemu) info block

       floppy0: [not inserted]
           Removable device: not locked, tray closed

       sd0: [not inserted]
           Removable device: not locked, tray closed

       $ qemu-system-hppa -M C3700 -sd /bin/sh
       qemu-system-hppa: -sd /bin/sh: machine type does not support 
if=sd,bus=0,unit=0

     Delete that from machines that lack an SD bus.

     Note, only the ARM and RISCV targets use such feature:

      $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
      hw/arm
      hw/riscv
      $

> Listing the affected machines might be useful.

I'll pass :)

> Worth a mention in the release notes?  I don't know.

I don't think so, since nothing working is lost.

