Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88C6E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4GE-00035l-6m; Thu, 19 Feb 2026 08:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt4G3-00034Y-LL
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:39:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt4G0-0007nM-4f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771508388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaljMD62u0BYwZlmvd0GjRKdMofqd8/DmBFVgpaucWk=;
 b=adHh32eeAftS/DHjDWeoUv4ZjGPRAM0drX0yl9L9iQkskSLYo/VVAV+GlF0DeW0jfpgbJa
 C3ovs/ERLNuk0RGT5SSIdBPXDLbRBcQIdVBQoe/lB3UQFjUVgodkrJ7f/TkwQKpLoWjQ6X
 xoqMpOvLWWZTUWrQbMlAh5uOYEP731U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-luGsydmJM8mg6WYdfBKfeQ-1; Thu,
 19 Feb 2026 08:39:46 -0500
X-MC-Unique: luGsydmJM8mg6WYdfBKfeQ-1
X-Mimecast-MFC-AGG-ID: luGsydmJM8mg6WYdfBKfeQ_1771508386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E5F1800451; Thu, 19 Feb 2026 13:39:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49FA51954112; Thu, 19 Feb 2026 13:39:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8CD321E692D; Thu, 19 Feb 2026 14:39:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:27 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
Date: Thu, 19 Feb 2026 14:39:42 +0100
Message-ID: <877bs8rgwx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This adds two related parts of the Rust bindings:
>
> - QAPI code generator that creates Rust structs from the JSON
>   description.  The structs are *not* ABI compatible with the
>   C ones, instead they use native Rust data types.
>
> - QObject bindings and (de)serialization support, which can be used to
>   convert QObjects to and from QAPI structs.

To and from generated Rust structs, I presume.

> Unfortunately Rust code is not able to use visitors, other than by
> creating an intermediate QObject.  This is because of the different
> architecture of serde vs. QAPI visitors, and because visitor's
> dual-purpose functions, where the same function is used by both input and
> output visitors, rely heavily on the structs using the same representation
> as the visitor arguments (for example NUL-terminated strings).

Prior discussion of some aspects:

    Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from =
2021
    Date: Mon, 23 Jun 2025 14:52:46 +0200
    Message-ID: <877c1262n5.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/877c1262n5.fsf@pond.sub.org/

> The serde format implementation was co-authored by me and Marc-Andr=C3=A9.
> Marc-Andr=C3=A9 did all the bug fixing and integration testing.
>
> As an example of how this would be used, the marshaling functions for
> QMP commands would look like this:
>
> fn qmp_marshal_query_stats(args: *mut QDict,
>     retp: *mut *mut QObject, errp: *mut *mut Error)
> {
>     let qobj =3D unsafe { QObject::cloned_from_raw(args.cast()) };
>
>     let result =3D from_qobject::<StatsFilter>(qobj)
>          .map_err(anyhow::Error::from)
>          .and_then(qmp_query_stats)
>          .and_then(|ret| to_qobject::<Vec<StatsResult>>(ret).map_err(anyh=
ow::Error::from));
>
>     match qmp_marshal_query_stats_rs(qobj) {
>         Ok(ret) =3D> unsafe { *retp =3D ret.into_raw(); },
>         Err(e) =3D> unsafe { crate::Error::from(e).propagate(errp) },
>     }
> }

Scoring 0.23 UOUPNBL (uses of unsafe per non-blank line).  SCNR!

> Despite the long v1->v2, the changes are mostly cosmetic; there are a few
> small differences in the detection of types to be wrapped with Box<>,
> because Vec<> is now considered to break cycles.
>
> Available at branch rust-next of https://gitlab.com/bonzini/qemu (which
> is now almost empty other than this series, yay).
>
> Paolo


