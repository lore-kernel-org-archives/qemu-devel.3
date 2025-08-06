Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3954C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcRF-0005Ba-Kh; Wed, 06 Aug 2025 07:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujcPp-0003o9-AA
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujcPn-0000ft-5F
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754480077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTMHmL35hsaGWkGcNHutApA4q04tp87CFaw8KglL5Es=;
 b=hBvul9vXs0xAGM6bbNtnJ534KOh6+Qp+Hz8/iJz46PSYXT5uHKHc0A37/6yyVpHuhGDSTV
 7jyF4XBlt77oVOggCCZBlswbTUpGmCP/MhveuUo3A7TKsCab+Pl2f+RyZyU6hqzwkrHk/C
 x3blRGK0e5PZRxJ71vSMjE3Xq26EMeA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-7furQXbWOBC55zcv_msWuw-1; Wed,
 06 Aug 2025 07:34:34 -0400
X-MC-Unique: 7furQXbWOBC55zcv_msWuw-1
X-Mimecast-MFC-AGG-ID: 7furQXbWOBC55zcv_msWuw_1754480072
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B47291800295; Wed,  6 Aug 2025 11:34:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCA2F195608F; Wed,  6 Aug 2025 11:34:28 +0000 (UTC)
Date: Wed, 6 Aug 2025 12:34:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
Message-ID: <aJM9v0ASQOPWzcQ9@redhat.com>
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
 <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
 <aJJGvL8feHr7Wme7@redhat.com> <87h5ykzout.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5ykzout.fsf@draig.linaro.org>
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

On Wed, Aug 06, 2025 at 12:11:38PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Aug 05, 2025 at 07:57:38PM +0300, Manos Pitsidianakis wrote:
> >> On Tue, Aug 5, 2025 at 7:49 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> >
> >> >
> >> > Was there a specific place where you found things hard to debug
> >> > from the error message alone ?  I'm sure we have plenty of examples
> >> > of errors that can be improved, but wondering if there are some
> >> > general patterns we're doing badly that would be a good win
> >> > to improve ?
> >> 
> >> Some months ago I was debugging a MemoryRegion use-after-free and used
> >> this code to figure out that the free was called from RCU context
> >> instead of the main thread.
> >
> > We give useful names to many (but not neccessarily all) threads that we
> > spawn. Perhaps we should call pthread_getname_np() to fetch the current
> > thread name, and used that as a prefix on the error message we print
> > out, as a bit of extra context ?
> 
> Do we always have sensible names for threads or only if we enable the
> option?

I was surprised to discover we don't name threads by default, only if we
add '-name debug-threads=yes'.  I'm struggling to understand why we would
ever want thread naming disabled, if an OS supports it ?

I'm inclined to deprecate 'debug-threads' and always set the names when
available.

> > Obviously not as much info as a full stack trace, but that is something
> > we could likely enable unconditionally without any overheads to worry
> > about, so a likely incremental wni.
> 
> The place where it comes in useful is when we get bug reports from users
> who have crashed QEMU in a embedded docker container and can't give us a
> reasonable reproducer. If we can encourage such users to enable this
> option (or maybe make it part of --enable-debug-info) then we could get
> a slightly more useful backtrace for those bugs.

The challenge is whether this build option would be enabled widely
enough to make a significant difference ?

I don't think we could really enable this in any distro builds, as
this is way too noisy to have turned on unconditionally at build
time for all users. Most containers are going to be consuming
distro builds, with relatively few building custom QEMU themselves
IME.  We might have better luck if this was a runtime option to
the -msg arg.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


