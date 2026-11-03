Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5B606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LKzeaykt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALS-0007VH-20; Tue, 03 Nov 2026 03:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALF-0007U9-56
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALD-0006MX-Cw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yINZvLitU7n19WhF0+Pe65Akt5Q+gez7fSSnwr+pcC8=;
 b=LKzeayktENPdnKJQYHAsGk4Ern6ArU5843q3E44M29/u3PjOTxe/mc2JWC/5iRl1Xc6xOT
 0NgBn8yuXtRsqe/Cx3jDYvnzAOBkDx3grfeI9PS0bC0GbN9vTa5teET55QcJIJh5eM3wO+
 3Zk6YzBePrkLK1ZOQcYRDZwo3wR0mCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-urKIzsMhPWqvVAC30PcNrg-1; Tue,
 03 Nov 2026 03:57:58 -0500
X-MC-Unique: urKIzsMhPWqvVAC30PcNrg-1
X-Mimecast-MFC-AGG-ID: urKIzsMhPWqvVAC30PcNrg_1793696278
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDDE61954236
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:57:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3DB41800586; Tue,  3 Nov 2026 08:57:56 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 11/25] trace: don't emit TraceEvent structs when
 'nop' backend is used
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20261102142844.3464712-12-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-12-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:46 +0400
Message-Id: <179369626696.418241.2752347843196837868.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6414;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ODE3HeZNdYfqVJ47ZGYLoFDRcSX6oPokCxjWaHwN244=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIORLcdmgWS1bmIikS5TjcXdNMLkOIKpSLSK
 YGf+0EbSDiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5YyeD/4n1u8Bx6ps5wLQR+5XLLL0H/OE+2ekv9s6V1dT2pkjGHiTwCtjZd/wpHn6PvJ492OqYhR
 Kf7MkT7bADJtrf4WzXP+PjX2N8QeVYE3coXp1xXkDitC3ei/hnJLXBH5qUKyH/+6p5WI7YaAyRG
 Nn86iLyEu4sM1Q8hIZ6pyn73+Q9ZN1x+azRlWNZYXZbfQKwAcyhricmBvaoUeGOky06RgmWMV35
 Ax4hMDESSfSdqne3poIu5DVeRRDVyappm2hgoDV4JKHtMNqQM5JjdEcYik+dTCGk6TeKWWW2mxN
 RpzqzJX4g5MJ8n9I2A08xkfswwXfYq/S34h6S66eq/H1aESi3/lKiXvNNf/Db39gwUhiack18WZ
 GP0WEly3HiFyxA6Sb+W99Mrf09YKX6EcX7E9xxSDMSydtHCRRPFDSy1UV0acfMK8wRhe7kw9p8/
 qacJr2lr1CJ7aTzRSeEVtKJdAaRIpmYixww4mUHNeK7FrL9LbSmm8cUo7u6KsXre/Mkd6Pr27aH
 fxskBN7RZSyfbUJxkIRMVxQkJctLmaSYEAmczxvMJdcW5XwIe7ZJt+5eYaSnU3SvtHpvOjXm24e
 xDeGw0a9fyhErgp0Lyu0Y4OGUeTXNc9tr9eaHLfRR0xKfWpjhCQbxU8A0RngwVjcL+8l7xrPG7c
 pvxENqWIEXf/TOw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The 'nop' backend is a short-hand for no trace probe usage
> at all. The emitted functions become a no-op, and as such
> there is no need to emit the TraceEvent structs, nor the
> DSTATE variables they reference.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261102142844.3464712-12-berrange@redhat.com>
> ---
>  scripts/tracetool/format/c.py | 75 ++++++++++++++++++-----------------
>  scripts/tracetool/format/h.py | 16 +++++---
>  tests/tracetool/nop.c         | 29 --------------
>  tests/tracetool/nop.h         |  6 +--
>  4 files changed, 50 insertions(+), 76 deletions(-)
>
> diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
> index de1c154a8819..5f6669c917c7 100644
> --- a/scripts/tracetool/format/c.py
> +++ b/scripts/tracetool/format/c.py
> @@ -29,41 +29,42 @@ def generate(events, backend, group):
>          '#include "%s"' % header,
>          '')
>  
> -    for e in events:
> -        out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
> +    if len(list(backend.backend_modules())):
> +        for e in events:
> +            out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
>  
> -    for e in events:
> -        out('TraceEvent %(event)s = {',
> -            '#ifdef CONFIG_TRACE_SIMPLE',
> -            '    .id = 0,',
> -            '#endif',
> -            '    .name = \"%(name)s\",',
> -            '    .sstate = %(sstate)s,',
> -            '    .dstate = &%(dstate)s',
> +        for e in events:
> +            out('TraceEvent %(event)s = {',
> +                '#ifdef CONFIG_TRACE_SIMPLE',
> +                '    .id = 0,',
> +                '#endif',
> +                '    .name = \"%(name)s\",',
> +                '    .sstate = %(sstate)s,',
> +                '    .dstate = &%(dstate)s',
> +                '};',
> +                event = e.api(e.QEMU_EVENT),
> +                name = e.name,
> +                sstate = "TRACE_%s_ENABLED" % e.name.upper(),
> +                dstate = e.api(e.QEMU_DSTATE))
> +
> +        out('TraceEvent *%(group)s_trace_events[] = {',
> +            group = group.lower())
> +
> +        for e in events:
> +            out('    &%(event)s,', event = e.api(e.QEMU_EVENT))
> +
> +        out('  NULL,',
>              '};',
> -            event = e.api(e.QEMU_EVENT),
> -            name = e.name,
> -            sstate = "TRACE_%s_ENABLED" % e.name.upper(),
> -            dstate = e.api(e.QEMU_DSTATE))
> +            '')
>  
> -    out('TraceEvent *%(group)s_trace_events[] = {',
> -        group = group.lower())
> +        out('static void trace_%(group)s_register_events(void)',
> +            '{',
> +            '    trace_event_register_group(%(group)s_trace_events);',
> +            '}',
> +            'trace_init(trace_%(group)s_register_events)',
> +            group = group.lower())
>  
> -    for e in events:
> -        out('    &%(event)s,', event = e.api(e.QEMU_EVENT))
> -
> -    out('  NULL,',
> -        '};',
> -        '')
> -
> -    out('static void trace_%(group)s_register_events(void)',
> -        '{',
> -        '    trace_event_register_group(%(group)s_trace_events);',
> -        '}',
> -        'trace_init(trace_%(group)s_register_events)',
> -        group = group.lower())
> -
> -    backend.generate_begin(active_events, group)
> -    for event in active_events:
> -        backend.generate(event, group)
> -    backend.generate_end(active_events, group)
> +        backend.generate_begin(active_events, group)
> +        for event in active_events:
> +            backend.generate(event, group)
> +        backend.generate_end(active_events, group)
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index 4dc1ad7eb158..6ffb7256e314 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -27,12 +27,16 @@ def generate(events, backend, group):
>          '#include "%s"' % header,
>          '')
>  
> -    for e in events:
> -        out('extern TraceEvent %(event)s;',
> -            event = e.api(e.QEMU_EVENT))
> +    if len(list(backend.backend_modules())):
> +        for e in events:
> +            out('extern TraceEvent %(event)s;',
> +                event = e.api(e.QEMU_EVENT))
>  
> -    for e in events:
> -        out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
> +        for e in events:
> +            out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
> +    else:
> +        for e in events:
> +            out('#define %s 0' % e.api(e.QEMU_DSTATE))
>  
>      # static state
>      for e in events:
> diff --git a/tests/tracetool/nop.c b/tests/tracetool/nop.c
> index f83d06252eaa..d34cc0ca7426 100644
> --- a/tests/tracetool/nop.c
> +++ b/tests/tracetool/nop.c
> @@ -5,32 +5,3 @@
>  #include "qemu/module.h"
>  #include "trace-testsuite.h"
>  
> -uint8_t _TRACE_TEST_BLAH_DSTATE;
> -uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> -TraceEvent _TRACE_TEST_BLAH_EVENT = {
> -#ifdef CONFIG_TRACE_SIMPLE
> -    .id = 0,
> -#endif
> -    .name = "test_blah",
> -    .sstate = TRACE_TEST_BLAH_ENABLED,
> -    .dstate = &_TRACE_TEST_BLAH_DSTATE
> -};
> -TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> -#ifdef CONFIG_TRACE_SIMPLE
> -    .id = 0,
> -#endif
> -    .name = "test_wibble",
> -    .sstate = TRACE_TEST_WIBBLE_ENABLED,
> -    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
> -};
> -TraceEvent *testsuite_trace_events[] = {
> -    &_TRACE_TEST_BLAH_EVENT,
> -    &_TRACE_TEST_WIBBLE_EVENT,
> -  NULL,
> -};
> -
> -static void trace_testsuite_register_events(void)
> -{
> -    trace_event_register_group(testsuite_trace_events);
> -}
> -trace_init(trace_testsuite_register_events)
> diff --git a/tests/tracetool/nop.h b/tests/tracetool/nop.h
> index 443f5e0cf6ee..64b6b0056841 100644
> --- a/tests/tracetool/nop.h
> +++ b/tests/tracetool/nop.h
> @@ -6,10 +6,8 @@
>  
>  #include "trace/control.h"
>  
> -extern TraceEvent _TRACE_TEST_BLAH_EVENT;
> -extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
> -extern uint8_t _TRACE_TEST_BLAH_DSTATE;
> -extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
> +#define _TRACE_TEST_BLAH_DSTATE 0
> +#define _TRACE_TEST_WIBBLE_DSTATE 0

The rust generator should be adjusted too

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


