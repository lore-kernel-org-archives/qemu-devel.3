Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD86D1269F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 12:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8IyR-0003jm-G5; Tue, 05 Nov 2024 07:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8IyP-0003ja-AK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:47:53 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8IyL-00005s-JV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:47:52 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so5844720a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730810867; x=1731415667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a8aIEJTFd//vuSo7fncINlA9yRVA5xj65DU5592aGk=;
 b=JzG27+KwpV16O2pLX9mu6G7s2YpWhQSc+O4Wxl9WZMUAmZudB6BCNXby8M/0SS37aa
 0OHEOcqNPzzDmzHgoXNBiwtFZ81t2OdGhu6yCVGT/sEkfHArQvk88F8vdfMAJi6Qn3Lh
 oaOSdrvK0tOoG65BCE92hxMUIYpIGjbJrxZbi0iil6+ys/Xe22y610yHkD0qVYbmSRLu
 imE4NOeqvRU15qJVt8K8pNY6hEFVE3sxUyYIasM/fG+qGZjFtnk/lgCgVN3Xvk0gERFv
 hlZi04rxP1Rpi4d3Qjek9Sdqkc7rcadqLBhkpKZLC4jjbJ4gQUFW55DZWcQOH3B1hYvM
 koEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730810867; x=1731415667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a8aIEJTFd//vuSo7fncINlA9yRVA5xj65DU5592aGk=;
 b=obRjXdGkGq3kNN/HdihbBjenA4bAWdfDm3KA7wdhT9Zn19PaK8vKHcFR/QreLbTL8a
 EqXsWkt58U1sq3TiEbka+2qId7k0QVhUjIIiehTU9N63lvU6EHWYyZCdHOC4TDLSLKVj
 4X8ChrWNxhCGaR6iqOzf3gpGCLoBT7p/qv0QGgaeJHxQ+n9eXmDnH3z1Qzvj6+ftgWNX
 Ib73l4Yx2yTLS13SdoN8+NjvOvJhCQcXZgYcfkv0t0NACU9FnmsUeMXEz1eQlo6pDGG3
 zA1ANMRp2WaSS+bNXkmtsOgQu0XtXy5R6n8dq5Dap20yJVQw86x/w9E0WUILzaFT8W9W
 18zg==
X-Gm-Message-State: AOJu0Yyrpyc7XfNdWfVp1BcqFgzXA8Kno0wElv+Hr8/+hPaXEdjlWLru
 COWYpL4jz/O5/OjFrBgqcF3g5wxQPRr+4N68uZD4gM1jWW1eUhQYnpTAbIo67Cub9VG0YwCaqEI
 HWiaWZt9ClORtA6ihZbBfeT5hcJz5E2hGsf9TRg==
X-Google-Smtp-Source: AGHT+IFJWK7kRZW6DcJrbXyjKR69JKGrrv8ghu8gKXCPrO2xBp3uuywqNXT8xYXVwTK5S9nRInYhjPfdq91G5quaHk8=
X-Received: by 2002:a05:6402:34c1:b0:5c9:5c40:6d9a with SMTP id
 4fb4d7f45d1cf-5cea9731db4mr15046365a12.34.1730810866616; Tue, 05 Nov 2024
 04:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20240305220938.85410-1-philmd@linaro.org>
 <20240305220938.85410-3-philmd@linaro.org>
In-Reply-To: <20240305220938.85410-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 12:47:35 +0000
Message-ID: <CAFEAcA-CJwcE9k+TqQ-vDrevzZPV_+CXAr1j9QfR_ivJTJ3e2w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target: Add system emulation aiming to target any
 architecture
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 5 Mar 2024 at 22:11, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Add the 'any'-architecture target.
>
> - Only consider 64-bit targets
> - Do not use any hardware accelerator (except qtest)
> - For architecture constants, use:
>   . max of supported targets phys/virt address space
>   . max of supported targets MMU modes
>   . min of supported targets variable page bits
>
> Since this is an experiment, the binary is named
> 'x-qemu-system-=F0=9F=9A=A7', and won't be installed.

(Since this came up on IRC) Can we stick to ASCII for
filenames, please? For instance, this doesn't display
correctly in an xterm on Ubuntu 22.04.

thanks
-- PMM

