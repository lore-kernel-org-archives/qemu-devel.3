Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49534C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprKp-0005Yv-3u; Thu, 28 Mar 2024 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rprKc-0005Y5-NP
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rprKW-0001Tu-3p
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H3yn9yhhlu2WBjLcHy+XH1SgMqK60qAwKpD2k/Zdlek=;
 b=K6KMAOL2ksSWEVfadlTQqym2PTCIQiFNFAVirOfqtG2brXLlJ4g4ZKvA+iPt2qq0wtP5mq
 Wt2K9q/Pb8CeQeuRMhFcQa/VRuNxktItdl+AjycpOFnm3x9rXwEzOQyglwrS/nec5Uui8R
 oYTWb7xpmAEu1tOyw8jf+huNgJ7t3iY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Wi_ZRyd7Mm2rAzFYt6QL7Q-1; Thu, 28 Mar 2024 11:06:08 -0400
X-MC-Unique: Wi_ZRyd7Mm2rAzFYt6QL7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79A34101A523;
 Thu, 28 Mar 2024 15:06:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32F2B17AA0;
 Thu, 28 Mar 2024 15:06:07 +0000 (UTC)
Date: Thu, 28 Mar 2024 10:06:01 -0500
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-block@nongnu.org, nbd@other.debian.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <jhweyusyjhha5hvffrtkwvuce35fajiy73dymgjre3jkjcjk7v@lrgdiintwb6i>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328141342.GK7636@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

Adjusting cc list to add upstream NBD and drop developers unrelated to
this part of the qemu series...

On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
> On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > Since version 2.66, glib has useful URI parsing functions, too.
> > Use those instead of the QEMU-internal ones to be finally able
> > to get rid of the latter. The g_uri_get_host() also takes care
> > of removing the square brackets from IPv6 addresses, so we can
> > drop that part of the QEMU code now, too.
> > 

> >  
> >      if (is_unix) {
> >          /* nbd+unix:///export?socket=path */
> > -        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
> > +        const char *uri_socket = g_hash_table_lookup(qp, "socket");
> > +        if (uri_server || uri_port != -1 || !uri_socket) {
> >              ret = -EINVAL;
> >              goto out;
> >          }

The spec for NBD URIs is at:

https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md

Should any of this spec mention case-insensitive concerns, such as
whether 'NBD://' may be equivalent to 'nbd://', and whether
'nbd+unix:///?socket=x' is equivalent to 'nbd+unix:///?Socket=x'?
Right now, I think that most implementations of NBD servers and
clients happen to use case-sensitive parsing; but glib provides the
option to do case-insensitive query parsing.

If I read https://docs.gtk.org/glib/type_func.Uri.parse_params.html
correctly, passing G_URI_PARAMS_CASE_INSENSITIVE (which you did not
do) would mean that 'nbd+unix:///?socket=ignore&Socket=/for/real'
would result in this g_hash_table_lookup finding only "Socket", not
"socket".  Maybe it is worth an explicit addition to the NBD URI spec
to mention that we intend to be case-sensitive (in the parts where it
can be; I'm not sure if the schema part must be handled
case-insensitively without re-reading the RFCs), and therefore that
'Socket=' does NOT have the same meaning as 'socket='.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


