Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79EAC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scM9I-0007AF-SQ; Fri, 09 Aug 2024 05:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1scM9C-00075S-7S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1scM99-0001i0-Aa
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723196574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7toFUW0d7oD6ChtLu69bkrvZQEmYJ5me+ufe81DvD8=;
 b=FAw7Twmu9+6WYuf1vNDCZG6tccmdorKluqrEq6YCV8nOSGWCWTgmDasLKRaJAVQRG0si3A
 zV6SD0JxHhM7fm3NTXS/5142nm9ysP73n9hj3hpuA0VjKgRD6M2GUKO7AnWGm24nTuqlZp
 ZrFd3my///lSeLxv9TeUC4FeVBKh038=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-TGJ8PlCdOFGNIt9qPCX2Tw-1; Fri, 09 Aug 2024 05:42:52 -0400
X-MC-Unique: TGJ8PlCdOFGNIt9qPCX2Tw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42820af1106so13115555e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723196571; x=1723801371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7toFUW0d7oD6ChtLu69bkrvZQEmYJ5me+ufe81DvD8=;
 b=q5GJ5kdmlGLymrTf8RoCtiBgUfVZx3PAjCMxxMC4Cjl0500pVaB08BZCEih6qU4qny
 UZk8s1TNNn4CAbXIJ3zZhgJMVRAg3+J2TOiTScedqaOBYHJ5EoRb3ZzOne3WWamZ5cah
 liWe/Dx7EBInL6difAgatCB+BMDtqNUFxqeLtEKNR/wtXCtI0Y91+yh8von5oa46BmYO
 yQyHbhSNz5eei+P5X7TZYtuNEFMRT8fxtk8uuFk5CcsIGbPC9ntHckoZNmbtPrMyAp0V
 iRBrHdYflLNBjkAc4nLK2lefts1JHbxbOuCzDKBUxlBi9IW5GyKUAvztNGa+xGqgEhXc
 w0Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2NwvSfF5AsKGuHgaXFXQH1MyZ6NoIeqOK0XqwsnaaVZzSNXOd3aFbrfTS50Za+nGHp6gVL5gLOlGgcvWr/PCfswavMU=
X-Gm-Message-State: AOJu0YzavSrcDo12nfKllSkgdM5RDOjr+4PdLZ6jARcNRWBLy0nnGw8j
 XS3tqoEE98OPAEKo8inFeER+SR4lMXUKB6f2qGEH3nRAP/UZH7wV8Y/MNFNxosG1b2XwyFv7Ed9
 wkB0dA5ed+RnmSiNrBHE6Iw7ecYuk/URLj9uzYChv8w5wTbl85LH6vAwOOyw9MoQ8GkzYKM3OTp
 WxyyvVhpBbQFxH/5A2ikSBRZiuDbc=
X-Received: by 2002:adf:fe8b:0:b0:367:8383:62e2 with SMTP id
 ffacd0b85a97d-36d5fb92ebemr570332f8f.29.1723196571084; 
 Fri, 09 Aug 2024 02:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsLMTVClWQmFKeZDsbH/wZrnMAyX636jcuedrbx/C8VkIwuxvXlrRioGAn+8AH4xZuTTl6rznR5sDz1ou7VA4=
X-Received: by 2002:adf:fe8b:0:b0:367:8383:62e2 with SMTP id
 ffacd0b85a97d-36d5fb92ebemr570314f8f.29.1723196570614; Fri, 09 Aug 2024
 02:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
 <9080f7e5-a40d-4cbd-a734-74578dd27894@linaro.org>
In-Reply-To: <9080f7e5-a40d-4cbd-a734-74578dd27894@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Aug 2024 11:42:38 +0200
Message-ID: <CABgObfY1hGKhBjwjDeKSSd5uxbe8Lc5=hVL6psB0NLbnX1bJ0g@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Octavian Purdila <tavip@google.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, stefanst@google.com, alex.bennee@linaro.org, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, crosa@redhat.com, 
 bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 9, 2024 at 11:30=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 9/8/24 00:30, Octavian Purdila wrote:
> > On Thu, Aug 8, 2024 at 2:56=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
>
>
> >>> diff --git a/configure b/configure
> >>> index 5ad1674ca5..811bfa5d54 100755
> >>> --- a/configure
> >>> +++ b/configure
> >>> @@ -956,7 +956,7 @@ mkvenv=3D"$python ${source_path}/python/scripts/m=
kvenv.py"
> >>>   # Finish preparing the virtual environment using vendored .whl file=
s
> >>>
> >>>   $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
> >>> -     ${source_path}/pythondeps.toml meson || exit 1
> >>> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
> >>
> >
> > Hi John,
> >
> > Thanks for reviewing!
> >
> >>
> >> I haven't read the rest of this series; I'm chiming in solely from the=
 build/python maintainer angle. Do we *always* need pysvd, no matter how QE=
MU was configured? Adding it to the meson line here is a very big hammer.
> >>
> >
> > I think the minimum we can do is to install it only if CONFIG_ARM is
> > enabled. That might change in the future if the models we create with
> > pysvd are enabled for other architectures.
>
> Similarly on how we manage libfdt, you can have meson defines
> SVDGEN as:
>
>    config_host_data.set('CONFIG_SVDGEN', svd_gen_header.found())
>
> Then declare SVDGEN in Kconfig.host, and finally use in the Kconfigs:

That would force people to install pysvd on the host, which is a pity
for such a small and little-known library.  We have used submodules
in the past for much larger and common dependencies, for example
capstone.

Paolo


