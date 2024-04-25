Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA139C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwJn-0005bo-6Q; Thu, 25 Apr 2024 06:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzwJf-0005b6-Ve
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:27:01 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzwJd-0002FT-Ch
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:26:59 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso160710566b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714040814; x=1714645614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cECjgcYCAwKF2zFdhFBXiwocyIFwXSmJ5fyMeM37apw=;
 b=uexx8lXecR9/1x4xMpT8ZZcJcmlj4tvfduliZ1pvlxWWTrXUKrnCqa2cVK9Dk640Fe
 tC8rijQjFmRgsPuESE3FVtQgRz134M5eezVbNR3PXq1bxa1W9SmZZC4pOyiykGuwu9Ce
 5XMRwgT5L3yv6n+wki41Z9doCRC9kOpC1vj0wCB9yuHN/M6K1XW5U1fQmHjWRcm5UAEa
 TKNFosezaJD2Zhpc79NV5MhsnllpYez4OINBssXlWYymHdcGApbZk3v2aN9Kg7wsBGzl
 oTOm7CXKzd6QoESmnGRPzcmidO2SqgqUsSzkLLXz7gKPkWpMf5IG/3sXITVUT8MMJFnp
 fbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714040814; x=1714645614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cECjgcYCAwKF2zFdhFBXiwocyIFwXSmJ5fyMeM37apw=;
 b=p61iJt/YQWRbUEOzgq+/YRsxv3VRQFTzqq3rdWEH6LCjo9fGX6XLeCRCoTrHOeYqlt
 6p7BOTSB7xqAZy4Ig7PRnwwWhUCundLl8zF/l6KO8jLYcSBKkR0hWgCk9NscqT35y/Ve
 zCo/bXNjWaQLF9LxdSmHfEY4pjNHoIqEraoVKJKQA51AAV8z57rbUb2clxIeKuo5Hqot
 F+NY6l8EIGWMwcZsLC4zldV3olHjFCFiNNxrpAfD7Swg2FJe1wHDBUoP4SyAY4/0kDTr
 j51sCSKI/jRB8rB8BjCKnxeCOeL+Iy5GDtV/vq+MsAwBpAAqGtU2S6jHnGogW/lEpbD5
 3FSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNY2dCLWUq68u8C/4+f9lEbeUVkPqr4Pll6/WWJWqqUNeEOC/o7DsbEJkur15fiY1hrlhrkepjSaKbVn/bPq05d7MTB4E=
X-Gm-Message-State: AOJu0YyrsTcWpwxhDGS/DV1Mqr8yLEZdz+CCMbk1fno6Td9FjteKd7Tk
 OF6CjjmQzi4oMBIo+Xsib4eiYyex0U2pyzWOAvGRiGUIos2qxXtd2EKqiyPwqvYPJqzwnZDNOYS
 CYDbJFnH5L36ZUupV3JLELmbOE/Xs0OZPzE8r1g==
X-Google-Smtp-Source: AGHT+IFmnvo3z2Sk2kQTxogc7GcZ9+S7ngRVfP/MmmjgLRQ55KQzvPvNPabpYWCA0GRZueK2oAMuCPY8HC45+2oQpK0=
X-Received: by 2002:a17:906:c7d8:b0:a55:ab13:5471 with SMTP id
 dc24-20020a170906c7d800b00a55ab135471mr2430528ejb.13.1714040813928; Thu, 25
 Apr 2024 03:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
 <20240425062213-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240425062213-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 25 Apr 2024 13:26:38 +0300
Message-ID: <CAAjaMXYTGUUeABd+Ghaf374pOFjoF7RdncTTiciLhmo1yXXZVQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

On Thu, 25 Apr 2024 at 13:24, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 25, 2024 at 01:04:31PM +0300, Manos Pitsidianakis wrote:
> > On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> > >
> > > On 25/04/2024 07:30, Manos Pitsidianakis wrote:
> > >
> > > > On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
> > > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > >>
> > > >> On 23/04/2024 12:05, Philippe Mathieu-Daud=C3=A9 wrote:
> > > >>
> > > >>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
> > > >>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> > > >>>> <manos.pitsidianakis@linaro.org> wrote:
> > > >>>>>
> > > >>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> > > >>>>>>
> > > >>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Dau=
d=C3=A9 wrote:
> > > >>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > > >>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-D=
aud=C3=A9 wrote:
> > > >>>>>>>>> Since VirtIO devices can change endianness at runtime,
> > > >>>>>>>>> we need to use the device endianness, not the target
> > > >>>>>>>>> one.
> > > >>>>>>>>>
> > > >>>>>>>>> Cc: qemu-stable@nongnu.org
> > > >>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages a=
nd streams")
> > > >>>>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg>
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 =
only.
> > > >>>>>>>> It is unconditionally little endian.
> > > >>>>>
> > > >>>>>
> > > >>>>> This part of the code is for PCM frames (raw bytes), not virtio=
 spec
> > > >>>>> fields (which indeed must be LE in modern VIRTIO).
> > > >>>>
> > > >>>> Thought a little more about it. We should keep the target's endi=
anness
> > > >>>> here, if it's mutable then we should query the machine the devic=
e is
> > > >>>> attached to somehow. the virtio device should never change endia=
nness
> > > >>>> like Michael says since it's not legacy.
> > > >>>
> > > >>> Grr. So as Richard suggested, this need to be pass as a device
> > > >>> property then.
> > > >>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca=
4e09876@linaro.org/)
> > > >>
> > > >> It feels to me that the endianness is something that should be neg=
otiated as part of
> > > >> the frame format, since the endianness of the audio hardware can b=
e different from
> > > >> that of the CPU (think PReP machines where it was common that a bi=
g endian CPU is
> > > >> driving little endian hardware as found on x86).
> > > >
> > > > But that is the job of the hardware drivers, isn't it? Here we are
> > > > taking frames passed from the guest to its virtio driver in the for=
mat
> > > > specified in the target cpu's endianness and QEMU as the device pas=
ses
> > > > it to host ALSA/Pipewire/etc which in turn passes it to the actual
> > > > audio hardware driver..
> > >
> > > The problem is that the notion of target CPU endian is not fixed. For=
 example the
> > > PowerPC CPU starts off in big-endian mode, but these days most system=
s will switch
> > > the CPU to little-endian mode on startup to run ppc64le. There's also=
 the ILE bit
> > > which can be configured so that a big-endian PowerPC CPU can dynamica=
lly switch to
> > > little-endian mode when processing an interrupt, so you could potenti=
ally end up with
> > > either depending upon the current mode of the CPU.
> > >
> > > These are the kinds of issues that led to the later virtio specificat=
ions simply
> > > using little-endian for everything, since then there is zero ambiguit=
y over what
> > > endian is required for the virtio configuration space accesses.
> > >
> > > It feels to me that assuming a target CPU endian is fixed for the PCM=
 frame formats
> > > is simply repeating the mistakes of the past - and even the fact that=
 we are
> > > discussing this within this thread suggests that at a very minimum th=
e virtio-snd
> > > specification needs to be updated to clarify the byte ordering of the=
 PCM frame formats.
> > >
> > >
> > > ATB,
> > >
> > > Mark.
> > >
> >
> >
> > Agreed, I think we are saying approximately the same thing here.
> >
> >  We need a mechanism to retrieve the vCPUs endianness and a way to
> > notify subscribed devices when it changes.
>
> I don't think I agree, it's not the same thing.
> Guest should just convert and send data in LE format.
> Host should then convert from LE format.
> Target endian-ness does not come into it.

That's not in the VIRTIO 1.2 spec. We are talking about supporting
things as they currently stand, not as they could have been.

