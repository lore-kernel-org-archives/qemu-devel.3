Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FC2C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0Lt-0002O9-IO; Mon, 02 Jun 2025 04:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Ls-0002Nh-53
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:17:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Lq-0000YA-39
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:16:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d54214adso9040585e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748852216; x=1749457016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KdEzzvB4E53h+C2iJPAR6RjEZ/WLCvGQ9vvdjuDP3X0=;
 b=pZO//xTPRAjrZppI4LtUggFieXQRSctpjH1dCq5k/2Jwvc6G8dovNvIBcXklYuulTy
 ZJ77zO7iY57P2GWOHot9LjZrjEL75MhhAJNJhrFITJIkfgX/qRlBww8bXZk07mIP8ukH
 2M2N8QJPwubdJFTUuVbsog8QFb/NwcNdZoAy+yzOPLayG3Bx3RYlwya8wAfgQAtnvUwH
 5IxIarU7Ck0CeVz6UeRB/zKyO+8bgnviejsJLe9fgI8zMD7woTTdGqwiqIy5T+DNtcBl
 sLpb3mKLG8GFlj8xrGdqCJYxNA7GqPAXSEeQMLIQ/FB7F+fucIha43Nc/iwzweDFg0+e
 v3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748852216; x=1749457016;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KdEzzvB4E53h+C2iJPAR6RjEZ/WLCvGQ9vvdjuDP3X0=;
 b=iWwmL/2V50n2/xr577OplNANlujTk991pnkYwv9MAZfbO+NuiytZXZcRFMw7YnMl32
 C5cO49glyZOqEVXbzQwP1W8LYGX/IHW6lgJCe4cAvujafVuxT24UON2rDG3R3aLFt/P+
 2ksaS+g0kZbN8Yxd9/V+DRUYZaYQab4oM97KzL7oexmHqiv/k8JnASuUBeOmSBfBcPQ2
 Si+I8prbfZheuFnnQEQXBhqoCAURoFT5NoQvMiDDIGgpyUMfF4OrrvUrOtuvy3r5cgB1
 lefMFS9QVn/DyjiIeADba4OXzldlrLwaF35g6hQGsbLH+SP5MY/CNs8j6VhgwTZ8C0c8
 9ozg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRH765zXo6wNyp5JxezgcmUkEZkaKdg1p+Qrr0jTgyItUmZfvx4DSoLLbFqUOrlII8kYzUyTuCz6f@nongnu.org
X-Gm-Message-State: AOJu0YxKrIywvg8b/XZdgluSf9TPxyZiP+uLwpQT7POqXr5pKjWKY95q
 I14v2uigfEj6s12mgp5yPf0OO0t0XfcoWzuoC+eEHN6w5cDzC1k1SpCu4OuGxTeGA/U=
X-Gm-Gg: ASbGncs+0mJsNr+HaOhNlb/NcJNM5jV/vgrho3uuEDtsLTEvFo3z+NZbbyS/mkzl6SM
 7a+H7MB2wIVFdhArlJwxI+eiJOJjs9/9rRo3diPK/dHKT7eakKuYtzk2SQ/p2oAeKINcaoEEJU3
 gUtWY/u8g1POP7CR3ZtJP1Szv7lnbimEJnGTiiVytq45llhCETpe+wtzdZMD7nGFZM+MsQoFXzT
 9tgksuNr+gvBgNjRRyMEpBbSUmENhGvFX3yVtvDLnm29IawP5hR+FElIdAdtD7f9Y+o62V0TI1P
 qevcQ0ruSH2A/kOo7XmnEu+5m98yNkZz/r+I13oa5RroA7Wv2cKyC/rw9o6NETF0gqGxqe7LeCI
 Qq6v310PWyfGYWIIo7No=
X-Google-Smtp-Source: AGHT+IH/TALBw1oWsVFS4spS7Ot003+dEDWRq9cBSxbXHzAWmVO6tvFjfbBTtLlTNBeheJu4Br7yew==
X-Received: by 2002:a05:600c:1e06:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-450d655f86amr93206155e9.27.1748852215892; 
 Mon, 02 Jun 2025 01:16:55 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb80f6sm111435055e9.28.2025.06.02.01.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:16:55 -0700 (PDT)
Message-ID: <9b906e0c-f7a3-4deb-a380-8a202955e4c6@linaro.org>
Date: Mon, 2 Jun 2025 10:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson: fix Windows build
To: oltolm <oleg.tolmatcev@gmail.com>, qemu-devel@nongnu.org
References: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
Content-Language: en-US
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

(Cc'ing maintainers)

On 29/5/25 10:54, oltolm wrote:
> The build failed when run on Windows. I replaced calls to Unix programs
> like ´cat´ and ´true´ with calls to ´python´. I wrapped calls to
> ´os.path.relpath´ in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
> 
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>   contrib/plugins/meson.build         | 2 +-
>   scripts/tracetool/backend/ftrace.py | 9 ++++++++-
>   scripts/tracetool/backend/log.py    | 9 ++++++++-
>   scripts/tracetool/backend/syslog.py | 9 ++++++++-
>   tests/functional/meson.build        | 4 +---
>   tests/include/meson.build           | 2 +-
>   tests/tcg/plugins/meson.build       | 2 +-
>   trace/meson.build                   | 5 +++--
>   8 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index fa8a426c8..1876bc784 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -24,7 +24,7 @@ endif
>   if t.length() > 0
>     alias_target('contrib-plugins', t)
>   else
> -  run_target('contrib-plugins', command: find_program('true'))
> +  run_target('contrib-plugins', command: [python, '-c', ''])
>   endif
>   
>   plugin_modules += t
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index baed2ae61..81a5f93b3 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -13,6 +13,7 @@
>   
>   
>   import os.path
> +from pathlib import PurePath
>   
>   from tracetool import out
>   
> @@ -30,6 +31,12 @@ def generate_h(event, group):
>       if len(event.args) > 0:
>           argnames = ", " + argnames
>   
> +    try:
> +        event_filename = os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename = event.filename
> +    event_filename = PurePath(event_filename).as_posix()
> +
>       out('    {',
>           '        char ftrace_buf[MAX_TRACE_STRLEN];',
>           '        int unused __attribute__ ((unused));',
> @@ -47,7 +54,7 @@ def generate_h(event, group):
>           args=event.args,
>           event_id="TRACE_" + event.name.upper(),
>           event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=event_filename,
>           fmt=event.fmt.rstrip("\n"),
>           argnames=argnames)
>   
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index de27b7e62..241fbbbd0 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -13,6 +13,7 @@
>   
>   
>   import os.path
> +from pathlib import PurePath
>   
>   from tracetool import out
>   
> @@ -37,6 +38,12 @@ def generate_h(event, group):
>       else:
>           cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>   
> +    try:
> +        event_filename = os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename = event.filename
> +    event_filename = PurePath(event_filename).as_posix()
> +
>       out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>           '        if (message_with_timestamp) {',
>           '            struct timeval _now;',
> @@ -55,7 +62,7 @@ def generate_h(event, group):
>           '    }',
>           cond=cond,
>           event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=event_filename,
>           name=event.name,
>           fmt=event.fmt.rstrip("\n"),
>           argnames=argnames)
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
> index 012970f6c..2e010e7c9 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -13,6 +13,7 @@
>   
>   
>   import os.path
> +from pathlib import PurePath
>   
>   from tracetool import out
>   
> @@ -36,6 +37,12 @@ def generate_h(event, group):
>       else:
>           cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>   
> +    try:
> +        event_filename = os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename = event.filename
> +    event_filename = PurePath(event_filename).as_posix()
> +
>       out('    if (%(cond)s) {',
>           '#line %(event_lineno)d "%(event_filename)s"',
>           '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
> @@ -43,7 +50,7 @@ def generate_h(event, group):
>           '    }',
>           cond=cond,
>           event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=event_filename,
>           name=event.name,
>           fmt=event.fmt.rstrip("\n"),
>           argnames=argnames)
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cf..ee222888f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -411,6 +411,4 @@ foreach speed : ['quick', 'thorough']
>     endforeach
>   endforeach
>   
> -run_target('precache-functional',
> -           depends: precache_all,
> -           command: ['true'])
> +alias_target('precache-functional', precache_all)
> diff --git a/tests/include/meson.build b/tests/include/meson.build
> index 9abba308f..8e8d1ec4e 100644
> --- a/tests/include/meson.build
> +++ b/tests/include/meson.build
> @@ -13,4 +13,4 @@ test_qapi_outputs_extra = [
>   test_qapi_files_extra = custom_target('QAPI test (include)',
>                                         output: test_qapi_outputs_extra,
>                                         input: test_qapi_files,
> -                                      command: 'true')
> +                                      command: [python, '-c', ''])
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 41f02f2c7..029342282 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -17,7 +17,7 @@ endif
>   if t.length() > 0
>     alias_target('test-plugins', t)
>   else
> -  run_target('test-plugins', command: find_program('true'))
> +  run_target('test-plugins', command: [python, '-c', ''])
>   endif
>   
>   plugin_modules += t
> diff --git a/trace/meson.build b/trace/meson.build
> index 3df454935..ebce0154c 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -4,7 +4,7 @@ trace_events_files = []
>   foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>     if item in qapi_trace_events
>       trace_events_file = item
> -    group_name = item.full_path().split('/')[-1].underscorify()
> +    group_name = fs.name(item).underscorify()
>     else
>       trace_events_file = meson.project_source_root() / item / 'trace-events'
>       group_name = item == '.' ? 'root' : item.underscorify()
> @@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>     endif
>   endforeach
>   
> +cat = [ python, '-c', 'import fileinput;[print(line) for line in fileinput.input()]', '@INPUT@' ]
>   trace_events_all = custom_target('trace-events-all',
>                                    output: 'trace-events-all',
>                                    input: trace_events_files,
> -                                 command: [ 'cat', '@INPUT@' ],
> +                                 command: [ cat ],
>                                    capture: true,
>                                    install: get_option('trace_backends') != [ 'nop' ],
>                                    install_dir: qemu_datadir)


