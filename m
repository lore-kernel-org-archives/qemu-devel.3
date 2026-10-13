Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C85CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGa8v-00063r-Ie; Tue, 13 Oct 2026 06:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGa8s-00062Z-TM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:53:59 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGa8p-0006JS-Oa
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:53:58 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15354aa70e8so197231c88.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888832; cv=none;
 d=google.com; s=arc-20260327;
 b=eyjXzleZuXPrmfnK0x6yRa1TzPU06KLJr5N3jmGrOSA1tBD5Ho/4nkcE6Ih5QmyUsx
 yKvPndyKqrW1qV4YWBc0rS0h7EPbBkr2RduOijAN5z28FvJaB6LW9e6dKFZTgrK8dCPU
 HmqdQGiRW18TRnyL0Pg3q/WXLKUVt/Dq5nBfS4x2ibPI78sCojUyKMn9RuFmyzD4QaLn
 KUyIlvAxivMB3gDUYlWRUBlgyH3Ffi21dFlCThBw9SfnYxF6SmqskwXeGu/1fXQnad+q
 BstgHSFwvaUP6+8NyvrW2xjknaIUdrGHjXFCGXxPeuc/1Xu3g4aThxI3J/0dblymIMTu
 HtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XLgdgBHjd0Yu+m2sHKj2XphKze2BC0+9iUIPwPtxwJ0=;
 fh=uZtXeOWea64wQW1rEejrNm3IvfSqIbbCqylHEt/o6Lk=;
 b=i0eXhDa5zfPp9e5NY8hXPCgulUqh9ogSfxw23SphvrHY1BtJRleJU4tfU3xNJNz+Cc
 1PoWIPkAIGP0qunPW4mrsdu8e/kk4cRiKeMwmNO3tE0UcftDrl4kiecIIZftL/iwAqJ9
 OJDoGCXpaHWFcRxA8mTxkgXj78d91ZuDDPStQnwaiGXGd0TV8KswAjgMPWovYoIghZoV
 9Hn9MZKpNnpt5HWYQX54NbLYKC6xFu4m+zONUqLoZJZ/XSMyTRVvZwc6onJxCS+4Bhad
 VIpXF7L7jmzHYUbL5LCcwIb/v/8DU/S8efT7Wr3foU2z1Zn4pftVrw9/u0TYEJUe6Uuj
 YzJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791888832; x=1792493632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XLgdgBHjd0Yu+m2sHKj2XphKze2BC0+9iUIPwPtxwJ0=;
 b=a+epzVtYwKdq5kHMkqlev7LW6tzmjbgS4fK0UrkEOWcdVo6qkpD3cvWYHWiIxATVdK
 AizytUpwoxGZjFFSkjwiNApAVPTOi1NWo90RxE81UIXIUOUOJuuERmroHXCba8VeVEVb
 21XpdGs2+yRbU0ePzBVGHPmLApMOP0qFWbqI6ouAEQ2yGsWEHQqbD/0tlcqkDShOYkIc
 06PTk8YzehJCLtvPkIq4ODlw4SmDyS8NaZeKdf9oRMg6chg7Bo3yHA7TbEeNTK3Ua8GB
 iTZYafdK5/PuXEbEGI6Pz9J8oKz4iSgE7ccecI4Ul1yPzPogGNfPu0oJxHIZ0caJju3H
 EwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888832; x=1792493632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XLgdgBHjd0Yu+m2sHKj2XphKze2BC0+9iUIPwPtxwJ0=;
 b=rF6eiisTfBcBeQmeux6tyaS0kJdOMt1CVuml9oJ92nE7vPh4j8ocdwdGZDt96Qn9fX
 67AvQO99aDnqT5092jYYIVYRRQ0QVG0U3zlhr84aUURPIl2mCpvAxKKcPSXggmF7lP+S
 U+SxjFnluP/JoMpVy/f5inUqYvIQdPpPwfEz41cE2NdzZiNv1yvNBuvSw6pn/87uK5k4
 rqPAcjBSGO66GBtFSf32F8D43fHr6iPPMQUKRnOI6B7WcbJUjloUVm8K5TEbbUszHcFX
 YTCWPMwp9HzIFQ+8e3O6QamtvclQym6J2utLYG97kkoiCQc0/urj2ntztHnoBXpcDg4a
 siAQ==
X-Gm-Message-State: AFq9FYIMR0ZcAZw9dLFOoc7qOQXDswdy7mMkIefgws8IQps/QTZZnvuj
 n1uqJsV81zwND2gwhs+G62oB2Obq1+wp9AUKgXWuMooX8ZgFT47feJMDEu9lG6gKpCrP8/d/kNE
 y1Tq+zYEk2cVE1BSpnlacGHdzQLW8LYzSbA8P
X-Gm-Gg: AYBFou3VEe7VblG77HJ88SMgDCjeRxUNXilT/Joybrcd8K2d0G984mgWnI8j1ZVrxYW
 2TErGMEH+bUbkRYConuh1jHFDaP2HrQvY0opc0VxDdApE/V1sG+QHBDCChPV8cWrON7LFB176cm
 rgyhIjCmc8hC509A7GSz1H06ZR5uy00E1Nmt1NF0jcruNne/PaW42zFpgnPfvABpsNnb2UlrEls
 /Q0sJMsCU9Xtv/RYg+j464DBF9g5xMRFthmg4J0c9fkExMQzuo5O0LTOXmKhJFdahLPyhrq2qjk
 7C8T5V50wOP8E1V9CAPIXdr0REiiWbmkVutOlaBEKxNzc1mJ13JOm6AlICZW1IzsYaSma+u7oHQ
 kjWpN+8u1/hg=
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id
 a92af1059eb24-16a612bc1e8mr18914079c88.39.1791888832196; Tue, 13 Oct 2026
 03:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260707202640.2099841-1-marcandre.lureau@redhat.com>
 <CAJ+F1CKkLdzMbutap633LkU=hKWPah-zrJD3WTohZZvBUK-19Q@mail.gmail.com>
In-Reply-To: <CAJ+F1CKkLdzMbutap633LkU=hKWPah-zrJD3WTohZZvBUK-19Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 14:53:40 +0400
X-Gm-Features: AclHuK_Exq8xsUSFx7QESa5SXqrsbrmQx489BKxCtZ3mSj2zJh2mvs2hDek1CCA
Message-ID: <CAJ+F1CLL57WQUtF2CjiN=3EupsPzfa3ZdsW6ZiXZAiU=XbCZNA@mail.gmail.com>
Subject: Re: [PATCH] meson: detect bindgen and LLVM 22 incompatibility
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1235.google.com
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

On Mon, Aug 24, 2026 at 4:34=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Paolo
>
> On Wed, Jul 8, 2026 at 12:27=E2=80=AFAM <marcandre.lureau@redhat.com> wro=
te:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > bindgen < 0.72.1 linked against libclang >=3D 22 generates opaque struc=
ts
> > for C types declared with "typedef struct X X;" forward declarations,
> > common in QEMU. The struct fields are missing from the generated Rust
> > bindings. For example, with bindgen 0.71.x and LLVM 22, a struct like:
> >
> >   typedef struct VMStateField VMStateField;
> >   struct VMStateField {
> >       const char *name;
> >       int version_id;
> >   };
> >
> > produces:
> >
> >   pub struct VMStateField {
> >       pub _address: u8,
> >   }
> >
> > instead of:
> >
> >   pub struct VMStateField {
> >       pub name: *const c_char,
> >       pub version_id: c_int,
> >   }
> >
> > The build then fails with:
> >   error[E0609]: no field `version_id` on type `VMStateField`
> >   error[E0609]: no field `flags` on type `VMStateField`
> >   error[E0560]: struct `util_sys::Error` has no field named `msg`
> >
> > Check the bindgen version against llvm-config at configure time. With
> > -Drust=3Denabled, error out; with -Drust=3Dauto, disable Rust and sugge=
st
> > the upgrade.
> >
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>
> iirc, you told me that the patch was good. Can you add a-b/r-b, should
> I take it through my tree?

ping

>
> > ---
> >  meson.build | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/meson.build b/meson.build
> > index 164328ded83..c965cef352e 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -125,6 +125,25 @@ if have_rust
> >        have_rust =3D false
> >      endif
> >    endif
> > +
> > +  # bindgen < 0.72.1 generates opaque structs for "typedef struct X X;=
"
> > +  # patterns when linked against libclang >=3D 22.
> > +  if have_rust and bindgen.version().version_compare('<0.72.1')
> > +    llvm_config =3D find_program('llvm-config', required: false)
> > +    if llvm_config.found()
> > +      llvm_version =3D run_command(llvm_config, '--version',
> > +                                 check: true).stdout().strip()
> > +      if llvm_version.version_compare('>=3D22.0.0')
> > +        if get_option('rust').enabled()
> > +          error('bindgen ' + bindgen.version() + ' is incompatible wit=
h LLVM ' + llvm_version + '. ' +
> > +                'Please upgrade with "cargo install --locked bindgen-c=
li@0.72.1"')
> > +        else
> > +          warning('bindgen ' + bindgen.version() + ' is incompatible w=
ith LLVM ' + llvm_version + ', disabling Rust.')
> > +          have_rust =3D false
> > +        endif
> > +      endif
> > +    endif
> > +  endif
> >  endif
> >
> >  if have_rust
> > --
> > 2.55.0
> >
> >

