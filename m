Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5478CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlce-00084K-LN; Thu, 11 Sep 2025 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlcT-00083Q-3T
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:02:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlcN-0003xR-0Z
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:02:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso7844385e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613709; x=1758218509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dT+Q59Pc2L/rhFNESzM1Obx+v54bS+WG5xyH9LUjUpA=;
 b=qOoxYgrx6V2wUw0yDrZ/FEn/4WBlMH9CckYDuo6BpGz4cnbLeND2LBbCcW0ZD4PXjk
 yHW5hbxtGm3l2/5c4l4CCo92h/jK8f+j1my994TUx2f4qouzgiM17yzX/v6vTzO03ih+
 qg44Iqy0TGiVse1NpN6MDpYgVEdBLu11tYU1TumzKr2a3XBkiemSn6mMGXsyiIxHpKvB
 vARcDAQB+TtrVyZP/zpsKLYQajl4L5a3HyG22TDBbpFcLGRmhwMftom0bsHvxE0bNBZW
 GLJf8xH4+atN7TvqNsXATuV1kNEFaGF2rDloUlDXQwDf3Q7LZB9I2+9AQ1mkHcN0PiIa
 tNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613709; x=1758218509;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dT+Q59Pc2L/rhFNESzM1Obx+v54bS+WG5xyH9LUjUpA=;
 b=WwxxbmCCLABcMZmRn9aA2ETS3UffspAxtKCpyOzuIV+SGVWOV8vs766QcuJk4kxM6e
 brhD04wnO9sHlplw5ZzY+Lcwmo7grxrxx1ippMr7mZtsGqWft/NkYbh8fvBJMmQ3KDUr
 RzCnQChDnxMX5/+Nt0p7545bW0lRi5dy/8/8/16OZB24C4Sh9he7JCWhAgHIaInW09of
 Tk7adM8fHuCKY81xyubXVaSsRdLjcSwYdx2qcf8K0SGDClPBdft6z+NtWO3rxGUAo+LA
 m+77dSROVm/QaE+I7psn4hpcHrcIKHryyVdGJ25MGxU1vuHbY3UwcKTcH/iTEzEJOmYH
 rh7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVbUXdg4+ZOQ6UyGdFzN3XIZPTHfiZJeSFADGVZ/OMhc9IetEEIjxT/MU+OaXIGAewe6dgg3imGC2G@nongnu.org
X-Gm-Message-State: AOJu0Yy0FvQwKv/10qUilgKKxjVF2RysEraI4xOzlVMtOqOa9BR25eVC
 nHGUQY64ULU6OHdSv0YjHrYszijTxTQkpUqRXsN3ANmWLByM5rzS+jpaSvj+0UYpFrA=
X-Gm-Gg: ASbGncvluyBg1siqZIzZ5kpBupVpXwqvClJoBjs4BwaFrG1ptsSVyaRRO+Ge4j2EuMY
 6EvgfAkVlS3jVVjtcnEY9SoWmE7oq/+qFgdFZXDIBurbOqjt8BnXLFVzoB/60l22XEKPq8csMoJ
 kEjHw0ukqMvtBU54A9oXunR+88mVayoD2wejrVtpAhoYdFxHYq6sT8KN/gpq16hg5f01e/mEVMA
 5j2y6erKq+ZUc52r6E6/7rtj/prV1umy5V3HUoiBXGL7XwRjE/KSFhN/tqeliYdo9vQqc9+uzHZ
 sOxzShNEj/B0qz18blIIW2J7rU/8lOAf7RzeOSG+pR4f9uNYLA4EHE4A+hmOtRbjCH/wWKoyTMW
 Iv83zU4FCtiSer/he5PTpla2WgYm1l7H8wul0YyctUDi+Vi1GYDXK6I5BVhAQcSzP/srxpsN0hF
 jZqvg=
X-Google-Smtp-Source: AGHT+IFVpkQFWQnUNu1MWepE5aBvXL+kuTpzxhQw7lHHly64gf0mGgsUBkCDhq9gekN/sHbcKG/qVQ==
X-Received: by 2002:a05:600c:468a:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45f211f2eb5mr3964795e9.17.1757613708455; 
 Thu, 11 Sep 2025 11:01:48 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037b9ebbsm34471925e9.11.2025.09.11.11.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:01:48 -0700 (PDT)
Message-ID: <0edf22b7-d2c6-4995-880a-03133d5043b6@linaro.org>
Date: Thu, 11 Sep 2025 18:01:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] util: fix interleaving of error & trace output
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
 <20250910180357.320297-15-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
> The monitor_cur_hmp() function will acquire/release mutex locks, which
> will trigger trace probes, which can in turn trigger qemu_log() calls.
> vreport() calls monitor_cur() multiple times through its execution
> both directly and indirectly via error_vprintf().
> 
> The result is that the prefix information printed by vreport() gets
> interleaved with qemu_log() output, when run outside the context of
> an HMP command dispatcher. This can be seen with:
> 
>   $ qemu-system-x86_64
>       -msg timestamp=on,guest-name=on
>       -display none
>       -object tls-creds-x509,id=f,dir=fish
>       -name fish
>       -d trace:qemu_mutex*
>     2025-09-10T16:30:42.514374Z qemu_mutex_unlock released mutex 0x560b0339b4c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514400Z qemu_mutex_lock waiting on mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514402Z qemu_mutex_locked taken mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514404Z qemu_mutex_unlock released mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.516716Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:30:42.516723Z qemu_mutex_locked taken mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:30:42.516726Z qemu_mutex_unlock released mutex 0x560b03398560 (../monitor/monitor.c:96)
>     2025-09-10T16:30:42.516728Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842057Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842058Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842055Z 2025-09-10T16:31:04.842060Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842061Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842062Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842064Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842065Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842066Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     fish 2025-09-10T16:31:04.842068Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842069Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842070Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842072Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842097Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842099Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     qemu-system-x86_64:2025-09-10T16:31:04.842100Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842102Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842103Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>      2025-09-10T16:31:04.842105Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842106Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842107Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     Unable to access credentials fish/ca-cert.pem: No such file or directory2025-09-10T16:31:04.842109Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842110Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842111Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
> 
> To avoid this interleaving (as well as reduce the huge number of
> mutex lock/unlock calls) we need to ensure that monitor_cur_hmp() is
> only called once at the start of vreport(), and if no HMP is present,
> no further monitor APIs can be called.
> 
> This implies error_[v]printf() cannot be called from vreport().
> 
> Instead a decision about whether output will go to monitor_[v]printf()
> or fprintf() must be made upfront, and then those functions called
> directly.
> 
>   $ qemu-system-x86_64
>       -msg timestamp=on,guest-name=on
>       -display none
>       -object tls-creds-x509,id=f,dir=fish
>       -name fish
>       -d trace:qemu_mutex*
>     2025-09-10T16:31:22.701691Z qemu_mutex_unlock released mutex 0x5626fd3b84c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701728Z qemu_mutex_lock waiting on mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701730Z qemu_mutex_locked taken mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701732Z qemu_mutex_unlock released mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.703989Z qemu_mutex_lock waiting on mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:22.703996Z qemu_mutex_locked taken mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:22.703999Z qemu_mutex_unlock released mutex 0x5626fd3b5560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:22.704000Z fish qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> This change requires adding a stub for monitor_printf() since that
> is now called directly by vreport(), where monitor_vprintf() was
> only needed previously.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   stubs/monitor-core.c           |  5 +++
>   tests/unit/test-util-sockets.c |  1 +
>   util/error-report.c            | 60 ++++++++++++++++++++++++----------
>   3 files changed, 48 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 1e0b11ec29..70b1f7a994 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -30,3 +30,8 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>   {
>       abort();
>   }
> +
> +int monitor_printf(Monitor *mon, const char *fmt, ...)
> +{
> +    abort();
> +}
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index d40813c682..53733163dd 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -76,6 +76,7 @@ Monitor *monitor_cur_hmp(void) { return cur_mon; }
>   bool monitor_cur_is_qmp(void) { return false; }
>   Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>   int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> +int monitor_printf(Monitor *mon, const char *fmt, ...) { abort(); }
>   
>   #ifndef _WIN32
>   static void test_socket_fd_pass_name_good(void)
> diff --git a/util/error-report.c b/util/error-report.c
> index c0fcf388de..6c887047e3 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -29,6 +29,9 @@ bool message_with_timestamp;
>   bool error_with_guestname;
>   const char *error_guest_name;
>   
> +typedef void (*error_print_func)(void *opaque, const char *fmt, ...);
> +typedef void (*error_print_vfunc)(void *opaque, const char *fmt, va_list ap);
> +
>   /*
>    * Print to current monitor if we have one, else to stderr.
>    */
> @@ -151,34 +154,34 @@ void loc_set_file(const char *fname, int lno)
>   /*
>    * Print current location to current monitor if we have one, else to stderr.
>    */
> -static void print_loc(void)
> +static void print_loc(bool cur, error_print_func print_func, void *print_opaque)
>   {
>       const char *sep = "";
>       int i;
>       const char *const *argp;
>   
> -    if (!monitor_cur_hmp() && g_get_prgname()) {
> -        error_printf("%s:", g_get_prgname());
> +    if (!cur && g_get_prgname()) {
> +        print_func(print_opaque, "%s:", g_get_prgname());
>           sep = " ";
>       }
>       switch (cur_loc->kind) {
>       case LOC_CMDLINE:
>           argp = cur_loc->ptr;
>           for (i = 0; i < cur_loc->num; i++) {
> -            error_printf("%s%s", sep, argp[i]);
> +            print_func(print_opaque, "%s%s", sep, argp[i]);
>               sep = " ";
>           }
> -        error_printf(": ");
> +        print_func(print_opaque, ": ");
>           break;
>       case LOC_FILE:
> -        error_printf("%s:", (const char *)cur_loc->ptr);
> +        print_func(print_opaque, "%s:", (const char *)cur_loc->ptr);
>           if (cur_loc->num) {
> -            error_printf("%d:", cur_loc->num);
> +            print_func(print_opaque, "%d:", cur_loc->num);
>           }
> -        error_printf(" ");
> +        print_func(print_opaque, " ");
>           break;
>       default:
> -        error_printf("%s", sep);
> +        print_func(print_opaque, "%s", sep);
>       }
>   }
>   
> @@ -199,34 +202,55 @@ real_time_iso8601(void)
>   G_GNUC_PRINTF(2, 0)
>   static void vreport(report_type type, const char *fmt, va_list ap)
>   {
> +    /*
> +     * Calling monitor_cur_hmp() will acquire/release mutexes,
> +     * which triggers trace probes, which can trigger
> +     * qemu_log calls, which would interleave with output
> +     * from this. Hence cache the monitor handle upfront
> +     * so any tracing appears before we start outputting.
> +     */
> +    Monitor *cur = monitor_cur_hmp();
> +    error_print_func print_func;
> +    error_print_vfunc print_vfunc;
> +    void *print_opaque;
>       gchar *timestr;
>   
> -    if (message_with_timestamp && !monitor_cur_hmp()) {
> +    if (cur) {
> +        print_func = (error_print_func)monitor_printf;
> +        print_vfunc = (error_print_vfunc)monitor_vprintf;
> +        print_opaque = cur;
> +    } else {
> +        print_func = (error_print_func)fprintf;
> +        print_vfunc = (error_print_vfunc)vfprintf;
> +        print_opaque = stderr;
> +    }
> +
> +    if (message_with_timestamp && !cur) {
>           timestr = real_time_iso8601();
> -        error_printf("%s ", timestr);
> +        print_func(print_opaque, "%s ", timestr);
>           g_free(timestr);
>       }
>   
>       /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
> -        error_printf("%s ", error_guest_name);
> +    if (error_with_guestname && error_guest_name && !cur) {
> +        print_func(print_opaque, "%s ", error_guest_name);
>       }
>   
> -    print_loc();
> +    print_loc(!!cur, print_func, print_opaque);
>   
>       switch (type) {
>       case REPORT_TYPE_ERROR:
>           break;
>       case REPORT_TYPE_WARNING:
> -        error_printf("warning: ");
> +        print_func(print_opaque, "warning: ");
>           break;
>       case REPORT_TYPE_INFO:
> -        error_printf("info: ");
> +        print_func(print_opaque, "info: ");
>           break;
>       }
>   
> -    error_vprintf(fmt, ap);
> -    error_printf("\n");
> +    print_vfunc(print_opaque, fmt, ap);
> +    print_func(print_opaque, "\n");
>   }
>   
>   /*


