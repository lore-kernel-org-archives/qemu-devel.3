Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5DCCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCg0-0002ad-VY; Mon, 30 Sep 2024 05:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1svCfz-0002UC-A0; Mon, 30 Sep 2024 05:26:43 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1svCfv-0006RG-Lt; Mon, 30 Sep 2024 05:26:43 -0400
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v3 22/22] fsdep/9p: fix -Werror=maybe-uninitialized
 false-positive
Date: Mon, 30 Sep 2024 11:26:26 +0200
Message-ID: <2542220.oxJn2mPQ6z@silver>
In-Reply-To: <20240930081458.1926382-23-marcandre.lureau@redhat.com>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Reply-to:  Christian Schoenebeck <qemu_oss@crudebyte.com>
From:  Christian Schoenebeck via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Monday, September 30, 2024 10:14:57 AM CEST Marc-Andr=C3=A9 Lureau wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> ../fsdev/9p-iov-marshal.c:93:23: error: =E2=80=98val=E2=80=99 may be used=
 uninitialized [-Werror=3Dmaybe-uninitialized]
> and similar
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  fsdev/9p-iov-marshal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
> index a1c9beddd2..75fb87a490 100644
> --- a/fsdev/9p-iov-marshal.c
> +++ b/fsdev/9p-iov-marshal.c
> @@ -84,7 +84,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int o=
ut_num, size_t offset,
>              break;
>          }
>          case 'w': {
> -            uint16_t val, *valp;
> +            uint16_t val =3D 0, *valp;
>              valp =3D va_arg(ap, uint16_t *);
>              copied =3D v9fs_unpack(&val, out_sg, out_num, offset, sizeof=
(val));

Another option would be inserting here:

	if (copied <=3D 0) break;

Same below. But I leave it up to you:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

/Christian

>              if (bswap) {
> @@ -95,7 +95,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int o=
ut_num, size_t offset,
>              break;
>          }
>          case 'd': {
> -            uint32_t val, *valp;
> +            uint32_t val =3D 0, *valp;
>              valp =3D va_arg(ap, uint32_t *);
>              copied =3D v9fs_unpack(&val, out_sg, out_num, offset, sizeof=
(val));
>              if (bswap) {
> @@ -106,7 +106,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int=
 out_num, size_t offset,
>              break;
>          }
>          case 'q': {
> -            uint64_t val, *valp;
> +            uint64_t val =3D 0, *valp;
>              valp =3D va_arg(ap, uint64_t *);
>              copied =3D v9fs_unpack(&val, out_sg, out_num, offset, sizeof=
(val));
>              if (bswap) {
>=20



