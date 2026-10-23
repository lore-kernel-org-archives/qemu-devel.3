Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ft9lvkOI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TzwQsXPC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKElX-0006V3-Mn; Fri, 23 Oct 2026 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xKElV-0006UJ-Vf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xKElT-0006yI-Rk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792759973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHJn/bQ7i1nFOGUE33+SuHHLPR5+3MgUazX6axy9mcw=;
 b=Ft9lvkOIgaftEUbDIhSNF12qvqdKx9Ogo+yDqphCMJgYeUykvooCAsuPcCtzUca0EVZqL2
 WDsumkxANZDx1sxKQGOkRl39rUClhrxw3TZ8FT2evDkfU95ajSpvwl+0S4XbP7JqQPqXbs
 PVFku0ysfIiBhFou4mPkY2pAHu0D8AU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-GXyABD3hPd6nV8oYPbUhUA-1; Fri, 23 Oct 2026 08:52:44 -0400
X-MC-Unique: GXyABD3hPd6nV8oYPbUhUA-1
X-Mimecast-MFC-AGG-ID: GXyABD3hPd6nV8oYPbUhUA_1792759963
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so884068a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759963; cv=none;
 d=google.com; s=arc-20260327;
 b=Jdm8WVPkyePU90cE/8CTlypXrjBPadHufG1emerYOhc0aN043hHJhUBgeJ3RarOUss
 BH/BmsN5liLZouT9SHqrrWu4NanM3Zm97XZEzS4f0OcCOusN2kRzIGrebYAFlGT4kHuG
 psSl0t2toeDpETMd8K98P1PzhpQp2AabzwnY/DWiwS0c5ZJBcK5t/UiZ0JBqvLuKIUlc
 bNzrK9YgCA6dAQpoN3bGXIwIxult56izbf9KpK9DBaNy3T4SfiaC0CyAMUCF/2OA0oND
 Txt4H4x5eq4Afyc84756XWqBSKJUbCwkvwRelS7I7hy2Ekn2VqRO8n8OVZgV85Vp53B3
 NN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UHJn/bQ7i1nFOGUE33+SuHHLPR5+3MgUazX6axy9mcw=;
 fh=x4K5gk7xv7OXRecWWGnitIYUYxAMoMoRt5GQc/oAfM8=;
 b=XgF0+JuYlJuuNV3G4V8flbmZsa2ffhQqAz/NbkuCtv+j3MSTqi68nNvjbn4MZ6PErB
 7PikJjZr4bDI3H0XzLlwbFX0loXkeIQr10BpaS9+217ttoKJnwBwaki/46V+4FZcJ9xX
 ndNHpVwH+NgYK5fCMfp8yLA1alF/Lg41VXOpJbfZhtrTB/ZSd30c41WqIiQV0Am21lVI
 Xth7en12fsP4sWSclrkQH+934vdMpgxWGka3VyOb73Q8e4/F9v4o0hee25pXjJbo4zTI
 IP8S/fHUghahhBiOyowB8V8OMsiC1hKPROtq4sFVaZ+Uie2t4/30nOzkprCK/aOBg+3I
 gKvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792759963; x=1793364763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UHJn/bQ7i1nFOGUE33+SuHHLPR5+3MgUazX6axy9mcw=;
 b=TzwQsXPC8FpBkqLMcoDc6q3vZQq+gkpSXyStwkzzipSKMqCRtualyHxpRQQG//gaJc
 cpZ1e/om9BYltuG6TTXIQqcjn4hw7bVc86rqYj5yUaK3FTW7odXEsgC8ZBCAR1HkQHMs
 0TP65NyJzhsNHkth5OJwGhbopdg14FV/PAYBcFaV+KLrCwXwKo5x33chcPdRj7H6MQQu
 htJEZ3L8FMdwv0kaEZMHprW7aanQ3XPy+SiIfrMc9O1Yj/fr5VrEwfYnsLNgPQAoZhE3
 8mcwMXvoo9lPuixBAgCW+K4Q/QPaytpPP+4O14DyCAOeBhOWYCuC76NK2KWBu8qoUli6
 bVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759963; x=1793364763;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UHJn/bQ7i1nFOGUE33+SuHHLPR5+3MgUazX6axy9mcw=;
 b=Nk5j2xBXV/FVnXx3iYrBoFLP9aTJxFNppeeX2YDwSXcL73NQ9NAeQXf9+qoRb5rEGV
 aYtrgAuLdwYZvRYp1y4ScZPFX/+rxol9TO0zYuG8FxiE0z6c6JNk85Z0njbJpOmOy4WF
 7HxsNSEGTkt8+IjE16xId2r504eNQ2mdX37vB4MGf814TriP4Lyxo8Xq+KGaK6H6GlV0
 j25DMVwf2Prn6WgT5rgRAmgPlcb5SSU9rDpxRQA0+HpJUHiVfhrYVaIt3qA8Rb/eM/eS
 meNMSJV6csYRLZKxkUStixeRawPZbsI8YllgHYnJg0m7oKyijWVOUUf1j2uzRBE9klus
 7f5A==
X-Gm-Message-State: AFq9FYKlRhjrRKGK3zyVzWrApzUgBLvaIutvGQcOdiTU+1A7HIhGObkT
 GapSy0izJQxsc1XVHdkO2nke/w3ZgWRUbZ2mYQ3Q3ozmtXRiZFn1pFXpX4KdRsj3Hh+r6mqeMfY
 H72jgFJQ2R7Bx+12krQla+jT3K3X2UR2nYithQI53u3h0hkD9iNOUpR96IqHSI+Jlcw3VyO5ohk
 34+9eVoiK7VecCcWWqgBgKwITu2WSpCSA=
X-Gm-Gg: AYBFou3bAUOZbQoLjcbA4SCoaU9k/57k3wS86STLPb4IGAzjIZCYEyxxwwPtKQjrf6Q
 otcy2rrtAg/k1SnlxG/6T8owD49fXXT42IuocNG75RdMB7okupTqjzmZ1yqupvf8ByeCpgMrOfs
 Gncn8sZWJQ+aBGW1xUQ2dgKHW7DUJzsPUry5eKo/hwMc8dUAv2HUNwe0Le8ydx7JzAFpzL8pWJL
 0JKdnvRvkzpZlLEGQSn/xE0QwAu06KxHhekxAkj37Fpx2Gno2PTXNJX+N/FIG4OAWtWFOLdodrp
 3w==
X-Received: by 2002:a17:90b:4c8b:b0:3ad:a232:4044 with SMTP id
 98e67ed59e1d1-3adce77b63bmr1671107a91.38.1792759962845; 
 Fri, 23 Oct 2026 05:52:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8b:b0:3ad:a232:4044 with SMTP id
 98e67ed59e1d1-3adce77b63bmr1671084a91.38.1792759962024; Fri, 23 Oct 2026
 05:52:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87ik2tj0g3.fsf@pond.sub.org>
In-Reply-To: <87ik2tj0g3.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Oct 2026 16:52:30 +0400
X-Gm-Features: AclHuK9xmEGvF0OyZ2a-feeTvInCBbT9OlJbgsN2wxK4TtyA9yVx47EX1DX-eTk
Message-ID: <CAMxuvazmyYb4d7neLQP4v4ZoKZfQfD1iDqA4gtC+QV5nBCging@mail.gmail.com>
Subject: Re: ObjectPropertyInfo design (was: [PATCH v7 00/65] Hi)
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 22, 2026 at 6:04=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9's series evolves ObjectPropertyInfo and ObjectPropertyVal=
ue:
> it adds member @qapi-type and changes many values of member @type.
>
> I'd like to take a step back and discuss design.  I trimmed Cc:
> accordingly.
>
>
> =3D The current interface
>
> qom-list returns information on an object's properties, one
> ObjectPropertyInfo per property.
>
> qom-list-properties returns information on properties an instance of a
> type is known to have[*], one ObjectPropertyInfo per property.
>
> qom-list-get returns information on the properties of several objects,
> one ObjectPropertyValue per property.
>
> ObjectPropertyInfo and ObjectPropertyValue provide @name and @type.
>
> ObjectPropertyInfo additionally provides @description and
> @default-value, both optional.
>
> ObjectPropertyValue additionally provides optional @value, absent when
> the property cannot be read.
>
> If ObjectPropertyValue was an extension of ObjectPropertyInfo, then
> qom-list-get would be a strictly more powerful version of qom-list.
> It isn't.  However, I think the information lost when moving from
> qom-list to qom-list-get is not useful:
>
> * @description is rarely present (I see under 15% in a quick test).  The
>   description text is commonly misleading for QMP.  For instance, qdev
>   bool properties have description "on/off".  The possible values are
>   actually JSON false and true.
>
> * @default-value can be useful with qom-list-properties, which operates
>   on types.  I doubt it is with qom-list, which operates on objects.
>
> Let's pretend @description doesn't exist, and @default-value exists only
> with qom-list-properties.
>
> This makes qom-list-get strictly more powerful than qom-list, so let's
> further pretend qom-list doesn't exist.
>
>
> =3D Simplified interface for the sake of discussion
>
> qom-list-properties returns information on properties an instance of a
> type is known to have[*]: @name, @type, and maybe @default-value.
>
> qom-list-get returns information on the properties of several objects:
> @name, @type, and maybe @value.
>
>
> =3D The meaning of @type
>
> Three cases:
>
> 1. For a child property (created with object_property_add_child() etc.),
>    @type is "child<T>", where T is the child's QOM type.
>
> 2. For a link property (created with object_class_property_add_link()
>    etc.), @type is "link<T>", where T is the target's QOM type.
>
> 3. For other properties, @type can be anything.  We commonly use QAPI
>    type names (occasionally misspelled), and also "well-known" (but
>    undocumented) non-QAPI names for primitive types.  Every now and
>    then, developers get lazy and use values like "list", or creative and
>    use values like "guest statistics".  Nobody has gotten sufficiently
>    masochistic to use values starting with "child<" or "link<" so far,
>    although nothing would stop that.
>
> Cases 1 and 2 go against the QAPI/QMP design maxim "don't encode stuff
> in strings".
>
> Case 3 is is hard to use for anything.  You're forced into stupid and
> brittle hardcoding.
>
> Marc-Andr=C3=A9's work adds a new optional member @qapi_type that refers =
to a
> QAPI type in the output of query-qmp-schema.  It's present for a large
> subset of case 3.  When it's present, @type should not be used.
>
> It also cleans up many crap cases of 3, but without making it robust.  I
> understand this isn't something the series tries to do, it's just
> something that's easier to do than not to do.  If it creates
> compatibility problems, we have to not do it.  I hope it doesn't.
>
>
> =3D Can we do better?
>
> What information are we trying to convey?  Four cases:
>
> 1. Child property: the child's QOM type
>
> 2. Link property: the target's QOM type
>
> 3. QAPI-backed property: the property's QAPI type
>
> 4. Other property: we have nothing useful to offer
>
> Case 4 should go away eventually.
>
> How would we encode this in QAPI on a green field?  With a union, of
> course:
>
>     { 'enum': 'ObjectPropertyKind',
>       'data': [ 'child', 'link', 'qapi', 'other'] }
>
>     { 'struct': 'ObjectPropertyInfoLink',
>       'data': { 'qom-type': 'str' } }
>
>     { 'struct': 'ObjectPropertyInfoQAPI',
>       'data': { 'qapi-type': 'str' } }
>
>     { 'union': 'ObjectProperty...',
>       'base': { 'kind': 'ObjectPropertyKind',
>                 ... more ... },
>       'discriminator': 'kind',
>       'data': {
>           'child': 'ObjectPropertyInfoLink',
>           'link': 'ObjectPropertyInfoLink',
>           'qapi': 'ObjectPropertyInfoQAPI' } }
>
> To make this a compatible evolution of ObjectPropertyInfo, we need
> ... more ... to be
>
>                 'type': 'str',
>                 '*description': 'str'
>                 '*default-value': 'any',
>
> Sadly, we need to duplicate the union for ObjectPropertyValue.  There,
> ... more ... needs to be
>
>                 'type': 'str',
>                 '*value': 'any'
>
> We should deprecate @type.  I'd also deprecate @description.

It's optional, I don't think that hurts.

> Thoughts?

I like it overall.

But this goes beyond the intended scope of the series.
Blending/merging QOM type & QAPI type would warrant more design
research. So covering child<> & link<> are out of scope of the current
qom-qapi series. I think the addition of qapi-type shouldn't be
incompatible with a future proposal, after all all properties should
have some 'wire' type (link/child are paths). But we can drop it for
now or just rename it x-qapi-type until we agree on the new
introspection.

my2c


