Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B8E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShdc-000085-2Y; Tue, 31 Dec 2024 14:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShdU-000072-Jw
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:10:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShdS-00007K-Sr
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:10:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283d48so74796495e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735672232; x=1736277032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BeygLn9ykMNOw/BE7vEWDHoaAdOtlNYtI57PhpXYn80=;
 b=mSJBSLNLDWX1HvEPl5PwDy5vdJdIV0KRNpb/B+4dPDFaTJyxYpDhr1OO77+JoOPO4l
 eLQU0LAAUcmKpFkz3Bp+wQhPRIG5Rq+K2kVV4+EN1ET1uPmEv/J82s4XPk/mMb6uMc8f
 9hC3ZDLOehvDZKCio49SkJ2NJgUDA3AM2Ah0Ee3aFB6aH/rEjSVY7nEJOmJZ73QnYynr
 QBYbDH277hfToM+ZyaAQKh3pJFu/eVGbGj8ZO9Xn9jE3hc03HDhDtwaPQJKiM1TTYEVg
 Xq95GElXeinDGFIq0HFMTv5qi3YefIDS1YzdOmZAeRI7pv+B7TcPPHxngEmcF3h5p4uk
 I0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735672232; x=1736277032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BeygLn9ykMNOw/BE7vEWDHoaAdOtlNYtI57PhpXYn80=;
 b=dXa2NA4UEVflFLHBNkmgxE+kbJ3SpkIGo9aBGW7CD9dMF7AnLa8V5eXnICfw+yRuzl
 89ysZv9KAaeeyOPpFAVbhClMs3VA61t04LT1UbQ+ru+Xo60Wirva7tHKyfuNX7DdaxL1
 Nld4m6ZOIdx79GoFNZSPk+tJbIs80mUak5uJ2lEWVPFzks6dwfU+pHzTPPnbytu7DG41
 7JiQet+v2mmv5ldsqBS8tSR1fZ5om8KTZkgp5qD/YpM0WFASniMt8fXV4YZimJ5/g6nR
 KsQZi2yCG1QkuJdOjobnDFL0fS8zdCibuGrJRl1qOjoHBTHaqUE0ki4vuUeg24awY0s+
 v7nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQeSbYaAnd+DiDIfzmJGOxAS8V3ErSrFxl297ZcYEblaYAsI6NQ+ideO+AIY+yquTweRhy+aYY7vzS@nongnu.org
X-Gm-Message-State: AOJu0Yx0R6P6qX9oQz9Lmwi5soGNXER7smWvTdujE9oOO7TIdusaoycO
 YdxQKsHHYmBq50qq730Qm1SsVwplyIoGd3herkmQIK4HP1/dn8WhCPnz/mIoIFPVSos5tTW23Ux
 G6RA=
X-Gm-Gg: ASbGnctO28ekvDZGQlYGfwHgOy6KhMk2WszrXrs+oH7R8KhiFP4zkJqurK3PwY1vhy5
 ccYvL1DFFYfbIXMdZsjG0lR3hTW9FXV3YoLQehIQhORvlfKN8scurzliJ1mDhrJic/9uDlDG0Zm
 Y08RpeO/H82jcVr5eJ68X/ruNzbZoMLjhT3pgp5YQwh4Da2uYtCUZRbbaGWl2iGT9q4y5rJ/jYb
 qbcZrqChHdEf5kTQGXT61Tl+NOsamUiw0Bc6IGaFQhSouA/1pkAZgYhHbzv3qAh0YZzJ/0M6/qj
 oQSme/HGaJWmIkrTIF5ECDI3
X-Google-Smtp-Source: AGHT+IGYnlsYAYCxCfIhBtxXny6yWaFiF6gmtL0ba+WpXpSSiqHjYfv6Puzt51BloFjvZtEHNhU5gg==
X-Received: by 2002:a05:600c:35cb:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-43668643642mr328078845e9.13.1735672232591; 
 Tue, 31 Dec 2024 11:10:32 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84705esm33651228f8f.44.2024.12.31.11.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 11:10:31 -0800 (PST)
Message-ID: <27983200-e32e-434b-ad4c-267276eb6112@linaro.org>
Date: Tue, 31 Dec 2024 20:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/misc/ivshmem-flat: Add ivshmem-flat device
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 armbru@redhat.com
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
 <20241216141818.111255-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216141818.111255-2-gustavo.romero@linaro.org>
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

On 16/12/24 15:18, Gustavo Romero wrote:
> Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
> does not require a PCI bus. It's meant to be used on machines like those
> with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
> and mps2-an385.
> 
> The device currently only supports the sysbus bus.
> 
> The new device, just like the ivshmem PCI device, supports both peer
> notification via hardware interrupts and shared memory.
> 
> The device shared memory size can be set using the 'shmem-size' option
> and it defaults to 4 MiB, which is the default size of shmem allocated
> by the ivshmem server.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1134
> Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/devices/ivshmem-flat.rst |  33 ++

Squashing:

-- >8 --
diff --git a/docs/system/device-emulation.rst 
b/docs/system/device-emulation.rst
index f19777411cd..a1b0d7997e0 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -86,6 +86,7 @@ Emulated Devices
     devices/ccid.rst
     devices/cxl.rst
     devices/ivshmem.rst
+   devices/ivshmem-flat.rst
     devices/keyboard.rst
     devices/net.rst
     devices/nvme.rst
---

to avoid:

docs/system/devices/ivshmem-flat.rst:document isn't included in any toctree
ninja: subcommand failed
make: *** [Makefile:168: run-ninja] Error 1

>   hw/misc/Kconfig                      |   5 +
>   hw/misc/ivshmem-flat.c               | 463 +++++++++++++++++++++++++++
>   hw/misc/meson.build                  |   2 +
>   hw/misc/trace-events                 |  16 +
>   include/hw/misc/ivshmem-flat.h       |  85 +++++
>   6 files changed, 604 insertions(+)
>   create mode 100644 docs/system/devices/ivshmem-flat.rst
>   create mode 100644 hw/misc/ivshmem-flat.c
>   create mode 100644 include/hw/misc/ivshmem-flat.h


