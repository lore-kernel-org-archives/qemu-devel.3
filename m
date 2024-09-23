Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04538CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 17:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssmWr-0001CL-HW; Mon, 23 Sep 2024 13:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ssmWi-00019g-9Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 13:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ssmWg-0005an-AL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 13:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727111224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XSTQLnOaxdfGGkVQ6+r645NQI3ev/4C5TTMAEej0nc=;
 b=e2x5XwVHesFg2aH62r8VjqZTh01cm3cc3Dinf/s+X6yFq6lj8i2HgSp8Ru9X/hi94Ei6oA
 u89G0Q1zTFqPWwC7ppJKtzn43B9INZz3SqCR2vR7qy0L9voafYKeUVp8VMjHPLUtngPyO7
 sSL6mVtUFut0dPzZT6pKjHlZKEKPjB0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-72S1mPfrMtqEpOlY7KURRA-1; Mon,
 23 Sep 2024 13:07:01 -0400
X-MC-Unique: 72S1mPfrMtqEpOlY7KURRA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 981961876F5F; Mon, 23 Sep 2024 17:06:59 +0000 (UTC)
Received: from localhost (unknown [10.42.28.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C872230030F9; Mon, 23 Sep 2024 17:06:46 +0000 (UTC)
Date: Mon, 23 Sep 2024 18:06:45 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <20240923170645.GB1450@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
 <20240922195122.GK5140@redhat.com>
 <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
 <ZvGZgxn1vZFF8Yl3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvGZgxn1vZFF8Yl3@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 23, 2024 at 06:38:27PM +0200, Daniel P. Berrangé wrote:
> On Mon, Sep 23, 2024 at 11:03:08AM -0500, Eric Blake wrote:
> > On Sun, Sep 22, 2024 at 08:51:22PM GMT, Richard W.M. Jones wrote:
> > > On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
> > > > On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > > > > Since version 2.66, glib has useful URI parsing functions, too.
> > > > > Use those instead of the QEMU-internal ones to be finally able
> > > > > to get rid of the latter. The g_uri_get_host() also takes care
> > > > > of removing the square brackets from IPv6 addresses, so we can
> > > > > drop that part of the QEMU code now, too.
> > > > > 
> > 
> > > > >  
> > > > > -    p = uri->path ? uri->path : "";
> > > > > +    p = g_uri_get_path(uri) ?: "";
> > > > >      if (p[0] == '/') {
> > > > >          p++;
> > > > >      }
> > 
> > > > Looks ok,
> > > >
> > > > Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> > > 
> > > Or maybe not.  This caused a regression in the nbdkit test suite (when
> > > we use qemu-img from 9.1).  It seems the exportname part of the NBD
> > > URI gets munged:
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/issues/2584
> > 
> > To be more specific, it looks like
> > g_uri_get_path("./name//with//..//slashes") is getting munged to
> > "name/slashes".  That is, glib is blindly assuming that ./ and XXX/../
> > can be dropped, and // can be simplified to /, which may be true for
> > arbitrary file names but not true for abitrary URIs (since URIs have
> > application-specific semantics, which may not match path name
> > traversal semantics).  Looks like we need to report a bug to glib,
> > and/or see if glib's URI functions have a flag for turning off this
> > unwanted munging.
> 
> The source code indicates it is doing some normalization
> based on this:
> 
>   https://datatracker.ietf.org/doc/html/rfc3986#section-5.2.4

I wrote a bit about this in the bug:

https://gitlab.com/qemu-project/qemu/-/issues/2584#note_2125192404

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


