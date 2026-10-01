Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED33CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMFH-0007Oy-5u; Thu, 01 Oct 2026 15:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMFE-0007Ky-HX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMFB-00022u-9x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790882100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfEayIbBoQMxjLvqEHfneVCZmSOEmasfoubSJl8WY18=;
 b=M77uuTDmQbWO8PL2c6PiAsQ+6DDz+yloe/D2W2siLzSML7XPLIX5McnfMXcy4SPI3iubUC
 +b/cr1mGzVnysDKDsrThHT0SVCEdV5yCDk6VqHk00i+//HpF3Wwy45Z0IASJgvyFuAmvBn
 +6z4HCSMdGm6tqP7EUR56GNZxqT5qlY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-Kmy0yRLSOSWK1rtt32jpwQ-1; Thu,
 01 Oct 2026 15:14:54 -0400
X-MC-Unique: Kmy0yRLSOSWK1rtt32jpwQ-1
X-Mimecast-MFC-AGG-ID: Kmy0yRLSOSWK1rtt32jpwQ_1790882090
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74CB61802578
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 19:14:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FE0C1800446; Thu,  1 Oct 2026 19:14:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 18/20] trace: stop tracking static disabled state
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
In-Reply-To: <20261001151228.3373747-19-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-19-berrange@redhat.com>
Date: Thu, 01 Oct 2026 23:14:36 +0400
Message-Id: <179088207684.2348671.5166153170222056421.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=24164;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3TXUdhBcUoXcE1qR1uS5Ycr2uZTsIFnkzg+jAEbKhRs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvrEfLiICOgmlODhRqzhT2xfyYQJIZJ/EMiTvJ
 flMoM3iZO+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar6xHwAKCRDa6OEJdZac
 5Tf/D/9GvWG7IRwKyVHsc38k+HyEZB8WyDKID6nCvKUX/BIoOJ1Sy+naaHQptlZ+TlG3Q7y5gZ7
 xYaFrkXz8BV38qewt3a2n+ADmcukC7cTinPJ3k9tBVFyz2Up/pk3s2Qq1vuOJ6M1yNyo3LxHK7U
 VgkDD/AvCQ88Y/gpZENGflwMqzw6gFMva9G2F2BIrkeNjPNNfWewuWrXfrYEasC0nfqEUztlHpV
 x21D/M08EjGYElOXWuXZLF0dil7OZ6SPvPAgC6BIkRcpFhkWCU5mGGtSHMZgamgDoHWFvZNd+Ph
 AeVPKQFlG4D3U45LT766AJJI1gex6SWuwegGUE0JgxFVHlvVP1LK7yE8BP6ZnyqIFpWzYRs7WEN
 jyMpILR0T5fiVTvQlQksofJBpKXs/r8sWdz68F0ubGcC193hCh1TOLRjLA91QZtkgUDf9fT6btr
 WJ8BxFrnVlqbH5pmPwzH7go+hNpiikyGHs/fL4IzPm784k+UDQsBTRFGZrcrUC/aYtAD9nOS7uh
 GE5iRiFnIZdy9j5ECgt7wZcI12Rii/rb25Ui4/qVG+cAN9I+6GnfpQiliKcoVzT4RCeaoobrFUZ
 BdIIAirY4KquRABI4CG358fudfxoosQAW3OCY7o716KWYq6NtQifC8i0RzBa1AoZfJ4/Wcc2/vF
 VVtC7cD0Z2nhRhg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> The TraceEvent struct contains a "bool sstate" field which track whether
> a trace event was disabled statically. i.e. at build time via the
> "disable" property annotation in trace-events.
> 
> The only runtime use of this field is to let "trace-event-get-state"
> report that an event is "unavailable" instead of reporting an error for
> an unknown trace event.
> 
> Trace events are not ABI so their names can change and the event can
> come and go at any time. Thus there is little utility in reporting the
> existence of a disabled event that cannot ever be used at runtime.
> 
> Removing the "bool sstate" field from TraceEvent saves 8 bytes of
> space in the struct, adding up to approx 64 KB across all current
> events.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261001151228.3373747-19-berrange@redhat.com>

Need a tracing.rst documentation update too.

>
> diff --git a/qapi/trace.json b/qapi/trace.json
> index de369dae6b53..a5aaf2cab0ea 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -17,8 +17,6 @@
>  #
>  # State of a tracing event.
>  #
> -# @unavailable: The event is statically disabled.
> -#
>  # @disabled: The event is dynamically disabled.
>  #
>  # @enabled: The event is dynamically enabled.
> @@ -26,7 +24,7 @@
>  # Since: 2.2
>  ##
>  { 'enum': 'TraceEventState',
> -  'data': ['unavailable', 'disabled', 'enabled'] }
> +  'data': ['disabled', 'enabled'] }

>  
>  ##
>  # @TraceEventInfo:
> @@ -73,6 +71,7 @@
>  # @enable: Whether to enable tracing.
>  #
>  # @ignore-unavailable: Do not match unavailable events with @name.
> +#      Deprecated: since 11.2
>  #
>  # Since: 2.2
>  #

> diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
> index 5f6669c917c7..9f06894623e2 100644
> --- a/scripts/tracetool/format/c.py
> +++ b/scripts/tracetool/format/c.py
> @@ -39,12 +39,10 @@ def generate(events, backend, group):
>                  '    .id = 0,',
>                  '#endif',
>                  '    .name = \"%(name)s\",',
> -                '    .sstate = %(sstate)s,',
>                  '    .dstate = &%(dstate)s',
>                  '};',
>                  event = e.api(e.QEMU_EVENT),
>                  name = e.name,
> -                sstate = "TRACE_%s_ENABLED" % e.name.upper(),
>                  dstate = e.api(e.QEMU_DSTATE))
>  
>          out('TraceEvent *%(group)s_trace_events[] = {',
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index 6ffb7256e314..3ca92ba5fbe8 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -38,14 +38,6 @@ def generate(events, backend, group):
>          for e in events:
>              out('#define %s 0' % e.api(e.QEMU_DSTATE))
>  
> -    # static state
> -    for e in events:
> -        if 'disable' in e.properties:
> -            enabled = 0
> -        else:
> -            enabled = 1
> -        out('#define TRACE_%s_ENABLED %d' % (e.name.upper(), enabled))
> -
>      backend.generate_begin(events, group)
>  
>      for e in events:
> diff --git a/stubs/trace-control.c b/stubs/trace-control.c
> index 3f196835db00..6016307ed8b0 100644
> --- a/stubs/trace-control.c
> +++ b/stubs/trace-control.c
> @@ -14,7 +14,6 @@
>  void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
>  {
>      bool state_pre;
> -    assert(trace_event_get_state_static(ev));
>  
>      /*
>       * We ignore the "vcpu" property here, since there's no target code. Then
> diff --git a/tests/tracetool/all.c b/tests/tracetool/all.c
> index 3b8d4d32d172..670f9f06e855 100644
> --- a/tests/tracetool/all.c
> +++ b/tests/tracetool/all.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
> index a2c2d40388e7..6eed86edb4d8 100644
> --- a/tests/tracetool/all.h
> +++ b/tests/tracetool/all.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #ifndef SDT_USE_VARIADIC
>  #define SDT_USE_VARIADIC 1
>  #endif
> @@ -59,16 +57,16 @@ static inline void trace_test_blah(void *context, const char *filename)
>      if (trace_event_get_state(TRACE_TEST_BLAH)) {
>  #line 4 "trace-events"
>          ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
> -#line 62 "all.h"
> +#line 60 "all.h"
>          if (qemu_loglevel_mask(LOG_TRACE)) {
>  #line 4 "trace-events"
>              qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
> -#line 66 "all.h"
> +#line 64 "all.h"
>          }
>          _simple_trace_test_blah(context, filename);
>  #line 4 "trace-events"
>          syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
> -#line 71 "all.h"
> +#line 69 "all.h"
>      }
>  }
>  
> @@ -89,16 +87,16 @@ static inline void trace_test_wibble(void *context, int value)
>      if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
>  #line 5 "trace-events"
>          ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
> -#line 91 "all.h"
> +#line 89 "all.h"
>          if (qemu_loglevel_mask(LOG_TRACE)) {
>  #line 5 "trace-events"
>              qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
> -#line 95 "all.h"
> +#line 93 "all.h"
>          }
>          _simple_trace_test_wibble(context, value);
>  #line 5 "trace-events"
>          syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
> -#line 100 "all.h"
> +#line 98 "all.h"
>      }
>  }
>  #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
> diff --git a/tests/tracetool/dtrace.c b/tests/tracetool/dtrace.c
> index f83d06252eaa..d51ba85503a8 100644
> --- a/tests/tracetool/dtrace.c
> +++ b/tests/tracetool/dtrace.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/dtrace.h b/tests/tracetool/dtrace.h
> index 0b5b47089e81..b9283851eb03 100644
> --- a/tests/tracetool/dtrace.h
> +++ b/tests/tracetool/dtrace.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #ifndef SDT_USE_VARIADIC
>  #define SDT_USE_VARIADIC 1
>  #endif
> diff --git a/tests/tracetool/ftrace.c b/tests/tracetool/ftrace.c
> index f83d06252eaa..d51ba85503a8 100644
> --- a/tests/tracetool/ftrace.c
> +++ b/tests/tracetool/ftrace.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
> index b34eef17d10e..4eba6b4d5991 100644
> --- a/tests/tracetool/ftrace.h
> +++ b/tests/tracetool/ftrace.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #include "trace/ftrace.h"
>  
>  
> @@ -24,7 +22,7 @@ static inline void trace_test_blah(void *context, const char *filename)
>      if (trace_event_get_state(TRACE_TEST_BLAH)) {
>  #line 4 "trace-events"
>          ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
> -#line 28 "ftrace.h"
> +#line 26 "ftrace.h"
>      }
>  }
>  
> @@ -37,7 +35,7 @@ static inline void trace_test_wibble(void *context, int value)
>      if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
>  #line 5 "trace-events"
>          ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
> -#line 41 "ftrace.h"
> +#line 39 "ftrace.h"
>      }
>  }
>  #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
> diff --git a/tests/tracetool/log.c b/tests/tracetool/log.c
> index f83d06252eaa..d51ba85503a8 100644
> --- a/tests/tracetool/log.c
> +++ b/tests/tracetool/log.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
> index fe08277887f7..cf37ed3ce263 100644
> --- a/tests/tracetool/log.h
> +++ b/tests/tracetool/log.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #include "qemu/log-for-trace.h"
>  
>  
> @@ -26,7 +24,7 @@ static inline void trace_test_blah(void *context, const char *filename)
>          if (qemu_loglevel_mask(LOG_TRACE)) {
>  #line 4 "trace-events"
>              qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
> -#line 29 "log.h"
> +#line 27 "log.h"
>          }
>      }
>  }
> @@ -42,7 +40,7 @@ static inline void trace_test_wibble(void *context, int value)
>          if (qemu_loglevel_mask(LOG_TRACE)) {
>  #line 5 "trace-events"
>              qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
> -#line 44 "log.h"
> +#line 42 "log.h"
>          }
>      }
>  }
> diff --git a/tests/tracetool/nop.h b/tests/tracetool/nop.h
> index 64b6b0056841..007715779438 100644
> --- a/tests/tracetool/nop.h
> +++ b/tests/tracetool/nop.h
> @@ -8,8 +8,6 @@
>  
>  #define _TRACE_TEST_BLAH_DSTATE 0
>  #define _TRACE_TEST_WIBBLE_DSTATE 0
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  
>  #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
>      false)
> diff --git a/tests/tracetool/simple.c b/tests/tracetool/simple.c
> index 3b8d4d32d172..670f9f06e855 100644
> --- a/tests/tracetool/simple.c
> +++ b/tests/tracetool/simple.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/simple.h b/tests/tracetool/simple.h
> index 735cb21d9113..9b066364b0ae 100644
> --- a/tests/tracetool/simple.h
> +++ b/tests/tracetool/simple.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  void _simple_trace_test_blah(void *context, const char *filename);
>  void _simple_trace_test_wibble(void *context, int value);
>  
> diff --git a/tests/tracetool/syslog.c b/tests/tracetool/syslog.c
> index f83d06252eaa..d51ba85503a8 100644
> --- a/tests/tracetool/syslog.c
> +++ b/tests/tracetool/syslog.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/syslog.h b/tests/tracetool/syslog.h
> index 4203b8b37dcc..6a9304489f6c 100644
> --- a/tests/tracetool/syslog.h
> +++ b/tests/tracetool/syslog.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #include <syslog.h>
>  
>  
> @@ -24,7 +22,7 @@ static inline void trace_test_blah(void *context, const char *filename)
>      if (trace_event_get_state(TRACE_TEST_BLAH)) {
>  #line 4 "trace-events"
>          syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
> -#line 28 "syslog.h"
> +#line 26 "syslog.h"
>      }
>  }
>  
> @@ -37,7 +35,7 @@ static inline void trace_test_wibble(void *context, int value)
>      if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
>  #line 5 "trace-events"
>          syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
> -#line 41 "syslog.h"
> +#line 39 "syslog.h"
>      }
>  }
>  #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
> diff --git a/tests/tracetool/ust.c b/tests/tracetool/ust.c
> index f83d06252eaa..d51ba85503a8 100644
> --- a/tests/tracetool/ust.c
> +++ b/tests/tracetool/ust.c
> @@ -12,7 +12,6 @@ TraceEvent _TRACE_TEST_BLAH_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
>      .dstate = &_TRACE_TEST_BLAH_DSTATE
>  };
>  TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> @@ -20,7 +19,6 @@ TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
>      .id = 0,
>  #endif
>      .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
>      .dstate = &_TRACE_TEST_WIBBLE_DSTATE
>  };
>  TraceEvent *testsuite_trace_events[] = {
> diff --git a/tests/tracetool/ust.h b/tests/tracetool/ust.h
> index 079b2c744917..c6c5d6d7c1cf 100644
> --- a/tests/tracetool/ust.h
> +++ b/tests/tracetool/ust.h
> @@ -10,8 +10,6 @@ extern TraceEvent _TRACE_TEST_BLAH_EVENT;
>  extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
>  extern uint8_t _TRACE_TEST_BLAH_DSTATE;
>  extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -#define TRACE_TEST_BLAH_ENABLED 1
> -#define TRACE_TEST_WIBBLE_ENABLED 1
>  #include <lttng/tracepoint.h>
>  #include "trace-ust-testsuite.h"
>  
> diff --git a/trace/control-internal.h b/trace/control-internal.h
> index f626b0472644..9a95e6714bb4 100644
> --- a/trace/control-internal.h
> +++ b/trace/control-internal.h
> @@ -33,12 +33,6 @@ static inline const char * trace_event_get_name(TraceEvent *ev)
>      return ev->name;
>  }
>  
> -static inline bool trace_event_get_state_static(TraceEvent *ev)
> -{
> -    assert(ev != NULL);
> -    return ev->sstate;
> -}
> -
>  /* it's on fast path, avoid consistency checks (asserts) */
>  #define trace_event_get_state_dynamic_by_id(id) \
>      (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)
> diff --git a/trace/control-target.c b/trace/control-target.c
> index 87b0f5037df1..348125a5822b 100644
> --- a/trace/control-target.c
> +++ b/trace/control-target.c
> @@ -12,8 +12,6 @@
>  
>  void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
>  {
> -    assert(trace_event_get_state_static(ev));
> -
>      bool state_pre = *ev->dstate;
>      if (state_pre != state) {
>          if (state) {
> diff --git a/trace/control.c b/trace/control.c
> index 947b220056ac..d414b1a90725 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -167,15 +167,6 @@ static void do_trace_enable_events(const char *line_buf)
>  
>      trace_event_iter_init_pattern(&iter, line_ptr);
>      while ((ev = trace_event_iter_next(&iter)) != NULL) {
> -        if (!trace_event_get_state_static(ev)) {
> -            if (!is_pattern) {
> -                warn_report("trace event '%s' is not traceable",
> -                            line_ptr);
> -                return;
> -            }
> -            continue;
> -        }
> -
>          /* start tracing */
>          trace_event_set_state_dynamic(ev, enable);
>          if (!is_pattern) {
> diff --git a/trace/control.h b/trace/control.h
> index e77c07a8e68e..80eb2bd14e6f 100644
> --- a/trace/control.h
> +++ b/trace/control.h
> @@ -107,13 +107,13 @@ static const char * trace_event_get_name(TraceEvent *ev);
>   * impact.
>   */
>  #define trace_event_get_state(id)                       \
> -    ((id ##_ENABLED) && trace_event_get_state_dynamic_by_id(id))
> +    (trace_event_get_state_dynamic_by_id(id))
>  
>  /**
>   * trace_event_get_state_backends:
>   * @id: Event identifier name.
>   *
> - * Get the tracing state of an event, both static and dynamic state from all
> + * Get the tracing state of an event from all
>   * compiled-in backends.
>   *
>   * If the event has the disabled property, the check will have no performance
> @@ -123,18 +123,7 @@ static const char * trace_event_get_name(TraceEvent *ev);
>   * does not have the disabled property.
>   */

It should also drop the mention of "disabled property"

>  #define trace_event_get_state_backends(id)              \
> -    ((id ##_ENABLED) && id ##_BACKEND_DSTATE())
> -
> -/**
> - * trace_event_get_state_static:
> - * @id: Event identifier.
> - *
> - * Get the static tracing state of an event.
> - *
> - * Use the define 'TRACE_${EVENT_NAME}_ENABLED' for compile-time checks (it will
> - * be set to 1 or 0 according to the presence of the disabled property).
> - */
> -static bool trace_event_get_state_static(TraceEvent *ev);
> +    (id ##_BACKEND_DSTATE())
>  
>  /**
>   * trace_event_get_state_dynamic:
> @@ -148,7 +137,6 @@ static bool trace_event_get_state_dynamic(TraceEvent *ev);
>   *
>   * Set the dynamic tracing state of an event.
>   *
> - * Pre-condition: trace_event_get_state_static(ev) == true
>   */
>  void trace_event_set_state_dynamic(TraceEvent *ev, bool state);
>  
> diff --git a/trace/event-internal.h b/trace/event-internal.h
> index ad1578aa2c53..40f06691063a 100644
> --- a/trace/event-internal.h
> +++ b/trace/event-internal.h
> @@ -14,7 +14,6 @@
>   * TraceEvent:
>   * @id: Unique event identifier.
>   * @name: Event name.
> - * @sstate: Static tracing state.
>   * @dstate: Dynamic tracing state
>   *
>   * Opaque generic description of a tracing event.
> @@ -24,7 +23,6 @@ typedef struct TraceEvent {
>      uint32_t id;
>  #endif
>      const char * name;
> -    const bool sstate;
>      uint8_t *dstate;
>  } TraceEvent;
>  
> diff --git a/trace/qmp.c b/trace/qmp.c
> index 074a27b204fd..331496a1471d 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -11,9 +11,10 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-trace.h"
>  #include "control.h"
> +#include "qemu/error-report.h"
>  
>  
> -static bool check_events(bool ignore_unavailable, bool is_pattern,
> +static bool check_events(bool is_pattern,
>                           const char *name, Error **errp)
>  {
>      if (!is_pattern) {
> @@ -24,27 +25,8 @@ static bool check_events(bool ignore_unavailable, bool is_pattern,
>              error_setg(errp, "unknown event \"%s\"", name);
>              return false;
>          }
> -
> -        /* error for unavailable event */
> -        if (!ignore_unavailable && !trace_event_get_state_static(ev)) {
> -            error_setg(errp, "event \"%s\" is disabled", name);
> -            return false;
> -        }
> -
> -        return true;
> -    } else {
> -        /* error for unavailable events */
> -        TraceEventIter iter;
> -        TraceEvent *ev;
> -        trace_event_iter_init_pattern(&iter, name);
> -        while ((ev = trace_event_iter_next(&iter)) != NULL) {
> -            if (!ignore_unavailable && !trace_event_get_state_static(ev)) {
> -                error_setg(errp, "event \"%s\" is disabled", trace_event_get_name(ev));
> -                return false;
> -            }
> -        }
> -        return true;
>      }
> +    return true;
>  }
>  
>  TraceEventInfoList *qmp_trace_event_get_state(const char *name,
> @@ -56,7 +38,7 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
>      bool is_pattern = trace_event_is_pattern(name);
>  
>      /* Check events */
> -    if (!check_events(true, is_pattern, name, errp)) {
> +    if (!check_events(is_pattern, name, errp)) {
>          return NULL;
>      }
>  
> @@ -68,14 +50,10 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
>          value = g_new(TraceEventInfo, 1);
>          value->name = g_strdup(trace_event_get_name(ev));
>  
> -        if (!trace_event_get_state_static(ev)) {
> -            value->state = TRACE_EVENT_STATE_UNAVAILABLE;
> +        if (trace_event_get_state_dynamic(ev)) {
> +            value->state = TRACE_EVENT_STATE_ENABLED;
>          } else {
> -            if (trace_event_get_state_dynamic(ev)) {
> -                value->state = TRACE_EVENT_STATE_ENABLED;
> -            } else {
> -                value->state = TRACE_EVENT_STATE_DISABLED;
> -            }
> +            value->state = TRACE_EVENT_STATE_DISABLED;
>          }
>          QAPI_LIST_PREPEND(events, value);
>      }
> @@ -91,18 +69,19 @@ void qmp_trace_event_set_state(const char *name, bool enable,
>      TraceEvent *ev;
>      bool is_pattern = trace_event_is_pattern(name);
>  
> +    if (has_ignore_unavailable && ignore_unavailable) {
> +        warn_report_once("the 'ignore-unavailable' property is deprecated "
> +                         "and has no effect");
> +    }
> +
>      /* Check events */
> -    if (!check_events(has_ignore_unavailable && ignore_unavailable,
> -                      is_pattern, name, errp)) {
> +    if (!check_events(is_pattern, name, errp)) {
>          return;
>      }
>  
>      /* Apply changes (all errors checked above) */
>      trace_event_iter_init_pattern(&iter, name);
>      while ((ev = trace_event_iter_next(&iter)) != NULL) {
> -        if (!trace_event_get_state_static(ev)) {
> -            continue;
> -        }
>          trace_event_set_state_dynamic(ev, enable);
>      }
>  }

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


