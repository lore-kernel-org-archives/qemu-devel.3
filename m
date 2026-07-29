Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F5C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpA44-0000pC-UM; Wed, 29 Jul 2026 15:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wpA43-0000p4-Iv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:35:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wpA41-0007ql-Aj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:35:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc891373e0so16074465ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785353736; cv=none;
 d=google.com; s=arc-20260327;
 b=iwiWxR8esnzNYm/hrPALbT/4oAPwyJww5UUb904H0rmhyRf/ByICTcy/FWq1Q2A98F
 AQ8vY6a5sVxtHWbM3sX3L4thEz68PQBMwpo+btDnrchJ5MIEL2MbT9IRtSyvBjSdd5yp
 b51S6TpbWF0ChdISK6QOvQPyqpeyV+DSIDaxT337YdPkQtyzRuTG47hf30gQeVTpKB+K
 sl18XR+G05ZGrwpgAf9u5CDyjlNY4l3ZH0kWX8FOO5BFSWqgAjLv8RZ8PBQWOiaikh3R
 lmdtOOScYk+tiLz5P2zjftTwjd+GA6/qa9SAUagRWrwW+XULpEOjn6DT3j2pBUadQVjM
 CfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3dDQP8D6JB90o7idQzeQxNaiOZNCP2cx4N87xRVz2dk=;
 fh=4SjtnPNCiaaaeFhaON8mG3x72oBiAheHsDAZtPcqOYc=;
 b=BEZ/PPdfD/KR5CJ+rUxovEQxk+2VZeW373pvm5jPrA+RMSt1B1QNnsh8eib2P1VEQd
 iWMO5rW35RER6+Qw+4hlH7svgQlYwIieDkUCKjF/WNhcQcX2vI90X9NyVBVpAxiaqVSP
 qrXJQ1ERcB5pKeVX7aaEBYwrBX3YXPzEkM64g20QibxA2s2XcW0CwfWbuHPXRLaT+iDk
 17J8WycS7TZaIbSCC5COE8k51fOz/++9Kmb3SjzgOwO9gtFUXvWb/0OVZSYQj9wD+AKD
 ed3SNe3yx7aqC7RDAfftLUZ22oisnfFvfSrQhZ5ZKT1uJ43McLJhHiyAFqp4EhvmYrS2
 7AzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785353736; x=1785958536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3dDQP8D6JB90o7idQzeQxNaiOZNCP2cx4N87xRVz2dk=;
 b=aVI4lxgZFyHizhCf7qHYwOsjMkGRrk5xltOj43t9kgg6w7JFpO1ikYas9SzYhrklN/
 GVKrNDAXitz4Tg255Z+l/6PJqUeVoJKRfxzu4xDJZNbp9AS1iNKgxAbPBHLLw64SKgHJ
 vl6j2mbSk0jF0a1CWEhOl+BQeZ28yhRQwPJP/CI/BmpenNLpCbMvVNEzNmcy8Cj20BPv
 0t5NaeyebByxfqXzHexTdZfbBCPci8YUlkbJwnjKknsKe/ZREjOY0/cPv69f7jPvUw4H
 wlC/cFjAoRdlCMSTpLTNPn6yibrXd6FB26XV4bhIF3Kiy+alfQAwXjks9gFj46icFRZJ
 1tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353736; x=1785958536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3dDQP8D6JB90o7idQzeQxNaiOZNCP2cx4N87xRVz2dk=;
 b=dfsUJBehkWItDbKDHzJCMO0OQWorv0h49ax/tK67oDjcbDoepR5wH5lXYs6/em9jIT
 e5AusAek2bM1mXpBbuwsP7uw4YSlbE4Qvi9NJAL0kWDjeSlAMkv+g2imOOFYLugcXsYm
 6WhUnBAN/jCOko9+XQRMTbua9OmPh4w1+fwxE8exRZWncdj8mFEvm3vqFAwExLVFg7R8
 uHLtg2/ZY1O3k6hxKa6xDWlL2QJJh3jaGemtW0CxGnLmnCEl2OqfyQDWhBndji0LkJXR
 my0E89Zb15UXKoPKPRCoyH8OAlyaxRy9phD2ZaBF8e38rKZjpv95z4bCMQq0B67V/ecG
 fhsQ==
X-Gm-Message-State: AOJu0YzYyaUQxiHgvvJJxLCms95YfdQxh7JecltWEAcJmvRv1JO1UGuT
 KMENCFq8OrHVJP8kA273D1DixZhG+wetijDcIUpMq0PNYkl+Wdwn86sc9T5o9YJo2eObqH/FQKn
 FiapcV0j0kM5JksDyUyblnMZw8dxAIss=
X-Gm-Gg: AR+sD12C9y5ie/sxCGORYQMWR27SG2ywHZjzTPVfxXjLRV9X6BMCxQJKa6Mp+WUv+qb
 cF23u6DoME+ZDhrK1uuZyf57IV2v539Qerxn/dy/cxBfnVWZqi+ivppNqX0s/NXsvylQldCvkH7
 RRzfJg1QlOE9v2BaCPOHuRaCizXIoUMSMghyxX9rjPNB/pC5LTs7NfoyDdFSqPsiG3+gocRDxCw
 +cATnt5WW4XRhIcw8VyjWi3YZm6ZFmda/fP9dW5yHPlqaqox1Ijt2J0NW0pmhGLzMANPB/XW1m9
 TmkuSGNcXIGiAKXa4Bm3nNmnjF7sWxttUEB84EgdmWDx+JNQzHgygZ+0TlpTJAIDqnFXpbumtZc
 DTWIvqLxBMNU=
X-Received: by 2002:a17:902:c948:b0:2cf:9f62:1dcd with SMTP id
 d9443c01a7336-2d033d6106cmr1991025ad.32.1785353735617; Wed, 29 Jul 2026
 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <878q6us19k.fsf@pond.sub.org>
 <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
 <878q6uq84y.fsf@pond.sub.org>
In-Reply-To: <878q6uq84y.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 23:35:23 +0400
X-Gm-Features: AUfX_mwKUzu__csbSlg3LUfbXWYn--WdMzc-p4je-JSI8iplXWF-33CYyRfbHIQ
Message-ID: <CAJ+F1C+buFmV5X+ZJeR8aX9JhXiRPEdcTHaPA58kvJDD9UYm-A@mail.gmail.com>
Subject: Re: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62f.google.com
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

On Wed, Jul 29, 2026 at 4:43=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Wed, Jul 29, 2026 at 11:29=E2=80=AFAM Markus Armbruster via qemu
> > development <qemu-devel@nongnu.org> wrote:
> >> Before I dive into individual patches, let me try to work out what the
> >> series does as a whole.
> >>
> >> > This series adds:
> >> >   - A new QAPITypeInfo struct that pairs a property with its QAPI sc=
hema
> >> >     type name, enum lookup table, and list-element type.
> >>
> >> Peeking at the code, I see that ObjectProperty gains a member @qapi_ty=
pe
> >> pointing to its QAPITypeInfo.
> >>
> >> It is null when the ObjectProperty doesn't have a QAPI type.
> >>
> >> If it's non-null, then ObjectProperty members @name and @type are
> >> redundant with qapi_type.name and .type.
> >>
> >> Correct?
> >
> > Almost. @name is the property name (e.g. "policy"), not the type name.
> > But @type becomes redundant with qapi_type->name when qapi_type is set
> > (object_property_add_qapi derive prop->type from qapi_type->name).
> >
> > Also @type carries additional information for some property kinds that
> > @qapi_type doesn't cover: child<T> and link<T> embed the linked
> > object's QOM type name in the type string. qapi_type can't represent
> > that atm.
>
> Can child and link properties have non-null @qapi_type?

No. Both object_property_add_child() and object_property_add_link()
use the base object_property_add(), not the _qapi variants, so
qapi_type stays NULL.

On the qdev side, qdev_prop_link.qapi_type is &str_type_info, but
create_link_property() calls object_class_property_add_link() which
bypasses that, so the ObjectProperty ends up with qapi_type =3D=3D NULL
and type =3D "link<T>".

>
> >> Would "every ObjectProperty has a QAPI type" be a reasonable goal for
> >> the future?
> >
> > Maybe? we would need to address the child<>/link<> gap. At least we
> > can make raw object_property_add() deprecated/static in object.c after
> > this series
>
> Interesting!
>
> >> >   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInf=
o
> >> >     instance for every schema-defined type, including the mapping
> >> >     between internal C names and the schema name visible to clients.
> >>
> >> Peeking at the code, I find:
> >>
> >> * The type
> >>
> >>     typedef struct QAPITypeInfo {
> >>         const char *name;
> >>         const char *schema_name;
> >>         const QEnumLookup *lookup;
> >>         const struct QAPITypeInfo *list;
> >>     } QAPITypeInfo;
> >>
> >> * A T_type_info for each QAPI type T, including built-in types.
> >>
> >> * T_type_info member @name is T's QAPI name, i.e. "T".
> >>
> >> * T_type_info member @schema_name is T's masked name used in
> >>   query-qmp-schema output, null when T is elided there.
> >>
> >> * T_type_info member @list points to TList_type_info when that exists,
> >>   else it's null.
> >>
> >> * T_type_info member @lookup points to T_lookup when T is an enum, els=
e
> >>   it's null.
> >>
> >> Correct?
> >
> > Yes
> >
> >> >   - A "qapi-type" field in the ObjectPropertyInfo and
> >> >     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
> >> >     when present giving clients a cross-reference into query-qmp-sch=
ema
> >> >     output.
> >>
> >> To be precise: when ObjectPropertyInfo member @type is "T", then membe=
r
> >> @qapi-type is T_type_info.qapi-type.  Correct?
> >
> > @qapi-type is T_type_info.schema_name, the masked name
>
> Right.
>
> >> If .qapi-type is non-null, you can use it to look up precise type
> >> information via QAPI introspection, i.e. query-qmp-schema.
> >>
> >> Correct?
> >
> > Yes
> >
> >>
> >> Possible problem: query-qmp-schema covers only types that are actually
> >> used in QMP.  But the above technique additionally wants QOM property
> >> types.  I haven't checked what your series does about this, if anythin=
g.
> >
> > Most types used as QOM properties are also used by QMP commands. But
> > it's true that types not used by QMP get schame_name =3D NULL atm.
>
> So the problem is real, and to reap the full benefit of your work, we
> need to solve it.  Not necessarily right away.
>
> > Should we have a new pragma? Even if we have conditions, we may end up
> > with unused types in the build, but that shouldn't be a big issue. Or
> > we would need a more complicated several step build.
>
> No need not worry about the how right now.
>
> >> ObjectPropertyInfo is only used with QMP command handlers.  It is
> >> computed from ObjectProperty.
> >>
> >> >   - Conversion of all PropertyInfo definitions from the old
> >> >     .type/.enum_table strings to the new .qapi_type pointer.
> >>
> >> The above is QOM, this is qdev.
> >>
> >> Like ObjectProperty, PropertyInfo gains a member @qapi_type pointing t=
o
> >> its QAPITypeInfo.  Howver, this one cannot be null.
> >>
> >> PropertyInfo members @type and @enum_table are dropped, because they a=
re
> >> redundant with qapi_type.type and .lookup.
> >>
> >> Correct?
> >
> > Almost. Every PropertyInfo has a non-NULL qapi_type, except the array
> > ones (created with DEFINE_PROP_ARRAY_INFO) which leave .qapi_type NULL
> > and derive it at registration time from
> > .element_info->qapi_type->list.
>
> Can you point me to the code setting it?  Would save me the digging.

qdev_prop_qapi_type(), when info->qapi_type is NULL (the array
PropertyInfos created by DEFINE_PROP_ARRAY_INFO), it follows
element_info->qapi_type->list.

For example, qdev_prop_uint32_list has .element_info =3D
&qdev_prop_uint32, so it resolves uint32_type_info.list ->
uint32List_type_info.

Not perfect, we can improve later. hopefully

>
> >                                 Either way, the resulting
> > ObjectProperty always ends up with a non-NULL qapi_type.
> >
> > PropertyInfo members @type and @enum_table are dropped, because they
> > are redundant with qapi_type->name and ->lookup.
>
> Yes.
>
> >> >   - Replacement of the generic qdev_prop_array with typed per-elemen=
t
> >> >     array PropertyInfos, removing the arrayinfo/arrayfieldsize
> >> >     indirection from struct Property.
> >>
> >> Before the series, an array-valued Property's @info member is
> >> @qdev_prop_array.  @qdev_prop_array provides no information on the arr=
ay
> >> elements.  Instead, Property member @arrayinfo points to the
> >> PropertyInfo for the elements, and @arrayfieldsize is the size of an
> >> element.
> >>
> >> Your series makes PropertyInfo array-capable: new members @element_inf=
o
> >> and @element_size are the elements' PropertyInfo and size.  It then ad=
ds
> >> a proper PropertyInfo for each such property, and drops
> >> @qdev_prop_array.
> >>
> >> Correct?
> >
> > Yes
> >
> >>
> >> This could perhaps be spun out and merged separately to reduce the siz=
e
> >> of future respins.
> >
> > I can split it out if it helps
>
> Splitting off self-contained parts of a big series can help if they can
> be merged quicker than the entire series.  We'll see.
>
> >> Not mentioned:
> >>
> >>     - New QOM property creation functions for creating properties of
> >>       QAPI type.  These take a QAPITypeInfo.
> >>
> >>     - Convert some properties to use them.
> >>
> >> >   - Removal of the deprecated PropertyInfo.type and .enum_table fiel=
ds,
> >> >     and of the old object_property_add_enum/add_tm APIs.
> >> >
> >> > Along the way, a few pre-existing type mismatches in property
> >> > definitions are fixed, the "struct tm" RTC property is replaced with=
 a
> >> > proper QAPI StructTm type etc. Introducing more specific types or a
> >> > "typedef" to QAPI could help provide better associated type informat=
ions
> >> > than plain "str" in many cases, for example.
> >>
> >> Examples?
> >>
> >
> > Properties using str_type_info that carry structured values with their
> > own validation: macaddr ("52:54:00:12:34:56"), PCI addresses
> > ("04:00.0"), netdev names, chardev names, drive names, UUID strings. A
> > QAPI "typedef" (or newtype) for e.g. MacAddr, PciDevAddr, UUID could
> > let tools know these aren't arbitrary strings (see "hw/nvdimm: convert
> > UUID property to QAPI-aware registration" patch).
>
> Two separate kinds:
>
> 1. Strings we need to parse: PCI addresses, MAC addresses, UUIDs, ...
>
>    Parsing maps the string to something else, usually some object that
>    isn't a string.
>
>    We avoid string parsing in QAPI/QMP whenever practical.  You quoted
>    several examples where we don't.
>
> 2. IDs of things we need to resolve
>
>    Resolving maps the string to the object it names.
>
> In both cases, we map strings to objects.
>
> QAPI is unaware of this.  It simply uses strings in generated C.
>
> What if QAPI was aware?  If the schema specified the object type, and
> how to map from string to it?  This is a step beyond a mere typedef.
> The mapping would move from handwritten code to generated code.
> Generated interfaces would use the object types instead of strings.
>
> Not now, of course.
>
> >> > Comments welcome!
> >> >
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
>
>

