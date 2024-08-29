Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9629CC83F14
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeTe-0003oF-08; Thu, 29 Aug 2024 08:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sjeTc-0003mx-EZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sjeTa-0002Jn-9U
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724935327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KinHDoTY8381XuZJbNAoUrDrAhM14Dx8wVvPEn3gxXc=;
 b=J3QSgkP+LZ4Leqrxq19qmownjo50IeqDho2W7RfPUXkU8rSa0QvUFOy+ifFLIlOqGzfH0P
 l8CyQHZsWCMCNVuLnUW5u0/fwAxkzJSvglglKabXPuiI12pcNu4AfuTvJO/rvl0mLcfdrl
 pCbR7VY0eZ9QYcSCRUJJf3x9LPVfgO8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-0bvsNz-UMhOf3XFYu0dF1g-1; Thu,
 29 Aug 2024 08:42:02 -0400
X-MC-Unique: 0bvsNz-UMhOf3XFYu0dF1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE19D1955BEE; Thu, 29 Aug 2024 12:42:01 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DECF19560AA; Thu, 29 Aug 2024 12:41:58 +0000 (UTC)
Date: Thu, 29 Aug 2024 14:41:54 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] chardev: allow specifying finer-grained reconnect timeouts
Message-ID: <ZtBsktBwDRgGj6lD@angien.pipo.sk>
References: <20240816100723.2815-1-d-tatianin@yandex-team.ru>
 <87v7zjleys.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87v7zjleys.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 29, 2024 at 13:56:43 +0200, Markus Armbruster wrote:
> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:

[...]

So firstly, libvirt models the timeout in the XML in seconds for now so
making use of this will require some XML design plumbing making use of
it if there'll be any users wanting it.

When libvirt would want to make use of this the amount of work for any
of the options below is almost the same (capability detection, adding
of the new plumbing, etc). The only difference is what to
do if nobody shows interest in exposing the sub-second intervals in
libvirt.

> > @@ -287,7 +292,8 @@
> >              '*telnet': 'bool',
> >              '*tn3270': 'bool',
> >              '*websocket': 'bool',
> > -            '*reconnect': 'int' },
> > +            '*reconnect': 'int',
> > +            '*reconnect-is-ms': 'bool' },
> >    'base': 'ChardevCommon' }
> > =20
> >  ##
>=20
> I don't like this interface.
>=20
>    PRO: compatible extension; no management application updates needed
>    unless they want to support sub-second delays.
>=20
>    CON: specifying a sub-second delay takes two parameters, which is
>    awkward.
>=20
>    CON: trap in combination with -set.  Before the patch, something like
>    -set chardev.ID.reconnect=3DN means N seconds no matter what.
>    Afterwards, it depends on the value of reconnect-is-ms, which may be
>    set far away.  Mitigating factor: -set is obscure.

Here we'd have to do nothing.

> Alternatives:
>=20
> 1. Change @reconnect to 'number', specify sub-second delays as
>    fractions.
>=20
>    PRO: compatible extension; no management application updates needed
>    unless they want to support sub-second delays.
>=20
>    CON: first use of floating-point for time in seconds in QAPI, as far
>    as I can see.
>=20
>    CON: QemuOpts can't do floating-point.

Same here.

>=20
> 2. Deprecate @reconnect in favour of a new member with a more suitable
>    unit.  Error if both are present.
>=20
>    PRO: after @reconnect is gone, the interface is what it arguably
>    should've been from the start.
>=20
>    CON: incompatible change.  Management application updates needed
>    within the deprecation grace period.

This one will require change to libvirt including a capability addition
even when libvirt might not want to use the new field. (Add capability
detection, switch to new interface if present. Libvirt doesn't want to
use deprecated interfaces to avoid future breakage.)

But we've done this multiple times so it's not a big deal.

> Let's get additional input from management application developers.  I
> cc'ed some.

=46rom libvirt's point of view I'd say either option is viable. We're okay
with deprecating the old interface libvirt is used to do that.
I'd personally prefer if floating point numbers were avoided.


