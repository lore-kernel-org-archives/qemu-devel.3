Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seegy-0004Gg-I5; Thu, 15 Aug 2024 13:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seegt-0003y0-JI
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:55:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seegm-0004Xq-Ja
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:55:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so1127476a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723744505; x=1724349305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jw42O4Ff2HO8SgGAiIajt3yXkZ/7KaY5K9z1+AIipQg=;
 b=AzWPjIZGhIolnYVQ7taHVQOoqiUEPUQOH0v4f8+zzd7vsVa4yVIJycs/GYuJFu/SE0
 B74NhNQi4MClBHqP9CerDa7fUcfPdBSj/e00RIhDkVOjBE0kCpoRTikfyZBnhfLh2BZO
 xpvJRFW232nn6JQDFiziesKWiU6K83NMoh750P/X/uKJi67fV/T1UdXZYK4Nj4EK+sOx
 AZiRKuUZSeaI1jaVMyJAGNwo6G4SRPBA5si1C7M41i1/igfWjK7B5VsXSM0Oj2Lr2E2j
 z1pNII0aritL8ZbEtp/A72XrGNDzBgq2v0sfcu3CC9n4Z/6xNHdiJ7l7WGJjdjys/Mxp
 uIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723744505; x=1724349305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jw42O4Ff2HO8SgGAiIajt3yXkZ/7KaY5K9z1+AIipQg=;
 b=xMghOt/2JhR6l4MkyX7Pi0IN0N80a4Ns+yZyBfpztBnYyaKNTtlou93B5ApFemwH1R
 xYqWp/ab6CsqxnXi07YQ20aCY4xld3bjTgUiGGvJJBOSqTseq/io8N7Akk10ewdVVNBj
 FwqcdtpbJxrsBjxaDZXAMhf7Wrg8aj+gSSos8Ej17DN7iMfdnP9EAx3pnACJT8Dtp8Lj
 8o5r99mNlWCmGifJuNhnOPeCE5DFWc/eDRRMvYdcpsvRPt1QO57NYuoUoXp6ohmfYe6S
 kxs7cY23Ol6Qu8x7HT3AoYNWucbnDDrmsxzTC/2/wyX4CQpTJhmtOZJ4BnhpJvv2Lfp/
 iHcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINFrZOUvhOLJwoJLBrpx9Fy+KfXPUYYNzrv7o9kteyQq6UYm0yZx4Gq0GeIze94qeVzmsN4smY58Ovw24+l2Wip+2SsA=
X-Gm-Message-State: AOJu0Yx52E3wMHXmTSg2SW0xurypIsyP6CepBjP9SsEkMLcMQFMU30FC
 eYgCabv3CQhZV0b8X6d35Oid4Tt42ue1cXC8N5TOC7RUu2j785p6Q8QbVkj3d7cn/KnnfExlB+d
 00h+grPtLj9uyPiPDS/uVBOz/CwP5wed97REJ6A==
X-Google-Smtp-Source: AGHT+IHguy3eQzFTIlLDOvSVCF35knPAw3D/fYtKe/Zh9diigsn4hGipWPiAUcKwXmU7/rQ8B7bVjOBUDIwqp2e1n58=
X-Received: by 2002:a05:6402:5cb:b0:5b4:cbba:902a with SMTP id
 4fb4d7f45d1cf-5beb3a3bd84mr3636991a12.4.1723744505269; Thu, 15 Aug 2024
 10:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
 <Zr3g7lEfteRpNYVC@redhat.com>
In-Reply-To: <Zr3g7lEfteRpNYVC@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 18:54:53 +0100
Message-ID: <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Aug 2024 at 12:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Aug 15, 2024 at 11:12:39AM +0100, Peter Maydell wrote:
> > On Wed, 14 Aug 2024 at 23:42, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> > >
> > > When building with gcc-12 -fsanitize=3Dthread, gcc reports some
> > > constructions not supported with tsan.
> > > Found on debian stable.
> > >
> > > qemu/include/qemu/atomic.h:36:52: error: =E2=80=98atomic_thread_fence=
=E2=80=99 is not supported with =E2=80=98-fsanitize=3Dthread=E2=80=99 [-Wer=
ror=3Dtsan]
> > >    36 | #define smp_mb()                     ({ barrier(); __atomic_t=
hread_fence(__ATOMIC_SEQ_CST); })
> > >       |                                                    ^~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >  meson.build | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/meson.build b/meson.build
> > > index 81ecd4bae7c..52e5aa95cc0 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -499,7 +499,15 @@ if get_option('tsan')
> > >                           prefix: '#include <sanitizer/tsan_interface=
.h>')
> > >      error('Cannot enable TSAN due to missing fiber annotation interf=
ace')
> > >    endif
> > > -  qemu_cflags =3D ['-fsanitize=3Dthread'] + qemu_cflags
> > > +  tsan_warn_suppress =3D []
> > > +  # gcc (>=3D11) will report constructions not supported by tsan:
> > > +  # "error: =E2=80=98atomic_thread_fence=E2=80=99 is not supported w=
ith =E2=80=98-fsanitize=3Dthread=E2=80=99"
> > > +  # https://gcc.gnu.org/gcc-11/changes.html
> > > +  # However, clang does not support this warning and this triggers a=
n error.
> > > +  if cc.has_argument('-Wno-tsan')
> > > +    tsan_warn_suppress =3D ['-Wno-tsan']
> > > +  endif
> >
> > That last part sounds like a clang bug -- -Wno-foo is supposed
> > to not be an error on compilers that don't implement -Wfoo for
> > any value of foo (unless some other warning/error would also
> > be emitted).
>
> -Wno-foo isn't an error, but it is a warning... which we then
> turn into an error due to -Werror, unless we pass -Wno-unknown-warning-op=
tion
> to clang.

Which is irritating if you want to be able to blanket say
'-Wno-silly-compiler-warning' and not see any of that
warning regardless of compiler version. That's why the
gcc behaviour is the way it is (i.e. -Wno-such-thingy
is neither a warning nor an error if it would be the only
warning/error), and if clang doesn't match it that's a shame.

thanks
-- PMM

