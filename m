Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D38CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwd6D-0005w9-4C; Thu, 11 Sep 2025 04:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd69-0005vk-VJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:56:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd67-0005WQ-H1
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:56:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3dae49b117bso451108f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757580963; x=1758185763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nll0NLGaWgrdoOT4kLjItrh6/lcecU6jGy/1hAEpG9I=;
 b=bnJKm3IsHx+BcwbTjx7oktdjLPlNkO3iO18iW4iSZXC1vKKY33fPvFNM2aSeguffJg
 JzOav/u+BBrYJLxaRfetggBfbt4hJkAhJfYJ+p+wBYtRJTA4wIKlXRsdJO1V64SP6bkG
 OpN/Nw6i73xMjiqkP3io5mrgw/SY2bVcWD4hbGoe799Vwgj+G3ClKqiyjmiAKURm4wuS
 kpd3uPjF4q4ds4pmP7kCi/fLzbA5vqcYb3nzm6FhXllkFHEYOR9ArsQ7EwkWeIViODIx
 SNdsZ3poeX0uNrUssjhNghYCSL9ICyU5q2v3gzkutHL3FwpM1JJr+aoRWCgdTkUqf2o5
 rMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757580963; x=1758185763;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nll0NLGaWgrdoOT4kLjItrh6/lcecU6jGy/1hAEpG9I=;
 b=iNgguh92NwkhdhpEI7iVRzewSslxr41G3BRSArgo+GAryo/alYgEhGvWaOgL+iyhv0
 qqJGx0G/HP7yhbpt5EKyZ4tlbbewVAkK0mEp6GDUx/2aCmiZuA7BcF3s/dteGUCi8mO5
 ew4g2kmx6CgzOgmiIiZ4oHO8XsE/4/laLg0oUG1w7dNfGitpOcjmJOwkyW15+MTUjKRa
 GZbOQel9L/wHVqfIb1vFwWXmAn+7hNGAL1x9pBTMwMaJei6s8RMA3208rvLRDVP3bU2b
 OmN4VrvJPm0At4+raK4BRl4IdTCQorfhsyTAXmDNYmbcwFjehG11azGrPIhBSFQkO8SQ
 RbSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4bWpR/bc7ydsuukrwCootnHb0shkp7OiEThQj0BLvvPl6f6i4wB2jzk/dDOp1WkOCuqmMzRb8pO/D@nongnu.org
X-Gm-Message-State: AOJu0Yz2ucbceojKcvdQKDD7oHd0m2HZ7O7U4/uCKUSCgbn+ttaOcrYz
 A0rBtn5G/SaQjBdP4RXn6mfNdksWLaRAUoIJ3nu0eaLswySknug9Q2ffdPlVpidrUQ0=
X-Gm-Gg: ASbGncs7FS0xA9Kq5JB30l5BeQq0upZAzM/fM+Bujcpg41aj+ztyN+r4a7XxY5u9dfT
 GpjQPE70gKAfT7dWD+JK0fxNgL/7W79Jqgtc0HPP9+hi4FHpUW5+08mEAd0WKzsWsl2cKJ264Y1
 Zvxc0fQykc7VJGY3r4SqwvVO4mvoY8ujWL2piJY/ZSevWsxZLv0OV1Fn1RZ9IeOGkXP9ZKVz8KF
 dpmXAYQSklSvaQb1Li3ZCY7vUJTgj+NNHV3x6+TE2BElAz5x9VplqA+EddRHSO3TXtQTXvrv1Jm
 bwKIcwXPvavEE6V9jmmV8mys9muFw7JvTyg+HwxSywN0CcZ0C2c6hYF3jtopRwjmjrSikXJQ5+Q
 kDP5tXmoXgeo5ToKLnCpgBe8DbG0FVavriFYzcot/gAUAAhI=
X-Google-Smtp-Source: AGHT+IHiiZwhA1aZ4Ljyq0Rq6zyR2CvhngX+IWXTTuDCyZlwXAV9ZJipHKARAsIMZZAExb4OdTshng==
X-Received: by 2002:adf:a298:0:b0:3e7:4197:c99d with SMTP id
 ffacd0b85a97d-3e74197cb7fmr10739992f8f.15.1757580963459; 
 Thu, 11 Sep 2025 01:56:03 -0700 (PDT)
Received: from [10.20.51.75] ([88.149.120.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5a16sm18618855e9.12.2025.09.11.01.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 01:56:02 -0700 (PDT)
Message-ID: <f4de96aa-a163-4cec-bb85-b8aa71e49753@linaro.org>
Date: Thu, 11 Sep 2025 08:55:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] monitor: move error_vprintf() back to
 error-report.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-12-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> This conceptually reverts 397d30e9401d2da96dbdf0ce49805d6d4bb68833.
> The discussion around stubs in that commit does not appear to be
> important to the current state of the codebase.
> 
> This makes the error_vprintf() impl source file match that
> of error_printf(), and also match the header where it is declared.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   monitor/monitor.c              | 13 -------------
>   stubs/monitor-core.c           |  5 +++++
>   tests/unit/test-util-sockets.c |  1 +
>   util/error-report.c            | 13 +++++++++++++
>   4 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 03dbe5d131..e1e5dbfcbe 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -268,19 +268,6 @@ void monitor_printc(Monitor *mon, int c)
>       monitor_printf(mon, "'");
>   }
>   
> -/*
> - * Print to current monitor if we have one, else to stderr.
> - */
> -int error_vprintf(const char *fmt, va_list ap)
> -{
> -    Monitor *cur_mon = monitor_cur();
> -
> -    if (cur_mon && !monitor_cur_is_qmp()) {
> -        return monitor_vprintf(cur_mon, fmt, ap);
> -    }
> -    return vfprintf(stderr, fmt, ap);
> -}
> -
>   static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>       /* Limit guest-triggerable events to 1 per second */
>       [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 1894cdfe1f..b498a0f1af 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
>       return NULL;
>   }
>   
> +bool monitor_cur_is_qmp(void)
> +{
> +    return false;
> +}

Better as g_assert_not_reached().  It's not obvious whether hmp or qmp is a better 
fallback answer for "no monitor".  Anyway, since monitor_cur() is NULL, we should never 
get here.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
>   Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>   {
>       return NULL;
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index ee66d727c3..bd48731ea2 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>    * otherwise we get duplicate syms at link time.
>    */
>   Monitor *monitor_cur(void) { return cur_mon; }
> +bool monitor_cur_is_qmp(void) { return false; }
>   Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>   int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
>   
> diff --git a/util/error-report.c b/util/error-report.c
> index 1b17c11de1..79b6f23e64 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -29,6 +29,19 @@ bool message_with_timestamp;
>   bool error_with_guestname;
>   const char *error_guest_name;
>   
> +/*
> + * Print to current monitor if we have one, else to stderr.
> + */
> +int error_vprintf(const char *fmt, va_list ap)
> +{
> +    Monitor *cur_mon = monitor_cur();
> +
> +    if (cur_mon && !monitor_cur_is_qmp()) {
> +        return monitor_vprintf(cur_mon, fmt, ap);
> +    }
> +    return vfprintf(stderr, fmt, ap);
> +}
> +
>   int error_printf(const char *fmt, ...)
>   {
>       va_list ap;


