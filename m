Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90953D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSwmA-0007AU-AF; Tue, 09 Dec 2025 07:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSwm8-0007AB-JL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSwm6-0004xL-S0
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765283100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyKYOnsWytdROJkeE/+8XKzgleSjncgMZz3onLwqT1A=;
 b=BSF76h2Wn9i50CZOBWY8E2/9+Q47jdCeUvQdmB5SaMVDpnsMeUH9CY13oPMnK5V1JsfsBP
 UXr72QBbRMb6CvyO5Wpf5nRRbqG5nNfcXdTfS7uMi4gAuWOJeVqYWLmn6HG5R7z+Rj0n1H
 1SnyNTGqn0JYjLGEL2uNec+/UWjrrv8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-BHVu5gm8PAaP5KJYbTv-AQ-1; Tue,
 09 Dec 2025 07:24:57 -0500
X-MC-Unique: BHVu5gm8PAaP5KJYbTv-AQ-1
X-Mimecast-MFC-AGG-ID: BHVu5gm8PAaP5KJYbTv-AQ_1765283096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91A11195605A; Tue,  9 Dec 2025 12:24:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FC3619560B6; Tue,  9 Dec 2025 12:24:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1FA421E6A27; Tue, 09 Dec 2025 13:24:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 15/19] scripts/qapi: add serde attributes
In-Reply-To: <20251010151006.791038-16-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:10:00 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-16-pbonzini@redhat.com>
Date: Tue, 09 Dec 2025 13:24:53 +0100
Message-ID: <87y0nb971m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate serde attributes to match the serialization format to QAPI's:
>
> - for enums, map Rust enum variants to original QAPI names
>
> - for structs, rejects JSON with extra fields and omit optional fields
>   (as opposed to serializing them as null)
>
> - for union variants:
>   - use tagged union format matching QAPI's discriminator,
>   - map variant names to original QAPI names
>   - flatten union data into parent struct
>
> - for alternates, use type-based discrimination
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Again, quick look at the generated code first.

Diff since the previous patch, with comments inline:

  diff -rup ex/commit-450ce0c076/example-qapi-types.rs ex/commit-dc1aa3de44=
/example-qapi-types.rs
  --- ex/commit-450ce0c076/example-qapi-types.rs	2025-12-09 08:28:34.167519=
593 +0100
  +++ ex/commit-dc1aa3de44/example-qapi-types.rs	2025-12-09 08:30:13.913250=
024 +0100
  @@ -11,27 +11,38 @@
   // that *could* be Eq too.
   #![allow(clippy::derive_partial_eq_without_eq)]

  +use serde_derive::{Serialize, Deserialize};
  +
   use util::qobject::QObject;


   #[repr(u32)]
  -#[derive(Copy, Clone, Debug, PartialEq, common::TryInto)]
  +#[derive(Copy, Clone, Debug, PartialEq, Serialize, Deserialize,
  +         common::TryInto)]
   pub enum QType {

  +    #[serde(rename =3D "none")]
       NONE,

NONE is an error value.  It must not occur as type of a QObject (see
qobject_type()'s assertion).  It should never occur in serialization /
deserializion.  Is there a way to instruct serde accordingly?

Related: generated QType_lookup[] maps QTYPE_NONE to "none", because the
generator special case required to map it to NULL isn't worth the
bother.

  +    #[serde(rename =3D "qnull")]
       QNULL,

  +    #[serde(rename =3D "qnum")]
       QNUM,

  +    #[serde(rename =3D "qstring")]
       QSTRING,

  +    #[serde(rename =3D "qdict")]
       QDICT,

  +    #[serde(rename =3D "qlist")]
       QLIST,

  +    #[serde(rename =3D "qbool")]
       QBOOL,

  +    #[serde(rename =3D "_MAX")]
       _MAX,

This one must not occur, either.  Generated QType_lookup[] does not have
a value for it.

   }

  @@ -44,12 +55,16 @@ impl Default for QType {
   }


  -#[derive(Clone, Debug, PartialEq)]
  +#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
  +#[serde(deny_unknown_fields)]
   pub struct UserDefOne {

  +=20=20=20=20

Funny extra blank line, next patch will revert it.

       pub integer: i64,

  +    #[serde(skip_serializing_if =3D "Option::is_none")]
       pub string: Option<String>,

  +    #[serde(skip_serializing_if =3D "Option::is_none")]
       pub flag: Option<bool>,
   }


