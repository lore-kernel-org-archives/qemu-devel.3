Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0389DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsJm-0002wo-Mc; Tue, 26 Aug 2025 07:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsJj-0002vp-QI
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsJc-0004Gt-Pr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756209495;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djl+0gtWuuhoRTrN1ryfL+u6O00KCBccCjqe7XL3P4o=;
 b=GFxbw7xvr7/ArwiMBmlWTCw8em6H2KeEaLxPcB2vjMsOp38kZrLgurcG4xYfN3e7VaOkcZ
 LbDR76uW04UOWeiu4+fKxjy3kpwvHYhpgO/jAQikLGRqqr9laPrzyzoWyj5FfciZqzhDqJ
 OHvcDhZvpJAKAqsxHDr0uF7BFUHQqqw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-Q1Bcn1xcNGOf3JZZkqOYTA-1; Tue,
 26 Aug 2025 07:58:12 -0400
X-MC-Unique: Q1Bcn1xcNGOf3JZZkqOYTA-1
X-Mimecast-MFC-AGG-ID: Q1Bcn1xcNGOf3JZZkqOYTA_1756209491
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31758195608A; Tue, 26 Aug 2025 11:58:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0BF3300146C; Tue, 26 Aug 2025 11:58:08 +0000 (UTC)
Date: Tue, 26 Aug 2025 12:58:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tanishdesai37@gmail.com, stefanha@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
Message-ID: <aK2hTYoI3y6T5b34@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
 <aK2dMdD1i88PFn1j@redhat.com>
 <CAFEAcA-msigoOs74vNMLBNJgWt9thkpaFEk5amM6ACjpE=6ThA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-msigoOs74vNMLBNJgWt9thkpaFEk5amM6ACjpE=6ThA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 26, 2025 at 12:45:42PM +0100, Peter Maydell wrote:
> On Tue, 26 Aug 2025 at 12:42, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 02:26:44PM +0200, Paolo Bonzini wrote:
> > > This simplifies the Python code and reduces the size of the tracepoints.
> 
> > > +void ftrace_write(const char *fmt, ...)
> > > +{
> > > +    char ftrace_buf[MAX_TRACE_STRLEN];
> > > +    int unused __attribute__ ((unused));
> > > +    int trlen;
> > > +    va_list ap;
> > > +
> > > +    va_start(ap, fmt);
> > > +    trlen = vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
> > > +    va_end(ap);
> > > +
> > > +    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
> > > +    unused = write(trace_marker_fd, ftrace_buf, trlen);
> >
> > You're just copying the existing code pattern which is fine for now so
> >
> >    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> >
> > More generally though, IMHO, QEMU would be better off bringing in
> > gnulib's 'ignore_value' macro, but simplified since we don't care
> > about ancient GCC
> >
> >   #define ignore_value(x) \
> >       (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))
> >
> > so that we don't need to play games with extra variables. eg
> >
> >    ignore_value(write(trace_marker_fd, ftrace_buf, trlen));
> 
> Isn't there a way to write that that explicitly tells
> the compiler "this is unused" (i.e. with the 'unused'
> attribute) rather than relying on a particular construct
> to not trigger a warning?

I think what the code is already doing is the closest to making it
explicit, but that needs the extra variable which is unpleasant.

It is annoyng that 'warn_unused_result' doesn't let you just cast
to (void) to discard a result without warnings :-(

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


