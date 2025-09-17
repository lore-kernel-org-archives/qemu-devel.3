Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B7CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyu88-0005pO-3L; Wed, 17 Sep 2025 11:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyu7v-0005aN-To
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyu7r-0002yN-RY
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758123077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vMKFqRY3BtBNK+Hs3MOpoJQL4QihCHW+yOssWMBAo0=;
 b=G8bhm3LfJghHWsqexHO+YDG/Krp9BnlIAHjXBDP3ecaPVzwruufG8LX1aPFE+uP98XNf5p
 iK7QYFvxIwELR4nVUtg10vgrDQGrq26C2sEsqJeHYtL1kwadSEGOnQkduSOPPl/mOpaJcl
 NGDbrU507i/aNuAhAyqhlgwNCB3mxdg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-eQWR11zwMVK0Fnp8oyAdqg-1; Wed,
 17 Sep 2025 11:31:14 -0400
X-MC-Unique: eQWR11zwMVK0Fnp8oyAdqg-1
X-Mimecast-MFC-AGG-ID: eQWR11zwMVK0Fnp8oyAdqg_1758123073
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECF171956094; Wed, 17 Sep 2025 15:31:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8892719560B1; Wed, 17 Sep 2025 15:31:05 +0000 (UTC)
Date: Wed, 17 Sep 2025 16:31:01 +0100
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
Subject: Re: [PATCH v3 02/20] monitor: initialize global data from a
 constructor
Message-ID: <aMrUNYrYeDB_sagn@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-3-berrange@redhat.com>
 <871po541h1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871po541h1.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 17, 2025 at 04:07:06PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Some monitor functions, most notably, monitor_cur() rely on global
> > data being initialized by 'monitor_init_globals()'. The latter is
> > called relatively late in startup. If code triggers error_report()
> > before monitor_init_globals() is called, QEMU will abort when
> > accessing the uninitialized monitor mutex.
> >
> > The critical monitor global data must be initialized from a
> > constructor function, to improve the guarantee that it is done
> > before any possible calls to monitor_cur(). Not only that, but
> > the constructor must be marked to run before the default
> > constructor in case any of them trigger error reporting.
> 
> Is error reporting from constructors a good idea?  I feel they're best
> used for simple initializations only.

When you're down in the weeds on a given piece of code it might
not occurr that it could be used in a constructor.

The biggest usage is QOM type registration, which we've obviously
been careful (lucky) enough to keep safe.

The other common use if initializing global mutexes.

I rather wish our mutex APIs supported a static initializer
like you get with pthreads and/or glib mutexes. That would
have avoided this ordernig problem.

> 
> Do we actually do it?

Probably not, but I can't be that confident as I have not auditted
all constructors.

I accidentally created a problem myself by putting an error_report
call into the rcu constructor to debug something never realized
that would result in pain.

And then I put error_report into the RCU thread itself and thus
discovered that was running concurrently with other constructors.

> > Note in particular that the RCU constructor will spawn a background
> > thread so we might even have non-constructor QEMU code running
> > concurrently with other constructors.
> 
> Ugh!

Indeed, that was my thought when discovernig this :-(

> 
> Arguably
> 
>   Fixes: e69ee454b5f9 (monitor: Make current monitor a per-coroutine property)
> 
> I never liked the @coroutine_mon hash table (which is what broke early
> monitor_cur()), but accepted it for want of better ideas.

I spent a little time wondering if we could replace coroutine_mon with
a "__thread Monitor cur' and then update that in monitor_set_cur, but
I couldn't convince myself it would be entirely safe. So for sake of
getting the series done I took this approach and left the current
monitor stuff for another day.

> 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


