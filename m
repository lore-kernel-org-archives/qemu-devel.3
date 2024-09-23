Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E7CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslXD-0001dH-KE; Mon, 23 Sep 2024 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sslX8-0001PW-Ph
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sslX5-0006rG-On
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727107404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYK0KUrM+wkswaMMiVGquRAgqanCH2tRKUjM6BfiBhg=;
 b=Yps2rJilzqbmJO+PQfUOLrmWs/7rEGHMtZQIfTuAPWeeQ04PrrGcHLUw0qpB5eyy3Wo8Ui
 8d1nJnv6Wss4xZgesDIpXoyinKqVmvLXNB1LIEHUIo0bEAPjtiRzdv3ImFX8I6HkuvaDoD
 8rQD58nvruiOYvoJq2K4ESTHMYYddWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-nDZKkxyePYqIeSTz2Lz8_Q-1; Mon,
 23 Sep 2024 12:03:21 -0400
X-MC-Unique: nDZKkxyePYqIeSTz2Lz8_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 196FC190A344; Mon, 23 Sep 2024 16:03:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.25])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 329131956060; Mon, 23 Sep 2024 16:03:11 +0000 (UTC)
Date: Mon, 23 Sep 2024 11:03:08 -0500
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
 <20240922195122.GK5140@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922195122.GK5140@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 22, 2024 at 08:51:22PM GMT, Richard W.M. Jones wrote:
> On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
> > On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > > Since version 2.66, glib has useful URI parsing functions, too.
> > > Use those instead of the QEMU-internal ones to be finally able
> > > to get rid of the latter. The g_uri_get_host() also takes care
> > > of removing the square brackets from IPv6 addresses, so we can
> > > drop that part of the QEMU code now, too.
> > > 

> > >  
> > > -    p = uri->path ? uri->path : "";
> > > +    p = g_uri_get_path(uri) ?: "";
> > >      if (p[0] == '/') {
> > >          p++;
> > >      }

> > Looks ok,
> >
> > Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Or maybe not.  This caused a regression in the nbdkit test suite (when
> we use qemu-img from 9.1).  It seems the exportname part of the NBD
> URI gets munged:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/2584

To be more specific, it looks like
g_uri_get_path("./name//with//..//slashes") is getting munged to
"name/slashes".  That is, glib is blindly assuming that ./ and XXX/../
can be dropped, and // can be simplified to /, which may be true for
arbitrary file names but not true for abitrary URIs (since URIs have
application-specific semantics, which may not match path name
traversal semantics).  Looks like we need to report a bug to glib,
and/or see if glib's URI functions have a flag for turning off this
unwanted munging.

Or we may just want to document this corner case change as
intentional.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


