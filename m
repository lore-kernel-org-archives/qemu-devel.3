Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C2C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQPC-0005Ns-VT; Thu, 13 Aug 2026 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQP8-0005NO-Td
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQP6-0001Ph-RI
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786608186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEaQkfmGmTr3IerMBUf2Pwakj0dxUfT/ZCuwk/9VqOc=;
 b=VOGKZH3iFSeM4o9I7k/BwJEgq5TFINOgqJiiZdA3ONvpG03gI6vaDev8b8ILvCK67ErpuI
 YckkBJePZi6VrW0NYlcbVB+p5hHx+HpOXZEfJYlm62zbUpHmL3V2zcpmrJmUkDQsFufJ4X
 qQYt+Dpunnl7Ka6J1jxM4J+dLEcTQ8k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-TIyFGSeLPNmWLC-J14RlgQ-1; Thu, 13 Aug 2026 04:03:00 -0400
X-MC-Unique: TIyFGSeLPNmWLC-J14RlgQ-1
X-Mimecast-MFC-AGG-ID: TIyFGSeLPNmWLC-J14RlgQ_1786608179
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so2459462a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 01:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786608179; cv=none;
 d=google.com; s=arc-20260327;
 b=AdyPJPliDTmdQ72PmxH4KOVvefQQTmaLApeDmd+SMTQbtJ5Ag38f4Nc5QSeamYBAsD
 iWXz7BPZUeUvkj2Vrp14jXRJm92HhxbIOp0PInn8WzxwHxGoXRZNUpi+HtD2WQy73j/C
 qf45kj7mLcS1d6jpWhWZ1F7GdxN4NuJNzdT72LtqiIEoY+91+Z+OwPV12k48Tt+jRXaM
 sNaD30D5XOoiQ/e0FcCE+znd45x93ejgm38qkkjCprrs8ogLx3kkkQRG3lIArQrAx8tl
 9y3bgPVn/5E1WZLYnHcgGRHXiHJqaWcmkF0AFD9AxxUS7LIQX6RFzSSL5G3zfG5K2Fnc
 Fkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vEaQkfmGmTr3IerMBUf2Pwakj0dxUfT/ZCuwk/9VqOc=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=M5Vj3lh6DmXpAk5FClRpevOVsMUqXnX/phg8VyX/0Qr0tOEF2hmACiNEGZoG1rBXUK
 ygkfFQ0R4cjORTc6xtkvkm9lPGDDFuHyNuRcCVq6u47GcL2c8+QBZnakjQrqog2CwkAN
 qtlDh54zqzVdID5Eu4infxyQXL7l9BoicV5CX6QAKrUtderGXViKSsDN9RCIaSALasuM
 kgN86WYvQPTbImu61Aa25Ld3n51Ob0Y/Cczs80JmCnNUP8PrfQVDhzjmbhGvI6OY5zeA
 oNuLnTk/V14TMr8c7C8L8wiCXSKjOdwNREgcwyqbb/jiq7LVGeMxjBB/x47EFNdtsmxg
 mQ5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786608179; x=1787212979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vEaQkfmGmTr3IerMBUf2Pwakj0dxUfT/ZCuwk/9VqOc=;
 b=Jg0AsjLyW7K81jKNZWR5IuFcjkHH9IIHa73wTeqWyrAUjlWKPl+w18JH3tRjFl94te
 xlCgSRxqaaqjVGhlvlils+rWVI+k1q3/Z/Me3ezpY2fp0BTcQklLtniwxIdxAoxdykDw
 cAOZEh7N+XK/yXmDfDJjP30NKEZgJIR5kBBXDzCx0kC17GKYaGCZQZ2PCv6JyTjKopSC
 gZqNObrdwU83xudseiWE9jzBo8LYYBEZX2S32c2r0YcDQs/trtPkUsO1dptQOkdPWiuU
 gSoo5O5cw1Im6bq3tzGFBGUZuYJASWHPXCglI9aQQOyoe1LvoDCKCKxVfSw6ZPtXVQso
 QWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786608179; x=1787212979;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vEaQkfmGmTr3IerMBUf2Pwakj0dxUfT/ZCuwk/9VqOc=;
 b=POqzS/CeS6Cv4HeqMLchGsALGr+vxmtt/oc2h0BI0rL3vl+C5B3xbF1lHgh8E6Nl9Y
 iW/ta8xV37I0cUhD2GGnWKaejGWAIFQ+Rh/J7ix9H01SuIh1H62Sp5URyhXijt0tOfFJ
 D7y4bJerT/tEkqgtgq2CJKK6MmUbhLtPZx3wcMjiZMcK1B+5QzDKAE8kjP9CQK0AKVU0
 gXRHhECRyReKKzIbnWmD2GLDzDU67v+YOu+VxrcnZ8DtvCZjdZoSgdwb6gWTkZD7ns5B
 2oNHM7faHoFaj7elTgw+FsSggJ34Fs/lGB/2jaYMjKRHypphqhR5XX6LvoShTzr5XagQ
 JKDQ==
X-Gm-Message-State: AOJu0YyNLGJWu6Cnt0gGLV3BWG2J2WVnAOEijN6hNBL5kawYN91v0Vlo
 tHv9wLTNK8y8Lgleogoi18OAXMAirLl2D/Uf55lCcGjRZPT6NkBoix+3OHsyXNLztjDsHzt/T3R
 WBdsrsG74QaX50BmGC5BV2mt1AwpZP35eFNbxPerNYDT9qMIQeX1Si2urUaAm/5AL3IbN8RKGKJ
 T3fFIAYhHfGm+TRjsUa5gEnjevjh+02jA=
X-Gm-Gg: AR+sD12UlolBJ/genlxclM0StWbdy2G17DyloPq2B9MtK8joDCnlqHffLWtnQPlUwtU
 0XXbLiAkBu7zUcKzKZAmkhGAx+R4IXIF+t0rGS6QfvzSFvy2VlABOIVM3U1hCDIUgvydm8J2u07
 EYR3Qlli8IR1+2w2UP/jSiFl4Ns1Fzt8d+5JdeSet7tIobmcfUOHoa5HdIfxaYWPclG4W+ZbSYC
 312vYgm1v3U2SCfTyFv32m2UY3ugsGSvomZyQ+g66GedY1aWX2GduaChMxWKqV85pDVDqQuHrqa
 Ag==
X-Received: by 2002:a05:6a20:2d26:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3cc55045770mr5860103637.14.1786608178926; 
 Thu, 13 Aug 2026 01:02:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d26:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3cc55045770mr5860033637.14.1786608178425; Thu, 13 Aug 2026
 01:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-8-cc9396b9c18c@redhat.com> <87ik5mqnzl.fsf@pond.sub.org>
In-Reply-To: <87ik5mqnzl.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 12:02:47 +0400
X-Gm-Features: AUfX_mxsYsaAmRG_5Z95B-aR_AsTn7pbtrXPE1xEOQFMQH8PgiGdCyBWBDeuI1w
Message-ID: <CAMxuvax4MEWEPXcG6Bp4wycdMutkj56tqhwAr+gaFs=oM55HQg@mail.gmail.com>
Subject: Re: [PATCH v2 08/53] qapi/qom: add qapi-type field to
 ObjectPropertyInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Fri, Aug 7, 2026 at 1:27=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add an optional 'qapi-type' field to ObjectPropertyInfo and
> > ObjectPropertyValue. When present, it contains the masked type name tha=
t
> > can be looked up in query-qmp-schema output. Absent for properties
> > without a QAPI type association.
>
> Always absent at this point, isn't it?

yes

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/qom.json | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index dd45ac1087c..a655be0beaa 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -35,6 +35,11 @@
>    ##
>    # @ObjectPropertyInfo:
>    #
>    # @name: the name of the property
>    #
>    # @type: the type of the property.  This will typically come in one of
>    #     four forms:
>    #
>    #     1) A primitive type such as 'u8', 'u16', 'bool', 'str', or
>    #        'double'.  These types are mapped to the appropriate JSON
>    #        type.
>    #
>    #     2) A child type in the form 'child<subtype>' where subtype is a
>    #        qdev device type name.  Child properties create the
>    #        composition tree.
>    #
>    #     3) A link type in the form 'link<subtype>' where subtype is a
> >  #        qdev device type name.  Link properties form the device model
> >  #        graph.
>
> The description of @type is problematic, and will need an update at some
> time.
>
> >  #
> > +# @qapi-type: if the property was registered with a QAPI type
> > +#     association, the type name as it appears in the output of
> > +#     ``query-qmp-schema``.  Absent for properties without a QAPI
> > +#     type association.  (since 11.1)
>
> Whether "the property was registered with a QAPI type association" is
> implementation detail.
>
> Maybe
>
>    # @qapi-type: the name of the property's type name as it appears in
>    #     the output of ``query-qmp-schema``.  Absent if the type does not
>    #     occur there.  (since 11.2)
>
> This is inaccurate now --- it can also be absent when we haven't gotten
> around to fix the property --- but it hopefully becomes accurate soon,
> and should be good enough until then.
>
> > +#
> >  # @description: if specified, the description of the property.
> >  #
> >  # @default-value: the default value, if any (since 5.0)
> > @@ -44,6 +49,7 @@
> >  { 'struct': 'ObjectPropertyInfo',
> >    'data': { 'name': 'str',
> >              'type': 'str',
> > +            '*qapi-type': 'str',
> >              '*description': 'str',
> >              '*default-value': 'any' } }
> >
> > @@ -55,6 +61,11 @@
> >  # @type: the type of the property, as described in
> >  #     `ObjectPropertyInfo`.
> >  #
> > +# @qapi-type: if the property was registered with a QAPI type
> > +#     association, the type name as it appears in the output of
> > +#     ``query-qmp-schema``.  Absent for properties without a QAPI
> > +#     type association.  (since 11.1)
> > +#
>
> Likewise.

adjusted, thanks

>
> >  # @value: the value of the property.  Absent when the property cannot
> >  #     be read.
> >  #
> > @@ -63,6 +74,7 @@
> >  { 'struct': 'ObjectPropertyValue',
> >    'data': { 'name': 'str',
> >              'type': 'str',
> > +            '*qapi-type': 'str',
> >              '*value': 'any' } }
> >
> >  ##
>


