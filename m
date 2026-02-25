Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBBCF357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9Ox-0004Kf-2T; Wed, 25 Feb 2026 02:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv9Ov-0004KP-Hk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv9Ou-0004oY-0A
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772004819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1IIefrHuZgT1Cj1wN5p85Y0G4qjjFOWqKRoc7T/TDSs=;
 b=PgePb/6GnOFKRM8tnyMXaEyEMvAJc4Pv98wPr4m/FSbo5tPwkG4e5KGRphHkdULXtHT+GH
 x3Sm5PD30fpysLKEQshtP5IQ3QXsBRh0+yERSn0Xb2apCFI2XkUgdQVX1JDrxziL4ptRPg
 SbXb8KpV7zUWGmNHDSgHOvn4uddNC48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-gPuNU7FEM-yIW6MIm9_riQ-1; Wed,
 25 Feb 2026 02:33:37 -0500
X-MC-Unique: gPuNU7FEM-yIW6MIm9_riQ-1
X-Mimecast-MFC-AGG-ID: gPuNU7FEM-yIW6MIm9_riQ_1772004816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 500B9195609E; Wed, 25 Feb 2026 07:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC9C81800348; Wed, 25 Feb 2026 07:33:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E23621E692D; Wed, 25 Feb 2026 08:33:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/16] scripts/qapi: add QAPISchemaType.is_predefined
In-Reply-To: <20260108131043.490084-11-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:37 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-11-pbonzini@redhat.com>
Date: Wed, 25 Feb 2026 08:33:33 +0100
Message-ID: <87bjhdxooi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> It is impossible to call is_implicit on an enum type from the visitor, because
> the QAPISchemaEnumType has already been exploded into its costituent fields.

constituent

Passing selected attributes instead of the entire object to its visitor
method limits what the visitor can do.  This is both good and bad.
We've run into "bad" a couple of times.  It's never been bad enough to
change the interface, though.

Thoughts?

> The Rust backend is also not modular (yet?) so it is not possible to filter
> out the builtin module;

Really?

The visitors are all based on QAPISchemaVisitor.  Protocol:

    .visit_begin()
    for all modules:
        .visit_module()
        for all entities:
            if .visit_needed():
                .visit_FOO()
    .visit_end()

QAPISchemaModularCVisitor implements .visit_module() to generate code
per module.  Its .write() skips builtin modules unless opt_builtins.

QAPISchemaMonolithicCVisitor is oblivious of modules: it doesn't
implement .visit_module(), and writes out everything.  This is fine,
because we use it only to generate qapi-features.[ch] and
qapi-introspect.[ch].  Generating the former has no need for recognizing
the built-ins because there are no built-in features.  Generating the
latter has no need because it treats built-in stuff exactly like
user-defined stuff.

QAPISchemaRsVisitor [PATCH 12] also doesn't implement .visit_module().
It uses QAPISchema.is_predefined(), defined in this patch, to skip
built-in.  Could it rely on .visit_module() instead?

>                         add a way to query for implicit type names without
> having the object itself.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/schema.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 848a7401251..15f5d97418f 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1243,6 +1243,17 @@ def _def_builtin_type(
>          # schema.
>          self._make_array_type(name, None)
>  
> +    def is_predefined(self, name: str) -> bool:
> +        # See QAPISchema._def_predefineds()
> +        entity = self._entity_dict[name]
> +        if isinstance(entity, QAPISchemaBuiltinType):
> +            return True
> +        if entity is self.the_empty_object_type:
> +            return True
> +        if name == 'QType':
> +            return True
> +        return False
> +
>      def _def_predefineds(self) -> None:
>          for t in [('str',    'string',  'char' + POINTER_SUFFIX),
>                    ('number', 'number',  'double'),


