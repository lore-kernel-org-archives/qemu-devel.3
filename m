Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04763D2F7D1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 10:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRSgC-0003lG-OY; Fri, 05 Dec 2025 05:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSgB-0003l7-6x
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSg9-0002XJ-Tp
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764929085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYDlm1SphlMuMIM3Wj/rljQQu8Q+Z0qgflSfIEvCuBk=;
 b=JJFlovefWJURhBLUawytBVtbyPmVDJ9QDISakcrZxaSDRorG91Nnt81iK2D3gD8ocoERf+
 Vh5thhOlEbvD5n0MwVYTlaoRp6P0Mp8mkfjGNENx3FO49S6REQ/zr8ijZODXJ24rqRogYZ
 TPV78zYVGgk6uLzQyUqoflGrsRfHp84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-VJ7VEswOMPqdbPkoapJANQ-1; Fri,
 05 Dec 2025 05:04:40 -0500
X-MC-Unique: VJ7VEswOMPqdbPkoapJANQ-1
X-Mimecast-MFC-AGG-ID: VJ7VEswOMPqdbPkoapJANQ_1764929079
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5218C1956052; Fri,  5 Dec 2025 10:04:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A0E0180035A; Fri,  5 Dec 2025 10:04:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EE1921E6A27; Fri, 05 Dec 2025 11:04:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
In-Reply-To: <20251010151006.791038-12-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:56 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-12-pbonzini@redhat.com>
Date: Fri, 05 Dec 2025 11:04:36 +0100
Message-ID: <875xal5jnv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> These are used by tests.  However it could even be an idea to use
> serde_json + transcoding and get rid of the C version...

Tell me more!

> Co-authored-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/wrapper.h          |  1 +
>  rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
> index 0907dd59142..c88820a5e5b 100644
> --- a/rust/util/wrapper.h
> +++ b/rust/util/wrapper.h
> @@ -37,3 +37,4 @@ typedef enum memory_order {
>  #include "qobject/qobject.h"
>  #include "qobject/qlist.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qjson.h"
> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
> index e896aba5f3a..292a3c9c238 100644
> --- a/rust/util/src/qobject/mod.rs
> +++ b/rust/util/src/qobject/mod.rs
> @@ -23,6 +23,7 @@
>  use common::assert_field_type;
>  pub use deserializer::from_qobject;
>  pub use error::{Error, Result};
> +use foreign::prelude::*;
>  pub use serializer::to_qobject;
>=20=20
>  use crate::bindings;
> @@ -111,6 +112,22 @@ fn refcnt(&self) -> &AtomicUsize {
>          let qobj =3D self.0.get();
>          unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)=
) }
>      }
> +
> +    pub fn to_json(&self) -> String {
> +        let qobj =3D self.0.get();
> +        unsafe {
> +            let json =3D bindings::qobject_to_json(qobj);
> +            glib_sys::g_string_free(json, glib_sys::GFALSE).into_native()
> +        }
> +    }
> +
> +    pub fn from_json(json: &str) -> std::result::Result<Self, crate::Err=
or> {
> +        let c_json =3D std::ffi::CString::new(json)?;
> +        unsafe {
> +            crate::Error::with_errp(|errp| bindings::qobject_from_json(c=
_json.as_ptr(), errp))
> +                .map(|qobj| QObject::from_raw(qobj))
> +        }
> +    }
>  }
>=20=20
>  impl From<()> for QObject {


