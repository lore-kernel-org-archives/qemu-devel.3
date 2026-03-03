Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C654EC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxME0-0007Wv-8L; Tue, 03 Mar 2026 04:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxMDt-0007WR-5d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxMDq-00070t-Rd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772530762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=wn7j5tpduQ9yc+0kyT16p7wSEWXwdwsvIZuE8Mz4aRs=;
 b=F5ui4qZoXKp8F96Xy0Ku2XpAvrumsperEcxc60zEG5q2CAxt9VCKBElvFe4wkwPDjhfNAU
 zE0zXexyYGTzuBEiJiKH4M9YPTLWLjOa91VYAGsH47Qeqh4XljPMWbhz9t8a4grHzOmqL0
 Q+tsm+KhIS79D4RP+fOGbR7FHfhpjUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-GBdnbKFROPSWVV2NIGxfHg-1; Tue,
 03 Mar 2026 04:39:18 -0500
X-MC-Unique: GBdnbKFROPSWVV2NIGxfHg-1
X-Mimecast-MFC-AGG-ID: GBdnbKFROPSWVV2NIGxfHg_1772530758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1137F1956072; Tue,  3 Mar 2026 09:39:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FC41800678; Tue,  3 Mar 2026 09:39:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E1FC21E692F; Tue, 03 Mar 2026 10:39:15 +0100 (CET)
Resent-To: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 03 Mar 2026 10:39:15 +0100
Resent-Message-ID: <87ldg9ntfg.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <20260108131043.490084-13-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:39 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
Date: Tue, 03 Mar 2026 10:19:13 +0100
Message-ID: <87seahnucu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Let's look at the generated Rust.  I'm going to ignore formatting issues
like blank lines.  My test inputs are adapted from
tests/qapi-schema/qapi-schema-test.json.

=3D Boilerplate and built-in stuff =3D

The qapi-types.rs generated for an empty schema is basically empty:

    // @generated by qapi-gen, DO NOT EDIT
    //!
    //! Schema-defined QAPI types
    //!
    //! Copyright (c) 2025 Red Hat, Inc.
    //!
    //! This work is licensed under the terms of the GNU LGPL, version 2.1 =
or
    //! later. See the COPYING.LIB file in the top-level directory.
    #![allow(unexpected_cfgs)]
    #![allow(non_camel_case_types)]
    #![allow(clippy::empty_structs_with_brackets)]
    #![allow(clippy::large_enum_variant)]
    #![allow(clippy::pub_underscore_fields)]
    // Because QAPI structs can contain float, for simplicity we never
    // derive Eq.  Clippy however would complain for those structs
    // that *could* be Eq too.
    #![allow(clippy::derive_partial_eq_without_eq)]
    use util::qobject::QObject;

Okay.

Note we generate nothing for the built-in types.  For C, we generate
qapi-builtin-types.[ch], which provides lists of built-in types, and
enum QType.  Rust gives us lists for free, and QType we don't need right
now.  Good.

=3D Enum types =3D

Input:

    { 'enum': 'TestIfEnum',
      'data': [ 'foo', { 'name' : 'bar', 'if': 'TEST_IF_ENUM_MEMBER' } ],
      'if': 'TEST_IF_UNION' }

Output without the boilerplate:

    #[cfg(TEST_IF_UNION)]
    #[derive(Copy, Clone, Debug, PartialEq)]

Ignoring such lines for now.

    #[repr(u32)]

As explained in the commit message.

    #[derive(common::TryInto)]

Ignoring these, too.

    pub enum TestIfEnum {

        FOO,
        #[cfg(TEST_IF_ENUM_MEMBER)]
        BAR,
    }

The obvious part :)

    #[cfg(TEST_IF_UNION)]
    impl Default for TestIfEnum {
        #[inline]
        fn default() -> TestIfEnum {
            Self::FOO
        }
    }

This specifies the enum type's default value.  Hmm...  Modified input:

    { 'enum': 'TestIfEnum',
      'data': [ { 'name' : 'bar', 'if': 'TEST_IF_ENUM_MEMBER' }, 'foo' ],
      'if': 'TEST_IF_UNION' }

Output:

    #[cfg(TEST_IF_UNION)]
    #[derive(Copy, Clone, Debug, PartialEq)]
    #[repr(u32)]
    #[derive(common::TryInto)]
    pub enum TestIfEnum {
        #[cfg(TEST_IF_ENUM_MEMBER)]
        BAR,

        FOO,
    }

    #[cfg(TEST_IF_UNION)]
    impl Default for TestIfEnum {
        #[inline]
        fn default() -> TestIfEnum {
            Self::BAR
        }
    }

If TEST_IF_ENUM_MEMBER is off, member BAR does not exist.  default()
uses it anyway.  Bug?

Not tested: enum definition's optional 'prefix' member, because Rust
generation has no need for it and does not use it.  Good.

=3D Object types =3D

Input:

    { 'struct': 'UserDefOne',
      'base': 'UserDefZero',
      'data': { 'string': 'str',
                '*number': 'number' } }

    { 'struct': 'UserDefZero',
      'data': { 'integer': 'int' } }

Output:

    #[derive(Clone, Debug, PartialEq)]

Ignoring such lines for now.

    pub struct UserDefOne {
        // Members inherited:

        pub integer: i64,
        // Own members:

        pub string: String,

        pub number: Option<f64>,
    }

    #[derive(Clone, Debug, PartialEq)]
    pub struct UserDefZero {

        pub integer: i64,
    }

Obvious enough.

More input:

    { 'union': 'TestIfUnion',
      'base': { 'type': 'TestIfEnum' },
      'discriminator': 'type',
      'data': { 'foo': 'UserDefOne',
                'bar': { 'type': 'UserDefZero', 'if': 'TEST_IF_ENUM_MEMBER'=
} },
      'if': { 'all': ['TEST_IF_UNION', 'TEST_IF_STRUCT'] } }

Output:

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    #[derive(Clone, Debug, PartialEq)]
    pub enum TestIfUnionVariant {

Possible trouble if somebody defines a QAPI type name ending with
'Variant'.

Code generated for a QAPI schema name named 'Frob' typically defines a
'Frob'.  Sometimes, we transform 'Frob' in (hopefully obvious) ways, say
to adhere to naming rules.  For instance, QAPI enum member 'foo' of
'TestIfEnum' becomes FOO in generated Rust.  This risks naming
collisions in generated code.  Hasn't been much of a problem in
practice.

We also need names for helpers.  These we commonly derive from QAPI
schema names, and we reserve names for the purpose:

* Names beginning with 'q_'

* Type names ending with 'List'

* Member name 'u' and names starting with 'has_'

Source: docs/devel/qapi-code-gen.rst section "Naming rules and reserved
names".

We could reserve names ending with 'Variant'.  Or we use a 'q_' prefix
here.

        Foo(UserDefOne),
        #[cfg(TEST_IF_ENUM_MEMBER)]
        Bar(UserDefZero),
    }

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    impl From<&TestIfUnionVariant> for TestIfEnum {
        fn from(e: &TestIfUnionVariant) -> Self {
            match e {

                TestIfUnionVariant::Foo(_) =3D> Self::FOO,
                #[cfg(TEST_IF_ENUM_MEMBER)]
                TestIfUnionVariant::Bar(_) =3D> Self::BAR,
            }
        }
    }

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    #[derive(Clone, Debug, PartialEq)]
    pub struct TestIfUnion {
        pub u: TestIfUnionVariant,
    }

Why do we need to wrap TestIfUnionVariant in a struct?  Hmm, we need it
in case we have more common members.  Modified input to demonstrate:

    { 'union': 'TestIfUnion',
      'base': { 'type': 'TestIfEnum', 'common': 'int' },
      'discriminator': 'type',
      'data': { 'foo': 'UserDefOne',
                'bar': { 'type': 'UserDefZero', 'if': 'TEST_IF_ENUM_MEMBER'=
} },
      'if': { 'all': ['TEST_IF_UNION', 'TEST_IF_STRUCT'] } }

Output:

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    #[derive(Clone, Debug, PartialEq)]
    pub enum TestIfUnionVariant {

        Foo(UserDefOne),
        #[cfg(TEST_IF_ENUM_MEMBER)]
        Bar(UserDefZero),
    }

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    impl From<&TestIfUnionVariant> for TestIfEnum {
        fn from(e: &TestIfUnionVariant) -> Self {
            match e {

                TestIfUnionVariant::Foo(_) =3D> Self::FOO,
                #[cfg(TEST_IF_ENUM_MEMBER)]
                TestIfUnionVariant::Bar(_) =3D> Self::BAR,
            }
        }
    }

    #[cfg(all(TEST_IF_UNION, TEST_IF_STRUCT))]
    #[derive(Clone, Debug, PartialEq)]
    pub struct TestIfUnion {

        pub common: i64,
        pub u: TestIfUnionVariant,
    }

Okay.

=3D Array types =3D

Input:

    { 'struct': 'ArrayStruct',
      'data': { 'integer': ['int'],
                '*any': ['any'] } }

Output:

    #[derive(Clone, Debug, PartialEq)]
    pub struct ArrayStruct {

        pub integer: Vec<i64>,

        pub any: Option<Vec<QObject>>,
    }

Okay.

=3D Alternate types =3D

Input:

    { 'alternate': 'TestIfAlternate',
      'data': { 'foo': 'int',
                'bar': { 'type': 'UserDefZero', 'if': 'TEST_IF_ALT_MEMBER'}=
 },
      'if': { 'all': ['TEST_IF_ALT', 'TEST_IF_STRUCT'] } }

Output:

    #[cfg(all(TEST_IF_ALT, TEST_IF_STRUCT))]
    #[derive(Clone, Debug, PartialEq)]
    pub enum TestIfAlternate {

            Foo(i64),
            #[cfg(TEST_IF_ALT_MEMBER)]
            Bar(UserDefZero),
    }

Doesn't use QType for the tag like C does.  Okay.


