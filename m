Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6F8D2F7CC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRSPV-0007jq-53; Fri, 05 Dec 2025 04:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSPS-0007jX-Ge
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSPQ-0006Qv-Jw
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764928047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPIjaK4gdfZC/k3k+VgKAws/2FHPuNNPy0zNAhULPEY=;
 b=MSLSk0tZCeZv0pbH6Yz9HtZvTpIVfUKVPxHcfB2AIYvNMM2vb5+PCegBP9Lo+yTZR30ed3
 EZRjj9ETCdtxePkQFj5qniDq723NT7aMo4SukXtu+5X6OY7VFWl+r0nfyhi23BxKfXhAvb
 Rri7j7f1t8bOeGkRC9kJuXlGWWWG/lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-H33kBs3kPBSsmtFTrIt6fw-1; Fri,
 05 Dec 2025 04:47:25 -0500
X-MC-Unique: H33kBs3kPBSsmtFTrIt6fw-1
X-Mimecast-MFC-AGG-ID: H33kBs3kPBSsmtFTrIt6fw_1764928044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68D36180034C; Fri,  5 Dec 2025 09:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEFDD3011A84; Fri,  5 Dec 2025 09:47:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1013321E6A27; Fri, 05 Dec 2025 10:47:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 06/19] rust/qobject: add Serialize implementation
In-Reply-To: <20251010151006.791038-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:51 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-7-pbonzini@redhat.com>
Date: Fri, 05 Dec 2025 10:47:21 +0100
Message-ID: <87a4zx5kgm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                    |  1 +
>  rust/util/Cargo.toml               |  1 +
>  rust/util/meson.build              |  3 +-
>  rust/util/src/qobject/mod.rs       |  4 +-
>  rust/util/src/qobject/serialize.rs | 59 ++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 3 deletions(-)
>  create mode 100644 rust/util/src/qobject/serialize.rs
>
> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index 11085133490..7c9f85d5728 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -445,6 +445,7 @@ dependencies =3D [
>   "foreign",
>   "glib-sys",
>   "libc",
> + "serde",
>  ]
>=20=20
>  [[package]]
> diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
> index 85f91436545..554004816eb 100644
> --- a/rust/util/Cargo.toml
> +++ b/rust/util/Cargo.toml
> @@ -17,6 +17,7 @@ anyhow =3D { workspace =3D true }
>  foreign =3D { workspace =3D true }
>  glib-sys =3D { workspace =3D true }
>  libc =3D { workspace =3D true }
> +serde =3D { workspace =3D true }
>  common =3D { path =3D "../common" }
>=20=20
>  [lints]
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index ce468ea5227..9fafaf76a37 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -39,10 +39,11 @@ _util_rs =3D static_library(
>      {'.': _util_bindings_inc_rs,
>      'qobject': [
>        'src/qobject/mod.rs',
> +      'src/qobject/serialize.rs',
>      ]}),
>    override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
>    rust_abi: 'rust',
> -  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs,=
 qom, qemuutil],
> +  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs,=
 serde_rs, qom, qemuutil],
>  )
>=20=20
>  util_rs =3D declare_dependency(link_with: [_util_rs])
> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
> index 9c6f168d6e1..0913fabc1ee 100644
> --- a/rust/util/src/qobject/mod.rs
> +++ b/rust/util/src/qobject/mod.rs
> @@ -6,6 +6,8 @@
>=20=20
>  #![deny(clippy::unwrap_used)]
>=20=20
> +mod serialize;
> +
>  use std::{
>      cell::UnsafeCell,
>      ffi::{c_char, CString},
> @@ -230,7 +232,6 @@ fn drop(&mut self) {
>      }
>  }
>=20=20
> -#[allow(unused)]
>  macro_rules! match_qobject {
>      (@internal ($qobj:expr) =3D>
>          $(() =3D> $unit:expr,)?
> @@ -313,5 +314,4 @@ macro_rules! match_qobject {
>                  $($type $(($val))? =3D> $code,)+)
>      };
>  }
> -#[allow(unused_imports)]
>  use match_qobject;
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

Could this be a programming error?  Like flawed input validation?

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


