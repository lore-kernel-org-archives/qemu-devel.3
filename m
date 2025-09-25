Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7D7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jH7-0007D7-Nq; Thu, 25 Sep 2025 06:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1jGr-00072s-Rv
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1jGh-0003Wl-4W
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758796321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLygx2SrNhE0h/tsW4RkRSuKB4mUTKvybXdgIygkjPw=;
 b=hxY5v6PwD3nhNemXTNmKzR/gGXCeLoPTt0TWGGCErPm8z0dSObrfoNpyv7xB14BMisZrB9
 BS2F5IJKLfs1IQwiNr0IB/GK48vdBZZ8dOrLuaUJTDvzwkQOG8HV56FblN79c+0ECvrEy7
 BT/TlqVCUYnUZycUEkt8REQoOjA8o8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-ZHNMZHwFOBq0cEPnYYQ31g-1; Thu,
 25 Sep 2025 06:31:58 -0400
X-MC-Unique: ZHNMZHwFOBq0cEPnYYQ31g-1
X-Mimecast-MFC-AGG-ID: ZHNMZHwFOBq0cEPnYYQ31g_1758796317
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9296A195608B; Thu, 25 Sep 2025 10:31:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2368D18003FC; Thu, 25 Sep 2025 10:31:50 +0000 (UTC)
Date: Thu, 25 Sep 2025 11:31:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 00/23] util: sync error_report & qemu_log output more
 closely
Message-ID: <aNUaE77pS6ypY8FA@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <3d77f02a-5e89-432b-8be1-d76df49b90e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d77f02a-5e89-432b-8be1-d76df49b90e2@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 12:22:39PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 25/9/25 11:44, Daniel P. Berrangé wrote:
> > This series is a tangent that came out of discussion in
> > 
> >     https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00903.html
> > 
> > In thinking about adding thread info to error_report, I
> > came to realize we should likely make qemu_log behave
> > consistently with error_report & friends. We already
> > honour '-msg timestamp=on', but don't honour 'guest-name=on'
> > and also don't include the binary name.
> > 
> > As an example of the current state, consider mixing error and
> > log output today:
> > 
> > - Default context:
> > 
> >    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
> >                         -d 'trace:qcrypto*'
> >    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55ac6d97f700 dir=fish
> >    qcrypto_tls_creds_get_path TLS creds path creds=0x55ac6d97f700 filename=ca-cert.pem path=<none>
> >    qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > - Full context:
> > 
> >    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
> >                         -d 'trace:qcrypto*' \
> >                         -msg guest-name=on,timestamp=on \
> >                         -name "fish food"
> >    2025-08-19T20:14:16.791413Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55e9a3458d10 dir=fish
> >    2025-08-19T20:14:16.791429Z qcrypto_tls_creds_get_path TLS creds path creds=0x55e9a3458d10 filename=ca-cert.pem path=<none>
> >    2025-08-19T20:14:16.791433Z fish food qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > And after this series is complete:
> > 
> > - Default context:
> > 
> >    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
> >                        -d 'trace:qcrypto*'
> >    qemu-system-x86_64(1184284:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55a24ad5cb30 dir=fish
> >    qemu-system-x86_64(1184284:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55a24ad5cb30 filename=ca-cert.pem path=<none>
> >    qemu-system-x86_64(1184284:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > - Full context:
> > 
> >    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
> >                        -d 'trace:qcrypto*' \
> >                        -msg guest-name=on,timestamp=on \
> >                        -name "fish food"
> >    2025-08-19T20:12:50.211823Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5582183d8760 dir=fish
> >    2025-08-19T20:12:50.211842Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5582183d8760 filename=ca-cert.pem
> > +path=<none>
> >    2025-08-19T20:12:50.211846Z [fish food] qemu-system-x86_64(1168876:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > The main things to note:
> > 
> >   * error_report/warn_report/qemu_log share the same
> >     output format and -msg applies to both
> > 
> >   * -msg debug-threads=on is now unconditionally enabled
> >     and thus the param is deprecated & ignored
> > 
> >   * Thread ID and name are unconditionally enabled
> > 
> >   * Guest name is surrounded in [...] brackets
> > 
> >   * The default output lines are typically 15 chars
> >     wider given that we always include the thread
> >     ID + name now
> > 
> >   * This takes the liberty of assigning the new file
> >     to the existing error-report.c maintainer (Markus)
> >     Since splitting it off into message.c instead of
> >     putting it all in error-report.c felt slightly
> >     nicer.
> > 
> > One thing I didn't tackle is making the location
> > info get reported for qemu_log. This is used to
> > give context for error messages when parsing some
> > CLI args, and could be interesting for log messages
> > associated with those same CLI args.
> 
> Testing with this change on top ...:
> 
> -- >8 --
> diff --git a/include/qemu/message.h b/include/qemu/message.h
> index 2cc092c993b..97fd2a94fbd 100644
> --- a/include/qemu/message.h
> +++ b/include/qemu/message.h
> @@ -10,2 +10,3 @@ enum QMessageFormatFlags {
>      QMESSAGE_FORMAT_THREAD_INFO = (1 << 3),
> +    QMESSAGE_FORMAT_VCPU_ID = (1 << 4),
>  };
> diff --git a/system/vl.c b/system/vl.c
> index bf9f80491f2..2f43a075be9 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -149,3 +149,4 @@
>      (QMESSAGE_FORMAT_PROGRAM_NAME | \
> -     QMESSAGE_FORMAT_THREAD_INFO)
> +     QMESSAGE_FORMAT_THREAD_INFO | \
> +     QMESSAGE_FORMAT_VCPU_ID)
> 
> diff --git a/util/message.c b/util/message.c
> index 7d94b9d970d..19d1331403a 100644
> --- a/util/message.c
> +++ b/util/message.c
> @@ -6,2 +6,3 @@
>  #include "monitor/monitor.h"
> +#include "hw/core/cpu.h"
> 
> @@ -46,2 +47,8 @@ void qmessage_context_print(FILE *fp)
>      }
> +
> +    if (message_format & QMESSAGE_FORMAT_VCPU_ID) {
> +        if (current_cpu) {
> +            fprintf(fp, "(cpuid:%d): ", current_cpu->cpu_index);
> +        }
> +    }
>  }
> ---
> 
> ... on a branch where I test heavy vcpu context switching.
> 
> When using tracing + stderr AND the stdio console, I sometimes get
> the trace events to disappear at some point. Not sure why (or if related
> to my branch) yet.
> 
> When redirecting traces to a file ('-D foo.log'), all traces are
> collected (no hang).
> 
> In both cases I notice a high performance slow down (when tracing is
> used).
> 
> Suspicions:
> - flocking

The logging code (and thus tracing) already used flockfile in
qemu_log, so that should not be new. Only error_report gained
new flockfile calls in this series.

> - new formatting

Seems the more likely option.  If practical, a git bisect across the
series should show which part introduced any slowdown.

Assuming you've not given any -msg option to QEMU though, the finger
probably points towards the thread name code, as the bit that is
new and enabled by default.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


