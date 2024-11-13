Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5636D462CA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFnt-0004be-34; Wed, 13 Nov 2024 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFnr-0004bI-BG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:01:12 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFnp-0002pg-5N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:01:10 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso9095039a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731513667; x=1732118467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cpSkhn6CgOU/dsVkDrTFmJPcV4OXcaexszkzUHJeQ74=;
 b=HnGuerVk9OKeOzcQq3/Cn31u/SRn+/yYzXJZnuCutkkrkpO1DeTBCwOg1rMfBUizWI
 q2CeO9w9HXLM/M2aUtu2IaY6EskJ7rOycNilrbhM+bnTNtVfCwWITfL2d4ZsbinbFJEu
 rtlIOk+fMSGP0ufmsHehPTtKFHKFfWMKwMtSb7HAl6Re5463PTTGI17WOfIVPxFKleqs
 Q8a2WOJBs7uiZ6NClgoDyQTsk8Hat3hAcEr5TH4tKHp51azn+MXE7JlLg2xS16TXo2+0
 n4UiNjWyqXPxEygg8hi9ubAAY4IhJgWe3t9N9O/yjVY3VJrfBmIGi4xD95jeIN99KDZw
 GN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513667; x=1732118467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpSkhn6CgOU/dsVkDrTFmJPcV4OXcaexszkzUHJeQ74=;
 b=Vlv4d3QmJsRiYqnByYd35Lr1FayjgwLWjUgtR95afMQ0swz56sJztlkwFVcO77R63B
 AJybU7VFL5z2mKuI97TWp8Wetxdiiqo/UXAA6qFGGeWqnMAdTwJTgApwhGljhCDyfW2v
 9U6vW+ZpU/axuHa5DCwCzkgWl3vv9VUYQiIhcSXYl63ESYodfct7hTII5khivACdqkCj
 +8hv6WmqFjpYTsXMnfsvbd3NCsluI4v1rDIfR6PkVI5Lp7cRwCD28hdpyGO42DceK0jm
 kGP/GuQARiNofFFPAUPlTOTVRgRJA5JfvRSvtuwlkqCJPLqr4YKhWiKVsZtcJngnPG5F
 Nexw==
X-Gm-Message-State: AOJu0YwtbIRZzN+scKnHFEgYjaBhMDC8FH7Td5JQiEeJ+rgd5MIdiuGt
 wa+sRIfvmC8jiYC11SMYvq6kptyPkjcYlLWx88D3p5cpfSaObXyrwnxn8mfiCMDXYrUbLUkkXey
 dvV16x28w6DntB6bcOz/8q8yVaSOyIcbAxXFLYg==
X-Google-Smtp-Source: AGHT+IGCujIKtFED8XpntsAD3w2lT+JxM5KV77C+yIQjMNjsQpq/LrpH5sNnu8gw6tg8XXfvsURnOlDJeMxCqAoZZEk=
X-Received: by 2002:a05:6402:2109:b0:5ce:dc8b:615c with SMTP id
 4fb4d7f45d1cf-5cf4f34fea9mr5981451a12.8.1731513664950; Wed, 13 Nov 2024
 08:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20241111100701.2620020-1-kraxel@redhat.com>
 <CAFEAcA83zip4PnAxjQp-Qiquwzqf=cVwRmxsKGeyAXvqwzg=qw@mail.gmail.com>
In-Reply-To: <CAFEAcA83zip4PnAxjQp-Qiquwzqf=cVwRmxsKGeyAXvqwzg=qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2024 16:00:54 +0000
Message-ID: <CAFEAcA_hvu9PxwjExKKi0P1mhEKdUF1McYc=pagY2LpcpxpR2w@mail.gmail.com>
Subject: Re: [PATCH] edk2: update submodule to edk2-stable202408.01
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 13 Nov 2024 at 15:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 10:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Updates the subhook submodule to point to a edk2 mirror repo.
> > Fixes recursive cloning of the edk2 submodule.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2660
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  roms/edk2 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/roms/edk2 b/roms/edk2
> > index b158dad150bf..4dfdca63a934 160000
> > --- a/roms/edk2
> > +++ b/roms/edk2
> > @@ -1 +1 @@
> > -Subproject commit b158dad150bf02879668f72ce306445250838201
> > +Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> > --
> > 2.47.0
>
> Shouldn't this also come with an update of the binaries?
> I know that in this case there's not supposed to be any
> change to the edk sources, but I kind of expected that the
> process of "update the edk submodule" ought to be
> standardised to the extent that it would produce new
> binary blobs to match the submodule bump.

(but since I've checked that in this case it really doesn't
need new binaries, I'm going to put this in for rc0 so
we don't have potentially more bug reports about the
sub-repo from users who try rc0.)

thanks
-- PMM

