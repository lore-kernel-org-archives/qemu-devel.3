Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC67CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZU-0008GP-GB; Wed, 20 May 2026 14:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wPlZK-0007lN-DJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wPlZB-0000h5-66
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=2GufbOugQ5ZGVodxdj7LE7O5HZSpJZi6FFRZkbgmLD8=; b=c1BdXF4YG7tk37Jq3fZScGCZhI
 oX2XmWgNTw4c0WxwzyLsJJJSXV6X2y2lEyv86H5WC7ngET5kTHw+iQdtY1NoHQ5HH6nIcbc9AmwPR
 Ek9+nGQKhSVdfExmDNNhtc+vYaih3u5QeYi0XQYXSaaS7gJ16Mpu7ogb/JCv/cy4PeZm1G09L1Sdf
 BlpPw4QvHSEzCrriFfLhgz+d0aJJmkSE6aH7TERr4OMmqLm/Lj/1N07vos/drZScVryLjrHAALdxn
 LzZmroY6IbJiOheGFt84HVsxvUk8PIzf5SpkWTItj84VtMaIDDh9ZWuDwK5EcDjh41UZD+z+0KAnW
 Ubfe3Uh+7s0VXgrl+LNnNnKTH2opef8IM0Qra3OgVAPpSIzOF2R8fX14JJNlHsCeRtbDfl/ddQarP
 Ns2mJ7G5j3JQ9sJFM9OE4PNwRkbsVYqDFHzBy2tJyLf7mI7eqGUPGabT/VwoQ8caDq6zp0DfDdevp
 oiAYoPh3zTbuDin6KASV0t6EdVnV3e+NwsE01ArOajjbPlTo7iIZvvtszrQZaITvzPh4x57zCPcGR
 Sx776WuLyabbfaF2ODuHEMY/2e1mNj20Sli4mMFhcbs9vsbMmpWLsuh7hAsnS5bum612zszJNlTW4
 /iXtmzo3WCSh9fL1gxEqsrmHDyJ8GyzKmZ2rD/TvU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, sin99xx <sinxx198@gmail.com>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
Date: Wed, 20 May 2026 20:22:36 +0200
Message-ID: <4735365.LvFx2qVVIh@weasel>
In-Reply-To: <E1wPkYi-000adH-4E@kylie.crudebyte.com>
References: <E1wPkYi-000adH-4E@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrote:
> From: sin99xx <sinxx198@gmail.com>
>=20
> v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread
> that reads V9fsFidState's path.data without holding a rename lock.
>=20
> A concurrent rename request, e.g. of its parent dir, causes the FID's
> absolute path to be altered by freeing the old path string and
> assigning a new one. This causes a heap-use-after-free race condition
> while do_readdir_many() is still accessing the old object.
>=20
> This allows a DoS by an unprivileged guest user.
>=20
> Fix this by wrapping the worker thread dispatch block within a pair of
> v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
> other places.
>=20
> Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> Fixes: CVE-2026-48004
> Reported-by: sin99xx <sinxx198@gmail.com>
> [Christian Schoenebeck: add commit log message]
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

sin99xx, I forgot, may I add your Signed-off-by tag?

  Signed-off-by: sin99xx <sinxx198@gmail.com>

This is required [1] for making you the patch author:

"Your patches must include a Signed-off-by: line. This is a hard requiremen=
t=20
because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m legally okay to contr=
ibute this and happy for it=20
to go into QEMU=E2=80=9D. For full guidance, read the Code provenance docum=
entation."

[1] https://www.qemu.org/docs/master/devel/submitting-a-patch.html

> ---
>  hw/9pfs/codir.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> index bce7dd96e9..5568399343 100644
> --- a/hw/9pfs/codir.c
> +++ b/hw/9pfs/codir.c
> @@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu,
> V9fsFidState *fidp, bool dostat)
>  {
>      int err =3D 0;
> +    V9fsState *s =3D pdu->s;
>=20
>      if (v9fs_request_cancelled(pdu)) {
>          return -EINTR;
>      }
> +    v9fs_path_read_lock(s);
>      v9fs_co_run_in_worker({
>          err =3D do_readdir_many(pdu, fidp, entries, offset, maxsize, dos=
tat);
> });
> +    v9fs_path_unlock(s);
>      return err;
>  }



