Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B7C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJxD-0001v0-Rk; Wed, 26 Feb 2025 11:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJwz-0001kv-4O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJww-0006tA-0h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740586072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3wg6ZOCd43MRSnPl1PnnELQdbYFw1kzSUG4St9Z3JEA=;
 b=BE8sVtJxMfvMwBcHbWitEcSGKSo0Cw8/lnHr3MsUBFpuc2HKFxJrqXYjQXyPrJZtuS72O5
 yiV4aRMdZH7s26/P9nhGm9JtxPODZiqW2UHDTM7kgPqvbVcd+WHDAIODGYBkchMZUdzrPN
 tFawq6uA8iCwod5dyInjODG6fxXa3WI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-YaNmaK1HPr67z6PTN2lxLA-1; Wed, 26 Feb 2025 11:07:49 -0500
X-MC-Unique: YaNmaK1HPr67z6PTN2lxLA-1
X-Mimecast-MFC-AGG-ID: YaNmaK1HPr67z6PTN2lxLA_1740586065
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4e47d0b2so3162036f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740586065; x=1741190865;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wg6ZOCd43MRSnPl1PnnELQdbYFw1kzSUG4St9Z3JEA=;
 b=hZEXSq8ow/UBO/mCD14dgs6qFwdWlN1fbEpERJH1J8r/frMwBz2S1vO7JtiYvY5JJh
 oylg9jkRJH9DW/mkF3xHHH9whflCYudLKKM0cD+tOXjKiLhzw15OkCjx7e5KW6UlNuQA
 QELKCkv8YSXXBC10HlsqVIAGbFBP7MiCa2vHLbcNal8VwITSYCDO1JJ3dnQ6t8aQ9CTe
 ob+7EqTzZ7rdbuOa9Wm3gywubHesje5EUa+rn2rl1jNeiOJHU7tEbdYDHlFGTfoX2IC3
 U7aAeOLxyOcoza5R7a3UHa7ViFUTpVm0ViYNkASjhRk2eTm0FG/rvVchlyDE+AEnnWG6
 ak4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV20Uy3wJunpOSYvQe+jTIj4o7Jzc0GKTq8Z4PGoWig8Tb3Ra2YP59JjRqKV8ojROG9LLX5Ftum5Owb@nongnu.org
X-Gm-Message-State: AOJu0Yz68RZKD8luweYWNhwXKQeOZnlHuwi5sCkJjQjjXCpg8VjTzv11
 pgh7mmn6i1LGm13Hu35LspKPx4Lq7P/RZLzZFIGxWUujkQjsviK0YSieXcyLCICeRu9L8q43PDN
 fSnB/Hm8TA/zvZo2fvkNGBpB1zLQui8NjuCEdigdmalaOgna87NnR
X-Gm-Gg: ASbGncszhOk7ts0n8uiZ3qH6QDGydaTLY+1M2OvB64wNBmOlsgoR3DoaQB8XiUGZ/4N
 k7WCgvV7UnhWlc1nWaFVRe241hKZRIMJ6Wk5XT/neuqdjOiu4rFw7VrB8eb0/HFb2JwOWKl0W0e
 JME72AU7oadOyuPOqGH92LUf+C7CZtsd5cryZQ2Vb+oj8txaXtI9HRk3pEkZy7xsAkAwdOBsKaR
 XFCyiaBhphm4h+xBJHw5KRGBPYvpZNXdmCUIpnnDbo1SULc8L3/uD6Qe348cYeb7HftISIY3Jkc
 UHu9QmVZPVujYiCbIxZj0FTeahz29URjeQPAFPpX2oydjYg=
X-Received: by 2002:a05:6000:1103:b0:38f:3d74:9af with SMTP id
 ffacd0b85a97d-390d4f9bfcbmr2751462f8f.45.1740586064990; 
 Wed, 26 Feb 2025 08:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQCdnP93a3ZpjiWr+k9plKWrGyVHH0BoErr+TA4/WYcmYL/H4aT7mjnZAw62/krt5K6TVQ8w==
X-Received: by 2002:a05:6000:1103:b0:38f:3d74:9af with SMTP id
 ffacd0b85a97d-390d4f9bfcbmr2751436f8f.45.1740586064575; 
 Wed, 26 Feb 2025 08:07:44 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390db1aa6c8sm2062307f8f.72.2025.02.26.08.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:07:44 -0800 (PST)
Message-ID: <13ffd935-9b26-4a43-8009-834220b709a1@redhat.com>
Date: Wed, 26 Feb 2025 17:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] tests/functional: skip vulkan tests with nVidia
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-9-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226140343.3907080-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/02/2025 15.03, Alex Bennée wrote:
> While running the new GPU tests it was noted that the proprietary
> nVidia driver barfed when run under the sanitiser:
> 
>    2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
>    EOTF mode SDR and colorimetry mode default.
>    2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
>    profile: stock sRGB color profile
> 
>    and that's the last thing it outputs.
> 
>    The sanitizer reports that when the framework sends the SIGTERM
>    because of the timeout we get a write to a NULL pointer (but
>    interesting not this time in an atexit callback):
> 
>    UndefinedBehaviorSanitizer:DEADLYSIGNAL
>    ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
>    0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
>    T471863)
>    ==471863==The signal is caused by a WRITE memory access.
>    ==471863==Hint: address points to the zero page.
>        #0 0x7a18ceaafe80
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #1 0x7a18ce9e72c0
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #2 0x7a18ce9f11bb
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #3 0x7a18ce6dc9d1
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #4 0x7a18e7d15326 in vrend_renderer_create_fence
>    /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
>        #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
> 
> The #dri-devel channel confirmed:
> 
>    <digetx> stsquad: nv driver is known to not work with venus, don't use
>        it for testing
> 
> So lets skip running the test to avoid known failures.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> ---
> v2
>    - implement block at the test level
> ---
>   tests/functional/test_aarch64_virt_gpu.py | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index 7a8471d1ca..a4ae5777e6 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -9,8 +9,6 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -import logging

That hunk should likely be squashed into patch 1 instead?

With that change:
Reviewed-by: Thomas Huth <thuth@redhat.com>


