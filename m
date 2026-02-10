Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563B4EA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoHI-0006xx-MP; Tue, 10 Feb 2026 08:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpoHF-0006xc-3A
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpoHD-0008Ls-2H
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770731977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf+3yOj25+sbZSZf5FpQfUDCFMtbbAL8U4ZEy4cQRtE=;
 b=fkegmNQ7nHE6a51oZZPx3Sw0EK6sUW0s/1T1PvbP49r6neet1vdxPfnq1i/v6qvgUYYVPu
 L6mjFVdOn5tZ6DOLHYK3I0g3x4UtupO0g/VG1/G06t5iYjPKDoaBbBp2MNTB5LLse8e+6c
 3G7oH/3MqAvycr16YaJwjng2qVfGOoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-3oP1rCfMMdGmEugBHwq5zA-1; Tue,
 10 Feb 2026 08:59:34 -0500
X-MC-Unique: 3oP1rCfMMdGmEugBHwq5zA-1
X-Mimecast-MFC-AGG-ID: 3oP1rCfMMdGmEugBHwq5zA_1770731973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 300391956089; Tue, 10 Feb 2026 13:59:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C2561800465; Tue, 10 Feb 2026 13:59:32 +0000 (UTC)
Date: Tue, 10 Feb 2026 08:59:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com,
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260210135931.GA90664@fedora>
References: <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
 <20260206140809.GA68769@fedora>
 <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
 <20260209142306.GA24854@fedora>
 <cd9c02195bcda43c4ac992c17a2a1de5d51102e7.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o7Cy+HlxdR1CZaYs"
Content-Disposition: inline
In-Reply-To: <cd9c02195bcda43c4ac992c17a2a1de5d51102e7.camel@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--o7Cy+HlxdR1CZaYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:23:51AM +0100, Martin Wilck wrote:
> On Mon, 2026-02-09 at 09:23 -0500, Stefan Hajnoczi wrote:
> > On Mon, Feb 09, 2026 at 01:50:00PM +0100, Hannes Reinecke wrote:
> > >=20
> > > My concern with opening the block device with BLK_OPEN_WRITE is
> > > that
> > > this will trigger udev to 'synthesize' (ie regenerate) an 'add'
> > > event
> > > on close, causing 'interesting' effects as this will cascade down
> > > through the udev rule chain, triggering blkid, partition scan, you
> > > name it.
> > > Horrible, horrible, horrible.
> > > Don't do it.
> > >=20
> > > Especially not as you are only interested in reading information,
> > > and not changing the disk state in any way.
> >=20
> > I see. I will send patches to change blkdev_pr_read_keys()
> > blkdev_pr_read_reservation() to require only BLK_OPEN_READ.
>=20
> Hm, but then if you need to make an actual reservation and call e.g.
> blkdev_pr_reserve(), you'll need to re-open the device r/w, and have
> the same problem. I'm not sure I understand the issue here ... doesn't
> your process have an open fd to the device in question anyway? You just
> need to be sure not to _close_ it, as that's what causes the uevents
> (udev uses an IN_CLOSE_WRITE inotify(7) event on the device node).

Shell scripts are the most exposed to this issue because they invoke
blkpr(8) anew each time instead of keeping the fd open between reading
reservation details and performing a reservation operation.

Stefan

--o7Cy+HlxdR1CZaYs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmLOcMACgkQnKSrs4Gr
c8j2fgf/SZMhGpGXjDA4y/6F3RfAVIXBVgYYbXK/rb2cz+oeYEMWUWlHIvCnYq7G
jCPpKNKQQalWuYnJlsMSilUzaWi7gvFwqeUbwV8ZA/aZZy+bxt8N/9UsSkgREgni
ym4sfHzf49ueGWgRMJKNO7jpOBMacM/lVd9CKfdC+885tutJah1moI6A0Um09DUV
t2P4wJQtECBhZXtYuI3PCOroTNWqWQ+MHomYRzmbaJWnngDefp8Pa8hdXqvymRcG
A89oFYQoyuYgP5xGgZTf3ztN7rkkyl4GjwZDVj24nRyMVgzbeVFUIQrMwDL7J6kO
KOgCm15mRwJb5DNUmLd6iziQ85N7MA==
=EFzv
-----END PGP SIGNATURE-----

--o7Cy+HlxdR1CZaYs--


