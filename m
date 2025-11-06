Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F24CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH0yR-0005v6-4u; Thu, 06 Nov 2025 09:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vH0yN-0005uN-UC
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:28:23 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vH0yJ-0004aU-DU
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:28:21 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64106cfa518so182233a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762439296; x=1763044096; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IG3vAIZkZXew8XBcs0vaDeXBCcBD98Zd0ztiQkjcy0Q=;
 b=XTLInBFEhoQJBzZaVRfRbKy7DbWGWhxHnOc4yg/upM0Uzno72YPezOH7GhejrIhghZ
 5uWpPnuroq6xNUf25C7XTUKyhLpIZltdQtoc20EgNUHGSq1l9XXz7h3CeUCuG+fEsvP3
 l1zpzA1YVQ88iHNJu08cXdt3cy0d7lWF0tWPlrb38cnf4sWSQqh4919766SSNe7hit/r
 N9HOvYMoD3XM0AOk7l6NXHa0oDh/Xi5PtCOSZkQ/0rYqxGOgWCZy+dLOfaJW4Vpn77xF
 ye0RbsjjD6+JanSM1QF5zWOMkS4eNMZkBeK4on8l+vlS1Phj1gV/mmUVgphOff98UAeR
 m4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762439296; x=1763044096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IG3vAIZkZXew8XBcs0vaDeXBCcBD98Zd0ztiQkjcy0Q=;
 b=m1SPyE2RW+T2eVQARMBdF/QO1N77m/eyI9/7pKnEh5qX7HHLSa4m2rQlI1K2OwNCTp
 thuSOIaYtGeKac8GoXl/ZMFoBb6h1IkEjG3DfH+lvBKrJJ2nCtkJsNKRBdcwec0SrKa3
 F1V1dFO1GKKK9NIPiNh3SD/Smi5o05CFOJymNqLpSMMWvg4mZrCUdf+2codSMnMof1ZY
 HMgkmuun2UYwsCwAws7DeVsLtWvfC8ZNjFDHZJBJ6E6OOu1QpLz6o/RRdbCOQuBXHtlm
 Q96z+GzDq2bEjZv4HZ1oHRL3e/GUe2h6Y7zVBXmYQQzWz5LycssLePvX32GYNl3zN6IT
 MSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOb5bdUnGvUdSoCoP+iT3rOZq9heC8sETUHf7vZmAGRk6ufbSccEsjmg0CflZy/q8tyk9vjh0FtlCZ@nongnu.org
X-Gm-Message-State: AOJu0YxGQ1gTxXmuSokYCUf0Ou1A32WW7jlpiuYGf2TEC5IliFEy6aOu
 RsBLQKEGOasi52PHpD4bWZltcLc5ZGu9gXzKbIkiizwhgQM/EY+AB7frM0+h7BL426LrPKZs+ol
 9b9Peq1vxSHYceYSLAZZyMyF9NBRi5Fiood4yXJIFTQ==
X-Gm-Gg: ASbGncvg3EUnu8ECBUdcPAHKVmpDUZnETUloFX6r+LkLV8AmShFz9Bg82nsMvtcq966
 EBWIxXOz/LTZVomQnFLDLxGkO/3Hj4xStDA6sy2rOLIbEukGDqq3T3EjUzod+ITw4rNpzpnlCvJ
 eewJ/+ZnJ+AFQdHha/loABsh1RV964s/2dH8+qQfGSV6v5bb8jqVYwDjS6zklL4/+GuKGK7B1Tk
 xwJCdUDwndm85FbfmSfrxAG8DoAFZWnjqIVoMAmgotIQ6i6gatjtCNKrdfSFvp/G51yqqU=
X-Google-Smtp-Source: AGHT+IGiAI6+Ryk5sS7V/ted6fWhM7KVau4cCeRs7i+qld4Hvnfd/sWNOZjGnWxNCSUj4omtActaWUzT9vcKMhU+K74=
X-Received: by 2002:a05:6402:3596:b0:63c:3b80:17c3 with SMTP id
 4fb4d7f45d1cf-64105b7e0eamr3403251a12.5.1762439296187; Thu, 06 Nov 2025
 06:28:16 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
In-Reply-To: <aQvM6l04VeZwbUOf@x1.local>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 6 Nov 2025 15:28:05 +0100
X-Gm-Features: AWmQ_blvgIx_BfN1Do1NCTRi8hhjNvViNRL9Jaj3jAgZn-6nwGCWl2CDs0jPiNs
Message-ID: <CAMGffE=VdsQSTOOpBvaDc=RQ98cMDHYemF7nS5pnqJ7Rsvafug@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52f;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Peter,
On Wed, Nov 5, 2025 at 11:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > These are not present (or not supported) on QEMU 8.2.10, which caus=
es
> > > > the migration state load to fail.
> > >
> > > Interesting, we've already done the compat work:
> > >
> > > GlobalProperty hw_compat_8_1[] =3D {
> > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> > >     { "ramfb", "x-migrate", "off" },
> > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > >     { "igb", "x-pcie-flr-init", "off" },
> > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > };
> > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > Yeah, I noticed the same.
>
> AFAICT, this is a known issue..
>
> Thomas and I used to suggest we should not turn on USO* by default by
> probing kernel, but only allow user choosing it explicitly in a VM
> setup. IOW, dest qemu should stop booting at all when kernel is too old
> (when user chose the feature).
I feel this is the approach we should have picked.
>
> See:
>
> https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
Is there any effort to allow migration from new OS support the USO
features to old OS doesn't support it?
Any hint to make it work?
>
> Thanks,
>
> --
> Peter Xu
>
Thx for the help.

