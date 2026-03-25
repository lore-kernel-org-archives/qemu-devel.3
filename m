Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B125FFEA83B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5L84-00060v-0H; Wed, 25 Mar 2026 06:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w5L7y-00060d-MN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:06:18 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w5L7p-0001rf-Tk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:06:12 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2c0c482e069so4055206eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774433168; cv=none;
 d=google.com; s=arc-20240605;
 b=er2YgaUGGRljaicHlX56Zc5jQYYiOgJ9ffHqxNfwCZsv78JN2QWlOmsI5cTFKcXbzN
 qLmXcXxkRi4KWsDcufh9pD5kdUNR3nktAAcIW1yBAlSIhFDoZOogtdt6oOHAikMIyFfn
 QZBd1FQfLvH62m8whGszEcf1u7YD3Hs5byw5hSB+i1VkNwRCscHDj6SKPfbyHvcZ5HHT
 3rM32cqMkyRujfXJHz9rcHw+hAFL0Sgv9bKrJMDrvPrl9SM+4+c0Vb7uGrp3ej4ptJYm
 B8PQDEmgJn5ybSVwvRty9edoxWdRnaPQdQls4tulMGI8fh6+7pvu1yutrAWVcSJaSF7p
 rT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jnp6JWiTBoYRWYcNZYzoWqXAJ73/8pnR58N37qdpm7I=;
 fh=3njbElQ++1yr9UMmCfeh1jl4SvqJ7kPaxqFji3Xozp8=;
 b=YJaDhGOMZQ7m4U2jxR1KZtS7RU2r6eCLOmJeDtTKKPXpm7lopkB8Sr/C46EuueVoHM
 2ONFdmT1b+/zmnop/lApQnwfSPTKNocAGwGBWBwVW56dCisz5m0Bvr5tThyhFwyAOHS/
 QfHldYyTjzIdBBcPt1RtND0pOM3pYPpUQLFBtR9tLW7AnYV+zYp86Wu3UJ2AJtOVc8BA
 vuThQeNOCoFH+iiFYoiUsrDg/dVMB1YZn5NyEn6Z0qG9VHwmKrL6VMaSgzHtshF2kyP7
 KR/LxiEGBtnEcE8PFeUKEZHlyVDi5mN3LXIkP2KUlDlUKnv+kBaq+QnjKp5pK3xj2jMf
 SaVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774433168; x=1775037968; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnp6JWiTBoYRWYcNZYzoWqXAJ73/8pnR58N37qdpm7I=;
 b=U7XXHQjSMin0rj+yGPxoVmgfqlUi+zpU4U1dOAqQ2D22gg4z5/PgZyBOQ7zHGsxQfE
 MwtcwMtPyPR+ETG1sBRGdOgmWPf2vBF83lZhxSxc2uhHc219/Zk/EAbRxBdeWEqClggF
 pqr/hSSqW+8muvN25FHzNhvr37wM5MvCivDQGhLqu+G5UudMLizayrWZmzRsNE2eREiA
 csDEvjuCoqrcUstI3cA5OqiGNXsyqyX2p1Ge3LbVYfy5dgw878rcY1BICbknquLJ526O
 FSmeP7HV5lu9M1dwnCilYsW4YrGbfdZ4bUjSQo3b+bOUrdNaJXY2P3Hm7VLk+D08pSJX
 9cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774433168; x=1775037968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jnp6JWiTBoYRWYcNZYzoWqXAJ73/8pnR58N37qdpm7I=;
 b=HQidN0TjbsGfgBWZZ+ygtqVdG8dpmBA7Qi5OShbSHTroKzAHZFN2A0L5Y+JIXAatwt
 O2FFSeXm+K1JpFB2FGxTDtZ66Qa7Zkf9BZdEGHQm0ueG9yMejYE2G773npMppWyH0XmQ
 gwDJkoOQBjRT+IGKM5ySrGW+PGWkBZ85XlcBZodThnxOXo7PmGScJJ8AtnGHX1ilznIj
 LRbKaJ4RYjeyWGmqdeNOTxxeGEHQe6bnh8qZx/L+TCGYtVG2J3A3L1MZKKwS2NEabDP+
 xuNftAXyd/UaBT2hGjvYRd3qTn2mZe1c2G0ePzRpb9Ra5M2oKlBpvLHMWgolfUgzhQWs
 Cnmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHrx82XhskYv4eN9pgzkMLweFSP7JLrDyAxmFqiIW/um5xlTEgc2FJkoL5dvgFit50GF6JpgSoldXg@nongnu.org
X-Gm-Message-State: AOJu0Yz9riszcg79IO+OWErAnYnVFZLALV8J3E+AWwFLCaLtoueAls0J
 y5TuLESjmVBEf4DNy9NAMI9ptoEqCDGvrJx4ycJG2RJbJbB9nND1D06aE1FAPriPAUZBTIYV8pw
 +O/aV5mwE/WOgKhpNofbplb+ACGjJ7QM=
X-Gm-Gg: ATEYQzxPT/Hxed2S1C4Zwg6WmaE2UaeT13R2amnGUZ28p3DBaiF6hgW6uDVdvDW9WBB
 aFvt5e4g72P6YNcCQGybiq2txwIA/+oC/pzGeODRjAH/9i8zUsNuQi2SOfHRd5K/ROhEwZAGpzd
 O8dw7HbkbZDCix4XFAdNuP0UVS12EJzPe34Wo7zqG6f4zoMYzxtxKbs7EJngW9V4hH+3V+0k/Gs
 hfjnXdwQl5LO5pe0grnJMTG4gWC2cckWWYJ1sShvrqx+XmSHkGCYCeXRc1gFIU5LUTLWbOcLy32
 riwLAbklRJSRdeTCZDXm+9jhT0HJ1z459w+nU0E=
X-Received: by 2002:a05:7300:f191:b0:2bd:b102:a022 with SMTP id
 5a478bee46e88-2c15d3c0932mr1471303eec.27.1774433168239; Wed, 25 Mar 2026
 03:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
 <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
 <acOpKJjdPUmtWeZd@redhat.com>
In-Reply-To: <acOpKJjdPUmtWeZd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Mar 2026 14:05:56 +0400
X-Gm-Features: AQROBzDmS_PJ2krTPcYqt_mdLUj_57znFfYFq6f36NBp62NhOrtst92sUKhInOY
Message-ID: <CAJ+F1CLxwLzPR3aFNHDtS4PKKTq5SAoqjtNuyfxRgyWj99vTag@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Wed, Mar 25, 2026 at 1:22=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 24, 2026 at 11:44:37AM -0700, Pierrick Bouvier wrote:
> > On 3/24/26 11:33 AM, Peter Maydell wrote:
> > > On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
> > > > Moving those sources will break build folder hierarchy also, which =
is an
> > > > issue for all existing binaries built from contrib anyway.
> > > > I'm not sure there is anything sane to do to fix that except accept=
ing
> > > > the breaking change.
> > >
> > > What are we breaking here ? Nothing outside QEMU ought to be
> > > depending on the layout of our source tree. When we move things
> > > around we'll update the meson.build and the documentation.
> > > I don't think we have 'contrib' in our installed-locations
> > > layout (tools get installed into the bin/ dir, for instance),
> > > but I might have missed something.
> > >
> >
> > I was thinking more about users that might have custom scripts using va=
rious
> > contrib plugins, or using vhost-* binaries or ivshmem-server or elf2dmp=
.
> > They will be relocated because meson automatically uses layout of sourc=
es in
> > build folder.
> > It's not a big deal anyway.
>
> If we're concerned about external users relying on stuff in contrib/,
> then that is exactly the reason why contrib/ should go, and everything
> be considered an officially supported deliverable of QEMU with an
> appropriate home in the source tree, and covered by 'make install'.

A solution worth considering is to split into various meson
subprojects. I did it for libslirp, libvhost-user, and started qga a
few years ago (https://patchew.org/QEMU/20220810124857.1360211-1-marcandre.=
lureau@redhat.com/)

This requires a bit of reorganization to have some common (internal)
libraries, but imho, we would make the whole project cleaner that way.

--=20
Marc-Andr=C3=A9 Lureau

