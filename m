Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC07EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1fU-0000At-GA; Tue, 10 Sep 2024 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1fS-0008Vd-PS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:16:30 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1fQ-0007wu-RC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:16:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32971cso1197756a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977787; x=1726582587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTO3SbR8/CS5imaO2ZtO2Uj6evUCssJ5RCky30jkoA4=;
 b=uAJjFpNC093Vq+M5fgAolqZ681pFZu870eYQGdC5qLEG827GzDx5DhkFvAw0im37jW
 AM/TsAL/lst1BjCkfGBGGKGPtKz5U1YW8LgzQCS3zhpnEZnEv3tFW1qWNdoSq8x2m45V
 Uv2pKgitFk3FnALrIQLRoRx5LP+rmgQDQMaG+XPnjcNsk0hwwt8P/OK+ehG3UHEdQDxC
 RSOu+qwyuKeUY9t0ph/el5IN6PCe7PEy8bvIY8jxGumdU231AdhNe7v2Hqusx7630QAF
 y0dIRjQRgkI9noa86wlNkeipBpwcdAjx64DSfwIMI+xv8nmKJq3sW+g0GEDgYoJ/7dQF
 nErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977787; x=1726582587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTO3SbR8/CS5imaO2ZtO2Uj6evUCssJ5RCky30jkoA4=;
 b=BD3HEfXdRz014bQ3YiddrlM2xL3xVHZukRtkgYGuN1WGFFRwvelKf7MoRerTaK24FQ
 9URHsI1KuQ6I8cZ9MhzHIjDfolXdAOf2z8z+Rqh2OZ8j2kI4tZ2huyrZJlzjXis4kB5a
 9XtfRnVY8kkhiypTiNt/NPrCgrzSzRKsYEWIcJqwgn9ZbbVxBaE5P1EfGQzGBVVH6oXf
 Fe+anJ7YPwaXDYuIfOb5H9VgcNp9bfzra8jHqTeoUH3PTp19rQxnyBW/m0mbTgf9obhW
 Ogr34R1iB8+AhD0UT65k1HZDwGWHfGsx5jFilC/COffNams7Rp/CpN40MuZeeePk1X9V
 BQ8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgCstv5drkTkhXgRKtCz4wFsvK4M1fm6HUkf9a4c5acVXzkxfCCQfD50/hHgdZ9xqvJZRCInVqWL9C@nongnu.org
X-Gm-Message-State: AOJu0YyWuNVhQwXtc7KnHGKc9Uhf4yDMRuNd4ruCXd/K6io/a3mJq4MI
 NA715PpgmqKvggAuyaw61eRo84w77MuurFV4gDjqD+776zJwmtHy6QdXsjrHmBg=
X-Google-Smtp-Source: AGHT+IFAGjw+abPhxhHX0Re1aE9GVOOiy4Jgffq3gvvgleE0NPDLMAlE+kkItOjrG8WurqO/irFbDw==
X-Received: by 2002:a05:6402:5cd:b0:5c2:439e:d6d6 with SMTP id
 4fb4d7f45d1cf-5c3dc78a1d6mr10104231a12.11.1725977786753; 
 Tue, 10 Sep 2024 07:16:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8d9easm4265169a12.97.2024.09.10.07.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:16:26 -0700 (PDT)
Message-ID: <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
Date: Tue, 10 Sep 2024 16:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/24] audio: Add sndio backend
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Qiuhao Li <Qiuhao.Li@outlook.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20220927081912.180983-21-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi,

(This is commit 663df1cc68).

On 27/9/22 10:19, Gerd Hoffmann wrote:
> From: Alexandre Ratchov <alex@caoua.org>
> 
> sndio is the native API used by OpenBSD, although it has been ported to
> other *BSD's and Linux (packages for Ubuntu, Debian, Void, Arch, etc.).
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> Signed-off-by: Alexandre Ratchov <alex@caoua.org>
> Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
> Tested-by: Volker Rümelin <vr_qemu@t-online.de>
> Message-Id: <YxibXrWsrS3XYQM3@vm1.arverb.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   meson_options.txt             |   4 +-
>   audio/audio_template.h        |   2 +
>   audio/audio.c                 |   1 +
>   audio/sndioaudio.c            | 565 ++++++++++++++++++++++++++++++++++
>   MAINTAINERS                   |   7 +
>   audio/meson.build             |   1 +
>   meson.build                   |   9 +-
>   qapi/audio.json               |  25 +-
>   qemu-options.hx               |  16 +
>   scripts/meson-buildoptions.sh |   7 +-
>   10 files changed, 632 insertions(+), 5 deletions(-)
>   create mode 100644 audio/sndioaudio.c


> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> new file mode 100644
> index 000000000000..7c45276d36ce
> --- /dev/null
> +++ b/audio/sndioaudio.c
> @@ -0,0 +1,565 @@
> +/*
> + * SPDX-License-Identifier: ISC

This is the single use of the ISC license in the more than 10k
files in the repository. Just checking IIUC this document:
https://www.gnu.org/licenses/quick-guide-gplv3.en.html

ISC -> LGPLv2.1 -> GPLv2 -> GPLv3

So ISC is compatible with GPLv2-or-later. Is that correct?

Thanks,

Phil.

> + *
> + * Copyright (c) 2019 Alexandre Ratchov <alex@caoua.org>
> + */
> +
> +/*
> + * TODO :
> + *
> + * Use a single device and open it in full-duplex rather than
> + * opening it twice (once for playback once for recording).
> + *
> + * This is the only way to ensure that playback doesn't drift with respect
> + * to recording, which is what guest systems expect.
> + */
> +
> +#include <poll.h>
> +#include <sndio.h>
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "audio.h"
> +#include "trace.h"
> +
> +#define AUDIO_CAP "sndio"
> +#include "audio_int.h"
[...]

