Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1DDEC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMBZ-000748-Qr; Tue, 03 Mar 2026 04:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMBY-00073w-NP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:37:00 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMBW-0006mz-VZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:37:00 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so5447099d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772530617; cv=none;
 d=google.com; s=arc-20240605;
 b=Fh7Yg5TO4m3YxnBLUch50IAFYlyNO4nkaWssnMc4ft/sMlh1UxgzZRTPpjmZj2wez9
 fA4VxltupYVeYFg5yWKWJUJdIMZJFzal8UfN5KWtuwRilYKlGVInZKLgCsWtUXM3UsOr
 rumX3ksTrMF0AEzUFjBcofc6Z2zJum7VRxvdSCgsDm4NLgPTCjaF7c/EDDiOCwJCmhiO
 UpS63lWcQXcwsD9w59NbQOh2tRfcP4nQX/xs+S/wOVb7j4r6956ZUvaxdt+aFhi4wWX6
 iG1ltqV2OEXNSn1EdBYHwpNthpoRp+PUj9ck+g2jdvvV5SOq73j4wzmN6apeE9u3giSc
 W14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Z579mPIkYLbS99wjxmFE2PCWQSeBFbwTR9I3S4A6Ls=;
 fh=3cXQUpVpbgpdFwjiRkk/INs2iN57YIx31vKYsn7+X2c=;
 b=GlH65ehpvZCLaYjzk70+vKGJsAiOzVjvykUGBgaeJ+ISBlcbg0qLfpwar3032SsCC8
 595iUN6sRTrHIcxFFLXx2kJkvYegvW4C4EsG0hX8vU0Awpb7g7UPCZkXezLQsH+nZtaf
 /JP5ojjtIqRqTYFe1aFq1vwnHdHr8vjDKZH9B2C7x+5o8+w/9BC2u5bS7SKZ7ldJDAUq
 9vcb3r0ebYHgTT1lrlnNXUJ5Ln437W5Tm1p/8uBNnaLzshK4LWttphOIJ5tO25rCoXV8
 DXWVXZSU4Jp7/kpoTvwpnY4TiYrj8oPxQ3wUbWquScgFGIQdfD+yYagr13fXZjUk+6vv
 7PHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772530617; x=1773135417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Z579mPIkYLbS99wjxmFE2PCWQSeBFbwTR9I3S4A6Ls=;
 b=Gj8LqdA+r41oYFKQAq4rOvBfunIV3t/dwvIyk+R4WMjT8N4tp797EQCDKxuK4eOFde
 g+w2c+18F0Y6lTMk4Ub2o3ZFL4OjrUbgogB9sjR+1s0rMsD1Y3n7xQJO9zmt2iLHwrqU
 zzJvl29nnbrkr1K65GrxaVp6LXVWcD9r2jObszh9tZjx4Apr49vztit8Pvl/iHjARI6S
 VTz9eViRwnWsOlnVu5xz4kmdSXZJQNOqge2lw49m2kzUDJBm66hdpRfn//b/+Vdy8Rhv
 0ZYErm8csFC7w/SdjZq0XUZD/tJHQerSVoCwUG4NodFSSeaigYepII6SUuPe9jg0UCxZ
 +Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772530617; x=1773135417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Z579mPIkYLbS99wjxmFE2PCWQSeBFbwTR9I3S4A6Ls=;
 b=T2O3uUyu1tUcacNEVXhglDAqNBFmx+GN99yNfDpzGF0bs7XvfdFgvaMKlJ0G17/BbT
 KC5cN4mAyA8RePfdiyJ4xEt/kJ3QoV4zU5tKcmxrZ8w7SORYk5qliDE64Itjdv4yOmnp
 TdfJJA1KgF/W8XPg1pWyAOBzo3DlqTJvPJE2Q4moprN0U4ZtT6t1IIWIM16ApRknNYUq
 9y+xceK4SPCeVlvIaAKsuG5LzeWfiSjFRExQ4brx+VwxQS36oUOalXolAaMgfd6XWV2F
 jiomwynY0cabIFTlDnqg6NB1uhoaQuqPBvPYJqy1opapqlf0YkCuyd83OivrIW1pbNKb
 31xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYxCLWncSNKg/oQ2+SCvs/7RNqxIGokk5zGMRAhb6PCG+9yMRXyJBwtPLwfG10IodWFrvLkbr/FbKA@nongnu.org
X-Gm-Message-State: AOJu0Yz/4A7C/o4gOLEL8pNUlE5ptx0Xnryu/ytT+/vosLatD6jh9oAH
 rzFsHOLNJKHLd7rWnIafMCeDJ9L2E3LAlHhQzfw1rGFSLmT3kSoDggziSmeYsdu/i39WP1G+PdO
 kq5IkKns61WvqGnFD03YSasEkzNx36bHrbC7sA6okLA==
X-Gm-Gg: ATEYQzwTPJNJmgN451MOCM+3Ze79pP8mUfb4Uj8a22zzRisjwVjjlaATxG9IPU+Oi7/
 4AykAEmD4GamPabWUVJUmZQrmUeWLiUzv9BTkMcNpQiI2+TmB2k2nqGC2jOKXcgPLPjEIhTNXzE
 /GJS9nT0n4sOYOyk8V++hFvSfwiswpgk0lc50mWoOF7BNOT3Zdz5VvsrVxkfNPpA3bqjQ3MPtxL
 rPWhFKPmSg7TnPQxXVuCdsGZqJufoK92su6Ws7Reg8wGnyjh05TL+/t5jBH97a3syVjyCaJFp3x
 Pa2OAnP1Qw7hXFRx+PGdEfRDc98oFwbrmS/ZAYxL33hKxJmvMChiazjRkHBFfMc5yd4=
X-Received: by 2002:a05:690e:2002:b0:641:f5bc:6990 with SMTP id
 956f58d0204a3-64cc2326cfcmr10695075d50.76.1772530617534; Tue, 03 Mar 2026
 01:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <aaadd0B4kP9amEbz@redhat.com>
In-Reply-To: <aaadd0B4kP9amEbz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:36:45 +0000
X-Gm-Features: AaiRm50MQ0M52s-hxH7dd02lqRM353JcmA4Hbunk2zoLPMk27CB8eHmG7ikN5wA
Message-ID: <CAFEAcA_YMukxSh0YWsxADasT69BZ=BR1Q1NkGeGWzjXQoUifSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 3 Mar 2026 at 08:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Mar 02, 2026 at 07:20:54PM -0600, Yodel Eldar wrote:
> > From: Yodel Eldar <yodel.eldar@yodel.dev>
> >
> > Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
> > clang if available, otherwise disable the treatment of warnings as
> > errors.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > ---
> > Hi,
> >
> > The previous version only disabled Werror whenever `--skip-meson` wasn'=
t
> > used and the build occurred in a git repo, but this change should
> > probably apply to all types of builds. So, let's use meson_option_add
> > to globally disable Werror instead; IIUC (and according to my testing),
> > this will override the value in config-meson.cross.new.
> >
> > I'm still not sure if we should be disabling Werror for ubsan, even
> > though it's not currently breaking builds with GCC; please let me know
> > what you think.
> >
> > Special thanks to Peter for looking into the cause of the reports aroun=
d
> > this, for sharing the findings, and suggesting approaches to resolve it=
.
> > I couldn't pick one over the other, so I went with using clang when
> > available with Werror disable as a fallback; please let me know if you
> > think this is an XOR kind of policy decision.
>
> In the bug
>
> >
> > Link to RFCv1:
> > https://lore.kernel.org/qemu-devel/20260302210039.261325-1-yodel.eldar@=
yodel.dev/
> >
> > Link to mentioned discussion:
> > https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn=
7jx2J9erBA5DLBw@mail.gmail.com/
> >
> > v2:
> > - Fix misnomer in commit message
> > - Simplify condition by using the same variable for all sanitizers
> > - Use meson_option_add to disable Werror
> >
> > Thanks,
> > Yodel
> > ---
> >  configure | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 5e114acea2..e457e8a17d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -762,6 +762,12 @@ for opt do
> >    ;;
> >    --wasm64-32bit-address-limit)
> >    ;;
> > +  --enable-asan) use_sanitizer=3D"yes"
> > +  ;;
> > +  --enable-tsan) use_sanitizer=3D"yes"
> > +  ;;
> > +  --enable-safe-stack) use_sanitizer=3D"yes"
> > +  ;;
> >    # everything else has the same name in configure and meson
> >    --*) meson_option_parse "$opt" "$optarg"
> >    ;;
> > @@ -771,6 +777,18 @@ for opt do
> >    esac
> >  done
> >
> > +if test "$use_sanitizer" =3D "yes"; then
> > +    if has clang; then
> > +        echo "Sanitizer requested: setting compiler suite to clang"
> > +        cc=3Dclang
> > +        cxx=3Dclang++
> > +        host_cc=3Dclang
> > +    else
> > +        echo "Sanitizer requested: disabling Werror for non-clang comp=
ilers"
> > +        meson_option_add -Dwerror=3Dfalse
> > +    fi
> > +fi
>
> GCC documents the possibility of false positives, but I would consider
> that caveat to apply to CLang too. It may simply have different false
> positives or at a lower rate.

I'm told that clang/LLVM doesn't have any "middle-end warnings", so
it won't have the same problem that the sanitizers might change IR code
in a way that results in a warning firing that didn't before. So I
think this "sanitizers change warning behaviour" is specific to GCC.

> If using sanitizers, it is expected behaviour that there can be false
> positives, and if the user doesn't want the build to break as a result
> of that, then *the user* can choose to disable -Werror with the suitable
> configure warnings.

It is expected *for GCC*. I don't think it's expected for LLVM/clang.

-- PMM

