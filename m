Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD567CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnnY-00056i-Nb; Wed, 17 Jun 2026 06:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZnnW-00054F-B3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZnnU-0006nr-US
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781693222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8WpNq/riiRODWvdXRHqF1p7saZ3/LurLT1oPMnBwT4=;
 b=E3a+O0tmdgqA3ICNViZg6xz9fQMMeMluZlz7y1F1IYzzZ/ITcX5Bo6n5CZW//KoEOmO7M1
 WYR/+1al8W4aFdgN91s10Kf+8lbx+JQKjDu/x8Xq7noTTEFZR3eeTplr9GUS9NuMMzO2in
 GfchriMoZfhGWUGam5rMA62kBt78Z84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-vxS_HMD6OWO_fw9KRHnBbg-1; Wed,
 17 Jun 2026 06:46:58 -0400
X-MC-Unique: vxS_HMD6OWO_fw9KRHnBbg-1
X-Mimecast-MFC-AGG-ID: vxS_HMD6OWO_fw9KRHnBbg_1781693216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C22F1955EB2; Wed, 17 Jun 2026 10:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 229FD195410A; Wed, 17 Jun 2026 10:46:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7390821E6A01; Wed, 17 Jun 2026 12:46:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Peter Xu
 <peterx@redhat.com>,  =?utf-8?Q?Herv=C3=A9?= Poussineau
 <hpoussin@reactos.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 7/7] qom: improve error message for invalid ID values
In-Reply-To: <20260616155554.264412-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 16 Jun 2026 16:55:54
 +0100")
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-8-berrange@redhat.com>
Date: Wed, 17 Jun 2026 12:46:51 +0200
Message-ID: <87o6h9o350.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Include the actual ID that was validated, since this may not be
> obvious in all contexts.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reproducer?

I'm asking because:

    $ qemu-system-x86_64 -object id=3D@
    qemu-system-x86_64: -object id=3D@: Parameter 'id' expects an identifier
    Identifiers consist of letters, digits, '-', '.', '_', starting with a =
letter.

This is qemu_opts_create().

And:

    {"execute":"device_add","arguments":{"driver":"e1000", "id":"@"}}
    {"error": {"class": "GenericError", "desc": "Invalid qdev ID '@'"}}

This is qdev_set_id().

Ah, found it:

    $ qemu-system-x86_64 -object '{"id": "@", "qom-type": "iothread"}'
    qemu-system-x86_64: QOM ID value '@' is not valid
    Identifiers consist of letters, digits, '-', '.', '_', starting with a =
letter.

> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 415d5c5291..9cd17e3bcc 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -774,7 +774,7 @@ object_new_with_props_helper(const char *typename,
>             (id =3D=3D NULL && parent =3D=3D NULL));
>=20=20
>      if (id !=3D NULL && !id_wellformed(id)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identif=
ier");
> +        error_setg(errp, "QOM ID value '%s' is not valid", id);
>          error_append_hint(errp, "Identifiers consist of letters, digits,=
 "
>                            "'-', '.', '_', starting with a letter.\n");
>          return NULL;

Improvement, but what about other places reporting an error when
id_wellformed() fails?


