Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F3EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDM9K-0006GI-6u; Fri, 09 May 2025 07:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDM9D-0006Fx-R4
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:44:12 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDM9A-00054n-SW
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:44:11 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e740a09eb00so2010445276.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746791045; x=1747395845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWPMhJ0Sk0mJLU2ZE9eP/Hx0TLPpyirbi6sQ6Yk4IDw=;
 b=GeY7YRYf4LK2+S13Phras32OwIRKPL9fb/erF4q/OLmxBKWu3cfEZtkCCpuH8d/hfD
 JYtcYg3Y5aWZo9RaC4xRwyHhUX3vqWmNeVTzD5O7IJdEoxwhhAdNYEpLBzTJb2PiZbkP
 IbFc4pCOqlYTsVIQc/fad18Y1TsF+6XIpUMHrgB2XMb8Ej4OTKbxnjosWqogFKLPEalk
 98KwD3sO1RD3GhX38LqgvMaRuXek0WRiT+2qgsw9e8EDhsBGJRg4E7sOQ14rJNSG9nn1
 GsTSt0bXtXROR46K53bGA0Z+ovVpHpWGbP0XjTkU0WR1FTfO227uGQS9hjNs+Bcq5yz7
 kkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746791045; x=1747395845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWPMhJ0Sk0mJLU2ZE9eP/Hx0TLPpyirbi6sQ6Yk4IDw=;
 b=UsnP+Lx0iIgiXsKlnS8FpWjV8k9aV8M0X8no9VRnZFZfJYWUTfasHzt+vKKiWCcuxg
 PoTZRHOV0z+JWwUl42aNIvTwuufTj1rPl9/uQ/GeN6JGTbSHeYl64J4gsThgRpe9D+Nx
 lVvgegl5f2QQ/Kbp6Ic0Kygrj6m6dtv5CXolfHumSrmXQouuBNp0BUoZea4TstlW/ATh
 ZAsWfjjPjxDMsH7BLkqfPmFn3zMTGBXCKmaCZGRdC0yeg090rvW3UEZaX/WuLF3D9HZa
 Jpf99OL9EUKu8bm9PdOhvqb9++r0oROqqtxZO6tZPp6KG9nuv7RB8Q+BzEt+e+b8S37W
 zOoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLCQD4obPQbEESWdWoqxD4s3r9+8PAV7RlG3L1fS6kd/W42YJ53Y8hqm+MznNwvN9H0nugHEXXgiPf@nongnu.org
X-Gm-Message-State: AOJu0YwSInQk54DXYzkfBTzK3Kck4LLJ17Ue7RSaNmSn4S2JaeHaC4Fk
 nzMGITVQcUFMlcjKWLwHDpNBtkCte00RyRe9ILZZI9jT9dn+mZNnm0BYIBjrs5+xMoJMwU67JMi
 zYD/k/wxumN2JQbwEodIBsfRuNmHu+vBRQ8cIWQ==
X-Gm-Gg: ASbGnctU0b4aXV/o36sjQx/tc4HEx/mcJtJ3D+seTzUxncV64rRKE2TpxluMiK9S1gd
 H6Mqrh/mrF5QmYsOsgDSLHgoqx6fUW8DUBjYAkqZ/UylhsFa5mliE7rauSKkFX+baAzv/VHeaVM
 D+bKUMOryxSdxSdDTrYZM/0Q8=
X-Google-Smtp-Source: AGHT+IEANq3k6k8uGBqRzffI2kNfhLBsmUO00zQrce2lgOi6kdo1CBiLV/WOlHQ5oOpSDlZ6W4p6tysG6k877aGOt8I=
X-Received: by 2002:a05:690c:4489:b0:708:100a:57b0 with SMTP id
 00721157ae682-70a3f9e4badmr38279097b3.8.1746791045315; Fri, 09 May 2025
 04:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
 <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
 <CAFEAcA-HWuAUVhqsE7p2BMo6wg+7F273Q_J2LVLrHzFagTjxgg@mail.gmail.com>
 <aB3dAPNgXj7w9-7L@redhat.com>
In-Reply-To: <aB3dAPNgXj7w9-7L@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 12:43:54 +0100
X-Gm-Features: ATxdqUFgLyjyeViuXI9TIX-GTN5xgvuJ3wiqu4qsd_2ry_z0YWIPux9C51IebDc
Message-ID: <CAFEAcA-2XS3jBAzLnx9m-V_mqrJr47BsbQamTzszTPN+rmisfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
 Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, 
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Fri, 9 May 2025 at 11:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Fri, May 09, 2025 at 11:37:14AM +0100, Peter Maydell wrote:
> > (I want to start here by saying that I appreciate that I'm
> > coming in without having read the previous discussion, so
> > this is kind of going back over ground you've already
> > been through.)
> >
> > I agree that rather than having an entirely separate "SMMU with
> > acceleration" it would be better to have it be a property on
> > the SMMU device. But why do we need it to be user created?
> > Making it user-created leads into all kinds of tricky areas
> > mostly surrounding the fact that QEMU right now simply doesn't
> > support having user-created sysbus devices and other kinds
> > of device with complex wiring-up. -device is really intended
> > for "this is a model of a device that in real hardware is
> > pluggable and has basically one connection, like a PCI card
> > has a PCI-slot".
>
> In terms of "why does it need to be user created" - the goal was to expos=
e
> multiple SMMUs to the guest, each associated with a separate physical SMM=
U.
> IIUC, each physical NUMA node would have its own SMMU.
>
> So configuring a guest VM will require creating multiple PXBs, one for
> each virtual NUMA node, and then creating SMMUs for each PXB.
>
> Since there was a need for the user to create SMMUs for the PXBs, the
> question was then raised, why shouldn't the default SMMU also be
> user creatable in the same way, so that mgmt apps like libvirt have
> a single way to configure the SMMUs with -device.

Sure, the default "there's just one pci bridge and either
no SMMU or one SMMU" isn't that special. But we don't
have good infrastructure for creating sysbus devices on
the command line, whether it's the default SMMU or the
extra SMMUs or a UART or anything else. I guess the
dynamic_sysbus stuff works, but I've never really liked it
(it's basically "the board will magically do the right thing",
and to some extent it's working around the way we have
very patchy support for "I want to configure a board the
device created rather than configuring a device I am
creating").

-- PMM

