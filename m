Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758D6E68140
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGAk-0004LC-5W; Tue, 17 Feb 2026 03:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsGAe-0004K5-Oa
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsGAa-0007w1-Kh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771315855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W/Uo1E2dvgODleIPWmMm3wQNyuE6fpc4NHRDCY16G/w=;
 b=d6+vQAGGboApsSu9eLVPAh7e3p5Ff1EuXOurkEHIO0Wphs3dHcWTvkFhVN+CfUxD50DSFK
 zLreH4tqfANdGiVL6cw9Pp/xLiHQg9Fwuysv3pg5kaSXJXuNsEbF2YmwWArCPPOMSY+YrZ
 bNqBspUvB68DYkZADfknY/47rj5mWt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-7e1gE1sfO2KKRdM9pFf-5w-1; Tue, 17 Feb 2026 03:10:53 -0500
X-MC-Unique: 7e1gE1sfO2KKRdM9pFf-5w-1
X-Mimecast-MFC-AGG-ID: 7e1gE1sfO2KKRdM9pFf-5w_1771315852
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-437700715ddso3682220f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 00:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771315851; cv=none;
 d=google.com; s=arc-20240605;
 b=esZQZjOQENP3wT1091wA88XY7rxGoSkn+HZAdtS77Knz+w9CenR2dId3Gyeu/SnlyR
 nvq9o1ODYjxdRU6PgemE0tshT13Gb8nZQDUN8yul3vGejxZDpTy6icP1Y2W5PrfiBn9s
 RzlAMcQik8OZ4LfZ74DCg0BJoJjggTEQk+gk8+WebMF97ndDBJX1malG2KWKECR/3kjo
 5UgXW4ZvfNWvlcSIGMaGkm+6ruGijeqHT8UcQlyG9+JsP2IWgOYqWqrcuWLMjqjkBvD0
 ac9eisOqYPkNcm3KXUsF8UvxGq3Qy4kvN9S7wFQ5NltfQantcTJ5QWUe6seT6uKQvF5k
 HJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W/Uo1E2dvgODleIPWmMm3wQNyuE6fpc4NHRDCY16G/w=;
 fh=ZiiJLlGSxy3IuhAY0ANTK0BsXUNxPjkZuGmQBuodCsY=;
 b=kaJGh8pIxoFqr8VzJRmoNUGGwRYFON2zsE5tnEf0+zbuAOoLjwCg3ECQB2fO16lZPD
 lUHKUFTQYH37Gd1RHDLEAvKscS32UeYQYth8QUavOS5aX1Bfap5ybbDaNfTkHpSyD0vN
 dR6jWyCwCxzTRwLwxfpMQuQddzXpTFSRaWifeJxClGi4f+hGlPAttjCJqMmIa7McBoHS
 qN39gSzaab/XBWvESyVKicCWs0hNa+yHpsd5Z7ewugDipM3Dt+BySJrt+YF93pPPzxv/
 ZN5s+MLJcGo2MoShoUjHPwjRNtcR7Ej8ohjLJY9b86uk8NzPQYCVhrhN7pThdcIrUBej
 aMWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771315851; x=1771920651; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W/Uo1E2dvgODleIPWmMm3wQNyuE6fpc4NHRDCY16G/w=;
 b=jHQS6yZ4zFc5AoOZZGQqo9I/eeY4H4hdOHwsOfqcy5iOD2oj5u3ucN+x8iDeZSAEEK
 wtmGXeF0MX6/pwlD03GgwKRw9G4NBRigjpYBTLRTpU9WXMYCAj506NN1SQ3cjB72XzuD
 e4sJQECac9ptttzJ/et0MG7Jv2/COQsT9+Uho0BAIGdNrwZg3o2m4BXCSJpIx/3laJMt
 z8fUbyPE6UuQ3Gp6ofRmDG5yYC9yM6lxzhliwedf9o4EpTtlg/cUPdE2zMapWQ1yWKuH
 YGCYJ5byqC8XaRQmvvAqgFrf0F/UrlRrxBLze5LqKUZ/XJ4xnwg2NBm+XWG2zGObWKmp
 rJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771315851; x=1771920651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Uo1E2dvgODleIPWmMm3wQNyuE6fpc4NHRDCY16G/w=;
 b=wP/h2Pbsv5Hod1+zCSyweHz2GFGL0Vc/eXa5gjNrXQfNj00UO8EFzJwkoJcNg2Q2S8
 gFrPK7psByWGYtKrIPkMDAXvriKbriEwBC48QMRG9AQtFLlHI/BIn+ZpWVX/vq57Va4X
 jRs8AQzi+igJZGKeV1EXtc5bkeiOcBbc4YUWnWWaQ9OU66/y1R6klf7YmAbgp97M8BR0
 0J/IZQ6IRVU3KUppCIaoxwn9zvBM5T3xTt4o2ARS4Up7G2FTqwumShPTuFwobYzKtWb2
 VwNFn4V8idjq3BTSDoHQ4wj5XKSC/1KLdJzwvxc29PgvGkv44lJ0eLpnwbCMHk8CIq8Q
 IN5Q==
X-Gm-Message-State: AOJu0YwqjbjJ/j1cl03pnEC15SqPLivhY6lhvTuNUP7GMH6+ggbRdgZL
 3K8xmWeJJCdHg8mZsyBnSISiMPJ039AnnX0X+L7UJO8gdibNix7TZ/QnxPi+bq+pTDhUpW0VimY
 9yPho+Az5/p3UtpjrwA17TxYQHsKSUzWrv9Y34aujacW6b7M+UZ7i3Z2uP2lK+mE3nzD+QtTVIq
 uQAPjBOsFlQkKAs6b/7ThNCp974C+wu3sSdCkL728=
X-Gm-Gg: AZuq6aJ5McKFM5JLWCxbffNRgjLLzdY61WJLmQlFSS0XcmpP2q6OrmE0fPK9yUg/lBJ
 RhQ13aqA8jjvPxP2nfm/BXckY7XLFbtODMFeLCPkFcTH6CDY8E/Uy1uace4B4OvnNvSYsILO2M+
 i5YyUxp6nlcfMsUixoRcNEtfZdr6++axG7RLAdEx2gZWdPf3Be/n47R3iN2+vKma4iGOxRymbDX
 M+rVP95Q2uQqlfChQmaFJdV/wJEu9mdj9toxPsYzGO24qIE5HMouah4Uc8BfANi4nUTaqdHDpjF
 gC1F5RM=
X-Received: by 2002:a05:6000:2901:b0:437:8941:2f7b with SMTP id
 ffacd0b85a97d-43796ac2122mr25696928f8f.19.1771315850919; 
 Tue, 17 Feb 2026 00:10:50 -0800 (PST)
X-Received: by 2002:a05:6000:2901:b0:437:8941:2f7b with SMTP id
 ffacd0b85a97d-43796ac2122mr25696879f8f.19.1771315850403; Tue, 17 Feb 2026
 00:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20260108131043.490084-1-pbonzini@redhat.com>
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Feb 2026 09:10:40 +0100
X-Gm-Features: AaiRm51fVtbfMa94EpJi178a0cY3PvFqqtH1n_rBm29JZygzxWrSgyfs_T4FTX0
Message-ID: <CABgObfYhrxjW_TCNaxQkEvkN8trcYjkVz=tCQTO2pGQh6cvDHA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Armbruster, Markus" <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000000c78b0064b009c4d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000c78b0064b009c4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's been more than a month... Looking for reviews of the qapi-gen changes,
especially the non-Rust-specific parts.

Paolo

Il gio 8 gen 2026, 14:10 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> This adds two related parts of the Rust bindings:
>
> - QAPI code generator that creates Rust structs from the JSON
>   description.  The structs are *not* ABI compatible with the
>   C ones, instead they use native Rust data types.
>
> - QObject bindings and (de)serialization support, which can be used to
>   convert QObjects to and from QAPI structs.
>
> Unfortunately Rust code is not able to use visitors, other than by
> creating an intermediate QObject.  This is because of the different
> architecture of serde vs. QAPI visitors, and because visitor's
> dual-purpose functions, where the same function is used by both input and
> output visitors, rely heavily on the structs using the same representatio=
n
> as the visitor arguments (for example NUL-terminated strings).
>
> The serde format implementation was co-authored by me and Marc-Andr=C3=A9=
.
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
>          .and_then(|ret|
> to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));
>
>     match qmp_marshal_query_stats_rs(qobj) {
>         Ok(ret) =3D> unsafe { *retp =3D ret.into_raw(); },
>         Err(e) =3D> unsafe { crate::Error::from(e).propagate(errp) },
>     }
> }
>
> Despite the long v1->v2, the changes are mostly cosmetic; there are a few
> small differences in the detection of types to be wrapped with Box<>,
> because Vec<> is now considered to break cycles.
>
> Available at branch rust-next of https://gitlab.com/bonzini/qemu (which
> is now almost empty other than this series, yay).
>
> Paolo
>
> v1->v2, Rust:
> - adjust comments in C code (include/qobject/qobject.h)
> - improve or fix documentation in rust/util/src/qobject/mod.rs
> - introduce a qobject! macro that is equivalent to QOBJECT()
> - remark when functions are converted from C inlines
> - rename from_int/from_uint/from_double macros
> - fix incorrect "native: true" on serde and serde_core overrides
> - rebase
>
> qapi-gen:
> - rewrite QAPISchemaIfCond.rsgen() to avoid messy typing
> - new patches 10-11 to extend existing qapigen code
> - rewritten rs_type() to avoid going through a C type first
> - removed renaming of QAPICBackend
> - reused C functions for case conversions
> - clean up rs_name, move it to common.py (needed for rs_type() changes)
> - Vec<> can break cycles and avoid boxing of structs
> - restrict squashing of consecutive newlines to Rust code
> - add copyright blurb
> - annotate that using a separate qapi-gen backend is temporary
> - drop #[derive(common::TryInto)] from enums
>
> Marc-Andr=C3=A9 Lureau (7):
>   rust/qobject: add Display/Debug
>   scripts/qapi: add QAPISchemaIfCond.rsgen()
>   scripts/qapi: generate high-level Rust bindings
>   scripts/rustc_args: add --no-strict-cfg
>   rust/util: build QAPI types
>   scripts/qapi: add serde attributes
>   rust/tests: QAPI integration tests
>
> Paolo Bonzini (9):
>   rust/qobject: add basic bindings
>   subprojects: add serde
>   rust/qobject: add Serialize implementation
>   rust/qobject: add Serializer (to_qobject) implementation
>   rust/qobject: add Deserialize implementation
>   rust/qobject: add Deserializer (from_qobject) implementation
>   rust/qobject: add from/to JSON bindings for QObject
>   scripts/qapi: add QAPISchemaType.is_predefined
>   scripts/qapi: pull c_name from camel_to_upper to caller
>
>  docs/devel/rust.rst                           |   1 +
>  meson.build                                   |   4 +-
>  include/qobject/qobject.h                     |   5 +-
>  rust/util/wrapper.h                           |   8 +
>  qapi/meson.build                              |   9 +
>  rust/Cargo.lock                               |   2 +
>  rust/Cargo.toml                               |   2 +
>  rust/meson.build                              |   4 +
>  rust/tests/meson.build                        |  21 +-
>  rust/tests/tests/integration.rs               |   2 +
>  rust/tests/tests/qapi.rs                      | 444 +++++++++++++
>  rust/util/Cargo.toml                          |   2 +
>  rust/util/meson.build                         |  30 +-
>  rust/util/src/lib.rs                          |   4 +
>  rust/util/src/qobject/deserialize.rs          | 134 ++++
>  rust/util/src/qobject/deserializer.rs         | 371 +++++++++++
>  rust/util/src/qobject/error.rs                |  58 ++
>  rust/util/src/qobject/mod.rs                  | 383 ++++++++++++
>  rust/util/src/qobject/serialize.rs            |  59 ++
>  rust/util/src/qobject/serializer.rs           | 585 ++++++++++++++++++
>  scripts/archive-source.sh                     |   3 +
>  scripts/make-release                          |   2 +-
>  scripts/qapi/backend.py                       |  25 +
>  scripts/qapi/common.py                        |  66 +-
>  scripts/qapi/rs.py                            |  61 ++
>  scripts/qapi/rs_types.py                      | 394 ++++++++++++
>  scripts/qapi/schema.py                        |  74 ++-
>  scripts/rust/rustc_args.py                    |  16 +-
>  subprojects/.gitignore                        |   3 +
>  .../packagefiles/serde-1-rs/meson.build       |  36 ++
>  .../packagefiles/serde-1.0.226-include.patch  |  16 +
>  .../packagefiles/serde_core-1-rs/meson.build  |  25 +
>  .../serde_core-1.0.226-include.patch          |  15 +
>  .../serde_derive-1-rs/meson.build             |  35 ++
>  .../serde_derive-1.0.226-include.patch        |  11 +
>  subprojects/serde-1-rs.wrap                   |  11 +
>  subprojects/serde_core-1-rs.wrap              |  11 +
>  subprojects/serde_derive-1-rs.wrap            |  11 +
>  38 files changed, 2910 insertions(+), 33 deletions(-)
>  create mode 100644 rust/tests/tests/integration.rs
>  create mode 100644 rust/tests/tests/qapi.rs
>  create mode 100644 rust/util/src/qobject/deserialize.rs
>  create mode 100644 rust/util/src/qobject/deserializer.rs
>  create mode 100644 rust/util/src/qobject/error.rs
>  create mode 100644 rust/util/src/qobject/mod.rs
>  create mode 100644 rust/util/src/qobject/serialize.rs
>  create mode 100644 rust/util/src/qobject/serializer.rs
>  create mode 100644 scripts/qapi/rs.py
>  create mode 100644 scripts/qapi/rs_types.py
>  create mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/serde-1.0.226-include.patch
>  create mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
>  create mode 100644
> subprojects/packagefiles/serde_core-1.0.226-include.patch
>  create mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.buil=
d
>  create mode 100644
> subprojects/packagefiles/serde_derive-1.0.226-include.patch
>  create mode 100644 subprojects/serde-1-rs.wrap
>  create mode 100644 subprojects/serde_core-1-rs.wrap
>  create mode 100644 subprojects/serde_derive-1-rs.wrap
>
> --
> 2.52.0
>

--0000000000000c78b0064b009c4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It&#39;s been more than a month... Looking for reviews of=
 the qapi-gen changes, especially the non-Rust-specific parts.<div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 8 =
gen 2026, 14:10 Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pb=
onzini@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">This adds two related parts of the Rust bindings:<br>
<br>
- QAPI code generator that creates Rust structs from the JSON<br>
=C2=A0 description.=C2=A0 The structs are *not* ABI compatible with the<br>
=C2=A0 C ones, instead they use native Rust data types.<br>
<br>
- QObject bindings and (de)serialization support, which can be used to<br>
=C2=A0 convert QObjects to and from QAPI structs.<br>
<br>
Unfortunately Rust code is not able to use visitors, other than by<br>
creating an intermediate QObject.=C2=A0 This is because of the different<br=
>
architecture of serde vs. QAPI visitors, and because visitor&#39;s<br>
dual-purpose functions, where the same function is used by both input and<b=
r>
output visitors, rely heavily on the structs using the same representation<=
br>
as the visitor arguments (for example NUL-terminated strings).<br>
<br>
The serde format implementation was co-authored by me and Marc-Andr=C3=A9.<=
br>
Marc-Andr=C3=A9 did all the bug fixing and integration testing.<br>
<br>
As an example of how this would be used, the marshaling functions for<br>
QMP commands would look like this:<br>
<br>
fn qmp_marshal_query_stats(args: *mut QDict,<br>
=C2=A0 =C2=A0 retp: *mut *mut QObject, errp: *mut *mut Error)<br>
{<br>
=C2=A0 =C2=A0 let qobj =3D unsafe { QObject::cloned_from_raw(args.cast()) }=
;<br>
<br>
=C2=A0 =C2=A0 let result =3D from_qobject::&lt;StatsFilter&gt;(qobj)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_err(anyhow::Error::from)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.and_then(qmp_query_stats)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.and_then(|ret| to_qobject::&lt;Vec&lt;St=
atsResult&gt;&gt;(ret).map_err(anyhow::Error::from));<br>
<br>
=C2=A0 =C2=A0 match qmp_marshal_query_stats_rs(qobj) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(ret) =3D&gt; unsafe { *retp =3D ret.into_raw=
(); },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Err(e) =3D&gt; unsafe { crate::Error::from(e).p=
ropagate(errp) },<br>
=C2=A0 =C2=A0 }<br>
}<br>
<br>
Despite the long v1-&gt;v2, the changes are mostly cosmetic; there are a fe=
w<br>
small differences in the detection of types to be wrapped with Box&lt;&gt;,=
<br>
because Vec&lt;&gt; is now considered to break cycles.<br>
<br>
Available at branch rust-next of <a href=3D"https://gitlab.com/bonzini/qemu=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/bonzin=
i/qemu</a> (which<br>
is now almost empty other than this series, yay).<br>
<br>
Paolo<br>
<br>
v1-&gt;v2, Rust:<br>
- adjust comments in C code (include/qobject/qobject.h)<br>
- improve or fix documentation in rust/util/src/qobject/mod.rs<br>
- introduce a qobject! macro that is equivalent to QOBJECT()<br>
- remark when functions are converted from C inlines<br>
- rename from_int/from_uint/from_double macros<br>
- fix incorrect &quot;native: true&quot; on serde and serde_core overrides<=
br>
- rebase<br>
<br>
qapi-gen:<br>
- rewrite QAPISchemaIfCond.rsgen() to avoid messy typing<br>
- new patches 10-11 to extend existing qapigen code<br>
- rewritten rs_type() to avoid going through a C type first<br>
- removed renaming of QAPICBackend<br>
- reused C functions for case conversions<br>
- clean up rs_name, move it to common.py (needed for rs_type() changes)<br>
- Vec&lt;&gt; can break cycles and avoid boxing of structs<br>
- restrict squashing of consecutive newlines to Rust code<br>
- add copyright blurb<br>
- annotate that using a separate qapi-gen backend is temporary<br>
- drop #[derive(common::TryInto)] from enums<br>
<br>
Marc-Andr=C3=A9 Lureau (7):<br>
=C2=A0 rust/qobject: add Display/Debug<br>
=C2=A0 scripts/qapi: add QAPISchemaIfCond.rsgen()<br>
=C2=A0 scripts/qapi: generate high-level Rust bindings<br>
=C2=A0 scripts/rustc_args: add --no-strict-cfg<br>
=C2=A0 rust/util: build QAPI types<br>
=C2=A0 scripts/qapi: add serde attributes<br>
=C2=A0 rust/tests: QAPI integration tests<br>
<br>
Paolo Bonzini (9):<br>
=C2=A0 rust/qobject: add basic bindings<br>
=C2=A0 subprojects: add serde<br>
=C2=A0 rust/qobject: add Serialize implementation<br>
=C2=A0 rust/qobject: add Serializer (to_qobject) implementation<br>
=C2=A0 rust/qobject: add Deserialize implementation<br>
=C2=A0 rust/qobject: add Deserializer (from_qobject) implementation<br>
=C2=A0 rust/qobject: add from/to JSON bindings for QObject<br>
=C2=A0 scripts/qapi: add QAPISchemaType.is_predefined<br>
=C2=A0 scripts/qapi: pull c_name from camel_to_upper to caller<br>
<br>
=C2=A0docs/devel/rust.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A04 +-<br>
=C2=A0include/qobject/qobject.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0rust/util/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
=C2=A0qapi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0rust/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+<br>
=C2=A0rust/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+<br>
=C2=A0rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0rust/tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 21 +-<br>
=C2=A0rust/tests/tests/integration.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0rust/tests/tests/qapi.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 444 +++++++++++++<br>
=C2=A0rust/util/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0rust/util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 30 +-<br>
=C2=A0rust/util/src/lib.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0rust/util/src/qobject/deserialize.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 134 ++++<br>
=C2=A0rust/util/src/qobject/deserializer.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 371 +++++++++++<br>
=C2=A0rust/util/src/qobject/error.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 58 ++<br>
=C2=A0rust/util/src/qobject/mod.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 383 ++++++++++++<br>
=C2=A0rust/util/src/qobject/serialize.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 59 ++<br>
=C2=A0rust/util/src/qobject/serializer.rs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 585 ++++++++++++++++++<br>
=C2=A0scripts/archive-source.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0scripts/make-release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0scripts/qapi/backend.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +<br>
=C2=A0scripts/qapi/common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 66 +-<br>
=C2=A0scripts/qapi/rs.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 61 ++<br>
=C2=A0scripts/qapi/rs_types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 394 ++++++++++++<br>
=C2=A0scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 ++-<br>
=C2=A0scripts/rust/rustc_args.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 +-<br>
=C2=A0subprojects/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0.../packagefiles/serde-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 36 ++<br>
=C2=A0.../packagefiles/serde-1.0.226-include.patch=C2=A0 |=C2=A0 16 +<br>
=C2=A0.../packagefiles/serde_core-1-rs/meson.build=C2=A0 |=C2=A0 25 +<br>
=C2=A0.../serde_core-1.0.226-include.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 15 +<br>
=C2=A0.../serde_derive-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 35 ++<br>
=C2=A0.../serde_derive-1.0.226-include.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 11 +<br>
=C2=A0subprojects/serde-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +<br>
=C2=A0subprojects/serde_core-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 11 +<br>
=C2=A0subprojects/serde_derive-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 11 +<br>
=C2=A038 files changed, 2910 insertions(+), 33 deletions(-)<br>
=C2=A0create mode 100644 rust/tests/tests/integration.rs<br>
=C2=A0create mode 100644 rust/tests/tests/qapi.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/deserialize.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/deserializer.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/error.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/mod.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/serialize.rs<br>
=C2=A0create mode 100644 rust/util/src/qobject/serializer.rs<br>
=C2=A0create mode 100644 scripts/qapi/rs.py<br>
=C2=A0create mode 100644 scripts/qapi/rs_types.py<br>
=C2=A0create mode 100644 subprojects/packagefiles/serde-1-rs/meson.build<br=
>
=C2=A0create mode 100644 subprojects/packagefiles/serde-1.0.226-include.pat=
ch<br>
=C2=A0create mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.bui=
ld<br>
=C2=A0create mode 100644 subprojects/packagefiles/serde_core-1.0.226-includ=
e.patch<br>
=C2=A0create mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.b=
uild<br>
=C2=A0create mode 100644 subprojects/packagefiles/serde_derive-1.0.226-incl=
ude.patch<br>
=C2=A0create mode 100644 subprojects/serde-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/serde_core-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/serde_derive-1-rs.wrap<br>
<br>
-- <br>
2.52.0<br>
</blockquote></div>

--0000000000000c78b0064b009c4d--


