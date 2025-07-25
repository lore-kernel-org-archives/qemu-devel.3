Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88EEC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLqu-0007Ng-3q; Fri, 25 Jul 2025 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLqs-0007MK-3n
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:04:58 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLqn-0003kb-Eg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:04:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3cdso1664228b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753463092; x=1754067892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ql3CqjEktw+CmiUF4vCUrznrOhJeXlMNKa5Yt/1FCsU=;
 b=H4PCSvWLet5ZuNESktYgtIU0GbuvZqCDQPZQvDC9NngbyrwOvL90OgKDlBOxdfUvjO
 6BZuUR0l1F3KAMBj/VNcj83SLatMzHl7BweN8y9hMn5gmqZAooLx4y8OPSMiUVSBg++v
 uPgqWrbnNqrvE3gfY2OJTSHgv09BZ6pbuyULW3O8IG+0szlP4vE9pf2KsriKXYc/UYXO
 AHc8RzP1HUuuV+hmlCtpzwlJS6yBreeB3WagSidXt7lXnQLg6S2uvDhW8CvIJ1vRqepT
 jH6xXC+B9+ZlR3Kb46ERdCGHCpStn6+/J8UnbcQotI20WIQ1ArDkUxlW/BQ6rLVufIaC
 zs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753463092; x=1754067892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql3CqjEktw+CmiUF4vCUrznrOhJeXlMNKa5Yt/1FCsU=;
 b=Umqrsw1fU1ja1yJR/goFwL9t6kmHih7R6coV/SyELplwIpuYRWfuDYOaMOSYPK9Z1W
 +vXrewfs7yBf5ffa4Uy5l6cK5Z065d8/vG9c9Agq92nvz/XbylZS9dJuzW2HMB5Q64k6
 16HZobNC0Th1b/QwullsnzDwGY440MwHXA4zgQeOnaFT0/ingyKD7QowpJPWSz3zm+G1
 JvCWJpl0vm2FXLuX3RESWF75Ns3abv9OhhuVaPvqyhYPLJ9LAqkguKo5gsViGTCFR2L0
 /0GdPUsQcnxRYJwUUyh74x95hJQuMaZsMyZf4cwDuU1tnCuATx9MBCBkyBWFPUgiWvuQ
 +lVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOa1TZy6lFp/n/rEppxVj60k5baRBzzioCehgE77uaTbHqycyt07wH7JmBYEMwtVId03IpUIPrwEXX@nongnu.org
X-Gm-Message-State: AOJu0YxEtVU5XhG4fHt3CAHWcwwU2z+n/u/jKsxlqyw/5JbmJC2srBLD
 89+mg6+k6mDZiSQD/eEgbNghQXhYOI9lTGtdlUf9r4VYjb08BHrnzdhjWF4I4tdpDGaIaQQa2Nn
 5Dmr5
X-Gm-Gg: ASbGnct0Q9yl2F7HUxmpFBTKYCJcH8JoXaEr2BgjGtbM9pXv8KvRbJTdKAp6jePVKK2
 3CiYSvCpYkecOwhe4eAuHfGx+uSeEKbIUWFhADb49FWewqSZAVAVgyJggNMfxWJeFxb5/7qXOPk
 RufbvtCEME/KdoglnSCljLsbv9HSjQqbZY2JsHkzLUIe40bAOR6Jyoq+RGUl4kB3TGcqctFnLra
 S2pjw4+10ZP8MGpAoqhnG1mJAQAy8geRHArzck9cwvP3Ki2mTlJB6BIKCCy3NUO54IToBqpWxNo
 jcHBRmAQOVJIeu5PT9cat0/GVQxc6b2F+yHjG0Wjs6TX0NjJ1esdnmNCcTklFwyPlwxsx217Hjw
 xo7w7utSyyDsVPqRih+tdvrwK7TkslzmBaM0=
X-Google-Smtp-Source: AGHT+IFBgvrxn22l1e9gCBPs2dq+IIZ7QTOroG4eCCipE6X3S5SO77+tnehfj/lDsUMkJbHfC023dg==
X-Received: by 2002:a05:6a00:cc3:b0:75f:8239:5c2b with SMTP id
 d2e1a72fcca58-76339569eeamr4026811b3a.23.1753463091438; 
 Fri, 25 Jul 2025 10:04:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfbf7asm147103b3a.75.2025.07.25.10.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:04:50 -0700 (PDT)
Message-ID: <d0e8ec94-1430-4db3-8c77-9dcdec3e67dc@linaro.org>
Date: Fri, 25 Jul 2025 10:04:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] log: make '-msg timestamp=on' apply to all qemu_log
 usage
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20250724144636.107828-1-stefanha@redhat.com>
 <20250724144636.107828-2-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250724144636.107828-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/24/25 7:46 AM, Stefan Hajnoczi wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Currently the tracing 'log' back emits special code to add timestamps
> to trace points sent via qemu_log(). This current impl is a bad design
> for a number of reasons.
> 
>   * It changes the QEMU headers, such that 'error-report.h' content
>     is visible to all files using tracing, but only when the 'log'
>     backend is enabled. This has led to build failure bugs as devs
>     rarely test without the (default) 'log' backend enabled, and
>     CI can't cover every scenario for every trace backend.
> 
>   * It bloats the trace points definitions which are inlined into
>     every probe location due to repeated inlining of timestamp
>     formatting code, adding MBs of overhead to QEMU.
> 
>   * The tracing subsystem should not be treated any differently
>     from other users of qemu_log. They all would benefit from
>     having timestamps present.
> 
>   * The timestamp emitted with the tracepoints is in a needlessly
>     different format to that used by error_report() in response
>     to '-msg timestamp=on'.
> 
> This fixes all these issues simply by moving timestamp formatting
> into qemu_log, using the same approach as for error_report.
> 
> The code before:
> 
>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>    {
>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>            if (message_with_timestamp) {
>                struct timeval _now;
>                gettimeofday(&_now, NULL);
>                qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n",
>                         qemu_get_thread_id(),
>                         (size_t)_now.tv_sec, (size_t)_now.tv_usec
>                         , creds, filename, path);
>            } else {
>                qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>            }
>        }
>    }
> 
> and after:
> 
>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>    {
>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>            qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>        }
>    }
> 
> The log and error messages before:
> 
>    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>    2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
>    2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem path=<none>
>    2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
> 
> and after:
> 
>    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>    2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
>    2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
>    2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
> 
> The binary size before:
> 
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>    $ strip qemu-system-x86_64
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
> 
> and after:
> 
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>    $ strip qemu-system-x86_64
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Message-id: 20250721185452.3016488-1-berrange@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   util/log.c                       | 20 +++++++++++++++++++-
>   scripts/tracetool/backend/log.py | 14 +-------------
>   2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/util/log.c b/util/log.c
> index 58d24de48a..abdcb6b311 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
>   
>   void qemu_log(const char *fmt, ...)
>   {
> -    FILE *f = qemu_log_trylock();
> +    FILE *f;
> +    g_autofree const char *timestr = NULL;
> +
> +    /*
> +     * Prepare the timestamp *outside* the logging
> +     * lock so it better reflects when the message
> +     * was emitted if we are delayed acquiring the
> +     * mutex
> +     */
> +    if (message_with_timestamp) {
> +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> +        timestr = g_date_time_format_iso8601(dt);
> +    }
> +
> +    f = qemu_log_trylock();
>       if (f) {
>           va_list ap;
>   
> +        if (timestr) {
> +            fprintf(f, "%s ", timestr);
> +        }
> +
>           va_start(ap, fmt);
>           vfprintf(f, fmt, ap);
>           va_end(ap);
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index 5c9d09dd11..eb50ceea34 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -20,7 +20,6 @@
>   
>   def generate_h_begin(events, group):
>       out('#include "qemu/log-for-trace.h"',
> -        '#include "qemu/error-report.h"',
>           '')
>   
>   
> @@ -32,20 +31,9 @@ def generate_h(event, group):
>       cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>   
>       out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> -        '        if (message_with_timestamp) {',
> -        '            struct timeval _now;',
> -        '            gettimeofday(&_now, NULL);',
>           '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> -        '                     %(argnames)s);',
> +        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>           '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        } else {',
> -        '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> -        '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        }',
>           '    }',
>           cond=cond,
>           event_lineno=event.lineno,

This broke compilation in debug on linux with all targets due to missing 
include. Not a big deal, but it's a bit surprising it passed our CI. Do 
we sometimes skip it for "simple" patches?

Fix: 
https://lore.kernel.org/qemu-devel/20250725165749.3893240-1-pierrick.bouvier@linaro.org/T/#u

Regards,
Pierrick

