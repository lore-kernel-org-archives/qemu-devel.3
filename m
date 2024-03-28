Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5ECCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsne-0007P3-Ou; Thu, 28 Mar 2024 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpsnc-0007Nl-Ok
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpsna-0003ar-Og
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711644018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7R9aNfsLS42W4V3aKdUp16BUTlvgWZay1823VO9zp8=;
 b=EaZ3I+ZKMqDacrMTplOth0OdpaOFVftCpMQCVHUShAUdUOOFzRcLr+X/gbeYPhLCnZjEBD
 P7wkbz2R5o/XDXYlrCR8wtIiYGt6FvD93fKeU1KYfeMYVHwg/2L404M6FII4862P17/sN5
 d0rI83KvZsfAS9CDN7irQKEA39ZjKzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-IAZewuelOnS3NnRTd4wmvg-1; Thu, 28 Mar 2024 12:40:15 -0400
X-MC-Unique: IAZewuelOnS3NnRTd4wmvg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42631101A58D;
 Thu, 28 Mar 2024 16:40:15 +0000 (UTC)
Received: from localhost (unknown [10.42.28.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8AF7492BCA;
 Thu, 28 Mar 2024 16:40:14 +0000 (UTC)
Date: Thu, 28 Mar 2024 16:40:10 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, nbd@other.debian.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <20240328164010.GM7636@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
 <jhweyusyjhha5hvffrtkwvuce35fajiy73dymgjre3jkjcjk7v@lrgdiintwb6i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhweyusyjhha5hvffrtkwvuce35fajiy73dymgjre3jkjcjk7v@lrgdiintwb6i>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 10:06:01AM -0500, Eric Blake wrote:
> Adjusting cc list to add upstream NBD and drop developers unrelated to
> this part of the qemu series...
> 
> On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
> > On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > > Since version 2.66, glib has useful URI parsing functions, too.
> > > Use those instead of the QEMU-internal ones to be finally able
> > > to get rid of the latter. The g_uri_get_host() also takes care
> > > of removing the square brackets from IPv6 addresses, so we can
> > > drop that part of the QEMU code now, too.
> > > 
> 
> > >  
> > >      if (is_unix) {
> > >          /* nbd+unix:///export?socket=path */
> > > -        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
> > > +        const char *uri_socket = g_hash_table_lookup(qp, "socket");
> > > +        if (uri_server || uri_port != -1 || !uri_socket) {
> > >              ret = -EINVAL;
> > >              goto out;
> > >          }
> 
> The spec for NBD URIs is at:
> 
> https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md
> 
> Should any of this spec mention case-insensitive concerns, such as
> whether 'NBD://' may be equivalent to 'nbd://', and whether
> 'nbd+unix:///?socket=x' is equivalent to 'nbd+unix:///?Socket=x'?
> Right now, I think that most implementations of NBD servers and
> clients happen to use case-sensitive parsing; but glib provides the
> option to do case-insensitive query parsing.

I haven't thought about this before, but do note that the NBD URI spec
defers to "IETF standards describing URIs" for all unanswered
questions.  RFC3986 does talk about this incidentally.  About the
scheme field it says (section 3.1):

   Although schemes are case-
   insensitive, the canonical form is lowercase and documents that
   specify schemes must do so with lowercase letters.  An implementation
   should accept uppercase letters as equivalent to lowercase in scheme
   names (e.g., allow "HTTP" as well as "http") for the sake of
   robustness but should only produce lowercase scheme names for
   consistency.

Hostname is also (obviously) case insensitive.  There's also a section
(6.2.3) which talks about normalization of URIs.

Overall it seems the intention of the RFC writer is that parsers
should handle any case; but when generating URIs (and for examples,
documentation etc) we should only generate lowercase.

libnbd absolutely does *not* get this right, eg:

  $ nbdinfo NBD://localhost
  nbdinfo: nbd_connect_uri: unknown NBD URI scheme: NBD: Invalid argument

so that's a bug too.

> If I read https://docs.gtk.org/glib/type_func.Uri.parse_params.html
> correctly, passing G_URI_PARAMS_CASE_INSENSITIVE (which you did not
> do) would mean that 'nbd+unix:///?socket=ignore&Socket=/for/real'
> would result in this g_hash_table_lookup finding only "Socket", not
> "socket".  Maybe it is worth an explicit addition to the NBD URI spec
> to mention that we intend to be case-sensitive (in the parts where it
> can be; I'm not sure if the schema part must be handled
> case-insensitively without re-reading the RFCs), and therefore that
> 'Socket=' does NOT have the same meaning as 'socket='.

We could mention this in the spec for clarity, but the current meaning
(as above) would be that case-insensitive parsing is recommended.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


