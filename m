Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FDEE9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupg1-0001Aq-IP; Tue, 24 Feb 2026 05:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vupfw-00017i-U1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vupfu-0008RU-Cl
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771928992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W46JeZ5dUBnZZzFMZ69ZeK7yRi3zGQxQwvHoeHtInHo=;
 b=c2uyk2BIbSmcHAdy0HuQoiOWUhdyw0y77We57ELv2B7s7PVwayKSZ5PRxeboYn6F87tK+p
 3dQHDxGWjFCd/6UaqFB43CAwag6L1mQW3He99QausneActbQrslkeaBj9jJshuNEvm/RE4
 s2wg7hQHlKu+ItRgSHvR3ras50ibB1E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-x5qXump9M9m0WrVLpAYbng-1; Tue,
 24 Feb 2026 05:29:49 -0500
X-MC-Unique: x5qXump9M9m0WrVLpAYbng-1
X-Mimecast-MFC-AGG-ID: x5qXump9M9m0WrVLpAYbng_1771928988
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6CC1195605A; Tue, 24 Feb 2026 10:29:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0215419560A2; Tue, 24 Feb 2026 10:29:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 926E721E692D; Tue, 24 Feb 2026 11:29:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 03/16] rust/qobject: add Serialize implementation
In-Reply-To: <20260108131043.490084-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:30 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-4-pbonzini@redhat.com>
Date: Tue, 24 Feb 2026 11:29:45 +0100
Message-ID: <87ecma4ep2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This allows QObject to be converted to other formats, for example
> JSON via serde_json.
>
> This is not too useful, since QObjects are consumed by
> C code or deserialized into structs, but it can be used for testing
> and it is part of the full implementation of a serde format.
>
> Co-authored-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

> diff --git a/rust/util/src/qobject/serialize.rs b/rust/util/src/qobject/s=
erialize.rs
> new file mode 100644
> index 00000000000..34ec3847c1d
> --- /dev/null
> +++ b/rust/util/src/qobject/serialize.rs
> @@ -0,0 +1,59 @@
> +//! `QObject` serialization
> +//!
> +//! This module implements the [`Serialize`] trait for `QObject`,
> +//! allowing it to be converted to other formats, for example
> +//! JSON.
> +
> +use std::{ffi::CStr, mem::ManuallyDrop, ptr::addr_of};
> +
> +use serde::ser::{self, Serialize, SerializeMap, SerializeSeq};
> +
> +use super::{match_qobject, QObject};
> +use crate::bindings;
> +
> +impl Serialize for QObject {
> +    #[inline]
> +    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
> +    where
> +        S: ::serde::Serializer,
> +    {
> +        match_qobject! { (self) =3D>
> +            () =3D> serializer.serialize_unit(),
> +            bool(b) =3D> serializer.serialize_bool(b),
> +            i64(i) =3D> serializer.serialize_i64(i),
> +            u64(u) =3D> serializer.serialize_u64(u),
> +            f64(f) =3D> serializer.serialize_f64(f),
> +            CStr(cstr) =3D> cstr.to_str().map_or_else(
> +                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),

.to_str() fails when its argument is invalid UTF-8.  It returns "an
error with details of where UTF-8 validation failed."[1]

Why are we replacing this error with a custom one?  I guess we add the
clue "in QString".  We also lose the details of where.  Feels like a
questionable trade.

Moreover, I believe this is a programming error: QString is not meant to
wrap arbitrary byte sequences, it's meant to wrap UTF-8 strings.
Programming errors should panic.

Can we use .expect()?  It panics "if the value is an Err, with a panic
message including the passed message, and the content of the Err."[2]

If we decide this isn't a programming error (because QString may contain
arbitrary zero-terminated byte sequences[3]): can we combine all the
readily available information like .expect() does?

In review of v2, you wrote

    I'd rather not special case this into the only abort (see the
    "#![deny(clippy::unwrap_used)]" in patch 4).

Is this an argument for pretending this isn't a programming error?  If
yes, I need a bit more help to understand it.

> +                |s| serializer.serialize_str(s),
> +            ),
> +            QList(l) =3D> {
> +                let mut node_ptr =3D unsafe { l.head.tqh_first };
> +                let mut state =3D serializer.serialize_seq(None)?;
> +                while !node_ptr.is_null() {
> +                    let node =3D unsafe { &*node_ptr };
> +                    let elem =3D unsafe { ManuallyDrop::new(QObject::fro=
m_raw(addr_of!(*node.value))) };
> +                    state.serialize_element(&*elem)?;
> +                    node_ptr =3D unsafe { node.next.tqe_next };
> +                }
> +                state.end()
> +            },
> +            QDict(d) =3D> {
> +                let mut state =3D serializer.serialize_map(Some(d.size))=
?;
> +                let mut e_ptr =3D unsafe { bindings::qdict_first(d) };
> +                while !e_ptr.is_null() {
> +                    let e =3D unsafe { &*e_ptr };
> +                    let key =3D unsafe { CStr::from_ptr(e.key) };
> +                    key.to_str().map_or_else(
> +                        |_| Err(ser::Error::custom("invalid UTF-8 in key=
")),
> +                        |k| state.serialize_key(k),
> +                    )?;
> +                    let value =3D unsafe { ManuallyDrop::new(QObject::fr=
om_raw(addr_of!(*e.value))) };
> +                    state.serialize_value(&*value)?;
> +                    e_ptr =3D unsafe { bindings::qdict_next(d, e) };
> +                }
> +                state.end()
> +            }
> +        }
> +    }
> +}

[1] https://doc.rust-lang.org/std/ffi/struct.CStr.html#method.to_str
[2] https://doc.rust-lang.org/std/result/enum.Result.html#method.expect
[3] Feels like a problematic idea to me.


