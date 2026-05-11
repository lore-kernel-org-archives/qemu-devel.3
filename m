Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAAACD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUmB-0003Gl-Vq; Mon, 11 May 2026 13:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUlr-0003DD-9n
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:50:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUln-0000e0-84
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:50:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso4003475f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778521815; x=1779126615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qH5CrdmSSHWrDn0WfT5mmIPW617z53HpM9rfXtkfd3U=;
 b=H8C6QRq0D0xqsX/ZcqfW4WH4lgKWJhhZm+dRk8KkoatGpfmJ5kq+UuVVoLth68iuah
 dZK5BqDmjJCTM9U6FaiGYIyp+t0Us2Ll4niFvHOCRtma2UKlgRwHa+h3Eej6zRKC2sJZ
 ZIkyOXc/XdwH56XEvpaZk8JLGure2RA2iwqKICeXXTFQxlc7LqiU/3I8ygXaxTRz9y50
 dWpRMd0x8VlyUt0dDIW11qlXd0xObhrSHBNK85+ksMblW3neGfPtI3tVUrPnaqwqoYoa
 s5KYOzl3BCppLL9mSYjA9HzkhqgaHWmVTeb1tYCMpPmxLFzfkVprhWS4xYsp+1+CN1bZ
 rSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521815; x=1779126615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qH5CrdmSSHWrDn0WfT5mmIPW617z53HpM9rfXtkfd3U=;
 b=XzZuHf2Hl3uJCFVwoZxbXzzwzNXcGNP9mLrnRq+293s5cD+UwDkPINU0pLVIk0hceB
 y9WDY5ZRQ8xZFzXzBc80zLEQmPGFUie5huNWphrmyhh2y5TxcjdXlbPk1tgtNPWP/vQW
 8ggAITTznM4p7Ze+W6GEK5Xb8GR4s0QNWiisjTVcPYN7yuQt/+ayJ51zfiUkfag5eXZa
 ilZwGBxLi4Fr20rhhCA2GwSOjihJKF1OSKL1qNYRCv4zmAAKk4A0UPyrvgal9nzAUk6T
 jc9Y9gqeV9G5GZe5bSkjjAlVudmdteVbfaeeuEP8snTaC6Nob0k0Mjy7qn3CMHV9S909
 SK5Q==
X-Gm-Message-State: AOJu0Yy92F1s7+MIe+uPJhYMgP07WzIdvgfWrj71w/DktsQZkPVX3Gcu
 BAjhudatjEZSVdgawdK1kgJqJND63kCMe7POAbQlCopVyG7RXQ4S2+E5R0OFnQi7twU=
X-Gm-Gg: Acq92OEM7nPQR2lg3vNEzUlQ2MvemlnuXTYj3iQzkWmNp54zatfYmMPrjn83OaXrh42
 7DPhdqNi7iVjeM27k0kaLBH3f0CjR7SeW12ryfzPM9Y0jh9T1YHE9NJHKqxbs0hnYIecYfr3hDx
 dm9p6PX49DKoOaqhxMIk6fhfreTElkUw9IN/zPx0527mKR0AgQgqBcZxTIXULBjj5Ac6x+7clrq
 zB0BOqmY1f/KOYWVXUNwB2sM4eewRIzWTDcYIrmwRLdJdFvnbLTay5JUAbycoHTlPCgWfFEzODr
 dsmXQXcfSsa9A56ESttgzE1zsuI+g+WULSjUzUS9/agnbi4IPvLp46tMXpio2QskatOoWmv+BhX
 2jvbM7EI+CwTOO1XZQtZQiBa1w0eKNarmoZri6itdDJO/jZ6f25TXB1K/H1FcQJCQhDQDFCaMMg
 M+YCWLpuK1UmuhIYmzcSW59qA9IYuBw7OBIZh20aRUsos4EYPsgXgr52Fq4pMw2aN/EA==
X-Received: by 2002:a05:6000:1847:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-456974835dfmr16228640f8f.17.1778521815134; 
 Mon, 11 May 2026 10:50:15 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549130549bsm27374886f8f.18.2026.05.11.10.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 10:50:14 -0700 (PDT)
Message-ID: <cc8a5b98-45d3-40b6-83f7-32cbb9eaab3b@linaro.org>
Date: Mon, 11 May 2026 19:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: restore cpu_models for system builds
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260511163541.192533-1-farman@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/5/26 18:35, Eric Farman wrote:
> Commit 0b83acf2f05 stated:
> 
>      Introduce a source set common to system / user. Start it
>      with the files built in both sets: 'cpu_models_user.c'
>      and 'gdbstub.c' No logical change intended.
> 
> Except that's not true:
> 
>      git show 0b83acf2f0 | grep cpu_models
>          with the files built in both sets: 'cpu_models_user.c'
>      +  'cpu_models_user.c',
>      -  'cpu_models_system.c',
>      -  'cpu_models_user.c',
> 
> Restore the s390x_user_ss section, move "cpu_models_user.c" back
> into it, and re-add "cpu_models_system.c" to the common_system
> section.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   target/s390x/meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

