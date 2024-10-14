Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A11CF259D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0IjB-00089z-MO; Mon, 14 Oct 2024 06:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0IjA-00088h-EX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0Ij8-0006tu-Oe
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728903301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeY11Wwqg0V/ezUajEATUKZkLz3dwUAERUQyPCGxFV4=;
 b=gsQISNS7t6ZBrac2kBDFfi/H6saeVIiaJXPOHhN6wnTUstEElE0+4kN0I7I1GY4wrqJ1wr
 LbX35aKmXaQDlR/PHeu7SFwKIyHgzoQcK2XgfRJa9lZw1Z1O01HZUbP2tgfnWNUECHUXOA
 U0jagT/GZDgAT/zLK6uNBRDfzbFEc0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vkkUFcUoOf6xxsjfATILxw-1; Mon, 14 Oct 2024 06:55:00 -0400
X-MC-Unique: vkkUFcUoOf6xxsjfATILxw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso1041046f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903299; x=1729508099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeY11Wwqg0V/ezUajEATUKZkLz3dwUAERUQyPCGxFV4=;
 b=N1eqfrg5h1uMWeDvVislKrpVp9GmZIlQfTryIXGqi8S+1jBwf1fhSe5KiG5WLcFn8Q
 TIRSwcXSzJt3nIgyMdZS3MxFbQ/I+vegcjHpKJ9rjTPP6epvFO1gOMbS4HryDbn+dq33
 6vgyxD/C8znsysnOksXQRsimvs6GU1664YI5Ssbp9oJMpcQfq3F6NVBLnebe9YguypIs
 eVO847Nt2SBgmRrURao6IpT2aKptbhacl44HBJ06dLuE+5iTtnljjNguQiKU7t3H9gk6
 RMs+ghjEM3b3OF4E3uUbXCnabZjOtVzyvykE5hYV9q5zMbu6CeOl2/x6GVKFsvSA9UtZ
 sFCg==
X-Gm-Message-State: AOJu0YxX87osv7Eh0ihnz/KwA0fCxr5LGf91kJd/PqIigHBZLIqfRF9T
 N/QY1IZ99WBWc62EFEevrWvFGpZgeghyvlM0+MFqj5in//fN/ERFdQHE+QgJeuq8NLS2u1oZr4g
 KhO1EwyE0jU+lxXqqYnEIiX7v4PTuQD2nDibM/s6FW3L7dfwntwIJPRxYVib8KoFUfqXVGepgKb
 LVoj10HTY6AedSVH2ZCMoUy9qEnew=
X-Received: by 2002:a5d:5708:0:b0:37d:4fe9:b6a6 with SMTP id
 ffacd0b85a97d-37d551f2dbfmr6852303f8f.29.1728903299027; 
 Mon, 14 Oct 2024 03:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKUq06Az1rjZxw9lp7oV1Eavu7jys7FE5efnoIipG7ODVMk9Q758fLmIhpbNMR1S+Z9mpkmfw8G+TOsHKyQ/8=
X-Received: by 2002:a5d:5708:0:b0:37d:4fe9:b6a6 with SMTP id
 ffacd0b85a97d-37d551f2dbfmr6852290f8f.29.1728903298634; Mon, 14 Oct 2024
 03:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
 <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Oct 2024 12:54:46 +0200
Message-ID: <CABgObfZXiYjRdJCeRewPho_Py0R+qSaXTGdK2_Sib3yTEzu_2A@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 14, 2024 at 12:40=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 14 Oct 2024 at 11:12, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > > v2->v3: new patches
> > > - scripts/archive-source: find directory name for subprojects
> > > - docs: fix invalid footnote syntax
> > > - docs: avoid footnotes consisting of just URLs
> > > - docs: use consistent markup for footnotes
> > >
> > > ----------------------------------------------------------------
> > > * first commit for Rust support
> > > * add CI job using Fedora + Rust nightly
> > > * fix detection of ATOMIC128 on x86_64
> > > * fix compilation with Sphinx 8.1.0
>
> > Applied, thanks.
>
> With this applied, I find that on one of my personal
> local dev branches an incremental rebuild fails, because
> meson complains about not finding a new enough bindgen,
> even though I did not --enable-rust. Meson also complains
> about a bogus coredata.dat and we end up running meson
> three times before it eventually decides the error is fatal.

The report of coredata.dat is just a warning that it's not able to use
any cached data, which is expected when bumping the Meson version.

It's definitely going in the "if have_rust and have_system" path. If
you have the meson-logs/meson-log.txt and meson-private/cmd_line.txt
files, they can help debugging. I'd expect a "rust =3D disabled" line in
the latter... but yes I see what's happening. The

  test "$rust" !=3D "auto" && meson_option_add "-Drust=3D$rust"

line is only executed when configure runs meson. Here it doesn't, and
Makefile just tells Meson to reconfigure itself. Meson then gets the
command line options from either coredata.dat (which has everything
cached in Python's pickle format) or cmd_line.txt (slow path when
Meson version is upgraded), but neither knows about the rust option;
and the meson_options.txt default is 'auto'.

To sum up:

1) this is specific to incremental builds

2) this is *not* specific to the Meson version change, the
coredata.dat warning is a red herring

3) this (mangled) patch would fix it:

diff --git a/configure b/configure
index 3e38a91616a..8a9a4153310 100755
--- a/configure
+++ b/configure
@@ -1987,7 +1987,7 @@ if test "$skip_meson" =3D no; then
   fi

   # QEMU options
-  test "$rust" !=3D "auto" && meson_option_add "-Drust=3D$rust"
+  test "$rust" !=3D "disabled" && meson_option_add "-Drust=3D$rust"
   test "$cfi" !=3D false && meson_option_add "-Dcfi=3D$cfi" "-Db_lto=3D$cf=
i"
   test "$docs" !=3D auto && meson_option_add "-Ddocs=3D$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add
"-Dfuzzing_engine=3D$LIB_FUZZING_ENGINE"
diff --git a/meson_options.txt b/meson_options.txt
index 2211f291b2d..fc6d5526d58 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -372,5 +372,5 @@ option('hexagon_idef_parser', type : 'boolean',
value : true,
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3',
'4'], value: '1',
        description: 'tweak required x86_64 architecture version
beyond compiler default')

-option('rust', type: 'feature', value: 'auto',
+option('rust', type: 'feature', value: 'disabled',
description: 'Rust support')

and I can send it shortly; fortunately your tree never got a working
coredata.dat, so it hasn't stored anywhere the rust=3Dauto value.

Paolo


Paolo


