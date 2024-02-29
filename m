Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F60C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYP6-0001wS-MK; Wed, 28 Feb 2024 23:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rfYP5-0001uh-1n
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:52:19 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rfYP2-0001tI-Jc
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:52:18 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-428405a0205so166921cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709182334; x=1709787134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yUrEdSa22muSvyjAyoWdPIRGKTMMbzqWHI22o/IGdU=;
 b=rZkzcHIMNqCb+JhZiXJ6dDf8oUsxGAaawmmhVPhDr2H6INqYfaYrXeKwLeG4nO2q2Y
 rMb2Cmv8Bp2UF1Fn9TEkBSbTEsCl3TfjMa4/XqoAsEqJm7GWCCIQK9iJ8GYb02D9OsjE
 W5x4oQn6L+ZgroK7BMk/CGIZLzVKFeQoutGnf4WaXiEsbr0BXTFHjUuNjKN479tsc5Px
 1aGueUf6gypXZIML+fmVSM+qWZyVOsjygtChYd/IJ3ffctjrMcnbosmnbXCCfb8Q1aSm
 JqJTB0TSBLQuV4VBdT03vFN56gI+r3yW72mu7Vg8Cb2BRoncmjCa7pNn62BygpTiTj61
 uJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709182334; x=1709787134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yUrEdSa22muSvyjAyoWdPIRGKTMMbzqWHI22o/IGdU=;
 b=ZsjMfCY6MM4F3ZySoJ3asctU30WwHYYFfNmP9QiWl6t8X+DsjCqYJrUmXDX7sHmDka
 99QA/ZFyvlNB8s5t4koeLCSXWTOUuXjM/n962OvKp3HxV0yHJlc12QSEqkGlT2ZaHLFU
 TF/qpsn9miVgrEdKZ0pgIKidhNA2tnJKeMHQUp+ikin+fqvg/6XNfpA0TCfv/xjmQA7y
 1fU8kbRPrRPcfxhI50zBGYEXWbFD5eiwPjin4dgXzpX4Znk8TCivTCwdgdvwSDihB9fs
 5Z8EJOnSUBmLgBf66PwCpg8YHQN9FPSrmb+mc8IK6zMtCOBzN3PbYuI80v8mziIIsk2U
 hNqw==
X-Gm-Message-State: AOJu0YwJWZ+MqbHiBP+bh6XpyxsuIrqHb28VZz0Awy2/HUXj1WLFJ5Cj
 KmUuWR1iwa7/AibnTkOqtJrH+SaxpACb0tH1yjdCN56D91Oz2aDWLScWwt1TVxizTAN4gB5/9ZN
 +IxZ85c7+YbdYKUXGOuq4KisfYLx+NZiQo+Uu
X-Google-Smtp-Source: AGHT+IEpqmDsfkU1mg6g0CLPYeJm88+JrlT/telYVcjdEaVUVOzskYDrxYclulfyHyNmn8fTmmvDZXRz6PhnDrlWZTc=
X-Received: by 2002:ac8:57cd:0:b0:42e:377e:8c07 with SMTP id
 w13-20020ac857cd000000b0042e377e8c07mr55163qta.11.1709182334341; Wed, 28 Feb
 2024 20:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
 <CAFEAcA-EnsmNkLuJb-dVZbT0+2TPJSw94eeEbx7JNiULsMKgUg@mail.gmail.com>
In-Reply-To: <CAFEAcA-EnsmNkLuJb-dVZbT0+2TPJSw94eeEbx7JNiULsMKgUg@mail.gmail.com>
From: Joe Komlodi <komlodi@google.com>
Date: Wed, 28 Feb 2024 20:52:02 -0800
Message-ID: <CAGDLtxu-+5-Bc+BGbZZPWfZOjdKJzNDkOz_BxJEmHNoNFnYpbA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] memattrs: target/arm: add user-defined and
 requester ID memattrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=komlodi@google.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

On Wed, Feb 28, 2024 at 6:21=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 27 Feb 2024 at 22:24, Joe Komlodi <komlodi@google.com> wrote:
> > This adds requester IDs to ARM CPUs and adds a "user-defined" memory
> > attribute.
> >
> > The requester ID on ARM CPUs is there because I've seen some cases wher=
e
> > there's an IOMMU between a CPU and memory that uses the CPU's requester
> > ID to look up how it should translate, such as an SMMU TBU or some othe=
r
> > IOMMU-like device.
> > For a specific downstream example I've seen, Xilinx overrides CPU
> > attributes with ones passed in by an object property in order to have
> > their IOMMUs work:
> > https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a45643fe2172d=
6f8ca/accel/tcg/cputlb.c#L1127.
> > The object property with the memory attributes is declared here, for
> > reference: https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a4=
5643fe2172d6f8ca/target/arm/cpu.c#L1310.
> >
> > The user-defined attribute represents optional user signals that are a
> > part of AMBA-AXI. As the name suggests, these are defined
> > per-implementation and devices that receive these have their own
> > interpretation of what the user-defined attribute means.
> >
> > We add them in CPUs and PCI transactions, because some of their
> > attributes are set in functions in ways that are not user-facing. DMAs
> > or other devices that set attributes (using address_space_rw or some
> > other means), can add them on a per-device basis.
>
> So as far as I can see, this patchset defines a bunch of mechanism,
> but no actual users: no device looks at these new memattrs, no board
> code sets the properties. I don't really want to add this without
> an upstream usecase for it.

Yeah, I believe the current use-cases for this series are mostly downstream=
.
It's possible that there's an upstream device that might benefit from
it, but I'm not aware of one.

Is the concern the usefulness of the series, or the worry about it bit-rott=
ing?
If it's the latter, would a qtest be alright to make sure it doesn't rot?

Thanks,
Joe
>
> thanks
> -- PMM

