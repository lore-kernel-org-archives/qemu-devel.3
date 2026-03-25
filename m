Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA0FEA82F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Jfa-0003df-UG; Wed, 25 Mar 2026 04:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5JfY-0003d9-Lv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5JfV-0002s9-Kk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774427568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNETIHEw/0gjcPRxzendSQ15j6+aiq3Q4+YNI6el4Jg=;
 b=CLguNCbbjbWBolyQgsrlF2d4qRVAiQ3Vufj/yrWH9BEexLIkR75Dj6QWDnKKvxz1HPoiw0
 ZPH141L/57yjDOpfezgSIjLOrtKSDZD8+DdYCiqDw36ovCICY9HRJ2UAunGll8wEoNfNU3
 KYf6hBc7HbPHD4jin5Dpn5WDHyYkS5U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-07j5RbUZMHizNu0YTXwTOA-1; Wed, 25 Mar 2026 04:32:46 -0400
X-MC-Unique: 07j5RbUZMHizNu0YTXwTOA-1
X-Mimecast-MFC-AGG-ID: 07j5RbUZMHizNu0YTXwTOA_1774427565
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82a782029b7so3995452b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 01:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774427565; cv=none;
 d=google.com; s=arc-20240605;
 b=TXC8WlFHmQT+G6Psnn3LqJmgVRA7+gknD1nwWDDfYsD/Se7jburBcJPEpxh3vwJ5JK
 5dWgC3MmudQsjDw1pc5YREJ+nNfR0YFQwumX/WPEaimVeLJO6yfXI8Fl/PInu9y5cTO6
 ByjyvzmQMghCB5JrdJDmZfT9rsBFkViDzg79DdiA67VBbPwp5GctLpC0xP4QIBaJywB3
 1oaQmB7Be1xFrP0NjdFZCbPaGI0EmcRgwOW1gKzA3gc68sxFESEvO9kffwU7G7iDCzeV
 PLh5/OzeHScjdgJ7Kd7paq59Qc4D5HxErtdb7B6mfBOaNWahIP0tC/oez3jaLkAytJmg
 alvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BNETIHEw/0gjcPRxzendSQ15j6+aiq3Q4+YNI6el4Jg=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=lnqjpCLNtfmxigvIB0RH51syrTMvnT88VDb+hJeFYfPZBPIeqjrDVHbzrAmiFq+uP8
 39FDvsGpFBZ3JZfiODf6slbtUcn1NZSYRE2JmgBEE4ExGMS0aKzzI8DeKgsfW9esWqwd
 r20Y5RAUrv7Q5JQWChzbY5QtU6Q2iZESsR5DZ6OC/WIkrmKOlmO4T5/m5OvGChA2uNHy
 LO6Zb43K0f0jpDsqqEqszAEqx5OHQcrbMDtzK2vnJkTakxU4xg+5hGbDr2WowhqWam0G
 h6vLN0tW/fmjWV7ddhhYtpFCzChZ+4COlkaCPfztCuDAetRPrcUy9IwB4RTiyRZ5E59f
 4Utg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774427565; x=1775032365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNETIHEw/0gjcPRxzendSQ15j6+aiq3Q4+YNI6el4Jg=;
 b=RBaOO+laxS3ZSwRBL3OWx77IcdooZ7NQaAZv3F2PcsXH/b5DAPY3Xq0zTHfGXd25/3
 +XrcSyKP6awfyvHizF8MBQ2Mdumv3aqbcJydkFi7Vwea4MlqfqbCwBF+i6Mwsmp3s1GC
 HQUKGzi6zTUNGnuhWcsacNK0bWY6fwCEuAHg2MSykOb78wkHIoJlospYV+/rP2Wg1Kgq
 DZNs6Hyhyks+MO4wCxguqlTekM4nHXgJF9FXtFSESk1R9CIRRV6i8pitJUSXTTjgRzfc
 ik5OIOIBXyYFCxNpqlZJ2Dz9dWZRKdEIGLD8VUhf4iDVUzj3/DmMMaYenhzRj1nK6BUL
 hSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774427565; x=1775032365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNETIHEw/0gjcPRxzendSQ15j6+aiq3Q4+YNI6el4Jg=;
 b=GxljmMXdqD7KREoi5c0BzDuxuIV1kx6errh9zeTt+rfkXT/RDvENwxeC/qRfKXxdaG
 10rMAlBXFS4eFjwTP/1kFw7E6WoX1B7YGb3BkWf+xxCQfbRvHpGvB3N9FUW8uY44jDiZ
 v3DRWuPUw1ks/J7SRvVKuljyExtlLQqVcy+MRvvcpq8DMSFu+nV9aOcVAlhCiAIKHK/B
 v2jSNNAONFakGWrzXuIfeQtZrrAp5au4jW/CULP5E8PxooIfcRI31TEi0f5xOneWqHzd
 e1cIlMkmuBdzbLIJ7Ibrc0oKS3LtxRGVXtzlFVgbkX6TWjSwe36CbuAHH9Eul44uPoKK
 LDVA==
X-Gm-Message-State: AOJu0Yz3D26OR0OpiF3+VuuFooPSJRkOtsgjAgp4mJRZ5Umu9feYF+wj
 7OYwPv0kaizK+cjDdqftvlZtCBJwWIYIF7cK+U6c2HW69prO8PylYtJRfN+5jAI6gxeHSAKT6F0
 x/yraUlDe0FmOuo6YVaYFNnrdWiiGn7BdUXmEl6lu0Z1oXmqoRDbAxquJy25w6V35pJcR1Ta/WH
 LRXk+CbYDN59W0Sa/mUeV1IHSe9YzqIWR1bRVuzMtr4g==
X-Gm-Gg: ATEYQzxHy094kPApEYuBlYFQsmcCH4Ncrm+hSVV7q8L7zG0B2EkEblB+XfPHxMm4TPC
 J1rZpVz2+IgbSKY/83W4UbbjuaxA8ZOh5Zj0UkND8drUsO14W60w+xRi8BTUY1sjQ0EZU1cnxZc
 pJA4/zX7T2ODBAHDMfkUKM0mP/jZD0Gq6W6QSiV272WeetGIVWoLWYKplNtTHkkNMEJoZTfafHT
 Ae7XwTeR4fxMZ0PS9uhNQlV/duX59tUfqiFsmDsVeiFEqYH63Uqf8iwiJG2UmntLkI4WfF4lUCd
 tv4c6zcmyH5KVb4piZNQYTw=
X-Received: by 2002:a05:6a20:12c9:b0:398:f1ed:7fa0 with SMTP id
 adf61e73a8af0-39c4adf2aa1mr2936324637.55.1774427564654; 
 Wed, 25 Mar 2026 01:32:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c9:b0:398:f1ed:7fa0 with SMTP id
 adf61e73a8af0-39c4adf2aa1mr2936301637.55.1774427564086; Wed, 25 Mar 2026
 01:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
 <acKsobCZ2G8TE2XI@redhat.com>
In-Reply-To: <acKsobCZ2G8TE2XI@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Mar 2026 12:32:32 +0400
X-Gm-Features: AaiRm51ZfKkXHQepsk5I2LeI9JW97kewfNgUXGViLpi0ilc17fLJn_o4GdHGrHs
Message-ID: <CAMxuvaxv2o301O3wVacVMtEdOSzc+bO6jDKX93AnhXTT4wr_6w@mail.gmail.com>
Subject: Re: [PATCH 60/60] contrib/qemu-vnc: add standalone VNC server over
 D-Bus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 24, 2026 at 7:24=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 17, 2026 at 12:51:14PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Add a standalone VNC server binary that connects to a running QEMU
> > instance via the D-Bus display interface (org.qemu.Display1, via the bu=
s
> > or directly p2p). This allows serving a VNC display without compiling
> > VNC support directly into the QEMU system emulator, and enables running
> > the VNC server as a separate process with independent lifecycle and
> > privilege domain.
>
> IIUC, this new binary is linking to all the existnig ui/vnc.c
> code, so there's no actual new impl of the RFB protocol, just
> a new glue layer for launching the existing impl with comms
> over DBus instead of from direct callback functions ?
>
> > Built only when both VNC and D-Bus display support are enabled.
> > If we wanted to have qemu -vnc disabled, and qemu-vnc built, we would
> > need to split CONFIG_VNC. This is left as a future exercise.
> >
> > I left out for now:
> >  - sasl & tls authz
>
> IMHO these are must have features, as the default VNC protocol
> security is a very bad joke.

Ok that should be doable. One thing that bothers me a bit is mapping
the -object options (authz) to a more regular CLI. Perhaps I'll just
add -object args and wire it with the other options..

>
> >  - some runtime functionalities (better done by restarting)
> >  - a few legacy options
> >  - Windows support
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  MAINTAINERS                    |   5 +
> >  docs/conf.py                   |   3 +
> >  docs/interop/dbus-display.rst  |   2 +
> >  docs/interop/dbus-vnc.rst      |  26 ++
> >  docs/interop/index.rst         |   1 +
> >  docs/meson.build               |   1 +
> >  docs/tools/index.rst           |   1 +
> >  docs/tools/qemu-vnc.rst        | 199 +++++++++++
> >  meson.build                    |  17 +
> >  contrib/qemu-vnc/qemu-vnc.h    |  46 +++
> >  contrib/qemu-vnc/trace.h       |   4 +
> >  contrib/qemu-vnc/audio.c       | 307 +++++++++++++++++
> >  contrib/qemu-vnc/chardev.c     | 127 +++++++
> >  contrib/qemu-vnc/clipboard.c   | 378 +++++++++++++++++++++
> >  contrib/qemu-vnc/console.c     | 168 ++++++++++
> >  contrib/qemu-vnc/dbus.c        | 439 ++++++++++++++++++++++++
> >  contrib/qemu-vnc/display.c     | 456 +++++++++++++++++++++++++
> >  contrib/qemu-vnc/input.c       | 239 ++++++++++++++
> >  contrib/qemu-vnc/qemu-vnc.c    | 450 +++++++++++++++++++++++++
> >  contrib/qemu-vnc/stubs.c       |  66 ++++
> >  contrib/qemu-vnc/utils.c       |  59 ++++
>
> IMHO we should not really be adding more things to the contrib
> directory, and rather wish most of the existing stuff was
> not there. When I see "contrib" directories in projects, the
> message is generally "unmaintained, abandoned junk".
>
> If this is a serious maintained feature we expect people to use,
> it should be formally under the ui/ directory, possibly a
> 'ui/dbus-vnc' subdir ?

It is intended to be maintained. (although I hope we can deprecate it
in favour of qemu-rdp in the long term). I'll follow the "Cleaning up
contrib/ and tools/" thread and see where it could land.
.

>
> >  tests/qtest/dbus-vnc-test.c    | 733 +++++++++++++++++++++++++++++++++=
++++++++
> >  contrib/qemu-vnc/meson.build   |  26 ++
> >  contrib/qemu-vnc/qemu-vnc1.xml | 174 ++++++++++
> >  contrib/qemu-vnc/trace-events  |  20 ++
> >  meson_options.txt              |   2 +
> >  scripts/meson-buildoptions.sh  |   3 +
> >  tests/dbus-daemon.sh           |  14 +-
> >  tests/qtest/meson.build        |   8 +
> >  29 files changed, 3971 insertions(+), 3 deletions(-)
> >
>
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 31d5916cfce..ef938e74793 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -119,6 +119,8 @@ option('vfio_user_server', type: 'feature', value: =
'disabled',
> >         description: 'vfio-user server support')
> >  option('dbus_display', type: 'feature', value: 'auto',
> >         description: '-display dbus support')
> > +option('qemu_vnc', type: 'feature', value: 'auto',
> > +       description: 'standalone VNC server over D-Bus')
>
> Every option is about QEMU, so 'qemu_' on a name feels redundant,
> and QEMU alrady has a VNC server too.
>
> I suggest 'dbus_vnc' is possibly a better name
>

Well, I just named the option after the binary's name. I think that's easie=
r.

>
> >  option('tpm', type : 'feature', value : 'auto',
> >         description: 'TPM support')
> >  option('valgrind', type : 'feature', value: 'auto',
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


