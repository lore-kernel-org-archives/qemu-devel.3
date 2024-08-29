Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9812C7EE2E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 07:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjZNK-0001rk-0X; Thu, 29 Aug 2024 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjZN9-0001qY-Dz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 03:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjZN7-0007VY-09
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 03:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724915706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IBE6IaiAEMRciJWtSMhKOiiBhE1VCTLKX6wFjCaafA=;
 b=KUwFNRcjuySdI8O0H8RCYzqPYqZqJUNgaRj+oMHbuGZGsT5yYTLD0tLOM3rdpzJlA4UXnp
 mMBrquU8TQ6H8AU2jyd1BSVeNCppSokP0f8Py0nGvLjF4ItINlva/GAvuyLCqHNM/tF7Xo
 pcXb1CP24hpsOWSTNg+nGjSR7A46noM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-7NcTPh0lNRuzlXF71RUblQ-1; Thu,
 29 Aug 2024 03:15:02 -0400
X-MC-Unique: 7NcTPh0lNRuzlXF71RUblQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 750E51954B07; Thu, 29 Aug 2024 07:15:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A35D19560A3; Thu, 29 Aug 2024 07:14:59 +0000 (UTC)
Date: Thu, 29 Aug 2024 08:14:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Subject: Re: [PULL 3/6] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
Message-ID: <ZtAf3kZkKXrCFpIk@redhat.com>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
 <20240805003130.1421051-5-richard.henderson@linaro.org>
 <Zs8ctyVxQz3iLDmM@redhat.com>
 <bea888ca-9221-4c51-bcd1-c869d73094ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bea888ca-9221-4c51-bcd1-c869d73094ae@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 08:47:27AM +1000, Richard Henderson wrote:
> On 8/28/24 22:48, Daniel P. Berrangé wrote:
> > >       dir = opendir("/proc/self/fd");
> > 
> > IIUC from previous threads this is valid on Linux and on Solaris.
> > 
> > On FreeBSD & macOS, you need /dev/fd though.
> 
> Fair, but importantly, it doesn't do anything *incorrect* those systems: it
> merely skips this method with ENOENT.
> 
> > > +    int open_max = sysconf(_SC_OPEN_MAX), i;
> > > +
> > > +    /* Fallback */
> > > +    for (i = 0; i < open_max; i++) {
> > > +        close(i);
> > > +    }
> > 
> > I'm told that sysconf(_SC_OPEN_MAX) returns -1 on some versions of
> > macOS. "Luckily" since we assigned to 'int' rather than 'unsigned int'
> > this will result in us not closing any FDs in this fallback path,
> > rather than trying to close several billion FDs (an effective hang).
> 
> Ouch.
> 
> > 
> > If _SC_OPEN_MAX returns -1, we should fallback to the OPEN_MAX
> > constant on macOS (see commit de448e0f26e710e9d2b7fc91393c40ac24b75847
> > which tackled a similar issue wrt getrlimit), and fallback to perhaps
> > a hardcoded 1024 on non-macOS.
> 
> I wish the timing on this had been better -- 25 minutes earlier and I would have delayed rc4.
> 
> Since macOS simply doesn't close fds, I'm of a mind to release 9.1.0 without
> this, and fix it for 9.1.1.  Thoughts?

The original net/tap.c code for closing FDs has the same bug, so in that
area we do NOT have a regression.

The original async teardown code would fail to close FDs as it is looking
for close_range or /proc/$PID/fd, and has no sysconf fallback, so again
no regression there.

IOW, I think this is acceptable to fix in 9.1 stable.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


