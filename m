Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3201CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsk2-0007e8-6J; Wed, 02 Oct 2024 02:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svsk0-0007dr-ET
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 02:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svsjz-0008Qa-02
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 02:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727850096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qGCZuuvT8BlhE4Ho/BSmmQXI4Y25oCYnBf1d2y2eFc=;
 b=BmOz7yOoggrS/medqG5YrWenAmhKCG6aDvu6dd44HzrJ7ZiNaOcFOn3fu+CmgDoB/yL/nm
 FOe41l3UDO++ffp4QJ+Y7VPG1idXFFNJwxIOgCvdh9xkeKRlPrWnVPx/C1uURp/BtrqqHi
 K9dvR4rTNKoVk64x/9cMgrpXKZoNjtw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-LtrUCXpkPSOMjEgxztfz4w-1; Wed,
 02 Oct 2024 02:21:33 -0400
X-MC-Unique: LtrUCXpkPSOMjEgxztfz4w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7B3319560B1; Wed,  2 Oct 2024 06:21:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BDC419560A2; Wed,  2 Oct 2024 06:21:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2638F21E6A28; Wed,  2 Oct 2024 08:21:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Fam Zheng <fam@euphon.net>,  Song
 Gao <gaosong@loongson.cn>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  qemu-block@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Greg Kurz
 <groug@kaod.org>,  Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann
 <kraxel@redhat.com>,  Bin Meng <bmeng.cn@gmail.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Hyman Huang
 <yong.huang@smartx.com>,  Kevin Wolf <kwolf@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  John Snow <jsnow@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,  Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Yuval Shaia <yuval.shaia.ml@gmail.com>,  Bin Meng
 <bin.meng@windriver.com>
Subject: Re: [PATCH v3 21/22] qom/object: fix -Werror=maybe-uninitialized
In-Reply-To: <20240930081458.1926382-22-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Mon, 30 Sep 2024 12:14:56 +0400")
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-22-marcandre.lureau@redhat.com>
Date: Wed, 02 Oct 2024 08:21:22 +0200
Message-ID: <87wmir9g9p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> object_resolve_path_type() didn't always set *ambiguousp.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fixes: 81c48dd79655 (hw/i386/acpi: Add object_resolve_type_unambiguous to i=
mprove modularity)

> ---
>  qom/object.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 28c5b66eab..bdc8a2c666 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *path, =
const char *typename,
>          }
>      } else {
>          obj =3D object_resolve_abs_path(object_get_root(), parts + 1, ty=
pename);
> +        if (ambiguousp) {
> +            *ambiguousp =3D false;
> +        }
>      }
>=20=20
>      g_strfreev(parts);
> @@ -2226,7 +2229,7 @@ Object *object_resolve_path_at(Object *parent, cons=
t char *path)
>=20=20
>  Object *object_resolve_type_unambiguous(const char *typename, Error **er=
rp)
>  {
> -    bool ambig;
> +    bool ambig =3D false;
>      Object *o =3D object_resolve_path_type("", typename, &ambig);
>=20=20
>      if (ambig) {

Contract:

   /**
    * object_resolve_path_type:
    * @path: the path to resolve
    * @typename: the type to look for.
    * @ambiguous: returns true if the path resolution failed because of an
    *   ambiguous match
    *
    * This is similar to object_resolve_path.  However, when looking for a
    * partial path only matches that implement the given type are considere=
d.
    * This restricts the search and avoids spuriously flagging matches as
    * ambiguous.
    *
    * For both partial and absolute paths, the return value goes through
    * a dynamic cast to @typename.  This is important if either the link,
    * or the typename itself are of interface types.
    *
    * Returns: The matched object or NULL on path lookup failure.
    */

Note the parameter is called @ambiguous here, but @ambiguousp in the
definition.  Bad practice.

All the contract promises is that true will be stored in the variable
passed to @ambiguous when the function fails in a certain way.  For that
to work, the variable must be initialized to false.

You found a caller that doesn't: object_resolve_type_unambiguous().
This is a bug.  There might be more.  Impact is not obvious.

Two ways to fix:

1. Find all callers that don't, and fix them.  Your first hunk is then
   superfluous.  Your second hunk fixes the one you already found.

2. Change the contract so callers don't have to initialize.  Your second
   hunk is then superfluous.  The update to the contract is missing.

While there: the contract fails to specify that @ambiguous may be null.
Needs fixing, too.

Same for object_resolve_path().


