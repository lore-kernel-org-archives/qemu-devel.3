Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F05FEDA68F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxS6H-0006dF-GC; Tue, 03 Mar 2026 10:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxS6B-0006bL-L6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxS68-00083q-Gq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772553347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBFMAMBF9+GbAURLNU5FTNb7far72NAR6lMU69HXP9c=;
 b=KCR3o2h4UF6/5K6P5ywF0Wsmgl1TTI11Tp2t2yLIl9DJITP3qYLdW8vIebMlD1pERKizvi
 6cB//JrHXW2fpL+G9HqEX+ACYWFd7KZ+cZJAyB0YjtmsfeKjAbT5Gcm33hBhyfBL34x7Pv
 ex6FN6ANgz9ltyW/FagglcLKtE65MFo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-SOud4lU5NvW1CWgARNRnOw-1; Tue, 03 Mar 2026 10:55:46 -0500
X-MC-Unique: SOud4lU5NvW1CWgARNRnOw-1
X-Mimecast-MFC-AGG-ID: SOud4lU5NvW1CWgARNRnOw_1772553345
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso63296225e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772553345; cv=none;
 d=google.com; s=arc-20240605;
 b=ab4RaE43oIcvxlad3DluMb3xUhNX+2gVVfVP9V2dXVt6TBn+t4N5fSheKP0Hp4mBTH
 vcfnXEbl2rn64hMiGGa9Td7T973dkCMr9Wzs+XzPBa3oWz7K6Itf0SWvgN2N4DPil6hq
 6Rx2a3M+8dn65xCWazX2ii2npNxg7g+HtL/8btcCxIwiccGGlq0IMu8P1jGGleJI0o7w
 ZsOiTopuKq68Y1okFJa0I/9EbTHPZlN2Izk054gDdWqDkGS2k3a9CcqzmhuSntQgNFJw
 2i8KZk8dEGhtv4x+pg5U1dEU4+D1Vrm/EcbDsT7XWnrbuTlqlxIMmLPtZHdgejsbUSF7
 7O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kBFMAMBF9+GbAURLNU5FTNb7far72NAR6lMU69HXP9c=;
 fh=9G+wQcN1OeX82zR1COBg3ih6AReuGmDO099qsZBIt9Q=;
 b=SrIf/GAEuJrPi6jyU2lzR7o7QIixQdr6flesmYN+dTGApJsb6XBI6ld5C8fHDwA5cA
 s1znVOt6IjzNudun9ebl4XrBkefwPvpG6V/yGFOlZu21klH+KbuAsOznLr5INCuWBPMb
 CQIwE+DIixSg+k41zYyg4CB5P/Me784yBNaRZFsE3lm/9S6d7a12APxNZ6u+heo4lumV
 kNEvz1dLUNIq0AqgY98g5jmLveuvjN0zi6R5GnhnKMbQDzQkRAi/2eXCB05v9r7RFaUL
 S2kdXQ7mEiMmv3dkMaTl3Qam0+9jz6A/9obX3uvc2KOrBWaBqtWZyyXFCi3wVNksj6m0
 k7Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772553345; x=1773158145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBFMAMBF9+GbAURLNU5FTNb7far72NAR6lMU69HXP9c=;
 b=VipBgeGjAc3nGBwLeSa717OE3WZfa3n3H8E0mNGuPMljjTnRcTFWa0QIC2XNtvVosQ
 aq7VoxpIDbJ9mSlxFHXf25i/27GWfhIsvighwtyYuceUj31vNCBI9Fi1jWRNMfkik2h0
 /Kik5A1eqeZs2aCXWyN3pWamm9ojNoONVNt+SqKXtC33qRArmAA1N00bq/s9efjZedZN
 fMdIGl6TAJqSdxK/Y/4O+VYhj1N+QD296A+TtqZXl42TEE1Obfy6PzieCPjPWZGTcAUK
 E38KOG39eLKerXzRQv5st2p/u4+Ak+dhHhwJs5Wk26RilMXCeMaY7o3T/RoZqlYAMfi/
 QiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553345; x=1773158145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kBFMAMBF9+GbAURLNU5FTNb7far72NAR6lMU69HXP9c=;
 b=Kd+H/kUynjUOatWGSbxqojpg/2QqiskN1qMWSHTegO65ALyb9GF780sr/R3oUek5Wt
 LOGXKYmjZWKoRZC1JqexRogJcoLJipnHGf3jZoruqTYOU6Jc8IzK2AzHnyaY5bodmSQ1
 kNfp9X2ciIZO47pFdK+Rstph/t/NxTkBnt/iEHV9TPkAqlZMMmiKAdP+DuWPBddUB2lb
 dop8OMTyWa3+ZdlorHaKju46pVc4LyibAVJVUtLraosOAvTefCXioGXADG0ivn8dXM32
 XNzd2DE4mdil/kbpz62QdMZ0mC0OnQ/8OsVSQy+dH8gpHywjVyiYX4fyhUMyu1rfdp1B
 TrLg==
X-Gm-Message-State: AOJu0Yz7jwd8tuAreOhRk7uInwKEKd9OinyRZafgc3e/V3f7hnAa2EeE
 B/f7aWoxRudjOg2K1WQjQh/xBN1M7qZLnzvlLR847URsR70dA7h+fHOZCNQjEz3D53MrPl3jNRZ
 MlLio3dX3b2MKKdpU+P7UB9dx0JhB/Of343V8CumQtJmGYhocn5QrwWGCscetZsHr9mc6qAd6XO
 caDlFuQHrWH4knFYktOApeYF8NJD5b/vg=
X-Gm-Gg: ATEYQzysZB+9zgDgEmN/NBqQPRSd1DMtCAzdrEh03i0nTgkv5tdRbl++x0TFsKLCxZd
 SFnp6kzaTTv1T/aAe/defVfEIvX02qJqyYQTCD4NHboKsMPk+FQ0T33SeoE990w0bIXVh7Cg3pX
 no4NVXyqTPQqSTJU/WYdwc5lKmkPi9bFhBn4ajMVrnIJdpBq2p+yS3ilqr2ZngNq4tRjk/yCOdn
 3ZJ5D5QW7nkhGkRq8/VHq0vgCSeVDpm8/1HgO/OLpdpXVm4oVYECdomIpMK92QZkDFz5t7t7++w
 jfljcN4=
X-Received: by 2002:a05:600c:1f06:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483c9bf49afmr271617335e9.27.1772553344656; 
 Tue, 03 Mar 2026 07:55:44 -0800 (PST)
X-Received: by 2002:a05:600c:1f06:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483c9bf49afmr271616805e9.27.1772553344152; Tue, 03 Mar 2026
 07:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
 <87jyw0khu2.fsf@pond.sub.org>
 <3cd5ac78-1833-4671-a866-60a57f29c3c1@redhat.com>
 <87v7fdm6w6.fsf@pond.sub.org>
In-Reply-To: <87v7fdm6w6.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Mar 2026 16:55:30 +0100
X-Gm-Features: AaiRm527eRsJkf5mhTMOAT03XGTTnkhduTVxyjQG7WtF5hnH1AJrEbUaHd32fjk
Message-ID: <CABgObfYBVbpLfzFiYaCjzTL5zTqynWcUepV=o-AesJJF3jENEQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 3, 2026 at 1:31=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> >> You replied "In this case it doesn't really matter: public items (such
> >> as QAPI enum entries, or struct fields) do not raise the unused warnin=
g
> >> anyway."
> >>
> >> What gives us confidence rs_name() will only be used where it doesn't
> >> really matter?
> >
> > The fact that all QAPI type definitions are (more or less by design) pu=
blic.
>
> Any particular reason not to use the same 'q_' prefix as in C?

The other Rust convention is that you usually have enums in CamelCase
(starting with an uppercase letter). "q_" or "Q_" would also trigger a
warning, and they would complicate to_camel_case a bit (because the
prefix would have to be kept including the underscore).

> >> This maps 'foo-0123-bar' to 'Foo_0123Bar'.  Intentional?  I'd kind of
> >> expect 'Foo0123Bar'.
> >
> > Will fix (it is meant for 0123-45).  New version is:
> >
> >    def to_camel_case(value: str) -> str:
> >        result =3D ''
> >        for p in re.split(r'[-_]+', value):
> >            if not p:
> >                pass
> >            elif p[0].isalpha() or (result and result[-1].isalpha()):
> >                result +=3D p[0].upper() + p[1:]
> >            else:
> >                result +=3D '_' + p
> >        return result
>
> Maps '0123-45' to '_0123_45'.  Is the leading '_' intentional?

Yes, because otherwise the output is not an identifier; but it doesn't
matter since the input is actually an identifier already and
to_camel_case('_0123_45') does give '_0123_45'. In neither case you
get the invalid identifier '0123_45'.

> I'm fine with not running rustfmt, and I'm fine with running it always
> (makes it a hard requirement).  Running it sometimes feels like more
> trouble than it's worth.

Yeah, I will drop it. I changed mcgen to allow removing empty lines in
the middle of a declaration, like this:

def mcgen(*code: T.Sequence[str], **kwds: object) -> str:
    '''
    Generate ``code`` with ``kwds`` interpolated.  Separate
    positional arguments represent separate segments that could
    expand to empty strings; empty segments are omitted and no
    blank lines are introduced at their boundaries.
    '''
    last =3D len(code) - 1
    result =3D []
    for i, s in enumerate(code):
        if s.startswith('\n'):
            s =3D s[1:]
        if i !=3D last:
            s =3D s.rstrip()
        s =3D cgen(s, **kwds)
        if s:
            result.append(s)
    return '\n'.join(result)

For the case of a single argument, the result is equivalent to the
existing implementation:

        # already checked by current mcgen()
        if s.startswith('\n'):
            s =3D s[1:]
        # skipped for a single argument
        if i !=3D last:
            s =3D s.rstrip()
        s =3D cgen(s, **kwds)
        if s:
            result.append(s)
    # result has zero or a single element, no '\n' added
    return '\n'.join(result)

Paolo


