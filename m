Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11C01061B24
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Khv-0002VD-9G; Mon, 30 Mar 2026 18:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Kho-0002Sh-Rr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:03:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Khl-0002QV-D3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:03:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so41847045e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774908208; x=1775513008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vt05lAnyLjXRvX1IXvgqr1r0NUqr0NThbYDX1DCl8oU=;
 b=YsuswK/JDhThs6PANEkWg8hsxdfjEC76UJKi9uq5aRXUYdDmVTQwhop3JTx02C4WiC
 NDy1PBayjPyDg+5PeK21nwa6VzPIz8kU6Fk+9s0peE1pFSEC8mNC02TSMZ9wra7BpgKb
 REgA7Fm9R8j2XxnEU7VaBXdh6e6VmAERIWQzeZukLSCLWu5stvMNtnjZVtrb3+MkXd58
 D4S8UegMiUVDpLRhB1IY5ekzV0JmKwTK+u/z4bvodpmMLXNVk2aJNUcXG8CVZviL8Uqg
 P0q+JRaaX8AHBhrIaRPDBYURcImTuxdVFh4zrCnAlkH/dSauzbckOP5ePQeB6D5BXaBW
 sEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774908208; x=1775513008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vt05lAnyLjXRvX1IXvgqr1r0NUqr0NThbYDX1DCl8oU=;
 b=Ti26khXDSOqKHRGiObB3arEFrXiOlrjFYxtIzpIgzUn+BfN5RJKgOPdPeC6aNhQjHX
 XhCdrit4kD3SXHRGUHauT7ADOr7PFp9uJ42jovZ1QOPksMAyNuco+RHZYB3yTMEUyKP4
 jDigXJGG4V+S+p9LCcEGjxtBIA96AJiDEFQ4Y3hrLYxWBFHgL3LaGKigduJSPN7A1s9U
 lwyGgpAihK/4Ec8hz8nSvSnd5BOjULzkZGziostysTghgv2WM0LF2f7bTmCvRhYyZK+u
 xppHda7NDI9tkDFxFiWo5Kar3WtQ/JxShql/YWhdgsiPaBi5j5QRBSHoixzzz5kQCjbJ
 slPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXup+BP5WMABLKA6o2QEGLLAoS8V1xgy6umhA5xJpsOlzjmHu/cyWs7n8kcMhjp0JfHPCE2wwQL5y8N@nongnu.org
X-Gm-Message-State: AOJu0Yw8VWYZHVTdeVwfoPasQq/CQ7l5BDTuGi2tq5Llks+o7xravxr7
 5G5cCv8fNkFvy4nQUxbNiHPK8f0amRJKGEifP1k6YuHxyQEG61A83MlpJds/vILg1NY=
X-Gm-Gg: ATEYQzzaZ+exCkbkmlFGm0v8s28F6GooBgaDFmJemyfch/t36F16NPSScpjHD+/Z7U3
 JhmEf0cpSTnhWzTbyp73kfXmDU7Qv2uSkIBcYVL+ZFKkiUFeulb40Wg+xkuxaLD8YbPpkCBFtZ/
 8LsGk92QhkMDdkJ6rvFr7DLXTXWcTsrciAAuEK2IIs2BeWHI0DH+QyCh2FN2PqSC0oaIkIs8FI7
 eZQsVicHR7roslzivVK7CY9Hmv6+Dn8RcOsnyXWRa3R4vQCNOwBfhTnJDnMSOr2biXN/OdFaMO1
 Z/OvSRr3fBiI6jVcbl/ZrmH6hNiBUj5S+0SJPlf1VSF/bVd0aZo9afhGI2nwElJByTVkEZWxYik
 YBi9KUNhDjYpmbRxMO7QGtD1aghgClHBDjpMpFSMrYCxCclARSYOL/4XLeT4GUs0fNitjvHRdrN
 P0pi4pliWRyApMGOU1uYFTfFJH0QVujrKkv25ZvPBuC1PYfzreKTBq4xDqJyXt
X-Received: by 2002:a05:600c:3b95:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48727d59448mr221959575e9.4.1774908207671; 
 Mon, 30 Mar 2026 15:03:27 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887ad9bac6sm3184845e9.4.2026.03.30.15.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 15:03:26 -0700 (PDT)
Message-ID: <bf16eeaa-d6d9-4bd8-a05b-08a0e3459a3a@linaro.org>
Date: Tue, 31 Mar 2026 00:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VGA default endianness
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260326154850.301609-1-thuth@redhat.com>
 <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 29/3/26 21:07, BALATON Zoltan wrote:
> On Thu, 26 Mar 2026, Thomas Huth wrote:
>> In the long run, we would like to get rid of the code that allows to
> 
> Not related to this patch but there's another hack in vga that might be 
> good to get rid of similarly. At hw/display/vga.c:2263 it says:
> 
>      /*
>       * Set default fb endian based on target, could probably be turned
>       * into a device attribute set by the machine/platform to remove
>       * all target endian dependencies from this file.
>       */
>      s->default_endian_fb = target_big_endian();
>      s->big_endian_fb = s->default_endian_fb;
> 
> I think this does not make much sense as VGA is little endian but since 
> this hack is there since forever just changing it may break some guests. 
> I've tried that changing the default_endian_fb to false at least breaks 
> OpenBIOS and its QEMU VGA NDRV for MacOS. So at least those might need 
> some backward compatibility property until they are fixed. I don't know 
> what else could it break but maybe it would be a good opportunity to 
> change it with new machine types with a property that could also be set 
> by users if something breaks just to find out what might need fixing and 
> eventually be able to remove it.

On the Jazz machine there is a bus bridge chipset handling such
endianness conversion, but we don't model it. I suppose something
similar is used on those machines, and the VGA chipset behind the
bridge is indeed a pure little endian one. Mostly because it is
cheaper for manufacturer to use that setup than synthetize a big
endian VGA chipset.

