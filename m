Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D2C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wruiZ-00038Q-4D; Thu, 06 Aug 2026 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wruiY-00038I-7U
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 05:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wruiW-0008CO-1D
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 05:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786009726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0Shg2Brr2ErhA6VDqoBeKNZ3bzgChJX2V4ZAS69+8A=;
 b=OxY2Wvx9afGrGRUFcLMpx2tJGFX692DREJov0Pe14lacdbF3UGblmLb8F3uhyOeFZAqo1c
 nfcX9699IsZonpFFTpVpWYiJtnlCvOvf6Bb7AHDd7SWDgMPlJDuzyRLp9CJrzmYMSHNRDX
 S+482S5OlOO5KiAv3pEhYIJ2Pu+U9Ic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Ti-oMgFWMt-4FszmjA-b6g-1; Thu,
 06 Aug 2026 05:48:37 -0400
X-MC-Unique: Ti-oMgFWMt-4FszmjA-b6g-1
X-Mimecast-MFC-AGG-ID: Ti-oMgFWMt-4FszmjA-b6g_1786009716
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 798C418001E3; Thu,  6 Aug 2026 09:48:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AB30180049F; Thu,  6 Aug 2026 09:48:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 264B521E6920; Thu, 06 Aug 2026 11:48:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 02/53] qapi/introspect: expose the type name map
In-Reply-To: <20260616-qom-qapi-v2-2-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:28 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-2-cc9396b9c18c@redhat.com>
Date: Thu, 06 Aug 2026 11:48:33 +0200
Message-ID: <87v79nvatq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Preserve the internal-to-masked name map computed during introspection
> visitation and return it from gen_introspect(). The type-infos generator
> will consume this map to produce per-type QAPITypeInfo constants with
> correct masked names.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/introspect.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 7e28de2279a..d3d3de481f4 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -178,6 +178,7 @@ def __init__(self, prefix: str, unmask: bool):
>          self._trees: List[Annotated[SchemaInfo]] =3D []
>          self._used_types: List[QAPISchemaType] =3D []
>          self._name_map: Dict[str, str] =3D {}
> +        self._final_name_map: Dict[str, str] =3D {}
>          self._genc.add(mcgen('''
>  #include "qemu/osdep.h"
>  #include "%(prefix)sqapi-introspect.h"
> @@ -208,8 +209,17 @@ def visit_end(self) -> None:
>          self._schema =3D None
>          self._trees =3D []
>          self._used_types =3D []
> +        self._final_name_map =3D dict(self._name_map)
>          self._name_map =3D {}
>=20=20
> +    def name_map(self) -> Dict[str, str]:
> +        """Return the QAPI-name-to-schema-name map.
> +
> +        Must be called after visit() has completed; the map is
> +        populated during visit_end().
> +        """
> +        return self._final_name_map

Can you explain why ._final_name_map is useful?

> +
>      def visit_needed(self, entity: QAPISchemaEntity) -> bool:
>          # Ignore types on first pass; visit_end() will pick up used types
>          return not isinstance(entity, QAPISchemaType)
> @@ -387,7 +397,8 @@ def visit_event(self, name: str, info: Optional[QAPIS=
ourceInfo],
>=20=20
>=20=20
>  def gen_introspect(schema: QAPISchema, output_dir: str, prefix: str,
> -                   opt_unmask: bool) -> None:
> +                   opt_unmask: bool) -> Dict[str, str]:
>      vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
>      schema.visit(vis)
>      vis.write(output_dir)
> +    return vis.name_map()

Returning QAPISchemaGenIntrospectVisitor's existing map through
gen_introspect() works.

Taking a step back...  QAPISchemaGenIntrospectVisitor computes the set
of types that are actually used in QMP, and a map from type name to
masked type name.  Back when I wrote the class, nothing else was
interested in either of these two things, so keeping them within their
only user made sense.

Now you want masked type names for QAPISchemaGenTypeInfoVisitor.  And
the doc generator could use the set of types used in QMP to trim the QMP
reference manual.  Are these things still in the right place?

If no: we can move them to a better place before or after this series.
Before would be less churn in master, but more in your tree.  So perhaps
you'd rather have it done afterwards.


