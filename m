Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7854CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqs32-0002tn-5C; Tue, 26 Aug 2025 07:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqs2s-0002sR-FU
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqs2j-0002Bx-Dk
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756208442;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96qN0QId4jkd8WkXhVCNog4+s0bhXs1iJvc2hs+MSgo=;
 b=NG2jZ+e1JW7oMVSPfWVC3bOtnt5dmT8w/O5JVuYjYwEY37KqZP/yV2Rwd7VeGohpY4kfC5
 0x2MX0tndmhMdQ3M3csD97JOI8aoRHdf3H3Ph8r3OqhWXxVn7b4d0s/iIaEYw66IpgKcYd
 QZgc0mX818jJuErD0IbCsPTwnboR01Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-JxGGsGVcODm00SI37jRJWQ-1; Tue,
 26 Aug 2025 07:40:40 -0400
X-MC-Unique: JxGGsGVcODm00SI37jRJWQ-1
X-Mimecast-MFC-AGG-ID: JxGGsGVcODm00SI37jRJWQ_1756208439
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 544CD1800342; Tue, 26 Aug 2025 11:40:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D2C81955F24; Tue, 26 Aug 2025 11:40:36 +0000 (UTC)
Date: Tue, 26 Aug 2025 12:40:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
Message-ID: <aK2dMdD1i88PFn1j@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822122655.1353197-4-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 22, 2025 at 02:26:44PM +0200, Paolo Bonzini wrote:
> This simplifies the Python code and reduces the size of the tracepoints.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tracetool/ftrace.h            | 28 ++++++----------------------
>  trace/ftrace.h                      |  1 +
>  trace/ftrace.c                      | 15 +++++++++++++++
>  scripts/tracetool/backend/ftrace.py | 12 ++----------
>  4 files changed, 24 insertions(+), 32 deletions(-)
> 
> diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
> index fe22ea0f09f..1dfe4239413 100644
> --- a/tests/tracetool/ftrace.h
> +++ b/tests/tracetool/ftrace.h
> @@ -21,18 +21,10 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
>  
>  static inline void trace_test_blah(void *context, const char *filename)
>  {
> -    {
> -        char ftrace_buf[MAX_TRACE_STRLEN];
> -        int unused __attribute__ ((unused));
> -        int trlen;
> -        if (trace_event_get_state(TRACE_TEST_BLAH)) {
> +    if (trace_event_get_state(TRACE_TEST_BLAH)) {
>  #line 4 "trace-events"
> -            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
> -                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
> -#line 33 "ftrace.h"
> -            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
> -            unused = write(trace_marker_fd, ftrace_buf, trlen);
> -        }
> +        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
> +#line 28 "ftrace.h"
>      }
>  }
>  
> @@ -42,18 +34,10 @@ static inline void trace_test_blah(void *context, const char *filename)
>  
>  static inline void trace_test_wibble(void *context, int value)
>  {
> -    {
> -        char ftrace_buf[MAX_TRACE_STRLEN];
> -        int unused __attribute__ ((unused));
> -        int trlen;
> -        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
> +    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
>  #line 5 "trace-events"
> -            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
> -                             "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
> -#line 54 "ftrace.h"
> -            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
> -            unused = write(trace_marker_fd, ftrace_buf, trlen);
> -        }
> +        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
> +#line 41 "ftrace.h"
>      }
>  }
>  #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */

snip

> diff --git a/trace/ftrace.c b/trace/ftrace.c
> index 9749543d9b2..6875faedb9c 100644
> --- a/trace/ftrace.c
> +++ b/trace/ftrace.c
> @@ -38,6 +38,21 @@ static int find_mount(char *mount_point, const char *fstype)
>      return ret;
>  }
>  
> +void ftrace_write(const char *fmt, ...)
> +{
> +    char ftrace_buf[MAX_TRACE_STRLEN];
> +    int unused __attribute__ ((unused));
> +    int trlen;
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    trlen = vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
> +    va_end(ap);
> +
> +    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
> +    unused = write(trace_marker_fd, ftrace_buf, trlen);

You're just copying the existing code pattern which is fine for now so

   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


More generally though, IMHO, QEMU would be better off bringing in
gnulib's 'ignore_value' macro, but simplified since we don't care
about ancient GCC

  #define ignore_value(x) \
      (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))

so that we don't need to play games with extra variables. eg

   ignore_value(write(trace_marker_fd, ftrace_buf, trlen));

With regards,
Daniel

[1] https://github.com/coreutils/gnulib/blob/master/lib/ignore-value.h#L38
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


