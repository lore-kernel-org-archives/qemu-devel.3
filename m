Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17514CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiko-0006z7-H5; Tue, 12 May 2026 04:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMikl-0006yW-Pu
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:46:12 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMikj-0008Mo-IP
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:46:11 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-656d749109cso2930667d50.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 01:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778575567; cv=none;
 d=google.com; s=arc-20240605;
 b=ImHFeXjBIdfH2o9H0JCxf4NVGV1XGjLyQC95SgxhGD2OCgSgzzTcbe6lGPUeq6BlD7
 Flrn18PHR7E9UvIfKkq3Cdr4Vclidldmy9NT7hyl04hQkQSarg83tVE6gQY0YlwCJs+1
 OIHWQ8dDhrWP3fHhr6T3rMtjvln0I7Q99OheyOozI16iHjbvlfxSvBQsroi9vbGuRSBT
 52obYK+xxh+rbnQ31nvMByMlO8Kq4nRzw25cHH8FG4IAT+UTxndkPtssNlZPV93UhDQC
 pku6kA1rXRxlywj0xnxL/JcZ5Jf48DscY5fcK1mZZLKoOPF0dopmxxYBfQpXu2oH2JzH
 aLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NbuCylVK/DuRauCdf9LVgP0UBnXCSCUNf6hunJ2wDa8=;
 fh=jE0Gv2UAgLEPjq4IOUwH97+atSDkuM6nkaIv6eSaEd8=;
 b=KAw/iwMlMVu13ZTGDwNo9olPnMRVYsuAHishTSX6FswiwZR+v8LCsaQgiwrQ92oJk7
 up1hVTykQ2glbA7wb37ClKWT/USCH7ZzWqRiJDS09Qtx0xseA/DDiY6o53Zz/8/AWTMX
 C8f1wVGnFpZghkn1FXpHuDISj0yDnoWURSeZVOs5e1MJtGdjdZ0LP4kTLnnq9lKLLxkH
 HKidURwRqn+l5SRNCyLD7d2z3QcABlYxNObP0zUrk5XKGPGrsFPCt9gTDKgYhnxJzFmP
 F21kfWiz7lAEikCUmcoY/cBOxd4giAKtzgojQBL2O8MHivQND1kcHm9MTT6M8b9EF18v
 G08g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778575567; x=1779180367; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NbuCylVK/DuRauCdf9LVgP0UBnXCSCUNf6hunJ2wDa8=;
 b=GKH4NWurQ/B7CzqKbOGy5OkZ90qmzeejOttu11AsywuvK48ppPGZiqaygJvs/sg9kw
 nnzmjL567C+inwfweyUsI9GCkVx8qt3BYu9Ah1BFxMlWCaQKxvwMhpNlalBXFPtqmQoq
 sIGRgMPc1ClaM2UUBnm6mXDXffQSkYW4heAeMxGx2jSIU/o41aDVRjxpDk/A9G+juCxW
 Cq4YqCaSGOPxG6vm8ohiBgtOgvNRvdlnkPfySOtJamnwN/Duqt1gitr4YC6r3miHxW/h
 dbp4TODlTnZauwWiwuqcd3ghTt3I1zqIWOQsP+5Am9DtSVa5RmVtRDhc5k+NJLRlb92j
 nvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778575567; x=1779180367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbuCylVK/DuRauCdf9LVgP0UBnXCSCUNf6hunJ2wDa8=;
 b=qnEHeFBcjm9juEvRfTEJp+FWiQ0Wy8eaFW2qHdm/+SldlMr9OSEh73/+/3mYEZ/Y0h
 KS549SedkraNaPA7Wred8GUUkAhbzdbgebIHXOMX1WaEbIZmitC0njbLDMbWXjhhqOOr
 AqwCVq4jU7HpprWwAgZwXuRIE5zIU/Dyw7Y/TgGuYJ30LbYIvkk73Cf9m8RaAEokHXaY
 ytHGdCka5OwyKNd0c8P2WKmVnsmOdRWPyI9Qx7v2Rn/0Y/F0ZkM/nAbMHFIBxCIXKq4k
 Kfp8Dg8hmzDgeuoyHxKtC8OyzPsitVg4zlFhnBix+2LqVcSnt0JDOUhTCcSt6R5OqVMT
 UqQw==
X-Gm-Message-State: AOJu0YwoNGpjGvcMaYksQwTJt47m7Zz1zcBO/wdPznIyBM6CaneU1nz+
 bUhB2scWkD7i3bgINyGK7kCxfqdnU8FIv8cQ8K+hs/2RPzYMc4eLMed2mCYqH3DErovV48CYh0C
 619BjmgiaQsza1xpez5BD605Da4YBA6QsVhuJGeXRNQ==
X-Gm-Gg: Acq92OEkNR69nPv+jTfEHLH57Zdksk60q/16i7CiTRhbQk2iOqbuOD2iFGJHDv2pGdm
 MfmruGSsTBKWsuCVLJCw54zF+SBbykKAOfNMhxS0xz1d8DQWHC9SZA/DiTbuggzGhyJT3qGWqyw
 X+wuNTtW8dClrAHytihF2Rlj/O6yMy4VPKsT/8baVz/YgTAczMrt1wRs9j44f0BaroIwgt03ObW
 4DQ6ysNSVNC5qbaGho9odzYgC7Kf094oNniFWerQS1cQKaGxteDpiUTL8xHuCn/CyorqgErof4+
 NbdOJJgpK1ZURYtHnmt0DzMZTRotgmgu5mepxnc2YCt8enXfczmQMd73dRaSPpB0STk=
X-Received: by 2002:a05:690e:484f:b0:654:5290:b335 with SMTP id
 956f58d0204a3-65de12d01e4mr1114254d50.52.1778575567327; Tue, 12 May 2026
 01:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <20260508152428.2648560-9-peter.maydell@linaro.org>
 <5618003e-a138-42de-b41e-90ef76d23aa6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5618003e-a138-42de-b41e-90ef76d23aa6@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2026 09:45:55 +0100
X-Gm-Features: AVHnY4JhkUm5SgjI_8t1zvbfXJJL-KCLxgzxsWwm4OOh6QYNeftf8uMjFx6x3Es
Message-ID: <CAFEAcA8nMjdQbRqBtJ0UAgWJcoqAkKMKJM_GZtVsCMN16TJEVQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] tools: Move qemu-vmsr-helper up a directory level
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 12 May 2026 at 07:54, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/05/09 0:24, Peter Maydell wrote:
> > We currently have exactly one subdirectory of tools, i386, which has
> > the qemu-vmsr-helper sources in it.  An entire subdirectory isn't
> > really necessary here as we have only one i386-specific tool binary
> > and no expectation that we will have many more.  Move it up a
> > directory level so it's in tools/ with all the other tools sources.
> >
> > This was previously covered by the "X86 general architecture support"
> > section of MAINTAINERS under the tools/i386/ path; add both the
> > source file and the docs file to that section.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   MAINTAINERS                         | 3 ++-
> >   meson.build                         | 2 +-
> >   tools/{i386 => }/qemu-vmsr-helper.c | 0
> >   tools/{i386 => }/rapl-msr-index.h   | 0
> >   4 files changed, 3 insertions(+), 2 deletions(-)
> >   rename tools/{i386 => }/qemu-vmsr-helper.c (100%)
> >   rename tools/{i386 => }/rapl-msr-index.h (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f2c66d7cc3..88cc1516d8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -153,7 +153,8 @@ F: stubs/hmp-cmds-target-i386.c
> >   F: target/i386/*.[ch]
> >   F: target/i386/Kconfig
> >   F: target/i386/meson.build
> > -F: tools/i386/
> > +F: tools/qemu-vmsr-helper.c
> > +F: docs/tools/qemu-vmsr-helper.rst
> >   F: tests/functional/i386/
> >   F: tests/functional/x86_64/
> >
> > diff --git a/meson.build b/meson.build
> > index 8164458eea..1dad3a2462 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4569,7 +4569,7 @@ if have_tools
> >                  install: true)
> >
> >       if cpu == 'x86_64'
> > -      executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
> > +      executable('qemu-vmsr-helper', files('tools/qemu-vmsr-helper.c'),
> >                  dependencies: [authz, crypto, io, qom, qemuutil,
> >                                 libcap_ng, mpathpersist],
> >                  install: true)
> > diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/qemu-vmsr-helper.c
> > similarity index 100%
> > rename from tools/i386/qemu-vmsr-helper.c
> > rename to tools/qemu-vmsr-helper.c
> > diff --git a/tools/i386/rapl-msr-index.h b/tools/rapl-msr-index.h
> > similarity index 100%
> > rename from tools/i386/rapl-msr-index.h
> > rename to tools/rapl-msr-index.h
>
>
> tools/rapl-msr-index.h lost maintainer coverage when F: tools/i386/ was
> narrowed to only tools/qemu-vmsr-helper.c

Good catch; we should add
F: tools/rapl-msr-index.h
to the MAINTAINERS section.

thanks
-- PMM

