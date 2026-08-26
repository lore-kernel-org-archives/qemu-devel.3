Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB511C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzB42-0000bO-DY; Wed, 26 Aug 2026 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzB40-0000ax-7F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzB3x-00065e-7a
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787740855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap0IST+5z0KnkhE8vfYeDjKOXHiPmeFHkDrNKdVEL7s=;
 b=fvucHhhJcAqnzVvBS19OOQKj+05g4fjARnKHfomJ2UC6sipoP/vgoSCDeUUpI6N6uEQXGi
 aKI7hjhxlcN9bs6GYmvsLrPdig+1hquBl1RgHlGOYpA3rv9AheuvelvLnyPztSQAx9wMt9
 WGczJWOG6IrJtcP+ZBJDw189QKs1EdY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-UZVDg3m2M_qpNWqCxJZsIQ-1; Wed, 26 Aug 2026 06:40:54 -0400
X-MC-Unique: UZVDg3m2M_qpNWqCxJZsIQ-1
X-Mimecast-MFC-AGG-ID: UZVDg3m2M_qpNWqCxJZsIQ_1787740853
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb92868263so641601a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787740853; cv=none;
 d=google.com; s=arc-20260327;
 b=lQbeklb8kf9lgEIUNUMaS6/bKLZXkwnnzXuL6wT9R2fl/jNlENMFTi5j4c24FD6DSl
 2NT5SBcrrxqE+nbLRX1bd3tqJHTQMxR8826y+pJNmbNDDf8pMdXJVyv6NJFRIj7NXuQd
 nXW+k3vmZLTEAQB0k88/KlcOTxmdKi+T2rgVPzVwUq1nusLG4R3dbRSQLhS19zf6+Qhl
 kaw97rr7p9cjBg2rR0fc42qpPuX3ds1j2lUkd+dqUVWI+L3IfXG/sXonxNJWu8AAFWfy
 fXVKMQPYI1iCpzScXRUwrdY1YytR+dDz/mZouZPZrvpK5vNRqtYcz9R2N9xuqoTikR8I
 ijhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ap0IST+5z0KnkhE8vfYeDjKOXHiPmeFHkDrNKdVEL7s=;
 fh=B5RgptwxciZoZ+8Bx34iwJAsddh0sHU+AHSWr/a2HRQ=;
 b=Wo8bXnESXtdF7sR1u6JFeyUxOOEPewPzt7VTu3dtu+F+kwbepa+ffOQnWy94MacDlS
 Q1YKZkQhStOhRHsZukomfXEc4YhFPprBDFafUcIyWelyriwTIxYmocywJYA3AEUysxN+
 4Tx95rxYk8pOPSPwlrCbAzCvAcpLfeEjnzWvCpkPf3dnTHF51qKTDcbq3daiMlS3+dOQ
 620lN3AAmic6oYozOnbwmvWcTpF59R+KTcMub5bNTFBu6f29+bi9sGDHDD3Im2uRMa//
 J8NJr3JfjFl92PdPE3bKmaUi0RKI4FvbJcwVB4asWNMfy2HZZTXwS+tXw4IIBTnxSfJs
 oWBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787740853; x=1788345653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ap0IST+5z0KnkhE8vfYeDjKOXHiPmeFHkDrNKdVEL7s=;
 b=kPs/ae/i/H+NhAzUmWBISipXuxt2hLME9561ZaYl1BpUFVwpw6ZPVBY5vtgx2NiyP0
 5THcZyDvyKdxWpRUlmTszlGM8sPgtEOlzOKsOJvKqeCf6AQo4+1kkKbtJ9pQzrPd2Wur
 m0/BJk9VHHUnUgNl/QzH1c6YP7468gee21sFKDYxHpHPZGoscMQmy0/tx2+9l2gv7wrA
 vWZwYmbkclMRSUKJ3LB7dvhBusUprtSuCroGe7LPFn0KWJA5ywFve0M2oXCU3h5tDTwr
 9pnH1D0dOo+1Wnczswqhl0kXIZ8GBSV9UyX35gpBIw239ONPMt0feNmdDQ1A/LUOVZ7/
 IL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787740853; x=1788345653;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ap0IST+5z0KnkhE8vfYeDjKOXHiPmeFHkDrNKdVEL7s=;
 b=nl7yrcWtSwRkHkXTopEc7HCR8gWM1rCv7aKVieqk4THaUjNHGyhXIRPioh+5AO0gNp
 cRE6YulBWxUs0BeT79kNs7nGO9aaCTZBQ6agMKnUCxTQW+XBwG82sFfk5yWZ2u8JztPw
 tCTsCQR4R74D8PTvGr1sYgXSbRIUcYabv7rqOgsIul2F3W9G5114kIDQkaN4O6OiZoYU
 tgZPGRYGeVupyVmviQw7PQ/2hwicKSef71/T1Lu5eH7cm+R3qwq1ynRT3uN2jJXPVGxM
 dGyacdXZ9T21StcjoTd4JfpaTYkIZTZKuVIc7k4bLwVDLvH6Agr0ogsNg+KgFGF2ORnv
 sP5Q==
X-Gm-Message-State: AFuF++nuMwyf/9uJKH1TcHTKYUEdsQbCiCFBywk6UEzoHtHYUOZoLi86
 n4X/ZBQ56cM61OOP4Eh4Yzk2Wwxd5G7Jbge+/4OvV95jBUV6KW5AY0dJFbnSQ9MbYKNZLFtnBqa
 FD7jTVa0vJQh6ZDXnOYWR8m/yKXhi9GErvVNK6LTOgfAYOlE6Z8QkPd8K5GAtAHwyXvlmgjPz4A
 ZTWzx7D1LpSDisIdnOiSQnyDTe2I917Y8=
X-Gm-Gg: AR+sD12+fICiV5LJFicATC7f7zNmucI7x1txazw3Sbij4ZcVRxZK6vrzLiHpQI8/WtV
 7GB3GdIxSNFFn0iY7uFt660FsDe++NN8f9PxOuQbJkdTuq/OPVfNahT2sGb8Xkz4nSYTNMN+tYC
 sqcX8rNq9GlFGiqaoWgMQoyQYDsDtBHtWWzcdTL28xYFcxTNRJ+siX/25rOg+doVpT8j3YFfyz8
 mLbYFCClkoMcwOvdNCuwp1VUBzjiIK6k2KoEH1f6EVIBZfTkpGb16/pgquL+HtROt915XLmsHoW
 vA==
X-Received: by 2002:a05:6a20:3d8d:b0:3cd:9f0b:f7a2 with SMTP id
 adf61e73a8af0-3cf84444964mr10209759637.11.1787740852832; 
 Wed, 26 Aug 2026 03:40:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8d:b0:3cd:9f0b:f7a2 with SMTP id
 adf61e73a8af0-3cf84444964mr10209679637.11.1787740852355; Wed, 26 Aug 2026
 03:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <ff0c0539-c24f-4c5f-91bb-38168d62a36b@nutanix.com>
In-Reply-To: <ff0c0539-c24f-4c5f-91bb-38168d62a36b@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 14:40:40 +0400
X-Gm-Features: AcwNN1Ur7BuwwMJP2Xn5268o30Dj1BwBI6PH2ch68Shic1Jfqtx4ZsBJia_e1kk
Message-ID: <CAMxuvayg=mv4q3bYn72J5RZ3YpJQRsj2=_Gh+NkO9kMOJW7Vpg@mail.gmail.com>
Subject: Re: [PATCH v3 00/74] qom/qdev: associate properties with QAPI schema
 types
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Tue, Aug 25, 2026 at 7:33=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 18/08/2026 12:10, Marc-Andr=C3=A9 Lureau wrote:
>
> > Hi,
> >
> > This series connects QOM and qdev properties to the QAPI type system, s=
o
> > that management tools can discover the QAPI schema type of each object
> > property.
> >
> > Today, QOM properties carry a free-form "type" string ("bool", "uint32"=
,
> > "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
> > query-qmp-schema. Management tools must maintain ad-hoc mappings or rel=
y
> > on naming conventions to figure out how to interpret property values.
> >
> > This series adds:
> >    - A new QAPITypeInfo struct that pairs a property with its QAPI sche=
ma
> >      type name, enum lookup table, and list-element type.
> >
> >    - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
> >      instance for every schema-defined type, including the mapping
> >      between internal C names and the schema name visible to clients.
> >
> >    - A "qapi-type" field in the ObjectPropertyInfo and
> >      ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
> >      when present giving clients a cross-reference into query-qmp-schem=
a
> >      output.
> >
> >    - Conversion of all PropertyInfo definitions from the old
> >      .type/.enum_table strings to the new .qapi_type pointer.
> >
> >    - Replacement of the generic qdev_prop_array with typed per-element
> >      array PropertyInfos, removing the arrayinfo/arrayfieldsize
> >      indirection from struct Property.
> >
> >    - Removal of the deprecated PropertyInfo.type and .enum_table fields=
,
> >      and of the old object_property_add_enum/add_tm APIs.
> >
> > Along the way, a few pre-existing type mismatches in property
> > definitions are fixed, the "struct tm" RTC property is replaced with a
> > proper QAPI StructTm type etc. Introducing more specific types or a
> > "typedef" to QAPI could help provide better associated type information=
s
> > than plain "str" in many cases, for example.
> >
> > Comments welcome!
>
> Thanks for quite a substantial piece work: there is quite a lot to pick
> through in this series which makes review tricky. If you post a new
> version, it might be worth showing an example of the before/after JSON
> to help give some context around the changes: however it feels this is

Well, the most significant change is that the query-qmp-schema grew of
about 10% to include types that are not referenced by QMP directly.

And qom-list, qom-list-get, device-list-properties, and
qom-list-properties now return an additional optional "qapi-type"
field to reference the schema types.


> going in the right direction, since it works towards the goal of
> allowing a QMP client to introspect everything it needs to know about
> the QAPI type underlying a property.
>
> I've started working through this with a few comments and reviews for
> the patches fixing up types: I wonder if the type fixups could be merged
> separately to help reduce the size of the series?

Sure, we can cherry-pick the fixes and reduce the new version.

>
> Question: is the eventual aim to deprecate the use of all the non-qapi
> object functions? Are there many instances left after this series at all?

QOM itself uses non-qapi functions, but outside of that, none should be lef=
t.

thanks

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > Changes in v3:
> > - QAPI analysis redesign (replacing the old "expose name map" from
> > introspect)
> > - all non-implicit QAPI types are now introspectable, including QOM-onl=
y
> > types
> > - QAPITypeInfo.schema_name -> masked_name
> > - exposes integer signedness and width through query-qmp-schema
> > - various extra property fixes
> > - rebase, some patch split or merge
> >
> > - Link to v2: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lo=
re.kernel.org_qemu-2Ddevel_20260616-2Dqom-2Dqapi-2Dv2-2D0-2Dcc9396b9c18c-40=
redhat.com&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3Dc23RpsaH4D2MKyD3EPJTDa=
0BAxz6tV8aUJqVSoytEiY&m=3DLGtC1Otz03Nx6wZrdIv7LRRcAEAYfhyfKJ4dtNt7PCxy3ILcs=
WudQol0qR9l2c5a&s=3DIdir-fKu3uFkuRRHZW8ipF3e84xwMMhnVWVuat0zVXs&e=3D
> >
> > Changes in v2:
> >
> > - Added kernel-doc documentation for the QAPITypeInfo struct fields.
> > - Dropped "qom: drop free-form property typename registration", it's
> >    still needed for array of links to provide useful type names.
> > - Added qdev_prop_link_list for array-of-links properties, with a
> >    create function that generates "link<TYPE>List" type names matching =
the
> >    existing "link<TYPE>" convention.
> > - qdev_prop_link now uses &str_type_info instead of "link" (the full
> >    "link<TYPE>" type name is set at property-add time)
> > - Simplified DEFINE_PROP_LINK_ARRAY to use qdev_prop_link_list, droppin=
g
> >    the now-unnecessary _arraytype parameter.
> > - rebased
> > - Link to v1: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lo=
re.kernel.org_qemu-2Ddevel_20260510-2Dqom-2Dqapi-2Dv1-2D0-2D48ba6a1a1fa5-40=
redhat.com&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3Dc23RpsaH4D2MKyD3EPJTDa=
0BAxz6tV8aUJqVSoytEiY&m=3DLGtC1Otz03Nx6wZrdIv7LRRcAEAYfhyfKJ4dtNt7PCxy3ILcs=
WudQol0qR9l2c5a&s=3D_KgQcnGFWRM8edu2HLa7HFwHHCkp2t6UyriBmPDNk8A&e=3D
> >
> > To: qemu-devel@nongnu.org
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Michael Roth <michael.roth@amd.com>
> > Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> >
> > ---
> > Marc-Andr=C3=A9 Lureau (74):
> >        qapi: add QAPITypeInfo struct definition
> >        qapi/gen: fix _module_basename for multi-dash 'what' parameters
> >        qapi: factor out QAPISchemaUsedTypes from introspect visitor
> >        qapi: register all introspectable types, not just QMP-reachable =
ones
> >        qapi: add type-infos generator
> >        meson: add qapi-type-infos-*.c/h to build
> >        qom: add qapi_type field to ObjectProperty
> >        qapi/qom: add qapi-type field to ObjectPropertyInfo
> >        qom/qmp: populate qapi-type in QMP handlers
> >        qom: add object_property_set_default_enum()
> >        qom: add object_{class_}property_add_qapi
> >        qom: add object_{class_}property_add_qapi_enum
> >        tests: update check-qom-proplist for QAPI-aware property registr=
ation
> >        qom: convert enum properties to QAPI-aware registration
> >        qom: remove old enum property registration API
> >        qom: convert struct properties to QAPI-aware registration
> >        x86: convert OnOffAuto properties to QAPI-aware registration
> >        microvm: convert OnOffAuto properties to QAPI-aware registration
> >        pc: convert OnOffAuto vmport property to QAPI-aware registration
> >        arm/virt: convert OnOffAuto acpi property to QAPI-aware registra=
tion
> >        riscv/virt: convert OnOffAuto properties to QAPI-aware registrat=
ion
> >        loongarch/virt: convert OnOffAuto properties to QAPI-aware regis=
tration
> >        hostmem-file: convert OnOffAuto rom property to QAPI-aware regis=
tration
> >        sev: convert OnOffAuto legacy-vm-type property to QAPI-aware reg=
istration
> >        whpx: convert OnOffAuto hyperv property to QAPI-aware registrati=
on
> >        whpx: convert OnOffAuto arch properties to QAPI-aware registrati=
on
> >        accel/kvm: convert OnOffSplit property to QAPI-aware registratio=
n
> >        whpx: convert OnOffSplit property to QAPI-aware registration
> >        ppc/spapr-caps: convert to QAPI-aware property registration
> >        system/memory: fix "priority" property typename
> >        backends/hostmem: fix property typenames
> >        backends/hostmem-file: fix "align" property typename
> >        accel/tcg: fix "tb-size" property typename
> >        block/throttle-groups: fix throttle properties typename
> >        event-loop-base: fix property typenames
> >        iothread: fix poll properties typename
> >        util/thread-context: fix property typenames
> >        target/i386: fix CPUID version properties typename
> >        ppc/pnv: fix phb-id and chip-id properties typename
> >        backends/hostmem-memfd: fix "hugetlbsize" property typename
> >        hw/acpi: fix "node" properties typename
> >        net/colo-compare: fix compare_timeout setter visitor type
> >        net/colo-compare: fix max_queue_size setter visitor type
> >        hw/misc/xlnx-versal-trng: add missing getter for fips-fault-even=
ts
> >        qom: convert scalar properties to QAPI-aware registration
> >        i386/cpu: convert strList property to QAPI-aware registration
> >        accel/hvf: convert OnOffSplit property to QAPI-aware registratio=
n
> >        i386/x86: convert SgxEPCList property to QAPI-aware registration
> >        virtio-balloon: convert guest-stats property to QAPI type
> >        qom: replace object_property_add_tm with StructTm QAPI type
> >        hw/nvdimm: convert UUID property to QAPI-aware registration
> >        hw/s390-virtio-ccw: convert loadparm property to QAPI-aware regi=
stration
> >        hw/ppc/spapr_drc: convert fdt property to QAPI-aware registratio=
n
> >        spdm-socket: convert SpdmTransportType to QAPI enum
> >        hw/gpio/pca955x: use QAPI enums for led and pin properties
> >        include: add QEMU_REPEAT helper macro
> >        hw/gpio/pca955x: convert pin/led property to QAPI-aware enum
> >        hw/pci: change the busnr type to uint8
> >        qdev: add qapi_type field to PropertyInfo with fallback registra=
tion
> >        qdev: convert core PropertyInfo definitions to use qapi_type
> >        qdev: adjust PciDevfn declared type
> >        qdev: convert system PropertyInfo definitions to use qapi_type
> >        hw: convert device-local PropertyInfo definitions to use qapi_ty=
pe
> >        target/riscv: fix incorrect QAPI types and u8 casting
> >        target/riscv: convert PropertyInfo definitions to use qapi_type
> >        qdev: convert PropertyInfo definitions to use qapi_type
> >        qdev: introduce typed array PropertyInfos
> >        qdev: simplify DEFINE_PROP_ARRAY and remove generic array Proper=
tyInfo
> >        qdev: remove deprecated PropertyInfo.type and .enum_table fields
> >        memory: use object_property_add_link for container property
> >        hw/i386: convert PCSouthBridgeOption to QAPI enum
> >        qom: use QAPITypeInfo in object_property_get_enum
> >        qapi: expose integer signedness and width in introspection
> >        tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schem=
a
> >
> >   accel/hvf/hvf-all.c                      |  29 ++--
> >   accel/kvm/kvm-all.c                      |  31 ++--
> >   accel/nitro/nitro-accel.c                |   3 +-
> >   accel/tcg/tcg-all.c                      |   3 +-
> >   accel/whpx/whpx-common.c                 |  58 +++----
> >   authz/list.c                             |  14 +-
> >   backends/cryptodev.c                     |   7 +-
> >   backends/hostmem-file.c                  |  33 ++--
> >   backends/hostmem-memfd.c                 |   3 +-
> >   backends/hostmem.c                       |  20 +--
> >   backends/spdm-socket.c                   |  25 +--
> >   backends/tpm/tpm_util.c                  |   3 +-
> >   block/throttle-groups.c                  |  10 +-
> >   chardev/char-socket.c                    |   3 +-
> >   crypto/secret_common.c                   |  12 +-
> >   crypto/secret_keyring.c                  |   9 +-
> >   crypto/tlscreds.c                        |  12 +-
> >   docs/devel/qapi-code-gen.rst             | 123 +++++++++++++--
> >   docs/interop/virtio-balloon-stats.rst    |  22 +--
> >   event-loop-base.c                        |   7 +-
> >   hw/acpi/ich9.c                           |   3 +-
> >   hw/acpi/pci.c                            |   7 +-
> >   hw/arm/virt.c                            |  31 ++--
> >   hw/block/xen-block.c                     |   3 +-
> >   hw/core/clock.c                          |   3 +-
> >   hw/core/machine-qmp-cmds.c               |   3 +-
> >   hw/core/machine.c                        |  13 +-
> >   hw/core/qdev-prop-internal.h             |  20 +++
> >   hw/core/qdev-properties-system.c         |  97 ++++++------
> >   hw/core/qdev-properties.c                | 180 ++++++++++++++-------
> >   hw/cpu/core.c                            |  10 +-
> >   hw/cxl/cxl-host.c                        |   6 +-
> >   hw/display/apple-gfx-mmio.m              |   2 +-
> >   hw/display/apple-gfx-pci.m               |   2 +-
> >   hw/display/apple-gfx.h                   |   1 +
> >   hw/display/apple-gfx.m                   |   7 +-
> >   hw/gpio/aspeed_gpio.c                    |   5 +-
> >   hw/gpio/aspeed_sgpio.c                   |   3 +-
> >   hw/gpio/pca9552.c                        | 261 ++++++++++++----------=
---------
> >   hw/gpio/pca9554.c                        | 157 +++++++------------
> >   hw/gpio/stm32l4x5_gpio.c                 |   5 +-
> >   hw/i386/microvm.c                        |  80 ++++------
> >   hw/i386/pc.c                             |  32 ++--
> >   hw/i386/pc_piix.c                        |  61 +++-----
> >   hw/i386/sgx-epc.c                        |   3 +-
> >   hw/i386/x86.c                            | 113 ++++++-------
> >   hw/ide/ide-dev.c                         |   3 +-
> >   hw/input/stellaris_gamepad.c             |   2 +-
> >   hw/intc/apic_common.c                    |   3 +-
> >   hw/intc/arm_gicv3_common.c               |   2 +-
> >   hw/intc/arm_gicv5_common.c               |   4 +-
> >   hw/intc/rx_icu.c                         |   4 +-
> >   hw/loongarch/virt.c                      |  87 +++++------
> >   hw/mem/nvdimm.c                          |  11 +-
> >   hw/mem/pc-dimm.c                         |   3 +-
> >   hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 ++-
> >   hw/misc/arm_sysctl.c                     |   4 +-
> >   hw/misc/aspeed_lpc.c                     |  73 ++++++---
> >   hw/misc/aspeed_sdmc.c                    |   3 +-
> >   hw/misc/mps2-scc.c                       |   2 +-
> >   hw/misc/npcm7xx_mft.c                    |   3 +-
> >   hw/misc/tz-ppc.c                         |  19 +--
> >   hw/misc/xlnx-versal-trng.c               |  15 +-
> >   hw/net/ne2000-isa.c                      |   3 +-
> >   hw/net/rocker/rocker.c                   |   2 +-
> >   hw/net/virtio-net.c                      |   2 +-
> >   hw/nvme/ctrl.c                           |  29 ++--
> >   hw/nvme/nguid.c                          |   3 +-
> >   hw/nvram/xlnx-bbram.c                    |   3 +-
> >   hw/nvram/xlnx-efuse.c                    |   5 +-
> >   hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
> >   hw/pci-bridge/pci_expander_bridge.c      |   3 +-
> >   hw/pci-host/i440fx.c                     |  29 ++--
> >   hw/pci-host/pnv_phb3.c                   |   5 +-
> >   hw/pci-host/pnv_phb4.c                   |   5 +-
> >   hw/pci-host/q35.c                        |   9 +-
> >   hw/pci/pci.c                             |   3 +-
> >   hw/ppc/spapr_caps.c                      |  39 ++---
> >   hw/ppc/spapr_drc.c                       |   5 +-
> >   hw/ppc/spapr_rtc.c                       |  18 ++-
> >   hw/remote/vfio-user-obj.c                |  22 +--
> >   hw/riscv/microchip_pfsoc.c               |   3 +-
> >   hw/riscv/riscv_hart.c                    |   6 +-
> >   hw/riscv/virt.c                          |  52 +++---
> >   hw/rtc/mc146818rtc.c                     |  16 +-
> >   hw/s390x/ccw-device.c                    |   3 +-
> >   hw/s390x/css.c                           |   5 +-
> >   hw/s390x/s390-pci-bus.c                  |   3 +-
> >   hw/s390x/s390-virtio-ccw.c               |   4 +-
> >   hw/s390x/sclpcpi.c                       |   8 +-
> >   hw/s390x/virtio-ccw-mem.c                |   3 +-
> >   hw/sensor/adc128d818.c                   |  16 +-
> >   hw/sensor/adm1266.c                      |   3 +-
> >   hw/sensor/adm1272.c                      |   9 +-
> >   hw/sensor/emc141x.c                      |   9 +-
> >   hw/sensor/isl_pmbus_vr.c                 |  19 +--
> >   hw/sensor/lsm303dlhc_mag.c               |   9 +-
> >   hw/sensor/max34451.c                     |   5 +-
> >   hw/sensor/tmp105.c                       |   3 +-
> >   hw/sensor/tmp421.c                       |   9 +-
> >   hw/usb/dev-storage-classic.c             |   3 +-
> >   hw/vfio-user/pci.c                       |   5 +-
> >   hw/vfio/pci-quirks.c                     |   3 +-
> >   hw/virtio/virtio-balloon.c               |  87 ++++-------
> >   hw/virtio/virtio-iommu-pci.c             |   2 +-
> >   hw/virtio/virtio-mem-pci.c               |   3 +-
> >   hw/virtio/virtio-mem.c                   |  18 ++-
> >   hw/xen/xen-pvh-common.c                  |   9 +-
> >   include/chardev/char.h                   |   8 -
> >   include/hw/block/block.h                 |   2 +-
> >   include/hw/core/qdev-properties-system.h |   2 +
> >   include/hw/core/qdev-properties.h        |  40 +++--
> >   include/hw/cxl/cxl_component.h           |   5 +-
> >   include/hw/i386/pc.h                     |   4 +-
> >   include/qapi/qapi-type-info.h            |  32 ++++
> >   include/qemu/osdep.h                     |  33 ++++
> >   include/qemu/uuid.h                      |   4 +
> >   include/qom/object.h                     | 171 ++++++++++++--------
> >   include/system/spdm-socket.h             |  28 ++--
> >   iothread.c                               |   9 +-
> >   meson.build                              |   2 +
> >   migration/options.c                      |   4 +-
> >   monitor/qmp.c                            |  12 +-
> >   net/colo-compare.c                       |  15 +-
> >   net/dump.c                               |   6 +-
> >   net/filter-buffer.c                      |   3 +-
> >   net/filter.c                             |  10 +-
> >   qapi/common.json                         |  28 ++++
> >   qapi/introspect.json                     |  20 ++-
> >   qapi/machine.json                        | 152 ++++++++++++++++++
> >   qapi/meson.build                         |   4 +
> >   qapi/pragma.json                         |   1 +
> >   qapi/qom.json                            |  10 ++
> >   qapi/sockets.json                        |  20 +++
> >   qga/meson.build                          |   2 +
> >   qom/object.c                             | 236 +++++++++++++---------=
------
> >   qom/qom-qmp-cmds.c                       |  32 ++--
> >   scripts/qapi/backend.py                  |   9 +-
> >   scripts/qapi/gen.py                      |   2 +-
> >   scripts/qapi/introspect.py               | 107 ++++++-------
> >   scripts/qapi/schema_analysis.py          | 149 ++++++++++++++++++
> >   scripts/qapi/type_infos.py               | 178 +++++++++++++++++++++
> >   system/bootdevice.c                      |   3 +-
> >   system/memory.c                          |  40 +----
> >   target/arm/cpu64.c                       |  11 +-
> >   target/arm/kvm.c                         |   3 +-
> >   target/arm/tcg/cpu64.c                   |   5 +-
> >   target/i386/cpu.c                        |  26 +--
> >   target/i386/kvm/kvm.c                    |  38 +++--
> >   target/i386/kvm/tdx.c                    |   4 +-
> >   target/i386/sev.c                        |  31 ++--
> >   target/i386/whpx/whpx-all.c              | 101 ++++--------
> >   target/ppc/compat.c                      |   3 +-
> >   target/riscv/cpu.c                       |  50 +++---
> >   target/riscv/kvm/kvm-cpu.c               |   7 +-
> >   target/riscv/tcg/tcg-cpu.c               |  13 +-
> >   target/s390x/cpu-system.c                |   4 +-
> >   target/s390x/cpu_models.c                |   5 +-
> >   target/sparc/cpu.c                       |   3 +-
> >   tests/include/meson.build                |   2 +
> >   tests/meson.build                        |   6 +
> >   tests/qapi-schema/meson.build            |   1 +
> >   tests/qtest/qmp-cmd-test.c               |  55 ++++++-
> >   tests/unit/check-qom-proplist.c          |  99 +++++++++---
> >   tests/unit/test-qdev-global-props.c      |  11 +-
> >   tests/unit/test-qdev.c                   |   2 +-
> >   ui/console-vc.c                          |   8 +-
> >   ui/console.c                             |   3 +-
> >   ui/dbus.c                                |  18 ++-
> >   ui/input-linux.c                         |  11 +-
> >   util/thread-context.c                    |   7 +-
> >   util/uuid.c                              |   5 +
> >   172 files changed, 2510 insertions(+), 1699 deletions(-)
> > ---
> > base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> > change-id: 20260510-qom-qapi-fbe0f5060c3f
> >
> > Best regards,
> > --
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ATB,
>
> Mark.
>


