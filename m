Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94EECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzX3m-0004Lq-Vz; Fri, 19 Sep 2025 05:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzX3k-0004L0-9F
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzX3g-0004pJ-2x
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272733;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0aD/pmWLEBTl3pMUlG/zKIA3vK/Pf/zu5AnBDTgwtg=;
 b=bKS604XNM1G4qV5DWjlsa7Bo5jyxIzOCDFbbnRnVRgTy0GbvJLwbF1KAOnqqW2upBjfBV9
 RrC6BRrjRa/UwnxGpYMbSs7GFacaZNlfqgK+BqUMQyJtZl4JoeB3gSmtVoUePjBigkbdVG
 rHhexVFSZjEVJm4nn/8GYsb66gadXpQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-wHih6RjaNwSOZqk-V34fKw-1; Fri,
 19 Sep 2025 05:05:32 -0400
X-MC-Unique: wHih6RjaNwSOZqk-V34fKw-1
X-Mimecast-MFC-AGG-ID: wHih6RjaNwSOZqk-V34fKw_1758272730
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 677CA195608E; Fri, 19 Sep 2025 09:05:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 407C718004A3; Fri, 19 Sep 2025 09:05:25 +0000 (UTC)
Date: Fri, 19 Sep 2025 10:05:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 07/20] util: add API to fetch the current thread name
Message-ID: <aM0c0eqGwA6ljX3-@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-8-berrange@redhat.com>
 <87y0qa4y3d.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0qa4y3d.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

On Fri, Sep 19, 2025 at 10:59:18AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This will be used to include the thread name in error reports
> > in a later patch. It returns a const string stored in a thread
> > local to avoid memory allocation when it is called repeatedly
> > in a single thread. This makes the assumption that the thread
> > name is set at the very start of the thread, which is the case
> > when using qemu_thread_create.
> 
> What happens when the assumption is violated?

You will get an operating system default thread name,
which on Linux will default to the unqualified binary
name based on argv[0]

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/thread.h    |  1 +
> >  meson.build              | 21 +++++++++++++++++
> >  util/qemu-thread-posix.c | 28 ++++++++++++++++++++++-
> >  util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
> >  4 files changed, 94 insertions(+), 5 deletions(-)


> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index 275445ed94..fbb94ca97b 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -18,7 +18,7 @@
> >  #include "qemu/tsan.h"
> >  #include "qemu/bitmap.h"
> >  
> > -#ifdef CONFIG_PTHREAD_SET_NAME_NP
> > +#if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
> >  #include <pthread_np.h>
> >  #endif
> >  
> > @@ -532,3 +532,29 @@ void *qemu_thread_join(QemuThread *thread)
> >      }
> >      return ret;
> >  }
> > +
> > +#ifndef PTHREAD_MAX_NAMELEN_NP
> > +#define PTHREAD_MAX_NAMELEN_NP 16
> 
> Feels a bit tight.  32?

On Linux this constant is not defined, but the manpage says

  The thread name is a meaningful C language string, whose length is
  restricted to 16 characters, including the terminating null byte ('\0')

so I defined the constant to match the non-Linux constant
name, but with the Linux documented max length.

> 
> > +#endif
> > +
> > +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];
> > +
> > +const char *qemu_thread_get_name(void)
> > +{
> > +    int rv;
> > +    if (namebuf[0] != '\0') {
> > +        return namebuf;
> > +    }
> > +
> > +# if defined(CONFIG_PTHREAD_GETNAME_NP)
> > +    rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
> > +# elif defined(CONFIG_PTHREAD_GET_NAME_NP)
> > +    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
> > +# else
> > +    rv = -1;
> > +# endif
> > +    if (rv != 0) {
> > +        strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
> > +    }
> > +    return namebuf;
> > +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


