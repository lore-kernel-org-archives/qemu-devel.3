Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9702C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 05:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sior0-0000k8-E9; Tue, 27 Aug 2024 01:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sioqy-0000jA-PR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sioqx-0007CA-A1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724736889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DkqT0HSrk22Ka9SsW6lOx47hhHDGWQ2PXp84H4h9wjA=;
 b=CMoxf276XRbLxoqAArlZdpUest0XKTLGZtOA+xjBRj+cTidtJsKAbkWS499kl08UWKejm1
 MOE5gwSXNDu8eXFCcirLpGpdRy6hjWrmSKJDa0IYWqK5N8PekX605/TJ0+I8QmVQsWQOkr
 1Xl6zrey6b36jmVizqPcD1/nSRvlO0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-0I2y9WvgNReLhT5-lhaz1Q-1; Tue, 27 Aug 2024 01:34:46 -0400
X-MC-Unique: 0I2y9WvgNReLhT5-lhaz1Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280ec5200cso45262235e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 22:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724736885; x=1725341685;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DkqT0HSrk22Ka9SsW6lOx47hhHDGWQ2PXp84H4h9wjA=;
 b=YKQJEtM1Y6NXgmHQvgEyFyvpyY/vQ9iCN+Q6cSRJk3PYTlEjcKrVjyZdlUOJngvra+
 BPGLb+dWHNHRrsfimjPORfi6JNRwvI0tE2xR+oa7IFK5iP9WBPiRZjbBzCiHtXB6XEkn
 naTi/Qd9S6YC20qXSSMs4KD5XpOMvL+zEAMDcmj81RO6kTA0MGkFZpiUdMMxnEYYBIvp
 S5CYVB7/gQoUFtKCx63KCu0NUxwHA4PYMXwQp/MaEiNEQ1Q/jFUwcdPOsECYRSPj4b5c
 9V3zv9/9XhPl8jtudslEpWVkk/as/KvJuX5yRt1Bhxnef272cjfRtJ9CJrGOd21IYLN9
 bitA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtLA4Ik4VCJzdo6he0JOnjHP5BsONRsfL8QTtPO+XVDLp2ErifYbHCuNDwTZ6t84ajk3tTh3vBPjcs@nongnu.org
X-Gm-Message-State: AOJu0YwddpdyRSDyJ1IDsTXyjXwnGCB/mEGRcSbyessVcKsQY0ENz5Zx
 wSyr/uls7MC/kl1ceeVYoVg66qFzI9BYCR/KqvWWbkXiivtbYnYBQRus7cV1NwsDmpw67RCR26c
 xOEImL019wnP5LR/7cqRKKa+uwovnVgsohU/ZAr7bw5xL3XdCoCIt
X-Received: by 2002:a05:600c:17d6:b0:42a:a70e:3108 with SMTP id
 5b1f17b1804b1-42acc8ff914mr88815145e9.24.1724736885090; 
 Mon, 26 Aug 2024 22:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY85SuMSdH14Uis1iE34mfrjes0P94B8dAfhVIvZ5OOoKJcEximxoxOaQDjoLU9qrYch15WA==
X-Received: by 2002:a05:600c:17d6:b0:42a:a70e:3108 with SMTP id
 5b1f17b1804b1-42acc8ff914mr88814915e9.24.1724736884521; 
 Mon, 26 Aug 2024 22:34:44 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308265655sm12095995f8f.104.2024.08.26.22.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 22:34:44 -0700 (PDT)
Message-ID: <e66847a0-7390-42d9-a51d-190e0734d25e@redhat.com>
Date: Tue, 27 Aug 2024 07:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/functional: Add a class containing Linux kernel
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240826221058.75126-1-philmd@linaro.org>
 <20240826221058.75126-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240826221058.75126-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/08/2024 00.10, Philippe Mathieu-Daudé wrote:
> Use the 'linux_kernel' namespace to provide common helpers
> to functional tests booting a Linux kernel.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/qemu_test/linux_kernel.py | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 tests/functional/qemu_test/linux_kernel.py
> 
> diff --git a/tests/functional/qemu_test/linux_kernel.py b/tests/functional/qemu_test/linux_kernel.py
> new file mode 100644
> index 0000000000..917beb7fb6
> --- /dev/null
> +++ b/tests/functional/qemu_test/linux_kernel.py
> @@ -0,0 +1,19 @@
> +# Linux kernel functional test helpers
> +#
> +# Copyright (c) 2024 Linaro Ltd.
> +#
> +# Author:
> +#  Philippe Mathieu-Daudé <philmd@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from . import wait_for_console_pattern
> +
> +KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +
> +KERNEL_PANIC_MESSAGE = 'Kernel panic - not syncing'
> +
> +def linux_kernel_wait_for_pattern(test, success_message):
> +    wait_for_console_pattern(test,
> +                             success_message=success_message,
> +                             failure_message=KERNEL_PANIC_MESSAGE)

I'd prefer to have the whole LinuxKernelTest class here (without the 
BootLinuxConsole class of course), that way the modifications that we have 
to do to the converted tests are definitely smaller when we don't have to 
change the "wait_for_console_pattern" lines everywhere. And it's also nicer 
if the variables are properly wrapped in a class.

  Thomas


