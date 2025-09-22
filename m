Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C93CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iG2-0002WG-UD; Mon, 22 Sep 2025 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0iFy-0002U1-VH
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:15:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0iFo-00079X-57
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:15:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so15987435e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758554097; x=1759158897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxtBtjS1z6YeJto4DGOD1O6EiNPhFsuznHDiitgwKWs=;
 b=AdL7H4QmUFb8pvCv4lfFtYpiqmhFHHXu8u+vJX6pPakSbFr5YtC9BOWeQq0cO2kP7x
 gRDo1eHZ/avzi+bUzxbvD+pz6AJIAxHe7M/6ifZectpB7ZHKlKItFDdUBoUjI/vDEFRa
 drEGM7U9Z/pdBcx+RWj7vy9yQTUbt2LSLKfPJ/mAXc8aKDe2Zi/lwyk/ZdlyDN9nJS/A
 QAA4CTfirGK+DqPsi+/s88IsSs0w9Z8pkyQvDv2oZgoGPXX0z9KBEo6mAozZ0RFW/+A6
 abX5AlCxaiR8w0zUqHae34pBQIqTksBC2TwZrMkO4RQYmUa26id/ffkrW/zsq4wO5fji
 5GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554097; x=1759158897;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OxtBtjS1z6YeJto4DGOD1O6EiNPhFsuznHDiitgwKWs=;
 b=FH4mrjL7BGyXm5/zZOCCpZZR/UoXTTeoATtDP0OOHfoXkqEY50uOzKbMbupWfoj+Z5
 NMzQCfKQSqjxmFqHe9yfKE6s2BPLR84QGbLo7RUwtmmNcmGyLHsIWyS6y5Xt5q8+aRqr
 HU/lMztVBM1FGQSBvZazixRemeJH7d07/T0fTF0wH9JS0RU8TGrHjVDv3zlgAFjv9Fst
 wUahUGkPJsJfN+vWxt5DYjERrZd2aSl18BQC+vrOU+BdfQUJI8AKoIDTiB4QxkQYV6UJ
 kPtYSVtsz0K4qMoGPSW5chGEYzOa1cxNwWCIZ1MLUBDG+kjK+hV1XKePCckMcjUgxoZt
 ldaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCbdNsStIF9XcXnNejjd4rmkVzve6VgW4wjpY9udNzYumhrKnxbsHwSAdLuBq+2BKf05hg2WvMLYC1@nongnu.org
X-Gm-Message-State: AOJu0Yzl8hj+tse8Fd55+LhfEdR/uT6hmPvT4TqJksB4BvoyVTSJRIuJ
 83WAAK2Mehqh806OeQ2uu/6v26sjmQogkF0GbBp+jS9A610rZt6v2Dh6bcdJPjwF684=
X-Gm-Gg: ASbGnctlVVmCbfgRbjNXXTz5glaac3ijgEsDbon2uv85VE/DRIeUdej0Xr5ALgCLMYC
 tkVGXui+ngS1OrBhDCC2zI5+fiQoKZf/OXGfTNzpZBm7VGRfkIyMWpqOTM0FC+1Zhi1wblOILcC
 t/mk2vDbvd84euUuh7kDeDcp/G8su3tsZMxCHErvBxH3YHOMBXQ6DBH3rXgEO+nzjW37YzuyIoh
 dv6tdZSWkmJP1Dkyh0gfdoENrodMPypoaK42Blz4ktKaTYQUcDHJkkWFxBhdfc/Tc+fvYbTNgZ+
 LyKlV10gW3S023Dx3Mntbs0b/wo2uW8cdsXTYWu/i5LfVZc1nkiOGWmuixa1upNPYMSJLJle1qN
 5I8MMPClLDCkNrEhtVAVYpYA=
X-Google-Smtp-Source: AGHT+IECLyQ38dZnbpgQyjFn0qH382QwTg1EbfDlnCGTSMYKRQSp1BnQ8MnOqinMMFiGN/oGhvFBjg==
X-Received: by 2002:a05:600c:8b21:b0:45f:27fb:8016 with SMTP id
 5b1f17b1804b1-467e63be55fmr104791375e9.1.1758554097020; 
 Mon, 22 Sep 2025 08:14:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461383b7b9csm248692925e9.2.2025.09.22.08.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:14:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43FD25F7C4;
 Mon, 22 Sep 2025 16:14:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Speich <c.speich@avm.de>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
In-Reply-To: <20250922093013-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 22 Sep 2025 09:30:33 -0400")
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 16:14:55 +0100
Message-ID: <87y0q6mscw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
>> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
>> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrang=C3=A9 =
wrote:
>> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wro=
te:
>> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wro=
te:
>> > > > > > > This removes the change introduced in [1] that prevents the =
use of
>> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEM=
U builds.
>> > > > > > >=20
>> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
>> > > > > > >=20
>> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
>> > > > > > > ---
>> > > > > > > vhost-user-device and vhost-user-device-pci started out as u=
ser
>> > > > > > > creatable devices. This was changed in [1] when the vhost-us=
er-base was
>> > > > > > > introduced.
>> > > > > > >=20
>> > > > > > > The reason given is to prevent user confusion. Searching qem=
u-discuss or
>> > > > > > > google for "vhost-user-device" I've seen no confused users.
>> > > > > > >=20
>> > > > > > > Our use case is to provide wifi emulation using "vhost-user-=
device-pci",
>> > > > > > > which currently is working fine with the QEMU 9.0.2 present =
in Ubuntu
>> > > > > > > 24.04. With newer QEMU versions we now need to patch, distri=
bute and
>> > > > > > > maintain our own QEMU packages, which is non-trivial.
>> > > > > > >=20
>> > > > > > > So I want to propose lifting this restriction to make this f=
eature
>> > > > > > > usable without a custom QEMU.
>> > > > > > >=20
>> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
>> > > > > >=20
>> > > > > > The confusion is after someone reuses the ID you are claiming =
without
>> > > > > > telling anyone and then linux guests will start binding that d=
river to
>> > > > > > your device.
>> > > > > >=20
>> > > > > >=20
>> > > > > > We want people doing this kind of thing to *at a minimum*
>> > > > > > go ahead and register a device id with the virtio TC,
>> > > > > > but really to write and publish a spec.
>> > > > >=20
>> > > > > Wanting people to register a device ID is a social problem and
>> > > > > we're trying to apply a technical hammer to it, which is rarely
>> > > > > an productive approach.
>> > > > >=20
>> > > > > If we want to demonstrate that vhost-user-device is "risky", then
>> > > > > how about we rename it to have an 'x-' prefix and thus disclaim
>> > > > > any support for it, but none the less allow its use. Document it
>> > > > > as an experimental device, and if it breaks, users get to keep
>> > > > > both pieces.
>> > > >=20
>> > > > Maybe with the insecure tag you are working on?
>> > >=20
>> > > Sure.
>> > >=20
>> > > > And disable in the default config?
>> > >=20
>> > > Disabling in default config would retain the very problem that Chris=
tian
>> > > is trying to solve - that no distro would have the functionality ava=
ilable
>> > > for users.
>> >=20
>> > I think his problem is that he has to patch qemu.
>>=20
>> Yes I'm trying to avoid that. Patching qemu also involes providing updat=
es
>> (and security patches!) for it. This is a very high burden to turn this
>> simple flag on.
>>=20
>> >=20
>> > As described, this is a developer option not an end user one.
>>=20
>> I don't really get the distintion between developer and end user here.
>>=20
>> As a developer I'm an end user too, I'm concerned with the linux kernel
>> and the additional host tooling for mac80211_hwsim support but QEMU
>> I'm just using as an user.
>>=20
>> Greetings,
>> Christian
>
> Are you ok with building qemu with an extra config flag?

In my patch I gated the feature on:

  VHOST_USER_TEST

so it's easy to patch out of the default config.

>
>
>
>> >=20
>> >=20
>> > I know Red Hat will disable it anyway - we support what we ship.
>> >=20
>> >=20
>> > > With regards,
>> > > Daniel
>> > > --=20
>> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/db=
errange :|
>> > > |: https://libvirt.org         -o-            https://fstop138.berra=
nge.com :|
>> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/db=
errange :|
>> >=20
>> >=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

