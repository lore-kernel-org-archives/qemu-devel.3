Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E481C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVrY-0001SK-S0; Wed, 22 Jul 2026 08:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmVrX-0001S4-Ef
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmVrU-0005lb-MU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784722542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il2iJMVjZQCsqFCEuOX5Gn1j7lRuc8N16zrXPFhfBHM=;
 b=HEIYkHxJV0/ezLrLcQukjtTOOtnNlxTKXMyh4t8zOACpnxolG0O5NL1awE0vxdbsPjoie2
 LpEKLYxmOTYVxJDz6wFMYC2tuNRPikSNHPsZHyay56fWhiLQM4k6IL+pqknKffq2SuWjRN
 wOgnZN9ct30N0hz7AUrrt2y1Baif0og=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-lwxo-iblOmeJK0wCKm1Krw-1; Wed,
 22 Jul 2026 08:15:39 -0400
X-MC-Unique: lwxo-iblOmeJK0wCKm1Krw-1
X-Mimecast-MFC-AGG-ID: lwxo-iblOmeJK0wCKm1Krw_1784722538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33F41955DE9; Wed, 22 Jul 2026 12:15:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B82901956042; Wed, 22 Jul 2026 12:15:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EC8721E6920; Wed, 22 Jul 2026 14:15:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Roland Clobus <rclobus@rclobus.nl>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 1/5] virtio-gpu: Support the configurable EDID fields
In-Reply-To: <20260707075536.126865-1-rclobus@rclobus.nl> (Roland Clobus's
 message of "Tue, 7 Jul 2026 09:47:56 +0200")
References: <20260707075536.126865-1-rclobus@rclobus.nl>
Date: Wed, 22 Jul 2026 14:15:34 +0200
Message-ID: <87cxwfjk49.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Roland Clobus <rclobus@rclobus.nl> writes:

> Adds support for the fields that are currently configurable
> in the function qemu_edid_generate.
>
> * The serial number does not need to be numerical.
> See https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
>
> * The name can be optional, there are now many more fields to set
>
> Signed-off-by: Roland Clobus <rclobus@rclobus.nl>

[...]

> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 09dd0e6d05..791d2f30f1 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,24 +970,62 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.  If both @xres and
> -# @yres are set, they take precedence over root virtio-gpu resolution
> -# configuration and enable the corresponding output.  If none of @xres
> -# and @yres are set, root virtio-gpu resolution configuration takes
> -# precedence and only the first output is enabled.  Only setting one
> -# of @xres or @yres is an error.
> +# Describes configuration of a VirtIO GPU output.  Matches the fields
> +# of struct @qemu_edid_info.

Blank lines between paragraphs, so they get actually rendered as
separate paragraphs.

If VirtIOGPUOutput matches qemu_edid_info, could it *replace*
qemu_edid_info?

> +# If values are set, they take precedence over the root virtio-gpu
> +# configuration.
> +# If none of @xres and @yres are set, the root virtio-gpu resolution
> +# configuration is used and only the first output is enabled.
> +#
> +# @vendor: a 3 letter code for the vendor (since xx.x TODO)
> +#          Default: "RHT" (Red Hat, Inc.)

You need to replace the TODO placeholders before we can merge the patch.

Posting patches that are not ready for merge is okay, but please tag
them with RFC, and explain why in the cover letter.

>  #
>  # @name: the name of the output
> +#        Default: "QEMU Monitor"
> +#
> +# @serial: the serial number (since xx.x TODO)

What's the default?

> +#
> +# @widthmm: width of the display in mm (since xx.x TODO)

Contradiction: "in mm" vs.

> +#           If @widthmm is set, @heightmm must be set too
> +#           If both @widthmm and @heightmm are unset,
> +#             100 DPI is assumed

"DPI".  What's the unit?

Does the default apply to both widthmm and heightmm?

Also, fails to build:

    [77/78] Generating docs/QEMU manual with a custom command
    FAILED: [code=3D1] docs/docs.stamp=20
    /usr/bin/env CONFDIR=3Detc/qemu /work/armbru/qemu/bld-docs/pyvenv/bin/s=
phinx-build -q -j auto -W -Dkerneldoc_werror=3D1 -Dversion=3D11.0.90 -Drele=
ase=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d=
 /work/armbru/qemu/bld-docs/docs/manual.p /work/armbru/qemu/docs /work/armb=
ru/qemu/bld-docs/docs/manual
    /work/armbru/qemu/docs/../qapi/virtio.json:973: ERROR: Unexpected inden=
tation. [docutils]

With the indentation fixed, this gets rendered like

    =E2=80=A2 widthmm (int, optional) =E2=80=93 width of the display in mm =
(since xx.x
      TODO) If widthmm is set, heightmm must be set too If both widthmm
      and heightmm are unset, 100 DPI is assumed

End your sentences with punctuation, and separate your paragraphs with
blank lines, please.

> +#
> +# @heightmm: height of the display in mm (since xx.x TODO)
> +#           If @heightmm is set, @widthmm must be set too

Please separate words with dashes in member names: width-mm, height-mm.

We don't normally put the unit in the member name.  E.g.

    ##
    # @ChardevVC:
    #
    # Configuration info for virtual console chardevs.
    #
    # @width: console width, in pixels
    #
    # @height: console height, in pixels
    #
    # @cols: console width, in chars
    #
    # @rows: console height, in chars

Perhaps an argument could be made that it's helpful here, because
millimeters is unusual.

>  #
>  # @xres: horizontal resolution of the output in pixels (since 11.0)
> +#        If @xres is set, @yres must be set too
>  #
>  # @yres: vertical resolution of the output in pixels (since 11.0)
> +#        If @yres is set, @xres must be set too

Defaults?

> +#
> +# @xmax: maximum horizontal resolution of the output in pixels
> +#        If @xmax is set, @ymax must be set too
> +#        (since xx.x TODO)
> +#
> +# @ymax: maximum vertical resolution of the output in pixels
> +#        If @ymax is set, @xmax must be set too
> +#        (since xx.x TODO)

Defaults?

> +#
> +# @refreshrate: refreshrate in mHz (since xx.x TODO)
> +#               Default: 75000
> +#
> +# .. note:: keep the defaults in sync with hw/display/edid-generate.c
>  #
>  # Since: 10.1
>  ##
>=20=20
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
> +  'data': { '*vendor': 'str',
> +            '*name': 'str',
> +            '*serial': 'str',
> +            '*widthmm': 'uint16',
> +            '*heightmm': 'uint16',
> +            '*xres': 'uint32',
> +            '*yres': 'uint32',
> +            '*xmax': 'uint32',
> +            '*ymax': 'uint32',
> +            '*refreshrate': 'uint32' } }
>=20=20
>  ##
>  # @DummyVirtioForceArrays:


