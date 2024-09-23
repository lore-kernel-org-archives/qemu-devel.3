Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460B6CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssm5a-0006g0-Sj; Mon, 23 Sep 2024 12:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssm5S-0006Nu-Au
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssm5P-0002b8-9O
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727109533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tOB3zabxRlWoXExj8FrqCm95Pa09ZuzKc1H2OvBsXOQ=;
 b=NtX9u4+8I+KmYmtLekKPq3JOatRbALIZC363sZl3NbIQ41wj8+HfHwnPaRn9uLKk64qmso
 6g8jJo3HygOf6wGsFfGtrF1JTvhQ0dnOvBLdn2U6o3I3wwbhlOI7rO71V7CX0GsZ0QThoE
 8tDzh7QRF+AtkCT3ucGtFgJB70EYfDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-U9m4cdGfNHGaYAqYkV_DrQ-1; Mon,
 23 Sep 2024 12:38:49 -0400
X-MC-Unique: U9m4cdGfNHGaYAqYkV_DrQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 256CF190A0BB; Mon, 23 Sep 2024 16:38:48 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 401EB19560AA; Mon, 23 Sep 2024 16:38:31 +0000 (UTC)
Date: Mon, 23 Sep 2024 18:38:27 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <ZvGZgxn1vZFF8Yl3@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
 <20240922195122.GK5140@redhat.com>
 <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 23, 2024 at 11:03:08AM -0500, Eric Blake wrote:
> On Sun, Sep 22, 2024 at 08:51:22PM GMT, Richard W.M. Jones wrote:
> > On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
> > > On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > > > Since version 2.66, glib has useful URI parsing functions, too.
> > > > Use those instead of the QEMU-internal ones to be finally able
> > > > to get rid of the latter. The g_uri_get_host() also takes care
> > > > of removing the square brackets from IPv6 addresses, so we can
> > > > drop that part of the QEMU code now, too.
> > > > 
> 
> > > >  
> > > > -    p = uri->path ? uri->path : "";
> > > > +    p = g_uri_get_path(uri) ?: "";
> > > >      if (p[0] == '/') {
> > > >          p++;
> > > >      }
> 
> > > Looks ok,
> > >
> > > Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> > 
> > Or maybe not.  This caused a regression in the nbdkit test suite (when
> > we use qemu-img from 9.1).  It seems the exportname part of the NBD
> > URI gets munged:
> > 
> > https://gitlab.com/qemu-project/qemu/-/issues/2584
> 
> To be more specific, it looks like
> g_uri_get_path("./name//with//..//slashes") is getting munged to
> "name/slashes".  That is, glib is blindly assuming that ./ and XXX/../
> can be dropped, and // can be simplified to /, which may be true for
> arbitrary file names but not true for abitrary URIs (since URIs have
> application-specific semantics, which may not match path name
> traversal semantics).  Looks like we need to report a bug to glib,
> and/or see if glib's URI functions have a flag for turning off this
> unwanted munging.

The source code indicates it is doing some normalization
based on this:

  https://datatracker.ietf.org/doc/html/rfc3986#section-5.2.4

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


