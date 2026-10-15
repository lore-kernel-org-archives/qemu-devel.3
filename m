Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63034CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEUR-0004ma-Jn; Thu, 15 Oct 2026 01:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEU5-0004Hd-Vu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:35 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEU3-0003My-On
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:33 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-483a66818edso635661fac.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792043909; x=1792648709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LHpYbf2Ey7JnZWiwataVOMF8xEVxbSopMyvNEjL4Ptg=;
 b=cOmQynGfxSMdA7vAa7KCn1GeDBlCBZZWOYQ9e4tiPC7ZKMmE0JDfJ9s94YusOakhKW
 6XKZwa4jtIFd2ClLevlzPkXOz3rROLOSMxtbN9YNzYQ/pfKIJxURIIwyorXLaLP+yj4I
 2SXt/xccDYjCxxF7TgPPNJJCKkN+eM3zir6usyCv7nBOXRlmycvubrI0mE/uxVboLIx5
 +TF2vjBNrhTpKfohEPXFmwY9WXjpAoZnUF81EiKLYx+EdsVhiLC0YClJwCGPcdLQetx9
 aVwTAgGq0IuYbob+zF+D6KTnskXlBlaXWCBun8kl5ooqa0qEdO+Svras5HrxfikPyfzW
 Vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792043909; x=1792648709;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LHpYbf2Ey7JnZWiwataVOMF8xEVxbSopMyvNEjL4Ptg=;
 b=Tp3g3WfCFM1+4RkcQT1qPvOT5FiIMXg69TGoAuhgnl9dHQJtsw/I1GA2ryxIaqP6mI
 83EebN1sC+9FN28dQt3itUcytma92IDoTsjC87COLj4iNQ2h3F6xtAHmA1hePtWFbQOl
 EJ6ehghr25AHEhJGGyCG0X6VQSE0ADSvyuo5r8E9e/e739YRBU+uNQO9eE2hCfoC3Qfw
 9f2xi7WxsCmthsQOKVtzmD6UiE5IRmRYFKCkBooMMCvhzivdhSJ1kl77rFsNEhbjy4pR
 q+V3jnu6H1u98hZ6SL5rj17jITllQBRyA4DzvxHlJIrPbOku2HLyztHl4kjjHpcrIZFE
 2dZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw33gK4U86F7uwEIjAQ2XXXdbya/en4tNd7FQAOXtgOZLIc0vzR4lSvIfBASlIBr+W6uFZpFcX9l7F/@nongnu.org
X-Gm-Message-State: AFq9FYK0L6oK3Enfp+/dHhYAh8s4rtDeX1Mlu5of8RKKpy70awvoo+ey
 cQe0P+3S4Wb1kuttnVJY2xl4BB1MjL0uKgdZv71Ren5R7y9tYzN7NenzjbD71nZB/EfSiA6aZdh
 +5jgM2TA=
X-Gm-Gg: AYBFou2jIItVnMqXIG8qZ8W6OTcje9EXu0iZmH2ikJ2FalhYtrmpEmGGZwr8Dg02dDA
 IkUJzUOjTcPozmR33t7yNb33R5W25nXRZM3L/YMR1/vk2TR966ghzoWlfHlLXssEfMUihVVxk50
 E3TDQ3Vqa5JU7/m22QqbfVl+HJ31GZpXtMUbxgVSo3xq1PE86AvTYdbJrmVzZht/pgjYK+XxQ56
 j/KEqeyslQ7+ClpuVuCwnoqelPJ8cDCfWZwa8IiVel4qS2XVpZLfL9w+j3HrhzPhtR7aCIR0/uf
 LODXVt414TeEOb4eXSZq4O74sHDMJf4ODwn02Iz+rTpvM0qczraQDw6330QrAd/J0ryFcWLmezP
 kRt6cwAVyCZ0nVepxCs72mZuRZ0gPyMNfEFkneAAbc4xocJ3vnWNzVhCKYBn4BCU8OXZnvEGryL
 KpTvZPmwiNPeb+Rw4uLDLHVvaLTgM3/x2u50fFDHGj/bgBhd7jXygvdmLSgY/Fmg9reRHZUAHOj
 c+8yIJ5HTAunrqBCDnWsGUgMkRl4KP3b+8TSLw=
X-Received: by 2002:a05:6870:e2d5:b0:43b:b245:30ac with SMTP id
 586e51a60fabf-4a2a896abacmr15048800fac.16.1792043909176; 
 Wed, 14 Oct 2026 22:58:29 -0700 (PDT)
Received: from [10.86.151.227] ([172.59.192.11])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a6df881fbfsm3703198fac.2.2026.10.14.22.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 22:58:28 -0700 (PDT)
Message-ID: <5ea71311-daba-4df1-87bb-42639b00b864@linaro.org>
Date: Thu, 15 Oct 2026 07:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] qemu-macppc queue 20261013
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/13/26 21:27, Mark Cave-Ayland wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git tags/qemu-macppc-20261013
> 
> for you to fetch changes up to 32d0ad97a528dd6c667e7f60d62de27328b00247:
> 
>    tests/functional: Boot OpenBSD on mac99 (2026-10-13 06:26:28 +0100)
> 
> ----------------------------------------------------------------
> Fixes to allow OpenBSD to boot on the mac99 machine.

Applied, thanks.

r~

