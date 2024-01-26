Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA28C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJy4-00076G-1p; Fri, 26 Jan 2024 06:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTJxz-00075q-9Z
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTJxx-0000p8-Ct
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706266904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gd6lJVnSVUS69Xf9qLuJFQa4bTUTxSXqpPF5edxEWw=;
 b=B0XPRxTkNKeoK/Yj7D+t3V2P8YKEXghQLCTxzEa2mQL14UnWYTnJtuCXTqxXgDLlYXNycY
 pFuQHvKgsrulo76+InKMql+AL2sngti4ccUCDlC6mLWKDIBR0I4n2RbvV0EsSfNXelanTR
 VLkO8Xo5S6yk8W38zkRQT3F/N9VJoc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-8JTTNg7ePt666QxjN_BJvg-1; Fri, 26 Jan 2024 06:01:41 -0500
X-MC-Unique: 8JTTNg7ePt666QxjN_BJvg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3447837226;
 Fri, 26 Jan 2024 11:01:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06542492BFA;
 Fri, 26 Jan 2024 11:01:38 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:01:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH trivial 1/2] close_all_open_fd(): move to oslib-posix.c
Message-ID: <ZbOREEOcbSCwex15@redhat.com>
References: <cover.1706221377.git.mjt@tls.msk.ru>
 <94fcee0d7595865b3a6fab744982ad47715e5faf.1706221377.git.mjt@tls.msk.ru>
 <ffc002d5-f648-43b8-b938-011a4a92cf5e@vivier.eu>
 <ZbN2DhQ4GeKc-aaX@redhat.com>
 <dbb90f22-d17d-4c40-8684-58ec976a014e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbb90f22-d17d-4c40-8684-58ec976a014e@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 26, 2024 at 01:45:39PM +0300, Michael Tokarev wrote:
> 26.01.2024 12:06, Daniel P. Berrangé wrote:
> > On Fri, Jan 26, 2024 at 08:44:13AM +0100, Laurent Vivier wrote:
> > > Le 25/01/2024 à 23:29, Michael Tokarev a écrit :
> 
> 
> > > I think the way using sysconf(_SC_OPEN_MAX) is more portable, simpler and
> > > cleaner than the one using /proc/self/fd.
> > 
> > A fallback that uses _SC_OPEN_MAX is good for portability, but it is
> > should not be considered a replacement for iterating over /proc/self/fd,
> > rather an additional fallback for non-Linux, or when /proc is not mounted.
> > It is not uncommon for _SC_OPEN_MAX to be *exceedingly* high
> > 
> >    $ podman run -it quay.io/centos/centos:stream9
> >    [root@4a440d62935c /]# ulimit -n
> >    524288
> > 
> > Iterating over 1/2 a million FDs is a serious performance penalty that
> > we don't want to have, so _SC_OPEN_MAX should always be the last resort.
> 
> From yesterday conversation in IRC which started this:
> 
>  <mmlb> open files          (-n) 1073741816
> 
> (it is a docker container)
> They weren't able to start qemu.. :)
> 
> Sanity of such setting is questionable, but ok.
> 
> Not only linux implement close_range(2) syscall, it is also
> available on some *BSDs.
> 
> And the most important point is, - we should aim at using O_CLOEXEC
> everywhere, without this need to close each FD at exec time.  I think
> qemu is the only software with such paranoid closing when just running
> an interface setup script..

We should try to use O_CLOEXEC everywhere, but at the same time QEMU
links to a large number of libraries, and we can't assume that they've
reliably used O_CLOEXEC. Non-QEMU owned code that is mapped in process
likely dwarfs QEMU owned code by a factor of x10.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


