Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E594ECCF9F5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE2H-0003GJ-HF; Wed, 29 Oct 2025 17:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE1t-0002r3-QJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:48:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE1a-0006pI-Jk
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:48:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso2456055e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774476; x=1762379276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMV4D1zqNPd0U3XrTFgmqX0FeI/ZzqBfVv2ZQim39cg=;
 b=aqwuC8IthqiR6RD9Ph4jAdYeJimU7LaGwEEiHNjSHeobC1W1bdUOSFfrYXM8CZUWVg
 wWwBoHZYGIMb5kOA5D2AjFaJ7XjOXJ6EEBRDbt7Y5+fJfbvcY9HuXQm0L8d9Lg/MZGCv
 r0LhLamn9HGGprA4Hkok5a9iLWMlrF42QuCL+zMmvzG7+VL2E4mElvReuiyy/OHuhxf3
 38wknB43dtNDhrcH/QZe5f1+aFQfzjwzCy6P6JE6Clil8fNa95r77WMjvd5YCmcQKA7i
 pYCTu1poj9zr/pZCrSXAYTkOEkWhSHgatz77MVO3oWtUGK0o13EcgoqO35Su8TmOeH07
 kRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774476; x=1762379276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMV4D1zqNPd0U3XrTFgmqX0FeI/ZzqBfVv2ZQim39cg=;
 b=Z00cd94nU4F0ZEB/pokuhld60rRffhkHel75EeVNZnHWTU+ZzOO7v1idpIDhTd5Oqe
 Z1csVcX/gWw2oKTqDtmrA94MdfAsJfdgBN8S8LmYphI90CefEQ32Fu0Vfzsuyw0YlVcd
 wL8CDsSDMP4Xza2y7sEhg1Y5PYEgYAw9fgzSgBYxfIeEidf1CdjlmpQdxUQVAhQ4YVYx
 /2RkA4GSzVkAL/vvcPEAipUGHbFzooP8v4y4V2OS7b4ZCXxUxa6aUAOlPPqD8dUlST+I
 hTeDDjW3j+c6rRFRQ6VaZHqhmO9UR1z8w55+5OUqXDAJEbVnrNTVPEaBH8/ZGw+Ea9uq
 BBMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjNQbVaR73q+Zig7cmqi+2Hq0xj7PLFVXV12QDr8L5Qvb/uqqTLI1SKC0TUTW1XMKP5ufn4N1dJz6l@nongnu.org
X-Gm-Message-State: AOJu0YwBnd/LuyUmrPIAWhhUDc7Ntl/qUzQhM4mACmEOUndV8H7oDipE
 hY6CoDxJhPMrkBaMztbbzn+yHOFASvT8cbqCZ7oFfoUrdJKK/9AEZJdAw/MuECKL2ZY=
X-Gm-Gg: ASbGncvvKGj/28pIa84aP9V6woICztcNIOcIY9c0Wm+iKDHnn8lLOYrTpFxcXBL4SYE
 XfaxpGSpIgmfxtuVtCnFChMXo6BeP/GpwlyTGZRYGInttPcrda8yG0CxtySwMBwcKAbALM4Cx8x
 0RoWxQSSgN2v+9B2bPex3G8qAPIy3aMSAddzbCXKvcnRjuC9pGDYGcYELAxlgnzHW8QUM490kb0
 BhgF9rCxDFMbGFlUEHvYN7OllNHntbrtW5YNK5Mdd1S+5ZwlgfJzYhYGvrauPBNhMASM1LfIsub
 QrtlpvF+qT1ryvHwBSiGTnCABbTt6oqliPKVRT7NcS2lDv2C3lx9VcNgKK6c1t+XxCadtHt+mXw
 hekkAdryQzFnlQxb4iYsakWuL+cCjs20Bp5RXyWLBIkBTTkY/DNk0KjhYHT3AbKUQSCky0s88Zz
 6ntedSdErYgRW9MsuRLt0uSccQt1UXaAedU13tFX/Bx+U=
X-Google-Smtp-Source: AGHT+IHoCsuNBhAAnlYzS1c1lZuBjLyuSz2j24w4/0gz+umMtU2uOJ6tCuRf0UbPo+zBmyPv4ocKkw==
X-Received: by 2002:a05:600c:3b8c:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-477267bc9e1mr7263985e9.21.1761774476152; 
 Wed, 29 Oct 2025 14:47:56 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5c9dsm29552826f8f.26.2025.10.29.14.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:47:55 -0700 (PDT)
Message-ID: <a6b15e1f-3476-45c7-8451-7dd81adcafa0@linaro.org>
Date: Wed, 29 Oct 2025 22:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/35] audio: use /audiodevs QOM container
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-12-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> audio_cleanup() is already called at exit (similar to chardev)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h |  2 --
>   audio/audio.c     | 38 +++++++++++++-------------------------
>   2 files changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


