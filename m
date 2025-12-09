Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81321D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSuYy-0004w9-3I; Tue, 09 Dec 2025 05:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSuYw-0004un-9O
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSuYu-0004Ks-Eq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765274595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Aj4vBCiD8PsKyCpBrI1xDOY6Czu2z2tPYE49xVb+aY=;
 b=X7HlFYN80a+tuOhXwRpX7moj0Kd+FYvYytUsRiXRl4JImOdBOcnrwuDyjqIZiVU9rxRCaR
 FwffacHTLiDPHXqPfsk9fNw+Dip6xXnaBgUeYYJPOIMoIEV0VSPFIRyGvqBsFkwkea2Jnp
 SfuB3VPtQHjbLNlXXBfISJ3/WDwcf1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-z6-9FA5XOoSMhaXSmA46tw-1; Tue,
 09 Dec 2025 05:03:13 -0500
X-MC-Unique: z6-9FA5XOoSMhaXSmA46tw-1
X-Mimecast-MFC-AGG-ID: z6-9FA5XOoSMhaXSmA46tw_1765274592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F27195606E; Tue,  9 Dec 2025 10:03:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7B4E19560AD; Tue,  9 Dec 2025 10:03:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B0A021E6A27; Tue, 09 Dec 2025 11:03:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <20251010151006.791038-15-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:59 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com>
Date: Tue, 09 Dec 2025 11:03:09 +0100
Message-ID: <87v7ig3rc2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Generate high-level native Rust declarations for the QAPI types.
>
> - char* is mapped to String, scalars to there corresponding Rust types
>
> - enums are simply aliased from FFI
>
> - has_foo/foo members are mapped to Option<T>
>
> - lists are represented as Vec<T>
>
> - structures have Rust versions, with To/From FFI conversions
>
> - alternate are represented as Rust enum
>
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). However, the discriminant
>   isn't a member of S, since Rust enum already include it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lurea=
u@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I like to look at the generated code before I look at the code
generator.  My go-to schema for a first look is example-schema.json from
docs/devel/qapi-code-gen.rst:

    { 'struct': 'UserDefOne',
      'data': { 'integer': 'int', '*string': 'str', '*flag': 'bool' } }

    { 'command': 'my-command',
      'data': { 'arg1': ['UserDefOne'] },
      'returns': 'UserDefOne' }

    { 'event': 'MY_EVENT' }

Generated example-qapi-types.rs:

    // @generated by qapi-gen, DO NOT EDIT

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


    #[repr(u32)]
    #[derive(Copy, Clone, Debug, PartialEq, common::TryInto)]
    pub enum QType {

        NONE,

        QNULL,

        QNUM,

        QSTRING,

        QDICT,

        QLIST,

        QBOOL,

        _MAX,
    }


    impl Default for QType {
        #[inline]
        fn default() -> QType {
            Self::NONE
        }
    }


    #[derive(Clone, Debug, PartialEq)]
    pub struct UserDefOne {

        pub integer: i64,

        pub string: Option<String>,

        pub flag: Option<bool>,
    }

Questions / observations:

* Why is util::qobject::QObject needed?

* NONE is an error value, not a valid QType.  Having such error values
  in enums isn't unusual in C.  What about idiomatic Rust?  Even if it's
  unusual there, we may elect to do it anyway, just to keep generated
  Rust closer to C.  But it should be a conscious decision, not a blind
  port from C to Rust.

* "Default for QType" is NONE.  In C, it's zero bytes, which boils down
  to QTYPE_NONE.

* QTYPE__MAX is a bit of a headache in C.  It's not a valid enum value.
  We make it one only because we need to know the largest valid enum
  value, e.g. to size arrays, and the easiest way to get that value is
  adding an invalid one to the enum.  Same for all the other generated
  enums.  Could we avoid it in Rust?

* Blank lines before the values of enum QType and the members of struct
  UserDefOne contain spaces.  PATCH 16 will remove the spaces.

* Definitions are separated by two blank lines.  PATCH 16 will collapse
  them into one.

Compare to example-qapi-types.h:

    /* AUTOMATICALLY GENERATED by qapi-gen.py DO NOT MODIFY */

    /*
     * Schema-defined QAPI types
     *
     * Copyright IBM, Corp. 2011
     * Copyright (c) 2013-2018 Red Hat Inc.
     *
     * This work is licensed under the terms of the GNU LGPL, version 2.1 o=
r later.
     * See the COPYING.LIB file in the top-level directory.
     */

    #ifndef EXAMPLE_QAPI_TYPES_H
    #define EXAMPLE_QAPI_TYPES_H

    #include "qapi/qapi-builtin-types.h"

    typedef struct UserDefOne UserDefOne;

    typedef struct UserDefOneList UserDefOneList;

    typedef struct q_obj_my_command_arg q_obj_my_command_arg;

    struct UserDefOne {
        int64_t integer;
        char *string;
        bool has_flag;
        bool flag;
    };

    void qapi_free_UserDefOne(UserDefOne *obj);
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(UserDefOne, qapi_free_UserDefOne)

    struct UserDefOneList {
        UserDefOneList *next;
        UserDefOne *value;
    };

    void qapi_free_UserDefOneList(UserDefOneList *obj);
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(UserDefOneList, qapi_free_UserDefOneList)

    struct q_obj_my_command_arg {
        UserDefOneList *arg1;
    };

    #endif /* EXAMPLE_QAPI_TYPES_H */

Observations:

* C has a file comment of the form

    /*
     * One-line description of the file's purpose
     *
     * Copyright lines
     *
     * License blurb
     */

  I think Rust could use such a comment, too.

* C has built-in types like QType in qapi-builtin-types.h, generated
  only with -b.  This is a somewhat crude way to let code generated for
  multiple schemas coexist: pass -b for exactly one of them.  If we
  generated code for built-in types unconditionally into qapi-types.h,
  the C compiler would choke on duplicate definitions.  Why is this not
  a problem with Rust?

* The Rust version doesn't have deallocation boilerplate.  Deallocation
  just works there, I guess.

* The Rust version doesn't have the List type.  Lists just work there, I
  guess.

* The Rust version doesn't have the implicit type q_obj_my_command_arg,
  which is the arguments of my-command as a struct type.  C needs it for
  marshaling / unmarshaling with visitors.  Rust doesn't, because we use
  serde.  Correct?


