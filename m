Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12EC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWxx-0007h4-DF; Tue, 01 Apr 2025 04:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzWxv-0007gv-3i
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzWxs-0000LX-OB
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743496038;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3fkN1pYjHsU9EtxFPbRwl9Y3AHoEMyPFV1fhUPfcGF0=;
 b=O9Na2uBzLrdGg/FBWzRYt2BqPvSErg0oza/fD6AKRF2//HXeODdoAfCUiiAv6REEdu48zu
 a0uSslUUUWxp00yGKUCnvAX51C6o0CQrdy9PW0jlkaJ7lpm62YM6huHBZ5lLCL702mwpsy
 ndqoTxe7pe1WYUKPjNZJk8d2dbtFV8M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-0bJHg54-O-Gckbp6piClhA-1; Tue,
 01 Apr 2025 04:27:17 -0400
X-MC-Unique: 0bJHg54-O-Gckbp6piClhA-1
X-Mimecast-MFC-AGG-ID: 0bJHg54-O-Gckbp6piClhA_1743496036
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81D351955DC6; Tue,  1 Apr 2025 08:27:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0A1D1956094; Tue,  1 Apr 2025 08:27:11 +0000 (UTC)
Date: Tue, 1 Apr 2025 09:27:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: saman <saman@enumclass.cc>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] Rust: Add tracing and logging support for Rust code
Message-ID: <Z-ujXI126OC9lZpi@redhat.com>
References: <20250401002633.738345-1-saman@enumclass.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401002633.738345-1-saman@enumclass.cc>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 31, 2025 at 07:26:33PM -0500, saman wrote:
> This change introduces initial support for tracing and logging in Rust-based
> QEMU code. As an example, tracing and logging have been implemented in the
> pl011 device, which is written in Rust.
> 
> - Updated `rust/wrapper.h` to include the `qemu/log.h` and `hw/char/trace.h` header.
> - Added log.rs to wrap `qemu_log_mask` and `qemu_log_mask_and_addr`
> - Modified `tracetool` scripts to move C function implementation from
>   header to .c
> - Added log and trace in rust version of PL011 device
> 
> Future enhancements could include generating idiomatic Rust APIs for tracing
> using the tracetool scripts
> 
> Signed-off-by: saman <saman@enumclass.cc>
> ---
>  include/qemu/log-for-trace.h        |  5 +--
>  rust/hw/char/pl011/src/device.rs    | 34 +++++++++++++++---
>  rust/hw/char/pl011/src/registers.rs | 20 +++++++++++
>  rust/qemu-api/meson.build           |  1 +
>  rust/qemu-api/src/lib.rs            |  1 +
>  rust/qemu-api/src/log.rs            | 54 +++++++++++++++++++++++++++++
>  rust/wrapper.h                      |  2 ++
>  scripts/tracetool/format/c.py       | 16 +++++++++
>  scripts/tracetool/format/h.py       | 11 ++----
>  util/log.c                          |  5 +++
>  10 files changed, 131 insertions(+), 18 deletions(-)
>  create mode 100644 rust/qemu-api/src/log.rs
> 
> diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
> index 69edf0d588..f2d383f89c 100644
> --- a/scripts/tracetool/format/c.py
> +++ b/scripts/tracetool/format/c.py
> @@ -43,6 +43,22 @@ def generate(events, backend, group):
>              sstate = "TRACE_%s_ENABLED" % e.name.upper(),
>              dstate = e.api(e.QEMU_DSTATE))
>  
> +        cond = "true"
> +
> +        out('',
> +            'void %(api)s(%(args)s)',
> +            '{',
> +            '    if (%(cond)s) {',
> +            '        %(api_nocheck)s(%(names)s);',
> +            '    }',
> +            '}',
> +            api=e.api(),
> +            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
> +            args=e.args,
> +            names=", ".join(e.args.names()),
> +            cond=cond
> +            )
> +
>      out('TraceEvent *%(group)s_trace_events[] = {',
>          group = group.lower())
>  
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index ea126b07ea..16b360ae49 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -74,17 +74,10 @@ def generate(events, backend, group):
>          cond = "true"
>  
>          out('',
> -            'static inline void %(api)s(%(args)s)',
> -            '{',
> -            '    if (%(cond)s) {',
> -            '        %(api_nocheck)s(%(names)s);',
> -            '    }',
> -            '}',
> +            'void %(api)s(%(args)s);',
>              api=e.api(),
> -            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
>              args=e.args,
> -            names=", ".join(e.args.names()),
> -            cond=cond)
> +            )
>  
>      backend.generate_end(events, group)
>

This is a non-trivial degradation for the tracing code. The code is
generated in an inline function in the header so that when a probe
point is not active, it has as little overhead as possible - with
some backends it will just a 'nop' instruction.  With this change
every probe is turned into a function call with no possiblity to
optimize away this overhead.

IMHO tracing in Rust needs to be done by generating native Rust
code for the (sub)set of trace  backends that we care about, and
not attempt to wrap the C trace code from Rust.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


