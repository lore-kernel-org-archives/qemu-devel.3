Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2D9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7fLH-0002Od-B8; Thu, 16 May 2024 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s7fLF-0002O4-Ii
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s7fLD-0000gx-LK
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715882190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVgiqESZcKGBKuw33HSBJzmLdLodY8wgN5X2qrMrxRs=;
 b=I+yr978Xbls3X6qQhRp6M03xuvP+U2bIZFeEhQoJ+RSQyxH8/F+3AjawcjdBm48n2wIhti
 EQFW6Hy+su3/7a2QYH3ToCbVDC0SKaG161tAvRaURbyD6cXMZ+5ky6fitrtxSm4ZQibScz
 NwcoA4Fpq75pAI4a2od8nEWooYKNUlE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-9B-PGCdKPLy5JI01roMang-1; Thu,
 16 May 2024 13:56:26 -0400
X-MC-Unique: 9B-PGCdKPLy5JI01roMang-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A7881C031B9;
 Thu, 16 May 2024 17:56:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 337DAC15BF0;
 Thu, 16 May 2024 17:56:20 +0000 (UTC)
Date: Thu, 16 May 2024 13:56:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 00/20] qapi: new sphinx qapi domain pre-requisites
Message-ID: <20240516175619.GA1176412@fedora.redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ddtIcneASRVMGzP2"
Content-Disposition: inline
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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


--ddtIcneASRVMGzP2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 05:57:19PM -0400, John Snow wrote:
> Howdy - this patch series is the first batch of patches meant to prepare
> the QAPI documentation for a new Sphinx module that adds
> cross-references, an index, improved inlining, elision of types unseen
> on the wire, and other goodies.
>=20
> This series addresses just existing code and documentation that needs to
> be changed and doesn't introduce anything new just yet - except the rST
> conversion of Notes and Examples sections, which DOES impact the
> existing QAPI documentation generation.
>=20
> If you're CC'd on this series, it's *probably* because I've adjusted
> some QAPI documentation that you're the maintainer of - In most cases,
> these changes are purely mechanical (converting QAPI sections into pure
> rST) and probably nothing too interesting. In a small handful of cases
> (patches 15-17), I've been a bit more invasive and you may want to take
> a quick peek.
>=20
> Overview:
>=20
> Patches 1-3: linter/typing cleanup
> Patches 4-12: QAPI generator fixes/miscellany
> Patch 13: qapidoc.py fix (to prepare for rST conversion)
> Patches 14-20: QAPI documentation modifications, rST conversion
>=20
> Sorry,
> --js
>=20
> John Snow (20):
>   [DO-NOT-MERGE]: Add some ad-hoc linting helpers.
>   qapi: linter fixups
>   docs/qapidoc: delint a tiny portion of the module
>   qapi/parser: preserve indentation in QAPIDoc sections
>   qapi/parser: adjust info location for doc body section
>   qapi/parser: fix comment parsing immediately following a doc block
>   qapi/parser: add semantic 'kind' parameter to QAPIDoc.Section
>   qapi/parser: differentiate intro and outro paragraphs
>   qapi/parser: add undocumented stub members to all_sections
>   qapi/schema: add __iter__ method to QAPISchemaVariants
>   qapi/schema: add doc_visible property to QAPISchemaDefinition
>   qapi/source: allow multi-line QAPISourceInfo advancing
>   docs/qapidoc: fix nested parsing under untagged sections
>   qapi: fix non-compliant JSON examples
>   qapi: remove developer factoring comments from QAPI doc blocks
>   qapi: rewrite StatsFilter comment
>   qapi: rewrite BlockExportOptions doc block
>   qapi: ensure all errors sections are uniformly typset
>   qapi: convert "Note" sections to plain rST
>   qapi: convert "Example" sections to rST
>=20
>  docs/sphinx/qapidoc.py                        |  62 ++++--
>  qapi/acpi.json                                |   6 +-
>  qapi/audio.json                               |   5 +-
>  qapi/block-core.json                          | 195 ++++++++++--------
>  qapi/block-export.json                        |  16 +-
>  qapi/block.json                               |  62 +++---
>  qapi/char.json                                |  53 +++--
>  qapi/control.json                             |  32 +--
>  qapi/crypto.json                              |  33 ++-
>  qapi/dump.json                                |  14 +-
>  qapi/introspect.json                          |   6 +-
>  qapi/machine-target.json                      |  29 +--
>  qapi/machine.json                             | 138 +++++++------
>  qapi/migration.json                           | 159 +++++++++-----
>  qapi/misc-target.json                         |  33 ++-
>  qapi/misc.json                                | 139 +++++++------
>  qapi/net.json                                 |  49 +++--
>  qapi/pci.json                                 |  11 +-
>  qapi/qapi-schema.json                         |   6 +-
>  qapi/qdev.json                                |  45 ++--
>  qapi/qom.json                                 |  69 +++----
>  qapi/replay.json                              |  12 +-
>  qapi/rocker.json                              |  30 +--
>  qapi/run-state.json                           |  63 +++---
>  qapi/sockets.json                             |  10 +-
>  qapi/stats.json                               |  30 ++-
>  qapi/tpm.json                                 |   9 +-
>  qapi/trace.json                               |   6 +-
>  qapi/transaction.json                         |  13 +-
>  qapi/ui.json                                  | 107 +++++-----
>  qapi/virtio.json                              |  50 ++---
>  qapi/yank.json                                |   6 +-
>  qga/qapi-schema.json                          |  48 ++---
>  scripts/qapi-lint.sh                          |  51 +++++
>  scripts/qapi/Makefile                         |   5 +
>  scripts/qapi/introspect.py                    |  12 +-
>  scripts/qapi/parser.py                        | 104 ++++++++--
>  scripts/qapi/schema.py                        |  54 ++++-
>  scripts/qapi/source.py                        |   4 +-
>  scripts/qapi/types.py                         |   4 +-
>  scripts/qapi/visit.py                         |   9 +-
>  tests/qapi-schema/doc-empty-section.err       |   2 +-
>  tests/qapi-schema/doc-empty-section.json      |   2 +-
>  tests/qapi-schema/doc-good.json               |  18 +-
>  tests/qapi-schema/doc-good.out                |  61 +++---
>  tests/qapi-schema/doc-good.txt                |  31 +--
>  .../qapi-schema/doc-interleaved-section.json  |   2 +-
>  47 files changed, 1152 insertions(+), 753 deletions(-)
>  create mode 100755 scripts/qapi-lint.sh
>  create mode 100644 scripts/qapi/Makefile
>=20
> --=20
> 2.44.0
>=20
>=20

For block-core.json/block-export.json/block.json:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--ddtIcneASRVMGzP2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZGSMMACgkQnKSrs4Gr
c8jcDwf9G1inq8BCxQ9PZvSALwQDONR5qIuIxmjr+LVl5Xoz9oDkEhUrjuoYwHfq
KWM3LKCzxvdT0XWGyR2skkkB0mckAsJIiSR0K2xdEzjJgi9Ea3IQsIwKNFLS74zA
TzBp0OQlBE3C5MYxvNOekUSZ3zDWcaDl6t6/RdhtYMHVMDGmTusfKVEXh4N5TS0e
3WDaV0/p3pZer/UHRgXxB17uTaEgQtpDsBH7P4cJQzrS0WXILUSoipvXrBgLmPsl
+qEOCG0YCmPoeKDRS9Hc0aCNus6OR+C5HMIEKLWtCCTJgdQj1FE3AsFnMVnxetVW
ovJ+lRbQcOF6V/p2Gh57C2vsZs7txQ==
=clEV
-----END PGP SIGNATURE-----

--ddtIcneASRVMGzP2--


