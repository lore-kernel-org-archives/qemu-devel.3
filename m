Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B808ECAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AZB-00079Y-Di; Mon, 29 Sep 2025 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3AZ5-000792-6x
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:53:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3AYo-0007m6-5E
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:53:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso28939595e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759139553; x=1759744353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3NXnt+1zn17ffiuSFkiAhJa9DOrWapfydcxrZfhtKA=;
 b=WRMS25qOvGeu4ap1UeFkkvy5zhONUIl7SE4ebqH/VwNAIq3SLVogS0uDF46ruoPEc5
 rdswMOeUJjZGBlP3U0lTfvl8g7kCRZNQeOgP2MOL8Aq44u17oJp9EunAdRdYQoJAnSAE
 wCj3BmHpO42EhQtIoRuOiKP7lifiSzw6tyntiTckR9kxcuN0vAR+yHCNCC3y/wJtRB4K
 bVXl1L+yvMCVRarnKC68/EH6ezbgUFzFm8o/g0Kx9iJhiwWI8phy3gpGpmb5MevQ9+iu
 jTel5UXVTl4y7b134ENIhUX7pGcyK41JA+PWhc5+G4gpNv/fplied3BtkvxCe8AxNEmc
 zs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759139553; x=1759744353;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i3NXnt+1zn17ffiuSFkiAhJa9DOrWapfydcxrZfhtKA=;
 b=YS3x7m71WcYo1SSSXP8Jaric36SXZTfi2pFKyU/SDC6VQjO2kD51PD1E+AEgAYYyZA
 B8YPZyIWivVuIzBfEWGBj5mElOBOIIcGTDmjD5a6too425ck3JBlqmPRb5iogGKIURR/
 lrHEtrwgug+erFahVJUojAPnqJpT+JNXdxvwChaZthGmw8M58Vcu/wbFIcY4/t+lk7zv
 FOPy+iBGUWg4ZlKMauLBUeUml/vlJVkY/VNBaFPhcUYJ2wwkKopDItX0KEmGGS77t+bL
 zBplhup8fS7aEMOWw91XZSA51EEeHEHbPMkQSFLPoYRMfEwgq+ZAUndFJcwaL8EKvYrs
 ZmOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMYSWwgwyFTPqOsu4sLIYDYtKomutvgp9y6IJXF338F+AgR4XGtFVwLgErjWylEnmH2YaXXatLl9lw@nongnu.org
X-Gm-Message-State: AOJu0YzSK9IeRVsoVICzvGDxgYxG7OyqCpbqMucSPfq4hdeVAd2oVWzY
 bOto+rMB2LB04VgTjyv0esz5SORFENT+96FXMnUaognwUY9iax4hkusUSS9WFD/5H7vRW1EKAC2
 PGCvPgAU=
X-Gm-Gg: ASbGncsSEbnIN3/mWGF93Ol7Rs0b1RICCWMKowXXtHnxrDQsbnxW093/rYajZYeKsut
 iDxExir984u+Y9Ga7XTEn6DxXodGbxFFUPLOeuWYzBUG9Lh6XUN59HaZ5RIcS1MAWnjy4Ixqhfr
 SW6EUd6gopsGK5aTDQ+VCy9E1Ysds34hs1B5prXdCVAyHuULS/FIq/jmE+vlJPEw97CXHdCov8+
 S0G1X6Wb0W61FfZvE08Sl0MUhS+yECQRPo4shg1PM8l/mbSoYvotAcHOaacawEYzQiDRlmS5d2a
 7V41gS+LXWNUgsmCq5U9Y2Lgy4KY7r1IWwEOe4s5P4Ngg7BmSvrJKhOK+1yH7zotezPv7opANoX
 pL9OWGfZU/zho2wj2XuIZiu+dO5T0GQwinw==
X-Google-Smtp-Source: AGHT+IF8qLComs2vB++xymCQRKi1Xq81MoFl5vAViq+5GIvHF5FnpPJiZtIAgjixvpDJP//QQd4RBA==
X-Received: by 2002:a05:600c:1c92:b0:46e:3dad:31ea with SMTP id
 5b1f17b1804b1-46e3dad3310mr131014395e9.17.1759139552850; 
 Mon, 29 Sep 2025 02:52:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3d754sm6201005e9.4.2025.09.29.02.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 02:52:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF9D65F83A;
 Mon, 29 Sep 2025 10:52:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Christian
 Speich <c.speich@avm.de>,  qemu-devel@nongnu.org,  Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
In-Reply-To: <20250929042410-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 29 Sep 2025 04:24:44 -0400")
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
 <20250929042410-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 10:52:30 +0100
Message-ID: <874islmvq9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Sep 29, 2025 at 09:22:02AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Sep 22, 2025 at 04:14:55PM +0100, Alex Benn=C3=A9e wrote:
>> > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >=20
>> > > On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
>> > >> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
>> > >> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrang=C3=A9=
 wrote:
>> > >> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wr=
ote:
>> > >> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrang=
=C3=A9 wrote:
>> > >> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirki=
n wrote:
>> > >> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speic=
h wrote:
>> > >> > > > > > > This removes the change introduced in [1] that prevents=
 the use of
>> > >> > > > > > > vhost-user-device and vhost-user-device-pci on unpatche=
d QEMU builds.
>> > >> > > > > > >=20
>> > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
>> > >> > > > > > >=20
>> > >> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
>> > >> > > > > > > ---
>> > >> > > > > > > vhost-user-device and vhost-user-device-pci started out=
 as user
>> > >> > > > > > > creatable devices. This was changed in [1] when the vho=
st-user-base was
>> > >> > > > > > > introduced.
>> > >> > > > > > >=20
>> > >> > > > > > > The reason given is to prevent user confusion. Searchin=
g qemu-discuss or
>> > >> > > > > > > google for "vhost-user-device" I've seen no confused us=
ers.
>> > >> > > > > > >=20
>> > >> > > > > > > Our use case is to provide wifi emulation using "vhost-=
user-device-pci",
>> > >> > > > > > > which currently is working fine with the QEMU 9.0.2 pre=
sent in Ubuntu
>> > >> > > > > > > 24.04. With newer QEMU versions we now need to patch, d=
istribute and
>> > >> > > > > > > maintain our own QEMU packages, which is non-trivial.
>> > >> > > > > > >=20
>> > >> > > > > > > So I want to propose lifting this restriction to make t=
his feature
>> > >> > > > > > > usable without a custom QEMU.
>> > >> > > > > > >=20
>> > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
>> > >> > > > > >=20
>> > >> > > > > > The confusion is after someone reuses the ID you are clai=
ming without
>> > >> > > > > > telling anyone and then linux guests will start binding t=
hat driver to
>> > >> > > > > > your device.
>> > >> > > > > >=20
>> > >> > > > > >=20
>> > >> > > > > > We want people doing this kind of thing to *at a minimum*
>> > >> > > > > > go ahead and register a device id with the virtio TC,
>> > >> > > > > > but really to write and publish a spec.
>> > >> > > > >=20
>> > >> > > > > Wanting people to register a device ID is a social problem =
and
>> > >> > > > > we're trying to apply a technical hammer to it, which is ra=
rely
>> > >> > > > > an productive approach.
>> > >> > > > >=20
>> > >> > > > > If we want to demonstrate that vhost-user-device is "risky"=
, then
>> > >> > > > > how about we rename it to have an 'x-' prefix and thus disc=
laim
>> > >> > > > > any support for it, but none the less allow its use. Docume=
nt it
>> > >> > > > > as an experimental device, and if it breaks, users get to k=
eep
>> > >> > > > > both pieces.
>> > >> > > >=20
>> > >> > > > Maybe with the insecure tag you are working on?
>> > >> > >=20
>> > >> > > Sure.
>> > >> > >=20
>> > >> > > > And disable in the default config?
>> > >> > >=20
>> > >> > > Disabling in default config would retain the very problem that =
Christian
>> > >> > > is trying to solve - that no distro would have the functionalit=
y available
>> > >> > > for users.
>> > >> >=20
>> > >> > I think his problem is that he has to patch qemu.
>> > >>=20
>> > >> Yes I'm trying to avoid that. Patching qemu also involes providing =
updates
>> > >> (and security patches!) for it. This is a very high burden to turn =
this
>> > >> simple flag on.
>> > >>=20
>> > >> >=20
>> > >> > As described, this is a developer option not an end user one.
>> > >>=20
>> > >> I don't really get the distintion between developer and end user he=
re.
>> > >>=20
>> > >> As a developer I'm an end user too, I'm concerned with the linux ke=
rnel
>> > >> and the additional host tooling for mac80211_hwsim support but QEMU
>> > >> I'm just using as an user.
>> > >>=20
>> > > Are you ok with building qemu with an extra config flag?
>> >=20
>> > In my patch I gated the feature on:
>> >=20
>> >   VHOST_USER_TEST
>> >=20
>> > so it's easy to patch out of the default config.
>>=20
>> FWIW, we have multiple other test devices that we don't gate behind KCon=
fig
>> build flags - hyperv-testdev, pc-testdev, pci-testdev & edu.
>
> Well that's because e.g. kvmtest actually depends on pci-testdev.
> IOW it's actually supported.

Isn't this solved by having an entry in MAINTAINERS?

Its not like the device isn't useful to developers working on vhost-user
daemons who have yet to acquire a stub. Indeed if the numbers are
correct it should work for any daemon which takes full responsibility
for the config space.

>
>>  IMHO the
>> vhost user device is more compelling to have enabled by default as it can
>> actually be used todo something useful.
>>=20
>> IMHO the rationale for disabling it is more fitting to downstreams like
>> RHEL.

Makes sense to me.

>>=20
>> With regards,
>> Daniel
>> --=20
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

