Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C38C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yh8-0004ZB-9B; Wed, 16 Apr 2025 05:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4ygv-0004W8-AG
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:04:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4ygb-0005tL-JM
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:04:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so59831805e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744794240; x=1745399040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUWYxnXh8lwhGY2OO/SccjnOI4f8xd+wiWjlUO6Csa4=;
 b=m+3qYqeE9hCYtyzuz4ioddaWkJZ36b98gNpLqZ3QsO1BvuJPWJ6cbN7FWLmmAAFT+w
 MX1jTzGIbP+B0jj8e9r4XeajHuabhqOOzs/Y2mHYkHEzJifgNS2jSCXyHMg8NF/3n+dp
 OBILtHHbg9zbQFVoINQSRy0pFH83LCmpIxugvghJBsl3mZsiA8KTvdO8W5zLbaSVxyEF
 YqtABN2I0mZtlvDJg37m5PPb+QyArd4xPtSG68oYB4bhPbM1yGNNZqc1OtG3aj3g0fB7
 VZaGP7Iz6QiomoKd3XOSR800vw85OJNJ6u4aHJlqhz+HM0rb77oHfV0QKgME0QM2IFMX
 sGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794240; x=1745399040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUWYxnXh8lwhGY2OO/SccjnOI4f8xd+wiWjlUO6Csa4=;
 b=YAuSQYOsxZiC9xkkGFD433pXFTpQcBkd6QTyYoLI5E7B2CY5mhm7XQ8mbDtvZYskTM
 I4sz0ahZuYG4BkMUUDg7mQp7zPypOJIB0Z4Qu/OAl9xnNOsMZKoKYiG+ioXyhMgDj3TH
 GQmSJ3ibFwqtoDe4hqRVkquOef9LBtzE3u5Fqar+PTxGDl1hzqR77DYAHKlLwU/ZHEIH
 MMvtzFXZ/sCzzx5VjRJYAIXE1kvNyE+8RfxWsaqRNN0YGYVoH8kKrm2xwBM5Oh2CvD3N
 1o5wNC/SpyuFpLHXL6IgLB9PFZN4TWzGGyYmn/72L0XkdzFM8c7xeRCXKXoERH6upxwj
 MngQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVRMOA7NscOG5py91w1FmAxuJO4bZCSzC6/8UTAT4ZaqTqFQYnVeibMmWa7CP5qzQI/rZwwVv5jxJj@nongnu.org
X-Gm-Message-State: AOJu0YwcLKpNPZ+hNoRF+CmNT9j2k5IeN0u6hIxQc8yUDs3Td03oc57c
 FhJMTnFGw+w8qGNEBOdFrCzDWHxEwE4+8wq9GAtTCM3iWEmDN1McjHQe4n31sNI=
X-Gm-Gg: ASbGncv1MTyr1DzIS473IBJTDW5iBHZJ+iUuDqK/h4YB5V3cUA/Qmm8T5CXMpmGdQD+
 YA49+LE10lBTfhd5Mj9vzCTWLYznmBkOk4V+q9AEaArM/dNCgpD973YIniZJ7Yjo7HdpW09Gq1A
 ZsUtySd5XtAZYlnaCo7fl6niA744OqQBDm9OoR1Y43287IJv0A3ZKdrYqKYuREfOKmd0qytxVNe
 ylzn95XQ+bDS5VNQusCj7jXLYpJSDX09o/jGHRVDw/K0SuXqTCX+Tibuum8mwutZqitjpYNShdb
 HBn5MCjtC7wDTo9PJYYzBYmz5Hlti1TdpSYEh0k4JUF09aAlJjRKZ87vcQcy2/qGff57kJbIMBn
 TdWHJwJQMrjwUDJUdaT6WY5iU
X-Google-Smtp-Source: AGHT+IFMBlwQSmEgqm/NTnMes5Uq1j9emF6+odX1U04PVh1jhQhYgfi2u1ppgJChumoqqCfveWDkGQ==
X-Received: by 2002:a05:600c:34c6:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-4405d69b68fmr10008205e9.23.1744794239868; 
 Wed, 16 Apr 2025 02:03:59 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8294sm15258185e9.2.2025.04.16.02.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:03:59 -0700 (PDT)
Message-ID: <e10f052d-b098-487e-a667-a0a19630d082@linaro.org>
Date: Wed, 16 Apr 2025 11:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] Disable options unsupported on Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <c2e3a58825c39678fcde361b685d1bd69d2fb1dd.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c2e3a58825c39678fcde361b685d1bd69d2fb1dd.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/4/25 10:14, Kohei Tokunaga wrote:
> Daemonizing and run-with aren't supported on Emscripten so disable these
> flags.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   qemu-options.hx | 4 +++-
>   system/vl.c     | 4 ++--
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..20ed22afe2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4863,9 +4863,11 @@ SRST
>   ERST
>   
>   #ifndef _WIN32
> +#ifndef EMSCRIPTEN

#if !defined(_WIN32) && !defined(EMSCRIPTEN)

?

>   DEF("daemonize", 0, QEMU_OPTION_daemonize, \
>       "-daemonize      daemonize QEMU after initializing\n", QEMU_ARCH_ALL)
>   #endif
> +#endif
>   SRST
>   ``-daemonize``
>       Daemonize the QEMU process after initialization. QEMU will not
> @@ -5249,7 +5251,7 @@ HXCOMM Internal use
>   DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
>   DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
>   
> -#ifdef CONFIG_POSIX
> +#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
>   DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
>       "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
>       "                Set miscellaneous QEMU process lifecycle options:\n"


