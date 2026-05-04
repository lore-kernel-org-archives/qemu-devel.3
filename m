Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0CCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrMC-0004vh-VJ; Mon, 04 May 2026 07:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJrMB-0004ul-2H
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJrM9-0005BT-FC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777893656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFlMesDBUHyHgVacbVFj6IdebfQoN6OzC82hNQ07U3w=;
 b=QsIdmwbuXzradx4g2pazSUMn+5G0PDGeVbVQdGH71ZPvuoG9ZNKeIguEjF0Ms4xDpHOESx
 TYUIdwB+Tob7dkjNapisklOcrDqPKZvjiUdW5mUnRZfHX+78jLforCHsrjJZR5jpK2KeG8
 NWdsPtP/Mp7muTMPySyGlKslHWm88iI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-Hsv8nZVmNaaMBJ1p6yPzzA-1; Mon,
 04 May 2026 07:20:52 -0400
X-MC-Unique: Hsv8nZVmNaaMBJ1p6yPzzA-1
X-Mimecast-MFC-AGG-ID: Hsv8nZVmNaaMBJ1p6yPzzA_1777893651
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F174180034A; Mon,  4 May 2026 11:20:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 831D01955D84; Mon,  4 May 2026 11:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23D9621E6A01; Mon, 04 May 2026 13:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 05/13] qapi/docs: adjust stub member insertion algorithm
In-Reply-To: <20260429192611.1581223-6-jsnow@redhat.com> (John Snow's message
 of "Wed, 29 Apr 2026 15:26:03 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-6-jsnow@redhat.com>
Date: Mon, 04 May 2026 13:20:48 +0200
Message-ID: <87o6iva0a7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I'm feeling dense again.  Please be patient with me.

John Snow <jsnow@redhat.com> writes:

> A forthcoming patch removes the implicit PLAIN section that always
> starts a QAPIDoc section list. Further future changes begin converting
> "PLAIN" sections to "INTRO" sections. To accommodate this, the insertion
> algorithm that places stub and dummy members must be adjusted to cope.

What are the stub and dummy members?

> This algorithm can handle zero-or-more PLAIN *or* INTRO sections at the
> beginning of a QAPIDoc object.

The revised algorithm, I presume.

What's the structure of its valid input before and after this patch?

> Since we have three places that need to insert stub members, take the
> opportunity to unify and deduplicate this code.

Three?  I can only see two: Transmogrifier.visit_sections() and
QAPIDoc.connect_member().

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 36 ++++++++---------
>  scripts/qapi/parser.py | 90 +++++++++++++++++++++++++++---------------
>  2 files changed, 75 insertions(+), 51 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 1f7c15b7075..70ab9cdc214 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -349,30 +349,32 @@ def _get_target(
>                  )
>  
>      def visit_sections(self, ent: QAPISchemaDefinition) -> None:
> +        # Generate a placeholder right after the member section(s) which
> +        # will be used to generate documentation for "The members of..."
> +        # pointers in the rendered document.
> +        # This is a temporary hack until the inliner is merged.
> +        if ent.doc:
> +            ent.doc.append_member_stub(
> +                QAPIDoc.ArgSection(
> +                    ent.doc.info, QAPIDoc.Kind.MEMBER, "q_dummy"
> +                )
> +            )
> +

This hack is of the nastier sort: passing a QAPISchema to the doc
generator modifies it.

Would it be possible to add this dummy always in QAPISchema?  Any
drawbacks?

[Remainder left for later...]


