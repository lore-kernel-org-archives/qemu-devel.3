Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF0CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkiG-0006JC-HE; Thu, 08 Oct 2026 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEkiE-0006IR-Vu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:46:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEkiD-0005O1-2d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:46:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso3785902a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791452811; cv=none;
 d=google.com; s=arc-20260327;
 b=VmseAZQ3mQoi1CXjZgCjpvKmh7X3/8JX2iN3tQlb45ilDbDr5EMz35wQZHL2Ajjk/Q
 noquLYBFpKtFv4isju0OD40pHMQncCfKhL5Wzuz7UFC3L1db1+Brv/dFGqnoHnSR74o0
 JETYGVUnzEpa9qMKmg8C55F7wnph2Xb74QGSXvO03SvO6L+fL/7hDi/JFIUyDzFA1z0W
 A4rRVUrKLTO70yV11DqmGpscohxQo/6XnY+wIG5xapO6MGslF6hhjaSs4q8DGK5HN2jO
 AyAwc60om35mxbzI5wpN4L3Ibo+KR7WMNi6MnaqRq3PfIsnn02ZbvpucQkwfrzuofx25
 KjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ogoTnumva6fXnSeYYYO0LBVKnfyDOFR0a4ATggkDipk=;
 fh=zyBPbMa2z+UiZlXwMqnIBQyF8aPiOPhmC7Funfhaw84=;
 b=Pvh4bGyojQmkAmIxlbyCv2Zp6tTM9IXFfkwPq1vbcO62c9Pbjev6GALb97SwWo95qG
 +g71N21jxTRjuaS7L+ZarTkF74/WS4g+SL9J+2Bm+RzaO10hd15JNa4FXmmtkfU/w9uv
 mb43exzYI7Srki3+x114lFor1ZpPQqWuxrAObrukiBLmAYSY8rJ3o7yO+m8qw2J6Aadm
 PTsTMo8D69FGuz2Tg+Ee0kxfqjyLmoiNMBcqHOSNptFQ66bHBlfCpwt1i7jAGudpcXkw
 4OZoixZyLw/rh3Cpa2F73OohVDGadLw+QnFanhjM80wnoOy6E5TiPGohetrXZubg4Wa8
 DMzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791452811; x=1792057611; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ogoTnumva6fXnSeYYYO0LBVKnfyDOFR0a4ATggkDipk=;
 b=k2jYUEM63bUBXcDw5+RND2qZR0szId4PoZ2xVxX1SKaJJi/B6MXRRQjyyA8YfmjmJq
 07XZnqZJes9uFHl/cjJAywZxqIe9mLWxpDBLhbYBLrO9s95gXzJ12+9ACY/wq5U8aVQ+
 OnOUdUCi8lZAr15NPS/ItLf9dj2y3H7OGET0uiMsoUi9qxOK++T1ocwPvdfgRANAhIOb
 cUAN4T5/lbwI82jkV6HitIP+e8OO4djOVPXjEU9TgeOpcypSbrc/8AcGtI1QNCPSp24u
 hj+IGm9deNdjKmMWJP/ex0cuNG85Op+5cEHQzQ8d2jLwLfFeCEvLeQfvd1PSdUppVrR3
 DGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452811; x=1792057611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ogoTnumva6fXnSeYYYO0LBVKnfyDOFR0a4ATggkDipk=;
 b=O0DJokCE8rMKOYN+pbPWu9NRHJu4UB1nYEZYVCLfYb7Oa8DIVvoajxcwDyNbcKkdmV
 SIJGjlWziHawRyvW2w3BZUNLy7lGbsxI4WZyPGA1PX6GcBQ4t0zc8nP/lnh43Hy/JXS5
 f2s234QPD0+9zM6Om94NDUefjjRdFSfx+v0s4TZQtWrl4TRUN1o96QiErWq9ulOWfy8s
 im0o2cljviCDg6TIDgZN/q/hRPZv6fKIiZLviS661ylLLOHBs3aN/yXmyQVM4Z8qtW62
 aeYDAO0qehSWbeF+wD43ISsuOp1XDSJoET6gn85Iu37qSCKmq+mdrh/7sslauW3y5AiL
 ejfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1c6DyfuoMLsAkI5kZqEMg0B1Nmh9wqPvOfiaMHVk98GB1u519zu/mpPUEjr14TdWGG9UTRrsterKY@nongnu.org
X-Gm-Message-State: AFq9FYKLMh3VyNhkRQU8Srcj6nlWZ7TpHune/5FKYFpQZLTlw4r69UQ9
 aTutEGhxyYPzU4ODRhDTAw1jcc3Hxi2shjZji7Mm5EIXksWlQ+WboxgFv7fU4t7PiHgiVHl1rDn
 qZubmzm41SoJuw3NXuwC+9wfgf+QpPyw=
X-Gm-Gg: AYBFou1X4sXUA6jyr36VBmJTDmEVbAYzNIsnUXyPWBlsQRwoD0zaQR5i9K3XFQeAP3X
 o/9AhsIXmEvf2OLZdnAM/ZdrW4rVvad89kPcyzrxb9QWF+XyCvc7/QipR1CkdN7AHjDco695DkB
 SGfag6g0LdvrR+IDZ+SbAEJKxiFrrGTUsu1gnwK0vHOfVBG+JoRq7GB5/aM9jXkD/dZSNdEGUV4
 vN9BzZYKfu202a5rv7wGtgldDYPrQAno0YkxWejOg6Cf5MJOuW0tY6eBCfmUq3lXSHKLuIMSJEU
 EzRBkZP1BzzREpdzXLt3wgH5ByeYJHrJKdvJ7ZidSoRxyvrWnsdviMM=
X-Received: by 2002:a05:6402:23c2:b0:6aa:e3f3:c9df with SMTP id
 4fb4d7f45d1cf-6aff453bc29mr3869590a12.20.1791452810906; Thu, 08 Oct 2026
 02:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
In-Reply-To: <asdlbOZBSYIaCMIh@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 17:46:35 +0800
X-Gm-Features: AclHuK_-C3RblRSJNtuVriKClZfH97RQs0eiitiJZBPRp79j3snPqumTItsdNYM
Message-ID: <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> > On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> > > This allows a combined binary to register machine types from all its =
targets.
> > > Consequently, QMP `query-machines` can return machine entries from ev=
ery
> > > target, even when `none` is selected. For example, a client can query=
 the
> > > combined machine list with:
> > >
> > > ```json
> > > { "execute": "query-machines" }
> > > ```
> > >
> > > The returned list includes the registered machine classes from all li=
nked
> > > targets. This is separate from selecting a machine: with `-target non=
e`,
> > > `-M virt` reports the targets that provide `virt` instead of choosing=
 one
> > > arbitrarily:
> > >
> > > ```text
> > > qemu-system -target none -M virt
> > > unsupported machine type: "virt" for target "none"
> > > Available for targets:
> > >   aarch64
> > >   arm
> > > ```
> > >
> >
> > From the long conversation on a previous thread, I thought we reached
> > the conclusion that if we didn't expose any ambiguous name, then -targe=
t
> > option is unnecessary, or maybe I got lost on track of this thread.
> >
> > https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> >
> > I'm not sure which semantic we want to have with -target none. If there
> > is no ambiguous name registered, we just don't need it at all. It's a
> > win-win IMHO.
>
> Yes, if we expose unique names for every machine, then -target is then
> redundant.

so how to diff riscv32-virt and risv64-virt? oh so for this machine we
needs two name?
"virt" needs register twice for it? or register only a single time,
but we prefix the target_name()
automatically? for example machine::name =3D=3D=3D "virt", but we can use
"riscv32-virt" "risv64-virt" to reach it?

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

