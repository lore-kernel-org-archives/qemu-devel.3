Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842A2D29FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfz2o-0000UI-Ti; Wed, 14 Jan 2026 06:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfz2g-0000SL-B7
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfz2e-0000py-Ij
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768390078;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8y9AEIef1rowFJV/3ySioCDHzjuQYFwC8MfG4kDGyE0=;
 b=aL6f5zK8WyuDF8fXpy2VySW9ZPwj4w4zz6NW/7oT4QAIKmaEqN0OUR7BpJwRiz6jTsybc/
 AgkPgw73DtnSNYTXEgf1pm50u0ohQk3PhoehdmUnLM5oOhlFJ8MrXjy0CJtQ7uxzV2VNhN
 yKAuTEoNkfEO7oIlb4+QPf+F6AwUiwc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-_fMqKwwwOlSUzvxvzJY9fA-1; Wed,
 14 Jan 2026 06:27:57 -0500
X-MC-Unique: _fMqKwwwOlSUzvxvzJY9fA-1
X-Mimecast-MFC-AGG-ID: _fMqKwwwOlSUzvxvzJY9fA_1768390075
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F31171956046; Wed, 14 Jan 2026 11:27:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B9DE1800240; Wed, 14 Jan 2026 11:27:49 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:27:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
Message-ID: <aWd9sn9LZ3w02fY6@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
 <878qe1c17b.fsf@pond.sub.org> <aWYXt9YckvZmFCia@redhat.com>
 <874iopacr0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iopacr0.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 02:00:35PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Jan 13, 2026 at 10:27:04AM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > This will be used to include the thread name in error reports
> >> > in a later patch. It returns a const string stored in a thread
> >> > local to avoid memory allocation when it is called repeatedly
> >> > in a single thread. The thread name should be set at the very
> >> > start of the thread execution, which is the case when using
> >> > qemu_thread_create.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  include/qemu/thread.h    |  1 +
> >> >  meson.build              | 21 +++++++++++++++++
> >> >  util/qemu-thread-posix.c | 33 ++++++++++++++++++++++++++-
> >> >  util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
> >> >  4 files changed, 99 insertions(+), 5 deletions(-)
> >> 
> >> Tempted to store the thread name in TLS and call it a day.
> >
> > Using the official APIs in this way ensures that the thread name is
> > visible outside QEMU. For example when debugging in GDB, which IMHO
> > is an important benefit.
> 
> I didn't mean to suggest not to set the "official" thread name.
> 
> This patch retrieves the "official" thread name back.  Takes a bit of
> system-specific code, including Meson magic.  We could instead hold on
> to our own copy, and just use that.

That would mean we don't get any names for threads which are spawned
indirectly.  There are quite a lot of libraries that QEMU can use,
which can spawn threads behind QEMU's back, and these threads can
still be running QEMU code through callbacks. spice, gstreamer,
jack and librbd are some I know that spawn threads, but there are
likely quite a few more. In the the jack case we hook into its thread
creation to set a name ourselves, but we can't rely on that in general,
and these libraries may well have set thread names we should use. 

I want to maximise the cases where we can retrieve a thread name.
While the code is more verbose than I'd like, it exists now so I
don't think its good to throw it away to put into a worse solution.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


