Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8054BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbcb-0000my-Gk; Mon, 10 Feb 2025 16:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thbcB-0000kf-A7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:46:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thbc7-0005Mh-6K
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739224002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWt3ozjPA6UvIoL+ztHI6Thcufem6YZDkDlsfoAWBME=;
 b=A5g3md4MO395mmAeTsaPX56Vz6XtboQ1Oy1LE5nil2g9S+KrHBBhL/24lSdCnE3x++kPlN
 +t7nioZIPGkluLQZX89bBNfFNpKaYjBzmmtNMYx+Le0/c0JvnIIU04AZ5rGHrNYUg8aDtC
 LWi1dt6SCAxBVX6CxdqPL2YnfCp56L0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-YVkgxfhqMNaHxLPtnN8iRg-1; Mon,
 10 Feb 2025 16:46:40 -0500
X-MC-Unique: YVkgxfhqMNaHxLPtnN8iRg-1
X-Mimecast-MFC-AGG-ID: YVkgxfhqMNaHxLPtnN8iRg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4262C1801A10; Mon, 10 Feb 2025 21:46:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B2C1800115; Mon, 10 Feb 2025 21:46:34 +0000 (UTC)
Date: Mon, 10 Feb 2025 15:46:31 -0600
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
Message-ID: <nqkksqej7hazlphlzzj7bjkoed2xxcjxqjdk7s42tjylhvojgr@mbyy5twhm6zl>
References: <20250203222722.650694-4-eblake@redhat.com>
 <20250203222722.650694-6-eblake@redhat.com>
 <d1171e97-eac6-4b9c-81cd-43dbb3777911@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1171e97-eac6-4b9c-81cd-43dbb3777911@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 10:20:09AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > ---
> >   qapi/block-export.json         | 10 ++++++++++
> >   include/block/nbd.h            |  6 +++---
> 
> [..]
> 
> > @@ -52,6 +57,10 @@
> >   #
> >   # @addr: Address on which to listen.
> >   #
> > +# @handshake-max-secs: Time limit, in seconds, at which a client that
> > +#     has not completed the negotiation handshake will be disconnected,
> > +#     or 0 for no limit (since 10.0; default: 10).
> > +#
> 
> Hmm. [not about the series], shouldn't we finally deprecate older interface?

By older interface, you are asking about the QMP command
'nbd-server-start' as compared to struct NbdServerOptions.  But the
struct is not directly present in any QMP commands; rather, it only
appears to be used by qemu-storage-daemon as one of its command line
options that needs to set up an NBD server with a JSON-like syntax
that has less nesting than QMP nbd-server-start.  blockdev-nbd.c has
two functions [nbd_server_start_options(NbdServerOPtions *arg...)  and
qmp_nbd_server_start(args...)] that both unpack their slightly
different forms and pass them as parameters to nbd_server_start() that
is then agnostic to whether the older QMP command or newer q-s-d CLI
option was specified.

It looks like libvirt is still using QMP nbd-server-start.  If we were
to start the deprecation process for qemu 10.0, what would the new
command look like?  What would everyone be required to use by qemu
10.2?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


