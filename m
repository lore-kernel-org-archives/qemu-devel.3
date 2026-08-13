Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D59C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQEb-0000MN-DZ; Thu, 13 Aug 2026 03:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQEY-0000Ih-Uh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQEW-00068c-T4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786607531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIte8VSnxTbthIyt0DLLzwiQPoCeS1ANCSyE35TJpnk=;
 b=HxsvteWEfdTI6EruRGxvZqZnSjWHamw6Sk43G4LPilnY01QyCl1Rf2aj/tmbhEBKEptWXU
 v99EYeCy3vSW21/WZRqOQuhW4l5bU8CUk7A84LoTSUObcbJsA9NKJArSD/rTZwmITYcGSV
 CetlOYdRwzJoeqtUnfTz9Vdwnkc7dLs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-6WX5HuN3Mca6xEmpNvPSaA-1; Thu, 13 Aug 2026 03:52:10 -0400
X-MC-Unique: 6WX5HuN3Mca6xEmpNvPSaA-1
X-Mimecast-MFC-AGG-ID: 6WX5HuN3Mca6xEmpNvPSaA_1786607530
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so374105a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 00:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786607529; cv=none;
 d=google.com; s=arc-20260327;
 b=JMZffxUM4cFzCIb3HadDSs9c11TFRKVef1l550faeYl7ZYTqRliY/20mt0ylq8JZ6r
 3n0Tb0EkTtl/pUgkMlRuaudaVDfdf2F/35/DgQE3mm5fqdDv1Q0c/f7BQYvesqeG20Cz
 /2oucbmIYdr409y2sAD6BWcdf+NO028WeXsGhK4eXHREn4umLpgj8wMef4jYhSzXfYyd
 jegS3tbBDaNYkhugmRvy5k7LEwOIWeolJ5bwwiDUgDuNIp2gjnrQ0vEv2TZRYqlFn12Y
 VLEjGEiFSEnmSVQIEYQA8eciZs6jgf/BTpDF9SiPkZy9lXcbZxkU5VseJfOJNfG/0QMF
 O9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VIte8VSnxTbthIyt0DLLzwiQPoCeS1ANCSyE35TJpnk=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=rq/KGy0gGvPEhqchaAKQ7QopsQvCG19p67KYGiytdpPggJYIPN5Q5twKQRMkKcqz6e
 J2FZsyoLOJtt1ahgkcA9t66lUdbzHYRM7mgZQX6CBBASI2pLdztHAt0i4cJlTQgBCoLH
 XlRyGplMx5F4vX5oVntcbNuIfEmQLiRhwdTyFtNeE656VrCfxZ2fYGV+UJ7nPVXhoZXq
 0w12HZr+4x4b6UgDKL20QblMY2ugPXbHAwVPdqdf5ySxBlwm74IyqSrO50tGfdcxTTRS
 a6p8NadibgNjXYYJFVZ6ikzXGO7ny1I6PsKU232ZrVT9QiP/bwl9YEEoEaiuPYEHjf9R
 TZ9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786607529; x=1787212329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VIte8VSnxTbthIyt0DLLzwiQPoCeS1ANCSyE35TJpnk=;
 b=hM//X3LK8C+D0b8wflMqAC6Do67nmVCNIcWBuUcEJ7/ym1S2UQNsK4xDUdrVTThcyB
 DtzcJ1OqKcshk00Ovm5tqcd0MIzCFkQ9xIMZ0BaFKIwtqRZoVN4JvYS1KlWTdoSOd3v6
 BJoIAwlmQoawghI7vMJ8tt2kv/sIgQ3eSey0ITtE/LxRyvCcMw/ysVlVf+Al0xRcx6jE
 QhMDSN3aIB4D4pBBTlldqzvor6kilCpC70SXLZjF6Yahbpr3Rk4W7IGIRxPsrSXFjNS4
 ldH35gtV1mSAFfo/uISWdvd0CNLU8CpsPFPdh1qYxQhICoXzw8r0mnpaF/v5f3nWtI+B
 bmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607529; x=1787212329;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VIte8VSnxTbthIyt0DLLzwiQPoCeS1ANCSyE35TJpnk=;
 b=C7/m2bH0FWsXKlL4yYWWG6nYoZQTgh8Ac/D942yhN8EU7KkrQn50GjDL6aUAclwtFu
 8thNpHNEtO6WLa4vqRWy6q8FYdNKNIOqDEn2SC3vMIBelE+Mov39AJ7JZ5RdZRQyHso8
 16g8pwvsiS5eINF5rtV/D6So8CWzfgsEZeYfuRIvATvoj+cf8i7QEEZPN0lI7lMRJ2Ad
 nULlrjf/gFT4P/MkE9pyn0q+68XQlaue/Rl01LmdhXN9izB+9IjzBY2kGoI0b2VAowIN
 jwCZZxmgsgat2qZfaT8Wp1lfYpa+c5bvrapX+U4+5Tpc4t4JwX02jfA+CCwsmFJduW/O
 9GbQ==
X-Gm-Message-State: AOJu0Yx4ICQKKDdUwDgcq0xhCzrw2H2O7hg2+6QEbxNwYc8WM78E+teq
 wmuUR2lzMyyjmTVkTYiKXBGvN+/67jtHsBdxoP+207vJU4xOCUAKml1aQzS7joqPyQqEgv09T2u
 0NZ/Nb+7KFEKYRyAATlrFl6jHHhKx6ORv9Y71DPpbFGpX6S9qvGtI0yyMVXzTmuAfSMYtTx0GKG
 9Ylj5nd6EhSt2xLC85Yc99aS7dYCTB8j8=
X-Gm-Gg: AR+sD10x1hjbJ00514hlxRZdji4Q+iIBhECYF6CCoHkXMhQ4RdX6XObPIAhB3rw7PtY
 XpCaFeVcBoaNDb1NcVUoD420TjZqba9gEgPFEGndw+ylkpBbPyh+70Dt85OBwR1ulXGSQ0+cjaY
 IeYo8KVCLGTrkFvES0q4LWx52IiOhdAxicE3nYdknsQ1JLgiu/otMv9Qc+IKw2xsNz2S0VRejtn
 cBlLIL9/1lED3ZrRVI+vfDRbNpUz5Ex5rHyTX+kp6RV1mqDIOO1zp2u+660TpWYPzpulY0Osk66
 kw==
X-Received: by 2002:a05:6a20:2443:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cc554894bdmr5235244637.37.1786607529522; 
 Thu, 13 Aug 2026 00:52:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:2443:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cc554894bdmr5235192637.37.1786607528972; Thu, 13 Aug 2026
 00:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-6-cc9396b9c18c@redhat.com> <87o6fes8t3.fsf@pond.sub.org>
In-Reply-To: <87o6fes8t3.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 11:51:56 +0400
X-Gm-Features: AUfX_mwbExFaF1egMB-WiK7prkuD8SSkRXIbEMcO2Xy-AAw46Gdaes1aXCR1mQw
Message-ID: <CAMxuvayGHh4Lfk50rTYZ_C6p3qhWzuTMQjPZVJLJWxrgoOx90Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/53] meson: add qapi-type-infos-*.c/h to build
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 7, 2026 at 11:12=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Register the new per-module type-infos output files so they are
> > generated during the QAPI code generation step and compiled into
> > the build.
>
> Actually, they're generated before this patch already, they just aren't
> compiled.

right

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/meson.build              | 4 ++++
> >  tests/include/meson.build     | 2 ++
> >  tests/meson.build             | 6 ++++++
> >  tests/qapi-schema/meson.build | 1 +
> >  4 files changed, 13 insertions(+)
> >
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index a46269b5a0c..7ae3843de6e 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -80,6 +80,7 @@ endif
> >  qapi_nonmodule_outputs =3D [
> >    'qapi-introspect.c', 'qapi-introspect.h',
> >    'qapi-types.c', 'qapi-types.h',
> > +  'qapi-type-infos.c', 'qapi-type-infos.h',
> >    'qapi-visit.h', 'qapi-visit.c',
> >    'qapi-commands.h', 'qapi-commands.c',
> >    'qapi-init-commands.h', 'qapi-init-commands.c',
> > @@ -90,6 +91,7 @@ qapi_nonmodule_outputs =3D [
> >  qapi_outputs =3D qapi_nonmodule_outputs + [
> >    'qapi-builtin-types.c', 'qapi-builtin-visit.c',
> >    'qapi-builtin-types.h', 'qapi-builtin-visit.h',
> > +  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
> >  ]
> >
> >  qapi_inputs =3D []
> > @@ -100,6 +102,8 @@ foreach module : qapi_all_modules
> >      'qapi-types-@0@.h'.format(module),
> >      'qapi-visit-@0@.c'.format(module),
> >      'qapi-visit-@0@.h'.format(module),
> > +    'qapi-type-infos-@0@.c'.format(module),
> > +    'qapi-type-infos-@0@.h'.format(module),
> >    ]
> >    if have_system or have_tools
> >      qapi_module_outputs +=3D [
> > diff --git a/tests/include/meson.build b/tests/include/meson.build
> > index 8e8d1ec4e69..026480d9685 100644
> > --- a/tests/include/meson.build
> > +++ b/tests/include/meson.build
> > @@ -4,6 +4,8 @@ test_qapi_outputs_extra =3D [
> >    'test-qapi-commands-sub-module.h',
> >    'test-qapi-events-sub-module.c',
> >    'test-qapi-events-sub-module.h',
> > +  'test-qapi-type-infos-sub-module.c',
> > +  'test-qapi-type-infos-sub-module.h',
> >    'test-qapi-types-sub-module.c',
> >    'test-qapi-types-sub-module.h',
> >    'test-qapi-visit-sub-module.c',
> > diff --git a/tests/meson.build b/tests/meson.build
> > index 9ba04bbedd3..71dc4ac8bf9 100644
> > --- a/tests/meson.build
> > +++ b/tests/meson.build
> > @@ -2,6 +2,8 @@ subdir('bench')
> >  subdir('qemu-iotests')
> >
> >  test_qapi_outputs =3D [
> > +  'qapi-builtin-type-infos.c',
> > +  'qapi-builtin-type-infos.h',
> >    'qapi-builtin-types.c',
> >    'qapi-builtin-types.h',
> >    'qapi-builtin-visit.c',
> > @@ -22,6 +24,10 @@ test_qapi_outputs =3D [
> >    'test-qapi-init-commands.h',
> >    'test-qapi-introspect.c',
> >    'test-qapi-introspect.h',
> > +  'test-qapi-type-infos-sub-sub-module.c',
> > +  'test-qapi-type-infos-sub-sub-module.h',
> > +  'test-qapi-type-infos.c',
> > +  'test-qapi-type-infos.h',
> >    'test-qapi-types-sub-sub-module.c',
> >    'test-qapi-types-sub-sub-module.h',
> >    'test-qapi-types.c',
> > diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.bu=
ild
> > index debff633ac1..b10f081554d 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -232,6 +232,7 @@ custom_target('QAPI doc',
> >                         'doc-good-qapi-init-commands.c', 'doc-good-qapi=
-init-commands.h',
> >                         'doc-good-qapi-introspect.c', 'doc-good-qapi-in=
trospect.h',
> >                         'doc-good-qapi-types.c', 'doc-good-qapi-types.h=
',
> > +                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-ty=
pe-infos.h',
> >                         'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h=
' ],
> >                input: files('doc-good.json'),
> >                command: [ qapi_gen, '-o', meson.current_build_dir(),
>
> You add *type-infos* before *types* in some places, and after *types* in
> others.  I'd prefer same order everywhere.  Slight preference for
> before, so the order is alphabetical.
>
> You don't add them to qga/meson.build.  Makes sense; the guest agent has
> no use for them at this time.  They're still generated, though, which is
> fine, except "make clean" doesn't delete them.  Unclean :)
>

fixed

> Related: PATCH 04 generates files with bad names
> qapi-builtin-type-builtin-infos.[ch], PATCH 05 fixes them to
> qapi-builtin-type-infos.[ch], but "make clean" doesn't delete the bad
> ones.  Only "hurts" people compiling between PATCH 04 and 05, so no big
> deal.  I'd reorder to avoid this anyway.  The fix's commit message needs
> to be adjusted then.

reordered

>
> Similar dirtiness predates this series: qapi-features.[ch]
> qapi-commands.trace-events qapi-init-commands.trace-events.
>


