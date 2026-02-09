Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B576E78D44
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMvb-0006U3-8h; Mon, 09 Feb 2026 03:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vpMvT-0006Tf-Jx
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vpMvQ-0001BT-0s
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770626838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2Le1WoOdjGKELqJDVth4fhtrvl7d+4r0jZMn+WBqOM=;
 b=Vwk5o9iPExTJrzfpIBHqfgJceN4SRsBsVB1fvaYO1AdHBGdz70oMBEXuoDq0Fa9smv4Das
 5orSklSfiDGLIfD80h/Ta87hdYB1dUbbht8ZrfUy5lMpjrV5GLq4pTdD+4IyG0f/rSYWWB
 iHAkkCPlUH8f+X5lBfWqgzjBCT/3BeA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-LQCijXzHMMq07bBc9E_Ysg-1; Mon,
 09 Feb 2026 03:47:15 -0500
X-MC-Unique: LQCijXzHMMq07bBc9E_Ysg-1
X-Mimecast-MFC-AGG-ID: LQCijXzHMMq07bBc9E_Ysg_1770626834
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E02A1955E72; Mon,  9 Feb 2026 08:47:14 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E82C630001A8; Mon,  9 Feb 2026 08:47:11 +0000 (UTC)
Date: Mon, 9 Feb 2026 09:47:08 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com,
 armbru@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
Message-ID: <aYmfDA5d-nQp9Zev@angien.pipo.sk>
References: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
 <aXyZrBIb77Gh_s7X@angien.pipo.sk>
 <97eb0bac-03a3-4edf-b3a6-2aa517ca0aac@yandex-team.ru>
 <aXy9cWMhM1uWCkyO@angien.pipo.sk>
 <7e7f0f77-d18d-44c8-b523-3853b6644fe3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7f0f77-d18d-44c8-b523-3853b6644fe3@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Feb 01, 2026 at 18:08:52 +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 30.01.26 17:17, Peter Krempa wrote:
> > On Fri, Jan 30, 2026 at 15:23:37 +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 30.01.26 14:44, Peter Krempa wrote:
> > > > On Fri, Jan 30, 2026 at 00:53:38 +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > They are the same as fds and vhostfds, except they accept only
> > > > > one fd. Let's deprecate redundant options.
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > ---
> > > > > 
> > > > > Hi all!
> > > > > 
> > > > > after "[PATCH v2 00/12] net: refactoring and fixes" options fd
> > > > > and vhostfd becomes redundant, fds and vhostfds may be used instead.
> > > > > 
> > > > > this patch also based on
> > > > > "[PATCH v6] qapi: net: deprecate vhostforce option", that's why
> > > > > it's sent separately.
> > > > > 
> > > > > Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
> > > > > Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>
> > > > > 
> > > > >    docs/about/deprecated.rst | 6 ++++++
> > > > >    qapi/net.json             | 9 +++++----
> > > > >    2 files changed, 11 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > > index e8ff478583..9010f8ab07 100644
> > > > > --- a/docs/about/deprecated.rst
> > > > > +++ b/docs/about/deprecated.rst
> > > > > @@ -451,6 +451,12 @@ TAP ``vhostforce`` (since 11.0)
> > > > >    The ``vhostforce`` option is redundant with the ``vhost`` option.
> > > > >    If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> > > > > +TAP ``fd`` and ``vhostfd`` (since 11.0)
> > > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +
> > > > > +Use ``fds`` and ``vhostfds`` correspondingly, each set with one fd
> > > > > +instead of ``fd`` and ``vhsotfd``.
> > > > 
> > > > Does this replacement apply/work on all versions supporting vhostfds/fd?
> > > > 
> > > > I'm asking because libvirt does have code to format the singlular vs
> > > > plural but none of the versions we support are lacking support for the
> > > > plural forms so we could replace this unconditionally if it works with
> > > > older versions.
> > > > 
> > > 
> > > Unfortunately, before "[PATCH v2 00/12] net: refactoring and fixes",
> > > some things will not work, if use fds/vhostfds instead of fd/vhostfd
> > > for one-queue TAP. Still, probably these cases are not used in Libvirt?
> > 
> > In that case any caveats should IMO be documented in the deprecation
> > document.
> 
> Will add.
> 
> > 
> > > for one-queue TAP. Still, probably these cases are not used in Libvirt?
> > 
> > Note that the network stuff in libvirt isn't my specialization so I
> > might be missing stuff that was not metioned explicitly.
> > 
> > > 1. Prior the series, tap.c code has check:
> > > 
> > >      /* QEMU hubs do not support multiqueue tap, in this case peer is set.
> > >       * For -netdev, peer is always NULL. */
> > >      if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
> > >          error_setg(errp, "Multiqueue tap cannot be used with hubs");
> > >          return -1;
> > >      }
> > 
> > So if that comment is accurate we only use fd/vhostfd with -netdev so
> > this won't trigger in libvirt.
> > 
> > 
> > > This is too restrictive: obviously queues may be set to 1, and fds/vhostfds
> > > may contain only one FD, but QEMU doesn't check it.
> > > 
> > > So, this case require fd/vhostfd options, if you want to pass some fds.
> > > 
> > > What this "hub" actually is? As I can see, it's -net cmdline option except for nic:
> > > 
> > > static int net_client_init1(const Netdev *netdev, bool is_netdev, Error **errp)
> > > {
> > >      ...
> > >          /* Do not add to a hub if it's a nic with a netdev= parameter. */
> > >          if (netdev->type != NET_CLIENT_DRIVER_NIC ||
> > >              !netdev->u.nic.netdev) {
> > >              peer = net_hub_add_port(0, NULL, NULL);
> > >          }
> > >      ...
> > > }
> > > 
> > > 
> > > 
> > > 2. Prior the series, you may pass vhostfds only together with fds. If you want
> > > to pass vhostfd for cases without fds, you have to use only vhostfd option.
> > 
> > So in the test data we seem to be using vhostfd only with fd (or the
> > crresponding plural form) but I'm not 100% sure based on the fact that
> > the formatters for the option are conditional on whether the FDs were
> > opened first.
> > 
> > The code opening the FDs seems to open 'vhostfd' only when 'fd' are
> > populated.
> > 
> > So if the above is the case (as in 'vhostfd' is used only with 'fd', or
> > the correspondign plural) then libvirt should be able to use this
> > unconditionally, right?
> > 
> 
> Yes, if I didn't miss something. I'll double check.

So since the deprecation will break libvirt's test code once it's
commited and libvirt updates capability dumps I've proposed
two patchsets:

Variant A:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/USXOQMQDKPLGITQ6HPEZOUNCB2OFVMVM/

Variant B:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/QMIVQIGXQERVKXTHEPKZCJ4NEANVKST7/

Variant A is the simpler approach of just unconditionally switching to
the plural variants which *should* work based on the above, but is out
of my specialization to verify it properly.

I've thus also proposed the more cautious variant B which adds a
capability which detects that the singular spelling is deprecated and
swtiches to the plural only when that is the case.

> > > Even for the case when you pass queues > 0, you can't provide vhostfds but only
> > > vhostfd (and QEMU will try to reuse it for all queues, which (as I understand)
> > > is a bug in current QEMU.
> > 
> > Okay I'm not sure how this works and if it has implications on libvirt.
> > 
> > Specifically we don't seem to be ever passing 'queues' to -netdev in
> > conjunction with fd/vhostfd or the correspondive plurals.
> 
> That's correct fd=, fds= and queues= are mutual exclusive. Still, vhostfd
> may be used withuot fd.. But that's rather strange.



