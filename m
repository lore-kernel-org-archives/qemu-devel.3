Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9AAEA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuVAl-0004mP-CC; Mon, 23 Feb 2026 07:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuVAb-0004kr-Pv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuVAX-0001AS-LP
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771850167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3j2HMcoOdXaHOgWo6wvYD8LqVNOT1WJa/Yd3WahaLR8=;
 b=CH9r2KXoqfXAr4cDAS/QOuC9YBqcOufC/98kFlh3+e8q2LreY5YywJT+DM0WNCqdnLFNph
 L0A2GjiFprB6I7NawxQWMUk0YCBtue6VPKcqfGBQUOx9DyVYjTSjbE8nqk4rxiwlxxnDOW
 lmN7H/L+2FaOXyMLK7fIbeKSnxVrlpA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-OQyL3syYM2iR-XF2uuKuaQ-1; Mon,
 23 Feb 2026 07:36:04 -0500
X-MC-Unique: OQyL3syYM2iR-XF2uuKuaQ-1
X-Mimecast-MFC-AGG-ID: OQyL3syYM2iR-XF2uuKuaQ_1771850164
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C0C81956052; Mon, 23 Feb 2026 12:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C9CE1800348; Mon, 23 Feb 2026 12:36:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B17DE21E692D; Mon, 23 Feb 2026 13:36:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <20260108131043.490084-13-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:39 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
Date: Mon, 23 Feb 2026 13:36:00 +0100
Message-ID: <87ms0z7i33.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate high-level native Rust declarations for the QAPI types.
>
> - char* is mapped to String, scalars to there corresponding Rust types
>
> - enums use #[repr(u32)] and can be transmuted to their C counterparts
>
> - has_foo/foo members are mapped to Option<T>
>
> - lists are represented as Vec<T>
>
> - structures map fields 1:1 to Rust
>
> - alternate are represented as Rust enum, each variant being a 1-element
>   tuple
>
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). The discriminant
>   isn't a member of S, since Rust enum already include it, but it can be
>   recovered with "mystruct.u.into()"
>
> Anything that includes a recursive struct puts it in a Box.  Lists are
> not considered recursive, because Vec breaks the recursion (it's possible
> to construct an object containing an empty Vec of its own type).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lurea=
u@redhat.com
> [Paolo: rewrite conversion of schema types to Rust types]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Please mention how to actually generate Rust, because it's anything but
obvious: pass -B qapi.backend.QAPIRsBackend to qapi-gen.py.  Recommend
to mention it again in the cover letter.

Additionally, state that this is a hack we'll want to replace both in
the commit message and a TODO comment.  See review of v1's cover letter
for why.

[...]


