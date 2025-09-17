Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3561FCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uytuE-0006kj-7T; Wed, 17 Sep 2025 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uytuB-0006jo-1T
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:17:11 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uytu8-0001NJ-Ss
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:17:10 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-412a2fe2f36so135025ab.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758122226; x=1758727026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z++9jssCH6EoRAApc3kWYP+ce0n2oLNrIk7ZhaO1EH8=;
 b=Z2MuFI+UW9pqgWx5QONY++xa3P3og9QVfKOBPUfsgnyEoXlvD3xLFLvpOl1qJtAtfH
 EWq+yOk2SwLmJmOmJw5LoOblElT5lMUxvUJXR+VCjxKzjiM9IzscOforE521lxhacr/e
 MvjhBQ1JVc4l58Qu4IgRI11Ycmf7eya2/xQgkbA9pPWJb4pKa+5y09Oq8Z4N077zO4RX
 xmMbzB2Q2dfGPubkrMugluOEVnpmJVEZpstKw/VBdEm0Xpe8lCDTVHAKFs33UQpnbn3f
 Up+a55AlfIZ7+qlEXC/vsC29CKcoYetFJRNvbomkx9bGG4xCmnSZ3aSScnx23egyQLU8
 gd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758122226; x=1758727026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z++9jssCH6EoRAApc3kWYP+ce0n2oLNrIk7ZhaO1EH8=;
 b=QrTvDpE12uxT80ZJgh/aUa9Ybej6wq/NjbWTvF+QXwcAz5SkR16VT1KiNJq2rAjwBJ
 LOq9ZT1fKMTFJC2DA/Uz48a1Xo8mHzNNSTS+pX76Ihcz234iqNDFN8SZpyFaPeQmvJoG
 IWuf1JBJw75uij2no4Lw6nkeXIIjkb4PWC0Qq5qG/p+tI7IFf8Y7jpFJmPMruKVgXIB6
 8VrbRM8iYc/Lxw48QTvaHujIRKqZgaJ0FFHdqoAMjtJTdvyLWlZsHgHcJO3zyykbU65A
 f3wsBfx+ygwYedpTazd9YOcacuLM2rsKXVTQwDKOAf5/i0NPHdH/Qe13H0dwN6NrwERJ
 XFVA==
X-Gm-Message-State: AOJu0YzMNcqEAojcnfI5/GH0RrmOEBhmIIoMWogTzKgRx+b6WCghtEsl
 qTqUgUx7vY+oj5uwamtcDEKSBq1HFdVfs3DG3LBHBoBFw9nQM2BZvI7dyL846b5PCcXu9lhHGG4
 vlTnXy0Rz3hhd1IauLWzBqf7RjBQqh1Ia5KBcuSM5
X-Gm-Gg: ASbGnctiZ8/jMdSFpYQqVxzK8vPMRxqAgpE+zR/OjwsxacvnfZmsYSpWtJM5qr29CBk
 FqpPtw8+2gHUWYrdvyn4oIv0qcpqDSZKYXpqD9q3qn5Dn0nahP4GPmk4lTpSplp9+k/+bpYQFQX
 KC1BARZr7lEtDkCYb5/571C0UPvVCepyrkYrkMzLzKafMfMXo/r6hKiARFo0nwRlaMYR7Tn8Mq0
 TMLWnSfNN55JxL1vKnz+kdYikpFg0PQNmQzXkP1X8PSlS4td1b930o=
X-Google-Smtp-Source: AGHT+IEoUI0C7HeF/sEwxPNWvTKL7gcrdFJeGzi5+ZyXJ/PyZn5qn5Z6FiDRsSUZkXgjS5huBpFAR4mkQBS9JSisW+o=
X-Received: by 2002:a05:6e02:1a07:b0:411:650e:654b with SMTP id
 e9e14a558f8ab-424186342e5mr6682585ab.12.1758122225540; Wed, 17 Sep 2025
 08:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250916165928.10048-1-nabihestefan@google.com>
 <aMp-MzBE19NORy4Y@redhat.com>
In-Reply-To: <aMp-MzBE19NORy4Y@redhat.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 17 Sep 2025 08:16:53 -0700
X-Gm-Features: AS18NWBt2yNC7rlDNhJrYCCuYlvXxhEwCUJ3bOB2KveHF3tiImRmX8LwxZ4o1q0
Message-ID: <CA+QoejWaM+K895k=WcRndq=BNe1kNfJ4L5APKyk4+GHhmQLD0g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

We ran it against an internal patch that we were updating, so I can't
show you the patch.

However, the difference on it being affected might be in how we're
running it? To check
against just the changes being done in the specific patch, instead of
the whole file, we
trigger it by running `./scripts/checkpatch.pl --branch HEAD...HEAD^`.
Could that be
why it's triggering against existing files?

Thanks,
Nabih

On Wed, Sep 17, 2025 at 2:24=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Sep 16, 2025 at 04:59:28PM +0000, Nabih Estefan wrote:
> > When running the license check, if we are updating a license it is
> > possible for the checkpatch script to test against old license lines
> > instead of newer ones, since the removal lines appear before the
> > addition lines in a .patch file.
>
> While we match the "SPDX-License-Identifier" text in any context,
> the "file must have SDPX" validation is only performed against
> files that are entirely new:
>
>   # Called at the end of processing a diff hunk for a file
>   sub process_end_of_file {
>         my $fileinfo =3D shift;
>
>         if ($fileinfo->{action} eq "new" &&
>             !exists $fileinfo->{facts}->{sawspdx}) {
>              ...raise error ....
>
> > Fix this by skipping over lines that start with "-" in the checkpatch
> > script.
>
> A new file cannot have any "-" lines present, so there isn't any
> bug that needs fixing AFAICT.  Can you show any patch or commit
> where this would have made a difference to what checkpatch.pl
> reports ?
>
> >
> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > ---
> >  scripts/checkpatch.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 833f20f555..c57a423f9f 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1813,7 +1813,8 @@ sub process {
> >               }
> >
> >  # Check SPDX-License-Identifier references a permitted license
> > -             if ($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*/)?\=
s*$,) {
> > +             if (($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*/)?=
\s*$,) &&
> > +                     $rawline !~ /^-/) {
> >                       $fileinfo->{facts}->{sawspdx} =3D 1;
> >                       &checkspdx($realfile, $1);
> >               }
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

