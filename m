Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F15CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLGr-00043E-Sz; Tue, 19 Aug 2025 08:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLGn-00042W-NJ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLGj-0005Sz-Q8
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755605807;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mHfC5aTy+cxy3oISPoQV1YeOmMlQOot8WL9r10jCEh4=;
 b=SKSxT1dx4vc7GR/U2kFXArl5w24OKnfZV9I2TvvjnLJsl1nH2qzoOGmvIl+Oa40fMMeLqC
 cV7gzmnGY2szpr12Xc0jzbNaQL7n6juijVVAywJnPc5k7Xz8ElP5gkQqnfr8RzoYzHWl2v
 pHO3DxkQUElnaxE/wpWsze/KalKRJAQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-SjA87wLBPReZDa_9DYIfRw-1; Tue,
 19 Aug 2025 08:16:46 -0400
X-MC-Unique: SjA87wLBPReZDa_9DYIfRw-1
X-Mimecast-MFC-AGG-ID: SjA87wLBPReZDa_9DYIfRw_1755605805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 290AF1954228
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:16:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E7A4195419F; Tue, 19 Aug 2025 12:16:43 +0000 (UTC)
Date: Tue, 19 Aug 2025 13:16:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] trace/ftrace: move snprintf+write from tracepoints to
 ftrace.c
Message-ID: <aKRrJySwMXT5YnET@redhat.com>
References: <20250808091110.23126-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808091110.23126-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 08, 2025 at 11:11:10AM +0200, Paolo Bonzini wrote:
> This simplifies the Python code and reduces the size of the tracepoints.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tracetool/ftrace.h            | 26 ++++----------------------
>  trace/ftrace.h                      |  1 +
>  trace/ftrace.c                      | 13 +++++++++++++
>  scripts/tracetool/backend/ftrace.py | 13 ++-----------
>  4 files changed, 20 insertions(+), 33 deletions(-)


> diff --git a/trace/ftrace.c b/trace/ftrace.c
> index 9749543d9b2..1d7e1ee6f6d 100644
> --- a/trace/ftrace.c
> +++ b/trace/ftrace.c
> @@ -38,6 +38,19 @@ static int find_mount(char *mount_point, const char *fstype)
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

va_end(ap);

> +    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
> +    unused = write(trace_marker_fd, ftrace_buf, trlen);
> +}
> +
>  bool ftrace_init(void)
>  {
>      char mount_point[PATH_MAX];

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


