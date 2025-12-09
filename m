Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSurK-0003LJ-Je; Tue, 09 Dec 2025 05:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vSur9-0003HL-JU
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:22:09 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vSur7-0000wX-CW
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=CCg7+Xy/7JkICOHfMxCpHoUI9fQZD+yf1mUssiB3sUI=; b=GPSCUbn5vTUajDAj2KVMkNyFjy
 mYgjE8JxTdnB0Qvfahz8Y0Y7NN98zuwjFOXWczmOGSEdE9yWc0Kg6RRms/Ea7b4C8YeFkgrOg4JWJ
 6K786kvILoizD+DuJgz/vgUwbyIf1tTfjOvnDCyU2Lhol01eTyx4qdeGE5JOHfN6d03Y67vgXBXz9
 gzqauG5SwYzAN2Jxaxa/ObPcu7hclA0CJX+iP/XhbAUy/8h8vbmAZcIxZsTHjYGDrAkfruZFqT/Wy
 +o6aeRWDiDDbP0AalWdbQGOGaiMaRrQTwQpGH5QRNrH3GJJZolzwxXM4FkAA0Ll06u6cRD6+7Eh8x
 KCSgpzkt4mr5X+EN4krjtAac5OHPx6VcZAsRZSBiucY37XaHYpJSSR49q9eSLYs77zYJoLTNy/o39
 Pib48KVLSxQJVIyUkbWcBqoTjYBfXIkEX2BNQL4yVVFq4v053YBqdrsUCx9XdmBpxOmmnhM7wSN2J
 xnmiwvL16ksOCsdhYKk01ve/tTgxfIRz8aMlhso9+YLBWxuhYxdw4CeFiHC9xO1DB710aT/hqk7B0
 rDEhGGKgrWCUW0n1FWu4OgFwMwLcdnCsxyoAZdqm/w6t6kgRDP0S53HgQrBJT9qlRaeXgW2GHn7Vr
 LQGN2BuEZfJeDI3Z9f7bLqv4b/mere8R2gbZieU+I=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Andrey Erokhin <language.lawyer@gmail.com>, Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Date: Tue, 09 Dec 2025 11:21:58 +0100
Message-ID: <2022919.PYKUYFuaPT@weasel>
In-Reply-To: <CANCZdfrkPrr-KQF800UVsQov8LpZte9x2ryRao7GGUyuxFwGeA@mail.gmail.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <c2d79567-6b6c-4222-b1df-550db57ad626@gmail.com>
 <CANCZdfrkPrr-KQF800UVsQov8LpZte9x2ryRao7GGUyuxFwGeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sunday, 7 December 2025 12:34:24 CET Warner Losh wrote:
> On Sat, Dec 6, 2025, 10:12=E2=80=AFAM Andrey Erokhin <language.lawyer@gma=
il.com>=20
> wrote:
> > On 03/12/2025 15:33, Christian Schoenebeck wrote:
> > > On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:
[...]
> > > But for passthrough it is not of any use, is it?
> >=20
> > Prolly none, just a side effect of how it's implemented.
> > Can either make it an error when used with passthrough, or ignore them
> > (use default -1 value) when copying options to 9p fs context (with or
> > without a warning)
> >=20
> > > Also while it is very handy to have a short option name like "uid" and
> >=20
> > "gid", for the sake of long term progression and clarity an option name
> > like "default-uid" would be more appropriate.
> >=20
> > Or rather default_uid, to match other options style? But uid/gid also
> > kinda match fmode/dmode :\

Right, that would render it strange having default_uid/default_gid vs. fmod/
gmode when all of them actually mean default values.

OK, as fmode/dmode are already there, then let's stick to your initial=20
suggestion of just using uid/gid.

But similar to fmode/dmode it should be made clear on documentation level t=
hat=20
uid/gid are only useful for mapped security models.

> FreeBSD has a mode where you can build the image where the files in the
> filesystem are owned by the user with random permission bits, but the
> actual owners / modes are in an mtree formatted file. The nopriv imagers
> combine the two when making images. It would be nice to have p9 do a
> simular mapping for the guest so I can boot test these images more direct=
ly
> w/o the copyout to the "bootable image". The set the uid feature would
> help, true, but leaves me wanting more.

And a host level (not yet existing) tool like qemu-9p-chown, qemu-9p-chmod=
=20
would be less appropriate for your use case?

/Christian



