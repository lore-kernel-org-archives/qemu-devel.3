Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9910C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp19B-0004cr-T0; Wed, 29 Jul 2026 06:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wp19A-0004cj-IA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:04:20 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wp198-00042A-MN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:04:20 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8111c0c7561so9620967b3.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319457; cv=none;
 d=google.com; s=arc-20260327;
 b=IdwgRaWxYMgYApbDFvSPIAYbeAMAruTzWG5FpiFms84geE6j5V17ouAc3b2t5Qose/
 VvMCRSfzKFcr19idBQAuI2vtN6TnV4JcTVpQX0lw7Yxm55UyAKesMFTUUV520IJQKteo
 aWakM5cHmpz/5UlTRRp1U7c4KDoCAwhvXyoYQv2p7ho0wL3ZPYPDfVH9/Z5UuJakVLtN
 lxOeM4jdjPEJv4vMDviRW60cwOLZbR8rNfGBoe0Ru7okGVeN3Ff6ZBe18pf/dlgKpj+Y
 qcmZJ6PWdbfN5IEJuaW4GUWAOvIaMLn+artREu7lRHYpPNxcNZpPCpf592jbWVQxwuxk
 UEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mONJcJM3vtdz8G/OIOMkcMJK5xW3cgfZk3miNlXqX0Y=;
 fh=4SjtnPNCiaaaeFhaON8mG3x72oBiAheHsDAZtPcqOYc=;
 b=LcT93gWRUPf/KodU9KZDzpWlR18ZomTGn94/jAawGjoq1j93z0yEMs4HA8C+Xh6x5P
 3WmslwZBfxTgDcXjvIN7pV90FipHyvYXDhdhmYSZfdWbo1ApE08a1mJfHVBqUoLM7qi+
 5yqkXFoRyp8Oapv6JotCkR7LsyawibZBR4dKv7N5X0dGCRjyDFB/UGqNVLv2o/DVVX1l
 5eAXZr9xLh829RNU9TC5fSUxvceQMLuBcnMtM2v42UwtVQDUIVTwCrxjRpEo0rlF/jR3
 g+Z/nGsh5mzCueRs2E1XUmftFRWvtrLDk97H4YXkRHUTNZalIW2q+UEzhmjLWXWVMSc3
 qGVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785319457; x=1785924257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mONJcJM3vtdz8G/OIOMkcMJK5xW3cgfZk3miNlXqX0Y=;
 b=fHJy5N+3Fo3SM+fgwvUetJn4GzGSA0ULttajZ5cZ8RZldHOtSRFX1SORSywQ1yPeVq
 nyO0J3StwO7YxQrtbZ74LdGgtgsthJ2flhdtRe2KAhVqMfibrKGr3KIHZ1nhaGzn5mgy
 Y1a3GsOVK2qgbmxQOMRLn9woD34v/TK2l6ATHU+upyLK7vZPP4c/kgKowerX02lVyJ/d
 MwGoDZuANOOzrE6JpbGYRbsegVd2WWLNbohotbVuENufRorwSg7J50lU/K8Y72kc1nKd
 TB3FlSaN1MbOa24OLLevxbthD4dawFZiD9mk52jX01pJ0JuLupO9vSE1cTu4Y/2NS4RS
 WTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785319457; x=1785924257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mONJcJM3vtdz8G/OIOMkcMJK5xW3cgfZk3miNlXqX0Y=;
 b=mb7KfZ2MMmZdLqVs975TaZK9td1T273AOXcay6K09W3HGIKeYv/Wo/2rUugY9YxTsw
 +s2YOn5fKYKy17Xtx3xzBQNaxhgBm52dvNl011zhcA52ayVk203IH55MvtIvg0/wtrf8
 UXqC/0ZLgRLiVk/mAA9yZgZFkyz3NdNJu6eMuiDVZ06S6LUVTTVooJI9VO0Xz0ASMGet
 rGuxHm4J7NJDYsPxV+C5/PD3U43ykJgWJNbMSQl7yY7sJdBKOUzwvNgE44/LNsjyvacn
 HuZFKbUhAKd/2vVamGceZpELS/aUi/nNT5RcsxGrKJGA2ElOvtsAxRUh6VBE7BqNH+cx
 gTEA==
X-Gm-Message-State: AOJu0YzJNON13pw27F0n2IG/qNYSO6Mv8UoYa27P9+HsIjT/a/dOKFmD
 U5bvckrmT5gLKCqKJR1PP0c//Qt9Xnel64J1CtZLmUewd1pvauyHHkTT9IbEO6OdW7QJNXQFD4v
 7HfHKnXltW1Kq3Om9BhWahE63PAGfAUQ=
X-Gm-Gg: AR+sD124cZSVLxs42lEQFUC+3cZ2ZqGG1nJYV6Ih7NFmHVejxaTDjSjQ6AzWiYT1yoJ
 Z95NkLMXCEN7hT10kBCpot8rFg6rMKaY5Xl52W1NwOiHCVS9AbNjz6OAEb0Wy4ueJTYFTREE8hu
 QT6zItVpjpw14apO1cYPhBfIAagIA8EXV3MOKWB4eumf0xL5yKr5iqwzObLH0UqXkwHcMQbx+Hp
 3wX5oKSu04jmZjTERWMEOOqYdJRKQViqO6M209Moke3H3gykjZPbRJp0MPYSN7drrIH4/2yLWJc
 9QWEwK0CKEd2EYS4vZYlhGVxFIspbn3Ekrqkkns/hQyo6NvjmTBsCrDEZ7QSVzBmwJukPsbMd+q
 p2wFjLp+Px24=
X-Received: by 2002:a05:690c:6d07:b0:81d:bc5:4600 with SMTP id
 00721157ae682-81f991874cfmr31008107b3.6.1785319456857; Wed, 29 Jul 2026
 03:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <878q6us19k.fsf@pond.sub.org>
In-Reply-To: <878q6us19k.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 14:04:03 +0400
X-Gm-Features: AUfX_mzW1dXnFjf-Ply1s5_JDO7e3AokRdQ8ZAi6SPajXxS5d2cG49B0pWuB3O0
Message-ID: <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
Subject: Re: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Wed, Jul 29, 2026 at 11:29=E2=80=AFAM Markus Armbruster via qemu
development <qemu-devel@nongnu.org> wrote:
> Before I dive into individual patches, let me try to work out what the
> series does as a whole.
>
> > This series adds:
> >   - A new QAPITypeInfo struct that pairs a property with its QAPI schem=
a
> >     type name, enum lookup table, and list-element type.
>
> Peeking at the code, I see that ObjectProperty gains a member @qapi_type
> pointing to its QAPITypeInfo.
>
> It is null when the ObjectProperty doesn't have a QAPI type.
>
> If it's non-null, then ObjectProperty members @name and @type are
> redundant with qapi_type.name and .type.
>
> Correct?

Almost. @name is the property name (e.g. "policy"), not the type name.
But @type becomes redundant with qapi_type->name when qapi_type is set
(object_property_add_qapi derive prop->type from qapi_type->name).

Also @type carries additional information for some property kinds that
@qapi_type doesn't cover: child<T> and link<T> embed the linked
object's QOM type name in the type string. qapi_type can't represent
that atm.

> Would "every ObjectProperty has a QAPI type" be a reasonable goal for
> the future?

Maybe? we would need to address the child<>/link<> gap. At least we
can make raw object_property_add() deprecated/static in object.c after
this series

>
> >
> >   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
> >     instance for every schema-defined type, including the mapping
> >     between internal C names and the schema name visible to clients.
>
> Peeking at the code, I find:
>
> * The type
>
>     typedef struct QAPITypeInfo {
>         const char *name;
>         const char *schema_name;
>         const QEnumLookup *lookup;
>         const struct QAPITypeInfo *list;
>     } QAPITypeInfo;
>
> * A T_type_info for each QAPI type T, including built-in types.
>
> * T_type_info member @name is T's QAPI name, i.e. "T".
>
> * T_type_info member @schema_name is T's masked name used in
>   query-qmp-schema output, null when T is elided there.
>
> * T_type_info member @list points to TList_type_info when that exists,
>   else it's null.
>
> * T_type_info member @lookup points to T_lookup when T is an enum, else
>   it's null.
>
> Correct?

Yes

> >   - A "qapi-type" field in the ObjectPropertyInfo and
> >     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
> >     when present giving clients a cross-reference into query-qmp-schema
> >     output.
>
> To be precise: when ObjectPropertyInfo member @type is "T", then member
> @qapi-type is T_type_info.qapi-type.  Correct?

@qapi-type is T_type_info.schema_name, the masked name

> If .qapi-type is non-null, you can use it to look up precise type
> information via QAPI introspection, i.e. query-qmp-schema.
>
> Correct?

Yes

>
> Possible problem: query-qmp-schema covers only types that are actually
> used in QMP.  But the above technique additionally wants QOM property
> types.  I haven't checked what your series does about this, if anything.

Most types used as QOM properties are also used by QMP commands. But
it's true that types not used by QMP get schame_name =3D NULL atm.

Should we have a new pragma? Even if we have conditions, we may end up
with unused types in the build, but that shouldn't be a big issue. Or
we would need a more complicated several step build.

> ObjectPropertyInfo is only used with QMP command handlers.  It is
> computed from ObjectProperty.
>
> >   - Conversion of all PropertyInfo definitions from the old
> >     .type/.enum_table strings to the new .qapi_type pointer.
>
> The above is QOM, this is qdev.
>
> Like ObjectProperty, PropertyInfo gains a member @qapi_type pointing to
> its QAPITypeInfo.  Howver, this one cannot be null.
>
> PropertyInfo members @type and @enum_table are dropped, because they are
> redundant with qapi_type.type and .lookup.
>
> Correct?

Almost. Every PropertyInfo has a non-NULL qapi_type, except the array
ones (created with DEFINE_PROP_ARRAY_INFO) which leave .qapi_type NULL
and derive it at registration time from
.element_info->qapi_type->list. Either way, the resulting
ObjectProperty always ends up with a non-NULL qapi_type.

PropertyInfo members @type and @enum_table are dropped, because they
are redundant with qapi_type->name and ->lookup.

> >   - Replacement of the generic qdev_prop_array with typed per-element
> >     array PropertyInfos, removing the arrayinfo/arrayfieldsize
> >     indirection from struct Property.
>
> Before the series, an array-valued Property's @info member is
> @qdev_prop_array.  @qdev_prop_array provides no information on the array
> elements.  Instead, Property member @arrayinfo points to the
> PropertyInfo for the elements, and @arrayfieldsize is the size of an
> element.
>
> Your series makes PropertyInfo array-capable: new members @element_info
> and @element_size are the elements' PropertyInfo and size.  It then adds
> a proper PropertyInfo for each such property, and drops
> @qdev_prop_array.
>
> Correct?

Yes

>
> This could perhaps be spun out and merged separately to reduce the size
> of future respins.

I can split it out if it helps

>
> Not mentioned:
>
>     - New QOM property creation functions for creating properties of
>       QAPI type.  These take a QAPITypeInfo.
>
>     - Convert some properties to use them.
>
> >   - Removal of the deprecated PropertyInfo.type and .enum_table fields,
> >     and of the old object_property_add_enum/add_tm APIs.
> >
> > Along the way, a few pre-existing type mismatches in property
> > definitions are fixed, the "struct tm" RTC property is replaced with a
> > proper QAPI StructTm type etc. Introducing more specific types or a
> > "typedef" to QAPI could help provide better associated type information=
s
> > than plain "str" in many cases, for example.
>
> Examples?
>

Properties using str_type_info that carry structured values with their
own validation: macaddr ("52:54:00:12:34:56"), PCI addresses
("04:00.0"), netdev names, chardev names, drive names, UUID strings. A
QAPI "typedef" (or newtype) for e.g. MacAddr, PciDevAddr, UUID could
let tools know these aren't arbitrary strings (see "hw/nvdimm: convert
UUID property to QAPI-aware registration" patch).


> > Comments welcome!
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

