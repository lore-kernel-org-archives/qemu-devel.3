Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814CDC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpAq-0003uJ-P9; Wed, 21 Feb 2024 11:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpAo-0003sa-4w
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:10:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpAS-0001c2-JL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:10:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d8739ddd4so115189f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708531793; x=1709136593; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHBXNYCfALl1QAOWdHewi35JME+D6K+Zk7VT8y53AAA=;
 b=OzA+lr95BhcoMESINoFE3WqvXABMZPeAZ+/7RACcb5s6igpyzawn/ypkUUgzVOzdKe
 WwqCwXbZBjonz9VdN0tu73NUWNJQJsQIrEp/ROx/o3Y+mJFF5uNcXmOuKEks1zjPCYSW
 r8JbwrJXJ8Ux4PZ3HUyZ66H+i35eVz+Mb7fbbSaPyr+bAaUcJpTDBk3V44EcehG/WNaD
 bHFvS0X4icmnZlQRsivwlSQGHbUNU6ASiRAoKxh3+mHLT6K2Gem8bfu34kR6xfbYtkGK
 TM0Sbd01gnKdA/DKuP0nxJfPHCPKeUXWBFrG+Qu7SxHhCc0ZFL1DltZnkkD64xnCsA2d
 ghQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531793; x=1709136593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHBXNYCfALl1QAOWdHewi35JME+D6K+Zk7VT8y53AAA=;
 b=qI791IXga14DS8UpFwD8rAjQE6d8i8i4t+NaB9O0YAsR1Y4mlEIfDnzsvPYdBxoBJF
 P9ijprzR2PVahsiD4lG0oejwDYaHjhZvA8oXg2PCiw2Boy1oH9+9/Bi3eYeROSfDX2Jh
 a3SufA6A0zeByVUwpy6JZytoymJbbrPkr3tDaye5GbbNT3mFkHcyLdz+SfSN4kvlEi32
 IyQZDe8v/siphvIvvnYBJlEjx2YzOJi2Ol5QSPRWLDAcBfoFc7D/dEa80/Cmrt+ADxSL
 iIzgLly0L2OfAVJK2rp2NnymWeir02k/QovwI57yXovp1EzOS14fN+WMIVnQ4IDHvDCz
 KCVg==
X-Gm-Message-State: AOJu0YzKIkfqP+VUyfHRm8CqLwNUauqWf7882ZhDUDvhsap9VjaImeKL
 1Elqfghx25HoL0k4MLXMcnsT38FiyAV4hmcm3mNPoOuBny2WYPueCvgtBBdz7NvKdc07aQu3FFQ
 Bsi70Ze2w+Q8DV6IGggjFDMRWVfAYEqwAJyifhw==
X-Google-Smtp-Source: AGHT+IGgmmVb1pDTdYAyR4/DPwrT/wt6bm70aKFrsMkd/bXFBF22nCd7av2S6hDW61IiNcxhIaWO9xeW3q4lfYlkvfg=
X-Received: by 2002:adf:f54e:0:b0:33d:d37:485a with SMTP id
 j14-20020adff54e000000b0033d0d37485amr11214319wrp.58.1708531793210; Wed, 21
 Feb 2024 08:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
 <55058f62-b59b-43ee-812c-628b8df9745e@linaro.org>
In-Reply-To: <55058f62-b59b-43ee-812c-628b8df9745e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2024 16:09:41 +0000
Message-ID: <CAFEAcA8PuK-EVWCYh16+4FDcPFPhU4qHHp5HzsnPvFhtut+gXA@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 at 15:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/2/24 17:06, Peter Maydell wrote:
> > Implement a ResetContainer.  This is a subclass of Object, and it
> > implements the Resettable interface.  The container holds a list of
> > arbitrary other objects which implement Resettable, and when the
> > container is reset, all the objects it contains are also reset.
> >
> > This will allow us to have a 3-phase-reset equivalent of the old
> > qemu_register_reset() API: we will have a single "simulation reset"
> > top level ResetContainer, and objects in it are the equivalent of the
> > old QEMUResetHandler functions.
> >
> > The qemu_register_reset() API manages its list of callbacks using a
> > QTAILQ, but here we use a GPtrArray for our list of Resettable
> > children: we expect the "remove" operation (which will need to do an
> > iteration through the list) to be fairly uncommon, and we get simpler
> > code with fewer memory allocations.
> >
> > Since there is currently no listed owner in MAINTAINERS for the
> > existing reset-related source files, create a new section for
> > them, and add these new files there also.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   MAINTAINERS                      | 10 +++++
> >   include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
> >   hw/core/resetcontainer.c         | 76 +++++++++++++++++++++++++++++++=
+
> >   hw/core/meson.build              |  1 +
> >   4 files changed, 135 insertions(+)
> >   create mode 100644 include/hw/core/resetcontainer.h
> >   create mode 100644 hw/core/resetcontainer.c
>
>
> > +static void resettable_container_child_foreach(Object *obj,
> > +                                               ResettableChildCallback=
 cb,
> > +                                               void *opaque, ResetType=
 type)
> > +{
> > +    ResettableContainer *rc =3D RESETTABLE_CONTAINER(obj);
> > +    unsigned int len =3D rc->children->len;
> > +
> > +    for (unsigned int i =3D 0; i < len; i++) {
>
> Worth a pair of trace events around the callback call.

Do you think so? What would be the interest in them?
(The way the resettable handling works this foreach loop
gets called several times for any particular reset event,
as well as getting called if anybody calls qemu_unregister_reset():
so "something is iterating the resettable container children"
can be for multiple reasons.)

-- PMM

